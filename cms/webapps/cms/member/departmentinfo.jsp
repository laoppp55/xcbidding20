<%@ page import="java.util.*,
		             com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
%>

<%
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken == null)
	{
		response.sendRedirect( "../login.jsp" );
		return;
	}
	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
		return;
	}


	int siteID = authToken.getSiteID();

	IUserManager uMgr = UserPeer.getInstance();
    List list = uMgr.getDepartments(siteID);
	int Count = list.size();
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language="javascript">
function createGroup()
{
  window.open("createdepartment.jsp","","top=100,left=100,width=360,height=360");
}
function edit(id)
{
   window.open("editdepartment.jsp?id="+id,"","top=100,left=100,width=360,height=360");
}
function del(id)
{
    window.open("deletedepartment.jsp?id="+id,"","top=100,left=100,width=360,height=360");
}
</script>
</head>
<%
	String[][] titlebars = {
		{ "���Ź���", "" }
	};
	String [][] operations =
	{
	  {"<a href=javascript:createGroup();>��������</a>", ""},
    {"ϵͳ����","index.jsp"},
	};
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="90%" align=center>
<tr bgcolor="#eeeeee" class=tine>
<td width="15%" align=center>������������</td>
<td width="15%" align=center>����Ӣ������</td>
<td align=center width="10%">�绰</td>
<td align=center width="10%">����</td>
<td align=center width="10%">������</td>
    <td align=center width="10%">�����쵼</td>
    <td align=center width="10%">�޸�</td>
<td align=center width="10%">ɾ��</td>
</tr>

<%
	for (int i=0; i<list.size(); i++)
	{
		Department dept = (Department)list.get(i);
%>

<tr bgcolor="#ffffff" class=line>
<td align="center">&nbsp;&nbsp;<%=dept.getCname()==null?"--":StringUtil.gb2iso4View(dept.getCname())%></td>
<td align="center">&nbsp;&nbsp;<%=dept.getEname()==null?"--":dept.getEname()%></td>
<td align="center"><%=dept.getTelephone() ==null?"--":StringUtil.gb2iso4View(dept.getTelephone())%></td>
<td align="center"><%=dept.getManager() == null?"--":StringUtil.gb2iso4View(dept.getManager())%></td>
<td align="center"><%=dept.getVicemanager() == null?"--":StringUtil.gb2iso4View(dept.getVicemanager())%></td>
    <td align="center"><%=dept.getLeader() == null?"--":StringUtil.gb2iso4View(dept.getLeader())%></td>
    <td align="center"><a href="#" onclick="edit(<%=dept.getId()%>)">�޸�</a> </td>
<td align="center"><a href="#" onclick="del(<%=dept.getId()%>)">ɾ��</a> </td>
</tr>
<% }  %>

</table>
</html>
