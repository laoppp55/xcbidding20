<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.bjhqfw.shetuan.ISheTuanManager" %>
<%@ page import="com.bizwink.cms.bjhqfw.shetuan.SheTuanPeer" %>
<%@ page import="com.bizwink.cms.bjhqfw.shetuan.SheTuan" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("/webbuilder/index.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int startflag = ParamUtil.getIntParameter(request,"startflag",0);
    String stname = ParamUtil.getParameter(request,"stname");
    String lianxiren = ParamUtil.getParameter(request,"lianxiren");
    String phone = ParamUtil.getParameter(request,"phone");
    String email = ParamUtil.getParameter(request,"email");
    String username = ParamUtil.getParameter(request,"username");
    String passwd = ParamUtil.getParameter(request,"passwd");

    if(startflag == 1){
        ISheTuanManager sMgr = SheTuanPeer.getInstance();
        SheTuan st = new SheTuan();
        st.setStname(stname);
        st.setLianxiren(lianxiren);
        st.setPhone(phone);
        st.setEmail(email);
        st.setUsername(username);
        st.setPasswd(passwd);
        sMgr.createSheTuan(st);
        response.sendRedirect("index.jsp");
    }

%>
<html>
<head>
    <title>�����û�����</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <meta http-equiv="Pragma" content="no-cache">
    <style type="text/css">
        TABLE {FONT-SIZE: 12px;word-break:break-all}
        BODY {FONT-SIZE: 12px;margin-top: 0px;margin-bottom: 0px; line-height:20px;}
        A:link {text-decoration:none;line-height:20px;}
        A:visited {text-decoration:none;line-height:20px;}
        A:active {text-decoration:none;line-height:20px; font-weight:bold;}
        A:hover {text-decoration:none;line-height:20px;}
    </style>
    <script language="javascript">
        function check(){
            if(document.form.stname.value == ""){
                alert("�������������ƣ�");
                return false;
            }
            if(document.form.lianxiren.value == ""){
                alert("��������ϵ�ˣ�");
                return false;
            }
            if(document.form.phone.value == ""){
                alert("������绰��");
                return false;
            }

            /*if(document.form.email.value == ""){
                alert("���������䣡");
                return false;
            }else{
                var strm = document.form.email.value   //�ύmail��ַ���ı���
                //var regm = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;//��֤Mail��������ʽ,^[a-zA-Z0-9_-]:��ͷ����Ϊ��ĸ,�»���,����,
                var regm = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;//��֤Mail��������ʽ,������������,
                if (!strm.match(regm) && strm!="")
                {
                    alert("�����ַ��ʽ������зǷ��ַ�!\n���飡");
                    document.form.email.select();
                    return false;
                }
            }*/

            var username = document.form.username.value;
            if(username == "" || username == null){
                alert("�������û�����");
                return false;
            } else {
                var objXmlc;
                var ref = window.location.href;
                if (window.ActiveXObject){
                    objXmlc = new ActiveXObject("Microsoft.XMLHTTP");
                }else if (window.XMLHttpRequest){
                    objXmlc = new XMLHttpRequest();
                }

                objXmlc.open("POST", "/_commons/checkShetuanUsername.jsp?username="+username,false);
                objXmlc.send(null);
                var res = objXmlc.responseText;
                var re = res.split('-');              
                if(re[0]==0){
                    var message = "<font color=red>�û�������ʹ�ã���<font>";
                    document.getElementById("p_register_user").innerHTML = message;
                }if(re[0]==1){
                    alert("�û����Ѿ���ע�᲻����ʹ�ã���");
                    var message = "<font color=red>�û����Ѿ���ע�᲻����ʹ�ã���<font>";
                    document.getElementById("p_register_user").innerHTML = message;
                    return false;
                }
            }

            if(document.form.passwd.value == ""){
                alert("�������û����");
                return false;
            }else{
                if(document.form.passwd.value.length < 6 || document.form.passwd.value.length > 16){
                    alert("���볤����Ҫ������ϣ�");
                    return false;
                }
            }
            if(document.form.passwd.value != document.form.passwd1.value){
                alert("������������벻��ͬ�����������룡");
                return false;
            }
            document.form.action = "create.jsp";
            document.form.submit();
        }
    </script>
</head>
<body>
<form name="form" action="" method="post">
    <input type="hidden" name="startflag" value="1">
    <center>
        <table width="90%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
            <tr>
                <td align="center">
                    <table width="70%" border="0" cellpadding="0">
                        <tr bgcolor="#F4F4F4" align="center">
                            <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">���������û���<b>��ɫ�Ǻű�ʾ����Ϊ������</b>��</td>
                        </tr>
                        <tr bgcolor="#d4d4d4" align="center">
                            <td>
                                <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">�������ƣ�&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="text" name="stname" value=""> <font color=red>*</font></td>
                                        <td align="left"></td>
                                    </tr>
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">��ϵ�ˣ�&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="text" name="lianxiren" value=""> <font color=red>*</font></td>
                                        <td align="left"></td>
                                    </tr>
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">�绰��&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="text" name="phone" value=""> <font color=red>*</font></td>
                                        <td align="left"></td>
                                    </tr>
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">�ʼ���&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="text" name="email" value=""></td>
                                        <td align="left"></td>
                                    </tr>
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">�û�����&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="text" name="username" value=""> <font color=red>*</font></td>
                                        <td align="left"><span id="p_register_user"></span></td>
                                    </tr>
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">�û����&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="password" name="passwd" value=""> <font color=red>*</font></td>
                                        <td align="left"></td>
                                    </tr>
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td width="20%" align="right">ȷ���û����&nbsp;</td>
                                        <td align="left" width="50%">&nbsp;<input type="password" name="passwd1" value=""> <font color=red>*</font></td>
                                        <td align="left"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td align="center">
                                <input type="button" name="ok" value=" ע �� " onclick="check()">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="button" name="ok" value=" �� �� " onclick=javascript:history.go(-1);>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

    </center>
</form>
</body>
</html>