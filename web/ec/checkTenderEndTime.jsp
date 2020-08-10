<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.po.BulletinNoticeWithBLOBs" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
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

    String bulletinNoticeUUID = ParamUtil.getParameter(request,"uuid");
    BulletinNoticeWithBLOBs bulletinNotice = null;
    ApplicationContext appContext = com.bizwink.util.SpringInit.getApplicationContext();
    if (appContext!=null) {
        INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
        bulletinNotice = noticeService.getBulletinNoticeByUUID(bulletinNoticeUUID);
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    boolean out_of_date_flag = false;
    Timestamp receiveFileEndTime = null;
    Timestamp currentTime = new Timestamp(System.currentTimeMillis());
    if (bulletinNotice!=null) {
        receiveFileEndTime = new Timestamp(bulletinNotice.getReceiveFileEndTime().getTime());
        System.out.println(sdf.format(receiveFileEndTime));
        System.out.println(sdf.format(currentTime));
        if (receiveFileEndTime.before(currentTime)) out_of_date_flag = true;

        /*
        long l_receiveFileEndTime = receiveFileEndTime.getTime();
        long l_currentTime = currentTime.getTime();
        System.out.println("receiveFileEndTime:" + l_receiveFileEndTime);
        System.out.println("currentTime:" + l_currentTime);
        if (l_receiveFileEndTime>l_currentTime) out_of_date_flag = true;
        */
    }

    String jsonData =  "{\"result\":" + out_of_date_flag + "}";

    JSON.setPrintWriter(response, jsonData, "utf-8");
%>
