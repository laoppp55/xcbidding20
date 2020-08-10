<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%
    boolean result = false;
    BigDecimal siteid = BigDecimal.valueOf(1);
    String email= filter.excludeHTMLCode(ParamUtil.getParameter(request, "email"));
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        result = usersService.checkEmail(siteid,email);
    }

    String jsonData = null;
    if (result == true)
        jsonData =  "{\"result\":\"true\"}";
    else
        jsonData = "{\"result\":\"false\"}";

    JSON.setPrintWriter(response, jsonData,"utf-8");
%>