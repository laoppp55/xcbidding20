<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.service.IBidderInfoService" %>
<%@ page import="com.bizwink.po.BidderInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-10-8
  Time: 下午10:57
  To change this template use File | Settings | File Templates.
--%>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", -10);

    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        if (referer_usr!=null)
            response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        else
            response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String compcode = ParamUtil.getParameter(request,"compcode");
    String projcode = ParamUtil.getParameter(request,"projcode");
    System.out.println("compcode==" + compcode);
    System.out.println("projcode==" + projcode);
    BidderInfo bidderInfo = null;
    ApplicationContext appContext = com.bizwink.util.SpringInit.getApplicationContext();
    if (appContext!=null) {
        IBidderInfoService bidderInfoService = (IBidderInfoService)appContext.getBean("bidderInfoService");
        bidderInfo = bidderInfoService.getBidderInfoByProjcodeAndCompcode(projcode,compcode);
    }

    String jsonData = "";
    if (bidderInfo!=null)
        jsonData =  "{\"result\":" + true + "}";
    else
        jsonData =  "{\"result\":" + false + "}";


    JSON.setPrintWriter(response, jsonData, "utf-8");
%>
