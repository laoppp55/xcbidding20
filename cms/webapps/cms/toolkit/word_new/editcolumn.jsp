<%@ page import="com.bizwink.webapps.leaveword.*" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    String userid = authToken.getUserID();
    int id = ParamUtil.getIntParameter(request,"id",0);
    boolean docreate = ParamUtil.getBooleanParameter(request,"doCreate");
    IWordManager wordMgr = LeaveWordPeer.getInstance();
    if(docreate) {
        Column column = new Column();
        String cname = ParamUtil.getParameter(request,"cname");
        String ename = ParamUtil.getParameter(request,"ename");
        String summary = ParamUtil.getParameter(request,"summary");
        column.setCname(cname);
        column.setEname(ename);
        column.setEditor(userid);
        column.setSiteid(siteid);
        column.setId(id);
        column.setSummary(summary);
        column.setLastupdated(new Timestamp(System.currentTimeMillis()));
        wordMgr.updateColumn(column);
        out.write("<script language=\"javascript\">alert(\"�ύ�ɹ���\");window.opener.location='columns.jsp';window.close();</script>");
        return;
    }
    Column column = wordMgr.getAColumn(siteid,id);
%>
<html>
<head>
    <title>
        �޸����Է�����Ϣ
    </title>
</head>
<body>
<table width="100%" border="1" cellpadding="3" cellspacing="1" class="css_002">
    <form name="columnForm" method="post" action="editcolumn.jsp">
        <input type="hidden" name="doCreate" value="true">
        <input type="hidden" name="id" value="<%=id%>">
        <tr  bgcolor="#FFFFFF" class="css_001">
            <td align="center" width="30%">��������</td>
            <td><input type="text" name="cname" value="<%=(column.getCname()!=null)?column.getCname():""%>" size="50" maxlength="100"></td>
        </tr>
        <tr>
            <td align="center" width="30%">Ӣ������</td>
            <td><input type="text" name="ename" value="<%=(column.getEname()!=null)?column.getEname():""%>" size="50" maxlength="100"></td>
        </tr>
        <tr>
            <td align="center" width="30%">��������</td>
            <td><input type="text" name="ename" value="<%=(column.getSummary()!=null)?column.getSummary():""%>" size="50" maxlength="100"></td>
        </tr>
        <tr>
            <td align="center"><input type="submit" name="ok" value="ȷ��"></td>
            <td><input type="button" name="cancel" value="����" onclick="javascript:window.close()"></td>
        </tr>
    </form>
</table>
</body>
</html>