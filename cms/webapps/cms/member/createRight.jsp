<%@ page import="java.util.*,
		 java.net.URLEncoder,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if( authToken == null ) {
        response.sendRedirect( "../login.jsp?url=member/createRight.jsp" );
	return;
    }

    if (!SecurityCheck.hasPermission(authToken, "right")){

		response.sendRedirect("../error.jsp?message=�޴�����Ȩ�޵Ĺ���");
		return;
	}

	boolean error = false;
	// creation success variable:
	boolean success = false;

	// get parameters
	String rightID           = ParamUtil.getParameter(request,"rightid");
	String rightName         = ParamUtil.getParameter(request,"rightname");
	String rightDesc         = ParamUtil.getParameter(request,"rightdesc");
	String rightCat         = ParamUtil.getParameter(request,"rightcat");
	boolean doCreate        = ParamUtil.getBooleanParameter(request,"doCreate");

	// check for errors
	if( doCreate ) {
		if( rightID == null || rightName == null ) {
			error = true;
		}
	}

	// adding the user
	if( !error && doCreate ) {
		IRightManager rightMgr = RightPeer.getInstance();
		try {
			Right newRight = new Right();
			newRight.setRightID( rightID );
			newRight.setRightName(rightName);
			newRight.setRightDesc(rightDesc);
			newRight.setRightCat(rightCat);
			rightMgr.create(newRight);
			success = true;
		}
		catch( CmsException ue ) {
		        success = false;
			error = true;
		}
	}

	// jsp from executing
	if( success ) {
		response.sendRedirect("rightManage.jsp?msg="
			+ URLEncoder.encode("�û������ɹ�"));
		return;
	}
%>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%	////////////////////
	String[][] titlebars = {
	        { "Ȩ���б�", "rightManage.jsp" },
		{ "�½�Ȩ����", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>
<%	// print error messages
	if( !success && error ) {
%>
<p><font class=cur>�½�Ȩ��ʧ��.</font><p>
<%	} %>

<font class=bhn>��������Ȩ�������Ϣ</font>
<%-- form --%>
<center>
<form action="createRight.jsp" method="post" name="createForm">
<input type="hidden" name="doCreate" value="true">
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
<tr class=line>
<td>Ȩ�ޱ�ʶ</td>
<td><input class=line name=rightid size=30 value="<%= (rightID!=null)?rightID:"" %>">
</td></tr>
<tr class=line>
<td>Ȩ������</td>
<td><input class=line name=rightname size=30 value="<%= (rightName!=null)?rightName:"" %>">
</td></tr>
<tr class=line>
<td>Ȩ�����</td>
<td><input class=line name=rightcat size=30 value="<%= (rightCat!=null)?rightCat:"" %>">
</td></tr>
<tr class=line>
<td>Ȩ�������Ϣ����</td>
<td><input class=line name=rightdesc size=30 value="<%= (rightDesc!=null)?rightDesc:"" %>">
</td></tr>
<tr><td colspan=2 align=center>
<input type=image src=../images/button_add.gif onclick="document.all.createForm.submit()">
&nbsp;
<input type=image src=../images/button_cancel.gif onclick="location.href='rightManage.jsp';return false;">
</td></tr>
</table></form>
</center>
<script language="JavaScript" type="text/javascript">
<!--
   document.createForm.rightid.focus();
//-->
</script>
</body></html>

