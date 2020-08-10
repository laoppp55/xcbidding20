<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteID = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();
    Tree colTree = null;

    if (sitetype == 0 || sitetype == 2)                              //0��ʾ�Լ���������վ��2��ʾ��������ģ����վ
        colTree = TreeManager.getInstance().getSiteTree(siteID);
    else
        colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteID,samsiteid);

    node[] treeNodes = colTree.getAllNodes();                     //��ȡ���������нڵ�
    int pid[] = new int[colTree.getNodeNum()];                    //����������Ҫ�Ľڵ����飬�洢��ǰδ����Ľڵ�
    String parentMenuName[] = new String[colTree.getNodeNum()];   //�洢ĳ���ڵ�������ӽڵ�ĸ��˵�����
    String parentMenu="menu";                                     //�洢��ǰ�ڵ�ĸ��˵�����
    String menuName = "menu";                                     //�洢��ǰ�ڵ�Ĳ˵�����
    int currentID = 0;                                            //��ǰ���ڴ���Ľڵ�
    int i=0;                                                      //ѭ������
    int[] ordernum = new int[colTree.getNodeNum()];               //��ǰ�ڵ������ӽڵ��˳���
    int orderNumber = 0;                                          //��ǰ�ڵ���ͬ���ڵ��˳���
    int nodenum = 1;                                              //��ǰ������ڵ�ĳ�ʼֵ
    int subflag = 1;                                              //�жϵ�ǰ�ڵ��Ƿ����ӽڵ�
    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���

    do
    {
        currentID = pid[nodenum];

        //���õ�ǰ����ڵ�ĳ�ʼֵ
        if(currentID != 0)
        {
            parentMenu = parentMenuName[nodenum];
            orderNumber = ordernum[nodenum];
            menuName = "menu"+currentID;
        }

        //�Ӵ���Ľڵ�������ȡ����ǰ���ڴ����Ԫ�أ����Ҹ�Ԫ���µ���Ԫ��
        //���������ӽڵ�ĸ��˵����ƣ����������ӽڵ�����кţ������е��ӽڵ����pid������
        subflag = 0;
        nodenum = nodenum - 1;
        for (i=0;i<colTree.getNodeNum();i++)
        {
            if (treeNodes[i].getLinkPointer() == currentID)
            {
                nodenum = nodenum + 1;
                pid[nodenum] = treeNodes[i].getId();
                parentMenuName[nodenum] = menuName;
                ordernum[nodenum] = subflag;
                subflag = subflag + 1;
            }
        }

        //�����ǰ�ڵ����ӽڵ㣬���ɵ�ǰ�ڵ�Ĳ˵�
        if (subflag != 0)
        {
            buf.append("var "+menuName+" = null;\n");
            buf.append(menuName+" = new MTMenu();\n");
        }
        for (i=0;i<colTree.getNodeNum();i++)
        {
            if (treeNodes[i].getLinkPointer() == currentID)
            {
                String cname = StringUtil.gb2iso4View(treeNodes[i].getChName());
                String name  = "<font class=line>"+cname+"</font>";
                buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
                buf.append(name).append("\",\"javascript:parent.frames['cmsleft'].abc('"+StringUtil.replace(cname,"'","`")+"','"+treeNodes[i].getId()+"')\", \"\"));");
                buf.append("\n");
            }
        }

        //������ǰ�˵������ĸ��˵�
        if(subflag != 0 && currentID != 0)
            buf.append(parentMenu+".items["+orderNumber+"].MTMakeSubmenu(" + menuName + ");\r\n");
    }while(nodenum >= 1);
    //ֱ��pid������û�д�����Ľڵ�Ϊֹ
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../style/global.css">
    <script language="javascript">
        function abc(par1,par2)
        {
            var el = window.parent.frames['cmsright'].document.getElementById('selectedColumn');
            var endFlag = true;
            i = 0;
            optionLen = el.options.length;
            while(( i < optionLen) && endFlag)
            {
                if (el.options[i].value == par2)
                {
                    endFlag = false;
                    alert("�벻Ҫ�ظ�ѡ����Ŀ");
                }
                i++;
            }

            par1 = par1.replace("`","'");
            if (endFlag)
                window.parent.frames['cmsright'].document.getElementById('selectedColumn').options.add(new Option(par1,par2,false,false));
        }
        var needDrag = 0;
    </script>
</head>
<script type="text/javascript" src="../js/mtmcode.js"></script>
<script type="text/javascript">
    <%=buf.toString()%>
</script>
<BODY onload="MTMStartMenu(true)" leftMargin=0 topMargin=0 MARGINHEIGHT="0" MARGINWIDTH="0">
</BODY></html>