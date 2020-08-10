<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.toolkit.companyinfo.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    String editor = authToken.getUserID();
    ICompanyinfoManager companyManager = CompanyinfoPeer.getInstance();
    companyClass companyType = new companyClass();
    Tree colTree = TreeManager.getInstance().getComapnyTypeTree(siteid);

    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int parentID = ParamUtil.getIntParameter(request, "parentID", 0);
    companyType = companyManager.getCompanyClass(parentID);
    String parentDirname = companyType.getDirname();

    boolean errors = false;
    boolean success = false;
    boolean errorCName = false;
    boolean errorEName = false;
    String CName = "";
    String EName = "";
    String extfilename = "";
    int orderid = 0;
    String desc = "";

    if (doCreate) {
        CName = ParamUtil.getParameter(request, "CName");
        EName = ParamUtil.getParameter(request, "EName");
        extfilename = ParamUtil.getParameter(request, "extfilename");
        orderid = ParamUtil.getIntParameter(request, "orderid", 1);
        desc = ParamUtil.getParameter(request, "desc");

        if (CName == null) {
            errorCName = true;
            errors = true;
        }
        if (EName == null) {
            errorEName = true;
            errors = true;
        }
        if (desc != null)
            desc = desc.trim();
        else
            desc = "";
    }

    if (!errors && doCreate) {
        boolean dualName = companyManager.duplicateEnName(parentID, EName);
        if (!dualName) {
            try {
                companyType.setSiteid(siteid);
                companyType.setParentid(parentID);
                companyType.setCname(StringUtil.gb2isoindb(CName));
                companyType.setEname(EName);
                companyType.setDirname(parentDirname + EName + "/");
                companyType.setExtname(extfilename);
                companyType.setCreatedate(new Timestamp(System.currentTimeMillis()));
                companyType.setLastupdated(new Timestamp(System.currentTimeMillis()));
                companyType.setOrderid(orderid);
                companyType.setEditor(editor);
                companyType.setDesc(StringUtil.gb2isoindb(desc));

                companyManager.create(companyType);
                success = true;
            }
            catch (Exception uaee) {
                uaee.printStackTrace();
                errors = true;
            }
        }
    }

    if (success) {
        //out.println("<script>top.close();</script>");
        out.println("<script>window.close();opener.location.href = \"index.jsp\"</script>");
        //response.sendRedirect(response.encodeRedirectURL("index.jsp?rightid=1&msgno=0"));
        return;
    }
     //����Ѵ��ڵ�վ����Ϣ
    String parentName = StringUtil.gb2iso4View(companyType.getCname());
    //�����ҳ�ļ���չ��
    String extname = companyManager.getIndexExtName(siteid);
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../css/global.css>
    <script language=javascript>
        function check(frm)
        {
            if (frm.CName.value == "")
            {
                alert("��Ŀ�������Ʋ���Ϊ�գ�");
                return false;
            }
            if (frm.CName.value.indexOf(",") > -1)
            {
                alert("��Ŀ���������в��ܺ��ж��ţ�");
                return false;
            }
            if (frm.EName.value == "")
            {
                alert("��ĿӢ�����Ʋ���Ϊ�գ�");
                return false;
            }
            else if (!checkEname(frm.EName.value))
            {
                alert("��ĿӢ�����Ʋ��Ϸ���Ӧ������ĸ�����ּ��»�����ɣ�");
                return false;
            }

            return true;
        }

        function checkEname(str)
        {
            var regstr = /[^0-9a-zA-Z_]/gi;
            if (regstr.exec(str) != null)
                return false;
            else
                return true;
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"�½���˾��Ϣ����", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>
    <%
        if (!success && errors) {
            out.println("<p class=cur>");
            if (!success)
                out.println("������Ϣ " + EName + " �Ѿ����ڡ�����һ��������ϢӢ������");
            else
                out.println("�����д������������ֶΣ����ԡ�");
        }
    %>
</p>
<center>
    <form action="createcolumn.jsp" method="post" name="createForm" onsubmit="return check(this);">
        <input type="hidden" name="doCreate" value="true">
        <input type="hidden" name="parentID" value="<%=parentID%>">
        <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
            <tr height=20>
                <td align=right class=line>�ϲ㹫˾������������</td>
                <td class=tine>&nbsp;<%= parentName %>
                </td>
            </tr>
            <tr height=30>
                <td align=right><font class=line <%= (errorCName) ? (" color=\"#ff0000\"") : "" %>>�����������ƣ�</font></td>
                <td>&nbsp;<input class=tine name=CName size=30 value="<%= (CName!=null)?CName:"" %>">*</td>
            </tr>
            <tr height=30>
                <td align=right><font class=line <%= (errorEName) ? (" color=\"#ff0000\"") : "" %>>����Ӣ�����ƣ�</font></td>
                <td>&nbsp;<input class=tine name=EName size=30 value="<%= (EName!=null)?EName:"" %>">*&nbsp;&nbsp;
                    <font color=red>Ŀ¼����ĸ�����ּ��»������</font>
                </td>
            </tr>
            <tr height=30>
                <td align=right class=line>��������</td>
                <td>&nbsp;<input class=tine name=orderid size=30 value="0">*</td>
            </tr>
            <tr height=30>
                <td class=line align=right>�ļ���չ����</td>
                <td class=tine>&nbsp;<select name=extfilename size=1 class=tine style="width:100">
                    <option value="html" <%if(extname.equalsIgnoreCase("html")){%>selected<%}%>>html</option>
                    <option value="htm" <%if(extname.equalsIgnoreCase("htm")){%>selected<%}%>>htm</option>
                    <option value="jsp" <%if(extname.equalsIgnoreCase("jsp")){%>selected<%}%>>jsp</option>
                    <option value="asp" <%if(extname.equalsIgnoreCase("asp")){%>selected<%}%>>asp</option>
                    <option value="shtm" <%if(extname.equalsIgnoreCase("shtm")){%>selected<%}%>>shtm</option>
                    <option value="shtml" <%if(extname.equalsIgnoreCase("shtml")){%>selected<%}%>>shtml</option>
                    <option value="php" <%if(extname.equalsIgnoreCase("php")){%>selected<%}%>>php</option>
                    <option value="wml" <%if(extname.equalsIgnoreCase("wml")){%>selected<%}%>>wml</option>
                </select></td>
            </tr>
            <tr>
                <td class=line align=right>����������</td>
                <td class=tine>&nbsp;<textarea class=tine rows="4" name="desc" cols="40"></textarea>
                </td>
            </tr>

        </table>
        <br>
        <input type=submit value="  ����  ">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type=button value="  ����  " onclick="javascript:window.close();">
    </form>
</center>

</BODY>
</html>
