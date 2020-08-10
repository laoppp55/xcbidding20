<%@ page import="java.sql.*,
                 com.bizwink.wenba.*,
                 com.bizwink.cms.audit.*,
                 java.util.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String userid = authToken.getUserID();
    int siteid = authToken.getSiteID();
    Tree colTree = TreeManager.getInstance().getWenbaTree();

    final String TREE_ROOT = "<img src=../../images/home.gif align=bottom border=0>";
    final String TREE_LINE = "<img src=../../images/t1.gif align=top border=0>";
    final String TREE_FORK = "<img src=../../images/t3.gif align=top border=0>";
    final String TREE_NODE = "<img src=../../images/node.gif align=bottom border=0>&nbsp";
    final String COLUMN_DEL = "<img src=../../images/button/del.gif align=bottom border=0 alt=\"ɾ����Ŀ\">";
    final String COLUMN_EDIT = "<img src=../../images/button/edit.gif align=middle border=0 alt=\"�޸���Ŀ\">";
    final String COLUMN_ADD = "<img src=../../images/new.gif align=middle border=0 alt=\"�½���Ŀ\">";
    final String TYPE_ADD = "<img src=../../images/new.gif align=middle border=0 alt=\"��ӷ���\">";

    IWenbaManager columnMgr = wenbaManagerImpl.getInstance();
    wenbaImpl column = null;
    node[] treeNodes = colTree.getAllNodes();                     //��ȡ���������нڵ�
    int pid[] = new int[colTree.getNodeNum()];                    //����������Ҫ�Ľڵ����飬�洢��ǰδ����Ľڵ�
    int nodenum = 1;                                              //��ǰ������ڵ�ĳ�ʼֵ
    int level = 0;                                                //�жϵ�ǰ�ڵ��Ƿ����ӽڵ�
    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���
    int childCount = 0;
    String tree = "";
    int ID = 0;
    int lineNr = 0;
    int treeRoot = colTree.getTreeRoot();
    int currentID = treeRoot;                                     //��ǰ���ڴ���Ľڵ�

    do {
        tree = "";
        //�Ӵ���Ľڵ�������ȡ����ǰ���ڴ����Ԫ�أ����Ҹ�Ԫ���µ���Ԫ��
        nodenum = nodenum - 1;

        for (int i = colTree.getNodeNum() - 1; i >= 0; i--) {
            if (treeNodes[i].getLinkPointer() == currentID) {
                nodenum = nodenum + 1;
                pid[nodenum] = treeNodes[i].getId();
            }
        }

        try {
            column = columnMgr.getColumn(currentID);
            if (column.getParentID() >= 0) {
                level = colTree.getNodeDepth(colTree, currentID);
                childCount = colTree.getChildCount(colTree, currentID);

                ID = column.getID();
                String CName = StringUtil.gb2iso4View(column.getCName());
                String EName = column.getEName();
                int orderid = column.getOrderID();
                String bgcolor = ((lineNr++ & 1) != 0) ? "#ffffff" : "#eeeeee";

                for (int i = 0; i < level - 1; i++)
                    tree = tree + TREE_LINE;
                tree = tree + TREE_FORK + TREE_NODE;

                buf.append("<tr height=20 class='menu' bordercolor='black' id='choice1'");
                buf.append(" onmouseover='movein(this)' ");
                buf.append(" onmouseout=\"moveout(this,'").append(bgcolor).append("')\"");
                buf.append(" bgcolor=").append(bgcolor).append(">\n");
                buf.append("<td width='52%' height=20>");
                buf.append(tree);

                buf.append("<a href='editcolumn.jsp?ID=").append(column.getID());
                buf.append("'>");

                buf.append(CName);
                buf.append("</a>");
                buf.append("</td>").append("\n");

                buf.append("<td width='16%' align=left>");
                buf.append("&nbsp;" + EName);
                buf.append("</td>").append("\n");

                buf.append("<td width='5%' align=center>");
                buf.append(orderid);
                buf.append("</td>").append("\n");

                buf.append("<td width='5%' align=center>");
                buf.append("<a href='editcolumn.jsp?ID=").append(ID);
                buf.append("'>");
                buf.append(COLUMN_EDIT);
                buf.append("</a></td>").append("\n");

                buf.append("<td width='5%' align=center>");
                buf.append("<a href='createcolumn.jsp?parentID=").append(ID);
                buf.append("'>");
                buf.append(COLUMN_ADD);
                buf.append("</a></td>").append("\n");
                /*buf.append("<td width='5%' align=center>");
                buf.append("<a href='javascript:createtype("+ID+")");
                buf.append("'>");
                buf.append(COLUMN_ADD);
                buf.append("</a></td>").append("\n");*/

                buf.append("<td width='5%' align=center>");
                if (childCount == 0) {
                    buf.append("<a href='removecolumn.jsp?ID=" + ID + "'\">");
                    buf.append(COLUMN_DEL + "</a>");
                } else {
                    buf.append("&nbsp;");
                }
                buf.append("</td>").append("\n");

                buf.append("</tr>\n");
            }
        }
        catch (wenbaException e) {
            e.printStackTrace();
        }
        currentID = pid[nodenum];
    } while (nodenum > 0);

    //System.out.println(buf.toString());
    //ֱ��pid������û�д�����Ľڵ�Ϊֹ

    int msgno = ParamUtil.getIntParameter(request, "msgno", -1);
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../../style/global.css">
    <script language="javascript">
        function window_add(columnID)
        {
            var winStr = "add_column_audit.jsp?columnID=" + columnID;
            var retval = showModalDialog(winStr, "column_audit_rules_add",
                    "font-family:Verdana; font-size:12; dialogWidth:37em; dialogHeight:30em; status=no");
            if (retval == "ok") history.go(0);
        }

        function window_update(columnID)
        {
            var winStr = "update_column_audit.jsp?columnID=" + columnID;
            var retval = showModalDialog(winStr, "column_audit_rules_update",
                    "font-family:Verdana; font-size:12; dialogWidth:37em; dialogHeight:30em; status=no");
            if (retval == "ok") history.go(0);
        }

        function window_alert()
        {
            alert("û����Ȩ�û����������ӵ��<�������>Ȩ�޵��û���");
        }

        function movein(which)
        {
            which.style.background = '#CECEFF';
        }

        function moveout(which, color)
        {
            which.style.background = color;
        }

        function EditAttr()
        {
            window.open("editattr.jsp?ID=<%=treeRoot%>&from=1", "", "width=600,height=400,left=200,right=200,scrollbars,status");
        }
        function createtype()
        {
            window.open("createnewtype.jsp?from=1", "", "width=600,height=400,left=200,right=200,scrollbars,status");
        }
    </script>
