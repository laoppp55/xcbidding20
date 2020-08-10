<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.ParamUtil" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ApplicationContext appContext = SpringInit.getApplicationContext();

    if (appContext!=null) {
        INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
    }
    String uuid = ParamUtil.getParameter(request,"uuid");

%>
<html>
<head>
    <title></title>
</head>
<body>
合同公告
</body>
</html>
