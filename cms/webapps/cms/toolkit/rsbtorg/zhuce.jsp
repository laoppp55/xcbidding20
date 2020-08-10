<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.register.*" %>
<%@page contentType="text/html;charset=gbk" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    String username = ParamUtil.getParameter(request, "username");
    String passwd = ParamUtil.getParameter(request, "passwd1");
    String name = ParamUtil.getParameter(request, "name");
    String phone = ParamUtil.getParameter(request, "phone");
    String company = ParamUtil.getParameter(request, "company");
    int usertype = ParamUtil.getIntParameter(request, "usertype", 0);
    if (startflag == 1) {
        Uregister reg = new Uregister();
        IUregisterManager regMgr = UregisterPeer.getInstance();
        reg.setName(username);
        regMgr.insertRegister(reg);
%>
<script type="text/javascript">
    alert("ע��ɹ���");
</script>
<%
        response.sendRedirect("denglu.jsp");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <title>ע��ҳ��</title>
    <link href="style.css" rel="stylesheet" type="text/css"/>
    <script language="JavaScript" type="text/javascript">
        String.prototype.length2 = function() {
            var cArr = this.match(/[^\x00-\xff]/ig);
            return this.length + (cArr == null ? 0 : cArr.length);
        }
        function checkname() {
            var userid = document.form1.userid.value;
            if (userid.length2() < 3 || userid.length2() > 15) {
                alert('������û�������Ӧ����3-15λ����������д�û�����');
                return false;
            }
            var date = new Date();
            var xmlhttp;
            if (window.ActiveXObject)
            {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            else if (window.XMLHttpRequest)
            {
                xmlhttp = new XMLHttpRequest();
            }
            xmlhttp.open("POST", "checkname.jsp?userid=" + userid, false);
            xmlhttp.send(null);
            var retstr = xmlhttp.responseText.replace(/\s/ig, '');
            //var retstr = xmlhttp.responseText;
            if (retstr != "success") {
                document.form1.nameflag.value = "1";
                document.getElementById("usernameflag").innerHTML = "<font color=red>" + retstr + "</font>";
                return false;
            } else if (retstr == "success") {
                document.form1.nameflag.value = "0";
                document.getElementById("usernameflag").innerHTML = "<font color=green>" + "��Ч���û���" + "</font>";
            }
        }

        function check() {
            if (document.form1.nameflag.value == "1") {
                alert('��������û�����Ч��');
                return false;
            }
            if (document.form1.userid.value.length2() < 3 || document.form1.userid.value.length2() > 15) {
                alert('������û�������Ӧ����3-15λ����������д�û�����');
                return false;
            }
            if (document.form1.userid.value == "") {
                alert('�������û�����');
                return false;
            } else if (document.form1.userid.value.indexOf("@") != -1) {
                alert('�û������ܺ���@,�����������û�����');
                return false;
            }

            if (document.form1.passwd1.value == "") {
                alert('���벻��Ϊ��!');
                return false;
            } else {
                if (document.form1.passwd1.value.length < 6 || document.form1.passwd1.value.length > 16) {
                    alert('���볤����Ҫ������ϣ�');
                    return false;
                }
            }
            if (document.form1.passwd2.value != document.form1.passwd1.value) {
                alert('ȷ�����������벻��ͬ,����������ȷ������!');
                return false;
            }
            if (document.form1.name.value == "") {
                alert('����д������');
                return false;
            }
            if (document.form1.phone.value == "") {
                alert('����д��ϵ�绰��');
                return false;
            }
            if (document.form1.company.value == "") {
                alert('����д���ڵ�λ��');
                return false;
            }
            document.form1.action = "zhuce.jsp";
            document.form1.submit();
        }


    </script>
</head>

<body>
<form name=form1 method="post">
    <input type="hidden" name="nameflag" value="0"/>
    <input type="hidden" name="startflag" value="1"/>
    <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center" valign="top">
                <table width="700" border="0" cellpadding="0" cellspacing="6" class="paddingtrlb">
                    <tr>
                        <td height="30" align="left" valign="top" bgcolor="#FFFFFF">&nbsp;</td>
                        <td align="left" valign="top" bgcolor="#FFFFFF" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="30" colspan="3" align="center" valign="top" bgcolor="#FFFFFF" class="fonttitle">��ҵ�û�ע��&nbsp; </td>
                    </tr>
                    <tr>
                        <td width="44%" align="right" valign="middle" bgcolor="#FFFFFF">�û�ID��</td>
                        <td width="56%" height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="userid" type="text" class="textborder" onblur="checkname()"/>
                        </label></td>
                        <td width="60%" align="left">
                            <div style="width:300px" id="usernameflag">��������Ҫʹ�õ��û���</div>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">���룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="passwd1" type="password" class="textborder"/>
                        </label></td>
                        <td align="left">������6-16���ַ���ɣ���ʹ��Ӣ����ĸ�����ֻ���š�</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">ȷ�����룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="passwd2" type="password" class="textborder"/>
                        </label></td>
                        <td align="left">��������һ����������������롣</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��֯�������룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_gode" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">��������֯�������롣</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��֯�������ƣ�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_name" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">��������֯�������ơ�</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�������룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_area_code" type="text" value="110000" class="textborder"/>
                        </label></td>
                        <td align="left">������������롣</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">ϵͳ/��ҵ���룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <select name="org_sys_code">
                                <option value="-1" selected>ѡ��ϵͳ/��ҵ����</option>
                            </select>
                        </label></td>
                        <td align="left">������ϵͳ/��ҵ���롣</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��λ���ͣ�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <select name="org_type">
                                <option value="-1" selected>ѡ��λ����</option>
                            </select>
                        </label></td>
                        <td align="left">�����뵥λ���͡�</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��λ��ϵ�ˣ�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_link_person" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">�����뵥λ��ϵ�ˡ�</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��ϵ�����֤���룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_person_id" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">��������ϵ�����֤���롣</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�ϼ���֯������</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_sup_code" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">        ������������롣</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��֯������ַ��</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_addr" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">��������֯������ַ��</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��֯�����ʱࣺ</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_post" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">��������֯�����ʱࡣ</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��ϵ�绰��</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_phone" type="text" class="textborder"/>
                        </label></td>
                        <td align="left">��������ϵ�绰��</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�ֻ����룺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_phone   " type="text" class="textborder"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��֯�������棺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_fax" type="text" class="textborder"/>
                        </label></td>
                    </tr>                    
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�������У�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_bank" type="text" class="textborder"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�˻����ƣ�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_account_name" type="text" class="textborder"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�����˺ţ�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_account" type="text" class="textborder"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��̨��λ���ʣ�</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <select name="org_hostility">
                                <option value="-1" selected>ѡ����̨��λ����</option>
                            </select>
                        </label></td>
                        <td align="left">��������̨��λ���ʡ�</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">��ַ��</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_web_site" type="text" class="textborder"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle" bgcolor="#FFFFFF">�������䣺</td>
                        <td height="35" align="left" valign="middle" bgcolor="#FFFFFF"><label>
                            <input name="org_mail" type="text" class="textborder"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td align="right" valign="bottom" bgcolor="#FFFFFF">&nbsp;</td>
                        <td height="25" align="left" valign="bottom" bgcolor="#FFFFFF" colspan="2"><label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" name="Submit" value="ȷ��" onclick="check()"/>
                        </label></td>
                    </tr>
                    <tr>
                        <td height="30" align="left" valign="top" bgcolor="#FFFFFF">&nbsp;</td>
                        <td align="left" valign="top" bgcolor="#FFFFFF" colspan="2">&nbsp;</td>
                    </tr>
                </table>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</form>
</body>
</html>
