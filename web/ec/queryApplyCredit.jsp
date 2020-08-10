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

    String uuid = ParamUtil.getParameter(request,"uuid");
    int start = ParamUtil.getIntParameter(request,"start",0);
    int rows = ParamUtil.getIntParameter(request,"rows",20);
    System.out.println("uuid==" + uuid);
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心--授信申请查询</title>
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
                <td>授信结果：</td><td><div id="resultid"></div></td>
            </tr>
            <tr>
                <td>授信状态：</td><td><div id="statusid"></div></td>
            </tr>
            <tr>
                <td>授信截止时间：</td><td><div id="expiryid"></div></td>
            </tr>
            <tr>
                <td>费率描述：</td><td><div id="rateid"></div></td>
            </tr>
            <tr>
                <td>授信额度：</td><td><div id="limitid"></div></td>
            </tr>
            <tr>
                <td>可用额度：</td><td><div id="usableid"></div></td>
            </tr>
            <tr>
                <td>审核不通过原因：</td><td><div id="errorid"></div></td>
            </tr>
        </table>
    </div>
</div>
<!--以下页面尾-->
</body>
<script>
    $(document).ready(function(){
        var uuid = "<%=uuid%>";
        htmlobj=$.ajax({
            url:"/queryApplyCredit.do",
            type:'post',
            dataType:'json',
            data:{
                uuid:uuid
            },
            async:false,
            cache:false,
            success:function(data){
                //{"result":"success","status":"-1","annual_rate":null,"expiry_date":null,"credit_limit":"0.0","credit_usable":"0.0","error":null}
                $("#statusid").html(data.status);
                $("#expiryid").html(data.expiry_date);
                $("#rateid").html(data.annual_rate);
                $("#limitid").html(data.credit_limit);
                $("#usableid").html(data.credit_usable);
                $("#errorid").html(data.error);
                $("#resultid").html(data.result);

            }
        });
    });
</script>
</html>
