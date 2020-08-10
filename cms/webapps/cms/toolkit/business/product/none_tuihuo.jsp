<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.bookincome.*"
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
  String currentyear = String.valueOf(new Timestamp(System.currentTimeMillis())).substring(0, 4) ;

  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);

  if(startflag == 1){
    int orderid             = ParamUtil.getIntParameter(request, "orderid", 0);
    long bookid             = ParamUtil.getIntParameter(request, "bookid", 0);
    String bookname         = ParamUtil.getParameter(request, "bookname");
    int number              = ParamUtil.getIntParameter(request, "number", 0);
    float money             = ParamUtil.getFloatParameter(request, "money", 0);
    String host             = ParamUtil.getParameter(request, "host");
    String jingbanren       = ParamUtil.getParameter(request, "jingbanren");
    String createdate_year  = ParamUtil.getParameter(request, "createdate_year");
    String createdate_month = ParamUtil.getParameter(request, "createdate_month");
    String createdate_day   = ParamUtil.getParameter(request, "createdate_day");
    String reason           = ParamUtil.getParameter(request, "reason");

    java.sql.Date receivedate = new java.sql.Date(Integer.parseInt(createdate_year)-1900 , Integer.parseInt(createdate_month)-1 , Integer.parseInt(createdate_day));

    IBookincomeManager bookincomeMgr = BookincomePeer.getInstance();
    Bookincome bookincome = new Bookincome();
    bookincome.setOrderid(orderid);
    bookincome.setBookID(bookid);
    bookincome.setBookName(bookname);
    bookincome.setNumber(number);
    bookincome.setIn_Price(money);
    bookincome.setUserid(host);
    bookincome.setJing_ban_ren(jingbanren);
    bookincome.setReason(reason);
    bookincome.setReceiveDate(receivedate);
    bookincomeMgr.insertTuiShu(bookincome);

    //�޸�ͼ����
    int booknum = bookincomeMgr.getBookNum(bookid);
    bookincomeMgr.updateBookNum(bookid,booknum,number);

    out.println("<script language=\"javascript\">");
    out.println("alert(\"������Ϣ��ӳɹ��������˿����д֧������\")");
    out.println("</script>");
  }
%>
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<meta http-equiv="Pragma" content="no-cache">
<script language="javascript">
function check(frm){
  if((tuihuo.orderid.value == "")||(tuihuo.orderid.value == null)){
    alert("�����붩����ţ�");
    return false;
  }

  if((tuihuo.bookid.value == "")||(tuihuo.bookid.value == null)){
    alert("������ͼ���ţ�");
    return false;
  }

  if((tuihuo.bookname.value == "")||(tuihuo.bookname.value == null)){
    alert("������ͼ�����ƣ�");
    return false;
  }

  if((tuihuo.number.value == "")||(tuihuo.number.value == null)){
    alert("�����������");
    return false;
  }

  if((tuihuo.money.value == "")||(tuihuo.money.value == null)){
    alert("�������Ʒ��ֵ��");
    return false;
  }

  if((tuihuo.host.value == "")||(tuihuo.host.value == null)){
    alert("�����������");
    return false;
  }

  if((tuihuo.jingbanren.value == "")||(tuihuo.jingbanren.value == null)){
    alert("�����뾭���ˣ�");
    return false;
  }

  if((tuihuo.createdate_year.value == "")||(tuihuo.createdate_year.value == null)){
    alert("����������������ʱ�䣡");
    return false;
  }

  if((tuihuo.createdate_month.value == "")||(tuihuo.createdate_month.value == null)){
    alert("����������������ʱ�䣡");
    return false;
  }

  if((tuihuo.createdate_day.value == "")||(tuihuo.createdate_day.value == null)){
    alert("����������������ʱ�䣡");
    return false;
  }

  return true;
}
</script>
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
        { "ͼ����/�¼�", "shangjia.jsp" },{"    ",""},
        { "Ԥ��ͼ��", "yuding.jsp" }
          };
%>
<%@ include file="../inc/titlebar.jsp" %>
<form action="tuihuo.jsp" method="post" name="tuihuo">
<input type="hidden" name="startflag" value="1">
<center>
<table width="770" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">ͼ���˻�</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                  <tr bgcolor="#FFFFFF">
                    <td>������ţ�</td>
                    <td> <input type="text" name="orderid" size="20"> <font color="#FF0000"> *
                      </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>ͼ���ţ�</td>
                    <td> <input name="bookid" type="text" size="20">
                      <font color="#FF0000">* </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>ͼ�����ƣ�</td>
                    <td> <input name="bookname" type="text" size="20">
                      <font color="#FF0000"> * </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>������</td>
                    <td> <input name="number" type="text" size="20">
                      <font color="#FF0000"> * </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>��Ʒ��ֵ��</td>
                    <td> <input name="money" type="text" size="20">
                      <font color="#FF0000"> * </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>������</td>
                    <td> <input name="host" type="text" size="20">
                      <font color="#FF0000"> * </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�����ˣ�</td>
                    <td> <input name="jingbanren" type="text" size="20">
                      <font color="#FF0000"> * </font> </td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�˻�ʱ�䣺</td>
                    <td> <input name="createdate_year" type="text" size="4" maxlength="4" value="<%=currentyear%>">
                      ��
                      <select name="createdate_month">
                        <option></option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                      </select>
                      ��
                      <select name="createdate_day">
                        <option></option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                      </select>
                      ��&nbsp; <font color="#FF0000"> * </font></td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�˻�ԭ��</td>
                    <td>
                    <textarea rows="5" cols="80" name="reason"></textarea><font color="#FF0000">&nbsp;</font>
                    </td>
                  </tr>
                </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          <tr align="center">
            <td><input type="submit" name="Submit" value="�ύ" onclick="javascript:return check(this.form);">
                &nbsp;&nbsp;&nbsp;
                <input name="Reset" type="reset" id="Reset" value="����"></td>
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