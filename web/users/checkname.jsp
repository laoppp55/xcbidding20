<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.filter" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="java.net.URI" %>
<%
    request.setCharacterEncoding("utf-8");
    boolean result = false;
    BigDecimal siteid = BigDecimal.valueOf(1);
    String username = ParamUtil.getParameter(request, "username");
    if (username != null && username!="") username= filter.excludeHTMLCode(URLDecoder.decode(username,"utf-8"));
    System.out.println("username==" + username);
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        result = usersService.checkName(siteid,username);
    }

    String jsonData = null;
    if (result == true)
        jsonData =  "{\"result\":" + result + "}";
    else
        jsonData = "{\"result\":" + result + "}";

    JSON.setPrintWriter(response, jsonData,"utf-8");
%>