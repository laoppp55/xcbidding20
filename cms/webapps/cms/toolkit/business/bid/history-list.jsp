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
  int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
  int range               = ParamUtil.getIntParameter(request, "range", 100);
  int searchflag          = ParamUtil.getIntParameter(request, "searchflag", 0);
  String userid = authToken.getUserID();
  int siteid = 1;

  IBidManager bidMgr = BidPeer.getInstance();
  Bid bid = new Bid();
  ISearchManager searchMgr = SearchPeer.getInstance();
  Search search = new Search();

  List list = new ArrayList();
  List currentlist = new ArrayList();

  String bookname = "";
  String booknames = "";
  int newflags = -1;
  String jumpstr = "";

  int row = 0;
  int rows = 0;
  int totalpages = 0;
  int currentpage = 0;

  list = bidMgr.listBidBooks(0,0,"2");
  currentlist = bidMgr.listBidBooks(startrow,range,"2");
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
    String sqlstr = "select * from tbl_bid where bidflag=2 ";
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
  function gotoSearch(r){
    SearchForm.action = "history-list.jsp?searchflag=1";
    SearchForm.submit();
  }

  function jumppage(r,str){
    window.location = "history-list.jsp?startrow="+r+"&searchflag=1"+str;
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
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="90%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">�������(��ʷ��¼)</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td width="24%" align="center">ͼ������</td>
                  <td width="15%" align="center">���ļ�</td>
                  <td width="15%" align="center">��߾���</td>
                  <td width="15%" align="center">������</td>
                  <td width="13%" align="center">�������</td>
                  <td width="13%" align="center">���۴���</td>
                </tr>
                <%
                  for(int i=0;i<currentlist.size();i++){
                    bid = (Bid)currentlist.get(i);
                    search = searchMgr.getABook(bid.getBookID());
                    int browsenum = bid.getBrowseNum();
                    int buynum = bid.getBuynum();

                    Timestamp nowtime = new Timestamp(System.currentTimeMillis());
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    java.util.Date now = df.parse(nowtime.toString());
                    java.util.Date date=df.parse(bid.getEndtime().toString());
                    long l=date.getTime()-now.getTime();
                    long day=l/(24*60*60*1000);
                    long hour=(l/(60*60*1000)-day*24);
                    long min=((l/(60*1000))-day*24*60-hour*60);
                    long s=(l/1000-day*24*60*60-hour*60*60-min*60);

                    if((day <= 0)&&(hour <= 0)&&(min <= 0)&&(s <= 0))
                    {
                      bookname = new String(search.getBookName().getBytes("iso8859_1"),"GBK");
                %>
                <tr  bgcolor="#FFFFFF">
                  <td align="center" class="txt"><%=bookname%></td>
                  <td align="center" class="txt"><%=bid.getBegin_Money()%>Ԫ</td>
                  <td align="center" class="txt"><%=bid.getHigh_Money()%>Ԫ</td>
                  <td align="center" class="txt"><%=bid.getUserID()==null?"":new String(bid.getUserID().getBytes("iso8859_1"),"GBK")%></td>
                  <td align="center" class="txt"><%=browsenum%></td>
                  <td align="center" class="txt"><%=buynum%>
                   <a href="detail_bid.jsp?bidid=<%=bid.getID()%>&bookname=<%=bookname%>" target=_blank>
                   �鿴��ϸ
                   </a>
                  </td>
                </tr>
                <%}}%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<table>
<tr valign="bottom">
<td>
����<%=rows%>����ʷ����&nbsp;&nbsp;��<%=totalpages%>ҳ ��<%=currentpage%>ҳ
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
<%
  if((startrow-range)>=0){
%>
[<a href="history-list.jsp?startrow=<%=startrow-range%>&searchflag=1<%=jumpstr%>">��һҳ</a>]
<%}%>
<%
  if((startrow+range)<rows){
%>
[<a href="history-list.jsp?startrow=<%=startrow+range%>&searchflag=1<%=jumpstr%>">��һҳ</a>]
<%}
  if(totalpages>1){
  %>
    &nbsp;&nbsp;��<input type="text" name="jump" value=<%=currentpage%> size="3">ҳ&nbsp;
    <a href="###" onclick="jumppage((document.all('jump').value-1) * <%=range%>,'<%=jumpstr%>');">GO</a>
 <%}%>
</td>
</tr>
</table>

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
