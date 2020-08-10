<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.service.EcService" %>
<%@ page import="com.bizwink.vo.OrderAndOrderdetail" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.service.impl.UsersService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    int userid = authToken.getUid();
    String username = authToken.getUserid();
    String realname = authToken.getUsername();
    Users user = null;
    List<OrderAndOrderdetail> orderAndOrderdetails = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        EcService ecService = (EcService)appContext.getBean("ecService");
        orderAndOrderdetails = ecService.getOrderinfoListByUid(authToken.getUid());

        UsersService usersService = (UsersService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(username);
    }
%>
<html>
<head>
    <title>京报发行网--删除订单</title>
    <script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
    <script language="javascript">
        function deleteOrder(orderid,checkcode,thetime) {
            htmlobj=$.ajax({
                url:"deleteOrder.jsp",
                data: {
                    orderid:orderid,
                    checkcode:checkcode,
                    thetime:thetime
                },
                dataType:'json',
                async:false,
                success:function(data){
                    //alert(data.result);
                    if (data.result == 'true') {
                        $("#row" + orderid).remove();
                        alert("成功删除订单："+orderid);
                    }
                }
            });
        }
    </script>
</head>
<body>
<div id="buyerid">
    <div>买家姓名：<%=(user!=null)?user.getNICKNAME():""%></div>
    <div>买家地址：<%=(user!=null)?user.getADDRESS():""%></div>
    <div>买家电话：<%=(user!=null)?user.getMPHONE():""%></div>
    <div>买家电子邮件：<%=(user!=null)?user.getEMAIL():""%></div>
    <div>买家座机：<%=(user!=null)?user.getPHONE():""%></div>
</div>

<div id="hid" style="height: 30px"></div>
<%if (orderAndOrderdetails!=null) {%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
    <tr>
        <!--td>买家姓名</td>
        <td>地址</td-->
        <td>订单编号</td>
        <td>订单金额</td>
        <td>订单生成日期</td>
        <td>订单状态</td>
        <td>是否支付</td>
        <td>修改</td>
        <td>删除</td>
    </tr>
    <%
        OrderAndOrderdetail orderAndOrderdetail = null;
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(int ii=0; ii<orderAndOrderdetails.size(); ii++) {
            orderAndOrderdetail = orderAndOrderdetails.get(ii);
            //生成不同操作的验证码
            String md5_payment = "/ec/payment.jsp?orderid=" + orderAndOrderdetail.getORDERID();
            Timestamp thetime = new Timestamp(System.currentTimeMillis());
            String checkcodeForPayment =Encrypt.md5(md5_payment.getBytes());
            String md5_update = "/ec/updateOrder.jsp?orderid=" + orderAndOrderdetail.getORDERID();
            String checkcodeForUpdate =Encrypt.md5(md5_update.getBytes());
            String md5_order = "/ec/orders.jsp?orderid=" + orderAndOrderdetail.getORDERID();
            String checkcodeForOrder =Encrypt.md5(md5_order.getBytes());
            String md5_delete = "/ec/deleteOrder.jsp?orderid=" + orderAndOrderdetail.getORDERID();
            String checkcodeForDelete =Encrypt.md5(md5_delete.getBytes());
    %>
    <tr id="row<%=orderAndOrderdetail.getORDERID()%>">
        <!--td><%=orderAndOrderdetail.getNAME()%></td>
        <td><%=orderAndOrderdetail.getADDRESS()%></td-->
        <td><a href="orders.jsp?orderid=<%=orderAndOrderdetail.getORDERID()%>&checkcode=<%=checkcodeForOrder%>&thetime=<%=thetime.getTime()%>" target="_blank"><%=orderAndOrderdetail.getORDERID()%></a></td>
        <td><%=(orderAndOrderdetail.getPAYFEE()==null)?"&nbsp;":orderAndOrderdetail.getPAYFEE()%></td>
        <td><%=format.format(orderAndOrderdetail.getCREATEDATE())%></td>
        <td><%=(orderAndOrderdetail.getSTATUS()==0)?"正常":"取消"%></td>
        <td><%=(orderAndOrderdetail.getPayflag()==0)?"<a href=\"payment.jsp?orderid=" + orderAndOrderdetail.getORDERID() + "&checkcode=" + checkcodeForPayment + "&thetime=" + thetime.getTime() + "\" target=\"_blank\">未支付</a>":"已支付"%></td>
        <td><a href="updateOrder.jsp?orderid=<%=orderAndOrderdetail.getORDERID()%>&checkcode=<%=checkcodeForUpdate%>&thetime=<%=thetime.getTime()%>" target="_blank">修改</a></td>
        <td><a href="#" onclick="javascript:deleteOrder('<%=orderAndOrderdetail.getORDERID()%>','<%=checkcodeForDelete%>','<%=thetime.getTime()%>');">删除</a></td>
    </tr>
    <%}%>
</table>
<%}%>
</body>
</html>
