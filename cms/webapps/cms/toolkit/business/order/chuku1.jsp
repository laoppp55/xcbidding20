<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*,
                 java.text.*,
                 com.bizwink.cms.business.Product.*"
         contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.cms.sitesetting.SiteInfoPeer" %>
<%@ page import="com.bizwink.cms.sitesetting.ISiteInfoManager" %>
<%@ page import="com.bizwink.cms.sitesetting.SiteInfo" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    long orderid = ParamUtil.getLongParameter(request, "orderid", 0);
    int the_siteid = authToken.getSiteID();
    int nextflag = ParamUtil.getIntParameter(request, "nextflag", 0);
    int dealflag = ParamUtil.getIntParameter(request, "dealflag", 0);
    boolean chaidanflag = false;
    int order_status = ParamUtil.getIntParameter(request, "order_status", -1);

    Order order = new Order();
    List list = new ArrayList();
    IOrderManager orderMgr = orderPeer.getInstance();
    IProductManager productMgr = productPeer.getInstance();
    ISiteInfoManager siteMgr = SiteInfoPeer.getInstance();
    Product product = new Product();

    order = orderMgr.getAOrder(orderid);
    String createdate = String.valueOf(order.getCreateDate());
    createdate = createdate.substring(0, 19);

    if (nextflag == 1) {
        int oldstatus = -1;
        if (order_status >= 0) {
            oldstatus = orderMgr.getStatus(orderid);
            orderMgr.updateStatus(orderid, order_status, "");
            response.sendRedirect("chuku1.jsp?orderid=" + orderid);
        }
    }

    DecimalFormat df = new DecimalFormat();
    df.applyPattern("0.00");
    DecimalFormat df2 = new DecimalFormat();
    df2.applyPattern("0");
    Fee fee = new Fee();
    fee = orderMgr.getAFeeInfo(order.getSendWay());
    SendWay payway = orderMgr.getASendWayInfo(order.getPayWay());
    Invoice invoice = orderMgr.getInvoiceInfoForOrder(orderid);
