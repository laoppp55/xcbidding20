<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
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
<title>ѡ������ģ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<frameset cols=160,*>
<frameset cols=* rows=0,*>
<frame src="treeforSelectModel.jsp" name=cmsleft>
<frame src="menu.html" name=menu>
</frameset>
<frame src="selectModelRight.jsp?column=<%=columnID%>" name=cmsright>
</frameset>
</html>
