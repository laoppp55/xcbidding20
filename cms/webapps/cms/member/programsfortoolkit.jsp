<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.program.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect( "../login.jsp" );
        return;
    }
    if (!SecurityCheck.hasPermission(authToken,54))
    {
        request.setAttribute("message","�޹����û���Ȩ��");
        response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
        return;
    }

    int siteid = authToken.getSiteID();

    IProgramManager progMgr = ProgramPeer.getInstance();
    List progList = progMgr.getAllToolkitPrograms(siteid);
    int progCount = progList.size();
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
        function createProgramForToolkit()
        {
            window.open("createProgramForToolkit.jsp","","top=100,left=100,width=800,height=300");
        }

        function editUser(userid)
        {
            window.open("editUser.jsp?userid="+userid,"","top=100,left=100,width=470,height=620");
        }
    </script>
</head>
<%
    String[][] titlebars = {
            { "�������������", "" }
    };
    String[][] operations = {
            {"<a href=javascript:createProgramForToolkit();>��������ģ��</a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="90%" align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td width="25%" align=center class="listHeader"><b>����Ӣ������</b></td>
        <td width="25%" align=center>������������</td>
        <td width="10%" align=center>����·��</td>
        <td width="10%" align=center>����ʱ��</td>
        <td width="10%" align=center>�޸�ʱ��</td>
        <td width="10%" align=center>�޸�</td>
        <td width="10%" align=center>ɾ��</td>
    </tr>
    <%
        for (int i=0; i<progCount; i++)
        {
            programOftoolkit tprogram = (programOftoolkit)progList.get(i);
            int id = tprogram.getId();
            String enname = tprogram.getProgid();
            String cnName = StringUtil.gb2iso4View(tprogram.getProgname());
            String proguri = tprogram.getProguri();
    %>
    <tr bgcolor="#ffffff" class=line>
        <td align=center><b><%=enname%></b></td>
        <td align=center><%=cnName%></td>
        <td align=center><%=proguri%></td>
        <td align=center><%=tprogram.getCreatedate().toString()%></td>
        <td align=center><%=tprogram.getUpdatedate().toString()%></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='update.jsp?id=<%=id%>';"></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='remove.jsp?id=<%=id%>';"></td>
    </tr>
    <%}%>
</table>

</body>
</html>