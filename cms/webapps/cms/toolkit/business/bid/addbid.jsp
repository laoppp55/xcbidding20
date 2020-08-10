<%@page import="java.io.*,
                java.util.*,
                java.sql.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.server.*,
                com.booyee.bid.*,
                com.booyee.bookincome.*,
                com.booyee.search.*" contentType="text/html;charset=gbk"
%>
<%
  long bookid = ParamUtil.getLongParameter(request, "bookid", 0);
  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);

  ISearchManager searchMgr = SearchPeer.getInstance();
  Search search = new Search();
  IBidManager bidMgr = BidPeer.getInstance();
  Bid bid = new Bid();
  IBookincomeManager bookincomeMgr = BookincomePeer.getInstance();
  search = searchMgr.getABook(bookid);

  if(search.getStockNum()<=0){
    out.println("<script language=\"javascript\">");
    out.println("alert(\"����ͼ���ֿ����Ϊ�㣡��\");");
    out.println("</script>");
  }

  String bookname = search.getBookName();
  bookname = new String(bookname.getBytes("iso8859_1"),"GBK");

  if(startflag == 1){
    float begin_money         = ParamUtil.getFloatParameter(request, "begin_money", 0);
    float add_money           = ParamUtil.getFloatParameter(request, "add_money", 0);
    int begintime_year        = ParamUtil.getIntParameter(request, "begintime_year", 0);
    int begintime_month       = ParamUtil.getIntParameter(request, "begintime_month", 0);
    int begintime_day         = ParamUtil.getIntParameter(request, "begintime_day", 0);
    int endtime_year          = ParamUtil.getIntParameter(request, "endtime_year", 0);
    int endtime_month         = ParamUtil.getIntParameter(request, "endtime_month", 0);
    int endtime_day           = ParamUtil.getIntParameter(request, "endtime_day", 0);
    int begintime_hour        = ParamUtil.getIntParameter(request, "begintime_hour", 0);
    int begintime_minute      = ParamUtil.getIntParameter(request, "begintime_minute", 0);
    int begintime_second      = ParamUtil.getIntParameter(request, "begintime_second", 0);
    int endtime_hour          = ParamUtil.getIntParameter(request, "endtime_hour", 0);
    int endtime_minute        = ParamUtil.getIntParameter(request, "endtime_minute", 0);
    int endtime_second        = ParamUtil.getIntParameter(request, "endtime_second", 0);
    String bname              = ParamUtil.getParameter(request, "bookname");
    String bookdesc           = ParamUtil.getParameter(request, "bookdesc");

    Timestamp begindate = new Timestamp(begintime_year-1900 , begintime_month-1 , begintime_day,begintime_hour,begintime_minute,begintime_second,0);
    Timestamp enddate = new Timestamp(endtime_year-1900 , endtime_month-1 , endtime_day,endtime_hour,endtime_minute,endtime_second,0);

    bid.setBookID(bookid);
    bid.setBegin_Money(begin_money);
    bid.setAdd_Money(add_money);
    bidMgr.insertBidMoney(bid,begindate,enddate);
    searchMgr.updateShowFlag(bookid,0);
    bookincomeMgr.updateBook(bookid,bname,bookdesc);

    response.sendRedirect("add.jsp");
  }
