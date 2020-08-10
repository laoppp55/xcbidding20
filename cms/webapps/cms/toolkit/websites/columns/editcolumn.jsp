<%@ page import="java.sql.*,
                 java.util.List,
                 com.bizwink.cms.toolkit.websites.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.viewFileManager.*" contentType="text/html;charset=GBK"%>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean errors = false;
    boolean success = false;
    int siteid = authToken.getSiteID();

    boolean doUpdate = ParamUtil.getBooleanParameter(request, "doUpdate");
    int ID = ParamUtil.getIntParameter(request, "ID", 0);
    int parentID = ParamUtil.getIntParameter(request, "parentID", 0);
    String CName = ParamUtil.getParameter(request, "CName");
    String extfilename = ParamUtil.getParameter(request, "extfilename");
    int orderid = ParamUtil.getIntParameter(request, "orderid", 1);
    String desc = ParamUtil.getParameter(request, "desc");

    IWebsiteManager websiteManager = WebsiteInfoPeer.getInstance();
    WebsiteClass companyType = new WebsiteClass();
    Tree colTree = TreeManager.getInstance().getWebsiteTypeTree(siteid);;

    int rootID = colTree.getTreeRoot();

    if (doUpdate) {
        if (CName == null) errors = true;
        if (desc != null)
            desc = desc.trim();
        else
            desc = "";
    }

    if (!errors && doUpdate) {
        try {
            companyType.setId(ID);
            companyType.setSiteid(siteid);
            companyType.setParentid(parentID);
            companyType.setCname(StringUtil.gb2isoindb(CName));
            companyType.setExtname(extfilename);
            companyType.setLastupdated(new Timestamp(System.currentTimeMillis()));
            String editor = authToken.getUserID();
            companyType.setOrderid(orderid);
            companyType.setEditor(editor);
            companyType.setDesc(StringUtil.gb2isoindb(desc));
            websiteManager.update(companyType,siteid);
            success = true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    if (success) {
        //response.sendRedirect(response.encodeRedirectURL("index.jsp?rightid=1"));
        out.println("<script>window.close();opener.location.href = \"index.jsp\"</script>");        
        return;
    }

    //������������
    companyType = websiteManager.getCompanyClass(ID);
    parentID = companyType.getParentid();
    CName = StringUtil.gb2iso4View(companyType.getCname());
    String EName = companyType.getEname();
    extfilename = companyType.getExtname();
    if (extfilename == null) extfilename = "";
    orderid = companyType.getOrderid();
    desc = companyType.getDesc();
    if (desc == null) desc = "";
    desc = StringUtil.gb2iso4View(desc);


    String parentName = "��վ��ҳ";
    if (parentID > 0) {
        WebsiteClass parentColumn = websiteManager.getCompanyClass(parentID);
        if (parentColumn != null) {
            parentName = StringUtil.gb2iso4View(parentColumn.getCname());
        }
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../css/global.css">
    <script language=javascript>

        function Upload()
        {
            window.open("../upload/upload.jsp?column=<%=rootID%>&attr=updateDesc", "Upload", "width=400,height=200,left=200,top=200");
        }

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

            return true;
        }
    </script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"�޸���Ŀ", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<center>
    <form action="editcolumn.jsp" method="post" name="updateForm" onsubmit="javascript:return check(this);">
        <input type=hidden name="doUpdate" value="true">
        <input type=hidden name="ID" value="<%=ID%>">
        <input type=hidden name="parentID" value="<%=parentID%>">
        <input type=hidden name="xmlTemplate">
        <input type=hidden name="extattrscope" value="0">

        <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="60%"
               align=center>
            <tr height=20>
                <td align=right class=line>����Ŀ����</td>
                <td class=tine>&nbsp;<%= parentName %>
                </td>
            </tr>
            <tr height=28>
                <td align=right><font class=line <%= (errors) ? (" color=\"#ff0000\"") : "" %>>��Ŀ���ƣ�</font></td>
                <td>&nbsp;<input class=tine name=CName size=30 value="<%= (CName!=null)?CName:"" %>">*</td>
            </tr>
            <tr height=28>
                <td align=right><font class=line>��ĿĿ¼��</font></td>
                <td>&nbsp;<input class=tine name=EName size=30 value="<%= (EName!=null)?EName:"" %>" disabled>*</td>
            </tr>
            <tr height=28>
                <td align=right class=line>��Ŀ����</td>
                <td>&nbsp;<input class=tine name=orderid size=30 value="<%= orderid %>">*</td>
            </tr>
            <tr height=28>
                <td class=line align=right>�ļ���չ����</td>
                <td class=tine>&nbsp;<select name=extfilename size=1 class=tine>
                    <option value="html" <%= (extfilename.compareTo("html") == 0) ? "selected" : "" %>>html</option>
                    <option value="htm" <%= (extfilename.compareTo("htm") == 0) ? "selected" : "" %>>htm</option>
                    <option value="jsp" <%= (extfilename.compareTo("jsp") == 0) ? "selected" : "" %>>jsp</option>
                    <option value="asp" <%= (extfilename.compareTo("asp") == 0) ? "selected" : "" %>>asp</option>
                    <option value="shtm" <%= (extfilename.compareTo("shtm") == 0) ? "selected" : "" %>>shtm</option>
                    <option value="shtml" <%= (extfilename.compareTo("shtml") == 0) ? "selected" : "" %>>shtml</option>
                    <option value="php" <%= (extfilename.compareTo("php") == 0) ? "selected" : "" %>>php</option>
                    <option value="wml" <%= (extfilename.compareTo("wml") == 0) ? "selected" : "" %>>wml</option>
                </select>
                </td>
            </tr>
            <tr>
                <td class=line align=right>��Ŀ������</td>
                <td class=tine>&nbsp;<textarea class=tine rows="4" name="desc" cols="40"><%=desc%>
                </textarea></td>
            </tr>
        </table>

        <br>
        <input type=submit value="  ����  ">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type=button value="  ����  " onclick="javascript:window.close();">
    </form>
</center>

</BODY>
</html>