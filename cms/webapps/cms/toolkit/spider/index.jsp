<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*"%>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.collectionmgr.*" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    IBasic_AttributesManager ibaMgr = Basic_AttributesPeer.getInstance();

    int totalPage;
    int currentPage = ParamUtil.getIntParameter(request, "currentPage", 1);

    int range = 14;
    int start = (currentPage - 1) * range;
    int rows = ibaMgr.getMaxColumn();

    if (rows % range > 0) {
        totalPage = rows / range + 1;
    } else if (rows == 0) {
        totalPage = 1;
    } else {
        totalPage = rows / range;
    }
    List battr = ibaMgr.getBasic_Attributes(start, range);
%>
<html>
<head>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="css/manager.css" type=text/css rel=stylesheet>
    <META content="MSHTML 6.00.6000.16525" name=GENERATOR>
</head>

<body>
<TABLE class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
    <tbody>
        <input name="currentPage" type="hidden" value=<%=currentPage%>>
        <tr>
            <td colspan="3" class=title>վ��</td>
        </tr>
        <tr>
            <td width="15%" align="center"><strong>վ�����</strong></td>
            <td align="center"><strong>վ������</strong></td>
            <td align="center" width="40%"><strong>����</strong></td>
        </tr>
        <%
            for (int i = 0; i < battr.size(); i++) {
                Basic_Attributes ba = (Basic_Attributes) battr.get(i);
                int stopflag = ba.getStopflag();
        %>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td width="15%">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td align="left">վ��&nbsp;<%=ba.getId()%>
                        </td>
                        <td align="right">
                            <%
                                if (ba.getLoginflag() == 1) out.println("<img src=\"images/rz.gif\" alt=\"��Ҫ��֤վ��\">");
                                if (ba.getProxyflag() == 1) out.println("<img src=\"images/dl.gif\" alt=\"������������\">");
                            %>
                        </td>
                    </tr>
                </table>
            </td>
            <td><a href="viewSites.jsp?basicId=<%=ba.getId()%>">
                <%=ba.getSiteName() == null ? "" : new String(ba.getSiteName().getBytes("GBK"), "GBK")%></a>
            </td>
            <td align="center">
                <%if(stopflag==0){%><a href="setSites.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>&sf=1">��Ч</a>&nbsp;|&nbsp;<%}else{%><a href="setSites.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>&sf=0"><font color="red">��Ч</font></a>&nbsp;|&nbsp;<%}%>
                <a href="viewSites.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>">�鿴</a>&nbsp;|&nbsp;
                <a href="editSites.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>">�޸�</a>&nbsp;|&nbsp;
                <a href="characterCode.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>">������</a>&nbsp;|&nbsp;
                <a href="matchUrl.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>">ƥ��URL</a>&nbsp;|&nbsp;
                <a href="delSites.jsp?basicId=<%=ba.getId()%>&pageid=<%=currentPage%>" onClick="return confirm('ȷ��Ҫɾ����');">ɾ��</a>
            </td>
        </tr>
        <%}%>
        <TR>
            <TD class=title5 colSpan=3>
                <a href="addSites.jsp">���վ��</a></TD>
        </TR>
        <TR>
            <TD colSpan=5>
                <TABLE cellPadding=4 width="100%" align=right border=0>
                    <TBODY>
                        <TR>
                            <td align="center">
                                <img src="images/rz.gif">&nbsp;��Ҫ��֤վ��&nbsp;&nbsp;&nbsp;&nbsp;
                                <img src="images/dl.gif">&nbsp;������������
                            </td>
                            <TD align=left>
                                <P align=right>
                                    <a href="index.jsp?currentPage=1">��ҳ</a>
                                    <%if (currentPage != 1) {%>
                                    <a href=index.jsp?currentPage=<%=currentPage - 1%>>��һҳ</a>
                                    <%}%>
                                    <%if (currentPage != totalPage) {%>
                                    <a href=index.jsp?currentPage=<%=currentPage + 1%>>��һҳ</a>
                                    <%}%>
                                    <A href="index.jsp?currentPage=<%=totalPage%>">βҳ</A>
                                    ҳ�Σ�<FONT color=#ff0000><%=currentPage%>/<%=totalPage%>
                                </FONT>ҳ ����<FONT color=#ff0000><%=rows%>
                                </FONT>����¼ ת��
                                    <select name="turn"
                                            onchange="window.location='index.jsp?currentPage='+document.all('turn').value">
                                        >
                                        <%
                                            for (int i = 1; i <= totalPage; i++) {
                                        %>
                                        <option value="<%=i%>" <%if (i == currentPage) {%> selected<%}%>><%=i%>
                                        </option>
                                        <%}%>
                                    </select>ҳ
                                </P>
                            </TD>
                        </TR>
                    </TBODY>
                </TABLE>
            </TD>
        </TR>

    </tbody>
</table>
</body>
</html>
