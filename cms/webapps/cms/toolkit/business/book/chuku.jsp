<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.bookincome.*,
                 com.booyee.order.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  String userid = authToken.getUserID();
  int siteid = 1;
  int msgflag = ParamUtil.getIntParameter(request, "msgflag", 0);

  IOrderManager orderMgr = OrderPeer.getInstance();
  Order order = new Order();
  List list = new ArrayList();
%>


<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<meta http-equiv="Pragma" content="no-cache">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
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

<form action="chuku.jsp" method="post" name="chuku">
<center>
<%
  if(msgflag == 1){
%>
<font size="2" color="red">ͼ���治�㣬�޷�������</font>
<br>
<%}%>
<table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">������Ϣ(ֻ��ʾ�����յ��������̵Ķ���)</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>������</td>
                  <td>�û�ID </td>
                  <td>�ռ�������</td>
                  <td>�ռ��˵�ַ</td>
                  <td>�ռ����ʱ�</td>
                  <td>�ռ��˵绰</td>
                  <td>���ʽ</td>

                  <td>����</td>
                  <td>ȡ����ʽ</td>
                  <td>����״̬</td>
                  <td>�ܷ���</td>
                  <td>�ʼķ���</td>
                  <td>�踶����</td>
                  <td>��������</td>
                </tr>
                  <%
                     list = orderMgr.order_list(3);
                     for(int i=0 ;i < list.size() ;i++){
                      order = (Order)list.get(i);
                      String createdate = String.valueOf(order.getCreateDate());
                      createdate = createdate.substring(0, 19);
                  %>
                <tr  bgcolor="#FFFFFF">
                  <%
                  //�ж��Ƿ�������    status=2������������������
                  int status = order.getStatus();
                  if(status == 3){
                  %>
                  <td><a href="chuku1.jsp?orderid=<%=order.getOrderid()%>&userid=<%=order.getUserid()%>&name=<%=order.getName()%>&receive=<%=order.getReceive()%>&dealflag=1">
                      ����</a>
                  </td>
                  <%}else{%>
                  <td>
                      ����
                  </td>
                  <%}%>
                  <td><%=order.getOrderid()%></td>
                  <td><%=order.getUserid()==null?"":new String(order.getUserid().getBytes("iso8859_1"),"GBK")%></td>
                  <td><%=order.getName()==null?"":new String(order.getName().getBytes("iso8859_1"),"GBK")%></td>
                  <td><%=order.getAddress()==null?"":new String(order.getAddress().getBytes("iso8859_1"),"GBK")%></td>
                  <td><%=order.getPostcode()%></td>
                  <td><%=order.getPhone()==null?"":new String(order.getPhone().getBytes("iso8859_1"),"GBK")%></td>
                  <td><%if(order.getBillingway() == 0){%>�ʾֻ��<%}else{if(order.getBillingway() == 1){%>���л��<%}else{if(order.getBillingway() == 2){%>������ʽ<%}}}%></td>

                  <td><%if(order.getArea() == 0){%>�й���½<%}else{if(order.getArea() == 1){%>�ۡ��ġ�̨����<%}else{if(order.getArea() == 2){%>����<%}}}%></td>
                  <td><%if(order.getReceive() == 0){%>��ͨ�ʼ�<%}
                   else{if(order.getReceive() == 1){%>EMS�ؿ�ר��<%}
                   else{if(order.getReceive() == 2){%>�û���ȡ<%}}}%></td>
                  <td><%if(order.getStatus() == 0){%>�¶���<%}
                   else{if(order.getStatus() == 1){%>���ڴ���<%}
                   else{if(order.getStatus() == 3){%>�յ�����<%}
                   else{if(order.getStatus() == 2){%>�ͻ�����<%}
                   else{if(order.getStatus() == 4){%>�������<%}
                   else{if(order.getStatus() == 5){%>����鵵<%}
                   else{if(order.getStatus() == 6){%><font color="#FF0000">ȱ��</font><%}}}}}}}%></td>
                  <td><%=order.getTotalfee()%></td>
                  <td><%=order.getDeliveryfee()%></td>
                  <td><%=order.getPayfee()%></td>
                  <td><%=createdate%></td>
                </tr>
                <%}%>
               </table>
            </td>
          </tr>
        </table>
      </td>
</tr>
</table>
</center>
</form>
</center>
</body>
</html>