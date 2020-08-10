<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*,
                 java.text.*"
         contentType="text/html;charset=gbk" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    long orderid = ParamUtil.getLongParameter(request, "orderid", 0);
    int siteid = authToken.getSiteID();
    Order theorder = new Order();
    List list = new ArrayList();
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatDateAndTime=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    IOrderManager orderMgr = orderPeer.getInstance();
    theorder = orderMgr.getAOrder(orderid);
    list = orderMgr.getDetailList(orderid);

    AddressInfo addressInfo = orderMgr.getAAddresInfoForOrder(orderid);
    Invoice invoice = orderMgr.getInvoiceInfoForOrder(orderid);

%>
<html>
<head>
    <title>�ͻ���������</title>
</head>
<body>
<table width="1200" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2">
    <tr>
        <td bgcolor="#f6f4f4" style="padding-left:30px;"><strong>��ȷ�϶�����Ϣ��</strong></td>
    </tr>
    <%
        for(int ii=0; ii<list.size(); ii++) {
            Order order = (Order)list.get(ii);
            String prodname = order.getProductname();
            Timestamp createdate = order.getCreateDate();

        /*    int bznum = order.getOrderNum();
            int subscribe = order.getSubscribe();
            int subscribenum = order.getSubscribenum();
            Timestamp userinstartdate = null;
            Timestamp userinenddate = null;
            Timestamp servicestartdate = null;
            Timestamp serviceenddate = null;

            if (order.getUserinstarttime()!=null)
                userinstartdate = new Timestamp(order.getUserinstarttime().getTime());
            if (order.getUserinendtime()!=null)
                userinenddate = new Timestamp(order.getUserinendtime().getTime());
            if (order.getServicestarttime()!=null)
                servicestartdate = new Timestamp(order.getServicestarttime().getTime());
            if (order.getServiceendtime()!=null)
                serviceenddate = new Timestamp(order.getServiceendtime().getTime());*/
    %>
    <tr>
        <td bgcolor="#ffffff" style="padding-left:30px;">
            <p>
                ������ţ�<%=orderid%>����������ʱ�䣺<%=format.format(createdate)%>��<Br/>
                �γ����ƣ�<span class="red"><%=(prodname!=null)?prodname:""%></span><Br/>
                <%--��ֽ������<%=bznum%><Br/>--%>
                �γ̽�<%=order.getSaleprice()%>Ԫ<Br/>
                ����ʱ�䣺<%=formatDateAndTime.format(order.getCreateDate())%><Br/>
            </p>
            <%--<p>
                ���ķ�ʽ<br/>
                <%
                    if(subscribe==1) {
                        out.println("�궩������ϵͳ���õĶ��Ĺ��������Ķ���ʱ��Ϊ" + format.format(servicestartdate)+"---" + format.format(serviceenddate));
                        //out.println("<br />���Ķ��ļ۸�" + orderAndOrderdetail.getPAYFEE());
                    } else if (subscribe==2) {
                        out.println("���궩������ϵͳ���õĶ��Ĺ��������Ķ���ʱ��Ϊ" + format.format(servicestartdate)+"---" + format.format(serviceenddate));
                        //out.println("<br />���Ķ��ļ۸�" + orderAndOrderdetail.getPAYFEE());
                    } else if (subscribe==3) {
                        out.println("��������������" + subscribenum + "�����ȣ�����ϵͳ���õĶ��Ĺ��������Ķ���ʱ��Ϊ" + format.format(servicestartdate)+"---" + format.format(serviceenddate));
                        //out.println("<br />���Ķ��ļ۸�" + orderAndOrderdetail.getPAYFEE());
                    } else if (subscribe==4) {
                        out.println("�¶�����������" + subscribenum + "���£�����ϵͳ���õĶ��Ĺ��������Ķ���ʱ��Ϊ" + format.format(servicestartdate)+"---" + format.format(serviceenddate));
                        //out.println("<br />���Ķ��ļ۸�" + orderAndOrderdetail.getPAYFEE());
                    }
                %>
            </p>--%>
            <%}%>
          <%--  <p>
                ������Ϣ<Br/>
                �ձ�����������λ����<%=(addressInfo!=null)?addressInfo.getName():""%><Br/>
                ������<%=(addressInfo!=null)?(addressInfo.getPhone()==null)?"":addressInfo.getPhone():""%><Br/>
                �ֻ���<%=(addressInfo!=null)?(addressInfo.getMobile()==null)?"":addressInfo.getMobile():""%><Br/>
                ��ַ��<%=(addressInfo!=null)?addressInfo.getAddress():""%><Br/>
                �ʱࣺ<%=(addressInfo!=null)?addressInfo.getZip():""%><Br/>
                ��ע��<%=(addressInfo!=null)?(addressInfo.getNotes()==null)?"":addressInfo.getNotes():""%><Br/>
            </p>
            <%if (invoice!=null) {%>
            <p>
                ��Ʊ��Ϣ<Br/>
                <%if (theorder.getNees_invoice()==0) {%>
                �Ƿ�Ҫ��Ʊ����Ҫ��Ʊ<Br/>
                <%} else {%>
                �Ƿ�Ҫ��Ʊ��Ҫ��Ʊ<Br/>
                <%}%>
                <%if (theorder.getNees_invoice()==1) {%>
                ��Ʊ���ͣ�����ר�Ʊ<Br/>
                <%} else if (theorder.getNees_invoice()==2){%>
                ��Ʊ���ͣ�������ͨ��Ʊ<Br/>
                <%} else {%>
                ��Ʊ���ͣ�δ֪��Ʊ����<Br/>
                <%}%>
                ��Ʊ��λ��<%=invoice.getCompanyname()%><Br/>
                ˰�ţ�<%=invoice.getIdentification()%><Br/>
                ��ַ��<%=(invoice.getRegisteraddress()==null)?"":invoice.getRegisteraddress()%><Br/>
                ��ϵ�绰��<%=(invoice.getPhone()==null)?"":invoice.getPhone()%><Br/>
                �������У�<%=invoice.getBankname()%><Br/>
                �����˺ţ�<%=invoice.getBankaccount()%><Br/>
                ��Ʊ���ݣ�<%=invoice.getContentinfo()%><Br/>
                &lt;%&ndash;�����ʼ���<%=(invoice.getEmail()==null)?"":invoice.getEmail()%><Br/>&ndash;%&gt;
            </p>
            <%}%>--%>
        </td>
    </tr>
</table>
</body>
</html>
