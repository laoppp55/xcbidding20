<%@ page import="java.util.*,
		 com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*"%>

<%	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if( authToken == null ) {
		response.sendRedirect( "../login.jsp?url=member/removeRight.jsp" );
		return;
	}

	if (!SecurityCheck.hasPermission(authToken, "right")){
		request.setAttribute("message","��ɾ��Ȩ�޵�����");
		response.sendRedirect("../error.jsp?message=��ɾ��Ȩ�޵�����");
		return;
	}

	// get parameters
	String rightID   = ParamUtil.getParameter(request,"rightid");

	boolean doDelete = ParamUtil.getBooleanParameter(request,"doDelete");
	// global error variables

	boolean error = (rightID == null);
	// delete right if specified
	if( doDelete && !error ) {
		IRightManager rightMgr = RightPeer.getInstance();
		try {
			Right right= new Right();
			right.setRightID(rightID);
			rightMgr.remove(right);
			response.sendRedirect("rightManage.jsp");
		}
		catch( CmsException ue ) {
			error = true;
		}
	}
%>

<html>
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>

<%	////////////////////
	String[][] titlebars = {
	        { "Ȩ���б�", "rightManage.jsp" },
		{ "ɾ��Ȩ��", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>

ȷ��Ҫɾ��Ȩ�� <b><%= rightID%></b>?

<p>

<form action="removeRight.jsp" name="deleteForm">
<input type="hidden" name="doDelete" value="true">
<input type="hidden" name="rightid" value="<%= rightID %>">
	<input type="submit" value=" ȷ�� ">
	&nbsp;
	<input type="submit" name="cancel" value=" ȡ�� " style="font-weight:bold;"
	 onclick="location.href='rightManage.jsp';return false;">
</form>

<script language="JavaScript" type="text/javascript">
<!--
document.deleteForm.cancel.focus();
//-->
</script>


</body>
</html>
