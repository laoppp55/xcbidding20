<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.service.IBidderInfoService" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.IPurchaseProjectService" %>
<%@ page import="com.bizwink.cms.server.MyConstants" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //response.setHeader("Cache-Control", "no-store");               // 禁止浏览器缓存
    //response.setHeader("Pragrma", "no-cache");                      // 禁止浏览器缓存
    //response.setDateHeader("Expires", 0);                            // 禁止浏览器缓存
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String username = authToken.getUserid();
    Users user = null;
    String compcode = null;
    List<BidderInfo> bidderInfoList = null;
    List<BulletinNoticeWithBLOBs> bulletinNotices = null;
    List<BulletinNoticeConsultationsWithBLOBs> consultationsNotices = null;
    List<BulletinNoticeSinglesourceWithBLOBs> singlesourceNotices = null;

    ApplicationContext appContext = SpringInit.getApplicationContext();
    IPurchaseProjectService purchaseProjectService = null;
    INoticeService noticeService = null;
    if (appContext!=null) {
        //获取用户信息
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(username);
        compcode = user.getCOMPANYCODE();
        //获取该投标人该登录账户投标信息
        IBidderInfoService bidderInfoService = (IBidderInfoService)appContext.getBean("bidderInfoService");
        bidderInfoList = bidderInfoService.getBidderInfosByUseridAndCompcode(username,user.getCOMPANYCODE(), BigDecimal.valueOf(0),BigDecimal.valueOf(20));
        purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        noticeService = (INoticeService)appContext.getBean("noticeService");
    }
