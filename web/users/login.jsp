<%@ page import="com.bizwink.util.ParamUtil" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
  int errcode = ParamUtil.getIntParameter(request,"errcode",0);
  System.out.println("errcode==" + errcode);
  String refer_url = request.getHeader("referer");
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>北京市西城区公共资源交易中心-企业法人登录</title>
  <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/list_more.css" rel="stylesheet" type="text/css">
  <link href="/ggzyjy/css/log.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

  <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

  <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
  <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
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
          } else if (errcode>0) {
              alert("用户注册成功");
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
<div class="main">
  <div class="logo_box">
    <div class="left"><a href="/ggzyjy/"><font size="6">北京市西城区公共资源交易中心</font></a></div>
    <div class="right">用户登录</div>
  </div>
</div>
<div class="main clearfix">
  <div class="login_box">
    <div class="login_box_in">
      <form name="loginform" method="post" action="/login.do" onsubmit="return loginsubmit(loginform)">
        <input type="hidden" name="doLogin" value="true">
        <input type="hidden" name="refer" value="<%=refer_url%>">
        <table width="380" border="0">
          <tbody>
          <tr>
            <td colspan="2" align="left" valign="bottom" class="w_red"><div id="usermsg"></div></td>
          </tr>
          <tr>
            <td class="txt_grey" colspan="2">用户名（企业完整名称） </td>
          </tr>
          <tr>
            <td valign="middle" colspan="2">
              <input name="username" type="text" class="input_but_1" id="userid" autocomplete="off" />
          </tr>
          <tr>
            <td class="txt_grey" colspan="2">用户密码</td>
          </tr>
          <tr>
            <td colspan="2">
              <input type="password" name="pwd" class="input_but_2" id="pwdid" autocomplete="new-password" />
            </td>
          </tr>
          <tr>
            <td class="txt_grey">验证码：</td>
          </tr>
          <tr>
            <td valign="middle" colspan="2"><span style="float:left; display:block"><input type="text" name="yzcode" class="input_yzm" autocomplete="off"></span>
              <span style="float:left; display:block; margin-left:10px;"><img src="/users/image.jsp" height="40px" id="yzImageID" name="yzcodeimage" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">换一张</a></span>
            </td>
          </tr>

          <!--tr>
            <td class="txt_grey">证书 </td>
          </tr>
          <tr>
            <td valign="middle">
              <input name="textfield1" type="text" class="input_but_1" id="textfield1" />
              <a href="#" class="txt_blue">刷新</a></td>
          </tr>
          <tr>
            <td class="txt_grey">证书密码</td>
          </tr>
          <tr>
            <td>
              <input name="textfield2" type="text" class="input_but_2" id="textfield2" /></td>
          </tr>
          <tr>
            <td class="txt_red">系统升级CA互认程序，如果无法正常显示证书名称，请下载并安装新的CA驱动程序。</td>
          </tr-->
          <tr>
            <td colspan="2"><input type="submit" class="input_but_3" />&nbsp;</td>
          </tr>
          <tr align="center">
            <td class="txt_grey"><a href="/users/userreg1.jsp">用户注册</a></td><td class="txt_grey"><a href="/users/findPwd.jsp">忘记密码</a></td>
          </tr>
          </tbody>
        </table>
      </form>
    </div>
  </div>
  <div class="right_box clearfix">企业用户登录</div>
</div>
<div class="main">
  <div class="txt_box">
    <p class="txt_red">温馨提示：</p>
    <p>1、建议使用谷歌浏览器或者360浏览器，初次使用用户请下载并认真阅读<a href="#">操作指南</a></p>
    <!--p>2、请使用CA证书登录，点击<a href="#">CA办理服务指南及驱动下载</a>查看服务办理流程或下载驱动程序</p-->
  </div>
</div>
</body>
</html>
