<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
%>

<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
</head>
<frameset cols=160,*>
<frameset cols=* rows=0,*>
<frame src=treeforKeyword.jsp name=cmsleft>
<frame src=menu.html name=menu>
</frameset>
<frame src=keywordRight.jsp name=cmsright>
</frameset>
</html>
