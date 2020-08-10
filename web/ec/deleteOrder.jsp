<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.service.EcService" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-8
  Time: 下午10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    long orderid = ParamUtil.getLongParameter(request,"orderid",0);
    String checkcode = ParamUtil.getParameter(request,"checkcode");
    long thetime = ParamUtil.getLongParameter(request,"thetime",0);
    long now = System.currentTimeMillis();

    String md5_delete = "/ec/deleteOrder.jsp?orderid=" + orderid;
    String checkcode_1 = Encrypt.md5(md5_delete.getBytes());
    ApplicationContext appContext = SpringInit.getApplicationContext();
    int retcode = 0;
    if (checkcode_1.equals(checkcode)) {
        if (appContext!=null) {
            EcService ecService = (EcService)appContext.getBean("ecService");
            retcode = ecService.deleteByOrderid(orderid);
        }
    }

    String  jsonData = null;
    if (retcode < 0)
        jsonData = "{\"result\":\"false\"}";
    else
        jsonData =  "{\"result\":\"true\"}";

    JSON.setPrintWriter(response, jsonData, "utf-8");
%>