%>
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<meta http-equiv="Pragma" content="no-cache">
<script language="javascript">
function calbid(bookid){
  addbidForm.action = "calbid.jsp?id="+bookid;
  addbidForm.submit();
}
</script>
<script language="javascript">
function create()
{
  if((addbidForm.begin_money.value == "")||(addbidForm.begin_money.value == null)){
     alert("���������ļۣ�");
     return false;
  }
  if((addbidForm.add_money.value == "")||(addbidForm.add_money.value == null)){
     alert("������ÿ�μӼۣ�");
     return false;
  }
  if((addbidForm.begintime_year.value == "")||(addbidForm.begintime_year.value == null)){
     alert("�������뿪ʼʱ��(��)��");
     return false;
  }
  if((addbidForm.begintime_month.value == "")||(addbidForm.begintime_month.value == null)){
     alert("�������뿪ʼʱ��(��)��");
     return false;
  }
  if((addbidForm.begintime_day.value == "")||(addbidForm.begintime_day.value == null)){
     alert("�������뿪ʼʱ��(��)��");
     return false;
  }
  if((addbidForm.endtime_year.value == "")||(addbidForm.endtime_year.value == null)){
     alert("�����������ʱ��(��)��");
     return false;
  }
  if((addbidForm.endtime_month.value == "")||(addbidForm.endtime_month.value == null)){
     alert("�������뿪ʼʱ��(��)��");
     return false;
  }
  if((addbidForm.endtime_day.value == "")||(addbidForm.endtime_day.value == null)){
     alert("�����������ʱ��(��)��");
     return false;
  }
  return true;
}
</script>
</head>
<body>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "�������", "index.jsp" }
          };

      String[][] operations = {
        { "���ھ���", "index.jsp" },{"    ",""},
        { "��Ӿ���", "add.jsp" },{"    ",""},
        { "�������", "manager.jsp" },{"    ",""},
        { "��ʷ��¼", "history-list.jsp" },{"    ",""}
      };
%>
<%@ include file="../inc/titlebar.jsp" %>
<form action="addbid.jsp" method="post" name="addbidForm">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="bookid" value="<%=bookid%>">
<table width="770" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">��Ӿ�����Ϣ</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                  <!--DWLayoutTable-->
                  <tr bgcolor="#FFFFFF">
                    <td width="20%">ͼ�����ƣ�</td>
                    <td width="60%"><input type="text" size="50" name="bookname" value="<%=bookname%>">
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td width="20%">��Ʒ������</td>
                    <%
                      String desc = "";
                      desc = search.getDesc();
                      if((desc != "")&&(desc != null)){
                        desc = new String(desc.getBytes("iso8859_1"),"GBK");
                      }else{
                        desc = "";
                      }
                    %>
                    <td width="60%"><input type="text" size="50" name="bookdesc" value="<%=desc%>">
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>���ļۣ�</td>
                    <td> <input type="text" name="begin_money" size="10"> Ԫ<font color="#FF0000">&nbsp;
                      </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>ÿ�μӼۣ�</td>
                    <td> <input name="add_money" type="text" id="desc" size="10"> Ԫ
                      <font color="#FF0000">&nbsp; </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>��ʼʱ�䣺</td>
                    <td> <input name="begintime_year" type="text" id="begintime_year" size="4" maxlength="4">
                      ��
                      <input name="begintime_month" type="text" size="3" maxlength="2">
                      ��
                      <input name="begintime_day" type="text" size="3" maxlength="2">
                      ��&nbsp;
                    <input name="begintime_hour" type="text" id="begintime_hour" value="0" size="2" maxlength="2">
                       ʱ
                      <input name="begintime_minute" type="text" id="begintime_minute" value="0" size="2" maxlength="2">
                       ��
                      <input name="begintime_second" type="text" id="begintime_second" value="0" size="2" maxlength="2">
                       ��
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>����ʱ�䣺</td>
                    <td> <input name="endtime_year" type="text" id="endtime_year" size="4" maxlength="4">
                      ��
                      <input name="endtime_month" type="text" size="3" maxlength="2">
                      ��
                      <input name="endtime_day" type="text" size="3" maxlength="2">
                      ��&nbsp;
                    <input name="endtime_hour" type="text" id="endtime_hour" value="0" size="2" maxlength="2">
                       ʱ
                      <input name="endtime_minute" type="text" id="endtime_minute" value="0" size="2" maxlength="2">
                       ��
                      <input name="endtime_second" type="text" id="endtime_second" value="0" size="2" maxlength="2">
                       ��
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          <tr align="center">
            <td><input type="submit" name="Submit" value="ȷ��" onclick="javascript:return create();">
            <input type="button" name="button2" value="ȡ������" onclick="javascript:calbid(<%=bookid%>);">
            <input type="button" name="button" value="����" onclick="javascript:history.go(-1);"></td>
          </tr>
        </table>
      </td>
</tr>
</table>
  </form>
</center>
</body>
</html>
