<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.service.IBidderInfoService" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.po.Users" %>
<%--
  Created by IntelliJ IDEA.
  User: petersong
  Date: 16-1-30
  Time: 下午7:27
  To change this template use File | Settings | File Templates.
--%>
<%
    //清除SESSION的数据
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken != null) {
        ApplicationContext appContext = SpringInit.getApplicationContext();
        if (appContext!=null) {
            IBidderInfoService bidderInfoService = (IBidderInfoService)appContext.getBean("bidderInfoService");      //投标报名服务
            IUserService usersService = (IUserService)appContext.getBean("usersService");
            Users user = usersService.getUserinfoByUserid(authToken.getUserid());

            //记录用户退出系统时间
            bidderInfoService.saveDownBidFileLog(authToken.getUserid(),user.getCOMPANYCODE(),null,"用户退出系统");
        }
        SessionUtil.removeUserAuthorization(response, session);
        authToken = null;
    }
    //清除Cookie的数据
    Cookie cookie = null;
    Cookie[] cookies = request.getCookies();
    if( cookies != null ){
      for (int i = 0; i < cookies.length; i++){
         cookie = cookies[i];
         if((cookie.getName( )).compareTo("username") == 0 ){
            cookie.setMaxAge(0);
			cookie.setPath("/");
            response.addCookie(cookie);
         } 
      }
    }

    Gson gson = new Gson();
    String jsondata=null;
    if (authToken == null){
        String result = "nologin";
        jsondata = gson.toJson(result);
        out.print(jsondata);
    }else{
        String result = "login";
        jsondata = gson.toJson(result);
        out.print(jsondata);
    }
    out.flush();
%>