<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.news.Producttype" %>
<%@ page import="com.bizwink.cms.news.IColumnManager" %>
<%@ page import="com.bizwink.cms.news.ColumnPeer" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String errormsg = "";
    boolean error = false;
    int columnID = ParamUtil.getIntParameter(request, "columnID", 0);
    int parentID = ParamUtil.getIntParameter(request, "parentID", 0);
    int from = ParamUtil.getIntParameter(request, "from", 0);   //from=1������ҳ
    String act = ParamUtil.getParameter(request, "act");

    session.setAttribute("Current_URL",request.getRequestURI());

    IColumnManager columnMgr = ColumnPeer.getInstance();


    if (act == null) {
        int id1 = columnMgr.getTypeID(parentID, columnID);

        if (id1 != -1) {
            Producttype pro = new Producttype();
            pro.setCname("");
            pro.setColumnID(columnID);
            pro.setParentid(0);
            pro.setReferid(id1);
            columnMgr.createType(pro);
        }
    }
    //����
    if (act != null && act.equals("doCreate")) {
        String cname = ParamUtil.getParameter(request, "cname");
        if (cname == null || cname.trim().length() == 0) {
            error = true;
            errormsg = "<p align=center><font color=red><b>�����������</b></font></p>";
        }
        if (!error) {
            Producttype pro = new Producttype();
            pro.setCname(cname);
            pro.setColumnID(columnID);
            pro.setParentid(0);
            pro.setReferid(0);
            columnMgr.createType(pro);
        }
        response.sendRedirect("edittype.jsp?act=doNothing&from=" + from + "&columnID=" + columnID + "&parentID=" + parentID);
    }
    //�޸�
    if (act != null && act.equals("doUpdate")) {
        String cname = ParamUtil.getParameter(request, "cname");
        int id = ParamUtil.getIntParameter(request, "id", 0);
        if (cname == null || cname.trim().length() == 0) {
            error = true;
            errormsg = "<p align=center><font color=red><b>�޸ķ������</b></font></p>";
        }

        if (!error) {
            columnMgr.updateTypeCname(id, cname);
        }
        response.sendRedirect("edittype.jsp?act=doNothing&from=" + from + "&columnID=" + columnID + "&parentID=" + parentID);
    }
    //ɾ��
    if (act != null && act.equals("doDelete")) {
        int id = ParamUtil.getIntParameter(request, "id", 0);
        columnMgr.deleteTypeValue(id);
        response.sendRedirect("edittype.jsp?act=doNothing&from=" + from + "&columnID=" + columnID + "&parentID=" + parentID);
    }

%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <title>��ӷ���</title>
    <script language=javascript>
        function check(frm)
        {
            if (frm.cname.value == "")
            {
                alert("�����������Ʋ���Ϊ�գ�");
                return false;
                cname.focus();
            }
            return true;
        }

        function checkEname(ename)
        {
            var retstr = false;
            var regstr = /[^a-zA-Z0-9_]/gi;
            if (regstr.exec(ename) == null)
            {
                retstr = true;
            }
            return retstr;
        }

        function Update(i, id)
        {
            var cname = document.all("cname" + i).value;
            if (cname == "")
            {
                return;
            }
            window.location = "edittype.jsp?id=" + id + "&cname=" + cname + "&act=doUpdate&from=<%=from%>&columnID=<%=columnID%>&parentID=<%=parentID%>";
        }

        function Save()
        {
            window.location = "createtype.jsp?act=doSave&from=<%=from%>&columnID=<%=columnID%>";
        }

        function control()
        {
            if (document.all("type").value == "3")
                picattr.style.display = "";
            else
                picattr.style.display = "none";
        }
        function addvalue(id, columnid) {
            window.open("createtypenewvalue.jsp?typeid=" + id + "&columnID=" + columnid, "", "width=600,height=400,left=200,right=200,scrollbars,status");
        }
    </script>
</head>

<body>
<table border="0" width="580" align="center">
    <tr>
        <td><%=errormsg%>
        </td>
    </tr>
    <tr height=80>
        <td width="100%">
            <form method="POST" action="edittype.jsp?from=<%=from%>&columnID=<%=columnID%>&parentID=<%=parentID%>"
                  onsubmit="javascript:return check(this);">
                <input type=hidden name=act value=doCreate>
                <table border=0 cellspacing=2 cellpadding=2 width="100%">
                    <tr>
                        <td width="96%">
                            �������ƣ�<input name="cname" size="15" class=tine>
                            <input type="submit" value="  �ύ  " name="submit" class=tine>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
                <tr>
                    <td width="20%" align="center"><B>������������</B></td>
                    <td width="20%" align="center"><B>����</B></td>
                    <td width="20%" align="center"><B>����ӷ���</B></td>
                </tr>
                <%
                    List inlist = columnMgr.getInheritanceType(parentID);
                    for (int i = 0; i < inlist.size(); i++) {
                        Producttype p = (Producttype) inlist.get(i);
                        String cname = StringUtil.gb2iso4View(p.getCname());
                %>
                <tr>
                    <td align="center"><input name=incname value="<%=cname%>" size=14 class=tine></td>
                    <td width="20%" align="center"><B>&nbsp;</B></td>
                    <td width="20%" align="center"><B>&nbsp;</B></td>
                </tr>
                <%}%>
                <%
                    List typeList = columnMgr.getAllTypeForColumn("select * from tbl_type where columnid = " + columnID + " and parentid = 0 and referid = 0 order by createdate desc");
                    for (int i = 0; i < typeList.size(); i++) {
                        Producttype pt = (Producttype) typeList.get(i);
                        String cname = StringUtil.gb2iso4View(pt.getCname());
                %>
                <tr>
                    <td align="center"><input name=cname<%=i%>
                                              value="<%=cname%>"
                                              size=14 class=tine></td>
                    <td align="center">
                        <a href="edittype.jsp?id=<%=pt.getId()%>&act=doDelete&from=<%=from%>&columnID=<%=columnID%>&parentID=<%=parentID%>">ɾ��</a>&nbsp;
                        <a href="javascript:Update(<%=i%>,<%=pt.getId()%>);">�޸�</a>
                    </td>
                    <td align=center><input type=radio onclick="javascript:addvalue(<%=pt.getId()%>,<%=columnID%>);">
                    </td>
                </tr>
                <%}%>
            </table>
        </td>
    </tr>
    <tr height=40>
        <td align=center>
            <%--<input type="button" value="   ����   " name="save" class=tine onclick="Save();">&nbsp;&nbsp;--%>
            <input type="button" value="   �ر�   " name="close" class=tine onclick="window.close();">
        </td>
    </tr>
    <%--    <tr><td>ע�⣺���������桱��ť����Ҫֱ�ӹرգ�</td></tr>--%>
</table>

</body>
</html>