<%@page language="java" contentType="text/html;charset=gbk"%>
<%@page import="com.yeepay.PaymentForOnlineService,com.yeepay.QueryResult"%>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.wxpay.WXPayService" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.bizwink.cms.business.Order.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%!
    String formatString(String text){
        if(text == null) return "";  return text;
    }
%>
<%@ include file="../../../include/auth.jsp"%>
<%
    IOrderManager orderManager = orderPeer.getInstance();

    int payway = ParamUtil.getIntParameter(request,"payway",0);
    int startrow = ParamUtil.getIntParameter(request,"start",0);
    int doUpdate = ParamUtil.getIntParameter(request,"startflag",0);
    String p2_Order   = formatString(request.getParameter("orderid"));
    List list = orderManager.getDetailList(Long.parseLong(p2_Order));
    int status = orderManager.getStatus(Long.parseLong(p2_Order));
    Map<String, String> qr = null;
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
    SimpleDateFormat disp_format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    String payresult = "";                                 //����֧��������ɹ�Ϊ��SUCCESS��
    String paylsh = null;                                    //֧�����ķ��صĽ�����ˮ��
    String mch_id = null;                                    //�̻�ID
    String jy_type = null;                                   //�������ͣ�����֧��Ϊbank��΢��ɨ��֧��ΪNATIVE
    String paydatetime = null;                               //֧����ɵ�ʱ��
    int retcode = -1;                                        //֧�������Ѿ������֧��������֧��״̬û�з��أ��ֹ��޸�֧��״̬�ķ����룬��������Ϊ0
    if (doUpdate == 0) {
        try {
            if (payway == 2) {                                                      //����֧����ѯ
                qr = PaymentForOnlineService.queryByOrder(p2_Order);                // ���ú�̨�����ѯ����
                if (qr.get("rb_PayStatus").equals("SUCCESS")) {
                    payresult = qr.get("rb_PayStatus");
                    paylsh = qr.get("r2_TrxId");
                    mch_id = qr.get("mch_id");
                    jy_type = "bank";
                    paydatetime = qr.get("ry_FinshTime");
                    //out.println("ҵ������:" + qr.get("r0_Cmd") + "<br>");
                    //out.println("��ѯ���:" + qr.get("r1_Code") + "<br>");
                    String prodname = "";
                    for (int ii = 0; ii < list.size(); ii++) {
                        Order order = (Order) list.get(ii);
                        prodname = order.getProductname();
                    }
                    out.println("��Ʒ����:" + prodname + "<br>");
                    out.println("������:" + qr.get("r6_Order") + "<br>");
                    out.println("֧��������ˮ��:" + qr.get("r2_TrxId") + "<br>");
                    out.println("֧�����:" + qr.get("r3_Amt") + "<br>");
                    out.println("���ױ���:" + qr.get("r4_Cur") + "<br>");
                    out.println("֧��״̬:" + qr.get("rb_PayStatus") + "<br>");
                    //out.println("֧������ʱ��:" +  qr.get("rx_CreateTime") + "]<br>");
                    out.println("֧�����ʱ��:" + qr.get("ry_FinshTime") + "<br>");
                    if (qr.get("hmacError") != null)
                        out.println("��֤��Ϣ����:" + qr.get("hmacError") + "<br>");
                    else
                        out.println("��֤��Ϣ����:" + "<br>");
                    if (qr.get("errorMsg") != null)
                        out.println("������Ϣ:" + qr.get("errorMsg") + "<br>");
                    else
                        out.println("������Ϣ:" + "<br>");

                    //out.println("�̻���չ��Ϣ:" +  qr.get("r8_MP") + "<br>");
                    //out.println("���˿���� [rc_RefundCount:" + qr.get("rc_RefundCount") + "]<br>");
                    //out.println("���˿��� [rd_RefundAmt:" + qr.get("rd_RefundAmt") + "]<br>");
                    //out.println("[rw_RefundRequestID:" +  qr.get("rw_RefundRequestID") + "]<br>");
                    //out.println("[rz_RefundAmount:" +  qr.get("rz_RefundAmount") + "]<br>");
                } else {
                    out.println("����" + p2_Order + "δ֧��<br>");
                }
            } else if (payway == 0) {
                //��ѯ΢�Ÿ�����Ϣ
                WXPayService wxPayService = WXPayService.getInstance();
                qr = wxPayService.tradeQuery(p2_Order);
                System.out.println("��ѯ΢�Ŷ�����Ϣ" + qr.get("result_code"));
                if (qr.get("result_code").equals("SUCCESS") && qr.get("trade_state_desc").equals("֧���ɹ�")) {
                    payresult = qr.get("result_code");
                    paylsh = qr.get("transaction_id");
                    mch_id = qr.get("mch_id");
                    jy_type = qr.get("trade_type");
                    paydatetime = qr.get("time_end");
                    Date date = format.parse(qr.get("time_end"));
                    out.println("֧��������ˮ��" + qr.get("transaction_id") + "<br>");
                    out.println("�����ţ�" + qr.get("out_trade_no") + "<br>");
                    String prodname = "";
                    for (int ii = 0; ii < list.size(); ii++) {
                        Order order = (Order) list.get(ii);
                        prodname = order.getProductname();
                    }
                    out.println("���ı�ֽ��" + prodname + "<br>");
                    out.println("֧����" + Float.parseFloat(qr.get("total_fee")) / 100 + "<br>");
                    out.println("֧�����֣�" + qr.get("fee_type") + "<br>");
                    out.println("֧�����������" + qr.get("trade_state_desc") + "<br>");
                    out.println("֧�����ʱ�䣺" + disp_format.format(date) + "<br>");

                    //out.println(qr.get("body"));
                    //out.println(qr.get("product_id"));
                    //out.println(qr.get("return_code"));
                    //out.println(qr.get("result_code"));
                    //out.println(qr.get("cash_fee"));
                    //out.println(qr.get("attach"));
                } else {
                    out.println("����" + p2_Order + "δ֧��<br>");
                }
            }
        } catch (Exception e) {
            out.println(e.getMessage());
        }
    } else if (status!=8){
        String orderid = ParamUtil.getParameter(request,"orderid");
        payresult = ParamUtil.getParameter(request,"payresult");
        payway = ParamUtil.getIntParameter(request,"payway",0);
        paylsh = ParamUtil.getParameter(request,"lsh");
        mch_id = ParamUtil.getParameter(request,"mchid");
        jy_type = ParamUtil.getParameter(request,"jytype");
        paydatetime = ParamUtil.getParameter(request,"paydatetime");
        format = new SimpleDateFormat("yyyyMMddhhmmss");

        Order order = new Order();
        order.setOrderid(Long.parseLong(orderid));                                            //������
        order.setR2TrxId(paylsh);                                                //֧�������صĽ�����ˮ��
        order.setZfmemberid(mch_id);                                               //�̻�ID
        order.setR2type(jy_type);                                                             //�������ͣ�ɨ��֧��
        order.setPayresult(payresult);                                         //���׷��ؽ��
        order.setPaydate(new Timestamp(format.parse(paydatetime).getTime()));   //�������ʱ��
        order.setPayWay(payway);                                                                   //0΢��֧����1֧������2����֧��
        order.setStatus(8);
        //8��ʾ�����������Ѿ����֧��
        retcode = orderManager.updateOrderinfoByZhifuResult(order);
    }
