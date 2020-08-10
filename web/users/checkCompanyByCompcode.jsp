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
<%@ page import="com.bizwink.po.PurchasingAgency" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.google.gson.Gson" %>
<%
    request.setCharacterEncoding("utf-8");
    PurchasingAgency result = null;
    BigDecimal siteid = BigDecimal.valueOf(1);
    String compacode = ParamUtil.getParameter(request, "compcode");
    if (compacode != null && compacode!="") compacode= filter.excludeHTMLCode(URLDecoder.decode(compacode,"utf-8"));
    Users user = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        result = usersService.getEnterpriseInfoByCompcode(compacode);
        user = usersService.getUserByCompcode(compacode,6);                 //获取公司的系统管理员账户
    }

    Gson gson = new Gson();
    String jsonData = gson.toJson(result);
    System.out.println(jsonData);
    JSON.setPrintWriter(response, jsonData,"utf-8");
%>