%>
<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <meta http-equiv="Pragma" content="no-cache">
    <script language="javascript">
        function closewin() {
            window.close();
        }

        function dofun(obj) {
            /*if (confirm("ȷ�ϲ�ָö�����")) {
                alert("���");
            } else {
                alert("�����");
            }*/

            alert("hello word");
            var winStr = "chaifen_orders.jsp?orderid=<%=orderid%>";
            var returnvalue = "";
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
    String[][] titlebars = {
            {"��ҳ", ""},
            {"��������", ""}
    };

    String[][] operations = {
            {"������", "index.jsp"}, {"", ""},
            {"�ѷ���", "receive.jsp"}, {"", ""},
            {"�����", "end.jsp"}, {"", ""},
            {"�˻�����", "putback.jsp"}, {"", ""},
            {"���ն���", "refuse.jsp"}, {"", ""},
            {"�ͻ�ȡ��", "qorders.jsp"}, {"", ""},
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
<td>
<table width="100%" border="0" cellpadding="0">
<tr bgcolor="#F4F4F4" align="center">
    <td class="moduleTitle"><font color="#48758C">����<font color=red><%=orderid%>
    </font>��ϸ��Ϣ(��������<%=createdate%>)  <a href="peisong.jsp?orderid=<%=orderid%>" target=_blank>��ӡ����</a></font></td>
</tr>
<tr bgcolor="#d4d4d4" align="right">
<td>
<table width="100%" border="0" cellpadding="2" cellspacing="1">
<%
    list = orderMgr.getDetailList(orderid);
    Order orderex = new Order();
    String name = "";
    String price = "";
    String typestr = "";
    String P_sitename = "";
    String P_company = "";
    String phone = "";
    if ((order.getPhone() != null) && (!"".equals(order.getPhone()))) {
        phone = order.getPhone();
        phone = StringUtil.gb2iso4View(phone);
    } else {
        phone = orderMgr.getPhone(orderid);
        phone = StringUtil.gb2iso4View(phone);
    }
%>
<tr>
    <td align="center"><%=StringUtil.gb2iso4View(order.getName())%></td>
    <td align="center" colspan="2"><!--%=StringUtil.gb2iso4View(order.getAddress())%--></td>
    <td align="center"><!--%=StringUtil.gb2iso4View(order.getPostcode())%--></td>
    <td align="center"><%=phone%></td>
    <td align="center"><%if (payway == null) {%>
        ��������<%} else {%><%=payway.getCname() == null ? "--" : StringUtil.gb2iso4View(payway.getCname())%><%}%>
    </td>
    <td align="center"><%if (fee == null) {%>ͬ���ͻ�<%}else{%><%=fee.getCname()==null?"--":StringUtil.gb2iso4View(fee.getCname())%>
        <%}%></td>
    <td>
        <font color="red">
            <%if (order.getNouse() == 0) {%>�ͻ�ȡ��<%
        } else {
            if (order.getStatus() == 1) {
        %>������<%
        } else {
            if (order.getStatus() == 2) {
        %>����<%
        } else {
            if (order.getStatus() == 3) {
        %>�˻�<%
        } else {
            if (order.getStatus() == 4) {
        %>���<%
        } else {
            if (order.getStatus() == 5) {
        %>����<%
        } else {
            if (order.getStatus() == 6) {
        %>�˻�����<%
        } else {
            if (order.getStatus() == 7) {
        %><font color="#FF0000">ȱ��</font><%
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        %></font></td>
    <td>&nbsp;</td>
</tr>
<tr bgcolor="#FFFFFF">
    <td align="center">��Ʒ����</td>
    <td align="center">�ۼ�</td>
    <td align="center">������</td>
    <td align="center">վ������</td>
    <td align="center">������</td>
    <!--td align="center">�ռ�������</td>
   <td align="center">�ռ��˵�ַ</td>
   <td align="center">�ռ����ʱ�</td>
   <td align="center">�ռ��˵绰</td>
   <td align="center">���ʽ</td>
   <td align="center">����</td>
   <td align="center">ȡ����ʽ</td>
   <!--td align="center">����״̬</td-->
    <td align="center">ʹ�û���</td>
    <td align="center">ʹ�ù���ȯ</td>
    <td align="center">�ܷ���</td>
    <td align="center">�ʼķ���</td>
    <td align="center">�ͻ�ʱ��</td>
</tr>
<%
    for (int i = 0; i < list.size(); i++) {
        orderex = (Order) list.get(i);
        product = productMgr.getAProduct(orderex.getProductid());
        SiteInfo si = siteMgr.getSiteInfo(product.getSiteID());
        if (si != null) P_sitename = si.getDomainName();
        if (product.getSuppliername() != null) P_company = product.getSuppliername();
        name = StringUtil.gb2iso4View(orderex.getProductname());
        price = String.valueOf(product.getSalePrice());
        //����ȯ��Ϣ
        Card card = orderMgr.getACardInfo(orderex.getCardid());
        if (product.getSiteID() != the_siteid) chaidanflag = true;
        String linktime = "";
        if(order.getLinktime() == null){
            linktime = "�����ա�˫��������վ����ͻ�";
        }
        else{
            if(linktime.equals("0")){

            }
            else if(linktime.equals("1")){
                  linktime = "ֻ�������ͻ�(˫���ա����ղ�����)";
            }
            else{
                linktime = "ֻ˫���ա������ͻ�(�����ղ�����)";
            }
        }
%>
<tr bgcolor="#FFFFFF">
    <td align="center"><%=name == null ? "--" : name%></td>
    <td align="center"><%=orderex.getSaleprice()%></td>
    <td align="center"><%=orderex.getOrderNum()%></td>
    <td align="center"><%=P_sitename%></td>
    <td align="center"><%=P_company%></td>
    <td align="center"><%=df.format(order.getUserscores())%></td>
    <td align="center"><%=order.getUsecard()%></td>
    <td align="center"><%=df.format(order.getPayfee())%></td>
    <td align="center"><%=df2.format(order.getDeliveryfee())%></td>
    <td align="center"><%=linktime%></td>
</tr>
<%}%>
</table>
</td>
</tr>
    <tr bgcolor="#d4d4d4">
<td align="left">

    </td>
    </tr>
</table>
</td>
</tr>
</table>
<table width="30%" border="0" cellpadding="2" cellspacing="1"  bgcolor="#F4F4F4" align="left">
                                <tr bgcolor="#FFFFFF">
                                    <td width="100%" colspan="2">��Ʊ��Ϣ��</td>
                                </tr>
        <%if(invoice != null){
             int content = invoice.getContent();
            Invoice c = orderMgr.getInvoiceConenteById(content);
            String cname = "";
            if(c == null){
                cname = "��ϸ";
            }
            else{
                cname = c.getContentinfo() == null?"��ϸ":StringUtil.gb2iso4View(c.getContentinfo());
            }
        %>
        <tr bgcolor="#FFFFFF">
                                    <td align="right">��Ʊ���ͣ�</td>
                                    <td align="left"><%if(invoice.getInvoicetype() == 0){out.print("��ͨ��Ʊ");}else{out.print("��ֵ˰��Ʊ");}%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">��Ʊ̧ͷ��</td>
                                    <td align="left"><%if(invoice.getTitle() == 0){out.print("����");}else{out.print("��λ");}%></td>
                                </tr>
                                 <tr bgcolor="#FFFFFF">
                                    <td align="right">��λ���ƣ�</td>
                                    <td align="left"><%=invoice.getCompanyname() == null?"":StringUtil.gb2iso4View(invoice.getCompanyname())%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">��Ʊ���ݣ�</td>
                                    <td align="left"><%=cname%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">��˰��ʶ��ţ�</td>
                                    <td align="left"><%=invoice.getIdentification() == null?"":StringUtil.gb2iso4View(invoice.getIdentification())%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">ע���ַ��</td>
                                    <td align="left"><%=invoice.getRegisteraddress()== null?"":StringUtil.gb2iso4View(invoice.getRegisteraddress() )%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">ע��绰��</td>
                                    <td align="left"><%=invoice.getPhone() == null?"":StringUtil.gb2iso4View(invoice.getPhone() )%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">�������У�</td>
                                    <td align="left"><%=invoice.getBankname() == null?"":StringUtil.gb2iso4View(invoice.getBankname() )%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right">�����ʺţ�</td>
                                    <td  align="left"><%=invoice.getBankaccount() == null?"":StringUtil.gb2iso4View(invoice.getBankaccount() )%></td>
                                </tr>
        <%}%>
                            </table>
<br>
<%--<input type="button" value="�ر�" onclick="window.close();">--%>
<form action="chuku1.jsp" method="post" name="chuku">
    <input type="hidden" name="nextflag" class="input" value="1">
    <table border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0">
                    <tr bgcolor="#F4F4F4" align="center">
                        <td class="moduleTitle"><font color="#48758C">�޸Ķ���״̬</font></td>
                    </tr>
                    <tr bgcolor="#d4d4d4" align="right">
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr bgcolor="#FFFFFF">
                                    <td width="146">������ţ�</td>
                                    <td width="222"><input readonly="true" class="input" name="orderid" type="text"
                                                           size="20" value="<%=orderid%>">
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td>����״̬��</td>
                                    <td>
                                        <select name="order_status">
                                            <option value="-1">��ѡ��</option>
                                            <option value="0">�ͻ�ȡ��</option>
                                            <option value="1">������</option>
                                            <option value="7">����</option>
                                            <option value="2">����</option>
                                            <option value="3">�˻�</option>
                                            <option value="4">���</option>
                                            <option value="5">����</option>
                                            <option value="6">ȱ��</option>
                                        </select>
                                        <font color="#FF0000">&nbsp; </font></td>
                                </tr>
                            </table>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr align="center">
                        <td>
                            <%if (chaidanflag == true) {%>
                            <input type="button" name="tijiao" value="��" onclick="javascript:dofun(this)">&nbsp;&nbsp;
                            <%}%>
                            <input type="submit" name="xiugai" value="�޸�">&nbsp;&nbsp;
                            <input type="button" name="close" value="�ر�" onclick="javascript:closewin();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
</center>
</body>
</html>
