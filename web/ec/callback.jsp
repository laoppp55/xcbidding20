<%@page contentType="text/html;charset=GBK" %>
<%@page import="com.yeepay.PaymentForOnlineService,com.yeepay.Configuration"%>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%!	String formatString(String text){
			if(text == null) {
				return ""; 
			}
			return text;
		}
%>
<%
	String keyValue   = formatString(Configuration.getInstance().getValue("keyValue"));                            // 商家密钥
	String r0_Cmd 	  = formatString(request.getParameter("r0_Cmd"));                                              // 业务类型
	String p1_MerId   = formatString(Configuration.getInstance().getValue("p1_MerId"));                            // 商户编号
	String r1_Code    = formatString(request.getParameter("r1_Code"));                                             // 支付结果
	String r2_TrxId   = formatString(request.getParameter("r2_TrxId"));                                            // 易宝支付交易流水号
	String r3_Amt     = formatString(request.getParameter("r3_Amt"));                                              // 支付金额
	String r4_Cur     = formatString(request.getParameter("r4_Cur"));                                              // 交易币种
	String r5_Pid     = new String(formatString(request.getParameter("r5_Pid")).getBytes("iso-8859-1"),"gbk");  // 商品名称
	String r6_Order   = formatString(request.getParameter("r6_Order"));                                            // 商户订单号
	String r7_Uid     = formatString(request.getParameter("r7_Uid"));                                              // 易宝支付会员ID
	String r8_MP      = new String(formatString(request.getParameter("r8_MP")).getBytes("iso-8859-1"),"gbk");   // 商户扩展信息
	String r9_BType   = formatString(request.getParameter("r9_BType"));                                            // 交易结果返回类型,1浏览器重定向 2服务器点对点
	String hmac       = formatString(request.getParameter("hmac"));                                                // 签名数据
    String rp_PayDate = formatString(request.getParameter("rp_PayDate"));                                         //支付成功时间
    String ru_Trxtime = formatString(request.getParameter("ru_Trxtime"));                                         //支付状态通知时间

    boolean isOK = false;
	// 校验返回数据包
	isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code,r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
	if(isOK) {
		//在接收到支付结果通知后，判断是否进行过业务逻辑处理，不要重复进行业务逻辑处理
        ApplicationContext appContext = SpringInit.getApplicationContext();
        MEcService mEcService = null;
        if(r1_Code.equals("1")) {
            long orderid = Long.parseLong(r6_Order);
            if (appContext!=null)
                mEcService = (MEcService)appContext.getBean("MEcService");
            else {
                response.sendRedirect("/error.jsp?errcode=-1");
                return;
            }
			// 产品通用接口支付成功返回-浏览器重定向
            SimpleDateFormat format=new SimpleDateFormat("yyyyMMddhhmmss");
			if(r9_BType.equals("1")) {
                //UpdatePayflag(long orderid,String jylsh,String zfmemberid,int r2type,String payresult,int payflag)
                //参数1：订单号
                //参数2：第三方支付服务的交易流水号
                //参数3：支付商户号
                //参数4：支付交易类型
                //参数5：支付返回码
                //参数6：1表示已经完成支付
                //参数7：代表是第三方支付编号，0--微信  2--银行 1-支付宝
                Date pay_sucess_date = format.parse(rp_PayDate);
                mEcService.UpdatePayflag(orderid,r2_TrxId,r7_Uid,r9_BType,r1_Code,1,2,new Timestamp(pay_sucess_date.getTime()));
                out.println("<script   lanugage=\"javascript\">alert(\"支付成功！\");window.close();</script>");
				//out.println("callback方式:产品通用接口支付成功返回-浏览器重定向");
				// 产品通用接口支付成功返回-服务器点对点通讯
			} else if(r9_BType.equals("2")) {
				// 如果在发起交易请求时	设置使用应答机制时，必须应答以"success"开头的字符串，大小写不敏感
                //orderMgr.updateStatus(id,4,"");
                //参数1：订单号
                //参数2：第三方支付服务的交易流水号
                //参数3：支付商户号
                //参数4：支付交易类型
                //参数5：支付返回码
                //参数6：1表示已经完成支付
                //参数7：代表是第三方支付编号，0--微信  2--银行 1-支付宝
                Date pay_sucess_date = format.parse(rp_PayDate);
                mEcService.UpdatePayflag(orderid,r2_TrxId,r7_Uid,r9_BType,r1_Code,1,2,new Timestamp(pay_sucess_date.getTime()));
				out.println("SUCCESS");
			  // 产品通用接口支付成功返回-电话支付返回		
			}
			// 下面页面输出是测试时观察结果使用
			//out.println("<br>交易成功!<br>商家订单号:" + r6_Order + "<br>支付金额:" + r3_Amt + "<br>易宝支付交易流水号:" + r2_TrxId);
		}
	} else {
		out.println("交易签名被篡改!");
	}
%>