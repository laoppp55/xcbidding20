<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.order.*"
                 contentType="text/html;charset=gbk"%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  String userid = authToken.getUserID();
  int siteid = 1;
%>
<%
  int orderid           = ParamUtil.getIntParameter(request, "orderid", 0);
  String userid1        = ParamUtil.getParameter(request, "userid");
  String shippername    = ParamUtil.getParameter(request, "shippername");
  String receivername   = ParamUtil.getParameter(request, "name");
  String jing_ban_ren   = ParamUtil.getParameter(request, "jing_ban_ren");
  int shippingway       = ParamUtil.getIntParameter(request, "receive", 0);
  int nextflag          = ParamUtil.getIntParameter(request, "nextflag", 0);
  int dealflag          = ParamUtil.getIntParameter(request, "dealflag", 0);

  Order order = new Order();
  List list = new ArrayList();
  IOrderManager orderMgr = OrderPeer.getInstance();

  if(nextflag == 1){

    //���tbl_booksend
    Order order2 = new Order();
    order2.setOrderid(orderid);
    order2.setUserid(userid1);
    order2.setShippingway(shippingway);
    orderMgr.insertBookSend(order2);

    //ͼ������޸Ŀ��
    list = orderMgr.order_detail_list(orderid);
    boolean doflag = false;
    boolean flag = true;
    for(int j=0;j<list.size();j++){
      order = (Order)list.get(j);
      long bookid = order.getBookid();
      int num = order.getOrdernum();
      int booknum = orderMgr.getBookNum(bookid);
      orderMgr.updateBookNum(bookid, booknum, num);

      if((booknum-num)>0){
        order.setOrderid(orderid);
        order.setUserid(userid1);
        order.setShippername(shippername);
        order.setReceivername(receivername);
        order.setJing_ban_ren(jing_ban_ren);
        order.setShippingway(shippingway);
        //������
        orderMgr.chuku_info(order);

        //�����detail��
        order = orderMgr.getAOrderDetail(orderid,bookid);
        order.setBookname(new String(order.getBookname().getBytes("iso8859_1"),"GBK"));
        orderMgr.chuku_detail(order);

        //ͼ������޸����������״̬Ϊ�������
        orderMgr.updateOrderStatus(4, orderid);
      }else{
        flag = false;
      }
    }

    int msgflag = 0;
    if(!flag){
      msgflag = 1;
    }
    response.sendRedirect("chuku.jsp?msgflag="+msgflag);
  }
%>
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<meta http-equiv="Pragma" content="no-cache">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "ͼ�����", "" },
              { "���ͼ��", "" }
          };

      String[][] operations = {
        { "���ͼ��", "book.jsp" },{"    ",""},
        { "ͼ���������", "piliang.jsp" },{"    ",""},
       // { "ͼ�����", "chuku.jsp" },{"    ",""},
        { "ͼ���˻�", "tuihuo.jsp" },{"    ",""},
        { "ͼ���ϼ�", "shangjia.jsp" },{"    ",""},
        { "Ԥ��ͼ��", "yuding.jsp" }
          };
%>
  <%@ include file="../inc/titlebar.jsp" %>
  <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
    <tr>
      <td> <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">ͼ�鶩����ϸ��Ϣ</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td> <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td>������</td>
                  <td>ͼ���� </td>
                  <td>ͼ������</td>
                  <td>ͼ��۸�</td>
                  <td>������Ŀ</td>
                  <td>�ۿۼ۸�</td>
                  <td>ͼ������</td>
                  <td>ͼ������</td>
                  <td>ͼ����</td>
                  <td>ͼ��߶�</td>
                  <td>��������</td>
                </tr>
                <% list = orderMgr.order_detail_list(orderid);
                  for(int i=0 ;i < list.size() ;i++){
                    order = (Order)list.get(i);
                    String bookname = order.getBookname();
                    bookname = new String(bookname.getBytes("iso8859_1"),"GBK");
                    String createdate = String.valueOf(order.getCreateDate());
                    createdate = createdate.substring(0,19);
              %>
                <tr  bgcolor="#FFFFFF">
                  <td><%=order.getOrderid()%></a></td>
                  <td><%=order.getBookid()%></td>
                  <td><%=bookname%></td>
                  <td><%=order.getBookprice()%></td>
                  <td><%=order.getOrdernum()%></td>
                  <td><%=order.getDiscountprice()%></td>
                  <td><%=order.getBook_type()%></td>
                  <td><%=order.getBookweight()%></td>
                  <td><%=order.getBook_width()%></td>
                  <td><%=order.getBook_height()%></td>
                  <td><%=createdate%></td>
                </tr>
                <%}%>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table><br>
  <input type="button" value="����" onclick="javascript:history.go(-1);">
  <% if(dealflag == 1){%>
  <form action="chuku1.jsp" method="post" name="chuku">
    <input type="hidden" name="nextflag" class="input" value="1">

    <table border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"><tr><td>
      <table width="100%" border="0" cellpadding="0">
        <tr bgcolor="#F4F4F4" align="center">
          <td class="moduleTitle"><font color="#48758C">ͼ�������Ϣ</font></td>
        </tr>
        <tr bgcolor="#d4d4d4" align="right">
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr bgcolor="#FFFFFF">
                <td width="146">������ţ�</td>
                <td width="222"> <input readonly = "true" class="input" name="orderid" type="text" size="20" value="<%=orderid%>">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>������ID��</td>
                <td> <input readonly = "true" class="input" name="userid" type="text" size="20" value="<%=userid1%>">
                  <font color="#FF0000">&nbsp; </font> </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>������������</td>
                <td> <input class="input" name="shippername" type="text" size="20">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>�ջ���������</td>
                <td> <input readonly = "true" class="input" name="name" type="text" size="20" value="<%=receivername%>">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>�����ˣ�</td>
                <td> <input class="input" name="jing_ban_ren" type="text" size="20">
                </td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>�ͻ���ʽ��</td>
                <td><select name="receive">
                    <option value="1"<%if(shippingway == 1){%> selected<%}%>>��ͨ�ʼ�</option>
                    <option value="2"<%if(shippingway == 2){%> selected<%}%>>EMS�ؿ�ר��</option>
                    <option value="3"<%if(shippingway == 3){%> selected<%}%>>�û���ȡ</option>
                  </select> </td>
              </tr>
            </table>
            <tr><td>&nbsp;</td></tr>
        <tr align="center">
          <td><input type="submit" name="Submit" value="�ύ"> &nbsp;&nbsp;&nbsp;
            <input name="Reset" type="reset"  value="����"></td>
        </tr></td></tr>
      </table></td></tr>
    </table>
  </form>
  <%}%>
</center>
</body>
</html>
