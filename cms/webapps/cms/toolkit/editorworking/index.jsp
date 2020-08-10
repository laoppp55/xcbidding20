<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-6-6
  Time: 上午10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>按栏目统计工作量</title>
    <link rel="stylesheet" href="../../design/css/layui.css">
</head>
<body class="layui-layout-body">
<form class="layui-form">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header layui-bg-blue" align="center">编辑工作量统计分析</div>
        <div class="layui-side layui-bg-gray">
            <div class="layui-side-scroll">
                <ul class="layui-nav layui-nav-tree layui-bg-gray"  lay-filter="test">
                    <li class="layui-nav-item"><a href="javascript: statisticsByCol();"><span style="color:black" class="layui-icon-camera">按栏目统计信息发布量</span></a></li>
                    <li class="layui-nav-item"><a href="javascript: statisticsByDept();"><span style="color:black" class="layui-icon-camera">按部门统计信息发布量</span></a></li>
                    <li class="layui-nav-item"><a href="javascript: statisticsByDeptAndCol();"><span style="color:black" class="layui-icon-camera">按部门、栏目统计信息发布量</span></a></li>
                    <li class="layui-nav-item"><a href="javascript: statisticsByEditor();"><span style="color:black" class="layui-icon-camera">采编人员信息发布量统计</span></a></li>
                    <li class="layui-nav-item"><a href="javascript: statisticsByDeptEditor();"><span style="color:black" class="layui-icon-camera">部门采编人员信息发布量统计</span></a></li>
                    <li class="layui-nav-item"><a href="javascript: systemSetup();"><span style="color:black" class="layui-icon-camera">系统设置</span></a></li>
                    <li class="layui-nav-item"><a href="../index.jsp"><span style="color:black" class="layui-icon-camera">返回</span></a></li>
                </ul>
            </div>
        </div>

        <div class="layui-body" style="left: 100px;top: 40px;">
            <!-- 内容主体区域 -->
            <div id="maincontant" style="padding:5px;"></div>
        </div>

        <div class="layui-footer"></div>
    </div>
</form>

<script src="../../js/jquery-1.11.1.min.js"></script>
<script src="../../design/layui.js"></script>
<!--引用xtree-->
<script src="../../design/layui-xtree.js"></script>

