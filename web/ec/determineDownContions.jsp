<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.po.BulletinNoticeWithBLOBs" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }
    String username = authToken.getUserid();
    String bulletinNotice_uuid = ParamUtil.getParameter(request,"uuid");
    BulletinNoticeWithBLOBs bulletinNotice = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();

%>
