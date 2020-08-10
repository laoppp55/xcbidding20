<%@page import="com.bizwink.cms.kings.deliverymaster.DeliveryMaster,
                com.bizwink.cms.kings.deliverymaster.DeliveryMasterPeer,
                com.bizwink.cms.kings.deliverymaster.IDeliveryMasterManager,
                com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.*" %>
<%@ page import="com.bizwink.cms.kings.deliverydetail.*" %>
<%
    String id = ParamUtil.getParameter(request, "id");
    DeliveryMaster dm = new DeliveryMaster();
    IDeliveryMasterManager delMgr = DeliveryMasterPeer.getInstance();
    dm = delMgr.getByIdDeliveryMaster(id);
    IDeliveryDetailManager ddMgr = DeliveryDetailPeer.getInstance();
    DeliveryDetail dd = new DeliveryDetail();
    List list = new ArrayList();
    list = ddMgr.getByIdDeliveryDetails(id);

    Timestamp deliverydate = dm.getDeliveryDate();
    String customerid = dm.getCustomerID();
    String salesmanid = dm.getSalesManID();
    String deliveryproperty = dm.getDeliveryProperty();
    String deliveryaddress = dm.getDeliveryAddress();
    String invoiceno = dm.getInvoiceNo();
    String customerorderno = dm.getCustomerOrderNo();
    String subtotal = Integer.toString(dm.getSubTotal());
    String valueaddtax = Integer.toString(dm.getValueAddTax());
    String amount = Integer.toString(dm.getAmount());
    String accountreceivable = Integer.toString(dm.getAccountReceivable());
    String received = Integer.toString(dm.getReceived());
    Timestamp limitdate = dm.getLimitDate();
%>
<HTML>
<HEAD><TITLE>�����������Ϣ</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<CENTER>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80% borderColorLight=#008000 border=1>
        <TBODY>
        <TR>
            <TD bgColor=#33ccff colSpan=2 height=32>
                <P align=center>��������Ϣ</P></TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>���������ţ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=id%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�������ڣ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=deliverydate.toString().substring(0, 10)%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�ͻ���ţ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=customerid == null ? "--" : customerid%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>ҵ��Ա��ţ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=salesmanid == null ? "--" : salesmanid%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>���������ԣ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%if(deliveryproperty != null){if(deliveryproperty.equals("1")){
                %>����<%}else{%>�����˳�<%}}%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�ͻ���ַ��</TD>
            <TD align=left width=70% height=32>&nbsp;<%=deliveryaddress == null ? "--" : deliveryaddress%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>��Ʊ���룺</TD>
            <TD align=left width=70% height=32>&nbsp;<%=invoiceno == null ? "--" : invoiceno%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�������룺</TD>
            <TD align=left width=70% height=32>&nbsp;<%=customerorderno == null ? "--" : customerorderno%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�ϼƽ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=subtotal == null ? "--" : subtotal%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>Ӫҵ˰��</TD>
            <TD align=left width=70% height=32>&nbsp;<%=valueaddtax == null ? "--" : valueaddtax%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�ܼƽ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=amount == null ? "--" : amount%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>Ӧ�ս�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=accountreceivable == null ? "--" : accountreceivable%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>���ս�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=received == null ? "--" : received%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32>�տ��ֹ�գ�</TD>
            <TD align=left width=70% height=32>&nbsp;<%=limitdate.toString().substring(0, 10)%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=30% height=32 colspan="2">
                <table cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=100% borderColorLight=#008000 border=1>
                    <tr><td bgColor=#33ccff height="32" colspan="4" align="center">��������ϸ</td></tr>
                    <tr><TD align=center width=40% height=32>��Ʒ����</TD>
                    <TD align=center width=20% height=32>����</TD>
                    <TD align=center width=20% height=32>����</TD>
                    <TD align=center width=20% height=32>���</TD>
                    </tr><%
                           if(list != null){
                               for(int i = 0; i < list.size(); i++){
                                   dd = (DeliveryDetail)list.get(i);
                                   String productid = dd.getProductID();
                                   String salesquantity = Integer.toString(dd.getSalesQuantity());
                                   String salesunitprice = Integer.toString(dd.getSalesUnitPrice());
                                   String salesamount = Integer.toString(dd.getSalesAmount());

                    %>
                    <tr><TD align=center width=40% height=32>&nbsp;<%=productid == null ? "--" : productid%></TD>
                    <TD align=center width=20% height=32>&nbsp;<%=salesquantity == null ? "--" : salesquantity%></TD>
                    <TD align=center width=20% height=32>&nbsp;<%=salesunitprice == null ? "--" : salesunitprice%></TD>
                    <TD align=center width=20% height=32>&nbsp;<%=salesamount == null ? "--" : salesamount%></TD>
                    </tr>
                    <%} }%>
                </table>                
            </TD>
        </TR>
        </TBODY>
    </TABLE>
</CENTER>
<BR><BR>
<CENTER><INPUT onclick=javascript:history.go(-1); type=button value=" �� �� ">
</CENTER>
</BODY>
</HTML>
