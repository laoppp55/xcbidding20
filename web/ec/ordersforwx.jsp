<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.wxpay.WXPayService" %>
<%@ page import="com.bizwink.util.SecurityUtil" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="com.bizwink.mysql.po.Addressinfofororder" %>
<%@ page import="com.bizwink.mysql.vo.InvoiceAndContents" %>
<%@ page import="com.bizwink.mysql.vo.OrderAndOrderdetail" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-24
  Time: 下午2:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    long orderid = ParamUtil.getLongParameter(request,"order",0);
    float total_fee = ParamUtil.getFloatParameter(request,"totalfee",0);
    String money_type = ParamUtil.getParameter(request,"moneytype");
    String prodname = ParamUtil.getParameter(request,"prod");
    String prodbrief = ParamUtil.getParameter(request,"prodbrief");
    String checkcode = ParamUtil.getParameter(request,"check");

    BigDecimal b = new BigDecimal(total_fee);
    double totalFee = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

    if (prodname == null) prodname = "";
    if (prodbrief == null) prodbrief = "";
    if (money_type == null) money_type ="";

    String weixin_checkcode_src = "/ec/ordersforwx.jsp?order=" + orderid + "&totalfee=" + totalFee + "&moneytype=" + money_type + "&prod=" + prodname + "&prodbrief=" + prodbrief;
    String checkcode_src = URLDecoder.decode(SecurityUtil.Decrypto(checkcode), "utf-8");

    String code_url = null;
    String weixin_checkcode = null;
    OrderAndOrderdetail orderAndOrderdetail = null;
    InvoiceAndContents invoiceAndContents = null;
    Addressinfofororder addressinfofororder = null;
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");

    if (checkcode_src.equals(weixin_checkcode_src)) {
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int retcode = 0;
        if (appContext!=null) {
            MEcService mEcService = (MEcService)appContext.getBean("MEcService");
            //orderid：订单号
            //1：用户点击了支付按钮
            //0：表示用户选择了微信支付方式
            retcode = mEcService.UpdateUserClickPayflag(orderid,1,0);
            orderAndOrderdetail = mEcService.getOrderinfos(orderid);
            addressinfofororder = mEcService.getAddressByOrderid(orderid);
            invoiceAndContents = mEcService.getInvoiceinfoByOrderid(orderid);
        }

        if (retcode > 0) {
            //生成微信支付的预定单
            WXPayService wxPayService = WXPayService.getInstance();
            //out_trade_no：订单号
            //body：产品说明等信息
            //money：订单交易金额
            //applyNo：产品ID
            code_url = wxPayService.doUnifiedOrder(String.valueOf(orderid),prodbrief,totalFee,prodname);
            System.out.println("code_url===" + code_url);
            weixin_checkcode_src = "createTwoDimensionalCode.jsp?codeurl=" + code_url;
            weixin_checkcode = URLEncoder.encode(SecurityUtil.Encrypto(weixin_checkcode_src),"utf-8");
        } else {
            response.sendRedirect("/users/error.jsp?errcode=-9");
            return;
        }
    } else {
        response.sendRedirect("/users/error.jsp?errcode=-10");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=8">
    <title>京报发行网--微信扫码支付</title>
    <link href="/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/css/css_in.css" rel="stylesheet" type="text/css" />
    <style>
        table tr td{padding:12px 8px;}
        body {
            line-height:30px;
            font-size:16px;
        }
        p{ padding-bottom:20px;}
    </style>
    <script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
    <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/users.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $.post("/users/showLoginInfo.jsp",{
                        username:encodeURI(name)
                    },
                    function(data) {
                        if (data.username!=null) {
                            $("#userInfos").html("欢迎你：<font color=\"red\">" + data.username + "</font>&nbsp;&nbsp;<a href='#' onclick=\"javascript:logoff('m');\">退出</a>" + "<a href=\"/users/m/personinfo.jsp\">个人中心</a>");
                        }
                    },
                    "json"
            )
        })

        function pay_status(){
            $.ajax({
                url:'checkPay.jsp',
                dataType:'json',
                type:'post',
                data:{'orderid':<%=orderid%>},
                success:function(data){
                    if (data.result=="bank"){
                        alert("银行支付成功，请确认返回");
                        window.opener.location.href = "/users/m/personinfo.jsp";
                        window.close();
                    } else if (data.result=="wx") {
                        alert("微信支付成功，请确认返回");
                        window.opener.location.href = "/users/m/personinfo.jsp";
                        window.close();
                    }
                },
                error:function(){
                }
            });
        }

        //启动定时器
        var int=self.setInterval(function(){pay_status()},1000);
    </script>
