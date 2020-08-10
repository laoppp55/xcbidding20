<%@ page import="java.io.*,
                 java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.bookincome.*"
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
%>

<%
  boolean success = false;
  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
  long bookid = ParamUtil.getLongParameter(request, "bookid", 0);
System.out.println("************"+bookid);
  String currentyear = String.valueOf(new Timestamp(System.currentTimeMillis())).substring(0, 4) ;
  int nextflag = 0;
  int sid = 0;
  int batchid = 0;
  int number = 0;
  float inprice = 0;

  if(startflag == 1)
  {
    batchid                       = ParamUtil.getIntParameter(request, "batchid", 0);
    int book_type_id              = ParamUtil.getIntParameter(request, "book_type_id", 0);
    String describe               = ParamUtil.getParameter(request, "describe");
    number                        = ParamUtil.getIntParameter(request, "number" ,0);
    inprice                       = ParamUtil.getFloatParameter(request, "inprice" ,0);
    int intype                    = ParamUtil.getIntParameter(request, "intype" ,0);
    float booksvalue              = ParamUtil.getFloatParameter(request, "booksvalue" ,0);
    String bookshost              = ParamUtil.getParameter(request, "bookshost");
    String jing_ban_ren           = ParamUtil.getParameter(request, "jing_ban_ren");
    float discount                = ParamUtil.getFloatParameter(request, "discount" ,0);
    int buydate_year              = ParamUtil.getIntParameter(request, "buydate_year" ,0);
    int buydate_month             = ParamUtil.getIntParameter(request, "buydate_month" ,0);
    int buydate_day               = ParamUtil.getIntParameter(request, "buydate_day", 0);
    nextflag                      = ParamUtil.getIntParameter(request, "nextflag",0);


    java.sql.Date buydate = new java.sql.Date(buydate_year-1900 , buydate_month-1 , buydate_day);

    IBookincomeManager bookincomeMgr = BookincomePeer.getInstance();
    Bookincome bookincome = new Bookincome();

    bookincome.setBatchid(batchid);
    bookincome.setBook_Type_ID(book_type_id);
    bookincome.setDescribe(describe);
    bookincome.setNumber(number);
    bookincome.setInprice(inprice);
    bookincome.setIntype(intype);
    bookincome.setBooksvalue(booksvalue);
    bookincome.setBookshost(bookshost);
    bookincome.setJing_ban_ren(jing_ban_ren);
    bookincome.setDiscount(discount);
    bookincome.setBuyDate(buydate);

    sid = bookincomeMgr.getSaveID(batchid,intype);

    if (sid == -1)
    {
      bookincomeMgr.shuku(bookincome);
      sid = bookincomeMgr.getSaveID(batchid,intype);
      System.out.println(batchid);
      System.out.println(bookid);
      bookincomeMgr.updateBookSID(sid,bookid);
      success = true;
    }else{
      success=false;
    }
  }

  if(startflag == 1){
    if (success){
      response.sendRedirect("bookinfo.jsp");
    }
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
  if((ruku.batchid.value == "")||(ruku.batchid.value == null)){
    alert("������ͼ�����ţ�");
    return false;
  }

  if((ruku.number.value == "")||(ruku.number.value == null)){
    alert("������ͼ�������");
    return false;
  }

  if((ruku.inprice.value == "")||(ruku.inprice.value == null)){
    alert("������ͼ��۸�");
    return false;
  }

  if((ruku.inprice.value == "")||(ruku.inprice.value == null)){
    alert("������ͼ��۸�");
    return false;
  }

  if((ruku.intype.value == "")||(ruku.intype.value == null)){
    alert("��ѡ��ִ�еĲ�����");
    return false;
  }

  if((ruku.jing_ban_ren.value == "")||(ruku.jing_ban_ren.value == null)){
    alert("�����뾭���ˣ�");
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
        { "ͼ���ϼ�", "shangjia.jsp" },{"    ",""},
        { "Ԥ��ͼ��", "yuding.jsp" }
          };
%>
<%@ include file="../inc/titlebar.jsp" %>


<form action="ruku.jsp" method="post" name="ruku">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="bookid" value="<%=bookid%>">
<center>
<table width="770" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">ͼ�������Ϣ</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2">
                <tr>
                  <td>ͼ�������Ϣ<font color="#FF0000">*</font>����</td>
                </tr>
              </table>
                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                  <!--DWLayoutTable-->
                  <tr bgcolor="#FFFFFF">
                    <td width="20%">ͼ�����ţ�</td>
                    <td width="30%"> <input name="batchid" type="text" id="bantchid" size="20">
                      <font color="#FF0000"> * </font></td>
                    <td>������ϸ��д<font color="#FF0000">ͼ�����ţ�ͼ������</font>����ϸ��Ϣ��</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>ͼ�����</td>
                    <td> <input type="text" name="book_type_id" size="20"> <font color="#FF0000">&nbsp;
                      </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>������Ϣ��</td>
                    <td> <input name="describe" type="text" id="desc" size="20">
                      <font color="#FF0000">&nbsp; </font> </td>
                    <td>&nbsp;</td>
                  </tr>

                  <tr bgcolor="#FFFFFF">
                    <td>������</td>
                    <td> <input name="number" type="text" id="number" size="20">
                      <font color="#FF0000"> * </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�۸�</td>
                    <td> <input name="inprice" type="text" id="inprice" size="20">
                      <font color="#FF0000"> * </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>ִ�в�����</td>
                    <td> <select name="intype" size="1" id="intype">
                        <option>��ѡ��</option>
                        <option value="0">������</option>
                        <option value="1">������</option>
                        <option value="2">���ż�</option>
                        <option value="3">��������</option>
                        <option value="4">���۾���</option>
                        <option value="5">���۹ż�</option>
                      </select> <font color="#FF0000"> * </font></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>��ֵ��</td>
                    <td> <input name="booksvalue" type="text" id="booksvalue" size="20"></td>
                    <td></td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>������</td>
                    <td> <input name="bookshost" type="text" id="bookshost" size="20">
                      &nbsp; </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�����ˣ�</td>
                    <td> <input name="jing_ban_ren" type="text" id="jing_ban_ren" size="20">
                      <font color="#FF0000"> * </font></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�ۿۣ�</td>
                    <td> <input name="discount" type="text" id="discount" size="20">
                      &nbsp; </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>����ʱ�䣺</td>
                    <td> <input name="buydate_year" type="text" id="buydate_year" size="4" maxlength="4" value="<%=currentyear%>">
                      ��
                      <select name="buydate_month" id="buydate_month">
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
                      <select name="buytime_day" id="buytime_day">
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
                      ��&nbsp; </td>
                    <td>&nbsp;</td>
                  </tr>
                  <!--tr bgcolor="#FFFFFF">
                    <td>&nbsp;</td>
                    <td>
                      <input name="nextflag" type="checkbox" value="1" checked>
                      ����������ϸ��Ϣ</td>
                    <td>&nbsp;</td>
                  </tr-->
                </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          <tr align="center">
            <td><input type="submit" name="Submit" value="���" onclick="javascript:return check(this.form);">
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