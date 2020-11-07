<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.po.BulletinNoticeWithBLOBs" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.po.BulletinNoticeSinglesourceWithBLOBs" %>
<%@ page import="com.bizwink.po.BulletinNoticeConsultationsWithBLOBs" %>
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
    String buymethod = ParamUtil.getParameter(request,"buymethod");
    BulletinNoticeWithBLOBs bulletinNotice = null;
    BulletinNoticeConsultationsWithBLOBs bulletinConsultationsNotice = null;
    BulletinNoticeSinglesourceWithBLOBs bulletinSinglesourceNotice = null;
    Timestamp receiveFileEndTime = null;
    ApplicationContext appContext = com.bizwink.util.SpringInit.getApplicationContext();
    if (appContext!=null) {
        INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
        if (buymethod.equals("1")) {
            bulletinNotice = noticeService.getBulletinNoticeByUUID(bulletinNoticeUUID);
            receiveFileEndTime = new Timestamp(bulletinNotice.getReceiveFileEndTime().getTime());
        } else if (buymethod.equals("3")) {   //6表示磋商     3表示谈判
            bulletinConsultationsNotice = noticeService.getConsultationsNoticeByUUID(bulletinNoticeUUID);
            receiveFileEndTime = new Timestamp(bulletinConsultationsNotice.getNegotiationFileEndTime().getTime());
        } else if (buymethod.equals("6")) {
            bulletinConsultationsNotice = noticeService.getConsultationsNoticeByUUID(bulletinNoticeUUID);
            receiveFileEndTime = new Timestamp(bulletinConsultationsNotice.getConsultationFileEndTime().getTime());
        } else if (buymethod.equals("4")) {
            bulletinSinglesourceNotice = noticeService.getSinglesourceNoticeByUUID(bulletinNoticeUUID);
            receiveFileEndTime = new Timestamp(bulletinSinglesourceNotice.getTenderEndTime().getTime());
        }

    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    boolean out_of_date_flag = false;
    Timestamp currentTime = new Timestamp(System.currentTimeMillis());
    if (receiveFileEndTime!=null) {
        System.out.println(sdf.format(receiveFileEndTime));
        System.out.println(sdf.format(currentTime));
        if (receiveFileEndTime.before(currentTime)) out_of_date_flag = true;
    }

    String jsonData =  "{\"result\":" + out_of_date_flag + "}";

    JSON.setPrintWriter(response, jsonData, "utf-8");
%>
