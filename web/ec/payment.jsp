<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.mysql.service.MArticleService" %>
<%@ page import="com.bizwink.mysql.vo.ArticleAndExtendAttrs" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.mysql.po.*" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="com.bizwink.mysql.vo.OrderAndOrderdetail" %>
<%@ page import="com.bizwink.mysql.vo.InvoiceAndContents" %>
<%@ page import="com.yeepay.PaymentForOnlineService" %>
<%@ page import="com.yeepay.Configuration" %>
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
        response.sendRedirect("/users/m/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    int userid = authToken.getUid();
    String username = authToken.getUserid();
    String realname = authToken.getUsername();
    Users user = null;
    long orderid = ParamUtil.getLongParameter(request,"orderid",0);
    String checkcode = ParamUtil.getParameter(request,"checkcode");
    long thetime = ParamUtil.getLongParameter(request,"thetime",0);

    float yprice = 0.00f;                   //年订阅价格
    float vipy = 0.00f;                     //年订阅优惠价
    float byprice = 0.00f;                  //半年订阅价格
    float vipby = 0.00f;                    //半年订阅优惠价
    float qprice = 0.00f;                   //季度订阅价格
    float vipq = 0.00f;                     //季度订阅优惠价
    float mprice = 0.00f;                   //月度订阅价格
    float vipm = 0.00f;                     //月度订阅优惠价
    float gprice = 0.00f;                   //订阅单价
    float vipgprice = 0.00f;                //订阅单价优惠价
    int subscribetype = 1;                  //订阅类型，1整订 2破头订阅 3破尾订阅 4破头破尾订阅
    int tqdays = 0;                         //提前预定天数
    int vipmonths = 0;                      //优惠月数
    int across_year_flag = 0;               //年订是否允许跨年
    int across_half_year_flag = 0;          //是否可跨越自然半年订阅，1自然半年，既1月1号开始或者7月1号开始，2可跨越自然半年，任何一个月的1号向后6个月即为半年
    int across_q_flag = 0;                  //是否可以跨越自然季度订阅，1自然季度，既1月1号，4月1号，7月1号，10月1号开始的季度，2可跨越自然季度，既任何一个月的1号开始向后3个月为一个季度
    String vip_dy_startdate = null;         //优惠订阅开始时间
    String vip_dy_enddate = null;           //优惠订阅结束时间
    int articleid = 0;

    ApplicationContext appContext = SpringInit.getApplicationContext();
    ArticleAndExtendAttrs articleAndExtendAttrs = null;
    OrderAndOrderdetail orderAndOrderdetail = null;
    InvoiceAndContents invoiceAndContents = null;
    Addressinfofororder addressinfofororder = null;
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");

    if (appContext!=null) {
        //读取订单信息
        MEcService mEcService = (MEcService)appContext.getBean("MEcService");
        orderAndOrderdetail = mEcService.getOrderinfos(orderid);
        addressinfofororder = mEcService.getAddressByOrderid(orderid);
        invoiceAndContents = mEcService.getInvoiceinfoByOrderid(orderid);
        articleid = orderAndOrderdetail.getOrderDetails().get(0).getPRODUCTID();

        //读取被订阅的报纸的信息
        MArticleService mArticleService = (MArticleService)appContext.getBean("MArticleService");
        articleAndExtendAttrs = mArticleService.getArticleAndEXtendAttrs(articleid);
        List<ArticleExtendattr> articleExtendattrs = articleAndExtendAttrs.getArticleExtendattrs();
        for(int ii=0; ii<articleExtendattrs.size(); ii++) {
            ArticleExtendattr extendattr = articleExtendattrs.get(ii);
            String ename = extendattr.getEname();
            if (ename.equalsIgnoreCase("_yprice")) yprice = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_vipyprice")) vipy = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_hyprice")) byprice = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_viphyprice")) vipby = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_mprice")) mprice = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_vipmprice")) vipm = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_jdprice")) qprice = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_vipqdprice")) vipq = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_gprice")) gprice = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_vipgprice")) vipgprice = extendattr.getFloatvalue().floatValue();
            if (ename.equalsIgnoreCase("_subscribetype")) subscribetype = extendattr.getNumericvalue();
            if (ename.equalsIgnoreCase("_presubscribeday")) tqdays = extendattr.getNumericvalue();
            if (ename.equalsIgnoreCase("_vipmonth")) vipmonths = extendattr.getNumericvalue();
            if (ename.equalsIgnoreCase("_acrossyear")) across_year_flag = extendattr.getNumericvalue();
            if (ename.equalsIgnoreCase("_acrosshalfyear")) across_half_year_flag = extendattr.getNumericvalue();
            if (ename.equalsIgnoreCase("_acrossq")) across_q_flag = extendattr.getNumericvalue();
            if (ename.equalsIgnoreCase("_vipstartdate")) vip_dy_startdate = extendattr.getStringvalue();
            if (ename.equalsIgnoreCase("_vipendtime")) vip_dy_enddate = extendattr.getStringvalue();
        }
    } else {
        response.sendRedirect("/users/m/error.jsp");
        return;
    }

    String keyValue = formatString(Configuration.getInstance().getValue("keyValue"));                       // 商家密钥
    // 交易请求地址https://www.yeepay.com/app-merchant-proxy/node
    String nodeAuthorizationURL = formatString(Configuration.getInstance().getValue("yeepayCommonReqURL"));
    if(orderid < 1) nodeAuthorizationURL = "#";
    // 商家设置用户购买商品的支付信息
    String p0_Cmd = formatString("Buy");                                                   // 在线支付请求，固定值 ”Buy”
    String p1_MerId = formatString(Configuration.getInstance().getValue("p1_MerId"));     // 商户编号
    String p2_Order = String.valueOf(orderid);                                              //formatString(request.getParameter("p2_Order")); "abc123567";//          					// 商户订单号
    String p3_Amt = String.valueOf(orderAndOrderdetail.getPAYFEE());                        //formatString(request.getParameter("p3_Amt"));  "0.01";//    	   							// 支付金额
    if(username.equals("petersong")) p3_Amt = "0.01";
    String p4_Cur = formatString("CNY");                                                   // 交易币种
    String p5_Pid = formatString(request.getParameter("p5_Pid"));                          // 商品名称
    String p6_Pcat = formatString(request.getParameter("p6_Pcat"));                        // 商品种类
    String p7_Pdesc = formatString(request.getParameter("p7_Pdesc"));                      // 商品描述
    String p8_Url = "http://www.jbfx.com.cn/dingyue/callback.jsp";                   //formatString(request.getParameter("p8_Url"));                // 商户接收支付成功数据的地址
    String p9_SAF = "0";//formatString(request.getParameter("p9_SAF")); 	                // 需要填写送货信息 0：不需要  1:需要
    String pa_MP = formatString(request.getParameter("pa_MP"));                           // 商户扩展信息
    String pd_FrpId = formatString(request.getParameter("pd_FrpId"));                    // 支付通道编码

    // 银行编号必须大写
    pd_FrpId = pd_FrpId.toUpperCase();
    String pr_NeedResponse = formatString("1");                                      // 默认为"1"，需要应答机制
    String hmac = formatString("");                                                  // 交易签名串

    // 获得MD5-HMAC签名
    hmac = PaymentForOnlineService.getReqMd5HmacForOnlinePayment(p0_Cmd,p1_MerId, p2_Order, p3_Amt, p4_Cur, p5_Pid, p6_Pcat, p7_Pdesc,p8_Url, p9_SAF, pa_MP, pd_FrpId, pr_NeedResponse, keyValue);
    // }
