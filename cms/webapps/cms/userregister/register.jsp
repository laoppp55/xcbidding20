<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%
    String username = ParamUtil.getParameter(request,"username");
    String password = ParamUtil.getParameter(request,"passWord1");
    String email = ParamUtil.getParameter(request,"email");
    int docreate = ParamUtil.getIntParameter(request,"doCreate",0);
    IUregisterManager regMgr = UregisterPeer.getInstance();
    String sitename = request.getServerName();
    int Siteid = regMgr.getSiteid(sitename);
    if (docreate == 1) {
        Uregister ure = new Uregister();
        ure.setMemberid(username);
        ure.setPassword(password);
        ure.setEmail(email);
        ure.setSiteid(Siteid);
        int code = regMgr.insert_Info(ure);
        System.out.println("code=" + code);
        if(code==0){
            response.sendRedirect("index.jsp?username="+username+"&siteid=" + Siteid);
            session.setAttribute("username",username);
        }else{
            out.println("<script   lanugage=\"javascript\">alert(\"ע��ʧ�ܣ�������ע�ᣡ\");window.location=\"register.jsp\";</script>");
        }
    }
%>

<html>
<head>
<title>��ӭע��</title>
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
    objXmlc.open("POST", "checkUsername.jsp?username="+name + "&siteid=<%=Siteid%>", false);
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
        objXmlc.open("POST", "CheceEmail.jsp?email="+Email + "&siteid=<%=Siteid%>", false);
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
    objXmlc.open("POST", "CheceVerify.jsp?Verify="+verify, false);
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
    document.all.cod.src="drawImage.jsp";
}
</script>
</head>
<body>
<form name="form" id="form" method="POST" >
    <input type="hidden" name="startflag" value="1">
    <input type="hidden" name="doCreate" value="1">
    <table width="800" border="0" cellpadding="0" cellspacing="0" >
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
                <input id="txtVerify" name="txtVerify" type="text" size="10"/>&nbsp;<img  name="cod" src="drawImage.jsp" border=1>&nbsp;&nbsp;<a href="#" onclick="javascript:shuaxin()">�������?����һ��</a></td>
            <td align="left"><div id="v_mag"></div></td>
        </tr>
        <tr>
            <td align="right"><input type="button" value="ע��"  onclick="javascript:check()"/></td>
            <td></td>
            <td></td>
        </tr>
    </table>
</form>
</body>
</html>
