<%@ page import="com.bizwink.util.JSON" %>
<%@page contentType="text/html;charset=utf-8" %>
<%
	response.setHeader("Cache-Control", "no-store");               // 禁止浏览器缓存
	response.setHeader("Pragrma", "no-cache");                      // 禁止浏览器缓存
	response.setDateHeader("Expires", 0);                            // 禁止浏览器缓存
	response.setContentType("text/html");
	String filename = (String)request.getSession().getAttribute("servr_filename");
	request.getSession().removeAttribute("servr_filename");
	String jsonData =  "{\"result\":\"" + filename + "\"}";
	JSON.setPrintWriter(response, jsonData,"utf-8");
%>