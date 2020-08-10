<%@ page import="java.util.*,
                com.bizwink.cms.tree.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String userid = authToken.getUserID();
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
                    break;
                }
            }
            colTree = TreeManager.getInstance().getUserTreeIncludeSampleSiteColumn(userid, siteid,samsiteid,clist);
        } else if (!userid.equalsIgnoreCase("admin") && SecurityCheck.hasPermission(authToken, 54)) {
            //վ�����Ա
            colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
        }
    }

    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���
    if (colTree.getNodeNum() > 1) {
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
                    //buf.append(name).append("\",\"javascript:go(" + treeNodes[i].getId() + ")\",\"cmsleft\"));");
                    buf.append(name).append("\",\"templates.jsp?column="+treeNodes[i].getId()+"&rightid="+rightid+"\", \"cmsright\"));");
                    buf.append("\n");
                }
            }

            if (currentID == colTree.getTreeRoot()  && SecurityCheck.hasPermission(authToken,54)) {
                buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
                buf.append("����ģ��").append("\",\"templatesforprogram.jsp?column=-100" + "\",\"cmsright\"));");
                buf.append("\n");
            }

            //������ǰ�˵������ĸ��˵�
            if (subflag != 0 && currentID != 0)
                buf.append(parentMenu + ".items[" + orderNumber + "].MTMakeSubmenu(" + menuName + ");\r\n");
        } while (nodenum >= 1);
    }
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../style/global.css">
</head>
<script type="text/javascript" src="../js/mtmcode.js"></script>
<script type="text/javascript">
    var needDrag = 0;
    <%=buf.toString()%>
</script>

<BODY <%if(buf.length()>0){%>onload="MTMStartMenu(true)"<%}%> leftMargin=0 topMargin=0 MARGINHEIGHT="0" MARGINWIDTH="0">
<input type=hidden name=justHref id="justHref">
</BODY>
</html>