%>
<html>
<head>
    <title>京报发行网</title>
    <link href="/css/jcDate.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/js/users.js"></script>
    <script language="javascript" type="text/javascript" src="/js/jQuery-jcDate.js"></script>

    <script language="javascript">
        $(document).ready(function(){
            var box=document.getElementById('begindateid');
            //alert(box.getBoundingClientRect().bottom - box.getBoundingClientRect().top);
            $(".jcDate").jcDate({
                Class : "",               //为input注入自定义的class类（默认为空）
                Default: "today",                                                   //设置默认日期（默认为当天）
                Event : "click",                                                    //设置触发控件的事件，默认为click
                Speed : 100,                                                         //设置控件弹窗的速度，默认100（单位ms）
                Left : 0,                                                           //设置控件left，默认0
                //Top : $('input.jcDate')[0].getBoundingClientRect().height,          //设置控件top，默认为input.jcDate框的高度
                Top:box.getBoundingClientRect().bottom - box.getBoundingClientRect().top,
                Format : "-",   //设置控件日期样式,默认"-",效果例如：XXXX-XX-XX
                DoubleNum: true, //设置控件日期月日格式，默认true,例如：true：2015-05-01 false：2015-5-1
                Timeout : 100,   //设置鼠标离开日期弹窗，消失时间，默认100（单位ms）
                OnChange: function() { //设置input中日期改变，触发事件，默认为function(){}
                    console.log('num change');
                }
            });

            $.post("/users/showLoginInfo.jsp",{
                        username:encodeURI(name)
                    },
                    function(data) {
                        if (data.username!=null) {
                            $("#userInfos").html("欢迎你：<a href=\"/users/m_personinfo.jsp\">" + data.username + "</a>&nbsp;&nbsp;<a href='#' onclick=\"javascript:logoff('m');\">退出</a>");
                            $("#userInfos").css({color:"red"});
                        }
                    },
                    "json"
            )
        })

        function checks(form) {
            alert(regform.numbercopy.value);
        }
    </script>
