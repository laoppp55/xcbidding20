<%@ page import="java.io.*,
                 java.sql.*,
                 java.util.*,
                 java.text.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.bid.*,
                 com.booyee.order.*,
                 com.booyee.search.*"
                 contentType="text/html;charset=gbk"
%>
<%
  int id = ParamUtil.getIntParameter(request, "end", 0);
  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
  IBidManager bidMgr = BidPeer.getInstance();
  Bid bid = new Bid();
  ISearchManager searchMgr = SearchPeer.getInstance();
  Search search = new Search();
  Search searchuser = new Search();
  IOrderManager orderMgr = OrderPeer.getInstance();
  Order order = new Order();

  String userid = "";
  bid = bidMgr.getABidBook(id);
  userid = new String(bid.getUserID().getBytes("iso8859_1"),"GBK");
  search = searchMgr.getABook(bid.getBookID());
  searchuser = searchMgr.getAUsers(userid);

  double mm = 0;
  float ms = 0;

  if(startflag == 1){
    id = ParamUtil.getIntParameter(request, "end", 0);
    int pay = ParamUtil.getIntParameter(request, "pay", 0);
    int receive = ParamUtil.getIntParameter(request, "receive", 0);
    int area = ParamUtil.getIntParameter(request, "area", 0);

    bid = bidMgr.getABidBook(id);
    userid = new String(bid.getUserID().getBytes("iso8859_1"),"GBK");
    search = searchMgr.getABook(bid.getBookID());
    searchuser = searchMgr.getAUsers(userid);

    //���Ŀ��
    int stocknum = 0;
    stocknum = orderMgr.getStockNum(bid.getBookID());
    stocknum = stocknum - 1;
    orderMgr.updateStockNum(stocknum,bid.getBookID());
    /*
    orderMgr.updateShowFlag(1,bid.getBookID());
    if(stocknum <= 0){
      orderMgr.updateShowFlag(0,bid.getBookID());
    }
    */

    int orderid = 0;
    orderid = orderMgr.getOrderID() + 1;
    Timestamp createdate = new Timestamp(System.currentTimeMillis());

    //���tbl_orders_detail
    order.setOrderid(orderid);
    order.setBookid(bid.getBookID());
    order.setBookname(new String(search.getBookName().getBytes("iso8859_1"),"GBK"));
    order.setBookprice(bid.getHigh_Money());
    order.setOrdernum(1);
    order.setDiscountprice(search.getDist_Price());
    order.setBook_type(search.getNewFlag());
    order.setBookweight(search.getBook_Weight());
    order.setBook_width(search.getBK_Width());
    order.setBook_height(search.getBK_Height());
    order.setCreateDate(createdate);
    orderMgr.createOrderDetail(order);

    //���tbl_orders
    order.setOrderid(orderid);
    order.setUserid(userid);
    order.setName(new String(searchuser.getUserName().getBytes("iso8859_1"),"GBK"));
    order.setSex(searchuser.getSex());
    order.setArea(area);
    order.setAddress(searchuser.getAddress()==null?"":new String(searchuser.getAddress().getBytes("iso8859_1"),"GBK"));
    order.setPostcode(searchuser.getPostCode()==null?"":new String(searchuser.getPostCode().getBytes("iso8859_1"),"GBK"));
    order.setPhone(searchuser.getDailyPhone()==null?"":new String(searchuser.getDailyPhone().getBytes("iso8859_1"),"GBK"));
    order.setBillingway(pay);
    order.setReceive(receive);
    order.setStatus(0);

    DecimalFormat df = new DecimalFormat();
    df.applyPattern("0");
    float bookweight = search.getBook_Weight();
    float totalmoney = bid.getHigh_Money();
    float deliveryfee = 0;
    if(receive == 2){                //��ȡ
      order.setDeliveryfee(0);
    }else if(receive == 0){          //��ͨ�ʼ�
      if(area == 0){
        deliveryfee = (float)(bookweight/1000*1.5+0.15+3.0);
      }else if(area == 1){
        deliveryfee = (float)(bookweight/1000*3+0.3+3.0);
      }else if(area == 2){
        deliveryfee = orderMgr.getG_A_T_Delivfee(bookweight);
      }
      //System.out.println(deliveryfee);
      mm = deliveryfee % 1;
      ms = 0;
      if(mm != 0)
        ms = (float)(deliveryfee/1) + 1;
      else
        ms = deliveryfee;

      order.setDeliveryfee((int)ms);
    }else if(receive == 1){          //EMS
      deliveryfee = bookweight/500*6+20;
      mm = deliveryfee % 1;
      ms = 0;
      if(mm != 0)
        ms = (float)(deliveryfee/1) + 1;
      else
        ms = deliveryfee;

      order.setDeliveryfee((int)ms);
    }

    totalmoney = totalmoney + (int)ms;
    order.setTotalfee(totalmoney);

    //�ӱ�tbl_users�в�ѯ�����û���Ԥ�������
    float prepay = orderMgr.getPrepay(new String(bid.getUserID().getBytes("iso8859_1"),"GBK"));
   if(prepay>0){
    if(totalmoney >= prepay){
      order.setPayfee(totalmoney-prepay);

      //�޸�tbl_users���е�Ԥ����
      prepay = prepay - totalmoney;
      orderMgr.updatePrepayFee(prepay,userid);
    }else{
      order.setPayfee(0);

      //�޸�tbl_users���е�Ԥ����
      prepay = prepay - totalmoney;
      orderMgr.updatePrepayFee(prepay,userid);
    }
   }else{
      order.setPayfee(totalmoney);

      //�޸�tbl_users���е�Ԥ����
      prepay = prepay - totalmoney;
      orderMgr.updatePrepayFee(prepay,userid);
    }

    order.setCreateDate(createdate);
    orderMgr.createOrder(order);

    bidMgr.updateBidFlag(2,id);
    response.sendRedirect("manager.jsp");
  }
