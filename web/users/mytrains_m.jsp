<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.service.impl.UsersService" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.EcService" %>
<%@ page import="com.bizwink.po.Orders" %>
<%@ page import="com.bizwink.service.ArticleService" %>
<%@ page import="com.bizwink.vo.ArticleAndExtendAttrs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.po.ArticleExtendattr" %>
<%@ page import="com.bizwink.service.ColumnService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken==null) {
		response.sendRedirect("/users/login_m.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
		return;
	}
	int userid = authToken.getUid();
	int siteid = authToken.getSiteid();
	String username = authToken.getUserid();
	Users user = null;
	int range = 2;
	String pagesstr = filter.excludeHTMLCode(request.getParameter("currpage"));
	int pages = 1;  //当前页
	if (pagesstr == null) {
		pages = 1;
	} else {
		pages = Integer.parseInt(pagesstr);
	}
	int orderCount = 0;
	List<Orders> ordersList = null;
	List<ArticleAndExtendAttrs> articleAndExtendAttrsList = null;
	ColumnService columnService = null;
	EcService ecService = null;
	ArticleService articleService = null;
	ApplicationContext appContext = SpringInit.getApplicationContext();
	if (appContext!=null) {
		ecService = (EcService)appContext.getBean("ecService");
		orderCount = ecService.getOrdersNumByUID(userid);
		ordersList = ecService.getOrdersByUIDInPage(siteid,userid,((pages-1)*range+1),(pages*range));
		List<Integer> artids = new ArrayList<Integer>();
		for(int ii=0;ii<ordersList.size();ii++) {
			Orders order = ordersList.get(ii);
			artids.add(order.getProjartid());
		}

		columnService = (ColumnService)appContext.getBean("columnService");

		articleService = (ArticleService)appContext.getBean("articleService");
		articleAndExtendAttrsList = articleService.getArticlesIncludeAttrs(artids);

		UsersService usersService = (UsersService)appContext.getBean("usersService");
		user = usersService.getUserinfoByUserid(username);
	}

	int totalPages = 0;  //总页数
	if (orderCount % range == 0) {
		totalPages = orderCount / range;
	} else {
		totalPages = orderCount / range + 1;
	}
