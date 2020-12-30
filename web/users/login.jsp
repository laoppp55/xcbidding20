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
  <script src="/ggzyjy/js/XTXSAB.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
  <script language="javascript">
      var errcode = <%=errcode%>;
      $(document).ready(function(){
          init(function(){
              SOF_GetUserList(call_back);
          },function(){
          });

          if (errcode == -101 || errcode == -102 || errcode == -106 || errcode == -103) {
              $("#usermsg").html("用户名或者密码错");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -104) {
              $("#usermsg").html("用户已经被删除");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -105) {
              $("#usermsg").html("验证码错，请重新输入验证码");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -107) {
              $("#usermsg").html("数字证书检查失败");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -108) {
              $("#usermsg").html("数字证书不在有效期内");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -109) {
              $("#usermsg").html("未获取有效的数字证书有效期");
              $("#usermsg").css({color:"red"});
          } else if (errcode == -6) {
              $("#usermsg").html("用户被暂时停止登录，请联系客服人员");
              $("#usermsg").css({color:"red"});
          } else if (errcode>0) {
              alert("用户注册成功");
          }
      });

      function call_back(data){
          var buf = data.retVal;
          if (buf=="" || buf==null || typeof(buf) == 'undefined')
              alert("请插入UKEY");
          else {
              var posi = buf.indexOf("&");
              buf = buf.substring(0,posi);
              posi = buf.indexOf("||");
              var companyname = buf.substring(0, posi);
              var certid = buf.substring(posi+2);
              posi = certid.indexOf("/");
              var sn = certid.substring(posi+1);
              loginform.sn.value = sn;
              SOF_ExportUserCert(certid,call_back_cert)
              loginform.username.value = companyname;
          }
      }

      function call_back_cert(data){
          var buf = data.retVal;
          loginform.cert.value=buf;
          SOF_GetCertInfo(buf,2,call_back_certnum);                                  //获取证书编号
          SOF_GetCertInfo(buf,11,call_cert_begin_date);                               //获取证书有效期开始时间
          SOF_GetCertInfo(buf,12,call_cert_end_date);                                 //获取证书有效期结束时间
      }

      function call_back_certnum(data){
          var buf = data.retVal;
          loginform.certnum.value = buf;
      }

      function call_cert_begin_date(data){
          var buf = data.retVal;
          loginform.certBDate.value = buf;
      }

      function call_cert_end_date(data){
          var buf = data.retVal;
          loginform.certEDate.value = buf;
      }

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

      function updateLoginWay(flag) {
          if (flag==0) {
              $("#userid").removeAttr("readonly");
          } else {
              SOF_GetUserList(call_back);
              $("#userid").attr({"readonly":"readonly"});
          }
      }
  </script>
</head>

<body>
<div class="main">
  <div class="logo_box">
    <div class="left"><a href="/ggzyjy/"><font size="6" color="black">北京市西城区公共资源交易中心</font></a></div>
    <div class="right">用户登录</div>
  </div>
</div>
<div class="main clearfix">
  <div class="login_box">
    <div class="login_box_in">
      <form name="loginform" method="post" action="/login.do" onsubmit="return loginsubmit(loginform)">
        <input type="hidden" name="doLogin" value="true">
        <input type="hidden" name="refer" value="<%=refer_url%>">
        <input type="hidden" name="sn" value="">
        <input type="hidden" name="certnum" value="">
        <input type="hidden" name="cert" value="">
        <input type="hidden" name="certBDate" value="">
        <input type="hidden" name="certEDate" value="">
        <table width="380" border="0">
          <tbody>
          <tr>
            <td colspan="2" align="left" valign="bottom" class="w_red"><div id="usermsg"></div></td>
          </tr>
          <tr>
            <td align="left" valign="bottom" class="w_red"><input type="radio" name="loginway" id="loginway_id" value="1" checked onclick="updateLoginWay(1);">CA登录</td>
            <td align="left" valign="bottom" class="w_red"><input type="radio" name="loginway" id="loginway_id" value="0" onclick="updateLoginWay(0);">用户名密码登录</td>
          </tr>
          <tr>
            <td class="txt_grey" colspan="2">用户名（企业完整名称） </td>
          </tr>
          <tr>
            <td valign="middle" colspan="2">
              <input name="username" type="text" class="input_but_1" id="userid" autocomplete="off" readonly/>
              <!--input type="button"  onclick="SOF_GetUserList(call_back)" value="调用" /-->
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
              <span style="float:left; display:block; margin-left:10px;"><img src="/users/image.jsp" height="40px" id="yzImageID" name="yzcodeimage" align="absmiddle" /></span><span><a href="javascript:change_yzcodeimage();">换一张</a></span>
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
            <td colspan="2"><input type="submit" class="input_but_3" value="提交"/>&nbsp;</td>
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
    <p class="txt_red"><img src="/images/icon_11.png"/>温馨提示：</p>
    <p>1、建议使用谷歌浏览器或者360浏览器，初次使用用户请下载并认真阅读<a href="/users/supplierGuide.pdf" target="_blank">投标人服务手册</a></p>
    <!--p>2、请使用CA证书登录，点击<a href="#">CA办理服务指南及驱动下载</a>查看服务办理流程或下载驱动程序</p-->
  </div>
</div>
</body>
</html>