%>
<html>
<head>
    <title>�޸Ķ���״̬</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" href="../../images/pt9.css">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <script type="text/javascript" src="../../../js/jquery-1.11.1.min.js"></script>
    <script language="javascript">
        var errcode = <%=retcode%>;
        $(document).ready(function() {
            if (errcode == 0) {
                alert("����֧��״̬�Ѿ��޸�");
                opener.location.href = "index.jsp?startrow=" + searchForm.start.value;
                window.close();
            }
        });

        function closewin(){
            window.close();
        }
    </script>
</head>

<body bgcolor="#FFFFFF">
<%if (status!=8 && payresult.equals("SUCCESS")) {  //����֧��״̬������8���Ҷ�����ѯ�����֧���ɹ���״̬����ʾ�޸Ķ�����֧��״̬%>
<center><br>
    <form name="searchForm" action="searchInfoFromPaycenter.jsp" method="post">
        <input type="hidden" name="startflag" value="1">
        <input type="hidden" name="start" value="<%=startrow%>">
        <input type="hidden" name="orderid" value="<%=p2_Order%>">
        <input type="hidden" name="payresult" value="<%=payresult%>">
        <input type="hidden" name="payway" value="<%=payway%>">
        <input type="hidden" name="lsh" value="<%=paylsh%>">
        <input type="hidden" name="mchid" value="<%=mch_id%>">
        <input type="hidden" name="jytype" value="<%=jy_type%>">
        <input type="hidden" name="paydatetime" value="<%=paydatetime%>">
        <p>֧��������ʾ�û��Ѿ������֧��������֧�����ĵ���Ϣ��������ԭ��δ��ͬ������Ϣ����վ��������ȷ���޸ġ���ť�޸Ķ���֧��״̬</p>
        <p align="center"><input type="submit" name="Ok" value="ȷ���޸�">&nbsp;&nbsp;<input type="button" name="close" value="�ر�" onclick="javascript:closewin();"></p>
    </form>
</center>
<%}%>
</body>
</html>
