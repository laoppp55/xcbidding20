<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.ParamUtil" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/27
  Time: 22:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    String username = authToken.getUsername();
    if (authToken==null) {
        if (referer_usr!=null) {
            response.sendRedirect("/users/login_m.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        } else {
            response.sendRedirect("/users/login_m.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        }
    }

    String signtime = ParamUtil.getParameter(request,"signtime");
    String projname = ParamUtil.getParameter(request,"projname");
    int errcode = ParamUtil.getIntParameter(request,"errcode",0);
%>
<html>
<head>
    <title>项目培训签到提醒信息</title>
</head>
<body>
欢迎<%=username%>，
<%=(errcode==0)?("您的培训项目是" + projname + ",您的签到时间是" + signtime):""%>
<%=(errcode==-1)?"不在培训项目期间，无需签到。":""%>
<%=(errcode==-2)?"您的所在位置不在允许的签到距离之内，请到指定的地点签到。":""%>
<%=(errcode==-3)?"不在允许的签到时间之内，不能进行签到。":""%>
</body>
</html>
