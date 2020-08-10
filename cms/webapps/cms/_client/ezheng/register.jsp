<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.feedback.FeedbackPeer" %>
<%@ page import="com.bizwink.webapps.feedback.IFeedbackManager" %>
<%
    String username = ParamUtil.getParameter(request,"username");
    String password = ParamUtil.getParameter(request,"passWord1");
    String email = ParamUtil.getParameter(request,"email");
    int docreate = ParamUtil.getIntParameter(request,"doCreate",0);
    IUregisterManager regMgr = UregisterPeer.getInstance();
    String sitename = request.getServerName();
   IFeedbackManager feedMgr = FeedbackPeer.getInstance();
   int siteid = feedMgr.getSiteID(sitename);
    int Siteid = siteid;
    if (docreate == 1) {
        Uregister ure = new Uregister();
        ure.setMemberid(username);
        ure.setPassword(password);
        ure.setEmail(email);
        ure.setSiteid(Siteid);
        int code = regMgr.insert_Info(ure);
        System.out.println("code=" + code);
        if(code==0){
            response.sendRedirect("login.jsp");
            session.setAttribute("username",username);
        }else{
            out.println("<script   lanugage=\"javascript\">alert(\"ע��ʧ�ܣ�������ע�ᣡ\");window.location=\"register.jsp\";</script>");
        }
    }
%>
<html>
    <head>
        <title></title>
    <script type="text/JavaScript">
function check_user() {
    var name = document.all.username.value;
    if(name ==""){
        var message = "<font color=red>�������û�����<font>";
        document.getElementById("u_mag").innerHTML = message;
        return false;
    }if(name.length <5||name.lenght >20){
    var message = "<font color=red>�û�������Ϊ5-20���ַ���<font>";
    document.getElementById("u_mag").innerHTML = message;
    return false;
}else{
    var objXmlc;
    var ref = window.location.href;
    if (window.ActiveXObject){
        objXmlc = new ActiveXObject("Microsoft.XMLHTTP");
    }else if (window.XMLHttpRequest){
        objXmlc = new XMLHttpRequest();
    }
    objXmlc.open("POST", "/_commons/checkUsername.jsp?username="+name + "&siteid=<%=Siteid%>", false);
    objXmlc.send(null);
    var res = objXmlc.responseText;
    var re = res.split('-');
    var retstrs = re[0];
    if(retstrs==0){
        var message = "<font color=red>�û�������ʹ�ã���<font>";
        document.getElementById("u_mag").innerHTML = message;
    }if(retstrs==1){
    var message = "<font color=red>�û����Ѿ���ע�᲻����ʹ�ã���<font>";
    document.getElementById("u_mag").innerHTML = message;
    document.all.username.value ="";
    return false;
}
}
}
function check_email() {
    var Email = document.all.email.value;
    if(Email ==""){
        var message = "<font color=red>�����������ַ��<font>";
        document.getElementById("e_mag").innerHTML = message;
        return false;
    }else{
        var objXmlc;
        var ref = window.location.href;
        if (window.ActiveXObject){
            objXmlc = new ActiveXObject("Microsoft.XMLHTTP");
        }else if (window.XMLHttpRequest){
            objXmlc = new XMLHttpRequest();
        }
        objXmlc.open("POST", "/_commons/CheceEmail.jsp?email="+Email + "&siteid=<%=Siteid%>", false);
        objXmlc.send(null);
        var res = objXmlc.responseText;
        var re = res.split('-');
        var retstrs = re[0];
        if(retstrs==0){
            var message = "<font color=red>�������ʹ�ã���<font>";
            document.getElementById("e_mag").innerHTML = message;
        }if(retstrs==1){
        var message = "<font color=red>�����Ѿ���ע�᲻����ʹ�ã���<font>";
        document.getElementById("e_mag").innerHTML = message;
        document.all.email.value ="";
        return false;
    }
    }
}
function checkPassword1(){
    var passWord1 = document.getElementById("passWord1").value;
    if(passWord1 == ""){
        document.getElementById("p_mag1").innerHTML = "<font color=red>���벻��Ϊ�գ�</font>";
        return false;
    }if(passWord1.length<5 ||passWord1.length>20){
    document.getElementById("p_mag1").innerHTML = "<font color=red>���볤��Ϊ6��20���ַ���</font>";
    document.getElementById("passWord1").value="";
    return false;
}
}
function checkPassword2(){
    var passWord1 = document.getElementById("passWord1").value;
    var psaaWord2 = document.getElementById("passWord2").value;
    if(passWord1!=psaaWord2){
        document.getElementById("p_mag1").innerHTML = "<font color=red>������������벻һ�£����������룡</font>";
        document.getElementById("passWord1").value="";
        document.getElementById("passWord2").value="";
        return false;
    }else{
        document.getElementById("p_mag1").innerHTML = "<font color=red>�������������һ�£�</font>";
    }
}
function check(){
    var name = document.getElementById("username").value;
    var email = document.getElementById("email").value;
    var pass = document.getElementById("passWord1").value;
    var yanzheng = document.getElementById("txtVerify").value;
    var verify = document.getElementById("txtVerify").value;
    if(name == ""){
        alert("�û�������Ϊ��");
        return false;
    }if(email ==""){
    alert("���䲻��Ϊ��");
    return false;
}if(pass ==""){
    alert("���벻��Ϊ��");
    return false;
}if(yanzheng ==""){
    alert("��֤�벻��Ϊ��");
    return false;
}else{
    var objXmlc;
    if (window.ActiveXObject){
        objXmlc = new ActiveXObject("Microsoft.XMLHTTP");
    }else if (window.XMLHttpRequest){
        objXmlc = new XMLHttpRequest();
    }
    objXmlc.open("POST", "/_commons/CheceVerify.jsp?Verify="+verify, false);
    objXmlc.send(null);
    var res = objXmlc.responseText;
		//alert(res);
    var re = res.split('-');
    var retstrs = re[0];
    if(retstrs==0){
        var message = "<font color=red>��֤����󣡣�<font>";
        document.getElementById("v_mag").innerHTML = message;
        document.all.txtVerify.value ="";
        shuaxin();
        return false;
    }
}
    document.all.form.action = "register.jsp";
    document.all.form.submit();
}

