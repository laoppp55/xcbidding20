<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="com.bizwink.cms.security.*,"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    
%>
<html><head><title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<body>
<%
 String[][] titlebars = {
      { "�������", "" }
   };
   String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
</body></html>