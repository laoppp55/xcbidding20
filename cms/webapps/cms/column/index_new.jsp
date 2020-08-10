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
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
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
            position: absolute;//ʹ�þ��Զ�λ
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
        /**�Զ��������Դ��ztree֧��json,���飬xml�ȸ�ʽ��**/
        var columnnodes = <%=column_json_data%>;
        var zTreeDemo;
        /**ztree�Ĳ������ã�setting��Ҫ������һЩtree�����ԣ��Ǳ�������Դ������Զ�̣�����Ч�����Ƿ��и�ѡ��ȵ�**/
        var setting = {
            check: { /**��ѡ��**/
            enable: false,
                chkboxType: {"Y":"", "N":""}
            },
            view: {
                //dblClickExpand: false,
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
                var a = 1; // ʲô������
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
                    if(isParent){//��Ҷ�ӽڵ�
                        showRMenu("firstNode", event.clientX, event.clientY+top);//����λ�ã�ʹ�õ��Ǿ���λ��
                    }else{//Ҷ�ӽڵ�
                        showRMenu("secondNode", event.clientX, event.clientY+top);
                    }
                } else {
                    showRMenu("root", event.clientX, event.clientY+top);//���ڵ�
                }
            }
        }

        $(document).ready(function(){//��ʼ��ztree����
            zTreeDemo = $.fn.zTree.init($("#columnTree"),setting,columnnodes);
            rMenu = $("#rMenu");
            //չ�����ڵ�
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

            //�ڵ�ǰҳ��� ����¼�
            $(document).bind("mousedown", onBodyMouseDown);
        }

        //�¼����� ���ز˵�
        function onBodyMouseDown(event) {
            if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
                $("#rMenu").css({
                    "visibility" : "hidden"
                });
            }
        }

        //��ʽ �����Ҽ��˵�
        function hideRMenu() {
            if(rMenu){
                $("#rMenu").css({
                    "visibility" : "hidden"
                });
            }
            //ȡ����
            $(document).unbind("mousedown", onBodyMouseDown);
        }

        //�첽�������
        function onAsyncSuccess(event, treeId, treeNode, msg) {

        }

        //�����ڵ� ��ʾ�ڵ�
        function menuShowNode() {
            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {
                if(!node.isParent){

                }
            } else {
                alert("δ�ҵ��ڵ�");
            }
        }

        //�Ҽ��˵� ��ӽڵ�
        function menuAddNode() {
            //���ز˵�
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
                alert("δ�ҵ��ڵ�");
            }
        }

        //�Ҽ��˵� �༭�ڵ�
        function menuEditNode() {
            hideRMenu();
            alert("�༭�ڵ�")

            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {

            } else {
                alert("δ�ҵ��ڵ�");
            }
        }

        //�Ҽ��˵� ���ݽڵ�
        function menuEditContentNode() {
            hideRMenu();
            alert("�༭�ڵ�����")

            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {

            } else {
                alert("δ�ҵ��ڵ�");
            }
        }

        //�Ҽ��˵�ɾ���ڵ�
        function menuDeleteNode() {
            hideRMenu();
            alert("ɾ���ڵ�")

            var node = zTreeDemo.getSelectedNodes()[0];
            if (node) {
                //easyUI ��Ϣ��
                top.$.messager.confirm("ɾ���ڵ��µ�������Ϣ","ȷ��Ҫɾ���˽ڵ���", function (r) {
                    if (r) {
                        var id = node.getParentNode().id;
                        $.ajax({
                            url : node.id,
                            beforeSend:function(){

                            },
                            success : function(data) {
                                var msg = "ɾ���ɹ�";
                                if ($.trim(data) == "success") {
                                    refreshNode(id);

                                    //location.href = "about:blank";
                                } else {
                                    msg = "ɾ��ʧ��";
                                }

                                top.$.messager.show({
                                    showType:'fade',
                                    showSpeed:2000,
                                    msg:msg,
                                    title:'ɾ������',
                                    timeout:1
                                });
                            }
                        });
                    }
                });
            } else {
                alert("δ�ҵ��ڵ�");
            }
        }

        //����
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

        //ˢ�½ڵ�
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

        //ˢ�¸��ڵ�
        function refreshParentNode(id) {
            var node = zTreeDemo.getNodeByParam("id", id, null);
            var pNode = node.getParentNode();
            if (pNode) {
                refreshNode(pNode.id);
            } else {
                refreshNode("0");
            }
        }

        //Ϊ��ӽڵ�ˢ��
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
            { "���Ź���", "" }
    };
    String [][] operations =
            {
                    {"<a href=javascript:createGroup();>��������</a>", ""},
                    {"ϵͳ����","../member/index.jsp"},
            };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>

<div id="rMenu" class="rMenu">
    <ul>
        <li id="m_add" onclick="menuAddNode();">���ӽڵ�</li>
        <li id="m_edit" onclick="menuEditNode();">�༭�ڵ�</li>
        <li id="m_editFile" onclick="menuEditContentNode();">�༭����</li>
        <li id="m_delete" onclick="menuDeleteNode();">ɾ���ڵ�</li>
    </ul>
</div>

<div class="ztree" id="columnTree"></div>

<div id="addnode" style="display:none;position: absolute;top:100px;left:200px;width:500px;border:1px solid red;">
    <form name="insertnode" method="post">
        <input type="hidden" value="" name="pid">
        <input type="hidden" value="" name="pcode">
        <table border="0" align="center">
            <tr>
                <td>�ڵ����ƣ�</td>
                <td><input type="text" value="" name="nodename" maxlength="50"></td>
            </tr>
            <tr>
                <td>�ڵ���룺</td>
                <td><input type="text" value="" name="nodecode" maxlength="50"></td>
            </tr>
            <tr>
                <td><input type="button" value="�ύ" name="tijiao" onclick="javascript:insert_node();"></td>
                <td><input type="button" value="ȡ��" name="cancel" onclick="javascript:cancel_insert();"></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
