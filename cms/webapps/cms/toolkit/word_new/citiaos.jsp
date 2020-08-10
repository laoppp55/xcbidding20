<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

    List citiaos = wordMgr.getAllCitiaos(siteid);
%>
<html>
<head>
    <title>
        �û�������Ч��������
    </title>
    <script language="javascript">
        function addNewCitiao() {
            window.open("addcitiao.jsp","addnewcolumnforlw","height=500,width=800");
        }

        function update(id) {
            window.open("editcitiao.jsp?id="+ id,"addnewcolumnforlw","height=500,width=800");
        }

        function del(id) {
            window.open("deletecitiao.jsp?id="+id,"addnewcolumnforlw","height=500,width=800");
        }
    </script>
 </head>
<body>
<table width="50%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
    <tr>
        <td>
            <a href="#" onclick="javascript:addNewCitiao()">�����´���</a>        <a href="#" onclick="javascript:window.close()">�˳�</a>
        </td>
    </tr>
</table>

<table width="100%" border="1" cellpadding="3" cellspacing="1" class="css_002">
    <tr  bgcolor="#FFFFFF" class="css_001">
        <td width="10%" align="center">���к�</td>
        <td width="50%">��������</td>
        <td width="20%">�޸�</td>
        <td width="20%">ɾ��</td>
    </tr>
    <%
        for(int i = 0; i < citiaos.size();i++){
            CiTiao citiao = (CiTiao)citiaos.get(i);
    %>
    <tr  bgcolor="#FFFFFF" class="css_001">
        <td align="left" width="10%"><input type="checkbox" name="ids" value="<%=citiao.getId()%>"></td>
        <td align="left" width="50%"><%=citiao.getContent() == null?"--":StringUtil.gb2iso4View(citiao.getContent())%></td>
        <td width="20%"><a href="#" onclick="javascript:update(<%=citiao.getId()%>);">�޸�</a></td>
        <td width="20%"><a href="#" onclick="javascript:del(<%=citiao.getId()%>);">ɾ��</a></td>
    </tr>
    <%}%>
</table>
</body>
</html>