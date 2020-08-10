<%@ page import="com.bizwink.util.ParamUtil" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
  int errcode = ParamUtil.getIntParameter(request,"errcode",0);
  String refer_url = request.getHeader("referer");
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>北京市西城区公共资源交易系统</title>
  <link href="/css/basis.css" rel="stylesheet" type="text/css">
  <link href="/css/program_style.css" rel="stylesheet" type="text/css">
  <link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
  <script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>
  <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
  <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
  <script src="/js/users.js" type="text/javascript"></script>
  <script language="javascript">
      var errcode = <%=errcode%>;
      $(document).ready(function(){
          if (errcode == -1 || errcode == -2 || errcode == -3) {
              $("#usermsg").html("用户名或者密码错");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -4) {
              $("#usermsg").html("验证码错，请重新输入验证码");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -5) {
              $("#usermsg").html("运行环境初始化错误，请联系客服人员");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -6) {
              $("#usermsg").html("用户被暂时停止登录，请联系客服人员");
              $("#usermsg").css({color:"red"});
          }
      });

      function loginsubmit(form) {
          var name = form.username.value;
          var pass = form.pwd.value;
          var yzcode = form.yzcode.value;

          if (name==null || name == "") {
              $.msgbox({
                  height:120,
                  width:250,
                  content:{type:'alert', content:'用户名不能为空'},
                  animation:0,        //禁止拖拽
                  drag:false          //禁止动画
                  //autoClose: 10       //自动关闭
              });
              return false;
          }

          if (pass==null || pass == "") {
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

          if (yzcode==null || yzcode == "") {
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
      }
  </script>
</head>

<body>
<div class="full_box">
  <div class="top_box">
    <!--#include virtual="/inc/head.shtml"-->
  </div>
  <div class="menu_box">
    <!--#include virtual="/inc/menu.shtml"-->
  </div>
</div>

<!--以上页面头-->
<div class="main div_top clearfix">
  <table width="1200" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-bottom:200px;">
    <tbody><tr>
      <td height="60" bgcolor="#f6f4f4" class="blue_title">&nbsp;&nbsp;&nbsp;登录</td>
    </tr>
    <tr>
      <td align="center" bgcolor="#FFFFFF">
        <form name="loginform" method="post" action="/login.do" onsubmit="return loginsubmit(loginform)">
          <input type="hidden" name="doLogin" value="true">
          <input type="hidden" name="refer" value="<%=refer_url%>">
          <table width="900" border="0" cellspacing="3" cellpadding="0">
            <tbody><tr>
              <td width="218" align="right" valign="middle"></td>
              <td width="673" height="40" align="left" valign="bottom"> </td>
            </tr>
            <tr>
              <td align="right" valign="middle">用户名：</td>
              <td align="left" valign="middle"><input type="text" name="username" class="input_txt" size="25" autocomplete="off"></td>
            </tr>
            <tr>
              <td align="right" valign="middle"></td>
              <td height="20" align="left" valign="bottom" class="w_red"><div id="usermsg"></div></td>
            </tr>
            <tr>
              <td align="right" valign="middle">密码：</td>
              <td align="left" valign="middle"><input type="password" name="pwd" class="input_txt" size="25" autocomplete="new-password"></td>
            </tr>
            <tr>
              <td align="right" valign="middle"></td>
              <td height="20" align="left" valign="bottom" class="w_red"></td>
            </tr>
            <tr>
              <td align="right" valign="middle">验证码：</td>
              <td align="left" valign="middle"><span style="float:left; display:block"><input type="text" name="yzcode" class="input_txt" size="15" autocomplete="off"></span>
                <span style="float:left; display:block; margin-left:10px;"><img src="/users/image.jsp" height="40px" id="yzImageID" name="yzcodeimage" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">看不清，换一张</a></span></td>
            </tr>
            <tr>
              <td align="right" valign="middle"></td>
              <td height="20" align="left" valign="bottom" class="w_red"></td>
            </tr>
            <tr>
              <td align="right" valign="middle"></td>
              <td><input name="ok" type="submit" class="regist_btn" value="登录"></td>
            </tr>
            <tr>
              <td align="right" valign="middle" height="80"></td>
              <td></td>
            </tr>
            </tbody></table>
        </form>
      </td>
    </tr>
    </tbody></table>
</div>
<!--以下页面尾-->
</body>
</html>
