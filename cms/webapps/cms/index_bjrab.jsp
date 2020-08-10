<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*"
        contentType="text/html;charset=gbk"
        %>

<%
    String username = ParamUtil.getParameter(request, "username");
    String password = ParamUtil.getParameter(request, "password", true);
    boolean doLogin = ParamUtil.getBooleanParameter(request, "doLogin");

    String errorMessage = "&nbsp;";

    if (doLogin)
    {
        IAuthManager authMgr = AuthPeer.getInstance();
        try
        {
            Auth authToken = authMgr.getAuth(username, password);
            if (authToken != null) {
                int siteid = authToken.getSiteID();
                session.setAttribute("CmsAdmin", authToken);
                session.setMaxInactiveInterval(60*60*1000);
                int modelnum = authMgr.getTemplateNum(siteid);
                if (modelnum == 0 && !username.equals("admin"))  {                    //转向模板选择页面
%>
<script type="text/javascript">
    var ret = confirm("选择已经存在的模板？");
    if (ret)
        window.location="register/webindex.jsp";
    else
    <%response.sendRedirect("index1.jsp");%>
</script>
<%
                } else                                                                  //转向登录成功页面
                    response.sendRedirect("index1.jsp");
            } else {
                errorMessage = "<font color=red>登陆失败!请重新输入用户名和密码!</font>";
            }
        }
        catch (UnauthedException e)
        {
            errorMessage = "<font color=red>登陆失败!请重新输入用户名和密码!</font>&nbsp;&nbsp;&nbsp;&nbsp;";
        }
        doLogin = false;
    }
%>

<html>
<head>
    <title>北京市无线电管理局</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <style type="text/css">
        <!--
        .btnOFF{padding:3px;border:1px outset;cursor:pointer;background-color:#ffffff;width:180px;height:18px;text-align:left;font-size:12px;text-valign:middle;}
        .ab1 {font-size: 12px;color: #666666;text-decoration: none;}
        -->
    </style>
    <link href="images/css.css" rel="stylesheet" type="text/css">

    <style type="text/css">
        <!--
        a:link {
            text-decoration: none;
        }
        a:visited {
            text-decoration: none;
        }
        a:hover {
            text-decoration: none;
        }
        a:active {
            text-decoration: none;
        }
        .STYLE1 {color: #005897}
        body {
            background-color: #FFFFFF;
        }
        -->
    </style>
</head>
<body>
<form action="index.jsp" name="loginForm" method="POST">
    <input type=hidden name=doLogin value=true>
    <table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3"><img src="images/tp_1.jpg" width="1024" height="134"></td>
        </tr>
        <tr>
            <td colspan="3"><img src="images/tp_2.jpg" width="1024" height="159"></td>
        </tr>
        <tr>
            <td><img src="images/tp_3.jpg" width="593" height="153"></td>
            <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td><img src="images/tp_5.jpg" width="250" height="52"></td>
                </tr>
                <tr>
                    <td><%=errorMessage%></td>
                </tr>
                <tr>
                    <td height="26" background="images/tp_6.jpg">
                        <input name="username" size="30"></td>
                </tr>
                <tr>
                    <td><img src="images/tp_8.jpg" width="250" height="49"></td>
                </tr>
                <tr>
                    <td height="26" background="images/tp_9.jpg">
                        <input name="password" type="password" size="33">
                    </td>
                </tr>
            </table></td>
            <td><img src="images/tp_4.jpg" width="181" height="153"></td>
        </tr>
        <tr>
            <td colspan="3"><img src="images/tp_10.jpg" width="1024" height="33"></td>
        </tr>
        <tr>
            <td><img src="images/tp_11.jpg" width="593" height="44"></td>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td><img src="images/tp_12.jpg" width="166" height="44"></td>
                    <td><input type=image src="images/dl.jpg" width="84" height="44"></td>
                </tr>
            </table></td>
            <td><img src="images/tp_13.jpg" width="182" height="44"></td>
        </tr>
        <tr>
            <td colspan="3"><img src="images/tp_14.jpg" width="1024" height="246"></td>
        </tr>
    </table>
</form>
<script language="javascript">document.forms[0].username.focus();</script>
</body>
</html>
