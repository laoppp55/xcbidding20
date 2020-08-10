<%@ page import="java.util.*,
		             com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.btob.system.po.Company" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.ArticleService" %>
<%@ page import="com.bizwink.btob.Service.CompanyService" %>
<%@ page import="com.bizwink.po.Article" %>
<%@ page import="com.bizwink.service.system.OrgService" %>
<%@ page import="com.bizwink.service.ColumnService" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect( "../login.jsp" );
        return;
    }
    if (!SecurityCheck.hasPermission(authToken, 54))
    {
        response.sendRedirect("../error.jsp?message=无管理用户的权限");
        return;
    }

    int siteid = authToken.getSiteID();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    String org_json_data = null;
    String column_json_data = null;
    if (appContext!=null) {
        ArticleService articleService = (ArticleService)appContext.getBean("articleService");
        CompanyService companyService = (CompanyService)appContext.getBean("companyService");
        ColumnService columnService = (ColumnService)appContext.getBean("columnService");
        column_json_data = columnService.getColumns(BigDecimal.valueOf(siteid));
        com.bizwink.service.system.OrgService orgService = (com.bizwink.service.system.OrgService)appContext.getBean("orgService");
        Company company1 = companyService.getCompanyByID(BigDecimal.valueOf(7741090359l));
        Article article = articleService.getArticleByID(BigDecimal.valueOf(88921));
        org_json_data = orgService.getOrgJsonsByCustomerid(BigDecimal.valueOf(7741048200l),1);
        //System.out.println(company.getC_COMPNAME() + "===" + company1.getC_COMPNAME() + "==" + article.getMAINTITLE());
    }

    System.out.println(column_json_data);

    int siteID = authToken.getSiteID();

    IUserManager uMgr = UserPeer.getInstance();
    List list = uMgr.getDepartments(siteID);
    int Count = list.size();
