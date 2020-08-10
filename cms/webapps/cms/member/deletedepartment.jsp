<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.IUserManager" %>
<%@ page import="com.bizwink.cms.security.UserPeer" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.SecurityCheck" %>
<%@page contentType="text/html;charset=GBK"  %>
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
    int id = ParamUtil.getIntParameter(request,"id",0);
    IUserManager uMgr = UserPeer.getInstance();
    int code = uMgr.deleteDepartment(id);
   if(code == 0){
       out.print("<script language=\"javascript\">alert(\"ɾ���ɹ���\");window.opener.history.go(0);window.close();</script>");
   }else{
       out.print("<script language=\"javascript\">alert(\"ɾ��ʧ�ܣ�\");window.opener.history.go(0);window.close();</script>");
   }
%>