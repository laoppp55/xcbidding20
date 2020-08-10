<%@ page import="java.util.*,
		 com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*"
                 contentType="text/html;charset=gbk"
%>

<%
    	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    	if (authToken == null)
    	{
        	response.sendRedirect( "../login.jsp?url=member/createnewsite.jsp" );
        	return;
    	}

	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		request.setAttribute("message","��ϵͳ�����Ȩ��");
		response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
		return;
	}

	boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
	boolean error = false;
	int siteID = authToken.getSiteID();
	int pubflag = -1;

	IRegisterManager regMgr = RegisterPeer.getInstance();

	if (doCreate)
	{
		pubflag = ParamUtil.getIntParameter(request, "pubflag", -1);
		if (pubflag == -1)
		{
			error = true;
		}
	}

	if (doCreate && !error)
	{
		try
		{
			regMgr.update_pubflag(siteID, pubflag);
			out.println("<script language=javascript>");
			out.println("window.close();");
			out.println("</script>");
			return;
		}
		catch (Exception e)
		{
			e.printStackTrace();
			out.println("�������⣡��رպ����ԣ�");
			return;
		}
	}

	//��ȡ��ǰվ�����·�����ʽ
	pubflag = regMgr.query_pubflag(siteID);
%>

<html>
<head>
<title>�������·�����ʽ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
</head>

<body bgcolor="#CCCCCC">
<br>
<form method="post" action="pubflag.jsp" name="form1">
<input type=hidden name="doCreate" value="true">
<table border="1" width="95%" cellpadding="0" cellspacing="0" borderColorDark=#ffffec borderColorLight=#5e5e00 align=center>
  <tr>
    <td width="100%" bgcolor="#006699" align="right" height="20" colspan="2">
      <p align="center"><font color="#FFFFFF"><b>�������·�����ʽ</b></font></td>
  </tr>
  <tr>
    <td width="50%" align="center" height="30"><input type="radio" name="pubflag" value="0" <%if(pubflag==0){%>checked<%}%>>&nbsp;�ֶ�����</td>
    <td width="50%" align="center" height="30"><input type="radio" name="pubflag" value="1" <%if(pubflag==1){%>checked<%}%>>&nbsp;�Զ�����</td>
  </tr>
</table>
<p align="center"><input type="submit" value="�� ��" name="Submit">&nbsp;&nbsp;&nbsp;
   <input type="button" value="ȡ ��" name="Reset" onclick="window.close()"></p>
</form>

</body>
</html>
