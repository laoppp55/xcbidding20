<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-26
  Time: 下午1:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>zTree测试</title>
    <!--link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/zTreeStyle/zTreeStyle.css" />
    <script src="js/jquery-1.4.4.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/jquery.ztree.all.js" type="text/javascript" charset="utf-8"></script>

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

</head>
<script type="text/javascript">
    var zTree;
    var setting = {
        view:{
            addHoverDom:addHoverDom,
            removeHoverDom:removeHoverDom,
            selectedMulti:false
        },
        edit: {
            enable: true,
            editNameSelectAll:true,
            removeTitle:'删除',
            renameTitle:'重命名'
        },
        data: {
            /* keep:{
             parent:true,
             leaf:true
             }, */
            simpleData: {
                enable: true
            }
        },
        callback:{
            beforeRemove:beforeRemove,//点击删除时触发，用来提示用户是否确定删除（可以根据返回值 true|false 确定是否可以删除）
            beforeEditName: beforeEditName,//点击编辑时触发，用来判断该节点是否能编辑
            beforeRename:beforeRename,//编辑结束时触发，用来验证输入的数据是否符合要求(也是根据返回值 true|false 确定是否可以编辑完成)
            onRemove:onRemove,//(beforeRemove返回true之后可以进行onRemove)删除节点后触发，用户后台操作
            onRename:onRename,//编辑后触发，用于操作后台
            beforeDrag:beforeDrag,//用户禁止拖动节点
            onClick:clickNode//点击节点触发的事件
        }
    };
    var zNodes =[
        { id:1, pId:0, name:"父节点 1", open:true},
        { id:11, pId:1, name:"去百度",url:'http://www.baidu.com',target:'_blank'},
        { id:12, pId:1, name:"叶子节点 1-2"},
        { id:13, pId:1, name:"叶子节点 1-3"},
        { id:2, pId:0, name:"父节点 2", open:true},
        { id:21, pId:2, name:"叶子节点 2-1"},
        { id:22, pId:2, name:"叶子节点 2-2"},
        { id:23, pId:2, name:"叶子节点 2-3"},
        { id:3, pId:0, name:"父节点 3", open:true},
        { id:31, pId:3, name:"叶子节点 3-1"},
        { id:32, pId:3, name:"叶子节点 3-2"},
        { id:33, pId:3, name:"叶子节点 3-3"}
    ];
    $(document).ready(function(){
        zTree = $.fn.zTree.init($("#tree"), setting, zNodes);
    });
    function beforeRemove(e,treeId,treeNode){
        return confirm("你确定要删除吗？");
    }
    function onRemove(e,treeId,treeNode){
        if(treeNode.isParent){
            var childNodes = zTree.removeChildNodes(treeNode);
            var paramsArray = new Array();
            for(var i = 0; i < childNodes.length; i++){
                paramsArray.push(childNodes[i].id);
            }
            alert("删除父节点的id为："+treeNode.id+"\r\n他的孩子节点有："+paramsArray.join(","));
            return;
        }
        alert("你点击要删除的节点的名称为："+treeNode.name+"\r\n"+"节点id为："+treeNode.id);
    }
    function beforeEditName(treeId,treeNode){
        /* if(treeNode.isParent){
         alert("不准编辑非叶子节点！");
         return false;
         } */
        return true;
    }
    function beforeRename(treeId,treeNode,newName,isCancel){
        if(newName.length < 3){
            alert("名称不能少于3个字符！");
            return false;
        }
        return true;
    }
    function onRename(e,treeId,treeNode,isCancel){
        alert("修改节点的id为："+treeNode.id+"\n修改后的名称为："+treeNode.name);
    }
    function clickNode(e,treeId,treeNode){
        if(treeNode.id == 11){
            location.href=treeNode.url;
        }else{
            alert("节点名称："+treeNode.name+"\n节点id："+treeNode.id);
        }
    }
    function beforeDrag(treeId,treeNodes){
        return false;
    }
    var newCount = 1;
    function addHoverDom(treeId,treeNode){
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                + "' title='添加子节点' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) btn.bind("click", function(){
            //在这里向后台发送请求保存一个新建的叶子节点，父id为treeNode.id,让后将下面的100+newCount换成返回的id
            //zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"新建节点" + (newCount++)});
            alert("开始添加节点")
            return false;
        });
    }
    function removeHoverDom(treeId,treeNode){
        $("#addBtn_"+treeNode.tId).unbind().remove();
    }
</script>
<body>
<ul id="tree" class="ztree"></ul>
</body>
</html>