<%@ page import="com.bizwink.weixin.SignUtil" %>
<%@ page import="com.bizwink" %>
<%@ page import="com.bizwink.weixin.HttpUtility" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-12-02
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp，nonce参数
    String signature = request.getParameter("signature");
    //时间戳
    String timestamp = request.getParameter("timestamp");
    //随机数
    String nonce = request.getParameter("nonce");
    //随机字符串
    String echostr = request.getParameter("echostr");

    //发送 POST 请求
    String sr= HttpUtility.urlSendPost("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx5c345dba1ac0184c&secret=274bb2545802a0ac31db9e7c4df03209", "");

    if (SignUtil.checkSignature(signature, timestamp, nonce)) {
        response.getOutputStream().println(echostr + "==" + sr);
    } else {
        response.getOutputStream().println("sign error==" + sr);
    }
%>