<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int from = ParamUtil.getIntParameter(request, "from", 0);
    int param = ParamUtil.getIntParameter(request, "param", -1);
    int column=ParamUtil.getIntParameter(request,"column",-1);
    System.out.println("columnid="+column);
%>

<html>
<head>
    <title>�����������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<frameset cols=160,* border=0 frameborder=0 framespacing=0>
    <frameset frameborder=0 framespacing=0 border=0 cols=* rows=0,*>
        <frame src="treeforArticleList.jsp?from=<%=from%>&param=<%=param%>" name=cmsleft scrolling=auto marginheight=0 marginwidth=0 noresize>
        <frame marginwidth=5 marginheight=5 src=menu.html name=menu noresize scrolling=auto frameborder=0>
    </frameset>
    <frame src="addRelatedArticleRight.jsp?from=<%=from%>&param=<%=param%>&column=<%=column%>" name=cmsright scrolling=auto marginheight=0 marginwidth=5 noresize>
</frameset>
</html>