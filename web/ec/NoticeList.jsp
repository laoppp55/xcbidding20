<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.cms.server.MyConstants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-store");               // 禁止浏览器缓存
    response.setHeader("Pragrma", "no-cache");                      // 禁止浏览器缓存
    response.setDateHeader("Expires", 0);                            // 禁止浏览器缓存
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String projcode = ParamUtil.getParameter(request,"projcode");
    List<BulletinNoticeWithBLOBs> bulletinNotices = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        //获取采购项目对应的招标公告的列表
        INoticeService noticeService= (INoticeService)appContext.getBean("noticeService");
        //一个采购项目可能对应有多个公告
        bulletinNotices = noticeService.getBulletinNoticeByproject(projcode);
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!doctype html>
<html>
<head>
    <title>北京市西城区公共资源交易系统--下载招标文件</title>
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
    <div class="personal_right_box">
        <table id="projectsid" width="1000" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-top:25px;">
            <tr>
                <td>公告名称</td>
                <td>项目名称</td>
                <td>采购人</td>
                <td>代理机构</td>
                <td>投标截止时间</td>
                <td>下载招标文件</td>
            </tr>

            <%for(int ii=0;ii<bulletinNotices.size();ii++) {
                BulletinNoticeWithBLOBs bulletinNotice= bulletinNotices.get(ii);
            %>
            <tr <%=((ii % 2)==0)?"bgcolor=\"#ffffff\"":"bgcolor=\"#ffffff\""%>>
                <td><%=bulletinNotice.getBulletintitle()%></td>
                <td><%=bulletinNotice.getPurchaseprojname()%></td>
                <td><%=bulletinNotice.getBuyerName()%></td>
                <td><%=bulletinNotice.getAgentName()%></td>
                <td><%=sdf.format(bulletinNotice.getTenderEndTime())%></td>
                <td><a href="<%=MyConstants.getDownloadAddress()%>/oa/common/attachment/publicDownloadFile?id=<%=bulletinNotice.getReceiveFile()%>">下载</a></td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
<!--以下页面尾-->
</body>
<script language="javascript">
    $(document).ready(function(){
        $.post("/users/showLoginInfo.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color='red'>" + data.username + "</font>  <span><a href='#' onclick=\"javascript:logoff();\">退出</a></span>" + "<span><a href=\"/users/personinfo.jsp\">个人中心</a></span>");
                }
            },
            "json"
        );
    })
</script>
</html>
