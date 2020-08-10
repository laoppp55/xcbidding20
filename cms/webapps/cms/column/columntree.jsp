<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript" src="../js/maintree.js"></script>

<STYLE>
BODY {
    FONT-SIZE: 12px;
    MARGIN: 10px 0px 0px;
    FONT-FAMILY: "����"
}

.skin0 {
    BORDER-RIGHT: black 2px solid;
    BORDER-TOP: black 2px solid;
    VISIBILITY: hidden;
    BORDER-LEFT: black 2px solid;
    WIDTH: 100px;
    CURSOR: default;
    LINE-HEIGHT: 20px;
    PADDING-TOP: 4px;
    BORDER-BOTTOM: black 2px solid;
    FONT-FAMILY: "����";
    POSITION: absolute;
    BACKGROUND-COLOR: menu;
    TEXT-ALIGN: left
}

.skin1 {
    BORDER-RIGHT: buttonhighlight 2px outset;
    BORDER-TOP: buttonhighlight 2px outset;
    FONT-SIZE: 10pt;
    VISIBILITY: hidden;
    BORDER-LEFT: buttonhighlight 2px outset;
    WIDTH: 100px;
    CURSOR: default;
    PADDING-TOP: 4px;
    BORDER-BOTTOM: buttonhighlight 2px outset;
    FONT-FAMILY: "����";
    POSITION: absolute;
    BACKGROUND-COLOR: menu;
    TEXT-ALIGN: left
}

.menuitems {
    PADDING-RIGHT: 1px;
    PADDING-LEFT: 10px;
    PADDING-BOTTOM: 2px;
    PADDING-TOP: 2px
}
</STYLE>

