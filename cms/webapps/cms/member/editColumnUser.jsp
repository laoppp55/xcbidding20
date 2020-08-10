<%@ page import="java.util.*,
                 java.net.*,
		 com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*"
%>
<%	response.setDateHeader("Expires", 0);
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if( authToken == null ) {
		response.sendRedirect( "../login.jsp?url=member/editColumnUser.jsp" );
		return;
	}

	if (!SecurityCheck.hasPermission(authToken, "column")){
		response.sendRedirect("../error.jsp?message=�޹���column��Ȩ��");
		return;
	}

	boolean doUpdate        = ParamUtil.getBooleanParameter(request,"doUpdate");
	int  colID          =ParamUtil.getIntParameter(request,"colID",-1);
	String ename        = ParamUtil.getParameter(request,"ename");
	IColumnUserManager columnUserMgr = ColumnUserPeer.getInstance();
	List userList;
	int userCount =0;
	userList = columnUserMgr.getUsers();
	userCount = userList.size();

	List columnUserList;
	int  columnUserListCount =0;
	columnUserList = columnUserMgr.getColumnUsers(colID);
	columnUserListCount = columnUserList.size();
	boolean error = false;
	boolean success = false;

	// save user changes if necessary
	if( !error && doUpdate ) {
	    List cUserList =new ArrayList();
	    for(int i=0;i <userCount;i++) {
		User user = (User)userList.get(i);
	        if (ParamUtil.getCheckboxParameter(request, user.getID())) {
		    cUserList.add(user);
		}
	    }
	    try {
		columnUserMgr.updateColumnUsers(ename,cUserList,colID);
		success = true;
	    }
	    catch( CmsException ue) {
		success = false;
		error = true;
	    }
	}

	if( success ) {
		response.sendRedirect("columnUserManage.jsp?msg=success");
		return;
	}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title></title>
	<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>

<%	////////////////////
	String[][] titlebars = {
	        { "������Ŀ�û�", "columnUserManage.jsp" },
		{ "�޸���Ŀ�û�", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>

<form action="editColumnUser.jsp">
<input type="hidden" name="doUpdate" value="true">
<input type="hidden" name="ename" value="<%= ename %>">
<input type="hidden" name="colID" value="<%= colID %>">
��Ŀ<b><%= ename %></b>�Ĺ���Ա:
<p>

<table cellspacing="1" cellpadding="3" border="1" width="80%" align=center>
<tr>
    <td>�û�������</td>
    <td>�û�ID</td>
<% for(int i=0;i <userCount;i++) {
	User user = (User)userList.get(i);
	String userID = user.getID();
	String userName =user.getNickName();
	int j=0;
	String value = "";
	while(j <columnUserListCount) {
	    User cuser =(User)columnUserList.get(j);
	    if (userID.equals(cuser.getID())){
	        value = "checked";
		j = columnUserListCount+1;
	    }
	    j++;
	}
%>
<tr >
	<td><%=userName%></td>
	<td><%=userID%></td>
	<td><input type="checkbox" name=<%=userID%> size="30" <%= value %>>
	</td>
</tr>
<%   }  %>
</table>

<p>

<center>
	<input type="submit" value="ȷ��">
	&nbsp;
	<input type="submit" value="ȡ��"
	onclick="location.href='columnUserManage.jsp';return false;">
</center>

</form>

</body>
</html>