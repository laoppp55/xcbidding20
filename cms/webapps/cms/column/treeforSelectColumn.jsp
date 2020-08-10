<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.register.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%

    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteID = authToken.getSiteID();
    String userid = authToken.getUserID();
    
    int ID = ParamUtil.getIntParameter(request, "ID", 0);
    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    Tree colTree = null;
    if (sitetype == 0 || sitetype == 2) {                             //0��ʾ�Լ���������վ��2��ʾ��������ģ����վ
        if (!userid.equalsIgnoreCase("admin") && !SecurityCheck.hasPermission(authToken, 54)) {
            //��ͨ�û�
            List clist = new ArrayList();
            Iterator iter1 = authToken.getPermissionSet().elements();
            while (iter1.hasNext()) {
                Permission permission = (Permission) iter1.next();
                if (rightid == permission.getRightID()) {
                    clist = permission.getColumnListOnRight();
                    break;
                }
            }
            //System.out.println("up=" + clist.size());
            colTree = TreeManager.getInstance().getUserTree(userid, siteid, clist,rightid);
        } else if (!userid.equalsIgnoreCase("admin") && SecurityCheck.hasPermission(authToken, 54)) {
            //վ�����Ա
            colTree = TreeManager.getInstance().getSiteTree(siteid);
        }
    } else {
        if (!userid.equalsIgnoreCase("admin") && !SecurityCheck.hasPermission(authToken, 54)) {
            //��ͨ�û�
            List clist = new ArrayList();
            Iterator iter1 = authToken.getPermissionSet().elements();
            while (iter1.hasNext()) {
                Permission permission = (Permission) iter1.next();
                if (rightid == permission.getRightID()) {
                    clist = permission.getColumnListOnRight();
                    //System.out.println("down" + clist.size());
                    break;
                }
            }
            colTree = TreeManager.getInstance().getUserTreeIncludeSampleSiteColumn(userid, siteid,samsiteid,clist);
        } else if (!userid.equalsIgnoreCase("admin") && SecurityCheck.hasPermission(authToken, 54)) {
            //վ�����Ա
            colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
        }
    }

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
    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���

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
                //String cname = new String(treeNodes[i].getChName().getBytes("ISO8859-1"), "GBK");
                String cname = StringUtil.gb2iso4View(treeNodes[i].getChName());
                String name = "<font class=line>" + cname + "</font>";
                buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
                buf.append(name).append("\",\"javascript:parent.frames['cmsleft'].abc('" + ID + "','" + treeNodes[i].getId() + "','" + StringUtil.replace(cname, "'", "`") + "')\"" + ", \"cmsright\"));");
                buf.append("\n");
            }
        }

        //������ǰ�˵������ĸ��˵�
        if (subflag != 0 && currentID != 0)
            buf.append(parentMenu + ".items[" + orderNumber + "].MTMakeSubmenu(" + menuName + ");\r\n");

    } while (nodenum >= 1);
    //ֱ��pid������û�д�����Ľڵ�Ϊֹ
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <LINK href="../style/global.css" type=text/css rel=stylesheet>
    <script type="text/javascript">
        function abc(par, par1, par2)
        {
            par2 = par2.replace("`", "'");
            var el = parent.frames['cmsright'].form1.columnList;
            var oOption = document.createElement("OPTION");
            oOption.text = par2;
            oOption.value = par1;
            optionLen = el.options.length;
            i = 0;
            var endFlag = true;

            if (par == par1)
            {
                endFlag = false;
                alert("��������������Ŀ�����£�");
            }

            while (( i < optionLen) && endFlag)
            {
                if (el.options(i).value == oOption.value)
                {
                    endFlag = false;
                    alert("�벻Ҫ�ظ�ѡ����Ŀ��");
                }
                i++;
            }

            if (endFlag) {
                el.add(oOption);
                parent.frames['cmsright'].form1.columnSubmit.disabled = false;
                parent.frames['cmsright'].form1.delColumn.disabled = false;
            }
        }
    </script>
</head>
<script type="text/javascript" src="../js/mtmcode.js"></script>
<script type="text/javascript">
    var needDrag = 0;
    <%=buf.toString()%>
</script>

<BODY onload="MTMStartMenu(true)" leftMargin=0 topMargin=0 MARGINHEIGHT="0" MARGINWIDTH="0">
</BODY>
</html>