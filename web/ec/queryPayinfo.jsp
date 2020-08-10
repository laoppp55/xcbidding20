<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.wxpay.WXPayService" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.yeepay.PaymentForOnlineService" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.mysql.po.Addressinfofororder" %>
<%@ page import="com.bizwink.mysql.vo.InvoiceAndContents" %>
<%@ page import="com.bizwink.mysql.vo.OrderAndOrderdetail" %>
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
        response.sendRedirect("/users/m/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    ApplicationContext appContext = SpringInit.getApplicationContext();
    String p2_Order   = formatString(request.getParameter("orderid"));
    OrderAndOrderdetail orderAndOrderdetail = null;
    InvoiceAndContents invoiceAndContents = null;
    Addressinfofororder addressinfofororder = null;
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
    int retcode = 0;
    if (appContext!=null) {
        MEcService mEcService = (MEcService)appContext.getBean("MEcService");
        orderAndOrderdetail = mEcService.getOrderinfos(Long.parseLong(p2_Order));
        //addressinfofororder = mEcService.getAddressByOrderid(Long.parseLong(p2_Order));
        //invoiceAndContents = mEcService.getInvoiceinfoByOrderid(Long.parseLong(p2_Order));
    }

    Map<String, String> qr = null;
    String result = null;
    //银行支付查询 调用后台外理查询方法
    qr = PaymentForOnlineService.queryByOrder(p2_Order);
    System.out.println("bank pay status==" + qr.get("rb_PayStatus"));
    if (qr.get("rb_PayStatus").equals("SUCCESS")) {
        result = "bank";
        qr.put("支付方式","银行支付");
        qr.put("商品名称",orderAndOrderdetail.getOrderDetails().get(0).getProductname());
        qr.put("订单号",qr.get("r6_Order"));
        qr.put("支付交易流水号",qr.get("r2_TrxId"));
        qr.put("支付金额",qr.get("r3_Amt"));
        qr.put("交易币种",qr.get("r4_Cur"));
        qr.put("支付状态",qr.get("rb_PayStatus"));
        //out.println("支付创建时间:" +  qr.get("rx_CreateTime") + "]<br>");
        qr.put("支付完成时间",qr.get("ry_FinshTime"));
    }

    //查询微信付款信息
    if (result == null) {
        WXPayService wxPayService = WXPayService.getInstance();
        qr = wxPayService.tradeQuery(p2_Order);
        System.out.println("wx pay status==" + qr.get("result_code"));
        if (qr.get("result_code").equals("SUCCESS")) {
            result = "wx";
            qr.put("支付方式","微信支付");
            qr.put("商品名称",orderAndOrderdetail.getOrderDetails().get(0).getProductname());
            qr.put("订单号",qr.get("out_trade_no"));
            qr.put("支付交易流水号",qr.get("transaction_id"));
            qr.put("支付金额",String.valueOf(Float.parseFloat(qr.get("total_fee"))/100));
            qr.put("交易币种",qr.get("fee_type"));
            qr.put("支付状态",qr.get("trade_state_desc"));
            //out.println("支付创建时间:" +  qr.get("rx_CreateTime") + "]<br>");
            qr.put("支付完成时间",qr.get("time_end"));
        }
    }

    String jsonData = null;
    Gson gson = new Gson();
    if (result != null){
        jsonData =  gson.toJson(qr);
        System.out.println("jsondata=="+jsonData);
    }else{
        jsonData = "{\"result\":\"false\"}";
    }
    JSON.setPrintWriter(response, jsonData, "utf-8");
%>
