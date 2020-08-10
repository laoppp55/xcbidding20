<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.cms.news.Column" %>
<%@ page import="com.bizwink.cms.news.ColumnPeer" %>
<%@ page import="com.bizwink.cms.news.IColumnManager" %>
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
            node[] treeNodes = colTree.getAllNodes();
            if (colTree.getNodeNum()> 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<colTree.getNodeNum();ii++){
                    if (ii<colTree.getNodeNum()-1) {
                        if (treeNodes[ii].getLinkPointer()==0)
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:"+ treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() +"\",url:\"\"" + ",open:\"true\"" +"},\r\n";
                        else
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:"+ treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() +"\"},\r\n";
                    }else {
                        if (treeNodes[ii].getLinkPointer() == 0)
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:" + treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() + "\",url:\"#\"" + ",open:\"true\"" + "}\r\n";
                        else
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:" + treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() + "\"}\r\n";
                    }
                }
                tbuf = tbuf + "]";
            }
        } else if (!userid.equalsIgnoreCase("admin") && SecurityCheck.hasPermission(authToken, 54)) {
            //վ�����Ա
            colTree = TreeManager.getInstance().getSiteTree(siteid);
            node[] treeNodes = colTree.getAllNodes();
            if (colTree.getNodeNum()> 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<colTree.getNodeNum();ii++){
                    if (ii<colTree.getNodeNum()-1) {
                        if (treeNodes[ii].getLinkPointer()==0)
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:"+ treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() +"\",url:\"\"" + ",open:\"true\"" +"},\r\n";
                        else
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:"+ treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() +"\"},\r\n";
                    }else {
                        if (treeNodes[ii].getLinkPointer() == 0)
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:" + treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() + "\",url:\"#\"" + ",open:\"true\"" + "}\r\n";
                        else
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:" + treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() + "\"}\r\n";
                    }
                }
                tbuf = tbuf + "]";
            }
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
            if (clist.size() > 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<clist.size();ii++){
                    Column column = (Column)clist.get(ii);
                    if (ii<clist.size()-1) {
                        if (column.getParentID()==0)
                            tbuf = tbuf + "{id:" +column.getID() + ",pId:"+ column.getParentID() + ",name:\"" + column.getCName() +"\",url:\"\"" + ",open:\"true\"" +"},\r\n";
                        else
                            tbuf = tbuf + "{id:" +column.getID() + ",pId:"+ column.getParentID() + ",name:\"" + column.getCName() +"\"},\r\n";
                    }else{
                        if (column.getParentID()==0)
                            tbuf = tbuf + "{id:" +column.getID() + ",pId:"+ column.getParentID() + ",name:\"" + column.getCName() +"\",url:\"#\"" + ",open:\"true\"" +"}\r\n";
                        else
                            tbuf = tbuf + "{id:" +column.getID() + ",pId:"+ column.getParentID() + ",name:\"" + column.getCName() +"\"}\r\n";
                    }
                }
                tbuf = tbuf + "]";
            }
        } else if (!userid.equalsIgnoreCase("admin") && SecurityCheck.hasPermission(authToken, 54)) {
            //վ�����Ա
            colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
            node[] treeNodes = colTree.getAllNodes();
            if (colTree.getNodeNum()> 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<colTree.getNodeNum();ii++){
                    if (ii<colTree.getNodeNum()-1) {
                        if (treeNodes[ii].getLinkPointer()==0)
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:"+ treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() +"\",url:\"\"" + ",open:\"true\"" +"},\r\n";
                        else
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:"+ treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() +"\"},\r\n";
                    }else {
                        if (treeNodes[ii].getLinkPointer() == 0)
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:" + treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() + "\",url:\"#\"" + ",open:\"true\"" + "}\r\n";
                        else
                            tbuf = tbuf + "{id:" + treeNodes[ii].getId() + ",pId:" + treeNodes[ii].getLinkPointer() + ",name:\"" + treeNodes[ii].getChName() + "\"}\r\n";
                    }
                }
                tbuf = tbuf + "]";
            }
        }
    }
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
            //alert(treeNode.id + "==" + treeNode.name);
            selectItem(treeNode.id,treeNode.name);
        }

        function selectItem(columnid,columnName) {
            var existflag = false;
            columnName = columnName.replace(new RegExp("#", "gm"), " ");
            columnName = columnName.replace(new RegExp("`", "gm"), "'");
            var option = new Option();
            option.text = columnName;
            option.value=columnid;

            len = parent.frames['cmsright'].selform.selectedcolumns.length;
            for(var i=0; i<len; i++) {
                if (columnid ==parent.frames['cmsright'].selform.selectedcolumns[i].value) {
                    existflag = true;
                    break;
                }
            }

            if (existflag == false) {
                parent.frames['cmsright'].selform.selectedcolumns.add(option);
                parent.frames['cmsright'].selform.selectedcolumns.focus();
            }
        }

        function onCheck(e, treeId, treeNode) {
            alert("onCheck");
        };
    </script>
</head>
<body style="background-color:#dddddd;">
<input type=hidden name=justHref id="justHref">
<div style="height: 8px;"></div>
<div class="ztree" id="columnTree"></div>
</body>
</html>
