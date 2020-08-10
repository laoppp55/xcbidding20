<%@page import="com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.util.SessionUtil,
                com.xml.Form,
                com.xml.FormPeer" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.xml.IFormManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    String querystr = ParamUtil.getParameter(request, "querystr");
    int seltype = ParamUtil.getIntParameter(request, "seltype", 1);
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 10);
    if (startrow < 0) {
        startrow = 0;
    }

    IFormManager formMgr = FormPeer.getInstance();
    List list = new ArrayList();
    List currentlist = new ArrayList();
    String sqlstr = "";
    if (seltype == 1) {
        sqlstr = "select * from tbl_zhuduijiangji where shetaidanwei like '@" + querystr + "@'";
    } else if (seltype == 2) {
        sqlstr = "select * from tbl_zhuduijiangji where suoshuxitong like '@" + querystr + "@'";
    }

    list = formMgr.getAllDuiJiangJi();
    currentlist = formMgr.getCurrentQureyDuiJiangJiList(sqlstr,startrow, range);

    //int row = 0;
    int rows;
    int totalpages = 0;
    int currentpage = 0;

    //row = currentlist.size();
    rows = formMgr.getAllDuiJiangJiNum();

    if (rows < range) {
        totalpages = 1;
        currentpage = 1;
    } else {
        if (rows % range == 0)
            totalpages = rows / range;
        else
            totalpages = rows / range + 1;

        currentpage = startrow / range + 1;
    }
%>
<HTML>
<HEAD><TITLE>���ߵ��������</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function DelSupplier(id)
        {
            var bln = confirm("���Ҫɾ����");
            if (bln)
            {
                window.location = "delete.jsp?id=" + id;
            }
        }

        function searchcheck() {
            if ((form1.querystr.value == null) || (form1.querystr.value == "")) {
                alert("������Ҫ��ѯ�����ݣ�");
                return false;
            }
            form1.submit();
            return true;
        }
    </SCRIPT>
</HEAD>
<BODY>
<P align=right><FONT color=#0000ff><A href="zhuduijiangji.jsp">����</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <A href="add.jsp">������걨</A></FONT> <BR>

<FORM name=form1 action=query.jsp method=post>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD align=middle width="3%">���</TD>
            <TD align=middle width="10%">��̨��λ</TD>
            <TD align=middle width="15%">����ϵͳ</TD>
            <TD align=middle width="15%">��ַ</TD>
            <TD align=middle width="10%">��ϵ��</TD>
            <TD align=middle width="10%">�绰</TD>
            <TD align=middle width="15%">ʹ�õ���</TD>
            <TD align=middle width="5%">���</TD>
            <TD align=middle width="5%">�޸�</TD>
            <TD align=middle width="5%">ɾ��</TD>
        </TR>
        <%
            if (currentlist != null) {
                for (int i = 0; i < currentlist.size(); i++) {
                    int id = 0;
                    String shetaidanwei = "";
                    String suoshuxitong = "";
                    String address = "";
                    String lianxiren = "";
                    String phone = "";
                    String shiyongdiqu ="";
                    Form form = (Form) currentlist.get(i);
                    id = form.getDjjid();
                    shetaidanwei = form.getShetaidanwei();
                    suoshuxitong = form.getSuoshuxitong();
                    address = form.getAddress();
                    lianxiren = form.getLianxiren();
                    phone = form.getPhone();
                    shiyongdiqu = form.getShiyongdiqu();
        %>
        <TR height=35>
            <TD align=middle width="3%"><%=i + 1%>
            </TD>
            <TD align=middle width="10%"><%=shetaidanwei == null? "--" :shetaidanwei%>
            </TD>
            <TD align=middle width="15%"><%=suoshuxitong == null ? "--" : suoshuxitong%>
            </TD>
            <TD align=middle width="15%"><%=address == null ? "--" : address%>
            </TD>
            <TD align=middle width="10%"><%=lianxiren == null ? "--" : lianxiren%>
            </TD>
            <TD align=middle width="10%"><%=phone == null ? "--" : phone%>
            </TD>
            <TD align=middle width="15%"><%=shiyongdiqu == null ? "--" : shiyongdiqu%>
            </TD>
            <TD align=middle width="5%"><A
                    href="scan.jsp?id=<%=id%>"><IMG
                    src="../images/preview.gif" border=0></A></TD>
            <TD align=middle width="5%"><A
                    href="edit.jsp?id=<%=id%>"><IMG
                    src="../images/dx.gif" border=0></A></TD>
            <TD align=middle width="5%">
                <A href="zhuduijiangji.jsp#" onclick="javascript:return DelSupplier(<%=id%>);">
                    <IMG src="../images/del.gif" border=0></A></TD>
        </TR>
        <%
                }
            }
        %>
        </TBODY>
    </TABLE>
    <BR>
    <BR><BR>

    <p align=right>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD>&nbsp;&nbsp;������<select name="seltype">
                <option value="1">��̨��λ</option>
                <option value="2">����ϵͳ</option>
            </select>
                <input type="text" size=40 name="querystr">&nbsp;&nbsp;<input type="button" value=" �� ѯ "
                                                                              onclick="javascript:return searchcheck();">
            </TD>
        </tr>
        </tbody>
    </table>

</FORM>
</BODY>
</HTML>
