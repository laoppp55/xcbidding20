<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.EcService" %>
<%@ page import="com.bizwink.service.ArticleService" %>
<%@ page import="com.bizwink.vo.ArticleAndExtendAttrs" %>
<%@ page import="com.bizwink.service.TrainInfoService" %>
<%@ page import="com.bizwink.vo.TrainInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.bizwink.service.ArticleClassService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.vo.TrainMajorCourse" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    int articleid = ParamUtil.getIntParameter(request,"article",0);
    String majorcode = ParamUtil.getParameter(request,"major");
    String projcode = ParamUtil.getParameter(request,"projcode");
    String checkcode = ParamUtil.getParameter(request,"checkcode");
    long thetime = ParamUtil.getLongParameter(request,"thetime",0);
    ApplicationContext appContext = SpringInit.getApplicationContext();
    ArticleClassService articleClassService = null;
    List<TrainMajorCourse> trainingClassList = new ArrayList<TrainMajorCourse>();
    if (appContext!=null) {
        //读取培训课程信息
        articleClassService = (ArticleClassService) appContext.getBean("articleClassService");
        trainingClassList = articleClassService.getTrainCoursesOfMajor(BigDecimal.valueOf(articleid),majorcode,projcode);
    }

    Gson gson = new Gson();
    String jsonData = gson.toJson(trainingClassList);
    System.out.println(jsonData);
    JSON.setPrintWriter(response, jsonData,"utf-8");
%>