function shuaxin(){
    document.all.cod.src="/_commons/drawImage.jsp";
}
</script>
<style type="text/css">
<!--.biz_table{ border:0 dashed null;
 } 
.biz_table td{ font-size:15px; color:#FF0000; font-family:���� ; text-align:left;
}
.biz_table input{ font-size:15px;  size:15px;

}
biz_table img{ border:0;
}
-->
</style></head>
    <body leftmargin="0" topmargin="0">
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
        <meta content="bzwink" name="author" />
        <meta content="��Ʒ����" name="description" />
        <meta content="��ױƷ��ʮ���塢���Ρ�����Ʒ" name="keywords" />
        <link href="/css/link.css" rel="stylesheet" /><%@include file="/www_chinabuy360_cn/include/top.shtml" %>
        <table cellspacing="0" cellpadding="0" width="1006" border="0">
            <tbody>
                <tr>
                    <td width="6" bgcolor="#ececec">&nbsp;</td>
                    <td width="32"><img alt="" src="/images/logo_leftgap02.gif" /></td>
                    <td align="center" width="220"><img height="23" alt="" width="210" border="0" src="/images/category_view.gif" /></td>
                    <td width="740" bgcolor="#ececec">
                    <table cellspacing="0" cellpadding="0" width="730" bgcolor="#ececec" border="0">
                        <tbody>
                            <tr>
                                <td width="10"><img height="30" alt="" width="10" border="0" src="/images/keyword_leftgap.gif" /></td>
                                <td width="730"><img height="10" alt="" width="2" align="absMiddle" border="0" src="/images/notice_bullet.gif" />&nbsp;<font style="FONT-SIZE: 12px"><strong>�û�ע��</strong></font></td>
                            </tr>
                        </tbody>
                    </table>
                    </td>
                    <td width="8" bgcolor="#ececec"></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
                <tr height="10">
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" width="960" align="center" border="0">
            <tbody>
                <tr>
                    <td valign="top" width="230"></td>
                    <td valign="top" align="center" width="730">
                    <table style="WIDTH: 112px; HEIGHT: 29px" cellspacing="1" cellpadding="1" width="112" align="left" border="0">
                        <tbody>
                            <tr>
                                <td width="60"><table cellpadding=0   cellspacing=0      class="biz_table"><form name="form" id="form" method="POST" >
    <input type="hidden" name="startflag" value="1">
    <input type="hidden" name="doCreate" value="1">
    <table width="800" border="0" cellpadding=0   cellspacing=0      class="biz_table" >
        <tr>
            <td width="150" align="right">��&nbsp;��&nbsp;��:</td>
            <td width="300" align="left">&nbsp;&nbsp;
                <input id="username" name="username" type="text" value="�������û���" size="18" onFocus="if (value =='�������û���'){value =''}" onBlur="check_user()"/></td>
            <td align="left"><div id="u_mag"></div></td>
        </tr>
        <tr>
            <td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>
            <td align="left">&nbsp;&nbsp;
                <input id="email" name="email" type="text" size="18" onBlur="check_email()"/></td>
            <td align="left"><div id="e_mag"></div></td>
        </tr>
        <tr>
            <td align="right">��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>
            <td align="left">&nbsp;&nbsp;
                <input name="passWord1" id="passWord1" type="password" size="19" onBlur="javascript:checkPassword1()"/></td>
            <td align="left"><div id="p_mag1"></div></td>
        </tr>
        <tr>
            <td align="right">ȷ������:</td>
            <td align="left">&nbsp;&nbsp;
                <input name="passWord2" id="passWord2" type="password" size="19" onBlur="javascript:checkPassword2()"/></td>
            <td align="left"><div id="p_mag2"></div></td>
        </tr>
        <tr>
            <td align="right">��&nbsp;֤&nbsp;��:</td>
            <td align="left">&nbsp;&nbsp;
                <input id="txtVerify" name="txtVerify" type="text" size="10"/>&nbsp;<img  name="cod" src="/_commons/drawImage.jsp" border=1>&nbsp;&nbsp;<a href="#" onclick="javascript:shuaxin()">�������?����һ��</a></td>
            <td align="left"><div id="v_mag"></div></td>
        </tr>
        <tr>
            <td align="right"><input type="button" value="ע��"  onclick="javascript:check()"/></td>
            <td></td>
            <td></td>
        </tr>
    </table>
</form></td>
                            </tr>
                        </tbody>
                    </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
                <tr height="30">
                    <td></td>
                </tr>
            </tbody>
        </table>
        <%@include file="/www_chinabuy360_cn/include/low.shtml" %>
    </body>
</html>