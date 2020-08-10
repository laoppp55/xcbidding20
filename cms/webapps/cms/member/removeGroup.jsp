<%@ page import="java.util.*,
		             com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*"
                 contentType="text/html;charset=gbk"
%>

<%
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken == null)
	{
		response.sendRedirect( "../login.jsp?url=member/removeGroup.jsp" );
		return;
	}
	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		request.setAttribute("message","�޹����û����Ȩ��");
		response.sendRedirect("../error.jsp?message=�޹����û����Ȩ��");
		return;
	}

	int groupID = ParamUtil.getIntParameter(request, "group", -1);
	String groupName = ParamUtil.getParameter(request, "name");
	boolean doDelete = ParamUtil.getBooleanParameter(request,"doDelete");

	if (doDelete)
	{
		IGroupManager groupMgr = GroupPeer.getInstance();
		try
		{
			Group group = new Group();
			group.setGroupID(groupID);
			groupMgr.remove(group);
			response.sendRedirect("groupManage.jsp");
			return;
		}
		catch (CmsException e)
		{
			e.printStackTrace();
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
		{ "ɾ���û���", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p class=tine>
&nbsp;&nbsp;&nbsp;&nbsp;ȷ��Ҫɾ���û��� <b><%=groupName%></b>
<p>

<form action="removeGroup.jsp" name="deleteForm" method=post>
<input type="hidden" name="doDelete" value="true">
<input type="hidden" name="group" value="<%=groupID%>">
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value="  ȷ��  " class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="  ȡ��  " class=tine onclick="location.href='groupManage.jsp';return false;">
</form>

</body>
</html>
