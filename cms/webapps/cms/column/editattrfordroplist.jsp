<%@ page import="com.bizwink.cms.security.*,
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

    int rowno = ParamUtil.getIntParameter(request, "rowno", 0);
    int type = ParamUtil.getIntParameter(request, "type", 0);
    int datatype = ParamUtil.getIntParameter(request, "datatype", 0);
    int columnid = ParamUtil.getIntParameter(request, "column", 0);
    String act = ParamUtil.getParameter(request, "act");
    int from = ParamUtil.getIntParameter(request, "from", 0);   //from=1������ҳ

    System.out.println("rowno===" + rowno);
%>
<!DOCTYPE html>
<HTML>
<HEAD>
    <TITLE> ��Ŀ��Ϣ�������Զ��� </TITLE>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <!--link rel="stylesheet" href="../css/demo.css" type="text/css"-->
    <link rel="stylesheet" href="../css/zTree.css" type="text/css">
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <!--link rel="stylesheet" href="../css/bootstrapztree.css" type="text/css"-->

    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <SCRIPT LANGUAGE="JavaScript">
        var zTreeObj;
        // zTree �Ĳ������ã�����ʹ����ο� API �ĵ���setting ������⣩
        //var setting = {};
        var setting = {
            view: {
                addHoverDom: addHoverDom,            //������ƶ����ڵ���ʱ����ʾ�û��Զ���ؼ�
                removeHoverDom: removeHoverDom      //�뿪�ڵ�ʱ�Ĳ���
            },
            edit: {
                enable: true, //��������Ϊtrueʱ���ɼ����޸ġ�ɾ��ͼ��
                editNameSelectAll: true,
                showRemoveBtn: true,
                showRenameBtn: true
            },
            check: {
                enable: true
            },
            edit: {
                enable: true
            },
            data: {
                simpleData: {
                    enable: true,
                    id : "id",       // ����id,��Ӧ��Json�е�id
                    pId : "pId"      // ����pId,��Ӧ��Json�е�parentId
                },
                key : {
                    name : "name" // �����ʾ��name���ԣ���Ӧ��Json�е�departName
                }
            },
            callback: {                              /**�ص����������ã����д������**/
                beforeEditName: beforeEditName,     //����༭ʱ�����������жϸýڵ��Ƿ��ܱ༭
                beforeRemove:beforeRemove,              //���ɾ��ʱ������������ʾ�û��Ƿ�ȷ��ɾ�������Ը��ݷ���ֵ true|false ȷ���Ƿ����ɾ����
                onRemove:onRemove,                   //(beforeRemove����true֮����Խ���onRemove)ɾ���ڵ�󴥷����û���̨����
                beforeRename:beforeRename,          //�༭����ʱ������������֤����������Ƿ����Ҫ��(Ҳ�Ǹ��ݷ���ֵ true|false ȷ���Ƿ���Ա༭���)
                onRename:onRename,                   //�༭�󴥷������ڲ�����̨
                beforeClick: beforeClick,
                onCheck: onCheck,
                //onNodeCreated:onNodeCreated,
                beforeEditName: beforeEditName,
                onClick: onClick
            }
        };

        // zTree ���������ԣ�����ʹ����ο� API �ĵ���zTreeNode �ڵ�������⣩
        $(document).ready(function(){
            var rowno = document.attrdroplist.rowno.value;
            var actval = document.attrdroplist.act.value;
            var cname = window.opener.attr.cname.value;
            var ename = window.opener.attr.ename.value;
            /*nodes1 = [
             {id:1, pId:0, name:'ʳƷ����|1',level:0},{id:11, pId:1,
             name:'ˮ��|11',level:1},{id:12, pId:1,
             name:'�߲�|22',level:1}
             ];*/

            if (actval=="update") {
                var defval = window.opener.attr.droplist<%=rowno%>.value;
                if (defval!=='null' && defval!==null && defval!=='') {
                    //alert(defval);
                    var nodes = eval('(' + defval + ')');
                    if (nodes.type == 0) {     //��ѡ�����б�
                        $("input[name='listtype']:eq(0)").attr("checked",'checked');
                    } else {                   //��ѡ�����б�
                        $("input[name='listtype']:eq(1)").attr("checked",'checked');
                    }
                    zTreeObj = $.fn.zTree.init($("#zztree"), setting, nodes.data);
                } else {
                    ename = ename.substring(1);
                    nodes = [{id:1,pId:0,name:cname+"|" + ename}];
                    zTreeObj = $.fn.zTree.init($("#zztree"), setting, nodes);
                }
            } else {
                nodes = [{id:1,pId:0,name:cname+"|" + ename}];
                zTreeObj = $.fn.zTree.init($("#zztree"), setting, nodes);
            }
        });

        function beforeClick(treeId, treeNode) {
            //alert(treeNode.id);
            return true;
        }

        function onCheck(e, treeId, treeNode) {
            alert("onCheck");
        }

        function onClick(event,treeId,treeNode) {
            //alert(treeNode.id);
        }

        function beforeEditName(event,treeId,treeNode) {
            alert(treeNode.id + "before edit");
        }

        function beforeEditName(treeId,treeNode){
            /* if(treeNode.isParent){
             alert("��׼�༭��Ҷ�ӽڵ㣡");
             return false;
             } */
            return true;
        }

        function beforeRemove(e,treeId,treeNode){
            return confirm("��ȷ��Ҫɾ����");
        }
        function onRemove(e,treeId,treeNode){
            if(treeNode.isParent){
                var childNodes = zTree.removeChildNodes(treeNode);
                var paramsArray = new Array();
                for(var i = 0; i < childNodes.length; i++){
                    paramsArray.push(childNodes[i].id);
                }
                alert("ɾ�����ڵ��idΪ��"+treeNode.id+"\r\n���ĺ��ӽڵ��У�"+paramsArray.join(","));
                return;
            }
            alert("����Ҫɾ���Ľڵ������Ϊ��"+treeNode.name+"\r\n"+"�ڵ�idΪ��"+treeNode.id);
        }


        function beforeRename(treeId,treeNode,newName,isCancel){
            if(newName.length < 3){
                alert("���Ʋ�������3���ַ���");
                return false;
            }
            return true;
        }

        function onRename(e,treeId,treeNode,isCancel){
            alert("�޸Ľڵ��idΪ��"+treeNode.id+"\n�޸ĺ������Ϊ��"+treeNode.name);
        }

        function addHoverDom(treeId, treeNode) {
            var aObj = $("#" + treeNode.tId + "_a");
            if ($("#diyBtn_"+treeNode.id).length>0) return;
            var editStr = "<span id='diyBtn_space_" +treeNode.id+ "' > </span>"
                    + "<button type='button' class='diyBtn1' id='diyBtn_" + treeNode.id
                    + "' title='"+treeNode.name+"' onfocus='this.blur();'></button>";
            aObj.append(editStr);
            var btn = $("#diyBtn_"+treeNode.id);
            if (btn) btn.bind("click", function(){
                alert("diy Button for " + treeNode.name);
            });
        };

        function removeHoverDom(treeId, treeNode) {
            $("#diyBtn_"+treeNode.id).unbind().remove();
            $("#diyBtn_space_" +treeNode.id).unbind().remove();
        };

        /**
         * �ж��Ƿ�null
         * @param data
         */
        function isNull(data){
            return (data == "" || data == undefined || data == null)?1:0;
        }

        function SaveKeyVal() {
            var text = document.attrdroplist.key.value;
            var value = document.attrdroplist.val.value;
            //��ȡztree����
            var zTree = $.fn.zTree.getZTreeObj("zztree");
            //��ȡ�������ĸ��ڵ�
            var zNode = zTree.getNodes();
            //��ȡ�����������нڵ�
            var nodes = zTree.transformToArray(zNode);
            var max_nodeid = 0;
            for (var ii=0;ii<nodes.length;ii++) {
                if (parseInt(nodes[ii].id,10) > parseInt(max_nodeid,10)) {
                    max_nodeid = nodes[ii].id;
                }
            }
            var newID = parseInt(max_nodeid,10) + parseInt(1);
            var parentNodes = zTree.getSelectedNodes();
            zTree.addNodes(parentNodes[0], {id:newID, pId:parentNodes[0].id, name:text + "|" + value}); //ҳ������ӽڵ�
            var node = zTree.getNodeByParam("id", newID, null); //�����µ�id�ҵ�����ӵĽڵ�
            //zTree.selectNode(node); //������ӵĽڵ㴦��ѡ��״̬
            document.attrdroplist.key.value = "";
            document.attrdroplist.val.value = "";
        }

        function Save() {
            var cname = window.opener.attr.cname.value;
            var ename = window.opener.attr.ename.value;
            var actval = document.attrdroplist.act.value;
            var listtypeval = $('input[name="listtype"]:checked').val();
            //��ȡztree����
            var zTree = $.fn.zTree.getZTreeObj("zztree");
            //��ȡ�������ĸ��ڵ�
            var zNode = zTree.getNodes();
            //��ȡ�����������нڵ�
            var nodes = zTree.transformToArray(zNode);
            var treebuf = "{type:" + listtypeval + ",'data':[";
            for (var ii=0;ii<nodes.length;ii++) {
                if (nodes.length == 1)
                    treebuf = treebuf + "{id:" + nodes[ii].id  + ",pId:0,name:'" + nodes[ii].name + "',level:" + nodes[ii].level + "}\r\n";
                else if (parseInt(ii,10)<(parseInt(nodes.length,10)-parseInt(1,10)))
                    if (nodes[ii].pId == null)
                        treebuf = treebuf + "{id:" + nodes[ii].id + ",pId:0,name:'" + nodes[ii].name + "',level:" + nodes[ii].level + "},\r\n";
                    else
                        treebuf = treebuf + "{id:" + nodes[ii].id + ",pId:" + nodes[ii].pId + ",name:'" + nodes[ii].name + "',level:" + nodes[ii].level + "},\r\n";
                else
                    treebuf = treebuf + "{id:" + nodes[ii].id + ",pId:" + nodes[ii].pId + ",name:'" + nodes[ii].name + "',level:" + nodes[ii].level + "}\r\n";
            }
            treebuf = treebuf + "]}";
            if (actval=="update") {
                window.opener.attr.droplist<%=rowno%>.value= treebuf;
                var theDroplist= window.opener.document.getElementById("selid<%=rowno%>");
                theDroplist.options.length=0;
                for(var ii=0; ii<nodes.length; ii++){
                    var op=window.opener.document.createElement("option");                       // �½�OPTION (op)
                    op.setAttribute("value",nodes[ii].id);                                         // ����OPTION�� VALUE
                    op.appendChild(window.opener.document.createTextNode(nodes[ii].name));        // ����OPTION�� TEXT
                    theDroplist.appendChild(op);                                                    // ΪSELECT �½�һ OPTION(op)
                }
                theDroplist.focus();
            } else {
                window.opener.attr.droplist.value=treebuf;
            }
            window.close();
        }
    </SCRIPT>
