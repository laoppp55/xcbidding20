<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*" contentType="text/html;charset=utf-8" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int columnID = ParamUtil.getIntParameter(request, "column", 0);
%>

<html>
<head>
    <title>WORD文件转HTML文件</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<iframe src='WordToHtml.jsp?column=<%=columnID%>' width="790" marginwidth="0" height="530" marginheight="0" scrolling="yes" frameborder="0"></iframe>
</html>