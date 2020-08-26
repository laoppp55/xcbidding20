<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.service.*" %>
<%@ page import="org.w3c.tidy.Dict" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.server.MyConstants" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    int unloginflag = 0;
    String userid = null;
    if (authToken!=null) {
        unloginflag = 1;
        userid = authToken.getUserid();
    } else {
        userid = "";
    }

    ApplicationContext appContext = SpringInit.getApplicationContext();
    String uuid = ParamUtil.getParameter(request,"uuid");
    BulletinNoticeSinglesourceWithBLOBs bulletinSinglesourceNotice = null;
    PurchaseProjectWithBLOBs purchaseProject = null;
    BudgetProject budgetProject = null;
    String receiveFileWay = null;
    Users user = null;
    String buymethod = null;
    List<Section> sectionList = null;
    INoticeService noticeService = null;
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        if (unloginflag == 1) user = usersService.getUserinfoByUserid(userid);

        noticeService = (INoticeService)appContext.getBean("noticeService");
        bulletinSinglesourceNotice = noticeService.getSinglesourceNoticeByUUID(uuid);
        IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        purchaseProject = purchaseProjectService.getProjectInfoWithBLOBsByProjCode(bulletinSinglesourceNotice.getPurchaseprojcode());
        sectionList = purchaseProjectService.getSectionsByProjcode(purchaseProject.getPurchaseprojcode());

        IBudgetProjectService budgetProjectService = (IBudgetProjectService)appContext.getBean("budgetProjectService");
        if (purchaseProject==null) response.sendRedirect("/users/error.jsp?errcode=300");
        budgetProject = budgetProjectService.getBudgetProjByPrjcode(purchaseProject.getBudgetProjectId());

        //保存用户已经阅读过公告的信息
        if (authToken!=null) {
            noticeService.saveReadNoticeFlag(bulletinSinglesourceNotice.getBulletintitle(),bulletinSinglesourceNotice.getUuid(),authToken.getUserid());
        }
    }

    int section_num  = 0;
    if (sectionList!=null) section_num = sectionList.size();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>招标公告--<%=bulletinSinglesourceNotice.getBulletintitle()%></title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/list_more.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

    <script src="/ggzyjy/js/style.js" type="text/javascript" ></script>
    <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

    <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>

    <script>
        function isEmpty(obj) {
            if (typeof obj == "undefined" || obj == null || obj == "") {
                return true;
            } else {
                return false;
            }
        }

        function downfile(uuid) {
            //检查供应商提交的信息是否通过了审核
            var auditFlag = 0;
            htmlobj = $.ajax({
                url: "/ec/checkSuppAuditInfo.jsp?thetime=<%=System.currentTimeMillis()%>",
                data: {
                    compcode:"<%=(user!=null)?user.getCOMPANYCODE():""%>"
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    if (data.auditstatus == "审核中" || data.auditstatus == "核验中") {
                        auditFlag = 1;
                    }
                }
            });

            //判断供应商是否已经报名
            var appFlag = 0;
            htmlobj = $.ajax({
                url: "/ec/checkApplicationInfo.jsp?thetime=<%=System.currentTimeMillis()%>",
                data: {
                    compcode:"<%=(user!=null)?user.getCOMPANYCODE():""%>",
                    projcode:"<%=purchaseProject.getPurchaseprojcode()%>"
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    if (data.result == true) {
                        appFlag = 1;
                    }
                }
            });

            //判断是否已经过了招标文件发售截止时间
            var out_of_date_flag = false;
            htmlobj = $.ajax({
                url: "/ec/checkTenderEndTime.jsp?thetime=<%=System.currentTimeMillis()%>",
                data: {
                    uuid: uuid
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    if (data.result == true) {
                        out_of_date_flag = true;
                    }
                }
            });

            var unloginflag = <%=unloginflag%>;           //判断用户是否登录
            if (unloginflag == 0) {
                /*$.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'请先登录，然后在下载招标文件'},
                    animation:0,          //禁止拖拽
                    drag:false            //禁止动画
                    //autoClose: 5000       //自动关闭
                });*/
                alert("请先登录，然后在下载招标文件");
                window.location.href = "/users/login.jsp";
            } else {
                if (auditFlag == 1) {
                    //alert("您提交的公司基本信息尚未通过审核，通过审核后在下载“招标文件”");
                    $.msgbox({
                        height:200,
                        width:300,
                        content:{type:'alert', content:'您提交的公司基本信息尚未通过信息核验，通过信息核验后在下载“招标文件”'},
                        animation:0,        //禁止拖拽
                        drag:false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                    return false;
                } else {
                    if (appFlag == 1) {
                        //alert("您已经完成了网上报名操作，可以到用户中心\"投标项目管理\"下载招标文件");
                        $.msgbox({
                            height:200,
                            width:300,
                            content:{type:'alert', content:'您已经完成了网上下载标书信息提交操作，可以到用户中心"投标项目管理"下载招标文件'},
                            animation:0,        //禁止拖拽
                            drag:false          //禁止动画
                            //autoClose: 10       //自动关闭
                        });
                        return false;
                    } else {
                        if (out_of_date_flag == false) {
                            var userid = "<%=URLEncoder.encode(userid,"utf-8")%>";
                            htmlobj = $.ajax({
                                url: "/getUserInfo.do",
                                data: {
                                    username: userid
                                },
                                dataType: 'json',
                                async: false,
                                success: function (data) {
                                    window.location.href = "/ec/bidApplication.jsp?uuid=" + uuid;
                                }
                            });
                        } else {
                            $.msgbox({
                                height: 200,
                                width: 300,
                                content: {type: 'alert', content: '已经过了招标文件售卖时间，你不能再下载招标文件'},
                                animation: 0,        //禁止拖拽
                                drag: false          //禁止动画
                                //autoClose: 10       //自动关闭
                            });
                            return false;
                        }
                    }
                }
            }
        }
    </script>
    <style>
        p{line-height: 36px;font-family: '微软雅黑', Tahoma, Arial, sans-serif}
    </style>
</head>
<body>
<%@include file="/ggzyjy/inc/head_ggxx.shtml" %>
<div class="date_box">
    <%@include file="/ggzyjy/inc/writeCurrentDate.shtml" %>
</div>
<div class="main clearfix">
    <div class="banner_box">
        <div class="baner_box_left">西城区公共资源交易信息网</div>
    </div>
    <div class="menu_box_1">
        <div class="home_box"><a href="/ggzyjy/">首页</a></div>
        <div class="menu_list">
            <ul>
                <li class="fl_4"><a href="/ggzyjy/news/">要闻动态</a></li>
                <li class="fl_3 current">公告信息</li>
                <li class="fl_2"><a href="/ggzyjy/manual/">服务指南</a></li>
                <li class="fl_1"><a href="/ggzyjy/jrkb/">今日开标</a></li>
            </ul>
        </div>
    </div>
    <div class="menu_c_box"><a class="current">招标（资审）公告</a>|<a href="/ggzyjy/ggxx/bggg/">变更公告</a>|<a href="/ggzyjy/ggxx/winzb/">中标公告</a>|<a href="/ggzyjy/ggxx/other/">其它公告</a></div>
    <div class="path_search_box">
        <div class="path_box">您的位置：<a href="/ggzyjy/">首页</a>&gt;<a href="/ggzyjy/ggxx/">公告信息</a>&gt;招标（资审）公告</div>
        <!--div class="search_box"><input type="text" class="sear"></div-->
    </div>
    <div class="list_main_box" id="datalistid">
        <div id="bcontentid">
            <div id="btitleid" style="text-align: center">
                <h2>[单一来源]&nbsp;&nbsp;<%=bulletinSinglesourceNotice.getBulletintitle()%></h2>
            </div>

            <div style="text-align: center;margin:28px 0 28px 0;"> </div>
            <div align="left" style="padding-left:30px;">
                <p align="center"></p>
                <p>
                <p></p>
                <h3>项目概况</h3> <%=bulletinSinglesourceNotice.getBulletincontent()%>
                <p></p> <p><strong>一、采购人名称：<%=bulletinSinglesourceNotice.getBuyerName()%></strong></p>
                <p>联系地址：<%=bulletinSinglesourceNotice.getBuyerAddress()%></p>
                <p>联系人：<%=bulletinSinglesourceNotice.getBuyerContactor()%></p>
                <p>联系电话：<%=bulletinSinglesourceNotice.getBuyerContactMobilePhone() + "," + bulletinSinglesourceNotice.getBuyerContactPhone()%></p>
                <p></p>
                <p><strong>二、拟采购服务说明：</strong></p>
                <p><%=bulletinSinglesourceNotice.getPurchasingContent()%></p>
                <p></p>
                <p><strong>三、采用单一来源采购方式的原因及相关说明</strong></p>
                <p><%=bulletinSinglesourceNotice.getRelevantDescriptions()%></p>
                <p></p>
                <p><strong>四、拟定的唯一供应商名称、地址</strong></p>
                <p>供应商名称：<%=bulletinSinglesourceNotice.getSupplierName() + "。供应商地址：" + bulletinSinglesourceNotice.getSupplierAddress()%></p>
                <p></p>
                <p><strong>五、专业人员对相关供应商因专利、专有技术等原因具有唯一性的具体论证意见、以及专业人员姓名、工作单位和职称</strong></p>
                <p>专家论证意见：<%=bulletinSinglesourceNotice.getProfessionalInformation()%></p>
                <p>专家名单：<%=bulletinSinglesourceNotice.getExpertOpinion()%></p>
                <p></p>
                <p><strong>六、公示期限</strong></p>
                <p>
                <p><%=bulletinSinglesourceNotice.getPublicityPeriod()%></p>
                </p>
                <p></p>
                <p></p>
                <p>
                    <%
                        if (bulletinSinglesourceNotice.getUrl()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinSinglesourceNotice.getUrl() + "\"><span style=\"color:red\">公告附件</span></a>");
                    %>
                </p>
                <p>
                </p>
                <p>
                    <%
                        if (bulletinSinglesourceNotice.getExpertOpinionURL()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinSinglesourceNotice.getExpertOpinionURL() + "\"><span style=\"color:red\">专家表附件</span></a>");
                    %>
                </p>
                <p>
                </p>
                <p>
                    <%
                        if (bulletinSinglesourceNotice.getExpertOpinionURL()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinSinglesourceNotice.getExpertOpinionURL() + "><span style=\"color:red\">专家论证意见</span></a>");
                    %>
                </p>
                <p>
                </p>
                <p>
                    <%
                        if (bulletinSinglesourceNotice.getRelatedMaterialsURL()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinSinglesourceNotice.getRelatedMaterialsURL() + "><span style=\"color:red\">相关材料附件</span></a>");
                    %>
                </p>
                </p>
                <p>
                    <%
                        if (bulletinSinglesourceNotice.getOtherAocumentsURL()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinSinglesourceNotice.getOtherAocumentsURL() + "><span style=\"color:red\">其他附件</span></a>");
                    %>
                </p>
                <p>
                </p>
            </div>
        </div>
    </div>
</div>
<div class="foot_box">
    <div class="main">
        <!--div class="foot">
            <p>政府网站标识码：1101020002</p>
            <p> ICP备案序号：京ICP备19014909号 京公网安备：11010202007633号</p>
            <p>地址：北京市西城区广安门南甲2号 邮编：100032 </p>
        </div-->
    </div>
</div>
</body>
</html>
