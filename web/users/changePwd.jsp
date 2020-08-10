<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken==null) response.sendRedirect("/users/login.jsp");
  String userid = authToken.getUserid();
  BigDecimal siteid = BigDecimal.valueOf(1);
  Users user = null;
  int errcode = 0;
  ApplicationContext appContext = SpringInit.getApplicationContext();
  if (appContext!=null) {
    IUserService usersService = (IUserService)appContext.getBean("usersService");
    user = usersService.getUserinfoByUserid(userid);
    if (user==null) {
      response.sendRedirect("/users/error.jsp");
      return;
    } else {
      String yzcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "yzcode"));
      String yzcodeForSession = (String)session.getAttribute("randnum");
      boolean doUpdate = ParamUtil.getBooleanParameter(request,"doUpdate");
      if (doUpdate) {
        String oldpass = filter.excludeHTMLCode(ParamUtil.getParameter(request, "oldpwd"));
        String pass = filter.excludeHTMLCode(ParamUtil.getParameter(request, "pwd"));
        String confpass = filter.excludeHTMLCode(ParamUtil.getParameter(request, "repwd"));
        String password = null;
        try {
          password = Encrypt.md5(oldpass.getBytes());
          if (yzcode.equalsIgnoreCase(yzcodeForSession)) {           //验证码输入正确才可以进行密码修改
            if (password.equalsIgnoreCase(user.getUSERPWD())) {          //用户输入的老密码正确才可以执行密码修改
              if(pass.equals(confpass)) {                                //用户两次输入新密码相同修改密码
                errcode = usersService.changePassword(userid,Encrypt.md5(pass.getBytes()));
              } else {
                errcode = -4;
              }
            } else {
              errcode = -3;
            }
          } else {
            errcode = -1;
          }
        } catch (Exception e) {
          errcode = -2;
        }
      }
    }
  } else {
    response.sendRedirect("/users/error.jsp");
    return;
  }
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>北京市西城区公共资源交易系统--用户个人中心--公司信息管理</title>
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
          if (errcode == -2) {
              $("#usermsg").html("用户旧密码转换MD5报错");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -3) {
              $("#usermsg").html("用户输入旧密码错");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -1) {
              $("#usermsg").html("用户输入验证码错");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -4) {
              $("#usermsg").html("新密码两次输入不一致");
              $("#usermsg").css({color:"red"});
          } else if (errcode > 0) {
              alert("用户密码修改成功");
              window.location.href="/users/changePwd.jsp";
          }
      })

      function tijiao(form) {
          var oldpass = form.oldpwd.value;
          var pass = form.pwd.value;
          var confpass = form.repwd.value;
          var yzcode = form.yzcode.value;

          if (oldpass == "") {
              alert("旧密码不能为空");
              return false;
          }

          if (pass.length < 8) {
              alert("密码不能小于8位");
              return false;
          }

          if (pass != confpass) {
              alert("新密码两次填写不一致");
              return false;
          }

          //if (yzcode == "" || yzcode.length != 4) {
          //    alert("验证码不正确");
          //    return false;
          //}

          return true;
      }

      function sendyzcode() {
          alert("send code to mphone");
      }

      function logoff(prefix) {
          $.post("/users/logoff.jsp",{},
              function(data) {
                  if (data.indexOf("nologin") > -1) {
                      window.location.href="/index.shtml";
                  }
              }
          )
      }

  </script>
</head>

<body style="background-image: url('');height: 600px;">
<div class="top_box">
  <div class="logo_box">
    <a href="/ggzyjy/" style="color: white">北京市西城区公共资源交易中心</a>
    <div class="reg_in" id="userInfos"><a href="/users/login.jsp">登录</a>|<a href="/users/userreg1.jsp">注册</a></div>
  </div>
</div>

