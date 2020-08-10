<%@ page import="java.util.*,
		 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
%>

<%!
  private final String YES = "<font color='#006600' size='-1'><b>��</b></font>";
  private final String NO  = "<font color='#ff0000' size='-1'><b>��</b></font>";
%>
<%@ include file="../../../include/auth.jsp"%>
<%
  if (!SecurityCheck.hasPermission(authToken,54))
  {
    request.setAttribute("message","�޹����û���Ȩ��");
    response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
    return;
  }
  int siteid = authToken.getSiteID();
  String authUsername = authToken.getUserID();

  IUserManager userMgr = UserPeer.getInstance();
  List userList;
  int userCount =0;
  userList = userMgr.getUsers(siteid);
  userCount = userList.size();
  String msg = ParamUtil.getParameter(request,"msg");
%>

<html>
<head>
<title>ϵͳ�û�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language="javascript">
function popup_window() {
    window.open( "addUser.jsp","","top=100,left=100,width=500,height=300,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
}

function edit_window(userid) {
  window.open( "addUser.jsp?userid="+userid,"","top=100,left=100,width=500,height=300,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
}

function grant_window(userid) {
  window.open( "grantRightToUser.jsp?userid="+userid,"","top=100,left=100,width=550,height=450,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
}
</script>
</head>
<%
	String str1 = "";
	String str2 = "";
	String str3 = "";
	String str4 = "";
	String str5 = "";

	if (authUsername.equals("admin"))
	{
		str1 = "�û�����";
		str2 = "�����û�";
	}

	String[][] titlebars = {
	        { "��ҳ", "../main.jsp" },
		{ str1, "" }
	};

        String[][] operations = {
                {str5, "fragManage.jsp"},
	        {"<a href=javascript:popup_window()>" + str2 + "</a>", ""},
		{str3, "groupManage.jsp"},
                {str4, "siteIPManage.jsp?siteid="+authToken.getSiteID()+"&dname="+authToken.getSitename()}
        };
%>
<%@ include file="../inc/titlebar.jsp" %>
<font class=line>�û��б�</font>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
<tr bgcolor="#eeeeee" class=tine>

<td width="9%" align=center class="listHeader"><b>�û���ʶ</b></td>
<td width="9%" align=center>�û�����</td>
<td width="16%" align=center>�����ʼ�</td>
<td width="10%" align=center>�绰</td>
<% if (authUsername.equals("admin")) { %>
<td align=center width="5%">����</td>
<td align=center width="5%">ɾ��</td>
<% } %>
</tr>

<%
  for ( int i=0; i<userCount; i++)
  {
    User user = (User)userList.get(i);
    String userID = user.getID();
    String nickName = StringUtil.gb2iso4View(user.getNickName());
    String email = user.getEmail();
    String phone = user.getPhone();
    if (phone == null)
      phone = "";
%>
<tr bgcolor="#ffffff" class=line>
<td align=center><b><%= userID %></b></td>
<td><%= nickName==null?"&nbsp;":nickName %></td>
<td><%= email==null?"&nbsp;":email %></td>
<td><%= phone==null?"&nbsp;":phone %>&nbsp;</td>
<% if (authUsername.equals("admin")) { %>
<td align="center">
<input type="radio" name="props" value="" onclick='javascript:edit_window("<%= userID %>");'></td>
  <% if (!"admin".equals(userID)) { %>
  <td align="center">
  <input type="radio" name="props" value="" onclick="location.href='removeUser.jsp?userid=<%= userID %>';"></td>
  <%}else{%>
  <td align="center">&nbsp;</td>
  <%}%>
<% } %>
</tr>

<% }  %>

</table>
</html>