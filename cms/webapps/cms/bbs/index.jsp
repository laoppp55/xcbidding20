<%@page import="java.io.*,
                java.util.*,
                java.sql.*,
                java.text.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.server.*,
                com.bizwink.bbs.bbs.*,
                com.bizwink.webapps.register.*" contentType="text/html;charset=gbk"
%>
<%
  int loginflag = ParamUtil.getIntParameter(request, "loginflag", -1);
  IBBSManager bbsMgr = BBSPeer.getInstance();
  BBS bbs = new BBS();

  List forumlist = new ArrayList();
  forumlist = bbsMgr.getAllColumn();
%>
<html>
<head>
<title>��ӭ���ʱ����ǽ�Ͷ�ʷ�չ�ɷ����޹�˾</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet href="images/chengjian.css" style="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<%
  if(loginflag == 0){
%>
<script language="javascript">
alert("��������û������������");
</script>
<%
  }
%>
<center>
<%@include file="head.jsp"%>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td><img src="images/space.gif" width="10" height="10"></td>
</tr>
</table>
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
    <td>��ӭ����<%=userid%></td><%if(userclass != null){if(userclass.equals("ϵͳ����Ա")){%><td><a href="board_manager.jsp">����</a></td><%}}%>
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
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="4" class="txt">
<tr>
<td width="15%" bgcolor="#0877AF" align="center"><font color="#FFFFFF"><b>��̳����</b></font></td>
<td width="15%" bgcolor="#0877AF" align="center"><font color="#FFFFFF"><b>��̳����Ա
</b></font></td>
<td width="15%" bgcolor="#0877AF" align="center"><font color="#FFFFFF"><b>�ظ�/����</b></font></td>
<td bgcolor="#0877AF" align="center"><font color="#FFFFFF"><b>������ </b></font></td>
</tr>
</table>
<%
  String forumname = "";
  int forumid = 0;
	String pic = "";
	int threadnum = 0;
	int topicnum = 0;
	String lasttopic = "";
	String lastposter = "";
	String manager = "";
	Timestamp lastposttime = new Timestamp(System.currentTimeMillis());

  for(int j=0;j<forumlist.size();j++){
    bbs = (BBS)forumlist.get(j);
    forumname = bbs.getBBSName();
    forumid = bbs.getID();
		pic = bbs.getPic();
		threadnum = bbs.getThreadNum();
		topicnum = bbs.getTopicNum();
		lasttopic = bbs.getLastTopic();
		lastposter = bbs.getLastPoster();
		lastposttime = bbs.getLastPostTime();
		manager = bbs.getManager();
%>
<table width="100%" border="0" cellspacing="1" cellpadding="4" class="txt">
<tr bgcolor="#F4F4F4">
<td width="15%" align="center">
<table border="0" cellspacing="0" cellpadding="4">
<tr>
<td bgcolor="#FFFFFF"><a href="list.jsp?forumid=<%=forumid%>&startflag=1"><img src="images/<%=pic%>" width="80" height="80" border="0"></a></td>
</tr>
<tr>
<td bgcolor="#FFFFFF" align="center"><b><a href="list.jsp?forumid=<%=forumid%>&startflag=1"><%=forumname%></a></b></td>
</tr>
</table>
</td>
<td align="center" width="15%"><%=manager==null?"":manager%></td>
<td bgcolor="#F4F4F4" width="15%"><!--���գ� 19<br-->
���⣺<%=topicnum%><br>
�ظ��� <%=threadnum%> </td>
<td>���⣺ <%=lasttopic==null?"":lasttopic%><br>
��󷢱� <%=lastposter==null?"":lastposter%><br>
<%=lastposttime==null?"":lastposttime.toString()%></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/dotline2.gif">
<tr>
<td><img src="images/space.gif" width="1" height="1"></td>
</tr>
</table>
<%}%>

</td>
</tr><div style="position: absolute; top: -978px;left: -898px;"><a href="http://www.91cssf.com">����˽��</a> <a href="http://www.jidiba.com">����˽��</a> <a href="http://www.aiqc.com.cn">����˽��</a> <a href="http://www.58923.com">��������˽��</a> <a href="http://www.on-ba.cn">����˽��</a> <a href="http://www.xinyingyy.com">�����˲�˽��</a> <a href="http://www.gzmix.com">����˽��</a> <a href="http://www.xa8lad.cn">ħ��˽��</a> <a href="http://www.ppxnet.cn">����˽��</a> <a href="http://www.90door.cn">dnf���</a> <a href="http://www.blueth.cn">����˽��</a></div>
</table>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td><img src="images/space.gif" width="25" height="25"></td>
</tr>
</table>
<%@include file="tail.jsp"%>
</center>
</body>
</html>
</html>   