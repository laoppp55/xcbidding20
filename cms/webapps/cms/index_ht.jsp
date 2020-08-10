<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*"
        contentType="text/html;charset=gbk"
        %>

<%
    String username = ParamUtil.getParameter(request, "username");
    String password = ParamUtil.getParameter(request, "password", true);
    boolean doLogin = ParamUtil.getBooleanParameter(request, "doLogin");
    //System.out.println("password=" + password);
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
    <%response.sendRedirect("index1.jsp");%>// window.location="index1.jsp";
</script>
<%
                    //response.sendRedirect("register/webindex.jsp");
                } else                                                                  //转向登录成功页面
                    response.sendRedirect("index1.jsp");
            } else {
                errorMessage = "<font color=red>登陆失败!请重新输入用户名和密码!</font>";
            }
        }
        catch (UnauthedException e)
        {
            errorMessage = "<font color=red>登陆失败!请重新输入用户名和密码!</font>";
        }
        doLogin = false;
    }
%>
<html>
<head>
    <title>北京市基督教三自爱国运动委员会 北京市基督教教务委员会</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <style type="text/css">
        <!--
        .btnOFF{padding:3px;border:1px outset;cursor:pointer;background-color:#ffffff;width:180px;height:18px;text-align:left;font-size:12px;text-valign:middle;}
        .btnON{padding:3px;border:1px inset;background-color: #ffffff;width:180px;height:18px;text-align:left;color:red;cursor:hand;font-size:12px;text-valign:middle;}
        .ab1 {font-size: 12px;color: #666666;text-decoration: none;}
        -->

    </style>
    <link href="style/css_ht.css" rel="stylesheet" type="text/css">

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
            background-color: #F3F3F3;
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
        }
        -->
    </style>
    <script src="js/md5-min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function tijiao()
        {
            var username = loginForm.username.value;
            if (username == "")
            {
                alert("用户名不能为空");
                return false;
            }
            if (username.length <= 3)
            {
                alert("用户名长度必须3位以上");
                return false;
            }

            var passwd = loginForm.password.value;
            if (passwd == "")
            {
                alert("用户口令不能为空");
                return false;
            }
            if (passwd.length < 2)
            {
                alert("用户密码长度必须2位以上");
                return false;
            }

            //loginForm.password.value = hex_md5(passwd);

            return true;
        }
    </script>
</head>

<body>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="150"><img src="images/spxt.gif" width="1" height="1"></td>
    </tr>
    <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="21" background="images/jdt.jpg"><%=errorMessage%><img src="images/spxt.gif" width="1" height="1"></td>
            </tr>
            <tr>
                <td background="images/bj2.jpg">
                    <form action="index.jsp" name="loginForm" method="POST" onsubmit="return tijiao();">
                        <input type=hidden name=doLogin value=true>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="509"><img src="images/jd1t.jpg" width="509" height="445"></td>
                                <td align="center" valign="middle"><table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td><TABLE cellSpacing="0" cellPadding="0" width="100" align="center" border="0">
                                                    <TR>
                                                        <TD align="left"><TABLE cellSpacing="0" cellPadding="3" border="0">
                                                            <TR>
                                                                <TD align="left" class="black1">用户名称:</TD>
                                                            </TR>
                                                        </TABLE></TD>
                                                    </TR>
                                                </TABLE></td>
                                                <td><input name="username" type="text" class="a1" size="20"></td>
                                            </tr>
                                        </table></td>
                                    </tr>
                                    <tr>
                                        <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td><TABLE cellSpacing="0" cellPadding="0" width="100" align="center" border="0">
                                                    <TR>
                                                        <TD align="left"><TABLE cellSpacing="0" cellPadding="3" border="0">
                                                            <TR>
                                                                <TD align="left" class="black1">用户密码:</TD>
                                                            </TR>
                                                        </TABLE></TD>
                                                    </TR>
                                                </TABLE></td>
                                                <td><input name="password" type="password" class="a1" size="21"></td>
                                            </tr>
                                        </table></td>
                                    </tr>
                                    <tr>
                                        <td height="25">&nbsp;
                                            <!--table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <TABLE cellSpacing="0" cellPadding="0" width="100" align="center" border="0">
                                                            <TR>
                                                                <TD align="left">
                                                                    <TABLE cellSpacing="0" cellPadding="3" border="0">
                                                                        <TR>
                                                                            <TD align="left" class="black1">验证码:</TD>
                                                                        </TR>
                                                                    </TABLE>
                                                                </TD>
                                                            </TR>
                                                        </TABLE>
                                                    </td>
                                                    <td><input name="yzm" type="text" class="a1" size="6"></td>
                                                    <td width="90">&nbsp;</td>
                                                </tr>
                                            </table-->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="25" align="right">
                                            <input name="Submit" type="submit" class="a1" value="   登  录   "></td>
                                    </tr>
                                </table></td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
            <tr>
                <td height="21" background="images/jdt.jpg"><img src="images/spxt.gif" width="1" height="1"></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="25" align="right">技术支持：首都信息发展股份有限公司</td>
    </tr>
</table>
<script language="javascript">document.forms[0].username.focus();</script>
</body>
</html>
