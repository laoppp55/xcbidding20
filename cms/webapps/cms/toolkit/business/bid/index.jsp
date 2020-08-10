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
                 com.booyee.search.*"
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

  int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
  int range               = ParamUtil.getIntParameter(request, "range", 100);
  int searchflag          = ParamUtil.getIntParameter(request, "searchflag", 0);

  IBidManager bidMgr = BidPeer.getInstance();
  Bid bid = new Bid();
  ISearchManager searchMgr = SearchPeer.getInstance();
  Search search = new Search();

  List list = new ArrayList();
  List currentlist = new ArrayList();

  String booknames = "";
  int newflags = -1;
  String jumpstr = "";

  int currentrows = 0;
  int totalrows = 0;
  int row = 0;
  int rows = 0;
  int totalpages = 0;
  int currentpage = 0;

    list = bidMgr.listBidBooks(0,0,"0");
    currentlist = bidMgr.listBidBooks(startrow,range,"0");

    row = currentlist.size();
    rows = list.size();

    if(rows < range){
      totalpages = 1;
      currentpage = 1;
    }else{
      if(rows%range == 0)
        totalpages = rows/range;
      else
        totalpages = rows/range + 1;

      currentpage = startrow/range + 1;
    }


  if(searchflag==1){
    booknames     = ParamUtil.getParameter(request,"bookname");
    newflags      = ParamUtil.getIntParameter(request,"newflag",-1);
    String sqlstr = "select * from tbl_bid where bidflag=0 ";
    if((booknames!="")&&(booknames!=null)){
       sqlstr = sqlstr + " and bookid in "+
                "(select bookid from tbl_bookinfo where bookname like '%"+booknames+"%')";
       jumpstr = jumpstr + "&bookname="+booknames;
    }
    if(newflags!=-1){
       sqlstr = sqlstr + " and bookid in " +
                "(select bookid from tbl_bookinfo where newflag = "+newflags+")";
       jumpstr = jumpstr + "&newflag=" + newflags;
    }

    sqlstr = sqlstr.replaceAll("@","%");
    list = bidMgr.listBidBooks(0,0,sqlstr);
    currentlist = bidMgr.listBidBooks(startrow,range,sqlstr);

    row = currentlist.size();
    rows = list.size();

    if(rows < range){
      totalpages = 1;
      currentpage = 1;
    }else{
      if(rows%range == 0)
        totalpages = rows/range;
      else
        totalpages = rows/range + 1;

      currentpage = startrow/range + 1;
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
function CheckAll(form){
   for (var i=0;i<form.elements.length;i++){
      var e = form.elements[i];
      if (e.name != 'chkAll')
        e.checked = form.chkAll.checked;
    }
}

function check(form){
  var flag = false;
  for (var i=0;i<form.elements.length;i++){
    if(form.elements[i].checked){
      flag = true;
    }
  }
  if(!flag){
    alert("����ѡ��Ҫ�����ľ��굥��");
    return false;
  }else{
    var val;
    val = confirm("��ȷ��Ҫ��ǰ������Щ������");
    if(val){
      bidform.action="end.jsp";
      bidform.submit();
      return true;
    }
    else
      return false;
  }
}

  function gotoSearch(r){
    SearchForm.action = "index.jsp?searchflag=1";
    SearchForm.submit();
  }

  function jumppage(r,str){
    window.location = "index.jsp?startrow="+r+"&searchflag=1"+str;
  }

</script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
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
<form name="bidform" method="post" action="index.jsp">
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="90%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">�������(������ͼ��)</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td align="center">�޸Ľ�����־</td>
                  <td align="center">ͼ������</td>
                  <td align="center">ͼ������</td>
                  <td align="center">���ļ�</td>
                  <td align="center">��߾���</td>
                  <td align="center">������</td>
                  <td align="center">�������</td>
                  <td align="center">���۴���</td>
                  <td align="center">ʣ��ʱ��</td>
                  <td></td>
                </tr>
                <%
                  for(int i=0;i<currentlist.size();i++){
                    bid = (Bid)currentlist.get(i);
                    search = searchMgr.getABook(bid.getBookID());
                    int browsenum = bid.getBrowseNum();
                    int buynum = bid.getBuynum();

                    int newflag = search.getNewFlag();
                    String booktype = "";
                    if(newflag == 0){
                      booktype = "����";
                    }else if(newflag == 1){
                      booktype = "����";
                    }else if(newflag == 2){
                      booktype = "�ż�";
                    }else if(newflag == 3){
                      booktype = "�����";
                    }
                    Timestamp nowtime = new Timestamp(System.currentTimeMillis());
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    java.util.Date now = df.parse(nowtime.toString());
                    java.util.Date date=df.parse(bid.getEndtime().toString());
                    long l=date.getTime()-now.getTime();
                    long day=l/(24*60*60*1000);
                    long hour=(l/(60*60*1000)-day*24);
                    long min=((l/(60*1000))-day*24*60-hour*60);
                    long s=(l/1000-day*24*60*60-hour*60*60-min*60);

                    boolean saleflag = true;;
                    if(day < 0){
                      day = 0;
                      saleflag = false;
                    }
                    if(hour < 0){
                      hour = 0;
                      saleflag = false;
                    }
                    if(min < 0){
                      min = 0;
                      saleflag = false;
                    }
                    if(s < 0){
                      s = 0;
                      saleflag = false;
                    }

                    //�ж��ӳ�ʱ��
                    boolean delayflag = false;
                    long ll = date.getTime() - now.getTime() + 300000 ;
                    long minl = ll/60000;
                    long sl = (ll%60000)/1000;

                    if(minl < 0){
                      minl = 0;
                    }
                    if(sl < 0){
                      sl = 0;
                    }

                    if((minl==0)&&(sl==0)){
                      saleflag = false;
                      delayflag = false;
                    }else{
                      saleflag = true;
                      delayflag = true;
                    }

                    String lefttime = "";
                    if((day ==0)&&(hour == 0)&&(min == 0)&&(s == 0)){
                      if((minl==0)&&(sl==0)){
                        lefttime = "�������";
                      }else{
                        lefttime = minl + "��" + sl + "��(��ʱ)";
                      }
                    }else{
                      lefttime = day + "��" + hour + "Сʱ" + min + "��" + s + "��";
                    }

                    String begintime = "";
                    begintime = String.valueOf(bid.getBegintime());
                    begintime = begintime.substring(0,16);
                    /*Timestamp thistime = new Timestamp(System.currentTimeMillis());
                    if(thistime.before(bid.getBegintime()))
                      lefttime = "������ʼʱ�䣺"+ begintime;*/
                    String bookname = "";
                    bookname = new String(search.getBookName().getBytes("iso8859_1"),"GBK");
                %>
                <tr  bgcolor="#FFFFFF">
                  <td align="center" class="txt"><input type="checkbox" name="end" value="<%=bid.getID()%>"></td>
                  <td align="center" class="txt">
                    <%=bookname%>
                  </td>
                  <td align="center" class="txt"><%=booktype%></td>
                  <td align="center" class="txt"><%=bid.getBegin_Money()%>Ԫ</td>
                  <td align="center" class="txt"><%=bid.getHigh_Money()%>Ԫ</td>
                  <td align="center" class="txt">
                  <a href="userbid.jsp?userid=<%=bid.getUserID()==null?"":new String(bid.getUserID().getBytes("iso8859_1"),"GBK")%>" target=_blank>
                   <%=bid.getUserID()==null?"":new String(bid.getUserID().getBytes("iso8859_1"),"GBK")%>
                  </a>
                  </td>
                  <td align="center" class="txt"><%=browsenum%></td>
                  <td align="center" class="txt"><%=buynum%>
                   <a href="detail_bid.jsp?bidid=<%=bid.getID()%>&bookname=<%=bookname%>" target=_blank>
                   �鿴��ϸ
                   </a>
                  </td>
                  <td align="center" class="txt"><%=lefttime%></td>
                  <td align="center" class="txt">
                   <a href="modify.jsp?id=<%=bid.getID()%>" target=_blank>�޸�</a>
                  </td>
                </tr>
                <%}%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="chkAll" value="on"  onclick="javascript:CheckAll(this.form);">ȫ��ѡ��</td></tr>
  </table>

<table>
<tr valign="bottom">
<td>
����<%=rows%>���&nbsp;&nbsp;��<%=totalpages%>ҳ ��<%=currentpage%>ҳ
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
<%
  if((startrow-range)>=0){
%>
[<a href="index.jsp?startrow=<%=startrow-range%>&searchflag=1<%=jumpstr%>">��һҳ</a>]
<%}%>
<%
  if((startrow+range)<rows){
%>
[<a href="index.jsp?startrow=<%=startrow+range%>&searchflag=1<%=jumpstr%>">��һҳ</a>]
<%}
  if(totalpages>1){
  %>
    &nbsp;&nbsp;��<input type="text" name="jump" value=<%=currentpage%> size="3">ҳ&nbsp;
    <a href="###" onclick="jumppage((document.all('jump').value-1) * <%=range%>,'<%=jumpstr%>');">GO</a>
 <%}%>
</td>
</tr>
</table>
  <input type="submit" value="��������" onclick="javascript:return check(this.form);">
</form>


<table width="770" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<form method="post" action="book.jsp" name="SearchForm">
<input type="hidden" name="searchflag" value="1">
<tr>
<td align="center" valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="8">
          <tr bgcolor="#F1F2EC">
            <td class="txt"><strong><font color="6F4A06">ͼ��������</font></strong></td>
          </tr>
        </table>
        <br>
        <table width="95%" border="0" cellspacing="0" cellpadding="0">
          <tr bgcolor="#d4d4d4">
            <td valign="top">
              <table width="100%" border="0" cellpadding="4" cellspacing="1">
                <tr bgcolor="#FFFFFF">
                  <td  valign="top" class="txt" width="50%">������&nbsp;
                    <input type="text" name="bookname" class="input">
                  </td>
                  <td class="txt">ͼ�����ͣ�&nbsp;
                    <select name="newflag">
                      <option>��ѡ��...</option>
                      <option value="0">����</option>
                      <option value="1">����</option>
                      <option value="3">�����</option>
                      <option value="2">�ż�</option>
                    </select>
                  </td>
                </tr>
              </table>
            </td>
</tr>
</table>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td><img src="images/space.gif" width="1" height="1"></td>
</tr>
</table>
        <p><input type=button value="����" onclick="javascript:gotoSearch();"><br>
          <br>
        </p>
</td>
</tr>
</form>
</table>
</center>
</body>
</html>
