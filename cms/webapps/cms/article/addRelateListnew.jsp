<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    int articleid = ParamUtil.getIntParameter(request, "articleid", 0);
%>

<html>
<head>
    <title>文章推荐</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<frameset cols=160,* border=0 frameborder=0 framespacing=0>
    <frameset frameborder=0 framespacing=0 border=0 cols=* rows=0,*>
        <frame src="treeforRelatenew.jsp?articleid=<%=articleid%>" name=cmsleft scrolling=auto marginheight=0 marginwidth=0>
        <frame marginwidth=5 marginheight=5 src="menu.html" name=menu scrolling=auto frameborder=0>
    </frameset>
    <frame src="addRelateRightnew.jsp?column=<%=columnID%>&mark=<%=markID%>&articleid=<%=articleid%>" name=cmsright
           scrolling=auto marginheight=0 marginwidth=5>
</frameset>
</html>