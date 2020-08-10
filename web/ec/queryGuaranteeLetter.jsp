<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String sectionCode = ParamUtil.getParameter(request,"projsectioncode");
    int start = ParamUtil.getIntParameter(request,"start",0);
    int rows = ParamUtil.getIntParameter(request,"rows",20);
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心--保函申请结果查询</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

    <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

    <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
</head>
<body>
<!--以上页面头-->
<div class="main clearfix div_top div_bottom">
    <div class="personal_right_box">
        <table id="projectsid" width="875" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-top:25px;">
            <tr>
                <td>保函名称：</td><td><div id="glnameid"></div></td>
            </tr>
            <tr>
                <td>保函申请状态：</td><td><div id="statusid"></div></td>
            </tr>
            <tr>
                <td>项目名臣：</td><td><div id="projnameid"></div></td>
            </tr>
            <tr>
                <td>项目编号：</td><td><div id="projcodeid"></div></td>
            </tr>
            <tr>
                <td>标包名称：</td><td><div id="sectionnameid"></div></td>
            </tr>
            <tr>
                <td>标包编号：</td><td><div id="sectioncodeid"></div></td>
            </tr>
            <tr>
                <td>保证金数额：</td><td><div id="marginid"></div></td>
            </tr>
            <tr>
                <td>保函下载地址：</td><td><div id="urlid"></div></td>
            </tr>
        </table>
    </div>
</div>
<!--以下页面尾-->
</body>
<script>
    $(document).ready(function(){
        var sectionCode = "<%=sectionCode%>";
        //根据标包编码检查是否已经申请过了保函或者保证金子账号
        htmlobj=$.ajax({
            url:"/queryGLApplyResult.do",
            type:"POST",
            data: {
                section_code:encodeURI(sectionCode)
            },
            dataType:'json',
            async:false,
            success:function(data){
                $("#glnameid").html(data.gl_name);
                $("#statusid").html(data.status);
                $("#projnameid").html(data.project_name);
                $("#projcodeid").html(data.project_code);
                $("#sectionnameid").html(data.section_name);
                $("#sectioncodeid").html(data.section_code);
                $("#marginid").html(data.tender_bond);
                $("#urlid").html("<a href=\"" + data.guarantee_url + "\" target=\"_blank\">下载保函</a>");
            }
        });
    });
</script>
</html>
