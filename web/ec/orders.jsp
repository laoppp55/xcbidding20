<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.EcService" %>
<%@ page import="com.bizwink.service.ArticleService" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.service.TrainInfoService" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.po.OrderDetail" %>
<%@ page import="com.bizwink.po.Orders" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.vo.TrainInfo" %>
<%@ page import="com.bizwink.po.TrainingMajor" %>
<%@ page import="com.bizwink.vo.ArticleAndExtendAttrs" %>
<%@ page import="com.bizwink.po.ArticleExtendattr" %>
<%@ page import="com.bizwink.util.SecurityUtil" %>
<%@ page import="com.wxpay.WXPayService" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! String formatString(String text) {
    if (text == null) {
        return "";
    }
    return text;
}
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        if (referer_usr!=null) {
            response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        } else {
            response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        }
    }
    long orderid = ParamUtil.getLongParameter(request,"orderid",0);
    String username = authToken.getUsername();
    Orders order = null;
    float totalFee = 0f;
    List<OrderDetail> orderDetailList = null;
    TrainingMajor trainingMajor = null;
    ArticleAndExtendAttrs articleExtendattr = null;
    String pxbt = null,pxet=null,bmbt=null,bmet=null;
    String code_url = null;
    String weixin_checkcode = null;
    String p4_Cur = formatString("CNY");
    String prodname = null;
    String prodbrief = null;

    ApplicationContext appContext = SpringInit.getApplicationContext();
    EcService ecService = null;
    ArticleService articleService = null;
    TrainInfoService trainInfoService = null;
    if (appContext!=null) {
        trainInfoService = (TrainInfoService) appContext.getBean("trainInfoService");
        articleService = (ArticleService) appContext.getBean("articleService");
        ecService = (EcService) appContext.getBean("ecService");
        //读取订单信息
        order = ecService.getOrder(orderid);
        prodname = order.getProjname();
        prodbrief = order.getProjbrief();
        orderDetailList = ecService.getOrderDetailList(orderid);
        for(int ii=0;ii<orderDetailList.size();ii++) {
            OrderDetail orderDetail = orderDetailList.get(ii);
            totalFee = totalFee + orderDetail.getSALEPRICE().floatValue();
        }
        articleExtendattr = articleService.getArticleAndEXtendAttrs(order.getProjartid());
        if (articleExtendattr != null) {
            List<ArticleExtendattr> extendattrs = articleExtendattr.getArticleExtendattrs();
            for (int jj = 0; jj < extendattrs.size(); jj++) {
                ArticleExtendattr extendattr = extendattrs.get(jj);
                if (extendattr.getEname().equals("_pxbt")) pxbt = extendattr.getStringvalue();
                if (extendattr.getEname().equals("_pxet")) pxet = extendattr.getStringvalue();
                if (extendattr.getEname().equals("_bmbt")) bmbt = extendattr.getStringvalue();
                if (extendattr.getEname().equals("_bmet")) bmet = extendattr.getStringvalue();
            }
        }
        trainingMajor = trainInfoService.getMajorinfoByProjcodeAndMajorcode(order.getProjcode(),order.getMajorcode());

        String weixin_checkcode_src = "/ec/ordersforwx.jsp?order=" + orderid + "&totalfee=" + totalFee + "&moneytype=" + p4_Cur + "&prod=" + prodname + "&prodbrief=" + prodbrief;
        //生成微信支付的预定单
        WXPayService wxPayService = WXPayService.getInstance();
        //out_trade_no：订单号
        //body：产品说明等信息
        //money：订单交易金额
        //applyNo：产品ID
        code_url = wxPayService.doUnifiedOrder(String.valueOf(orderid),prodbrief,Double.valueOf(totalFee),prodname);
        System.out.println("code_url===" + code_url);
        weixin_checkcode_src = "createTwoDimensionalCode.jsp?codeurl=" + code_url;
        weixin_checkcode = URLEncoder.encode(SecurityUtil.Encrypto(weixin_checkcode_src),"utf-8");

    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京城建集团党校--培训订单支付</title>
    <link href="/css/basis.css" rel="stylesheet" type="text/css">
    <link href="/css/column.css" rel="stylesheet" type="text/css">
    <link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function pay_status(){
            $.ajax({
                url:'checkPay.jsp',
                dataType:'json',
                type:'post',
                data:{'orderid':<%=orderid%>},
                success:function(data){
                    if (data.result=="bank"){
                        alert("银行支付成功，请确认返回");
                        window.opener.location.href = "/users/personinfo.jsp";
                        window.close();
                    } else if (data.result=="wx") {
                        alert("微信支付成功，请确认返回");
                        window.opener.location.href = "/users/personinfo.jsp";
                        window.close();
                    }
                },
                error:function(){
                }
            });
        }

        //启动定时器
        //var int=self.setInterval(function(){pay_status()},1000);
    </script>
</head>

<body>
<div class="full_box">
    <div class="top_box">
        <%@include file="/inc/top.shtml" %>
    </div>
    <div class="logo_box clearfix">
        <%@include file="/inc/search.shtml" %>
    </div>
    <div class="menu_box">
        <%@include file="/inc/menu.shtml" %>
    </div>
</div>

<!--以上页面头-->
<div class="main div_top clearfix">
    <div class="con_box">
        <div class="title_box blue_title">请确认信息</div>
        <div class="info_box">
            <div class="info_min">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                    <tr>
                        <td width="120">报名人： </td>
                        <td><%=username%></td>
                    </tr>
                    <tr>
                        <td>培训项目： </td>
                        <td><%=order.getProjname()%> </td>
                    </tr>
                    <tr>
                        <td>选择专业： </td>
                        <td class="kecheng"><%=trainingMajor.getMAJOR()%></td>
                    </tr>
                    <tr>
                        <td>培训课程： </td>
                        <td class="kecheng">
                            <ul>
                                <%
                                    for(int ii=0;ii<orderDetailList.size();ii++) {
                                        OrderDetail orderDetail = orderDetailList.get(ii);
                                %>
                                <li><span class="inp"></span><%=orderDetail.getProductname()%><span class="redfont">¥<%=orderDetail.getSALEPRICE()%>元</span></li>
                                <%}%>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>培训地址： </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>报名时间： </td>
                        <td><%=(bmbt!=null)?bmbt:""%></td>
                    </tr>
                    <tr>
                        <td>培训开始时间： </td>
                        <td><%=(bmet!=null)?bmet:""%></td>
                    </tr>
                    <tr>
                        <td>订单金额： </td>
                        <td><%=(totalFee>0)?("￥" + totalFee + "元"):""%> </td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="pay" style="text-align: center;">扫一扫付款（元）<br>
                <span class="redfont"><%=(totalFee>0)?("￥" + totalFee + "元"):""%></span><br><img src="createTwoDimensionalCode.jsp?codeurl=<%=code_url%>&check=<%=weixin_checkcode%>" id="weixinpayID" name="weixinpayimage" align="absmiddle"/></div>
        </div>
    </div>

</div>
<!--以下页面尾-->
<div>
    <%@include file="/inc/tail.shtml" %>
</div>

</body>
</html>
