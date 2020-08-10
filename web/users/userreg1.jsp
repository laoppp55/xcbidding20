<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 17-3-25
  Time: 下午9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int errcode = 0;
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>北京市西城区公共资源交易中心-企业法人注册</title>
  <link href="/ggzyjy/css/log.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

  <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

  <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
  <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
  <script type="text/javascript">
      function donext(form) {
          var compname = form.compname.value;
          var compcode = form.compcode.value;
          var pass = form.pwd.value;
          var confpass = form.rpwd.value;
          var yzcode = form.yzcode.value;

          if (compname==null || compname=="" || compname=='' || typeof compname == "undefined") {
              $.msgbox({
                  height:120,
                  width:300,
                  content:{type:'alert', content:'公司名称不能为空'},
                  animation:0,        //禁止拖拽
                  drag:false          //禁止动画
                  //autoClose: 10       //自动关闭
              });
              return false;
          } else {
              if (compname.getBytes() < 6) {
                  $.msgbox({
                      height:120,
                      width:300,
                      content:{type:'alert', content:'公司名称的长度必须6个字符以上'},
                      animation:0,        //禁止拖拽
                      drag:false          //禁止动画
                      //autoClose: 10       //自动关闭
                  });
                  return false;
              }
          }

          if (compcode==null || compcode=="" || compcode=='' || typeof compcode == "undefined") {
              $.msgbox({
                  height:120,
                  width:300,
                  content:{type:'alert', content:'公司统一社会信用代码不能为空'},
                  animation:0,        //禁止拖拽
                  drag:false          //禁止动画
                  //autoClose: 10       //自动关闭
              });
              return false;
          } else {
              var checkresult = CheckSocialCreditCode(compcode);
              if (checkresult == false) {
                  $.msgbox({
                      height: 120,
                      width: 300,
                      content: {type: 'alert', content: '公司统一社会信用代码不符合规则，请按营业执照填写统一社会信用代码'},
                      animation: 0,        //禁止拖拽
                      drag: false          //禁止动画
                      //autoClose: 10       //自动关闭
                  });
                  return false;
              } else {
                  //判断公司是否已经完成了注册
                  var existflag = 0;
                  var contactor = "";
                  htmlobj = $.ajax({
                      url: "checkCompanyByCompcode.jsp",
                      type: 'post',
                      dataType: 'json',
                      data: {
                          compcode: encodeURI(compcode)
                      },
                      async: false,
                      cache: false,
                      success: function (data) {
                          if (data!=null) {
                              existflag = 1;
                              contactor = data.contacts + "手机" + data.contactormphone + "，办公电话" + data.contactNumber;
                          }
                      }
                  });

                  if (existflag == 1) {
                      //alert("电子邮件地址已经被注册过，请更换电子邮件地址！");
                      $.msgbox({
                          height: 200,
                          width: 300,
                          content: {type: 'alert', content: compname + '已经完成注册，如需设置账号请联系管理员' + contactor},
                          animation: 0,        //禁止拖拽
                          drag: false          //禁止动画
                          //autoClose: 10       //自动关闭
                      });
                      return false;
                  }
              }
          }

          if (pass == "") {
              $.msgbox({
                  height:120,
                  width:300,
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
                  width:300,
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
<div class="main">
  <div class="logo_box">
    <div class="left"><a href="/ggzyjy/">北京市西城区公共资源交易中心</a></div>
    <div class="right">用户登录</div>
  </div>
  <div class="title_box">新用户注册</div>
  <div class="txt_box">
    <p class="txt_red">温馨提示：</p>
    <p class="txt_red">1、 请输入营业执照上面的完整企业名称 </p>
    <p class="txt_red">2、 统一社会信用代码必须与营业执照上面的统一社会信用代码相同，否则会影响后续业务</p>
  </div>
  <!--div class="txt_box">
    <p class="txt_red">温馨提示：</p>
    <p class="txt_red">1、 请使用北京CA数字证书进行注册，企业名称、统一社会信用代码或组织机构代码 </p>
    <p class="txt_red">2、 务必保证所填信息与CA数字证书中的企业信息一致，已注册过的企业请勿重复注册。</p>
  </div-->
  <div class="title_box_1">
    <ul>
      <li class="txt_white">1、填写基本信息</li>
      <li>2、注册成功,并完善信息</li>
    </ul>
  </div>
  <div class="info_box">
    <form name="form1" action="userreg2.jsp" method="post" onsubmit="return donext(this);">
      <table width="510" border="0" class="info_table">
        <tbody>
        <!--tr>
          <td width="127">&nbsp;</td>
          <td>证书序列号:</td>
        </tr>
        <tr>
          <td align="right">CA:</td>
          <td><input name="textfield1" type="text" class="input_but_4">
            <a href="#" class="dusuo">读锁</a></td>
        </tr-->
        <tr>
          <td align="right">企业名称:</td>
          <td><input name="compname" type="text" class="input_but_5"></td>
        </tr>
        <tr>
          <td align="right">统一社会信用代码或组织机构代码：</td>
          <td><input name="compcode" type="text" class="input_but_5"></td>
        </tr>
        <!--tr>
          <td align="right">企业类型：</td>
          <td style="padding: 10px 0;"><input type="checkbox" name="checkbox"/>
            <label for="checkbox">采购代理(招标人)  </label>&nbsp;&nbsp;
            <input type="checkbox" name="checkbox"  />
            <label for="checkbox">供应商(投标人)  </label></td>
        </tr-->
        <tr>
          <td align="right">输入密码：</td>
          <td><input name="pwd" type="password" class="input_but_5"></td>
        </tr>
        <tr>
          <td align="right">确认密码：</td>
          <td><input name="rpwd" type="password" class="input_but_5"></td>
        </tr>
        <tr>
          <td align="right">验证码：</td>
          <td>
            <input type="text" placeholder="输入图形验证码" class="input_but_6" name="yzcode" id="VerCode"/>
            <span><img src="/users/image.jsp" width="100" height="36" id="yzImageID" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">换一张</a></span>
            <!--img src="/ggzyjy/images/yanzhengma.png" width="160" height="36" alt=""/-->
          </td>
        </tr>
        <tr>
          <td align="right">&nbsp;</td>
          <td><input type="submit" class="input_but_7" name="ok" value="下一步"></td>
        </tr>
        </tbody>
      </table>
    </form>
  </div>
</div>
</body>
</html>
