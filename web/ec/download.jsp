<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午7:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jspsmart.upload.SmartUploadException" %>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.server.MyConstants" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.service.IBidderInfoService" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }
    String username = authToken.getUserid();
    String bulletinNotice_uuid = ParamUtil.getParameter(request,"uuid");
    try {
        SmartUpload su = new SmartUpload();//创建对象
        su.initialize(getServletConfig(), request, response);//初始化
        //禁止浏览器自动打开文件
        su.setContentDisposition(null);
        su.downloadFile(MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id=" + bulletinNotice_uuid);
        su.stop();

        //记录用户下载招标文件的LOG
        ApplicationContext appContext = SpringInit.getApplicationContext();
        if (appContext!=null) {
            IUserService usersService = (IUserService)appContext.getBean("usersService");
            Users user = usersService.getUserinfoByUserid(username);
            IBidderInfoService bidderInfoService = (IBidderInfoService)appContext.getBean("bidderInfoService");
            bidderInfoService.saveDownBidFileLog(username,user.getCOMPANYCODE(),bulletinNotice_uuid);
        }
    } catch (SmartUploadException e) {
        e.printStackTrace();
    } finally {
        response.sendRedirect("/users/personinfo.jsp?errcode=501");      //招标文件下载成功
    }
%>