%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <link rel="stylesheet" type="text/css" href="../style/zTreeStyle/zTreeStyle.css">
    <link rel="stylesheet" type="text/css" href="../style/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../style/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../css/demo.css">

    <script type="text/javascript" src="../js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.js"></script>
    <!--script type="text/javascript" src="../js/jquery.easyui.min.js"></script-->
    <style type="text/css">
        table{border-collapse:collapse;border-spacing:0;border-left:1px solid #888;border-top:1px solid #888;background:#efefef;}
        th,td{border-right:1px solid #888;border-bottom:1px solid #888;padding:5px 15px;}
        th{font-weight:bold;background:#ccc;}

        div#rMenu {
            z-index: 4;
            position: absolute;//使用绝对定位
            width: 120px;
            visibility: hidden;
            top: 0;
            background-color: #555;
            padding: 1px;
        }

        div#rMenu ul {
            margin: 0px;
            padding: 0px;
        }

        div#rMenu ul li {
            font-size: 12px;
            line-height: 25px;
            width:100px;
            margin: 0px;
            padding: 0px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
            border-bottom: 1px solid #fff;
            padding-left: 3px;
        }

        div#rMenu ul li:hover {
            background: #eee;
        }
    </style>

    <script language="javascript">
        /**自定义的数据源，ztree支持json,数组，xml等格式的**/
        var columnnodes = <%=column_json_data%>;
        var zTreeDemo;
        /**ztree的参数配置，setting主要是设置一些tree的属性，是本地数据源，还是远程，动画效果，是否含有复选框等等**/
        var setting = {
            check: { /**复选框**/
            enable: false,
                chkboxType: {"Y":"", "N":""}
            },
            view: {
                //dblClickExpand: false,
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
                onCheck: onCheck,
                onRightClick : OnRightClick
            }
        };

        function beforeClick(treeId, treeNode) {
            zTreeDemo.selectNode(treeNode);
        }

        function onCheck(e, treeId, treeNode) {
            zTreeDemo.selectNode(treeNode);
            alert("onCheck");
        }

        function OnRightClick(event, treeId, treeNode) {
            if(treeNode == null) {
                var a = 1; // 什么都不做
            }else if(treeNode && treeNode.name) {
                curName = treeNode.name;
            }else {
                curName = undefined;
            }

            if (treeNode) {
                var top = $(window).scrollTop();
                zTreeDemo.selectNode(treeNode);
                if (treeNode.getParentNode()) {
                    var isParent = treeNode.isParent;
                    if(isParent){//非叶子节点
                        showRMenu("firstNode", event.clientX, event.clientY+top);//处理位置，使用的是绝对位置
                    }else{//叶子节点
                        showRMenu("secondNode", event.clientX, event.clientY+top);
                    }
                } else {
                    showRMenu("root", event.clientX, event.clientY+top);//根节点
                }
            }
        }

        $(document).ready(function(){//初始化ztree对象
            zTreeDemo = $.fn.zTree.init($("#columnTree"),setting,columnnodes);
            rMenu = $("#rMenu");
            //展开根节点
            expandNodes(zTreeDemo.getNodes());
        });

        function showRMenu(type, x, y) {
            $("#rMenu ul").show();
            if (type == "root") {
                $("#m_add").show();
                $("#m_edit").hide();
                $("#m_editFile").hide();
                $("#m_delete").hide();
            } else if(type == "firstNode"){
                $("#m_add").show();
                $("#m_edit").show();
                $("#m_editFile").hide();
                $("#m_delete").show();
            }else if(type == "secondNode"){
                $("#m_add").show();
                $("#m_edit").show();
                $("#m_editFile").show();
                $("#m_delete").show();
            }

            $("#rMenu").css({
                "top" : y + "px",
                "left" : x + "px",
                "visibility" : "visible"
            });

            //在当前页面绑定 鼠标事件
            $(document).bind("mousedown", onBodyMouseDown);
        }

        //事件触发 隐藏菜单
        function onBodyMouseDown(event) {
            if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
                $("#rMenu").css({
                    "visibility" : "hidden"
                });
            }
        }

        //隐式 隐藏右键菜单
        function hideRMenu() {
            if(rMenu){
                $("#rMenu").css({
                    "visibility" : "hidden"
                });
            }
            //取消绑定
            $(document).unbind("mousedown", onBodyMouseDown);
        }

        //异步加载完成
        function onAsyncSuccess(event, treeId, treeNode, msg) {

        }

        //单击节点 显示节点
        function menuShowNode() {
            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {
                if(!node.isParent){

                }
            } else {
                alert("未找到节点");
            }
        }

        //右键菜单 添加节点
        function menuAddNode() {
            //隐藏菜单
            hideRMenu();
            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {
                pId = node.id;
               // $("#addnode").css({
               //     "display" : "block"
               // });

                var feature="dialogWidth:1000px;dialogHeight:800px;status:no;help:no";
                var url = "createNewColumn.jsp?parentID="+pId;
                var retval = window.showModalDialog(url,null,feature);
                insertnode.pid.value=pId;
            } else {
                alert("未找到节点");
            }
        }

        //右键菜单 编辑节点
        function menuEditNode() {
            hideRMenu();
            alert("编辑节点")

            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {

            } else {
                alert("未找到节点");
            }
        }

        //右键菜单 内容节点
        function menuEditContentNode() {
            hideRMenu();
            alert("编辑节点内容")

            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {

            } else {
                alert("未找到节点");
            }
        }

        //右键菜单删除节点
        function menuDeleteNode() {
            hideRMenu();
            alert("删除节点")

            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {
                //easyUI 消息框
                top.$.messager.confirm("删除节点下的所有信息","确定要删除此节点吗？", function (r) {
                    if (r) {
                        var id = node.getParentNode().id;
                        $.ajax({
                            url : node.id,
                            beforeSend:function(){

                            },
                            success : function(data) {
                                var msg = "删除成功";
                                if ($.trim(data) == "success") {
                                    refreshNode(id);

                                    //location.href = "about:blank";
                                } else {
                                    msg = "删除失败";
                                }

                                top.$.messager.show({
                                    showType:'fade',
                                    showSpeed:2000,
                                    msg:msg,
                                    title:'删除操作',
                                    timeout:1
                                });
                            }
                        });
                    }
                });
            } else {
                alert("未找到节点");
            }
        }

        //焦点
        function focusNode(id) {
            var node = zTreeDemo.getNodeByParam("id", id, null);
            if (node) {
                zTreeDemo.selectNode(node);
            } else {
                setTimeout(function() {
                    focusNode(id);
                }, 10);
            }

        }

        function expandNodes(nodes) {
            zTreeDemo.expandNode(nodes[0], true, false, false);
        }

        //刷新节点
        function refreshNode(id) {
            var node = zTreeDemo.getNodeByParam("id", id, null);
            if (node) {
                zTreeDemo.reAsyncChildNodes(node, "refresh");
            } else {
                setTimeout(function() {
                    refreshNode(id);
                }, 10);
            }
        }

        //刷新父节点
        function refreshParentNode(id) {
            var node = zTreeDemo.getNodeByParam("id", id, null);
            var pNode = node.getParentNode();
            if (pNode) {
                refreshNode(pNode.id);
            } else {
                refreshNode("0");
            }
        }

        //为添加节点刷新
        function refreshForAddNode(id) {
            var node = zTreeDemo.getNodeByParam("id", id, null);
            zTreeDemo.addNodes(node, {
                id : "xx",
                name : "new node"
            });
            zTree.reAsyncChildNodes(node, "refresh");
        }

        function cancel_insert() {
            $("#addnode").css({"display" : "none"})
        }

        function insert_node() {
            alert(insertnode.pid.value);
            id = insertnode.pid.value;
            refreshForAddNode(id)
            $("#addnode").css({"display" : "none"})
        }


        function createGroup()
        {
            window.open("createdepartment.jsp","","top=100,left=100,width=360,height=360");
        }
        function edit(id)
        {
            window.open("editdepartment.jsp?id="+id,"","top=100,left=100,width=360,height=360");
        }
        function del(id)
        {
            window.open("deletedepartment.jsp?id="+id,"","top=100,left=100,width=360,height=360");
        }
    </script>
