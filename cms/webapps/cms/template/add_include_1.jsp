<%@page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  int columnID = ParamUtil.getIntParameter(request, "column", 0);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type="text/css" href="style.css">
</head>
<body bgcolor=#ffffff text=#000000 link=#0000ff vlink=#0000ff alink=#ff0000>
<center>
<span class="tabstyle"><b>>ѡ���������ļ�</b></span>
<hr width=100% size=1>
</center>
</body>
</html>