<script>
    //JavaScript代码区域
    layui.use(["element","form"], function(){
        var element = layui.element;
        var form = layui.form;
    });

    function statisticsByCol() {
        var htmlStr = '<div class="layui-form-item"><div class="layui-input-block"><input type="radio" name="timeSlice" value="1" checked title="今天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="2" title="昨天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="3" title="一周">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="4" title="30天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="5" title="自定义时间:">';
        htmlStr = htmlStr + '<input type="text" name="startday" value="" placeholder="请输入开始时间" class="layui-input" style="width:200px;display:inline;">-';
        htmlStr = htmlStr + '<input type="text" name="endday" value="" placeholder="请输入结束时间" class="layui-input" style="width:200px;display:inline;">&nbsp;&nbsp;&nbsp;';
        htmlStr = htmlStr + '<input type="button" name="query" value="查询" class="layui-btn"><input type="button" name="export" value="导出EXCEL" class="layui-btn"><div></div></br></br>';
        htmlStr = htmlStr + '<img src="images/workingByCol.jpg" />';

        $("#maincontant").html(htmlStr);
        var form = layui.form;
        form.render();
    }

    function statisticsByDept() {
        var htmlStr = '<div class="layui-form-item"><div class="layui-input-block"><input type="radio" name="timeSlice" value="1" checked title="今天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="2" title="昨天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="3" title="一周">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="4" title="30天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="5" title="自定义时间:">';
        htmlStr = htmlStr + '<input type="text" name="startday" value="" placeholder="请输入开始时间" class="layui-input" style="width:200px;display:inline;">-';
        htmlStr = htmlStr + '<input type="text" name="endday" value="" placeholder="请输入结束时间" class="layui-input" style="width:200px;display:inline;">&nbsp;&nbsp;&nbsp;';
        htmlStr = htmlStr + '<input type="button" name="query" value="查询" class="layui-btn"><input type="button" name="export" value="导出EXCEL" class="layui-btn"><div></div></br></br>';
        htmlStr = htmlStr + '<img src="images/workingByDept.jpg" />';

        $("#maincontant").html(htmlStr);
        var form = layui.form;
        form.render();
    }

    function statisticsByDeptAndCol() {
        var htmlStr = '<div class="layui-form-item"><div class="layui-input-block"><input type="radio" name="timeSlice" value="1" checked title="今天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="2" title="昨天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="3" title="一周">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="4" title="30天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="5" title="自定义时间:">';
        htmlStr = htmlStr + '<input type="text" name="startday" value="" placeholder="请输入开始时间" class="layui-input" style="width:200px;display:inline;">-';
        htmlStr = htmlStr + '<input type="text" name="endday" value="" placeholder="请输入结束时间" class="layui-input" style="width:200px;display:inline;">&nbsp;&nbsp;&nbsp;';
        htmlStr = htmlStr + '<input type="button" name="query" value="查询" class="layui-btn"><input type="button" name="export" value="导出EXCEL" class="layui-btn"><div></div></br></br>';
        htmlStr = htmlStr + '<img src="images/workingByDeptAndCol.jpg" />';

        $("#maincontant").html(htmlStr);
        var form = layui.form;
        form.render();
    }

    function statisticsByEditor() {
        var htmlStr = '<div class="layui-form-item"><div class="layui-input-block"><input type="radio" name="timeSlice" value="1" checked title="今天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="2" title="昨天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="3" title="一周">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="4" title="30天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="5" title="自定义时间:">';
        htmlStr = htmlStr + '<input type="text" name="startday" value="" placeholder="请输入开始时间" class="layui-input" style="width:200px;display:inline;">-';
        htmlStr = htmlStr + '<input type="text" name="endday" value="" placeholder="请输入结束时间" class="layui-input" style="width:200px;display:inline;">&nbsp;&nbsp;&nbsp;';
        htmlStr = htmlStr + '<input type="button" name="query" value="查询" class="layui-btn"><input type="button" name="export" value="导出EXCEL" class="layui-btn"><div></div></br></br>';
        htmlStr = htmlStr + '<img src="images/workingByEditor.jpg" />';

        $("#maincontant").html(htmlStr);
        var form = layui.form;
        form.render();
    }

    function statisticsByDeptEditor() {
        var htmlStr = '<div class="layui-form-item"><div class="layui-input-block"><input type="radio" name="timeSlice" value="1" checked title="今天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="2" title="昨天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="3" title="一周">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="4" title="30天">';
        htmlStr = htmlStr + '<input type="radio" name="timeSlice" value="5" title="自定义时间:">';
        htmlStr = htmlStr + '<input type="text" name="startday" value="" placeholder="请输入开始时间" class="layui-input" style="width:200px;display:inline;">-';
        htmlStr = htmlStr + '<input type="text" name="endday" value="" placeholder="请输入结束时间" class="layui-input" style="width:200px;display:inline;">&nbsp;&nbsp;&nbsp;';
        htmlStr = htmlStr + '<input type="button" name="query" value="查询" class="layui-btn"><input type="button" name="export" value="导出EXCEL" class="layui-btn"><div></div></br></br>';
        htmlStr = htmlStr + '<img src="images/workingByDeptEditor.jpg" />';

        $("#maincontant").html(htmlStr);
        var form = layui.form;
        form.render();
    }

    function systemSetup() {
        var htmlStr = '<div class="layui-form-item"><div class="layui-input-block">' +
            '<img src="images/workingByDeptEditor.jpg" />' +
            '<div align="center"><input type="button" name="dosave" value="提交" onclick="javascript:doSaveConfig();" class="layui-btn layui-bg-blue layui-edge-bottom layui-btn-fluid"></div>'+
            '<div></div>';

        $("#maincontant").html(htmlStr);
        var form = layui.form;
        form.render();
    }

    function doSaveConfig() {
        alert("save config infomation");
    }
</script>
</body>
</html>
