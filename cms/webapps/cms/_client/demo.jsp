<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String info = ParamUtil.getParameter(request,"info");
    System.out.println("from server====" + info);
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>layDate Demo</title>
    <link rel="stylesheet" href="../css/skins/default/laydate.css" />
    <link rel="stylesheet" href="../css/demo.css" />
    <script src="../js/laydate.js"></script>
<style>
html{background-color:#E3E3E3; font-size:14px; color:#000; font-family:'微软雅黑'}
h2{line-height:30px; font-size:20px;}
a,a:hover{ text-decoration:none;}
pre{font-family:'微软雅黑'}
.box{width:970px; padding:10px 20px; background-color:#fff; margin:10px auto;}
.box a{padding-right:20px;}
</style>
</head>
<body>
<div style="width:970px; margin:10px auto;">
演示一：<input type="text" name="fdate" placeholder="请输入日期" class="laydate-icon" onclick="laydate()">
</div>
<div class="box">
演示二：<input type="text" name="sdate" class="laydate-icon" id="demo" value="2014-6-25更新">
</div>
<script>
;!function(){
    laydate({
       elem: '#demo'
    })
}();
</script>
</body>
</html>