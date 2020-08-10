<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*"
         contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.webapps.register.*" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    long orderid = ParamUtil.getLongParameter(request, "orderid", 0);
    int the_siteid = authToken.getSiteID();

    Order order = new Order();
    IOrderManager orderMgr = orderPeer.getInstance();
    order = orderMgr.getAOrder(orderid);
    String phone1 = "";
    String phone2 = "";
    if ((order.getPhone() != null) && (!"".equals(order.getPhone()))) {
        String phone[] = order.getPhone().split(",");
        for (int i = 0; i < phone.length; i++) {
            phone1 = StringUtil.gb2iso4View(phone[0]);
            //phone2 = StringUtil.gb2iso4View(phone[1]);
        }
    }
   List list = new ArrayList();
   list = orderMgr.getDetail(orderid);

   Uregister ureg = new Uregister();
   IUregisterManager uregMgr = UregisterPeer.getInstance();
   // System.out.println("sssssss = " + order.getUserid());
   ureg = uregMgr.getUregister(order.getUserid());
   orderMgr.orderPeer(String.valueOf(order.getPayfee()));
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
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
    <br>
    <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0">
                    <tr bgcolor="#F4F4F4" align="left">
                        <td class="moduleTitle"><font color="#48758C" size="4">���ζ���Ӧ�����:</font>
                            <font size="4"><%=orderMgr.ToChinese()%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            ��<%=order.getPayfee()%>&nbsp;
                        </td>
                    </tr>
                    <tr bgcolor="#d4d4d4" align="right">
                        <td>
                            <table width="100%" border="0" cellpadding="2" cellspacing="1">

                                <tr>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center"></td>
                                    <td align="center">&nbsp;</td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">�ͻ���ַ��</td>
                                    <td align="left"
                                        colspan="6"><%=order.getAddress() == null ? "" : StringUtil.gb2iso4View(order.getAddress())%>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">�ջ��ˣ�</td>
                                    <td align="left"
                                        width="23%"><%=order.getName() == null ? "" : StringUtil.gb2iso4View(order.getName())%>
                                    </td>
                                    <td align="right" width="10%">��ϵ�绰��</td>
                                    <td align="left" colspan="2" width="23%"><%=phone1%>
                                    </td>
                                    <td align="right" width="10%">��ϵ�ֻ���</td>
                                    <td align="left" width="24%"><%=phone2%>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">�����ˣ�</td>
                                    <td align="left" width="23%"><%=order.getName() == null ? "" : StringUtil.gb2iso4View(order.getName())%></td>
                                    <td align="right" width="10%">��ϵ�绰��</td>
                                    <td align="left" colspan="2" width="23%"><%=phone1%></td>
                                    <td align="right" width="10%">��ϵ�ֻ���</td>
                                    <td align="left" width="23%"><%=phone2%></td>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">��ע��Ϣ��</td>
                                    <td align="left" colspan="6"></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">�ͻ�ʱ�䣺</td>
                                    <td align="left" colspan="3" width="40%"><%=new Timestamp(System.currentTimeMillis()).toString().substring(0,10)%></td>
                                    <td align="right" width="10%">�µ�ʱ�䣺</td>
                                    <td align="left" colspan="2" width="40%"><%=order.getCreateDate() == null?"":StringUtil.gb2iso4View(order.getCreateDate().toString().substring(0,10))%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">�����ţ�</td>
                                    <td align="left" colspan="3" width="40%"><%=orderid%></td>
                                    <td align="right" width="10%">�����ܼƣ�</td>
                                    <td align="left" colspan="2" width="40%"><%=order.getPayfee()%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">��Ա�ţ�</td>
                                    <td align="left" colspan="3" width="40%"><%=order.getName() == null ? "" : StringUtil.gb2iso4View(order.getName())%></td>
                                    <td align="right" width="10%">�ͻ��ѣ�</td>
                                    <td align="left" colspan="2" width="40%"><%=order.getDeliveryfee()%></td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">��Ա���</td>
                                    <td align="left" colspan="3" width="40%"><%=ureg.getUsertype()%></td>
                                    <td align="right" width="10%">����֧����</td>
                                    <td align="left" colspan="2" width="40%">
                                        <%if(order.getPayflag() == 0){%>0.00<%}else{%><%=order.getPayfee()%><%}%>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">��Ա���֣�</td>
                                    <td align="left" colspan="3" width="40%"><%=ureg.getScores()%></td>
                                    <td align="right" width="10%">Ԥ���֧����</td>
                                    <td align="left" colspan="2" width="40%">0.00</td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">�ʻ���</td>
                                    <td align="left" colspan="3" width="40%"><%=ureg.getScores()%></td>
                                    <td align="right" width="10%">��Ʒ��֧����</td>
                                    <td align="left" colspan="2" width="40%">0.00</td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td align="right" width="10%">���ʽ��</td>
                                    <td align="left" colspan="3" width="40%"><%=order.getPayWay()%></td>
                                    <td align="right" width="10%">ʵ�����</td>
                                    <td align="left" colspan="2" width="40%"><%=order.getPayfee()%></td>
                                </tr>
                                <tr>
                                    <td bgcolor="#d4d4d4" align="right" colspan="7">
                                        <table width="100%" border="0" cellpadding="2" cellspacing="1">
                                            <tr bgcolor="#FFFFFF">
                                                <td align="center" width="8%">���</td>
                                                <td align="center" width="30%">��Ʒ����</td>
                                                <td align="center" width="8%">����</td>
                                                <td align="center" width="8%">��λ</td>
                                                <td align="center" width="8%">�۸�</td>
                                                <td align="center" width="15%">���ֶһ�</td>
                                                <td align="center" width="15%">���С��</td>
                                            </tr><%if(list != null){
                                            for(int i = 0; i < list.size(); i++){
                                                order = (Order)list.get(i);
                                                %>
                                            <tr bgcolor="#FFFFFF">
                                                <td align="center" width="8%"><%=i+1%></td>
                                                <td align="center" width="30%"><%=order.getProductname() == null?"":StringUtil.gb2iso4View(order.getProductname())%></td>
                                                <td align="center" width="8%"><%=order.getOrderNum()%></td>
                                                <td align="center" width="8%"><%=order.getType() == null?"":order.getType()%></td>
                                                <td align="center" width="8%"><%=order.getSaleprice()%></td>
                                                <td align="center" width="15%">&nbsp;</td>
                                                <td align="center" width="15%"><%=order.getOrderNum() * order.getSaleprice()%></td>
                                            </tr>
                                            <%
                                            }
                                        }else{%>
                                            <tr bgcolor="#FFFFFF">
                                                <td align="center" width="8%">&nbsp;</td>
                                                <td align="center" width="30%">&nbsp;</td>
                                                <td align="center" width="8%">&nbsp;</td>
                                                <td align="center" width="8%">&nbsp;</td>
                                                <td align="center" width="8%">&nbsp;</td>
                                                <td align="center" width="15%">&nbsp;</td>
                                                <td align="center" width="15%">&nbsp;</td>
                                            </tr><%}%>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br>
    <input type="button" value=" �� �� " onclick="window.close();">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" value=" �� ӡ " onclick="window.print();">
</center>
</body>
</html>
