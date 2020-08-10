<%@page import="java.io.*,
                java.util.*,
                java.sql.*,
                java.text.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.server.*,
                com.bucid.bbs.*,
                com.bucid.register.*" contentType="text/html;charset=gbk"
%>
<%
  String username       = ParamUtil.getParameter(request, "username");
  String password       = ParamUtil.getParameter(request, "password");
  String title          = ParamUtil.getParameter(request, "title");
  String content        = ParamUtil.getParameter(request, "content");
  String url            = ParamUtil.getParameter(request, "url");
  int startflag         = ParamUtil.getIntParameter(request, "startflag", 0);
  int loginflag         = ParamUtil.getIntParameter(request, "loginflag", 0);
  int forumid           = ParamUtil.getIntParameter(request, "forumid", 0);

  IRegisterManager registerMgr = RegisterPeer.getInstance();
	Register register = new Register();
  IBBSManager bbsMgr = BBSPeer.getInstance();
  BBS bbs = new BBS();

  if((content != "")&&(content != null)){
    content = content.replaceAll("\n","<br>");
    content = content.replaceAll(" ","&nbsp;");
  }

  if((title != "")&&(title != null)){
    title = title.replaceAll("<","&lt;");
    title = title.replaceAll(">","&gt;");
  }

  if((url != "")&&(url != null)){
    content = content + "<br><br>";
    content = content + "<img src=\"" + url + "\">";
  }

  if(loginflag == 1) {
    String locstr = "window.location=\"posttopic1.jsp?forumid="+forumid+"\";";
    out.println("<script language=javascript>");
    out.println("alert(\"��������û������������\");");
    out.println(locstr);
    out.println("</script>");
  }

  if(startflag == 1) {
    boolean existflag = false;

    existflag = registerMgr.userLogin(username,password,0);
    if(existflag){
			register = registerMgr.getAUser(username);
			String grade = register.getGrade();
			int id = register.getID();
      session.setAttribute("userid",username);
      session.setAttribute("password",password);
			session.setAttribute("UserClass",grade);

      //�û��ĵ�¼�ɹ�����
      int loginnum = registerMgr.getUserLoginNum(username) + 1;
      registerMgr.updateUserLoginNum(id, loginnum);

      int postnum = bbsMgr.getBBSUserNUM("postnum",id)+1;
      //ÿ����һƬ�����¼�2��
      bbsMgr.updateBBSUser("logintime",id,0);
      bbsMgr.updateBBSUser("postnum",id,postnum);

      Timestamp nowtime = new Timestamp(System.currentTimeMillis());
      String ipaddress = request.getRemoteAddr();

      //�û��������������û����ߵ�¼ʱ��
      bbs = new BBS();
      bbs.setUserName(username);
      bbs.setLoginTime(nowtime);
      bbs.setIPAddress(ipaddress);

      //ɾ�����û������߱��еļ�¼
      bbsMgr.deleteOnline(bbs);

      //�û���¼�ɹ������µ��û���¼ʱ������û����߱�
      bbsMgr.insertOnline(bbs);

			//�������threadid
			int threadid = bbsMgr.getMaxThreadID() + 1;

      //�û���¼�ɹ������û�����������tbl_thread��
      bbs = new BBS();
			bbs.setID(threadid);
      bbs.setForumID(forumid);
      bbs.setAnswerID(0);
      bbs.setThreadName(title);
      bbs.setThreadContent(content);
      bbs.setPostTime(nowtime);
      bbs.setAuthor(username);
      bbs.setIPAddress(ipaddress);
      bbs.setAnswerUser(username);
      bbs.setAnswerTime(nowtime);
      bbsMgr.PostThread(bbs);

      //���±�tbl_column�е���󷢱���˵���Ϣ
      int threadnum = bbsMgr.getNUM("threadnum",forumid);
      int topicnum = bbsMgr.getNUM("topicnum",forumid) + 1;
      bbsMgr.updateLastNum(threadnum,topicnum,forumid);
      bbsMgr.updateLastPost(username,title,nowtime,forumid);

      response.sendRedirect("list.jsp?forumid="+forumid+"&startflag=1");
    }else{
      response.sendRedirect("posttopic1.jsp?loginflag=1&forumid="+forumid);
    }
  }