</head>

<body>
<div class="topbox"><%@include file="/inc/top.shtml" %></div>
<div class="main"><%@include file="/inc/menu.shtml" %></div>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2">
    <tr>
        <td bgcolor="#f6f4f4" style="padding-left:30px;"><strong>请确认订单信息：</strong></td>
    </tr>
    <tr>
        <td bgcolor="#ffffff" style="padding-left:30px;">
            <table width="100%" align="center" cellpadding="0" cellspacing="1">
                <tr>
                    <td align="right">
                        订单编号：
                    </td>
                    <td align="left">
                        <%=orderid%>
                    </td>
                    <td align="right">
                        报纸名称：
                    </td>
                    <td align="left">
                        <span class="red">《<%=orderAndOrderdetail.getOrderDetails()==null?"":orderAndOrderdetail.getOrderDetails().get(0).getProductname()%>》</span>
                    </td>
                    <td align="right">
                        报纸份数：
                    </td>
                    <td align="left">
                        <%=orderAndOrderdetail.getOrderDetails().get(0).getORDERNUM()%>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        订单金额：
                    </td>
                    <td align="left">
                        <%=orderAndOrderdetail.getPAYFEE()%>元
                    </td>
                    <td align="right">
                        下单时间：
                    </td>
                    <td align="left">
                        <%=format.format(orderAndOrderdetail.getCREATEDATE())%>
                    </td>
                    <td align="right">
                        订报时间：
                    </td>
                    <td align="left">
                        <%=format.format(orderAndOrderdetail.getOrderDetails().get(0).getServicestarttime())%>到<%=format.format(orderAndOrderdetail.getOrderDetails().get(0).getServiceendtime())%>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="center" bgcolor="#ffffff" style="padding-bottom:30px;">
            <table width="56%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="53%" align="center">扫一扫付款(元)<br /><span style="font-size:24px; color:#e00404"><%=orderAndOrderdetail.getPAYFEE()%>元</span><br />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <div style="border:1px solid #cccccc; width:310px; height:350px; padding-top:8px;">
                            <form name="scanForm">
                                <input type="hidden" name="order" value="<%=orderid%>">
                            </form>
                            <div><img src="createTwoDimensionalCode.jsp?codeurl=<%=code_url%>&check=<%=weixin_checkcode%>" id="weixinpayID" name="weixinpayimage" align="absmiddle"/></div>
                            <!--div><img src="images/zhifubao.jpg" /></div-->
                            <div style="padding-top:8px;"><img src="/images/sao-sao.jpg" width="36" height="37" style="vertical-align: middle;"/> 扫一扫继续支付</div>
                        </div>
                    </td>
                </tr>
            </table></td>
    </tr>
</table>
<table>
    <tr>
        <td height="50px;"></td>
    </tr>
</table>

<div class="footbox"><%@include file="/inc/tail.shtml" %></div>
</body>
</html>

<!--body>
<form name="scanForm">
<input type="hidden" name="order" value="<%=orderid%>">
</form>
<img src="createTwoDimensionalCode.jsp?codeurl=<%=code_url%>&check=<%=weixin_checkcode%>" id="weixinpayID" name="weixinpayimage" align="absmiddle"/>
</body>
</html-->
