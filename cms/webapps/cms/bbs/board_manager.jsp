<%@page import="java.util.*,
                com.bizwink.cms.util.*,
                com.bizwink.bbs.bbs.*" contentType="text/html;charset=gbk"
%>
<%
if ((session.getValue("UserClass")==null)||(!session.getValue("UserClass").equals("ϵͳ����Ա")))
{
   response.sendRedirect("/bbs/index.jsp");
}
%>
<html><script language="JavaScript"></script></html>

<html>
<head>
<link rel=stylesheet href="images/chengjian.css" style="text/css">
<script language="JavaScript">
function Popup(url, window_name, window_width, window_height)
{
  settings=
      "toolbar=no,location=no,directories=no,"+
      "status=no,menubar=no,scrollbars=yes,"+
      "resizable=yes,width="+window_width+",height="+window_height;

  NewWindow=window.open(url,window_name,settings);
}

function CheckValue()
{
  if (form1.title.value=="")
  {
    alert("��̳���Ʋ���Ϊ��!");
    form1.title.focus();
    return false;
  }
}

function icon(theicon) {
  document.input.message.value += " "+theicon;
  document.input.message.focus();
}
</script>

<title>��ӭ���ʱ����ǽ�Ͷ�ʷ�չ�ɷ����޹�˾</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<center>
<%@include file="head.jsp"%>
<table width="778" border="0" cellspacing="0" cellpadding="0">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/dotline.gif">
<tr>
<td><img src="images/space.gif" width="3" height="3"></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<form method=post name="loginform" action="login.jsp">
<input type="hidden" name="startflag" value="1">
<tr>
<td><b><span class="tittle">����λ��: </span></b><span class="tittle"><a href="/bbs/index.jsp">�ǽ���̳</a></span></td>
<%
  String userid = (String)session.getAttribute("userid");
	String userclass = (String)session.getAttribute("UserClass");
	if(userid != null){
%>
    <td>��ӭ����<%=userid%></td><%if(userclass.equals("ϵͳ����Ա")){%><td><a href="board_manager.jsp">����</a></td><%}%>
<%}else{%>
<td>
�û�����<input type="text" name="username" size=8>
���룺<input type="password" name="password" size=8>
<input type="submit" value="��¼">
</td>
<%}%>
<td align="right" width=40><a href="reg1.jsp">ע��</a>&nbsp;&nbsp;</td>
<%
if(userid != null){
%>
<td align="left" width=40><a href="logout.jsp">�˳�</a>&nbsp;&nbsp;</td>
<%}%>
</tr>
</form>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/dotline.gif">
<tr>
<td><img src="images/space.gif" width="3" height="3"></td>
</tr>
</table>
</td></tr></table>
<br><br>
<table  bordercolorlight="#0000FF" cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" border="1" width="760" align="center">
  <tr>
    <td class="tablerow" colspan="7" bgcolor="#FFFFFF" height="16">
      <table border="0" cellspacing="0" width="100%" cellpadding="0">
        <tr>
          <td width="20%" align="center"><font color="#333399"><b><a href='board_manager.jsp'><font color="red">��̳����</font></a></b></font></td>
          <td width="40%" align="left"><font color="#333399"><b><a href='user_manager.jsp'>�û�����</a></b></font></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor="#9CCFFF">
    <td width="17" height="14">&nbsp;</td>
    <td width="302" height="14" bgcolor="#9CCFFF">��̳����</td>
    <td width="172" align="center" height="14">��̳����</td>
    <td width="116" align="center" height="14">�޸�</td>
    <td width="91" align="center" height="14">ɾ�� </td>

  </tr>
<%
	int Notice_Id = 0;
	String Submit_Button = "";
	String Submit_Action = "";
	String manager = "";
	String bbsname = "";

	IBBSManager bbsMgr = BBSPeer.getInstance();
  List list = bbsMgr.getAllColumn();

	for(int i=0;i<list.size();i++){
	  BBS bbs = new BBS();
		bbs = (BBS)list.get(i);
		Notice_Id = bbs.getID();
		manager = bbs.getManager();
		bbsname = bbs.getBBSName();
%>
  <tr bgcolor="#F7FBFF">
    <td align="center"  height="26" width="17"><img src="images/folder.gif" width="13" height="16"></td>
    <td height="26" width="302" bgcolor="#F7FBFF"><a href="board_manager.jsp?modifyid=<%=Notice_Id%>">
      <%=bbsname%> </a> <br />
    </td>
    <td align="center" height="26" width="172"><%=manager%></td>
    <td align="center" height="26" width="116"><a href='board_manager.jsp?modifyid=<%=Notice_Id%>'>�޸�</a></td>
    <td align="center" height="26" width="91"><a href='delete_board.jsp?modifyid=<%=Notice_Id%>&modflag=1' onclick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){return true;}return false;}">ɾ��</a></td>

  </tr>
<%
  }
%>

</form>
<%
	bbsname = "";
	manager = "";
  int modifyid = ParamUtil.getIntParameter(request, "modifyid", -1);
	int modflag = ParamUtil.getIntParameter(request, "modflag", -1);
	if(modifyid != -1)
	{
		Submit_Button = "�޸�";
		Submit_Action = "board_manager.jsp";
		BBS bbs = bbsMgr.getAFORUM(modifyid);
		bbsname = bbs.getBBSName();
		manager = bbs.getManager();
	}else{
		Submit_Button = "����";
		Submit_Action = "add_board.jsp";
	}

	if(modflag == 1){
		String title = ParamUtil.getParameter(request, "title");
		String mgr = ParamUtil.getParameter(request, "manager");
		bbsMgr.updateForum(title,mgr,modifyid);
		response.sendRedirect("board_manager.jsp");
	}
%>
  <tr bgcolor="#F7FBFF">
   <form method="POST" name="form1" action="<%=Submit_Action%>">
	 <input type="hidden" name="modifyid" value="<%=modifyid%>">
	 <input type="hidden" name="modflag" value="1">
	<td align="center" height="10" width="17">&nbsp;</td>
    <td colspan="6" height="10" align="right" valign="middle">
      <div align="left"></div>
        <div align="center">��̳����
          <input type="text" name="title" value="<%=bbsname%>">
		  ����
          <input type="text" name="manager" value="<%=manager%>">
          <input type="submit" name="Submit"   value="<%=Submit_Button%>">
          <input type="reset" name="Submit2" value="����">
        </div>
      </form>
      </td>
  </tr>

</table>
</td></tr></table>
<br><br><br><br>
<%@include file="tail.jsp"%>