%>
<html>
<head>
<title>��ӭ���ʱ����ǽ�Ͷ�ʷ�չ�ɷ����޹�˾</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet href="images/chengjian.css" style="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<center>
<table width="778" border="0" cellspacing="0" cellpadding="0" height="36">
<tr>
<td background="images/index-bg01.gif" align="right">
<table border="0" cellspacing="0" cellpadding="0" width="250">
<tr>
<td><img src="images/button-home.gif" width="75" height="24"></td>
<td><img src="images/button-dichan.gif" width="75" height="24"></td>
<td><img src="images/button-touzi.gif" width="75" height="24"></td>
</tr>
</table>
</td>
<td bgcolor="#717171" width="1"></td>
</tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="257"><img src="images/index-logo.gif" width="257" height="45"></td>
<td>&nbsp; </td>
</tr>
</table>
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
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="tittle">
<%
  bbs = bbsMgr.getAFORUM(forumid);
%>
<tr>
<td><b><span class="tittle">����λ��:</span></b><span class="tittle"><a href="/bbs/index.jsp">�ǽ���̳</a>
>> <a href="list.jsp?forumid=<%=forumid%>&startflag=1"><%=bbs.getBBSName()%></a></span></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/dotline.gif">
<tr>
<td><img src="images/space.gif" width="3" height="3"></td>
</tr>
</table>
<%
  int threadcount = bbsMgr.getAllThreadNum(0, forumid);
  int answercount = bbsMgr.getAllThreadNum(1, forumid);
  int onlinecount = bbsMgr.getAllThreadNum(2, 0);
%>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="txt">
<tr bgcolor="F1F2EC">
<form  method="post" action="searchuser.jsp" name="searchform">
<td>Ŀǰ��̳������ <b><%=onlinecount%></b> ��&nbsp;&nbsp;&nbsp;&nbsp;����̳�������� <b><%=threadcount%></b>&nbsp;&nbsp;&nbsp;&nbsp;�ظ�����
<b><%=answercount%></b> [<a href="online.jsp" target=_blank>�����û�</a>] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�û���ѯ&nbsp;
<input type="text" name="search_user" size=8>
&nbsp;
<input type=button value="��ѯ" onClick="javascript:searchuser(this.form);" name="button">
</td>
</form>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
<td bgcolor="#FFFFFF" valign="top" align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="txt">
<form name="postForm" method="post" action="posttopic1.jsp">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="forumid" value="<%=forumid%>">
<tr>
<td align="left">ע�⣺��ע���û�û�з�����Ϣ��Ȩ����<a href="/login.jsp" class="red" target=_blank>��½����</a>>>��<a href="/reg1.jsp" class="red" target=_blank>ע��</a>>></td>
</tr>
<tr>
<td>�û�����
<input type="text" name="username" size="15">
���룺
<input type="password" name="password" size="15">
</td>
</tr>
<tr>
<td>���⣺
<input type="text" name="title" size="60">
</td>
</tr>
<tr>
<td> ���ݣ�
<textarea name="content" cols="80" rows="10"></textarea>
</td>
</tr>
<tr align="center">
<td>
<input type="submit" name="Submit2" value="����">
</td>
</tr>
</form>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td><img src="images/space.gif" width="25" height="25"></td>
</tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="49"><img src="images/index17.gif" width="49" height="36"></td>
<td valign="top" bgcolor="#EEEEEE">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td height="1" bgcolor="#BBBBBB"></td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="48">&nbsp;</td>
<td width="111"><a href="sitemap.html"><img src="images/index-button15.gif" width="111" height="13" border="0"></a></td>
<td width="111"><a href="law.html"><img src="images/index-button16.gif" width="111" height="13" border="0"></a></td>
<td width="111"><a href="contactus.html"><img src="images/index-button17.gif" width="111" height="13" border="0"></a></td>
<td><a href="hezuo.html"><img src="images/index-button18.gif" width="111" height="13" border="0"></a></td>
<td><img src="images/index-bg05.gif" width="2" height="34"></td>
</tr>
</table>
</td>
</tr>
<tr bgcolor="#BBBBBB">
<td height="1"></td>
</tr>
</table>
</td>
<td width="6"><img src="images/index18.gif" width="6" height="36"></td>
</tr>
</table>
<table width="100" border="0" cellspacing="0" cellpadding="0">
<tr>
<td height="10"></td>
</tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="265"><img src="images/index19.gif" width="257" height="34"></td>
<td bgcolor="#A5A5A5" width="1"></td>
<td align="center">
<table width="98%" border="0" cellspacing="0" cellpadding="3">
<tr>
<td>�����г�������������·11�� �ʱࣺ100029 <br>
�绰��(010) 82275566 ���棺(010) 82275533E_mail��bucid@bucid.com </td>
</tr>
</table>
</td>
</tr>
</table>
</center>
</body>
</html>

