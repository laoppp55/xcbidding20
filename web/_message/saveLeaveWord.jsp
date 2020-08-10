<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.service.MessageService" %>
<%@ page import="com.bizwink.po.LeaveWord" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String username = null;
    int retcode = 0;
    int siteid = 0;
    if (authToken!=null) {
        username = authToken.getUserid();
        siteid = authToken.getSiteid();
    } else {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null) ip =  request.getRemoteAddr();
        username = ip;
    }

    String name = filter.excludeHTMLCode(ParamUtil.getParameter(request,"name"));
    String phone = filter.excludeHTMLCode(ParamUtil.getParameter(request,"phone"));
    String content = filter.excludeHTMLCode(ParamUtil.getParameter(request,"content"));

    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        MessageService messageService = (MessageService)appContext.getBean("messageService");
        LeaveWord leaveWord = new LeaveWord();
        leaveWord.setSITEID(BigDecimal.valueOf(siteid));
        leaveWord.setLINKMAN(name);
        leaveWord.setUSERID(username);
        leaveWord.setPHONE(phone);
        leaveWord.setTITLE(content);
        leaveWord.setWRITEDATE(new Timestamp(System.currentTimeMillis()));
        retcode = messageService.saveMessage(leaveWord);
    }

    String jsonData = null;
    if (retcode > 0)
        jsonData =  "{\"result\":\"true\"}";
    else
        jsonData =  "{\"result\":\"false\"}";
    JSON.setPrintWriter(response, jsonData, "utf-8");
%>