<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.webapps.leaveword.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    IWordManager wordMgr = LeaveWordPeer.getInstance();

    List columns = wordMgr.getALLColumn(siteid);
%>
<html>
<head>
    <title>
        �û����Է������
    </title>
    <script language="javascript">
        function addNewColumn() {
            window.open("addcolumn.jsp","addnewcolumnforlw","height=500,width=800");
        }

        function update(id) {
            window.open("editcolumn.jsp?id="+ id,"addnewcolumnforlw","height=500,width=800");
        }

        function del(id) {
            window.open("deletecolumn.jsp?id="+id,"addnewcolumnforlw","height=500,width=800");
        }
    </script>
</head>
<body>
<table width="50%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
    <tr>
        <td>
            <a href="#" onclick="javascript:addNewColumn()">�����·���</a>                   <a href="#" onclick="javascript:window.close()">�˳�</a>
        </td>
    </tr>
</table>

<table width="100%" border="1" cellpadding="3" cellspacing="1" class="css_002">
    <tr  bgcolor="#FFFFFF" class="css_001">
        <td width="10%" align="center">���к�</td>
        <td align="center" width="15%">��������</td>
        <td align="center" width="15%">Ӣ������</td>
        <td align="center" width="10%">������</td>
        <td align="center" width="15%">����ʱ��</td>
        <td align="center" width="15%">�޸�ʱ��</td>
        <td align="center" width="10%">�޸�</td>
        <td align="center" width="10%">ɾ��</td>
    </tr>
    <%
        for(int i = 0; i < columns.size();i++){
            Column column = (Column)columns.get(i);
    %>
    <tr  bgcolor="#FFFFFF" class="css_001">
        <td align="left" width="10%"><input type="checkbox" name="ids" value="<%=column.getId()%>"></td>
        <td align="left" width="15%"><%=column.getCname() == null?"--":StringUtil.gb2iso4View(column.getCname())%></td>
        <td align="left" width="10%"><%=column.getEname() == null?"--":column.getEname()%></td>
        <td align="left" width="10%"><%=column.getEditor() == null?"--":column.getEditor()%></td>
        <td align="left" width="15%"><%=column.getCreatedate() == null?"--":column.getCreatedate().toString()%></td>
        <td align="left" width="15%"><%=column.getLastupdated() == null?"--":column.getLastupdated().toString()%></td>
        <td align="center" width="10%"><a href="#" onclick="javascript:update(<%=column.getId()%>);">�޸�</a></td>
        <td align="center" width="10%"><a href="#" onclick="javascript:del(<%=column.getId()%>);">ɾ��</a></td>
    </tr>
    <%}%>
</table>
</body>
</html>