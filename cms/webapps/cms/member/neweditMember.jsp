<%@ page import="com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
String userID   = ParamUtil.getParameter(request,"userid");
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����б�����</title>
</head>
<frameset cols=160,* border=0 frameborder=0 framespacing=0>
<frameset frameborder=0 framespacing=0 border=0 cols=* rows=0,*>
<frame src="treeformember.jsp" name="cmsleft" scrolling="auto" marginheight=0 marginwidth=0 noresize>
<frame marginwidth=5 marginheight=5 src="menu.html" name="menu" noresize scrolling="auto" frameborder=0>
</frameset>
<frame src='editMember.jsp?userid=<%= userID %>' name="cmsright" scrolling=auto marginheight=0 marginwidth=5 noresize>
</frameset>
</html>