<%@ page import="com.bizwink.util.*" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 17-10-22
  Time: 下午7:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean result = false;
    BigDecimal siteid = BigDecimal.valueOf(1);
    String mphone= filter.excludeHTMLCode(ParamUtil.getParameter(request, "mphone"));
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        result = usersService.checkCellphone(siteid,mphone);
    }

    String jsonData = null;
    if (result == true)
        jsonData =  "{\"result\":" + result + "}";
    else
        jsonData = "{\"result\":" + result + "}";

    JSON.setPrintWriter(response, jsonData,"utf-8");
%>