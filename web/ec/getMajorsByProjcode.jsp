<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.TrainInfoService" %>
<%@ page import="com.bizwink.po.TrainingMajor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bizwink.util.JSON" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/16
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_url = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_url,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String projcode = ParamUtil.getParameter(request,"projcode");
    String checkcode = ParamUtil.getParameter(request,"checkcode");
    long thetime = ParamUtil.getLongParameter(request,"thetime",0);
    TrainInfoService trainInfoService = null;
    List<TrainingMajor> trainingMajorList = new ArrayList<TrainingMajor>();

    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext != null) {
        trainInfoService = (TrainInfoService) appContext.getBean("trainInfoService");
        trainingMajorList = trainInfoService.getMajorsByProjcode(projcode);
    }

    Gson gson = new Gson();
    String jsonData = gson.toJson(trainingMajorList);
    System.out.println(jsonData);
    JSON.setPrintWriter(response, jsonData,"utf-8");
%>