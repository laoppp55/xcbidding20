<%@ page import="com.bizwink.collectionmgr.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int basicId = ParamUtil.getIntParameter(request, "basicId", -1);
    IMatchUrl_SpecialCodeManager iMuScMgr = MatchUrl_SpecialCodePeer.getInstance();
    List spCodeList = iMuScMgr.getSpCode(basicId);
%>
<html>
<head>
    <META http-equiv=Content-Type content="text/html; charset=GBK">
    <LINK href="css/manager.css" type=text/css rel=stylesheet>
    <META content="MSHTML 6.00.6000.16525" name=GENERATOR>
</head>

<body>
<form name="scList"action="">
    <TABLE class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <tbody>
            <tr>
                <td class=title colspan="4">�������</td>
            </tr>
            <tr>
                <td align="center" width="10%%"><strong>���������к�</strong></td>
                <td align="center"><strong>��ʼ������</strong></td>
                <td align="center"><strong>����������</strong></td>
                <td align="center" width="10%"><strong>����</strong></td>
            </tr>
            <%
                for (int i = 0; i < spCodeList.size(); i++) {
                    MatchUrl_SpecialCode muSc;
                    muSc = (MatchUrl_SpecialCode) spCodeList.get(i);
                    String st=muSc.getSt();
                    if(st!=null) st=st.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                    else st="";
                    String et=muSc.getEt();
                    if(et!=null)et=et.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                    else et="";
            %>
            <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
                onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
                <td><%=muSc.getSc_id()%>
                </td>
                <td><%=st %>
                </td>
                <td><%=et%>
                </td>
                <td>
                    <a href="editMuSc.jsp?sc_id=<%=muSc.getSc_id()%>&basicId=<%=basicId%>">�޸�</a>&nbsp;|
                    <a href="delMuSc.jsp?sc_id=<%=muSc.getSc_id()%>&basicId=<%=basicId%>"
                       onClick="return confirm('ȷ��Ҫɾ����');">ɾ��</a>&nbsp;
                </td>
            </tr>
            <%}%>
            <tr>
                <td colspan=4 align="right" class="title5">
                    <a href="addMuSc.jsp?flag=1&basicId=<%=basicId%>">����������</a>&nbsp;|&nbsp;
                    <a href="index.jsp">������ﷵ��</a>
                </td>
            </tr>
        </tbody>
    </table>
</form>
</body>
</html>