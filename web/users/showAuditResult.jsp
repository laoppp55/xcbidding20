<%@ page import="com.bizwink.util.*" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.po.PurchasingAgency" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.google.gson.Gson" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 17-10-22
  Time: 下午7:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }
    String username = authToken.getUserid();
    Users user = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    PurchasingAgency purchasingAgency = null;
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(username);
        purchasingAgency = usersService.getEnterpriseInfoByCompcode(user.getCOMPANYCODE());
    }

    String auditResult = null;
    if (purchasingAgency != null) auditResult = purchasingAgency.getAuditstatus();

    Gson gson = new Gson();
    String jsonData = gson.toJson(purchasingAgency);

    JSON.setPrintWriter(response, jsonData,"utf-8");
%>