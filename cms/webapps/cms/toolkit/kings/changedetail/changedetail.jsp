<%@page import="com.bizwink.cms.kings.changedetail.ChangeDetail,
                com.bizwink.cms.kings.changedetail.ChangeDetailPeer,
                com.bizwink.cms.kings.changedetail.IChangeDetailManager,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteid = authToken.getSiteID();
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    if (startrow < 0) {
        startrow = 0;
    }

    IChangeDetailManager chadMgr = ChangeDetailPeer.getInstance();
    List list = new ArrayList();
    List currentlist = new ArrayList();

    currentlist = chadMgr.getCurrentChangeDetailList(siteid, startrow, range);

    int rows;
    int totalpages = 0;
    int currentpage = 0;

    rows = chadMgr.getAllChangeDetailNum(siteid);

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
<HEAD><TITLE>����䶯����ϸ��</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function DelChanges(changeid)
        {
            var bln = confirm("���Ҫɾ����");
            if (bln)
            {
                window.location = "delete.jsp?changeid=" + changeid;
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
<P align=right><FONT color=#0000ff><a href="../supplier/index.jsp">����</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <A href="add.jsp">��Ӵ���䶯</A></FONT> <BR>

<FORM name=form1 action=query.jsp method=post>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD align=middle width="5%">���</TD>
            <TD align=middle width="15%">�䶯������</TD>
            <TD align=middle width="8%">��Ʒ���</TD>
            <TD align=middle width="10%">�䶯����</TD>
            <TD align=middle width="9%">�䶯���</TD>
            <TD align=middle width="5%">�޸�</TD>
            <TD align=middle width="5%">ɾ��</TD>
        </TR>
        <%
            if (currentlist != null) {
                for (int i = 0; i < currentlist.size(); i++) {
                    int id = 0;
                    String changeid;
                    String productid;
                    String changequantity;
                    String changeamount;
                    ChangeDetail cd = (ChangeDetail) currentlist.get(i);
                    changeid = cd.getChangeID();
                    productid = Integer.toString(cd.getProductID());
                    changequantity = Integer.toString(cd.getChangeQuantity());
                    changeamount = Integer.toString(cd.getChangeAmount());
        %>
        <TR height=35>
            <TD align=middle width="3%"><%=i + 1%>
            </TD>
            <TD align=middle width="15%"><%=changeid == null ? "--" : changeid%>
            </TD>
            <TD align=middle width="8%"><%=productid == null ? "--" : productid%>
            </TD>
            <TD align=middle width="10%"><%=changequantity == null ? "--" : changequantity%>
            </TD>
            <TD align=middle width="20%"><%=changeamount == null ? "--" : changeamount%>
            </TD>
            <TD align=middle width="5%"><A
                    href="edit.jsp?changeid=<%=changeid%>"><IMG
                    src="../images/dx.gif" border=0></A></TD>
            <TD align=middle width="5%">
                <A href="changedetail.jsp#" onclick="javascript:return DelChanges('<%=changeid%>');">
                    <IMG src="../images/del.gif" border=0></A></TD>
        </TR>
        <%
                }
            }
        %>
        </TBODY>
    </TABLE>
    <BR>

    <p align=center>
    <TABLE>
        <TBODY>
        <TR>
            <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp; ��<%=rows%>��&nbsp;&nbsp; ��ǰ��<%=currentpage%>ҳ&nbsp;
                <%
                    if ((startrow - range) >= 0) {
                %>
                <a href="changedetail.jsp?startrow=0">��һҳ</a>
                <%}%>
                <%if ((startrow - range) >= 0) {%>
                <a href="changedetail.jsp?startrow=<%=startrow-range%>">��һҳ</a>
                <%}%>
                <%if ((startrow + range) < rows) {%>
                <A href="changedetail.jsp?startrow=<%=startrow+range%>">��һҳ</A>
                <%}%>
                <%if (currentpage != totalpages) {%>
                <A href="changedetail.jsp?startrow=<%=(totalpages-1)*range%>">���һҳ</A>
                <%}%>
            </TD>
            <TD>&nbsp;</TD>
        </TR>
        </TBODY>
    </TABLE>
    <BR><BR>

    <p align=right>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD>&nbsp;&nbsp;������<select name="seltype">
                <option value="1">�䶯������</option>
                <option value="2">��Ʒ���</option>
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
