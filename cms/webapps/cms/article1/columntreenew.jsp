<%@ page import="com.bizwink.cms.news.Column,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=utf-8" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    String userid = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    Tree colTree = null;
    String tbuf = null;

    if (sitetype == 0 || sitetype == 2) {                             //0表示自己创建的网站，2表示完整拷贝模板网站
        if (!userid.equalsIgnoreCase("admin") && !SecurityCheck.hasPermission(authToken, 54)) {
            //普通用户
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
            //站点管理员
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
    } else {                                                           //1表示共享模板网站的栏目和模板
        if (!userid.equalsIgnoreCase("admin") && !SecurityCheck.hasPermission(authToken, 54)) {
            //普通用户
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
            //站点管理员
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel=stylesheet type="text/css" href="../style/global.css">
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="../js/jquery.form.js"></script>
    <script type="text/javascript" language="javascript">
        /**自定义的数据源，ztree支持json,数组，xml等格式的**/
        var columnnodes = <%=tbuf%>;
        /**ztree的参数配置，setting主要是设置一些tree的属性，是本地数据源，还是远程，动画效果，是否含有复选框等等**/
        var setting = {
            check: { /**复选框**/
            enable: false,
                chkboxType: {"Y":"", "N":""}
            },
            view: {
                //dblClickExpand: false,
                showIcon: false,
                expandSpeed: 300 //设置树展开的动画速度，IE6下面没效果，
            },
            data: {
                simpleData: {   //简单的数据源，一般开发中都是从数据库里读取，API有介绍，这里只是本地的
                    enable: true,
                    idKey: "id",  //id和pid，这里不用多说了吧，树的目录级别
                    pIdKey: "pId",
                    rootPId: 0   //根节点
                }
            },
            callback: {     /**回调函数的设置，随便写了两个**/
            beforeClick: beforeClick,
                onCheck: onCheck
            }
        };

        $(document).ready(function(){//初始化ztree对象
            var zTreeDemo = $.fn.zTree.init($("#columnTree"),setting, columnnodes);
        });

        function beforeClick(treeId, treeNode) {
            parent.frames['cmsright'].location = "articles.jsp?rightid=<%=rightid%>&column=" + treeNode.id;
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