%>
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<meta http-equiv="Pragma" content="no-cache">
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center><br><br>
<form name="orderForm" action="history.jsp" method="post">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="end" value="<%=id%>">
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="90%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">���궩��</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">ͼ������</td>
                  <td width="24%" align="center"><%=search.getBookName()==null?"":new String(search.getBookName().getBytes("iso8859_1"),"GBK")%></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">���ļ�</td>
                  <td align="center" class="txt"><%=bid.getBegin_Money()%>Ԫ</td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">��߾���</td>
                  <td align="center" class="txt"><%=bid.getHigh_Money()%>Ԫ</td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">������</td>
                  <td align="center" class="txt"><%=bid.getUserID()==null?"":new String(bid.getUserID().getBytes("iso8859_1"),"GBK")%></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">�ջ�������</td>
                  <td align="center" class="txt"><%=searchuser.getUserName()==null?"":new String(searchuser.getUserName().getBytes("iso8859_1"),"GBK")%></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">����/����</td>
                  <td align="center" class="txt">
                    <input type="radio" name="area" value="0">
                    ������ &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="area" value="1" checked>
                    �й���½ &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="area" value="2">
                    �ۡ��ġ�̨���� &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="area" value="3">
                    ����
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">�ʼĵ�ַ</td>
                  <td align="center" class="txt"><%=searchuser.getAddress() == null?"":new String(searchuser.getAddress().getBytes("iso8859_1"),"GBK")%></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">��ϵ�绰</td>
                  <td align="center" class="txt"><%=searchuser.getDailyPhone()%></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">��������</td>
                  <td align="center" class="txt"><%=searchuser.getPostCode()%></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">�ջ���ʽ</td>
                  <td align="center" class="txt">
                    <input type="radio" name="receive" value="0" checked>
                    <span class="pt9">��ˢ���ʾ���ͨ�ʼģ� </span>
                    <input type="radio" name="receive" value="1">
                    �ʾ�EMS�ؿ�ר���ͻ�����</span>
                    <input type="radio" name="receive" value="2">
                    ��ȡ </span>
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td width="10%" align="center">���ʽ</td>
                  <td align="center" class="txt">
                    <input type="radio" name="pay" value="0" checked>
                    �ʾֻ��
                    <input type="radio" name="pay" value="1">
                    ���п�֧��
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          <tr align="center"><td><input type="submit" value="�ύ"></td></tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</center>
</body>
</html>
