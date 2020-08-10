<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.wxpay.WXPayService" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.yeepay.PaymentForOnlineService" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-10-8
  Time: 下午10:57
  To change this template use File | Settings | File Templates.
--%>
<%!
    String formatString(String text){
        if(text == null) return "";  return text;
    }
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String p2_Order   = formatString(request.getParameter("orderid"));
    Map<String, String> qr = null;
    String result = null;
    //银行支付查询 调用后台外理查询方法
    //qr = PaymentForOnlineService.queryByOrder(p2_Order);
    //System.out.println("bank pay status==" + qr.get("rb_PayStatus"));
    //if (qr.get("rb_PayStatus").equals("SUCCESS")) {
    //    result = "bank";
    //}

    //查询微信付款信息
    if (result == null) {
        WXPayService wxPayService = WXPayService.getInstance();
        qr = wxPayService.tradeQuery(p2_Order);
        System.out.println("wx pay status==" + qr.get("result_code"));
        if (qr.get("result_code").equals("SUCCESS") && qr.get("trade_state_desc").equals("支付成功")) {
            result = "wx";
        }
    }

    String jsonData = null;
    if (result != null)
        jsonData =  "{\"result\":\"" + result + "\"}";
    else
        jsonData = "{\"result\":\"false\"}";

    JSON.setPrintWriter(response, jsonData, "utf-8");
%>
