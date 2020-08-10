<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-8-31
  Time: 下午6:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/css/css_in.css" rel="stylesheet" type="text/css" />
    <title>京报发行网</title>
</head>

<body>
<div class="topbox">
    <%@include file="/inc/top.jsp" %>
</div>
<div class="main">
    <div class="logo"><img src="/images/201809logo.jpg" width="90" height="90" /></div>
    <%@include file="/inc/menu.jsp" %>
    <div class="clear"></div>
</div>
<div class="con_box">
    <div class="personal_left">
        <div class="title">个人中心</div>
        <ul>
            <li><a href="/users/personinfo.jsp">我的订单</a></li>
            <li><a href="/users/changepersoninfo.jsp">修改注册信息</a></li>
            <li><a href="/users/changePwd.jsp">修改密码</a></li>
            <li><a href="/users/invoices.jsp">发票信息</a></li>
            <li><font color="red">送货地址信息</font></li>
        </ul>
    </div>
    <div class="personal_right_box">
        <div class="personal_right">
            <div class="p_r_title">修改发票信息</div>
            <div class="cont">
                <table width="80%" border="0" align="center" cellpadding="0" cellspacing="1">
                    <tr>
                        <td width="21%" height="60">&nbsp;</td>
                        <td width="79%">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">公司名称：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="50"/></td>
                    </tr>
                    <tr>
                        <td height="40">&nbsp;</td>
                        <td align="left" valign="middle"></td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">税号：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="40" /></td>
                    </tr>
                    <tr>
                        <td height="40">&nbsp;</td>
                        <td align="left" valign="middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">地址：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="60" /></td>
                    </tr>
                    <tr>
                        <td height="40">&nbsp;</td>
                        <td align="left" valign="middle" class="w_red">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">联系电话：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="30" /></td>
                    </tr>
                    <tr>
                        <td height="40">&nbsp;</td>
                        <td align="left" valign="middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">开户银行：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="30" /></td>
                    </tr>
                    <tr>
                        <td height="40">&nbsp;</td>
                        <td align="left" valign="middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">账号：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="40" /></td>
                    </tr>
                    <tr>
                        <td height="60" align="right" valign="middle">发票内容：</td>
                        <td>北京日报</td>
                    </tr>
                    <tr>
                        <td align="right" valign="middle">邮箱：</td>
                        <td><input name="textfield" type="text" class="input_txt" size="50" /></td>
                    </tr>
                    <tr>
                        <td height="40">&nbsp;</td>
                        <td align="left" valign="middle">&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="30">&nbsp;</td>
                        <td align="left" valign="middle"><input name="button" type="submit" class="regist_btn" id="button" value="保存修改" /></td>
                    </tr>
                    <tr>
                        <td height="60">&nbsp;</td>
                        <td align="left" valign="middle">&nbsp;</td>
                    </tr>
                </table>
            </div>
        </div>


    </div>
</div>
<div class="clear"></div>
<div class="footbox">
    <div class="main">
        <div class="footbox_in">
            <p>北京日报报业发行有限公司    版权所有</p>
            <p>电信与信息服务业务经营许可证：京ICP证070805号     增值电信业务经营许可证：京B2-20070141     京公网安备110102000848号</p>
        </div>
    </div>
</div>
</body>
</html>