</HEAD>
<BODY>
<form name="attrdroplist">
    <input type="hidden" name="act" value="<%=act%>">
    <input type="hidden" name="columnid" value="<%=columnid%>">
    <input type="hidden" name="rowno" value="<%=rowno%>">
    <table border="0" width="100%">
        <tr height=40>
            <td align=center>&nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                ���ƣ�<input type="text" name="key" value="">
                ��ֵ��<input type="text" name="val" value="">
                <input type="button" value="����" name="add" class=tine onclick="SaveKeyVal();">
            </td>
        </tr>
        <tr>
            <td align="center">
                �б����ͣ�<input type="radio" name="listtype" value="0" checked>��ѡ&nbsp;&nbsp;&nbsp;&nbsp;
                          <input type="radio" name="listtype" value="1">��ѡ
            </td>
        </tr>
        <tr>
            <td align="center">
                <!--select name="maincls" id="mainclsid" style="width:300px;height:300px;" multiple ondblclick="javascript:addSubclasses();"></select-->
                <div style="width: 500px;">
                    <ul id="zztree" class="ztree" style="width: 450px;"></ul>
                </div>
            </td>
        </tr>
        <tr height=40>
            <td align=center>
                <input type="button" value="   ����   " name="save" class=tine onclick="Save();">&nbsp;&nbsp;
                <input type="button" value="   �ر�   " name="close" class=tine onclick="window.close();">
            </td>
        </tr>
    </table>
</form>

</BODY>
</HTML>