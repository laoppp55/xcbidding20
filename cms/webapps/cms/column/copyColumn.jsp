<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.cms.tree.Tree" %>
<%@ page import="com.bizwink.cms.tree.TreeManager" %>
<%@ page import="com.bizwink.cms.tree.node" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    session.setAttribute("Current_URL",request.getRequestURI());
    int copyflag = ParamUtil.getIntParameter(request, "copyflag", 0);
    if (copyflag == 1) {
        int orgColumnId = ParamUtil.getIntParameter(request, "orgcolumnid", 0);
        int targetColumnId = ParamUtil.getIntParameter(request, "targetcolumnid", 0);
        if ((orgColumnId != 0) && (targetColumnId != 0)) {
            IColumnManager columnMgr = ColumnPeer.getInstance();
            Column column = columnMgr.getColumn(orgColumnId);
            int siteId = column.getSiteID();
            Tree colTree = TreeManager.getInstance().getSiteTree(siteId);
            node[] treenodes = colTree.getAllNodes();
            int[] cid = colTree.getSubTreeColumnIDList(treenodes, orgColumnId);

            String cids = "";
            for (int i = 0; i < cid[0] - 1; i++) {
                cids = cids + cid[i + 1] + ",";
            }
            cids = cids + cid[cid[0]];
            if (cids.length() > 0) {
                columnMgr.copyColumn(cids, targetColumnId);
            }
            response.sendRedirect("index.jsp");
        }
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
</head>
<script language="javascript">
    function checkwhat()
    {
        var strVal = copycolumn.orgcolumnid.value;
        var strVal1 = copycolumn.targetcolumnid.value;

        if (strVal == "")
        {
            alert("Դ��Ŀ����Ϊ�գ���ѡ�񱻸��Ƶ���Ŀ����")
            return false;
        }

        if (strVal1 == "")
        {
            alert("Ŀ����Ŀ����Ϊ�գ���ѡ��Ŀ����Ŀ����")
            return false;
        }

        if (strVal == strVal1)
        {
            alert("Ŀ����Ŀ���ܺ�Դ��Ŀ��ͬ")
            return false;
        }

        return true;
    }

    function cancelit()
    {
        window.location = "index.jsp";
    }

    function selectTColumn(from) {
        win = window.open("selectCopyColumnTree.jsp?f=" + from, "", "width=500,height=400");
        win.focus();
    }
</script>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"��Ŀ����", "copyColumn.jsp"}
    };
    String[][] operations = {
    };
%>
<%@ include file="../inc/titlebar.jsp" %>

<form name="copycolumn" method="Post">
    <input type=hidden name=copyflag value=1>
    <center>
        <table cellpadding="1" cellspacing="1" border="0" width="50%">
            <tr>
                <td width="40%">ԭʼ��Ŀ���ƣ�<input id="orgcolumnname" name="orgcolumnname" size="22" readonly
                                              ondblclick="selectTColumn(0);">(��˫�������ѡ����Ŀ)
                    <input type=hidden id="orgcolumnid" name="orgcolumnid" size="5" readonly></td>
            </tr>
            <tr>
                <td width="40%">Ŀ����Ŀ���ƣ�<input id="targetcolumnname" name="targetcolumnname" size="22" readonly
                                              ondblclick="selectTColumn(1);">(��˫�������ѡ����Ŀ)
                    <input type=hidden id="targetcolumnid" name="targetcolumnid" size="5" readonly></td>
                <td width="20%">
                    <input type=submit value=" ���� " onclick="return checkwhat();">&nbsp;&nbsp;
                    <input type=button value=" ȡ�� " onclick="cancelit();">
                </td>
            </tr>
        </table>
    </center>
</form>
</BODY>
</html>