<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=utf-8" %>
<%@ page import="com.bizwink.cms.news.ColumnPeer" %>
<%@ page import="com.bizwink.cms.news.IColumnManager" %>
<%@ page import="com.bizwink.po.Column" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.ColumnService" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    int siteid = authToken.getSiteID();
    String userid = authToken.getUserID();
    int sitetype = authToken.getSitetype();
    String tbuf = null;

    Column rootColumn = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        ColumnService columnService = (ColumnService)appContext.getBean("columnService");
        rootColumn = columnService.getRootColumnBySiteid(BigDecimal.valueOf(siteid));
    }
    int rootColumnID = rootColumn.getID().intValue();

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
            //colTree = TreeManager.getInstance().getUserTree(userid, siteid, clist,rightid);
            if (clist.size() > 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<clist.size();ii++){
                    com.bizwink.cms.news.Column column = (com.bizwink.cms.news.Column)clist.get(ii);
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
            //colTree = TreeManager.getInstance().getSiteTree(siteid);
            IColumnManager columnManager = ColumnPeer.getInstance();
            List<com.bizwink.cms.news.Column> columns = columnManager.getColumnsForSite(siteid);
            if (columns.size() > 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<columns.size();ii++){
                    com.bizwink.cms.news.Column column = (com.bizwink.cms.news.Column)columns.get(ii);
                    if (ii<columns.size()-1) {
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
            //colTree = TreeManager.getInstance().getUserTree(userid, siteid, clist,rightid);
            if (clist.size() > 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<clist.size();ii++){
                    com.bizwink.cms.news.Column column = (com.bizwink.cms.news.Column)clist.get(ii);
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
            //colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
            IColumnManager columnManager = ColumnPeer.getInstance();
            List<com.bizwink.cms.news.Column> columns = columnManager.getColumnsForSite(siteid);
            if (columns.size() > 0) {
                tbuf = "[\r\n";
                for(int ii=0;ii<columns.size();ii++){
                    com.bizwink.cms.news.Column column = (com.bizwink.cms.news.Column)columns.get(ii);
                    if (ii<columns.size()-1) {
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
        }
    }
    System.out.println(tbuf);
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/icon.css">
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/column.css">
    <script type="text/javascript" src="../js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/treegrid-dnd.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="../js/splitter.js"></script>
    <script type="text/javascript">
        var w = document.documentElement.clientWidth;
        var h = document.documentElement.clientHeight;
        //var w = document.documentElement.scrollWidth || document.body.scrollWidth;
        //var h = document.documentElement.scrollHeight || document.body.scrollHeight;

        function go(){
            window.document.location = "../exit.jsp";
        }
    </script>
</head>
<body>
<div id="header">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFAE08">
        <tr bgcolor="#FFAE08" height="60">
            <td width="2%">&nbsp;</td>
            <td width="85%">
                <table width="620" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <jsp:include page="../headernew.jsp" flush="true"/><!--动态包含-->
                    </tr>
                </table>
            </td>
            <td width="13%">
                <a href="help/index.htm" target=_blank><img src="../images/help.gif" border="0"></a>&nbsp;
                <a href="javascript:go();"><img src="../images/exit.gif" border="0"></a>
            </td>
        </tr>
    </table>
</div>
<div id="splitterContainer">
    <div id="leftPane">
        <!--div class="ztree" id="columnTree" style="background-color:yellow;"></div-->
        <div class="ztree" id="columnTree"></div>
    </div>
    <!-- #leftPane -->
    <div id="rightPane">
        <script type="text/javascript">
            //document.write('<table id="tg" class="easyui-treegrid" title="模板管理" style="width:' + w*0.85 + 'px;height:' + h*0.95 + 'px"></table>');
        </script>
    </div>
    <!-- #rightPane -->
</div>
<!-- #splitterContainer -->
</body>
<script type="text/javascript">
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

    function onCheck(e, treeId, treeNode) {
        alert("onCheck");
    };

    function beforeClick(treeId, treeNode) {

    }

    $(document).ready(function(){
        $("#splitterContainer").splitter({minAsize:100,maxAsize:300,splitVertical:true,A:$('#leftPane'),B:$('#rightPane'),slave:$("#rightSplitterContainer"),closeableto:0});
        $("#rightSplitterContainer").splitter({splitHorizontal:true,A:$('#rightTopPane'),B:$('#rightBottomPane'),closeableto:100});
        var zTreeDemo = $.fn.zTree.init($("#columnTree"),setting, columnnodes);
    })
</script>
</html>
