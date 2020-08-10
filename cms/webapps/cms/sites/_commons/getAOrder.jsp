<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.business.Product.Product" %>
<%@ page import="com.bizwink.cms.business.Product.productPeer" %>
<%@ page import="com.bizwink.cms.business.Product.IProductManager" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    long orderid = ParamUtil.getLongParameter(request, "orderid", 0);

    IOrderManager oMgr = orderPeer.getInstance();
    List list = new ArrayList();
    list = oMgr.getDetailList(orderid);

    Order order = new Order();
    order = oMgr.getAOrder(orderid);

    DecimalFormat df = new DecimalFormat();
    df.applyPattern("0.00");
    DecimalFormat df2 = new DecimalFormat();
    df2.applyPattern("0");
    Fee fee = new Fee();
    fee = oMgr.getAFeeInfo(order.getSendWay());
    SendWay payway = oMgr.getASendWayInfo(order.getPayWay());
    String paywaystr = "";
    if (payway == null) {
        paywaystr = "��������";
    } else {
        paywaystr = payway.getCname() == null ? "--" : StringUtil.gb2iso4View(payway.getCname());
    }
    String feestr = "";
    if (fee == null) {
        feestr = "ͬ���ͻ�";
    } else {
        feestr = fee.getCname() == null ? "--" : StringUtil.gb2iso4View(fee.getCname());
    }
    String status = "";
    if (order.getStatus() == 0) {
        status = "�ͻ�ȡ��";
    }
    if (order.getStatus() == 1) {
        status = "������";
    }
    if (order.getStatus() == 2) {
        status = "����";
    }
    if (order.getStatus() == 3) {
        status = "�˻�";
    }
    if (order.getStatus() == 4) {
        status = "���";
    }
    if (order.getStatus() == 5) {
        status = "����";
    }
    if (order.getStatus() == 6) {
        status = "ȱ��";
    }
    if (order.getStatus() == 7) {
        status = "�ȴ�����";
    }
    String outstr = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" class=\"biz_table\">";

    outstr = outstr + "<td class=\"moduleTitle\"><font color=\"#48758C\">����<font color=red>" + orderid + "</font>��ϸ��Ϣ(��������" + order.getCreateDate().toString().substring(0, 10)
            + ")</font></td>\n" +
            "</tr>\n" +
            "<tr bgcolor=\"#d4d4d4\" align=\"right\">\n" +
            "<td>\n" +
            "<table width=\"100%\" border=\"0\" cellpadding=\"2\" cellspacing=\"1\">\n" +
            "    <tr bgcolor=\"#FFFFFF\">\n" +
            "        <td align=\"center\">��Ʒ����</td>\n" +
            "        <td align=\"center\">�ۼ�</td>\n" +
            "        <td align=\"center\">������</td>\n" +
            "        <td align=\"center\">�ռ�������</td>\n" +
            "        <td align=\"center\">�ռ��˵�ַ</td>\n" +
            "        <td align=\"center\">�ռ����ʱ�</td>\n" +
            "        <td align=\"center\">�ռ��˵绰</td>\n" +
            "        <td align=\"center\">���ʽ</td>\n" +
            "        <!--<td align=\"center\">����</td>-->\n" +
            "        <td align=\"center\">ȡ����ʽ</td>\n" +
            "        <td align=\"center\">����״̬</td>\n" +
            "        <td align=\"center\">�ܷ���</td>\n" +
            "        <td align=\"center\">�ʼķ���</td>\n" +
            "    </tr>";
    IProductManager productMgr = productPeer.getInstance();
    Product product = new Product();
    for (int i = 0; i < list.size(); i++) {
        Order orderex = (Order) list.get(i);
        product = productMgr.getAProduct(orderex.getProductid());
        String phone = "";
        if ((order.getPhone() != null) && (!"".equals(order.getPhone()))) {
            phone = order.getPhone();
            phone = StringUtil.gb2iso4View(phone);
        } else {
            phone = oMgr.getPhone(orderid);
            phone = StringUtil.gb2iso4View(phone);
        }
        String name = StringUtil.gb2iso4View(product.getMainTitle());
        String price = String.valueOf(product.getSalePrice());
        outstr = outstr + " <tr bgcolor=\"#FFFFFF\">\n" +
                "        <td align=\"center\">" + name + "</td>\n" +
                "        <td align=\"center\">" + orderex.getSaleprice() +
                "</td>\n" +
                "        <td align=\"center\">" + orderex.getOrderNum() +
                "</td>\n" +
                "        <td align=\"center\">" + StringUtil.gb2iso4View(order.getName()) +
                "</td><td align=\"center\">" + StringUtil.gb2iso4View(order.getAddress()) +
                "</td><td align=\"center\">" + StringUtil.gb2iso4View(order.getPostcode())+
                "</td><td align=\"center\">" + phone + "</td><td align=\"center\">" + paywaystr +
                "</td>\n" +
                "        <td align=\"center\">" + feestr +
                "</td>\n" +
                "        <td>\n" +
                "            <font color=\"red\">" + status +
                "</font></td>\n" +
                "        <td align=\"center\">" + df.format(order.getPayfee()) +
                "</td>\n" +
                "        <td align=\"center\">" + df2.format(order.getDeliveryfee()) +
                "</td>\n" +
                "    </tr>";
    }
    outstr = outstr + "</table>";


    out.write(outstr);
%>