<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int markID=ParamUtil.getIntParameter(request,"mark",-1);
%>

<html>
<head>
    <title>�û���¼ҳ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<frameset cols=*.0 border=0 frameborder=0 framespacing=0>
    <frame src="addUserLogin.jsp?column=<%=columnID%>&mark=<%=markID%>" name=cmsright scrolling=auto marginheight=0 marginwidth=5
           noresize>
</frameset>
</html>