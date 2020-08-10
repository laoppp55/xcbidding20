<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if( authToken == null )
    {
        response.sendRedirect( "../login.jsp?url=member/createMember.jsp" );
        return;
    }
    if (!SecurityCheck.hasPermission(authToken, 54))
    {
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
        return;
    }

    int groupID = ParamUtil.getIntParameter(request,"groupID",0);    //����Ȩ�˵���id�����ǵ�¼�ߵ���id
%>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�û�����</title>
</head>
<frameset cols=160,*>
<frameset cols=* rows=0,*>
<frame src=columntree.jsp name=cmsleft>
<frame src=menu.html name=menu>
</frameset>
<frame src="doGrantForGroup.jsp?groupID=<%=groupID%>" name=cmsright>
</frameset>
</html>