<SCRIPT language=javascript>
    <!--
    //����˵���ʾ����ۣ����Դ����涨���2�ָ�ʽ��ѡ����һ
    var menuskin = "skin0";
    //�Ƿ�����������ڵ�״̬������ʾ�˵���Ŀ����Ӧ�������ַ���
    var display_url = false;

    function getEvent() {     //ͬʱ����ie��ff��д��
        if (document.all)    return window.event;
        func = getEvent.caller;
        while (func != null) {
            var arg0 = func.arguments[0];
            if (arg0) {
                if ((arg0.constructor == Event || arg0.constructor == MouseEvent)
                        || (typeof(arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
                    return arg0;
                }
            }
            funcfunc = func.caller;
        }
        return null;
    }

    function showmenuie5(columnid,rightid) {
        //��ȡ��ǰ����Ҽ����º��λ�ã��ݴ˶���˵���ʾ��λ��
        var event = arguments[0] || window.event;
        var rightedge = document.body.clientWidth - event.clientX;
        var bottomedge = document.body.clientHeight - event.clientY;

        //��������λ�õ������ұߵĿռ�С�ڲ˵��Ŀ�ȣ��Ͷ�λ�˵��������꣨Left��Ϊ��ǰ���λ������һ���˵����
        if (rightedge < ie5menu.offsetWidth)
            ie5menu.style.left = document.body.scrollLeft + event.clientX - ie5menu.offsetWidth;
        else
        //���򣬾Ͷ�λ�˵���������Ϊ��ǰ���λ��
            ie5menu.style.left = document.body.scrollLeft + event.clientX;

        //��������λ�õ������±ߵĿռ�С�ڲ˵��ĸ߶ȣ��Ͷ�λ�˵��������꣨Top��Ϊ��ǰ���λ������һ���˵��߶�
        if (bottomedge < ie5menu.offsetHeight)
            ie5menu.style.top = document.body.scrollTop + event.clientY - ie5menu.offsetHeight;
        else
        //���򣬾Ͷ�λ�˵���������Ϊ��ǰ���λ��
            ie5menu.style.top = document.body.scrollTop + event.clientY;

        //���ò˵��ɼ�
        ie5menu.style.visibility = "visible";
        return false;
    }
    function hidemenuie5() {
        //���ز˵�
        //�ܼ򵥣�����visibilityΪhidden��OK��
        ie5menu.style.visibility = "hidden";
    }

    function highlightie5(evt) {
        //��������꾭���Ĳ˵�����Ŀ

        //�����꾭���Ķ�����menuitems�����������ñ���ɫ��ǰ��ɫ
        //event.srcElement.className��ʾ�¼����Զ�������ƣ����������ж����ֵ�������Ҫ��
        var event = evt || window.event;
        var element = event.srcElement || event.target;
        if (element.className == "menuitems") {
            element.style.backgroundColor = "highlight";
            element.style.color = "white";

            //��������Ϣ��ʾ��״̬��
            //event.srcElement.url��ʾ�¼����Զ����ʾ������URL
            if (display_url)
                window.status = event.srcElement.url;
        }
    }

    function lowlightie5(evt) {
        //�ָ��˵�����Ŀ��������ʾ
        var event = evt || window.event;
        var element = event.srcElement || event.target;
        if (element.className == "menuitems") {
            element.style.backgroundColor = "";
            element.style.color = "black";
            //window.status = "";
        }
    }

    //�Ҽ������˵�������ת
    function jumptoie5(evt) {
        //ת���µ�����λ��
        var event = evt || window.event;
        var element = event.srcElement || event.target;
        //var seltext=window.document.selection.createRange().text
        if (element.className == "menuitems") {
            //������ڴ����ӵ�Ŀ�괰�ڣ������Ǹ������д�����
            if (element.getAttribute("target") != null)
            {
                window.open(element.getAttribute("url"), element.getAttribute("target"));
            }
            else
            //�����ڵ�ǰ���ڴ�����
                window.location = element.getAttribute("url");
        }
    }
    //-->
</SCRIPT>
</head>
<%
    session.setAttribute("Current_URL",request.getRequestURI());
    String userid = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int rightid = ParamUtil.getIntParameter(request, "rightid", 54);
    Tree colTree = null;

    if (!userid.equalsIgnoreCase("admin") && !SecurityCheck.hasPermission(authToken, 54)) {
        //��ͨ�û�
        List clist = new ArrayList();
        PermissionSet p_set = authToken.getPermissionSet();
        Iterator iter1 = p_set.elements();
        while (iter1.hasNext()) {
            Permission permission = (Permission) iter1.next();
            if (rightid == permission.getRightID()) {
                clist = permission.getColumnListOnRight();
                break;
            }
        }
        colTree = TreeManager.getInstance().getUserTree(userid, siteid, clist,rightid);
    } else if (!userid.equalsIgnoreCase("admin") && SecurityCheck.hasPermission(authToken, 54)) {
        //վ�����Ա
        colTree = TreeManager.getInstance().getSiteTree(siteid);
        //colTree = TreeManager.getInstance().getIndustryClassTree();
    }

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
<input type=hidden name=justHref>

<DIV class=skin0 id=ie5menu onmouseover=highlightie5(event) onclick=jumptoie5(event); onmouseout=lowlightie5(event)>
    <DIV class=menuitems url="javascript:go(1);">�½���Ŀ</DIV>
    <DIV class=menuitems url="javascript:go(2);">�޸���Ŀ</DIV>
    <DIV class=menuitems url="javascript:go(3);">ɾ����Ŀ</DIV>
    <DIV class=menuitems url="javascript:go(4);">�ļ�����</DIV>
</DIV>

<select language=javascript>
    function go(flag)
    {
        if (flag == 1) {
            window.open("createcolumn.jsp?parentID=" + columnID,"","width=600,height=500,left=100,top=100");
        } else if (flag == 2) {
            window.open("editcolumn.jsp?ID=" + columnID,"","width=600,height=500,left=100,top=100");
        } else if (flag == 3) {
            window.open("removecolumn.jsp?ID=" + columnID,"","width=600,height=500,left=100,top=100");
        } else if (flag == 4) {
            window.open("/webbuilder/webedit/index.jsp?column=" + columnID + "&right=4","","width=850,height=600,left=5,top=5");
        }
    }
</select>

<SCRIPT language=JavaScript1.2>
    //�����ǰ�������Internet Explorer��document.all�ͷ�����

    //ѡ��˵��������ʾ��ʽ
    //ie5menu=document.getElementById("ie5menu");
    ie5menu.className = menuskin;

    //�ض�������Ҽ��¼��Ĵ������Ϊ�Զ������showmenuie5
    //document.getElementById("test").oncontextmenu = showmenuie5;
    //document.getElementById("test1").oncontextmenu = showmenuie5;

    //�ض����������¼��Ĵ������Ϊ�Զ������hidemenuie5
    document.body.onclick = hidemenuie5;

</SCRIPT>
</BODY>
</html>