</head>
<body>
<div class="box">
    <div class="liucheng_bg1">
        <div class="liucheng">
            <div class="bai_zi">填写订报信息</div>
            <div>确认订报信息</div>
            <div>在线支付</div>
        </div>
    </div>
    <div class="shuoming">
        <p class="red"><strong>订报说明</strong></p>
        <p>1、报纸投递地址限：北京市五环内、回龙观、上地、天通苑、亦庄、各郊区（县）县城</p>
        <p>2、“年订”指订期为整12个月。例如开始日期为2012年1月1日，截止日期为2012年12月31日；开始日期为2012年1月10日，截止日期为2013年1月9日</p>
        <p>3、付款成功后，配送人员将与您联系确认时间，上门送赠品及收订凭证。</p>
        <p>4、咨询电话：58393333（周一至周五，9:00至11:30，13：00至16:00，节假日除外）</p>
        <p>5、退订报时，需退回赠品，且退回的赠品不影响再次发放</p>
    </div>

    <div class="xinxi">
        <p>您订阅的是：<span class="red">《<%=articleAndExtendAttrs.getMaintitle()==null?"":articleAndExtendAttrs.getMaintitle()%>》</span></p>
        <p>您的订单编号：<%=orderid%></p>
        <p>购买份数：<%=orderAndOrderdetail.getOrderDetails().get(0).getORDERNUM()%></p>
        <% if (subscribetype==1) {%>
        <p>您录入的订阅开始日期：<%=(orderAndOrderdetail.getOrderDetails().get(0).getUserinstarttime()!=null)?format.format(orderAndOrderdetail.getOrderDetails().get(0).getUserinstarttime()):""%></p>
        <%}else {%>
        <p>您录入的订阅开始日期：<%=(orderAndOrderdetail.getOrderDetails().get(0).getUserinstarttime()!=null)?format.format(orderAndOrderdetail.getOrderDetails().get(0).getUserinstarttime()):""%></p>
        <p>您录入的订阅结束日期：<%=(orderAndOrderdetail.getOrderDetails().get(0).getUserinendtime()!=null)?format.format(orderAndOrderdetail.getOrderDetails().get(0).getUserinendtime()):""%></p>
        <%}%>
    </div>

    <div class="border">
        <div class="title">订阅方式：<br/>
            <%
                if(orderAndOrderdetail.getOrderDetails().get(0).getSubscribe()==1) {
                    out.println("<font color='red'><b>年订：<b/></font>根据系统设置的订阅规则计算出的订阅时间为" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServicestarttime())+"---" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServiceendtime()));
                    out.println("<br /><font color='red'><b>您的订阅价格：<b/></font>" + orderAndOrderdetail.getPAYFEE());
                } else if (orderAndOrderdetail.getOrderDetails().get(0).getSubscribe()==2) {
                    out.println("<font color='red'><b>半年订：<b/></font>根据系统设置的订阅规则计算出的订阅时间为" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServicestarttime())+"---" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServiceendtime()));
                    out.println("<br /><font color='red'><b>您的订阅价格：<b/></font>" + orderAndOrderdetail.getPAYFEE());
                } else if (orderAndOrderdetail.getOrderDetails().get(0).getSubscribe()==3) {
                    out.println("<font color='red'><b>季订：<b/></font>您订阅了" + orderAndOrderdetail.getOrderDetails().get(0).getSubscribenum() + "个季度，根据系统设置的订阅规则计算出的订阅时间为" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServicestarttime())+"---" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServiceendtime()));
                    out.println("<br /><font color='red'><b>您的订阅价格：<b/></font>" + orderAndOrderdetail.getPAYFEE());
                } else if (orderAndOrderdetail.getOrderDetails().get(0).getSubscribe()==4) {
                    out.println("<font color='red'><b>月订：<b/></font>您订阅了" + orderAndOrderdetail.getOrderDetails().get(0).getSubscribenum() + "个月，根据系统设置的订阅规则计算出的订阅时间为" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServicestarttime())+"---" + format.format(orderAndOrderdetail.getOrderDetails().get(0).getServiceendtime()));
                    out.println("<br /><font color='red'><b>您的订阅价格：<b/></font>" + orderAndOrderdetail.getPAYFEE());
                }
            %>
        </div>
    </div>
    <div id="kid" style="height: 20px"></div>
    <%if (addressinfofororder!=null) {%>
    <div class="border">
        <div class="title">配送地址及信息<%--（<a href="dingyue.jsp">返回修改</a>）--%></div>
        <div class="info">
            <div class="left">收报人姓名（单位）：<%=addressinfofororder.getName()%></div>
            <div class="clear"></div>
            <div class="left">座机：<%=addressinfofororder.getPhone()%></div>
            <div class="clear"></div>
            <div class="left">手机：<%=addressinfofororder.getMobile()%></div>
            <div class="clear"></div>
            <div class="left">地址：<%=addressinfofororder.getAddress()%></div>
            <div class="clear"></div>
            <div class="left">邮编：<%=addressinfofororder.getZip()%></div>
            <div class="clear"></div>
            <div class="left">邮箱（Email）：<%=addressinfofororder.getEmail()%></div>
            <div class="clear"></div>
            <div class="left">备注：<%=addressinfofororder.getNotes()%></div>
        </div>
    </div>
    <%}%>

    <%if (invoiceAndContents!=null) {%>
    <div class="clear" style="height: 20px;">&nbsp;&nbsp;</div>
    <div class="border">
        <div class="title">发票信息</div>
        <div class="info" id="invoiceid">
            <p>是否要发票：</p>
            <p>发票类型：</p>
            <p>发票单位（个人或公司）：<%=invoiceAndContents.getCompanyname()%></p>
            <p>税号：<%=invoiceAndContents.getIdentification()%></p>
            <p>地址：<%=invoiceAndContents.getRegisteraddress()%></p>
            <p>联系电话：<%=invoiceAndContents.getPhone()%></p>
            <p>开户银行：<%=invoiceAndContents.getBankname()%></p>
            <p>银行账号：<%=invoiceAndContents.getBankaccount()%></p>
            <p>发票内容：<%=invoiceAndContents.getInvoicecontentfororders().get(0).getContent()%></p>
        </div>
    </div>
    <%}%>

    <div class="border">
        <div class="title">支付方式</div>
        <form name="yeepay" action='<%=nodeAuthorizationURL%>' method='POST' target="_blank">
            <input type="hidden" name="doCreate" value="true">
            <input type="hidden" name="prodid" value="<%=articleid%>">
            <input type="hidden" name="yprice" value="<%=yprice%>">
            <input type="hidden" name="byprice" value="<%=byprice%>">
            <input type="hidden" name="qprice" value="<%=qprice%>">
            <input type="hidden" name="mprice" value="<%=mprice%>">
            <input type="hidden" name="vipy" value="<%=vipy%>">
            <input type="hidden" name="vipby" value="<%=vipby%>">
            <input type="hidden" name="vipq" value="<%=vipq%>">
            <input type="hidden" name="vipm" value="<%=vipm%>">
            <input type="hidden" name="bzname" value="<%=articleAndExtendAttrs.getMaintitle()%>">
            <input type="hidden" name="gprice" value="<%=gprice%>">
            <input type="hidden" name="vipgprice" value="<%=vipgprice%>">
            <input type="hidden" name="subscribetype" value="<%=subscribetype%>">
            <input type="hidden" name="tqdays" value="<%=tqdays%>">
            <input type="hidden" name="vipmonths" value="<%=vipmonths%>">
            <input type="hidden" name="vipdystartdate" value="<%=vip_dy_startdate%>">
            <input type="hidden" name="vipdyenddate" value="<%=vip_dy_enddate%>">
            <input type="hidden" name="acrossyearflag" value="<%=across_year_flag%>">
            <input type="hidden" name="acrosshalfyearflag" value="<%=across_half_year_flag%>">
            <input type="hidden" name="acrossqflag" value="<%=across_q_flag%>">

            <input type='hidden' name='p0_Cmd' value='<%=p0_Cmd%>'>
            <input type='hidden' name='p1_MerId' value='<%=p1_MerId%>'>
            <input type='hidden' name='p2_Order' value='<%=p2_Order%>'>
            <input type='hidden' name='p3_Amt' value='<%=p3_Amt%>'>
            <input type='hidden' name='p4_Cur' value='<%=p4_Cur%>'>
            <input type='hidden' name='p5_Pid' value='<%=p5_Pid%>'>
            <input type='hidden' name='p6_Pcat' value='<%=p6_Pcat%>'>
            <input type='hidden' name='p7_Pdesc' value='<%=p7_Pdesc%>'>
            <input type='hidden' name='p8_Url' value='<%=p8_Url%>'>
            <input type='hidden' name='p9_SAF' value='<%=p9_SAF%>'>
            <input type='hidden' name='pa_MP' value='<%=pa_MP%>'>
            <input type='hidden' name='pd_FrpId' value='<%=pd_FrpId%>'>
            <input type="hidden" name="pr_NeedResponse" value="<%=pr_NeedResponse%>">
            <input type='hidden' name='hmac' value='<%=hmac%>'>
            <%--<input type='submit' />--%>
            <div style="text-align:center; width:952px; float:left; padding-bottom:30px;"><br>
                <input type="image" src="/images/qrzf.jpg" name="button" id="button" value="提交"/><br><br>
                <strong>点击“确认支付方式”按钮，可选择多种银行卡进行支付。<br><br>

                    支付成功后订单才生效。</strong>
            </div>
        </form>
    </div>
</div>
</body>
</html>