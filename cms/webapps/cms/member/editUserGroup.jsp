<%@ page import="java.util.*,
		             com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*"
                 contentType="text/html;charset=gbk"
%>

<%
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken == null)
	{
		response.sendRedirect( "../login.jsp?url=member/editUserGroup.jsp" );
		return;
	}
	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		response.sendRedirect("../error.jsp?message=�޹����û���������Ȩ��");
		return;
	}

	int siteID = authToken.getSiteID();
	String userID = ParamUtil.getParameter(request, "userid");
	boolean doUpdate = ParamUtil.getBooleanParameter(request,"doUpdate");

	IUserManager userMgr = UserPeer.getInstance();
	GroupSet allGroups = userMgr.getAllGroups(siteID);
	GroupSet groups = null;

	if (doUpdate)
	{
	  groups = new GroupSet();
	  Iterator iter = allGroups.elements();
	  while (iter.hasNext())
	  {
		  Group group = (Group)iter.next();
	    if (ParamUtil.getCheckboxParameter(request,String.valueOf(group.getGroupID())))
		    groups.add(group);
	  }

	  try
	  {
		  userMgr.updateUserGroups(userID, groups);
  		response.sendRedirect("index.jsp?msg=success");
	  	return;
	  }
	  catch (CmsException e)
	  {
		  e.printStackTrace();
	  }
	}

	groups = userMgr.getUserGroups(userID);
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<%
	String[][] titlebars = {
		{ "�������", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>

<form action="editUserGroup.jsp">
<input type="hidden" name="doUpdate" value="true">
<input type="hidden" name="userid" value="<%=userID%>">
<font class=tine>�û�&nbsp;<b><%=userID%></b>&nbsp;�������:</font>
<p>

<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="90%" align=center>
<tr bgcolor="#eeeeee" class=tine>
    <td align=center width="15%"><b>�û����ʶ</b></td>
    <td align=center width="25%"><b>�û�������</b></td>
    <td align=center width="40%"><b>�û�������</b></td>
    <td align=center width="20%"><b>�Ƿ��Ǹ����Ա</b></td>
<%
   Iterator iter = allGroups.elements();
   while (iter.hasNext())
   {
  	 Group group = (Group)iter.next();
	   int groupID = group.getGroupID();
	   String groupName = group.getGroupName();
	   groupName = StringUtil.gb2iso4View(groupName);
	   String desc = group.getGroupDesc();
	   if (desc == null) desc = "";
	   desc = StringUtil.gb2iso4View(desc);
	   String value = "";
	   if (groups.contains(groupID)) value = "checked";
%>
<tr bgcolor="#ffffff" class=line>
	<td align=center><%=groupID%></td>
	<td>&nbsp;<%=groupName%></td>
	<td>&nbsp;<%=desc%></td>
	<td align=center><input type="checkbox" name="<%=groupID%>" <%=value%>></td>
</tr>
<%}%>
</table>
<p>
<center>
	<input type="submit" value="  ȷ��  " class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="  ȡ��  " class=tine onclick="location.href='index.jsp';return false;">
</center>
</form>

</body>
</html>
