<%@ page import="java.util.*,
		             com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*"
                 contentType="text/html;charset=gbk"
%>

<%
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken == null)
	{
		response.sendRedirect( "../login.jsp?url=member/removeMember.jsp" );
		return;
	}

	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		request.setAttribute("message","�޹����û���Ȩ��");
		response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
		return;
	}

	String userID = ParamUtil.getParameter(request, "userid");
	int type = ParamUtil.getIntParameter(request, "type", 0);
	boolean doDelete = ParamUtil.getBooleanParameter(request, "doDelete");

	boolean error = (userID == null);
	if (userID.equals("admin"))
	{
		request.setAttribute("message","����ɾ�������û�");
		response.sendRedirect("../error.jsp");
		return;
	}

	if (doDelete && !error)
	{
		IUserManager userMgr = UserPeer.getInstance();
		try
		{
			User user = userMgr.getUser(userID);
			userMgr.remove(user,authToken.getUserID());

			if (type == 1)
				response.sendRedirect("admin_index.jsp");
			else
				response.sendRedirect("index.jsp");
      return;
		}
		catch (CmsException ue)
		{
      ue.printStackTrace();
			error = true;
		}
	}
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>

<%
	String[][] titlebars = {
		{ "ɾ���û�", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>

<p class=tine>&nbsp;&nbsp;ɾ���û� <b><%=userID%></b></p>

<form action="removeUser.jsp" name="deleteForm">
<input type="hidden" name="doDelete" value="true">
<input type="hidden" name="userid" value="<%=userID%>">
<input type="hidden" name="type" value="<%=type%>">
&nbsp;&nbsp;
<input type="submit" value="  ȷ��  " class=tine>&nbsp;&nbsp;
<%if (type == 1){%>
<input type="button" value="  ȡ��  " onclick="location.href='admin_index.jsp';return false;">
<%}else{%>
<input type="button" value="  ȡ��  " onclick="location.href='index.jsp';return false;">
<%}%>
</form>

</body>
</html>
