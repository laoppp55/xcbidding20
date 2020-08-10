<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.*" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.feedback.FeedbackPeer" %>
<%@ page import="com.bizwink.webapps.feedback.IFeedbackManager" %>
<%
    String company=ParamUtil.getParameter(request,"company");
    String username = ParamUtil.getParameter(request,"username");
    String department=ParamUtil.getParameter(request,"department");
    String email = ParamUtil.getParameter(request,"email");
    String password = ParamUtil.getParameter(request,"passWord1");
    int docreate = ParamUtil.getIntParameter(request,"doCreate",0);

    IUregisterManager regMgr = UregisterPeer.getInstance();
    String sitename = request.getServerName();
    IFeedbackManager feedMgr = FeedbackPeer.getInstance();
    sitename = "www.cbcsd.org.cn";
    int siteid = feedMgr.getSiteID(sitename);
    if (docreate == 1) {
        Uregister ure = new Uregister();
        ure.setMemberid(username);
        ure.setPassword(password);
        ure.setEmail(email);
        ure.setSiteid(siteid);
        ure.setCompany(company);
        ure.setDepartment(department);
        ure.setLockflag(2);

        int code = regMgr.insert_Info(ure);
        if(code>0){
            out.println("<script   lanugage=\"javascript\">alert(\"ע��ɹ�,��Ⱥ���ˣ�\");window.location=\"/index.shtml\";</script>");
            //response.sendRedirect("/index.shtml");
            //Uregister ug = regMgr.login(username,password,siteid);
            //session.setAttribute("username",username);
        }else{
            out.println("<script   lanugage=\"javascript\">alert(\"ע��ʧ�ܣ�������ע�ᣡ\");window.location=\"register.jsp\";</script>");
        }
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head xmlns="">
    <title>CBCSD</title>
    <meta content="text/html; charset=gb2312" http-equiv="Content-Type" />
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/css/login.css" />
    <script type="text/javascript"  src="/js/jquery.min.js" ></script>
    <script type="text/javascript"  src="/js/jquery.jcarousel.pack.js" ></script>
    <script type="text/javascript"  src="/js/menu.js" ></script>
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
                objXmlc.open("POST", "/_commons/checkUsername.jsp?username="+name + "&siteid=39", false);
                objXmlc.send(null);
                alert(objXmlc.responseText);
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
                objXmlc.open("POST", "/_commons/CheceEmail.jsp?email="+Email + "&siteid=1411", false);
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
                var re = res.split('-');
                var retstrs = re[0];
                if(retstrs==0){
                    var message = "<font color=red>��֤����󣡣�<font>";
                    document.getElementById("v_mag").innerHTML = message;
                    document.all.txtVerify.value ="";
                    //shuaxin();
                    return false;
                }
            }

            document.all.form.action = "register.jsp";
            document.all.form.submit();
        }

        function shuaxin(){
            var verify=document.getElementById('safecode');
            verify.setAttribute('src','/_commons/drawImage.jsp?dumy='+Math.random());
        }
    </script>
</head>
<body xmlns="">
<div class="main">
    <div class="box"><%@include file="/inc/head.shtml" %><div class="banner"><img alt="" src="/images/banner61.jpg" /></div>
        <div class="con">
            <div class="path"><span>��ǰλ�ã�</span><a href="/">��ҳ</a></div>
            <div class="bigmain">
                <div class="left">
                    <form id="Regformid" method="post" action="register.jsp?formtype=0" onSubmit="return check();" name="Regform">
                        <input type="hidden" name="startflag" value="1" />&nbsp;
                        <input type="hidden" name="doCreate" value="1" />
                        <input type="hidden" name="siteid" value="39" />

                        <div class="title"><img alt="" src="/images/loginone1.jpg" /></div>
                        <div class="tabone">
                            <div class="tab_title">��˾���ƣ�</div>
                            <div class="tab_input"><input name="company" type="text" /></div>
                            <div class="tab_grey"></div>
                            <div class="tab_red"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">������</div>
                            <div class="tab_input"><input name="username" id="username" onBlur="check_user()" onFocus="if (value =='�������û���'){value =''}" name="username" value="�������û���" type="text" /></div>
                            <div class="tab_grey" id="u_mag"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">���ţ�</div>
                            <div class="tab_input"><input name="department" type="text" /></div>
                            <div class="tab_grey"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">���䣺</div>
                            <div class="tab_input"><input id="email" onBlur="check_email()" name="email" type="text" /></div>
                            <div class="tab_grey" id="e_mag"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">��¼���룺</div>
                            <div class="tab_input"><input id="passWord1" type="password" onBlur="javascript:checkPassword1()" name="passWord1" /></div>
                            <div class="tab_grey" id="p_mag1"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">�ٴ�ȷ�����룺</div>
                            <div class="tab_input"><input id="passWord2" type="password" onBlur="javascript:checkPassword2()" name="passWord2" /></div>
                            <div class="tab_grey" id="p_mag2"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">��֤�룺</div>
                            <div class="tab_input"><input id="txtVerify" name="txtVerify" type="text" />&nbsp;<img alt="" border="1" name="safecode" src="/_commons/drawImage.jsp" />&nbsp;&nbsp;<a  href="javascript:shuaxin();"><span class="titlered">�������?����һ��</span></a></div>
                            <div class="tab_grey" id="v_mag"></div>
                        </div>
                        <div class="button"><input type="image" src="/images/button_login.jpg" value="ע��" /></div>
                    </form>
                </div>
                <div class="right">
                    <form id="loginid" method="post" action="login.jsp" name="loinform">
                        <input type="hidden" name="doLogin" value="true" />
                        <input type="hidden" name="siteid" value="39" />
                        <div class="title"><img alt="" src="/images/loginone2.jpg" /></div>
                        <div class="tabone">
                            <div class="tab_title">��˾���ƣ�</div>
                            <div class="tab_input"><input name="comp" type="text" /></div>
                            <div class="tab_grey"></div>
                            <div class="tab_red"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">������</div>
                            <div class="tab_input"><input name="userid" type="text" /></div>
                            <div class="tab_grey"></div>
                        </div>
                        <div class="tabone">
                            <div class="tab_title">��¼���룺</div>
                            <div class="tab_input"><input id="passwd" type="password" name="passwd" /></div>
                            <div class="tab_grey"></div>
                        </div>
                        <div class="button"><input type="image" src="/images/loginone3.jpg" value="��¼" /></div>
                    </form>
                </div>
            </div>
        </div><%@include file="/inc/tail.shtml" %><div class="clear"></div>
    </div>
</div>
<div class="bg-bottom"></div>
<p></p>
</body>
</html>