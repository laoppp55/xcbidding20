<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.cms.news.Column" %>
<%@ page import="com.bizwink.cms.news.ColumnPeer" %>
<%@ page import="com.bizwink.cms.news.IColumnManager" %>
<%@ page import="java.util.Map" %>
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
    String tbuf = null;

    if (sitetype == 0 || sitetype == 2) {                             //0��ʾ�Լ���������վ��2��ʾ��������ģ����վ
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
        }
    } else {                                                           //1��ʾ����ģ����վ����Ŀ��ģ��
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
            colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
        }
    }
    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���
    int current_pid = 0;
    node currentNode = null;
    if (colTree.getNodeNum() > 1) {
        node[] treeNodes = colTree.getAllNodes();                       //��ȡ���������нڵ�
        List<node> pid = new ArrayList<>();                        //����������Ҫ�Ľڵ����飬�洢��ǰδ����Ľڵ�
        int nodenum = 1;                                              //��ǰ������ڵ�ĳ�ʼֵ
        int subnodenum = 0;                                              //��¼��ǰ�ڵ���ӽڵ�����

        for(int ii=0;ii<treeNodes.length; ii++) {
            //����ǰ�ڵ�
            if (current_pid == treeNodes[ii].getLinkPointer()) {
                pid.add(treeNodes[ii]);
                break;
            }
        }

        int rootid = pid.get(0).getId();

        buf.append("[ //�ڵ�\r\n");
        //�洢ÿ���ڵ���ӽڵ�����
        Map<Integer,Integer> subnodes = new HashMap();
        //����������Ŀ��
        while(pid.size()>0) {
            currentNode = pid.get(0);
            pid.remove(0);
            nodenum = nodenum - 1;
//            System.out.println(currentNode.getChName() + "===" + currentNode.getId() + "===" + currentNode.getLinkPointer());

            //���ҵ�ǰ�ڵ���ӽڵ㣬�����ӽڵ㱣�浽�������ڵ���б�
            for(int ii=0;ii<treeNodes.length; ii++) {
                if (currentNode.getId() == treeNodes[ii].getLinkPointer()) {
                    pid.add(subnodenum,treeNodes[ii]);
                    nodenum = nodenum + 1;
                    subnodenum = subnodenum + 1;
                }
            }

            //��¼��ǰ�ڵ���ӽڵ���
            subnodes.put(currentNode.getId(),subnodenum);

            //ȡ����ǰ�ڵ㸸�ڵ���ӽڵ���
            int SubNodeNumOfParentNode=0;
            if (currentNode.getLinkPointer()>0) SubNodeNumOfParentNode= subnodes.get(currentNode.getLinkPointer());

            //��ǰ�ڵ㲻�����ӽڵ�
            if(subnodenum==0) {
                if (SubNodeNumOfParentNode > 1) {
                    buf.append("   {\r\n");
                    buf.append("      name: '" + currentNode.getChName() + "',\r\n");
                    buf.append("      id:" + currentNode.getId() + "\r\n");
                    buf.append("   },\r\n");
                } else if (SubNodeNumOfParentNode==1){
                    buf.append("   {\r\n");
                    buf.append("      name: '" + currentNode.getChName() + "',\r\n");
                    buf.append("      id:" + currentNode.getId() + "\r\n");
                    buf.append("   }\r\n");
                    //�ж��Ƿ���������Ŀ�������һ���ڵ㣬���һ���ڵ������Ҫ�ж���
                    if(nodenum > 0)
                        buf.append("]\r\n},\r\n");
                    else
                        buf.append("]\r\n}\r\n");
                }
            } else if (subnodenum>0){
                buf.append("   {\r\n");
                buf.append("      name: '" + currentNode.getChName() + "',\r\n");
                buf.append("      id:" + currentNode.getId() + ",\r\n");
                buf.append("children: [\r\n");
            }

            //��ǰ�ڵ�ĸ��ڵ���ӽڵ���Ŀ��1����ʾ���ڵ��һ���ӽڵ㱻����
            subnodes.put(currentNode.getLinkPointer(),SubNodeNumOfParentNode-1);

            //�ӽڵ���������㣬������һ��������ڵ��Ƿ����ӽڵ�
            subnodenum = 0;
        }

        //д����Ӧ�Ľ����ַ�
        buf.append("]\r\n");

    }
    FileUtil.writeFile(buf,"c:\\data\\tree.txt");
    //System.out.println(buf.toString());
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../style/global.css">
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="../js/jquery.form.js"></script>
    <script type="text/javascript" language="javascript">
        /**�Զ��������Դ��ztree֧��json,���飬xml�ȸ�ʽ��**/
        var columnnodes = <%=tbuf%>;
        /**ztree�Ĳ������ã�setting��Ҫ������һЩtree�����ԣ��Ǳ�������Դ������Զ�̣�����Ч�����Ƿ��и�ѡ��ȵ�**/
        var setting = {
            check: { /**��ѡ��**/
            enable: false,
                chkboxType: {"Y":"", "N":""}
            },
            view: {
                //dblClickExpand: false,
                showIcon: false,
                expandSpeed: 300 //������չ���Ķ����ٶȣ�IE6����ûЧ����
            },
            data: {
                simpleData: {   //�򵥵�����Դ��һ�㿪���ж��Ǵ����ݿ����ȡ��API�н��ܣ�����ֻ�Ǳ��ص�
                    enable: true,
                    idKey: "id",  //id��pid�����ﲻ�ö�˵�˰ɣ�����Ŀ¼����
                    pIdKey: "pId",
                    rootPId: 0   //���ڵ�
                }
            },
            callback: {     /**�ص����������ã����д������**/
            beforeClick: beforeClick,
                onCheck: onCheck
            }
        };

        $(document).ready(function(){//��ʼ��ztree����
            var zTreeDemo = $.fn.zTree.init($("#columnTree"),setting, columnnodes);
        });

        function beforeClick(treeId, treeNode) {
            parent.frames['cmsright'].location = "templates.jsp?rightid=<%=rightid%>&column=" + treeNode.id;
        }

        function onCheck(e, treeId, treeNode) {
            alert("onCheck");
        };
    </script>
</head>
<body style="background-color:#c4dcfb;">
<input type=hidden name=justHref id="justHref">
<div style="height: 8px;"></div>
<div class="ztree" id="columnTree"></div>
</body>
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
            parent.frames['cmsright'].location = "articles.jsp?rightid=<%=rightid%>&column=" + columnID;
            return;
        } else {
            if (document.getElementById("justHref").value != "" && window.parent.frames['cmsleft'].document.all("justHref").value)
                window.parent.frames['cmsleft'].document.all("justHref").value.className = "line";
            document.getElementById("justHref").value = "href" + columnID;
            window.parent.frames['cmsright'].location = "articles.jsp?rightid=<%=rightid%>&column=" + columnID;
            return;
        }
    }
</script>