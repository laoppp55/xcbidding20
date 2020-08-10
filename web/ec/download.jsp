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
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.po.BulletinNoticeWithBLOBs" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="com.bizwink.cms.server.InitServer" %>
<%@ page import="java.io.File" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }
    String username = authToken.getUserid();
    String bulletinNotice_uuid = ParamUtil.getParameter(request,"uuid");
    BulletinNoticeWithBLOBs bulletinNotice = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        //获取下载招标文件的公告信息，得到公告文件的文件名称
        INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
        bulletinNotice = noticeService.getBulletinNoticeByUUID(bulletinNotice_uuid);

        String fileName = null;
        if (bulletinNotice==null) {
            response.sendRedirect("/error.jsp?errcode=301");      //采购公告不存在错误
        } else {
            fileName = bulletinNotice.getReceiveFile();
        }

        String path = InitServer.getProperties().getProperty("main.uploaddir");
        if (!path.endsWith(File.separator)) path = path + File.separator;
        SmartUpload su = new SmartUpload();//创建对象
        su.initialize(getServletConfig(), request, response);//初始化
        try {
            ///common/attachment/publicDownloadFile?id=附件的uuid
            su.downloadFile(path + fileName);//路径加文件名
            su.stop();
            //su.setContentDisposition();
        } catch (SmartUploadException e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect("/users/personinfo.jsp?errcode=501");      //招标文件下载成功
        }
    }
%>
