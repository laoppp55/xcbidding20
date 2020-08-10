<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 java.sql.Timestamp"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteID = authToken.getSiteID();
    String username = authToken.getUserID();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int templateID = ParamUtil.getIntParameter(request, "template", 0);
    int referModelID = ParamUtil.getIntParameter(request, "referid", 0);
    boolean doUpdate = ParamUtil.getBooleanParameter(request, "doUpdate");
    int samsiteid=authToken.getSamSiteid();
    IColumnManager columnMgr = ColumnPeer.getInstance();
    IModelManager modelManager = ModelPeer.getInstance();
    Model model = modelManager.getModel(templateID, username);

    if (doUpdate)
    {
        String cname = ParamUtil.getParameter(request, "cname");
        String ename = ParamUtil.getParameter(request, "ename");

        model.setID(templateID);
        //model.setColumnID(columnID);
        //model.setReferModelID(referModelID);
        model.setEditor(username);
        model.setLastupdated(new Timestamp(System.currentTimeMillis()));
        model.setLockstatus(0);
        model.setChineseName(cname);
        model.setTemplateName(ename);
        modelManager.Update(model,siteID,samsiteid,0);

        out.println("<script language=javascript>opener.history.go(0);window.close();</script>");
        return;
    }

    referModelID = model.getReferModelID();
    int oldColumnID = modelManager.getModel(referModelID).getColumnID();
    String Cname = StringUtil.gb2iso4View(columnMgr.getColumn(columnID).getCName());
    String oldCname = StringUtil.gb2iso4View(columnMgr.getColumn(oldColumnID).getCName());
%>

<html>
<head>
    <title>�޸�ģ��</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../style/global.css">
</head>
<script language=javascript>
    function check()
    {
        if (document.editForm.cname.value != "" && document.editForm.ename.value != "")
            return true;
        else
            return false;
    }
</script>
<body>

<form action="editReferTemplate.jsp?template=<%=templateID%>&column=<%=columnID%>" method="post" name=editForm onsubmit="javascript:return check();">
    <input type=hidden name=doUpdate value=true>
    <input type=hidden name=referid value=<%=referModelID%>>
    <input type=hidden name=column value=<%=model.getColumnID()%>>

    <table width="90%" align=center border=0>
        <tr height=30><td>��ǰ��Ŀ��<%=Cname%></td></tr>
        <tr height=30><td><b>��ǰģ��������<font color=red><%=oldCname%></font>��Ŀ�µ�ID=<%=referModelID%>��ģ��</b></td></tr>
        <tr height=30><td align=center>ģ���������ƣ�<input name=cname size=24 value="<%=(model.getChineseName()==null)?"":StringUtil.gb2iso4View(model.getChineseName())%>"></td></tr>
        <tr height=30><td align=center>ģ���ļ�����&nbsp;&nbsp;<input name=ename size=24 value="<%=model.getTemplateName()%>"></td></tr>
        <tr height=60><td align=center>
            <input type=submit value="  ����  " class=tine>&nbsp;&nbsp;
            <input type=button value="  ȡ��  " class=tine onclick="window.location='closewin.jsp?id=<%=templateID%>&column=<%=columnID%>';">
        </td></tr>
    </table>
</form>

</body>
</html>