</head>
<BODY BGCOLOR="#ffffff" LINK="#000099" ALINK="#cc0000" VLINK="#000099" TOMARGIN=8>
<%
    String[][] titlebars = {
            { "部门管理", "" }
    };
    String [][] operations =
            {
                    {"<a href=javascript:createGroup();>创建部门</a>", ""},
                    {"系统管理","../member/index.jsp"},
            };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>

<div id="rMenu" class="rMenu">
    <ul>
        <li id="m_add" onclick="menuAddNode();">增加节点</li>
        <li id="m_edit" onclick="menuEditNode();">编辑节点</li>
        <li id="m_editFile" onclick="menuEditContentNode();">编辑内容</li>
        <li id="m_delete" onclick="menuDeleteNode();">删除节点</li>
    </ul>
</div>

<div class="ztree" id="columnTree"></div>

<div id="addnode" style="display:none;position: absolute;top:100px;left:200px;width:500px;border:1px solid red;">
    <form name="insertnode" method="post">
        <input type="hidden" value="" name="pid">
        <input type="hidden" value="" name="pcode">
        <table border="0" align="center">
            <tr>
                <td>节点名称：</td>
                <td><input type="text" value="" name="nodename" maxlength="50"></td>
            </tr>
            <tr>
                <td>节点编码：</td>
                <td><input type="text" value="" name="nodecode" maxlength="50"></td>
            </tr>
            <tr>
                <td><input type="button" value="提交" name="tijiao" onclick="javascript:insert_node();"></td>
                <td><input type="button" value="取消" name="cancel" onclick="javascript:cancel_insert();"></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
