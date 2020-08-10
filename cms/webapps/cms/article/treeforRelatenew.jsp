<%@ page import="com.bizwink.cms.news.ArticlePeer,
                 com.bizwink.cms.news.IArticleManager,
                 com.bizwink.cms.security.Auth,
                 com.bizwink.cms.tree.Tree,
                 com.bizwink.cms.tree.TreeManager" contentType="text/html;charset=GBK"%>
<%@ page import="com.bizwink.cms.tree.node" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int pushArticle = authToken.getPushArtile();
    IArticleManager articleMgr = ArticlePeer.getInstance();
    int articleid = ParamUtil.getIntParameter(request, "articleid", 0);
    String maintitle = articleMgr.getArticle(articleid).getMainTitle();
    maintitle = StringUtil.gb2iso4View(maintitle);
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../style/global.css">
    <script type="text/javascript" src="../js/mtmcode.js"></script>
    <script type="text/javascript">
        function addRelatedColumn(par1, par2)
        {
            var tableobj = parent.frames['cmsright'].markForm.document.getElementById("relatearticle");
            var rowobj = tableobj.insertRow(tableobj.rows.length);

            var cell1 = rowobj.insertCell(rowobj.cells.length);
            var cell2 = rowobj.insertCell(rowobj.cells.length);
            var cell3 = rowobj.insertCell(rowobj.cells.length);
            var cell4 = rowobj.insertCell(rowobj.cells.length);

            cell1.innerHTML = "<input name=columnid" + (tableobj.rows.length - 1) + " type='text' value='" + par2 + "' readonly>";
            cell2.innerHTML = par1 + "<input type=hidden name=columnname" + (tableobj.rows.length - 1) + " value='" + par1 + "'>";
            cell3.innerHTML = "<input name=maintitle" + (tableobj.rows.length - 1) + " type='text' value='<%=maintitle%>'>";
            cell4.innerHTML = "<input type='button' value='ɾ��' onclick='delete_row(" + (tableobj.rows.length - 1) + ");leo()'>";
        }
        var needDrag = 0;
    </script>
</head>
<%
    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();
    int modeltype = ParamUtil.getIntParameter(request, "modeltype", 0);
    Tree colTree = null;
    if (sitetype == 0 || sitetype == 2)                              //0��ʾ�Լ���������վ��2��ʾ��������ģ����վ
        colTree = TreeManager.getInstance().getSiteTree(siteid);
    else                                                             //1��ʾ����ģ����վ����Ŀ��ģ��
        colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
    node[] treeNodes = colTree.getAllNodes();                       //��ȡ���������нڵ�
    int pid[] = new int[colTree.getNodeNum()];                        //����������Ҫ�Ľڵ����飬�洢��ǰδ����Ľڵ�
    String parentMenuName[] = new String[colTree.getNodeNum()];       //�洢ĳ���ڵ�������ӽڵ�ĸ��˵�����
    String parentMenu = "menu";                                     //�洢��ǰ�ڵ�ĸ��˵�����
    String menuName = "menu";                                     //�洢��ǰ�ڵ�Ĳ˵�����
    int currentID = 0;                                            //��ǰ���ڴ���Ľڵ�
    int i = 0;                                                      //ѭ������
    int[] ordernum = new int[colTree.getNodeNum()];                   //��ǰ�ڵ������ӽڵ��˳���
    int orderNumber = 0;                                          //��ǰ�ڵ���ͬ���ڵ��˳���
    int nodenum = 1;                                              //��ǰ������ڵ�ĳ�ʼֵ
    int subflag = 1;                                              //�жϵ�ǰ�ڵ��Ƿ����ӽڵ�
    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���

    do {
        currentID = pid[nodenum];

        //���õ�ǰ����ڵ�ĳ�ʼֵ
        if (currentID != 0) {
            parentMenu = parentMenuName[nodenum];
            orderNumber = ordernum[nodenum];
            menuName = "menu" + currentID;
        }

        out.println("<table class=line width=100% border=0 cellspacing=0 cellpadding=0>");
        out.println("<tr bgcolor=#003366><td height=2 colspan=2></td></tr>");

        //�Ӵ���Ľڵ�������ȡ����ǰ���ڴ����Ԫ�أ����Ҹ�Ԫ���µ���Ԫ��
        //���������ӽڵ�ĸ��˵����ƣ����������ӽڵ�����кţ������е��ӽڵ����pid������
        subflag = 0;
        nodenum = nodenum - 1;
        for (i = 0; i < colTree.getNodeNum(); i++) {
            if (treeNodes[i].getLinkPointer() == currentID) {
                nodenum = nodenum + 1;
                pid[nodenum] = treeNodes[i].getId();
                parentMenuName[nodenum] = menuName;
                ordernum[nodenum] = subflag;
                subflag = subflag + 1;
            }
        }

        //�����ǰ�ڵ����ӽڵ㣬���ɵ�ǰ�ڵ�Ĳ˵�
        if (subflag != 0) {
            buf.append("var " + menuName + " = null;\n");
            buf.append(menuName + " = new MTMenu();\n");
        }
        for (i = 0; i < colTree.getNodeNum(); i++) {
            if (treeNodes[i].getLinkPointer() == currentID) {
                String cname = StringUtil.gb2iso4View(treeNodes[i].getChName());
                String name = "<font class=line>" + StringUtil.gb2iso4View(treeNodes[i].getChName()) + "</font>";
                buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
                buf.append(name).append("\",\"javascript:parent.frames['cmsleft'].addRelatedColumn('" + StringUtil.replace(cname, "'", "`") + "','" + treeNodes[i].getId() + "')\", \"\"));");
                buf.append("\n");
            }
        }

        //������ǰ�˵������ĸ��˵�
        if (subflag != 0 && currentID != 0)
            buf.append(parentMenu + ".items[" + orderNumber + "].MTMakeSubmenu(" + menuName + ");\r\n");
    } while (nodenum >= 1);
    //ֱ��pid������û�д�����Ľڵ�Ϊֹ
%>

<script type="text/javascript">
    var needDrag = 0;
    <%=buf.toString()%>
</script>

<BODY onload="MTMStartMenu(true)" leftMargin=0 topMargin=0 MARGINHEIGHT="0" MARGINWIDTH="0">
</BODY>
</html>