%>
<!doctype html>
<html>
<head>
    <title>北京市西城区公共资源交易系统--我的投标项目信息</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
    <!--link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css"-->
    <link href="/ggzyjy/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/ggzyjy/js/style.js" type="text/javascript" ></script>
    <script src="/ggzyjy/js/jquery.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
    <script language="javascript">
        function downfile(purchaseProjcode,buymethod_type) {
            var iWidth=1200;                                                 //弹出窗口的宽度;
            var iHeight=600;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;            //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;             //获得窗口的水平位置;
            //判断这个采购项目有几个公告，如果有一个公告直接下载公告，如果这个采购项目有多个公告，显示公告列表，下载每个公告的招标文件
            /*var noticeCount = 0;       //该项目发布公告的数量
            htmlobj = $.ajax({
                url: "/ec/getNoticeCountByProjcode.jsp?thetime=< %=System.currentTimeMillis()%>",
                data: {
                    purchaseProjcode:purchaseProjcode,
                    buymethod:buymethod_type
                },
                dataType: 'json',
                async: false,
                success: function (data) {
                    if (data.result == true) {
                        appFlag = 1;
                    }
                }
            });*/

            window.open("/ec/NoticeList.jsp?projcode=" + projcode, "NoticeList", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
        }
    </script>
</head>
<body style="background-image: url('');height: 600px;">
<div class="top_box">
    <div class="logo_box">
        <a href="/ggzyjy/" style="color: white">北京市西城区公共资源交易中心</a>
        <div class="reg_in" id="userInfos"><a href="/users/login.jsp">登录</a>|<a href="/users/userreg1.jsp">注册</a></div>
    </div>
</div>
<!--以上页面头-->
<div class="main clearfix div_top div_bottom">
    <div class="personal_left">
        <div class="title">个人中心</div>
        <ul>
            <li><a href="/ec/myBidinfos.jsp"><span style="color: red"> 投标项目管理</span></a></li>
            <!--li><a href="/users/personinfo.jsp?action=2">授信申请管理</a></li>
            <li><a href="/users/personinfo.jsp?action=3">保证金管理</a></li-->
            <li><a href="/users/companyinfo.jsp">公司信息管理</a></li>
            <li><a href="/users/updatereg.jsp">修改个人注册信息</a></li>
            <li><a href="/users/changePwd.jsp">修改密码</a></li>
        </ul>
    </div>
    <div class="personal_right_box">
        <table id="projectsid" width="1000" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-top:25px;">
            <tr>
                <td>项目编号</td>
                <td>项目名称</td>
                <td>采购人</td>
                <td>代理机构</td>
                <td>采购方式</td>
                <td>下载招标文件</td>
            </tr>

            <%for(int ii=0;ii<bidderInfoList.size();ii++) {
                BidderInfo bidderInfo = bidderInfoList.get(ii);
                PurchaseProject purchaseProject = purchaseProjectService.getProjectInfoByProjCode(bidderInfo.getPurchaseprojcode());
                String buymethod = null;
                String buymethod_type = purchaseProject.getPurchasemode();

                //一个采购项目的招标公告列表
                boolean multiNoticeFlag = false;    //该项目是否发多个公告标识
                if (purchaseProject.getPurchasemode().equals("1")) {
                    buymethod = "公开招标";
                    bulletinNotices = noticeService.getBulletinNoticeByproject(purchaseProject.getPurchaseprojcode());
                    if (bulletinNotices.size()>1) multiNoticeFlag = true;
                } else if (purchaseProject.getPurchasemode().equals("2")) {
                    buymethod = "邀请招标";
                } else if (purchaseProject.getPurchasemode().equals("6")) {
                    buymethod = "竞争性磋商";
                    consultationsNotices = noticeService.getConsultationsNoticesByPurchaseprojcode(purchaseProject.getPurchaseprojcode());
                    if (consultationsNotices.size()>1) multiNoticeFlag = true;
                } else if (purchaseProject.getPurchasemode().equals("3")) {
                    buymethod = "竞争性谈判";
                    consultationsNotices = noticeService.getConsultationsNoticesByPurchaseprojcode(purchaseProject.getPurchaseprojcode());
                    if (consultationsNotices.size()>1) multiNoticeFlag = true;
                } else if (purchaseProject.getPurchasemode().equals("5")) {
                    buymethod = "询价";
                } else if (purchaseProject.getPurchasemode().equals("4")) {
                    buymethod = "单一来源";
                    singlesourceNotices = noticeService.getSinglesourceNoticesByPurchaseprojcode(purchaseProject.getPurchaseprojcode());
                    if (singlesourceNotices.size()>1) multiNoticeFlag = true;
                } else
                    buymethod = "其他";


            %>
            <tr <%=((ii % 2)==0)?"bgcolor=\"#ffffff\"":"bgcolor=\"#ffffff\""%>>
                <td><%=bidderInfo.getPurchaseprojcode()%></td>
                <td><%=purchaseProject.getPurchaseprojname()%></td>
                <td><%=purchaseProject.getPurchasername()%></td>
                <td><%=purchaseProject.getAgencyname()%></td>
                <td><%=(buymethod!=null)?buymethod:""%></td>
                <%if(multiNoticeFlag) {%>
                <td><a href="javascript:downfile('<%=bidderInfo.getPurchaseprojcode()%>',<%=buymethod_type%>);">下载</a></td>
                <%} else {
                    if (buymethod_type.equals("1"))
                        out.println("<td><a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFileTime?compcode=" + compcode + "&username=" + username + "&id=" + bulletinNotices.get(0).getReceiveFile() + " target=\"_blank\">下载</a></td>");
                    else if (buymethod_type.equals("3"))
                        out.println("<td><a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFileTime?compcode=" + compcode + "&username=" + username + "&id=" + consultationsNotices.get(0).getOtherAocuments() + " target=\"_blank\">下载</a></td>");
                    else if (buymethod_type.equals("6"))
                        out.println("<td><a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFileTime?compcode=" + compcode + "&username=" + username + "&id=" + consultationsNotices.get(0).getOtherAocuments() + " target=\"_blank\">下载</a></td>");
                    //else if (buymethod_type.equals("4"))
                    //    out.println("<td><a href=" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinNotices.get(0).getReceiveFile() + ">下载</a></td>");
                }%>
            </tr>
            <%}%>
        </table>
    </div>
</div>
<!--以下页面尾-->
</body>
<script language="javascript">
    $(document).ready(function(){
        //检测用户是否通过采购中心的审核
        var auditResult = "";
        htmlobj = $.ajax({
            url: "/users/showAuditResult.jsp?thetime=<%=System.currentTimeMillis()%>",
            type: 'post',
            dataType: 'json',
            data: {},
            async: false,
            cache: false,
            success: function (data) {
                if (data.auditstatus!=null) {
                    auditResult = data.auditstatus;
                }
            }
        });

        $.post("/users/showLoginInfo.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color='red'>" + data.username + "</font>  (<a href=\"javascript:showAuditInfo();\"><span style='color: #F7FF78'>" + auditResult + "</span></a>)" + "<span><a href='#' onclick=\"javascript:logoff();\">退出</a></span>" + "<span><a href=\"/users/personinfo.jsp\">个人中心</a></span>");
                }
            },
            "json"
        );
    })

    function showAuditInfo() {
        htmlobj = $.ajax({
            url: "/users/showAuditResult.jsp?thetime=<%=System.currentTimeMillis()%>",
            type: 'post',
            dataType: 'json',
            data: {},
            async: false,
            cache: false,
            success: function (data) {
                if (data!=null) {
                    $.msgbox({
                        height: 300,
                        width: 400,
                        content: {type: 'alert', content: "采购中心审核信息："+data.auditstatus},
                        animation: 0,        //禁止拖拽
                        drag: false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                }
            }
        });
    }
</script>
</html>
