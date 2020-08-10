<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.bizwink.util.SecurityUtil" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String messages= ParamUtil.getParameter(request, "message");
    String checkcode = URLEncoder.encode(SecurityUtil.Encrypto(messages),"utf-8");
    JSON.setPrintWriter(response, checkcode,"utf-8");
%>