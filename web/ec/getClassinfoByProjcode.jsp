<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.TrainInfoService" %>
<%@ page import="com.bizwink.po.TrainingClass" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.vo.TrainInfo" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/16
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String projcode = ParamUtil.getParameter(request,"projcode");
    String checkcode = ParamUtil.getParameter(request,"checkcode");
    long thetime = ParamUtil.getLongParameter(request,"thetime",0);
    ApplicationContext appContext = SpringInit.getApplicationContext();
    TrainInfoService trainInfoService = null;
    List<TrainingClass> trainingClassList = new ArrayList<TrainingClass>();
    TrainInfo trainInfo = null;
    if (appContext!=null) {
        //读取订单信息
        trainInfoService = (TrainInfoService)appContext.getBean("trainInfoService");
        trainingClassList = trainInfoService.getTrainingClassByProjcode(projcode);
    }

    Gson gson = new Gson();
    String jsonData = gson.toJson(trainingClassList);
    //System.out.println(jsonData);
    JSON.setPrintWriter(response, jsonData,"utf-8");
%>