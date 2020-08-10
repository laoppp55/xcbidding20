<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.filter" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.util.Encrypt" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%--
  Created by IntelliJ IDEA.
  User: petersong
  Date: 16-1-30
  Time: 下午7:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ApplicationContext appContext = SpringInit.getApplicationContext();
    int errcode = 0;
    String userid = "";
    String mphone = "";
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        userid = filter.excludeHTMLCode(ParamUtil.getParameter(request, "userid"));
        mphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "mphone"));
        String pwd = filter.excludeHTMLCode(ParamUtil.getParameter(request, "pwd"));
        boolean doUpdate = ParamUtil.getBooleanParameter(request,"doUpdate");
        if (doUpdate) {
            //获取用户信息
            Users us = usersService.getUserinfoByUseridAndMphone(userid, mphone);
            //如果用户信息不为空，调用发送邮件程序
            if (us != null) {
                if (us.getMPHONE().equals(mphone) && us.getUSERID().equals(userid))
                    errcode = usersService.updatePwdByUseridAndMphone(Encrypt.md5(pwd.getBytes()), userid, mphone);
                else
                    errcode = -2;
            } else {
                errcode = -1;
                System.out.println("未能获取用户信息");
            }
        }
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易中心-密码找回</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />

    <script src="/ggzyjy/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
    <script language="javascript">
        var errcode = <%=errcode%>;
        $(document).ready(function(){
            if (errcode > 0) {
                alert("用户密码注册成功");
                window.location.href="/users/login.jsp";
                return;
            } else if (errcode==-1 || errcode==-2){
                alert("您输入的用户名或者手机号码有错误，未能找到该用户");
                return;
            }
        });

        function change_yzcodeimage() {
            $("#yzImageID").attr("src","/users/image.jsp?temp=" + Math.random());
        }

        function trim(str) {
            var i;

            i=0;
            while (i<str.length && str.charAt(i)==' ') i++;
            str=str.substr(i);
            i=str.length-1;
            while (i>=0 && str.charAt(i)==' ') i--;
            str=str.substr(0,i+1);

            return str
        }

        function validpassword(){
            var pass1 = theform.pwd.value;
            var pass2 = theform.repwd.value;
            var allValid = true;

            if( trim(pass1)=="" ) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'请输入密码，密码不能为空！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            if( trim(pass2)=="" ) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'请输入确认密码，确认密码不能为空！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            if (pass1.indexOf(" ") != -1) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'密码中包括空格，请输入新密码！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            if (pass2.indexOf(" ") != -1) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'确认密码中包括空格，请输入确认密码！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            if( pass1.length < 6 ) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'密码长度至少6个字符！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            if( pass1.length != pass2.length ) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'两次输入的密码长度不一致！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            for(i=0;i<pass1.length;i++) {
                if( pass1.charAt(i) != pass2.charAt(i) ) {
                    $.msgbox({
                        height:120,
                        width:250,
                        content:{type:'alert', content:'两次输入的密码不一致!'},
                        animation:0,       //禁止拖拽
                        drag:false         //禁止动画
                        //autoClose: 10     //自动关闭
                    });
                    allValid = false;
                    break;
                }
            }

            return allValid;
        }

        function tijiao(form) {
            var pass = form.pwd.value;
            var confpass = form.repwd.value;
            var mphone = form.mphone.value;
            var yzcode = form.yzcode.value;

            if (pass == "") {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'密码不能为空，请填写密码'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            if (pass.length < 6) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'密码长度必须大于6位'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            if (pass != confpass) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'两次填写的密码不一致'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            if (mphone != "") {
                //var filter = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;     //验证电话号码是否正确
                var filter = /^1[3|4|5|8][0-9]\d{4,8}$/;                                   //验证手机号码是否正确
                flag = filter.test(mphone);
                if (!flag) {
                    $.msgbox({
                        height:120,
                        width:250,
                        content:{type:'alert', content:'手机号输入有误，请重新输入！'},
                        animation:0,        //禁止拖拽
                        drag:false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                    return false;
                }
            }

            if (yzcode == "") {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'验证码不能为空，请输入验证码'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            if (yzcode.length != 4) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'验证码输入不正确'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<div class="top_box">
    <div class="logo_box">
        <a href="/ggzyjy/" style="color: white">北京市西城区公共资源交易中心</a>
        <div class="reg_in" id="userInfos"><a href="/users/login.jsp">登录</a>|<a href="/users/userreg1.jsp">注册</a></div>
    </div>
</div>

<div class="main div_top clearfix">
    <table width="1200" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-bottom:180px;">
        <tr>
            <td height="60" bgcolor="#f6f4f4" class="blue_title">&nbsp;&nbsp;&nbsp;忘记密码</td>
        </tr>
        <tr>
            <td align="center" bgcolor="#FFFFFF">
                <form name="theform" method="post" action="findPwd.jsp" onsubmit="return tijiao(theform)">
                    <input type="hidden" name="doUpdate" value="true">
                    <table width="900" border="0" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="276" align="right" valign="middle"></td>
                            <td width="615" height="40" align="left" valign="bottom"> </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">用户名：</td>
                            <td align="left" valign="middle">
                                <input type="text" name="userid" class="input_txt" size="40" value="<%=(userid!=null)?userid:""%>"/></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">手机号：</td>
                            <td align="left" valign="middle">
                                <input type="text" name="mphone" class="input_txt" size="40" value="<%=(mphone!=null)?mphone:""%>"/></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">输入新密码：</td>
                            <td align="left" valign="middle">
                                <input type="password" name="pwd" class="input_txt" size="40" /></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">再次输入新密码：</td>
                            <td align="left" valign="middle">
                                <input type="password" name="repwd" class="input_txt" size="40" onblur="javascript:validpassword();"/></td>
                        </tr>
                        <!--tr>
                            <td align="right" valign="middle">短信验证码：</td>
                            <td align="left" valign="middle"><input type="text" name="dxcode" class="input_txt" size="15"/></td>
                        </tr-->
                        <tr>
                            <td align="right" valign="middle">验证码：</td>
                            <td align="left" valign="middle"><span style="float:left; display:block"><input type="text" name="yzcode" class="input_txt" size="15" autocomplete="off"></span>
                                <span style="float:left; display:block; margin-left:10px;"><img src="/users/image.jsp" height="40px" id="yzImageID" name="yzcodeimage" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">看不清，换一张</a></span></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle"></td>
                            <td align="left" valign="bottom" height="20"> </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle"></td>
                            <td align="left"><input name="send" type="submit" class="regist_btn" value="修改密码" /></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" height="80"></td>
                            <td></td>
                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