</head>
<BODY BGCOLOR="#ffffff" LINK="#000099" ALINK="#cc0000" VLINK="#000099" TOMARGIN=8>
<center>
    <%
        String[][] titlebars = {
                {"��ҳ", ""},
                {"�ʰɷ������", ""}
        };
        String[][] operations = new String[][] {
                    {"�½�����", "createcolumn.jsp?parentID=" + treeRoot}
            };
    %>
    <%@ include file="../../inc/titlebar.jsp" %>
    <%
        if (msgno == 0)
            out.println("<span class=cur>�·��ഴ���ɹ�</span>");
        else if (msgno == -1)
            out.println("<span class=cur></span>");
        else
            out.println("<span class=cur>�·��ഴ��ʧ��</span>");
    %>
    <table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='100%'>
        <tr class=tine bgcolor="#dddddd" height=20>
            <td width='52%'>&nbsp;<%=TREE_ROOT%>&nbsp;<%=treeNodes[0].getEnName()%>
            </td>
            <td align=center width='28%'>Ŀ¼��</td>
            <td align=center width='5%'>��Ŀ����</td>
            <td align=center width='5%'>�޸�</td>
            <td align=center width='5%'>�½�</td>
            <td align=center width='5%'>ɾ��</td>
        </tr>
        <%
            out.println(buf.toString());
        %>
    </table>
</center>
</BODY>
</html>
