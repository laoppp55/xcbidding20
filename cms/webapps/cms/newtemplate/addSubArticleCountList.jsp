<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String str = ParamUtil.getParameter(request, "str");
    int columnid=ParamUtil.getIntParameter(request,"column",-1);
    if (str == null) str = "";
%>

<html>
<head>
    <title>����������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<frameset cols=160,* border=0 frameborder=0 framespacing=0>
    <frameset frameborder=0 framespacing=0 border=0 cols=* rows=0,*>
        <frame src="treeforArticleList.jsp" name=cmsleft scrolling=auto marginheight=0 marginwidth=0 noresize>
        <frame marginwidth=5 marginheight=5 src=menu.html name=menu noresize scrolling=auto frameborder=0>
    </frameset>
    <frame src="addSubArticleCountRight.jsp?str=<%=str%>&column=<%=columnid%>" name=cmsright scrolling=auto marginheight=0 marginwidth=5
           noresize>
</frameset>
</html>