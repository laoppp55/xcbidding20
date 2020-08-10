<%@ page import="com.bizwink.util.ParamUtil" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-21
  Time: 下午9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int errcode = ParamUtil.getIntParameter(request,"errcode",0);
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心</title>
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

        function checks(form) {
            alert(regform.numbercopy.value);
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
<div class="main_bannerbox">
    <div class="main">
        <%
            if (errcode == 300)
                out.println("采购（资审）公告存在，但是相应的采购项目不存在，业务逻辑存在错误。");
            else if (errcode == -201)
                out.println("您已经完成了投标报名，不需要再次进行报名。");
            else if (errcode == -202)
                out.println("请登录系统后在进行投标报名和招标文件下载操作。");
            else if (errcode == -203)
                out.println("系统运行环境出现错误，请联系技术支持人员。");
            else if (errcode == -204)
                out.println("前后台数据输入不符，未能通过数据检验，请检查您的输入数据。");
            else if (errcode == -205)
                out.println("您的验证码输入错误，请输入正确的验证码。");

            else
                out.println("<div class=\"notebox\">系统出现错误了。</div>");
        %>
    </div>
</div>
<!--div class="footbox">< %@include file="/inc/tail.shtml" %></div-->
</body>
</html>