<!--以上页面头-->
<div class="main clearfix div_top div_bottom">
  <div class="companyinfo_left">
    <div class="title">个人中心</div>
    <ul>
      <li><a href="/ec/myBidinfos.jsp">投标项目管理</a></li>
      <!--li><a href="/users/personinfo.jsp?action=2">授信申请管理</a></li>
      <li><a href="/users/personinfo.jsp?action=3">保证金管理</a></li-->
      <li><a href="/users/companyinfo.jsp">公司信息管理</a></li>
      <li><a href="/users/updatereg.jsp">修改个人注册信息</a></li>
      <li><a href="/users/changePwd.jsp"><span style="color: red">修改密码</span></a></li>
    </ul>
  </div>
  <div class="personal_right_box">
    <div class="personal_right">
      <div class="p_r_title">修改密码</div>
    </div>
    <form name="regform" method="post" action="changePwd.jsp" onsubmit="return tijiao(regform)">
      <input type="hidden" name="doUpdate" value="true">
      <table width="875" border="0" cellspacing="3" cellpadding="0" class="regtable">
        <tbody><tr>
          <td width="215" align="right" valign="middle"></td>
          <td width="660" height="40" align="left" valign="bottom"> </td>
        </tr>
        <tr>
          <td align="right" valign="middle"><span class="hint_red">*</span> 用户名：</td>
          <td align="left" valign="middle"><%=user.getNICKNAME()%></td>
        </tr>
        <tr>
          <td align="right" valign="middle"></td>
          <td align="left" valign="bottom" height="20"> </td>
        </tr>
        <tr>
          <td align="right" valign="middle"><span class="hint_red">*</span> 旧密码：</td>
          <td align="left" valign="middle"><input type="password" name="oldpwd" class="input_txt" autocomplete="new-password" size="25">
            大写小写及数字组成！</td>
        </tr>
        <tr>
          <td align="right" valign="middle"></td>
          <td height="20" align="left" valign="bottom" class="w_red"></td>
        </tr>
        <tr>
          <td align="right" valign="middle"><span class="hint_red">*</span> 新密码：</td>
          <td align="left" valign="middle"><input type="password" name="pwd" class="input_txt" autocomplete="new-password" size="25">
            大写小写及数字组成！</td>
        </tr>
        <tr>
          <td align="right" valign="middle"></td>
          <td height="20" align="left" valign="bottom" class="w_red"></td>
        </tr>
        <tr>
          <td align="right" valign="middle"><span class="hint_red">*</span> 确认密码</td>
          <td align="left" valign="middle"><input type="password" name="repwd" class="input_txt" autocomplete="new-password" size="25"></td>
        </tr>
        <tr>
          <td align="right" valign="middle"></td>
          <td height="20" align="left" valign="bottom" class="w_red"></td>
        </tr>
        <tr>
          <td align="right" valign="middle">验证码：</td>
          <td align="left" valign="middle"><span style="float:left; display:block"><input type="text" name="yzcode" autocomplete="off" class="input_txt" size="15" autocomplete="off"></span>
            <span style="float:left; display:block; margin-left:10px;"><img src="/users/image.jsp" height="40px" id="yzImageID" name="yzcodeimage" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">看不清，换一张</a></span></td>
        </tr>
        <!--tr>
          <td align="right" valign="middle">手机验证码：</td>
          <td><span style="float:left; display:block"><input type="text" name="yzcode" class="input_txt" size="15"></span>
            <span style="float:left; display:block; margin-left:10px;"><a href="javascript:sendyzcode();">向注册手机发送验证吗</a></span></td>
        </tr-->
        <tr>
          <td align="right" valign="middle"></td>
          <td align="left" valign="bottom" height="20"> </td>
        </tr>
        <tr>
          <td align="right" valign="middle"></td>
          <td><input name="ok" type="submit" class="regist_btn" value="确认"></td>
        </tr>
        <tr>
          <td align="right" valign="middle" height="80"></td>
          <td></td>
        </tr>
        </tbody>
      </table>
    </form>
  </div>
</div>
<!--以下页面尾-->
</body>
<script language="javascript">
    $(document).ready(function(){
        //检测用户是否通过采购中心的审核
        var auditResult = "";
        htmlobj = $.ajax({
            url: "/users/showAuditResult.jsp?thetime=<%=System.currentTimeMillis()%>",
            type: 'post',
            dataType: 'json',
            data: {},
            async: false,
            cache: false,
            success: function (data) {
                if (data.auditstatus!=null) {
                    auditResult = data.auditstatus;
                }
            }
        });

        $.post("/users/showLoginInfo.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color='red'>" + data.username + "  </font>(<a href=\"javascript:showAuditInfo();\"><span style='color: #F7FF78'>" + auditResult + "</span></a>)" + "<span><a href='#' onclick=\"javascript:logoff();\">退出</a></span>" + "<span><a href=\"/users/personinfo.jsp\">个人中心</a></span>");
                }
            },
            "json"
        );
    })

    function showAuditInfo() {
        htmlobj = $.ajax({
            url: "/users/showAuditResult.jsp?thetime=<%=System.currentTimeMillis()%>",
            type: 'post',
            dataType: 'json',
            data: {},
            async: false,
            cache: false,
            success: function (data) {
                if (data!=null) {
                    $.msgbox({
                        height: 300,
                        width: 400,
                        content: {type: 'alert', content: "采购中心审核信息："+data.reason},
                        animation: 0,        //禁止拖拽
                        drag: false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                }
            }
        });
    }
</script>

</html>
