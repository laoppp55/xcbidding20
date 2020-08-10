<%@ page import="com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../css/cms.css">
    <script type="text/javascript" src="../js/tree.js"></script>
    <script type="text/javascript" src="../js/mtmcode.js"></script>
</head>
<%
    int siteid = authToken.getSiteID();
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    Tree colTree = TreeManager.getInstance().getComapnyTypeTree(siteid);

    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���
    if (colTree.getNodeNum() > 1) {
        node[] treeNodes = colTree.getAllNodes();                     //��ȡ���������нڵ�
        int pid[] = new int[colTree.getNodeNum()];                    //����������Ҫ�Ľڵ����飬�洢��ǰδ����Ľڵ�
        String parentMenuName[] = new String[colTree.getNodeNum()];   //�洢ĳ���ڵ�������ӽڵ�ĸ��˵�����
        String parentMenu = "menu";                                     //�洢��ǰ�ڵ�ĸ��˵�����
        String menuName = "menu";                                     //�洢��ǰ�ڵ�Ĳ˵�����
        int currentID = 0;                                            //��ǰ���ڴ���Ľڵ�
        int i = 0;                                                      //ѭ������
        int[] ordernum = new int[colTree.getNodeNum()];               //��ǰ�ڵ������ӽڵ��˳���
        int orderNumber = 0;                                          //��ǰ�ڵ���ͬ���ڵ��˳���
        int nodenum = 1;                                              //��ǰ������ڵ�ĳ�ʼֵ
        int subflag = 1;                                              //�жϵ�ǰ�ڵ��Ƿ����ӽڵ�

        do {
            currentID = pid[nodenum];

            //���õ�ǰ����ڵ�ĳ�ʼֵ
            if (currentID != 0) {
                parentMenu = parentMenuName[nodenum];
                orderNumber = ordernum[nodenum];
                menuName = "menu" + currentID;
            }

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
                    String name = "<span class=line id=href" + treeNodes[i].getId() + ">" + StringUtil.gb2iso4View(treeNodes[i].getChName()) + "</span>";
                    buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
                    buf.append(name).append("\",\"javascript:go(" + treeNodes[i].getId() + "); oncontextmenu=showmenuie5(" + treeNodes[i].getId() + "," + rightid + ");\",\"cmsleft\"));");
                    buf.append("\n");
                }
            }

            //������ǰ�˵������ĸ��˵�
            if (subflag != 0 && currentID != 0)
                buf.append(parentMenu + ".items[" + orderNumber + "].MTMakeSubmenu(" + menuName + ");\r\n");
        } while (nodenum >= 1);
        //ֱ��pid������û�д�����Ľڵ�Ϊֹ
    }
%>
<script type="text/javascript">
    var needDrag = 0;
    <%=buf.toString()%>
</script>

<BODY <%if (buf.length() > 0) {%> onload="MTMStartMenu(true)"<%}%> leftMargin=0 topMargin=0 MARGINHEIGHT="0"
                                  MARGINWIDTH="0">
<input type=hidden name=justHref id="justHref">

<div id=ie5menu style="width:120px;position:absolute;display:none;">
    <TABLE border=0 cellpadding=0 cellspacing=0 class=Menu width=100% onselectstart="return false;"
           oncontextmenu="return false;" scroll=no>
        <tr>
            <td width=100% class=RightBg>
                <TABLE border=0 cellpadding=0 cellspacing=0 width=100%>
                    <tr id=d01>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;�����б�
                        </td>
                    </tr>
                    <tr id=d02>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;�ϴ��ļ��б�
                        </td>
                    </tr>
                    <tr>
                        <td height=2 align=center>
                            <TABLE border=0 cellpadding=0 cellspacing=0 width=100% height=2>
                                <tr>
                                    <td height=1 class=HrShadow></td>
                                </tr>
                                <tr>
                                    <td height=1 class=HrHighLight></td>
                                </tr>
                            </TABLE>
                        </td>
                    </tr>
                    <tr id=d03>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;����������
                        </td>
                    </tr>
                    <tr id=d04>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;�ѷ�������
                        </td>
                    </tr>
                    <tr id=d05>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;����ʧ������
                        </td>
                    </tr>
                    <tr id=d06>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;���������
                        </td>
                    </tr>
                    <tr id=d07>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;�˸�����
                        </td>
                    </tr>
                    <tr id=d08>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;�鵵����
                        </td>
                    </tr>
                    <tr id=d09>
                        <td height=20 class=MouseOut
                            onMouseOver="this.className='MouseOver';" onMouseOut="this.className='MouseOut';">&nbsp;δ������
                        </td>
                    </tr>
                </TABLE>
            </td>
        </tr>
    </TABLE>
</div>
</BODY>
</html>

<script type="text/javascript">
    function go(columnID)
    {
        var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
        if (isMSIE) {
            if (justHref.value != "" && parent.frames['menu'].document.all(justHref.value))
                parent.frames['menu'].document.all(justHref.value).className = "line";
            parent.frames['menu'].document.all("href" + columnID).className = "sline";
            justHref.value = "href" + columnID;
            parent.frames['cmsright'].location = "companys.jsp?rightid=<%=rightid%>&column=" + columnID;
            return;
        } else {
            if (document.getElementById("justHref").value != "" && window.parent.frames['cmsleft'].document.all("justHref").value)
                window.parent.frames['cmsleft'].document.all("justHref").value.className = "line";
            document.getElementById("justHref").value = "href" + columnID;
            window.parent.frames['cmsright'].location = "companys.jsp?rightid=<%=rightid%>&column=" + columnID;
            return;
        }
    }
</script>