%>
<!doctype html>
<html>
<head xmlns="">
	<title>北京城建集团党校---个人中心</title>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<meta content="no-cache" http-equiv="Cache-Control" />
	<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
	<meta content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" name="viewport" />
	<meta content="750" name="MobileOptimized" />
	<link href="/css/m_basis.css" rel="stylesheet" type="text/css" />
	<link href="/css/m_program.css" rel="stylesheet" type="text/css" />
	<link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
	<script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
	<script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
	<script src="/js/users.js" type="text/javascript"></script>
	<script language="javascript">
        function deleteOrder(orderid,checkcode,thetime) {
            htmlobj=$.ajax({
                url:"/ec/deleteOrder_m.jsp",
                data: {
                    orderid:orderid,
                    checkcode:checkcode,
                    thetime:thetime
                },
                dataType:'json',
                async:false,
                success:function(data){
                    if (data.result == 'true') {
                        $("#row" + orderid).remove();
                        alert("成功删除订单："+orderid);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    /*弹出jqXHR对象的信息*/
                    alert(jqXHR.responseText);
                    alert(jqXHR.status);
                    alert(jqXHR.readyState);
                    alert(jqXHR.statusText);
                    /*弹出其他两个参数的信息*/
                    alert(textStatus);
                    alert(errorThrown);
                }
            });
        }

        function queryPay(orderid) {
            htmlobj=$.ajax({
                url:"/ec/queryPayinfo.jsp",
                data: {
                    orderid:orderid
                },
                dataType:'json',
                async:false,
                success:function(data){
                    if (data.支付方式 == '微信支付') {
                        alert('你已经使用微信支付方式完成了支付，不需要在进行支付，支付信息如下\r\n' +
                            '支付方式：微信支付\r\n' +
                            '商品名称：' + data.商品名称 + '\r\n' +
                            '订单号：' + data.订单号 + '\r\n' +
                            '支付交易流水号：' + data.支付交易流水号 + '\r\n' +
                            '支付金额：' + data.支付金额 + '\r\n' +
                            '交易币种：' + data.交易币种 + '\r\n' +
                            '支付状态：' + data.支付状态 + '\r\n' +
                            '支付完成时间：' + data.支付完成时间);
                    } else if (data.支付方式 == '银行支付') {
                        alert('你已经使用银行支付方式完成了支付，不需要在进行支付，支付信息如下' + '\r\n' +
                            '支付方式：银行支付' + '\r\n' +
                            '商品名称：' + data.商品名称 + '\r\n' +
                            '订单号：' + data.订单号 + '\r\n' +
                            '支付交易流水号：' + data.支付交易流水号 + '\r\n' +
                            '支付金额：' + data.支付金额 + '\r\n' +
                            '交易币种：' + data.交易币种 + '\r\n' +
                            '支付状态：' + data.支付状态 + '\r\n' +
                            '支付完成时间：' + data.支付完成时间);
                    }
                }
            });
        }

        function showProjDetail(orderid) {
            var iWidth=window.screen.availWidth-400;                                                 //弹出窗口的宽度;
            var iHeight=600;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/users/trainprjdetail.jsp?orderid=" + orderid, "", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
        }
	</script>
</head>
<body class="home" style=" background-color:#F5F5F5">
<div class="personal_top">
	<div class="go_back"><a href="javascript:history.go(-1)"><img src="/images/arrow_white.png" /></a></div>

	<div class="title_white_personal">我的项目</div>
</div>
<%for(int ii=0;ii<ordersList.size();ii++) {
	Orders order = ordersList.get(ii);

	//List<Integer> zhuce = columnService.getSubColumnIDCollection(BigDecimal.valueOf(74));      //注册类培训
	//List<Integer> manager = columnService.getSubColumnIDCollection(BigDecimal.valueOf(76));    //现场管理人员类培训
	//List<Integer> operate = columnService.getSubColumnIDCollection(BigDecimal.valueOf(77));    //现场操作人员培训

	//获取培训项目开始培训时间和结束培训时间
	String pxbt = null,pxet=null;
	int train_type = 0;
	List<ArticleExtendattr> extendattrs=null;
	ArticleAndExtendAttrs articleAndExtendAttrs = null;
	for(int jj=0;jj<articleAndExtendAttrsList.size();jj++) {
		articleAndExtendAttrs = articleAndExtendAttrsList.get(jj);
		train_type = columnService.getTrainType(BigDecimal.valueOf(articleAndExtendAttrs.getColumnid()));
		if (articleAndExtendAttrs.getId()==order.getProjartid()) {
			break;
		}
	}

	if(articleAndExtendAttrs!=null) {
		extendattrs = articleAndExtendAttrs.getArticleExtendattrs();
		for (int jj=0; jj<extendattrs.size();jj++) {
			ArticleExtendattr extendattr = extendattrs.get(jj);
			if (extendattr.getEname().equals("_pxbt")) pxbt = extendattr.getStringvalue();
			if (extendattr.getEname().equals("_pxet")) pxet = extendattr.getStringvalue();
		}
	}

	//生成不同操作的验证码
	Timestamp thetime = new Timestamp(System.currentTimeMillis());
	//注册类订单的修改
	String updateForZhuce = "/ec/updateOrderForZhuce_m.jsp?orderid=" + order.getORDERID();
	String checkcodeForUpdateOfZhuce =Encrypt.md5(updateForZhuce.getBytes());
	//现场管理人员培训订单的修改
	String updateForManage = "/ec/updateOrderForManage_m.jsp?orderid=" + order.getORDERID();
	String checkcodeForUpdateOfManage =Encrypt.md5(updateForManage.getBytes());
	//现场管理人员培训订单的修改
	String updateForOperate = "/ec/updateOrderForOperate_m.jsp?orderid=" + order.getORDERID();
	String checkcodeForUpdateOfOperate =Encrypt.md5(updateForOperate.getBytes());
	//现场管理人员培训订单的修改
	String updateForThree = "/ec/updateOrderForThree_m.jsp?orderid=" + order.getORDERID();
	String checkcodeForUpdateOfThree =Encrypt.md5(updateForThree.getBytes());
	//支付订单信息
	String orderinfo = "/ec/orders.jsp?orderid=" + order.getORDERID();
	String checkcodeForOrder =Encrypt.md5(orderinfo.getBytes());
	//删除订单信息
	String delete = "/ec/deleteOrder_m.jsp?orderid=" + order.getORDERID();
	String checkcodeForDelete = Encrypt.md5(delete.getBytes());
%>

<div class="white_box" id="row<%=order.getORDERID()%>">
	<div>
		<p>培训项目编号：<%=order.getProjcode()%></p>

		<p>培训项目名称 : <%=order.getProjname()%></p>

		<p>培训金额：<%=order.getTOTALFEE()%></p>

		<p>开始时间：<%=pxbt%></p>

		<p>结束时间 : <%=pxet%></p>

		<p>项目状态 : 正常</p>

		<p>是否支付 : 已支付</p>
	</div>
	<%if (order.getPayflag() == 0) {%>
	<%if (order.getProjcode().equals("101") || order.getProjcode().equals("102") ||order.getProjcode().equals("103")||order.getProjcode().equals("104")) {%>
	<div class="ctrl_box">
		<span class="edit"><a href="/ec/updateOrderForZhuce_m.jsp?orderid=<%=order.getORDERID()%>&checkcode=<%=checkcodeForUpdateOfZhuce%>&thetime=<%=thetime.getTime()%>" target="_blank">修改</a></span>
		<span class="del"><a href="#" onclick="javascript:deleteOrder('<%=order.getORDERID()%>','<%=checkcodeForDelete%>','<%=thetime.getTime()%>');">删除</a></span>
	</div>
	<%} else if (order.getProjcode().equals("105")) {%>
	<div class="ctrl_box">
		<span class="edit"><a href="/ec/updateOrderForManage_m.jsp?orderid=<%=order.getORDERID()%>&checkcode=<%=checkcodeForUpdateOfManage%>&thetime=<%=thetime.getTime()%>" target="_blank">修改</a></span>
		<span class="del"><a href="#" onclick="javascript:deleteOrder('<%=order.getORDERID()%>','<%=checkcodeForDelete%>','<%=thetime.getTime()%>');">删除</a></span>
	</div>
	<%} else if (order.getProjcode().equals("106")) {%>
	<div class="ctrl_box">
		<span class="edit"><a href="/ec/updateOrderForOperate_m.jsp?orderid=<%=order.getORDERID()%>&checkcode=<%=checkcodeForUpdateOfOperate%>&thetime=<%=thetime.getTime()%>" target="_blank">修改</a></span>
		<span class="del"><a href="#" onclick="javascript:deleteOrder('<%=order.getORDERID()%>','<%=checkcodeForDelete%>','<%=thetime.getTime()%>');">删除</a></span>
	</div>
	<%} else if (order.getProjcode().equals("107")) {%>
	<div class="ctrl_box">
		<span class="edit"><a href="/ec/updateOrderForThree_m.jsp?orderid=<%=order.getORDERID()%>&checkcode=<%=checkcodeForUpdateOfThree%>&thetime=<%=thetime.getTime()%>" target="_blank">修改</a></span>
		<span class="del"><a href="#" onclick="javascript:deleteOrder('<%=order.getORDERID()%>','<%=checkcodeForDelete%>','<%=thetime.getTime()%>');">删除</a></span>
	</div>
	<%} else {%>
	<script>
        alert("未知的培训类别！！！");
	</script>
	<%}%>

	<!--div class="ctrl_box"><span class="edit"><a href="#">编辑</a></span><span class="del"><a href="#">删除</a></span></div-->
	<%}%>
</div>
<%}%>
	<script>
        Pagination(<%=totalPages%>,<%=pages%>,null,"mytrains_m.jsp");
	</script>
	<!--a href="/xwxx/qyyw/index.shtml">上一页</a><span class="cur">1</span> <a href="/xwxx/qyyw/index1.shtml">2</a> <a href="/xwxx/qyyw/index2.shtml">3</a> <a href="/xwxx/qyyw/index3.shtml">4</a> <a href="/xwxx/qyyw/index4.shtml">5</a> <a href="/xwxx/qyyw/index1.shtml">下一页</a-->
</body>
</html>
