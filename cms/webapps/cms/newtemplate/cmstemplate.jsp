<%@page import="com.bizwink.cms.security.*,
                com.bizwink.cms.util.*"
    	      	contentType="text/html;charset=gbk"
%>

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
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../style/global.css">
<title>ѡ��ϵͳģ��</title>
</head>
<frameset cols=160,*>
  <frameset cols=* rows=0,*>
    <frame src="columntree1.jsp?rightid=<%=columnID%>" name=cmsleft>
    <frame src="menu1.html" name=menu>
  </frameset>
  <frame src="pagesmain1.jsp" name=cmsright>
</frameset>
</html>
