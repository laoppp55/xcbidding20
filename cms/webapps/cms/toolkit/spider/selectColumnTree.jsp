<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
%>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��Ϣ���͵���Ŀ</title>
</head>
<frameset cols=160,*>
<frameset cols=* rows=0,*>
<frame src=columntree.jsp name=cmsleft>
<frame src=menu.html name=menu>
</frameset>
<frame src="doGrantForGroup.jsp" name=cmsright>
</frameset>
</html>