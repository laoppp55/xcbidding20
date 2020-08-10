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

    if (doLogin) {
        String yzcode = ParamUtil.getParameter(request, "yzmcode");
        String yzcode_from_session = (String)session.getAttribute("randnum");
        IAuthManager authMgr = AuthPeer.getInstance();
        try{
            //��ȡ�û��˵�IP��ַ
            String user_ip = null;
            if (request.getHeader("x-forwarded-for") == null) {
                user_ip = request.getRemoteAddr();
            } else {
                user_ip = request.getHeader("x-forwarded-for");
            }

            Auth authToken = authMgr.getAuth(username, password,user_ip);
            if (yzcode!=null) {
                if (yzcode.equalsIgnoreCase(yzcode_from_session)) {
                    if (authToken != null) {
                        int siteid = authToken.getSiteID();
                        session.setAttribute("CmsAdmin", authToken);
                        session.setMaxInactiveInterval(60*60*1000);
                        int modelnum = authMgr.getTemplateNum(siteid);
                        if (modelnum == 0 && !username.equals("admin"))  {                    //ת��ģ��ѡ��ҳ��
%>
<script type="text/javascript">
    var ret = confirm("ѡ���Ѿ����ڵ�ģ�壿");
    if (ret)
        window.location="register/webindex.jsp";
    else
    <%response.sendRedirect("index1.jsp");%>// window.location="index1.jsp";
</script>
<%
                            //response.sendRedirect("register/webindex.jsp");
                        } else                                                                  //ת���¼�ɹ�ҳ��
                            response.sendRedirect("index1.jsp");
                    } else {
                        errorMessage = "<font color=red>��½ʧ��!�����������û���������!</font>";
                    }
                } else
                    errorMessage = "<font color=red>��֤�������������������֤��!</font>";
            } else {
                errorMessage = "<font color=red>��֤��Ϊ�գ���������֤��!</font>";
            }
        } catch (UnauthedException e){
            errorMessage = "<font color=red>��½ʧ��!�����������û���������!</font>";
        }
        doLogin = false;
    }
%>

<html>
<head>
    <title>���ݹ���ϵͳ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet href="images/cms.css" style="text:css">
    <style type="text/css">
        <!--
        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            background-color: #c3c3c3;
        }
        -->
    </style>
    <script src="js/md5-min.js" type="text/javascript"></script>
    <script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function change_yzcodeimage() {
            $("#yzImageID").attr("src","image.jsp?temp=" + Math.random());
        }

        function doTijiao() {
            var username = loginForm.username.value;
            if (username == ""){
                alert("�û�������Ϊ��");
                return false;
            }
            if (username.length <= 3){
                alert("�û������ȱ���3λ����");
                return false;
            }

            var passwd = loginForm.password.value;
            if (passwd == ""){
                alert("�û������Ϊ��");
                return false;
            }

            if (username!="admin") {
                if (passwd.length < 8){
                    alert("�û����볤�ȱ���8λ����");
                    return false;
                }

                var regex = /[0-9]/;
                if(!regex.test(passwd)){
                    alert("��������������");
                    return false;
                }

                regex = /[a-z]/;
                if(!regex.test(passwd)){
                    alert("����������Сд��ĸ");
                    return false;
                }

                regex = /[A-Z]/;
                if(!regex.test(passwd)){
                    alert("������������д��ĸ");
                    return false;
                }

                regex = /\W/;
                if(!regex.test(passwd)){
                    alert("���������������ַ�");
                    return false;
                }
            } else {
                if (passwd.length < 2){
                    alert("admin�û����볤�ȱ���2λ����");
                    return false;
                }
            }

            //loginForm.password.value = hex_md5(passwd);
            //loginForm.username.value = hex_md5(username);
            //return true;

            //htmlobj=$.ajax({url:"getLoginStatus.jsp?uid=" + username,cache:false,async:false});
            statusval = 0;   //htmlobj.responseText;
            if (statusval == 0) {
                loginForm.password.value = hex_md5(passwd);
                return true;
            } else {
                alert("���˺��Ѿ�������������¼��������������˳�");
                return false;
            }
        }
    </script>
</head>

<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="1%" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="61%" height="80" align="left" valign="middle" bgcolor="#FFFFFF"><img src="images/text.gif" width="248" height="53"></td>
        <td width="38%" align="right" valign="middle" bgcolor="#FFFFFF"><a href="http://www.bizwink.com.cn" target=_blank title="����ӯ�̶�������������޹�˾"><img src="images/logo.gif" width="133" height="44" border=0></a></td>
    </tr>
    <tr>
        <td colspan="3" background="images/yellow.gif"><img src="images/yellow.gif" width="1" height="9"></td>
    </tr>
    <tr align="center" valign="middle" bgcolor="eeeeee" background="images/bgpatten.gif">
        <td height="420" colspan="3" background="images/bgpatten.gif">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="3%" align="right"><img src="images/left1.gif" width="16" height="242"></td>
                    <td width="40%" valign="top" background="images/left_bg.gif">
                        <br><br><img src="images/welcome.gif"><br>
                    </td>
                    <td><img src="images/middle.gif" width="22" height="242"></td>
                    <td width="50%" valign="top" background="images/right_bg.gif">
                        <form action="index.jsp" name="loginForm" method="POST" onsubmit="return doTijiao();">
                            <input type=hidden name=doLogin value=true>
                            <table width="300" border="0" cellspacing="0" cellpadding="2">
                                <tr>
                                    <td height="60" colspan="2"><img src="images/denglu.gif" width="167" height="54"></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><%=errorMessage%></td>
                                </tr>
                                <tr height="34">
                                    <td><img src="images/name.gif" width="47" height="15"></td>
                                    <td><input name="username" size="20"></td>
                                </tr>
                                <tr height="34">
                                    <td><img src="images/password.gif" width="33" height="14"></td>
                                    <td><input name="password" type="password" size="20" autocomplete="off"></td>
                                </tr>
                                <tr height="30">
                                    <td><img src="images/button/yzm831.jpg" width="47" height="15"></td>
                                    <td><input name="yzmcode" size="6">
                                        <img src="image.jsp" id="yzImageID" name="yzcodeimage" align="absmiddle"/><a href="javascript:change_yzcodeimage();">�����壬��һ��</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td align=center colspan="2"><input type=image src="images/button_denglu.gif" width="62" height="23"></td>
                                </tr>
                            </table>
                        </form>
                    </td>
                    <td width="4%" align="left"><img src="images/right1.gif" width="15" height="242"></td>
                </tr>
            </table></td>
    </tr>
    <tr>
        <td colspan="3" background="images/line.gif"><img src="images/line.gif" width="1" height="2"></td>
    </tr>
    <tr bgcolor="c3c3c3">
        <td height="80" class="css">&nbsp; </td>
        <td height="80" class="css"><br>
            ��������: <a href="mailto:customer@bizwink.com.cn">customer@bizwink.com.cn </a> <a href="http://www.bizwink.com.cn" target=_blank><font color=black>Bizwink</font></a> Software Inc ��˾��Ȩ����2001-2008 </td>
        <td height="80" class="css">&nbsp;</td>
    </tr>
</table>
<script language="javascript">document.forms[0].username.focus();</script>
</body>
</html>
