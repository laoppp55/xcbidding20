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
    BulletinNoticeWithBLOBs bulletinNotice = null;
    PurchaseProjectWithBLOBs purchaseProject = null;
    BudgetProject budgetProject = null;
    String receiveFileWay = null;
    Users user = null;
    String buymethod = null;
    List<Section> sectionList = null;
    INoticeService noticeService = null;
    String publishtime = null;
    SimpleDateFormat publishsdf = new SimpleDateFormat("yyyy-MM-dd");
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        if (unloginflag == 1) user = usersService.getUserinfoByUserid(userid);
        noticeService = (INoticeService)appContext.getBean("noticeService");
        bulletinNotice = noticeService.getBulletinNoticeByUUID(uuid);
        publishtime = publishsdf.format(bulletinNotice.getPublishtime());
        receiveFileWay = bulletinNotice.getReceiveFileWay();
        if (receiveFileWay == null) receiveFileWay = "";
        IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        purchaseProject = purchaseProjectService.getProjectInfoWithBLOBsByProjCode(bulletinNotice.getPurchaseprojcode());
        sectionList = purchaseProjectService.getSectionsByProjcode(purchaseProject.getPurchaseprojcode());

        IBudgetProjectService budgetProjectService = (IBudgetProjectService)appContext.getBean("budgetProjectService");
        if (purchaseProject==null) response.sendRedirect("/users/error.jsp?errcode=300");
        budgetProject = budgetProjectService.getBudgetProjByPrjcode(purchaseProject.getBudgetProjectId());
        if (budgetProject.getBuymethod().equals("1"))
            buymethod = "公开招标";
        else if (budgetProject.getBuymethod().equals("2"))
            buymethod = "邀请招标";
        else if(budgetProject.getBuymethod().equals("3"))
            buymethod = "竞争性谈判";
        else if(budgetProject.getBuymethod().equals("4"))
            buymethod = "单一来源";
        else if(budgetProject.getBuymethod().equals("5"))
            buymethod = "询价";
        else if(budgetProject.getBuymethod().equals("6"))
            buymethod = "竞争性磋商";
        else if(budgetProject.getBuymethod().equals("9"))
            buymethod = "其它";

        //保存用户已经阅读过公告的信息
        if (authToken!=null) {
            noticeService.saveReadNoticeFlag(bulletinNotice.getBulletintitle(),bulletinNotice.getUuid(),authToken.getUserid());
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
    <title>招标公告--<%=bulletinNotice.getBulletintitle()%></title>
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
                <h2>[<%=(buymethod!=null)?buymethod:""%>]&nbsp;&nbsp;<%=bulletinNotice.getBulletintitle()%></h2>
                <%if(receiveFileWay.equals("1") || receiveFileWay.equals("3")){ //1网上下载招标文件，2现场售卖招标文件%>
                <!--a href="/ec/download.jsp?uuid=< %=bulletinNotice.getUuid()%>" style="color: red"--><a href="javascript:downfile('<%=bulletinNotice.getUuid()%>')" style="color: red">下载招标文件</a>
                <%}%>
            </div>

            <div style="text-align: center;margin:28px 0 28px 0;"> 发布时间：<%=publishtime%></div>
            <div align="left" style="padding-left:30px;">
                <%if (budgetProject.getBuymethod().equals("1")) {%>
                <p align="center"></p>
                <p>
                <p></p>
                <h3>项目概况</h3> <%=bulletinNotice.getProjBasicInfo()%>
                <p></p> <p><strong>一、项目基本情况</strong></p>
                <p>项目编号：<%=purchaseProject.getInvestprojcode()%></p>
                <p>项目名称：<%=budgetProject.getProjectname()%></p>
                <% if (section_num == 1) {
                    Double bugdet = 0d;
                    Double upprice = 0d;
                    if (sectionList.get(0).getBugdet()!=null) bugdet = sectionList.get(0).getBugdet().doubleValue();
                    if (sectionList.get(0).getUpprice()!=null) upprice= sectionList.get(0).getUpprice().doubleValue();
                %>
                <p>预算金额：<%=String.format("%.4f",bugdet)%> 元（人民币）</p>
                <p>最高限价：<%=String.format("%.4f",upprice)%> 元（人民币）</p>
                <%} else if(section_num > 0){
                    for(int ii=0;ii<section_num;ii++) {
                        Double bugdet = 0d;
                        Double upprice = 0d;
                        if (sectionList.get(ii).getBugdet()!=null) bugdet = sectionList.get(ii).getBugdet().doubleValue();
                        if (sectionList.get(ii).getUpprice()!=null) upprice= sectionList.get(ii).getUpprice().doubleValue();
                        out.print("<p>" + sectionList.get(ii).getSectionname() +  "的预算金额：" + String.format("%.4f",bugdet) + " 元（人民币）</p>");
                        out.print("<p>" + sectionList.get(ii).getSectionname() +  "的最高限价：" + String.format("%.4f",upprice) + " 元（人民币）</p>");
                        out.print("<p></p>");
                    }
                }%>
                <p>采购需求：</p>
                <p></p>
                <p><%=purchaseProject.getPurchasecontent()%></p>
                <p></p>
                <!--p>合同履行期限：自合同签订之日起至2020年12月31日止</p-->
                <p>
                    <%
                        if(section_num > 1) {
                            for (int ii = 0; ii < section_num; ii++) {
                                if (sectionList.get(ii).getSynflag().equals("0")) {
                                    out.print("<p>" + sectionList.get(ii).getSectionname() + "不接受联合体投标</p>");
                                    out.print("<p></p>");
                                } else {
                                    out.print("<p>" + sectionList.get(ii).getSectionname() + "接受联合体投标</p>");
                                    out.print("<p></p>");
                                }
                            }
                        } else if (section_num == 1){
                            if (sectionList.get(0).getSynflag()!=null) {
                                if (sectionList.get(0).getSynflag().equals("0")) {
                                    out.print("<p>本项目不接受联合体投标</p>");
                                    out.print("<p></p>");
                                } else {
                                    out.print("<p>本项目接受联合体投标</p>");
                                    out.print("<p></p>");
                                }
                            } else {
                                out.print("<p>本项目不接受联合体投标</p>");
                                out.print("<p></p>");
                            }
                        }
                    %>
                </p>
                <p><strong>二、申请人的资格要求：</strong></p>
                <p><%=bulletinNotice.getBidderRequirement()%></p>
                <p></p>
                <p><%=(purchaseProject.getProjectSpecificRequire()==null)?"":"本项目特殊资质要求："+purchaseProject.getProjectSpecificRequire()%></p>
                <p></p>
                <p></p>
                <p><strong>三、获取招标文件</strong></p>
                <p>时间：<%=(bulletinNotice.getReceiveFileStartTime()==null)?"":sdf.format(bulletinNotice.getReceiveFileStartTime()) + "至" + ((bulletinNotice.getReceiveFileEndTime()==null)?"":sdf.format(bulletinNotice.getReceiveFileEndTime())) + "双休日及法定节假日除外"%></p>
                <p>地点：<%=bulletinNotice.getReceiveFileAddress()%></p>
                <p>方式：
                    <%
                        if (receiveFileWay.equals("1"))
                            out.println("网上下载招标文件");
                        else if (receiveFileWay.equals("3"))
                            out.println("网上下载或者现场获取招标文件");
                        else
                            out.println("现场获取招标文件");
                    %>
                </p>
                <p>售价：￥<%=bulletinNotice.getSellingPrice()%> 元</p>
                <p><strong>四、提交投标文件截止时间、开标时间和地点</strong></p>
                <p>开标时间： <%=sdf.format(bulletinNotice.getTenderEndTime())%>（北京时间）</p>
                <p>开标地点：<%=bulletinNotice.getBidOpenAddress()%></p>
                <p><strong>五、公告期限</strong></p>
                <p>自本公告发布之日起5个工作日。</p>
                <p><strong>六、其他补充事宜</strong></p>
                <p>
                <p><%=bulletinNotice.getOtherNode()%></p>
                <!--p>评标方法和标准：综合评分法；本次评审均采用百分制，满分为100分。</p-->
                </p>
                <p><strong>七、对本次招标提出询问，请按以下方式联系。</strong></p>
                <p>1.采购人信息</p>
                <p>名 称：<%=bulletinNotice.getBuyerName()%>　　　　　</p>
                <p>地址：<%=bulletinNotice.getBuyerAddress()%>　　　　　　　　</p>
                <p>联系方式：<%=bulletinNotice.getBuyerContactor() + "," + bulletinNotice.getBuyerContactPhone()%>　　　　　　</p>
                <p>2.采购代理机构信息</p>
                <p>名 称：<%=bulletinNotice.getAgentName()%>　　　　　　　　　　　　</p>
                <p>地　址：<%=bulletinNotice.getAgentAddress()%>　　　　　　　　　　　　</p>
                <p>联系方式：<%=bulletinNotice.getAgentContactor() + "," + bulletinNotice.getAgentContactPhone()%>　　　　　　　　　　　　</p>
                <p>3.项目联系方式</p>
                <p>项目联系人：<%=bulletinNotice.getProjcontactor()%></p>
                <p>电　话：　　<%=bulletinNotice.getProjContactPhone()%></p>
                </p>
                <p>八、采购项目需要落实的政府采购政策：</p>
                <p><%=bulletinNotice.getPolicyNode()%></p>
                <p></p>
                <p></p>
                <p>
                    <%
                        if (bulletinNotice.getReceiveNotice()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinNotice.getReceiveNotice() + "\"><span style=\"color:red\">公告附件</span></a>");
                    %>
                </p>
                <p>
                </p>
                <p>
                    <%
                        //if (bulletinNotice.getReceiveFile()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinNotice.getReceiveFile() + "\"><span style=\"color:red\">招标文件</span></a>");
                    %>
                </p>
                <p>
                </p>
                <p>
                    <%
                        if (bulletinNotice.getAttachment()!=null) out.println("<a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinNotice.getAttachment() + "><span style=\"color:red\">其它附件</span></a>");
                    %>
                </p>
                <p>
                </p>
                <%} else {
                    bulletinNotice.getRichTextContent();
                }%>
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
