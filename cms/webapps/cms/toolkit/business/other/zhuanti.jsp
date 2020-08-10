<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.other.*,
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

  String jumpstr = "";

  ISearchManager searchMgr = SearchPeer.getInstance();
  Search search = new Search();
  List list = new ArrayList();
  List currentlist = new ArrayList();
  int currentrows = 0;
  int totalrows = 0;
  int row = 0;
  int rows = 0;
  int totalpages = 0;
  int currentpage = 0;

  if(searchflag == 0){
    list = searchMgr.getAllBook();
    currentlist = searchMgr.getCurrentAllBook(startrow,range);

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

  String booknames         = "";
  String authors           = "";
  String publishers        = "";
  int pinxiangs            = 0;
  String types             = "";
  String publishtime1s     = "";
  String publishtime2s     = "";
  String upshelf1s         = "";
  String upshelf2s         = "";
  String findtypes         = "";
  String findwhats         = "";
  int newflags = 0;
  float in_price1s = 0;
  float in_price2s = 0;
  float saleprice1s = 0;
  float saleprice2s = 0;
  String c_booknames = "";
  int recommends = 0;
  int stocknum1s = 0;
  int stocknum2s = 0;
  String gonghuoshangs = "";
  int printing_number1s = 0;
  int printing_number2s = 0;

  if(searchflag == 1){
    booknames         = ParamUtil.getParameter(request, "bookname");
    authors           = ParamUtil.getParameter(request, "author");
    publishers        = ParamUtil.getParameter(request, "publisher");
    pinxiangs         = ParamUtil.getIntParameter(request, "pinxiang", 0);
    types            = ParamUtil.getParameter(request, "type");
    publishtime1s     = ParamUtil.getParameter(request, "publishtime1");
    publishtime2s     = ParamUtil.getParameter(request, "publishtime2");
    upshelf1s         = ParamUtil.getParameter(request, "upshelf1");
    upshelf2s         = ParamUtil.getParameter(request, "upshelf2");
    findtypes         = ParamUtil.getParameter(request, "findtype");
    findwhats         = ParamUtil.getParameter(request, "findwhat");
    newflags         = ParamUtil.getIntParameter(request, "newflag",-1);
    in_price1s       = ParamUtil.getFloatParameter(request,"in_price1",-1);
    in_price2s       = ParamUtil.getFloatParameter(request,"in_price2",-1);
    saleprice1s     = ParamUtil.getFloatParameter(request,"saleprice1",-1);
    saleprice2s     = ParamUtil.getFloatParameter(request,"saleprice2",-1);
    c_booknames      = ParamUtil.getParameter(request, "c_bookname");
    recommends       = ParamUtil.getIntParameter(request, "recommend",-1);
    stocknum1s       = ParamUtil.getIntParameter(request, "stocknum1",-1);
    stocknum2s       = ParamUtil.getIntParameter(request, "stocknum2",-1);
    gonghuoshangs    = ParamUtil.getParameter(request, "gonghuoshang");
    printing_number1s = ParamUtil.getIntParameter(request, "printing_number1",-1);
    printing_number2s = ParamUtil.getIntParameter(request, "printing_number2",-1);
  }

  if(searchflag == 2){
    booknames         = ParamUtil.getParameter(request, "booknames");
    authors           = ParamUtil.getParameter(request, "authors");
    publishers        = ParamUtil.getParameter(request, "publishers");
    pinxiangs         = ParamUtil.getIntParameter(request, "pinxiangs", 0);
    types             = ParamUtil.getParameter(request, "types");
    publishtime1s     = ParamUtil.getParameter(request, "publishtime1s");
    publishtime2s     = ParamUtil.getParameter(request, "publishtime2s");
    upshelf1s         = ParamUtil.getParameter(request, "upshelf1s");
    upshelf2s         = ParamUtil.getParameter(request, "upshelf2s");
    findtypes         = ParamUtil.getParameter(request, "findtypes");
    findwhats         = ParamUtil.getParameter(request, "findwhats");
    newflags         = ParamUtil.getIntParameter(request, "newflags",-1);
    in_price1s       = ParamUtil.getFloatParameter(request,"in_price1s",-1);
    in_price2s       = ParamUtil.getFloatParameter(request,"in_price2s",-1);
    saleprice1s     = ParamUtil.getFloatParameter(request,"saleprice1s",-1);
    saleprice2s     = ParamUtil.getFloatParameter(request,"saleprice2s",-1);
    c_booknames      = ParamUtil.getParameter(request, "c_booknames");
    recommends       = ParamUtil.getIntParameter(request, "recommends",-1);
    stocknum1s       = ParamUtil.getIntParameter(request, "stocknum1s",-1);
    stocknum2s       = ParamUtil.getIntParameter(request, "stocknum2s",-1);
    gonghuoshangs    = ParamUtil.getParameter(request, "gonghuoshangs");
    printing_number1s = ParamUtil.getIntParameter(request, "printing_number1s",-1);
    printing_number2s = ParamUtil.getIntParameter(request, "printing_number2s",-1);
  }


  if(searchflag != 0){
    if((findtypes != "")&&(findtypes != null)){
      if(findtypes.equals("bookname"))
      {
        booknames = findwhats;
      }else if(findtypes.equals("author")){
        authors = findwhats;
      }else if(findtypes.equals("publisher")){
        publishers = findwhats;
      }
    }

    String sqlstr = "";
    int book_type_id = 0;
    if(searchflag != 0){
      sqlstr = "select * from tbl_bookinfo where showflag=1 and 1 = 1";
      if((booknames != "")&&(booknames != null)){
       if(!booknames.equals("null")){
          sqlstr = sqlstr + " and bookname like '@" + booknames + "@'";
       }
      }

      if((authors != "")&&(authors != null)){
       if(!authors.equals("null")){
          sqlstr = sqlstr + " and author like '@" + authors + "@'";
       }
      }

      if((publishers != "")&&(publishers != null)){
       if(!publishers.equals("null")){
          sqlstr = sqlstr + " and publisher like '@" + publishers + "@'";
       }
      }

      if((pinxiangs != 0)){
          sqlstr = sqlstr + " and pinxiang like '@" + pinxiangs + "@'";
      }

      if((types != "")&&(types != null)){
       if(!types.equals("null")){
          sqlstr = sqlstr + " and book_type_id like '@" + types + "@'";
       }
      }

      if((publishtime1s != "")&&(publishtime1s != null)){
       if(!publishtime1s.equals("null"))
        sqlstr = sqlstr + " and publishtime >= '" + publishtime1s + "'";
      }

      if((publishtime2s != "")&&(publishtime2s != null)){
       if(!publishtime2s.equals("null"))
        sqlstr = sqlstr + " and publishtime <= '" + publishtime2s + "'";
      }

      if((upshelf1s != "")&&(upshelf1s != null)){
       if(!upshelf1s.equals("null"))
        sqlstr = sqlstr + " and createdate >= '" + upshelf1s + "'";
      }

      if((upshelf2s != "")&&(upshelf2s != null)){
       if(!upshelf2s.equals("null"))
        sqlstr = sqlstr + " and createdate <= '" + upshelf2s + "'";
      }

      if((c_booknames != "")&&(c_booknames != null)){
       if(!c_booknames.equals("null"))
        sqlstr = sqlstr + " and c_bookname='"+c_booknames+"'";
      }

      if(newflags>=0){
        sqlstr = sqlstr + " and newflag='"+newflags+"'";
      }

      if(in_price1s>=0){
        sqlstr = sqlstr + " and in_price>='"+in_price1s+"'";
      }

      if(in_price2s>=0){
        sqlstr = sqlstr + " and in_price<='"+in_price2s+"'";
      }

      if(saleprice1s>=0){
        sqlstr = sqlstr + " and saleprice>='"+saleprice1s+"'";
      }

      if(saleprice2s>=0){
        sqlstr = sqlstr + " and saleprice<='"+saleprice2s+"'";
      }

      if(recommends>=0){
        sqlstr = sqlstr + " and recommend='"+recommends+"'";
      }

      if(stocknum1s>=0){
        sqlstr = sqlstr + " and stocknum>='"+stocknum1s+"'";
      }

      if(stocknum2s>=0){
        sqlstr = sqlstr + " and stocknum<='"+stocknum2s+"'";
      }

      if((gonghuoshangs != "")&&(gonghuoshangs != null)){
       if(!gonghuoshangs.equals("null"))
        sqlstr = sqlstr + " and gonghuoshang='"+gonghuoshangs+"'";
      }

      if(printing_number1s>=0){
        sqlstr = sqlstr + " and printing_number>='"+printing_number1s+"'";
      }

      if(printing_number2s>=0){
        sqlstr = sqlstr + " and printing_number<='"+printing_number2s+"'";
      }
      sqlstr = sqlstr + " order by createdate desc";
    }

    sqlstr = sqlstr.replaceAll("@","%");
    searchMgr = SearchPeer.getInstance();
    list = searchMgr.getSearch(sqlstr);
    currentlist = searchMgr.getCurrentSearch(sqlstr,startrow, range);

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
<script language="JavaScript" src="/include/setday.js" ></script>
<meta http-equiv="Pragma" content="no-cache">
<script language="javascript">
function CheckAll(form){
   for (var i=0;i<form.elements.length;i++){
      var e = form.elements[i];
      if (e.name != 'chkAll')
        e.checked = form.chkAll.checked;
    }
}

function gotodo(val){
  zhuantiForm.action = "dozhuanti.jsp?flag="+val;
  zhuantiForm.submit();
}

function gotoSearch(r,p){
  if(p.length>0){
   if(p.length<4){
     alert("����ȷ��д��ݣ���ʽΪ:2004");
     return false;
   }
   if(p<1770){
     alert("����ȷ��д���ڣ������1770");
      return false;
   }
   if(!isCharsInBag (p, "0123456789")){
     alert("����ȷ��д���ڣ�");
      return false;
   }
  }
  if(r.length>0){
    if(r.length<4){
      alert("����ȷ��д��ݣ���ʽΪ:2004");
      return false;
    }
    if(r<1770){
      alert("����ȷ��д���ڣ������1770");
       return false;
    }
    if(!isCharsInBag (r, "0123456789")){
      alert("����ȷ��д���ڣ�");
       return false;
   }
 }
  SearchForm.action = "zhuanti.jsp?searchflag=1";
  SearchForm.submit();

    return true;
}


function isCharsInBag (s, bag)
{
   var i;
  for (i = 0; i < s.length; i++)
  {
   var c = s.charAt(i);
   if (bag.indexOf(c) == -1) return false;
  }
  return true;
}

function jumppage(r,str){
  zhuantiForm.action = "zhuanti.jsp?startrow="+r+str;
  zhuantiForm.submit();
}
function golistnew(r){
  zhuantiForm.action = "zhuanti.jsp?startrow="+r;
  zhuantiForm.submit();
}
</script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "ͼ��ר���ػݹ���", "index.jsp" },
              { "ר�����", "" }
          };

      String[][] operations = {
              { "�����ר��", "add.jsp" },
              {"ר�����","del.jsp"}
          };
%>
<%@ include file="../inc/titlebar.jsp" %>
<form method="post" action="dozhuanti.jsp" name="zhuantiForm">
<input type="hidden" name="flag" value="1">
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="100%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">ר��ͼ�����</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td align="center">&nbsp;</td>
                  <td align="center">ר������</td>
                  <td align="center">ͼ������</td>
                  <td align="center">���</td>
                  <td align="center">ͼ������</td>
                  <td align="center">������</td>
                  <td align="center">������</td>
                  <td align="center">����ʱ��</td>
                  <td align="center">ӡ��</td>
                  <td align="center">���¼�</td>
                  <td align="center">������</td>
                  <td align="center">����ʱ��</td>
                </tr>
                <%
                String bookname = "";
                String author = "";
                String publisher = "";
                Timestamp publishtime = null;
                float inprice = 0;
                Timestamp createdate = null;
                long bookid = 0;
                int newflag = 0;
                String booktype = "";
                int zhuanti = 0;

                for(int i=0;i<currentlist.size();i++){
                  search = (Search)currentlist.get(i);

                  zhuanti = search.getZhunti();
                  newflag = search.getNewFlag();
                  if(newflag == 0){
                    booktype = "����";
                  }else if(newflag == 1){
                    booktype = "����";
                  }else if(newflag == 2){
                    booktype = "�ż�";
                  }else if(newflag == 3){
                    booktype = "�����";
                  }

                  int book_type_id = search.getBook_Type_ID();
                  String booktypestr = "";
                  if(book_type_id == 1){
                    booktypestr = "��ѧ";
                  }else if(book_type_id == 2){
                    booktypestr = "��ʷ";
                  }else if(book_type_id == 3){
                    booktypestr = "��ѧ";
                  }else if(book_type_id == 4){
                    booktypestr = "����";
                  }else if(book_type_id == 5){
                    booktypestr = "����";
                  }else if(book_type_id == 6){
                    booktypestr = "�Ļ�";
                  }else if(book_type_id == 7){
                    booktypestr = "������";
                  }else if(book_type_id == 8){
                    booktypestr = "����";
                  }else if(book_type_id == 9){
                    booktypestr = "����";
                  }

                  bookid = search.getBookID();
                  bookname = search.getBookName();
                  bookname = new String(bookname.getBytes("iso8859_1"),"GBK");
                  author = search.getAuthor();
                  author = new String(author.getBytes("iso8859_1"),"GBK");
                  publisher = search.getPublisher();
                  publisher = new String(publisher.getBytes("iso8859_1"),"GBK");
                  publishtime = search.getPublishtime();
                  createdate = search.getCreateDate();

                  int zhuantiflag = search.getZhunti();
                  String zhuantiname = searchMgr.getZhuantiName(zhuantiflag);
                  zhuantiname = zhuantiname==null?"":new String(zhuantiname.getBytes("iso8859_1"),"GBK");
                %>
                <tr  bgcolor="#FFFFFF">
                  <td align="center"><input type="checkbox" value="<%=bookid%>" name="tehui"></td>
                  <td align="center"><%=zhuantiname%></td>
                  <td align="center"><%=booktype%></td>
                  <td align="center"><%=booktypestr%></td>
                  <td align="center"><%=bookname%></td>
                  <td align="center"><%=author%></td>
                  <td align="center"><%=publisher%></td>
                  <td align="center"><%=publishtime==null?"":String.valueOf(publishtime).substring(0, 7)%></td>
                  <td align="center"><%=search.getPrinting_Number()%></td>
                  <td align="center"><%=search.getSale_Price()%></td>
                  <td align="center"><%=search.getC_BookName()==null?"":new String(search.getC_BookName().getBytes("iso8859_1"),"GBK")%></td>
                  <td><%=createdate==null?"":String.valueOf(createdate).substring(0,19)%></td>
                </tr>
                <%}%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="chkAll" value="on"  onclick="javascript:CheckAll(this.form);">ȫ��ѡ��</td></tr>
    <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;
    <%
      IOtherManager otherMgr = OtherPeer.getInstance();
      Other other = new Other();
      List zhuantilist = new ArrayList();
      zhuantilist = otherMgr.listZhuanTi();
    %>
    <select name="zhuanti">
    <%
      String ztname = "";
      for(int i=0;i<zhuantilist.size();i++){
        other = (Other)zhuantilist.get(i);
        ztname = other.getZTName()==null?"":new String(other.getZTName().getBytes("iso8859_1"),"GBK");
    %>
    <option value="<%=other.getID()%>"><%=ztname%></option>
    <%}%>
    </select>
    </td></tr>
  </table>
  <input type="button" value="ʵ��ר��" onclick="javascript:gotodo(1);">
  <input type="button" value="ȡ��ר��" onclick="javascript:gotodo(0);">
</form>

<table>
<tr valign="bottom">
<td>
����<%=rows%>����&nbsp;&nbsp;��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
<%
  if(searchflag == 0){
    if((startrow-range)>=0){
%>
[<a href="zhuanti.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
<%}%>
<%
  if((startrow+range)<rows){
%>
[<a href="zhuanti.jsp?startrow=<%=startrow+range%>">��һҳ</a>]
<%}
 if(totalpages>1){%>
&nbsp;&nbsp;��<input type="text" name="jump" value=<%=currentpage%> size="3">ҳ&nbsp;
 <a href="###" onclick="golistnew((document.all('jump').value-1)*<%=range%>);">GO</a>
<%}

  }else{
    if(searchflag != 0){
    jumpstr="&searchflag=2&booknames="+booknames+"&authors="+authors+"&publishers="+publishers;
    jumpstr=jumpstr+"&pinxiangs="+pinxiangs+"&types="+types+"&publishtime1s="+publishtime1s;
    jumpstr=jumpstr+"&publishtime2s="+publishtime2s+"&upshelf1s="+upshelf1s+"&upshelf2s="+upshelf2s;
    jumpstr=jumpstr+"&findtypes="+findtypes+"&findwhats="+findwhats+"&newflags="+newflags;
    jumpstr=jumpstr+"&in_price1s="+in_price1s+"&in_price2s="+in_price2s+"&saleprice1s="+saleprice1s;
    jumpstr=jumpstr+"&saleprice2s="+saleprice2s+"&c_booknames="+c_booknames+"&recommends="+recommends;
    jumpstr=jumpstr+"&stocknum1s="+stocknum1s+"&stocknum2s="+stocknum2s+"&gonghuoshangs="+gonghuoshangs;
    jumpstr=jumpstr+"&printing_number1s="+printing_number1s+"&printing_number2s="+printing_number2s;

    if((startrow-range)>=0){
%>
  [<a href="zhuanti.jsp?startrow=<%=startrow-range%><%=jumpstr%>">��һҳ</a>]
  <%}
    if((startrow+range)<rows){
  %>
  [<a href="zhuanti.jsp?startrow=<%=startrow+range%><%=jumpstr%>">��һҳ</a>]
  <%}
 if(totalpages>1){

 %>
   &nbsp;&nbsp;��<input type="text" name="jump" value=<%=currentpage%> size="3">ҳ&nbsp;
   <a href="###" onclick="jumppage((document.all('jump').value-1) * <%=range%>,'<%=jumpstr%>');">GO</a>
<%}
}}%>
</td>
</tr>
</table>
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
                  <td class="txt">��������&nbsp;
                     <input type="text" name="c_bookname" class="input">
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td class="txt">�����ˣ�&nbsp;
                    <input type="text" name="author" class="input">
                  </td>
                  <td class="txt">�����̣�&nbsp;
                    <input type="text" name="gonghuoshang" class="input">
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td height="37" class="txt">�����ˣ�&nbsp;
                    <input type="text" name="publisher" class="input">
                    <font color="#FF0000"> </font> </td>
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
                <tr bgcolor="#FFFFFF">
                  <td class="txt">ͼ��Ʒ�ࣺ&nbsp;
                    <select name="pinxiang">
                      <option>��ѡ��...</option>
                      <option value="10">ʮƷ</option>
                      <option value="9">��Ʒ</option>
                      <option value="8">��Ʒ</option>
                      <option value="7">��Ʒ</option>
                      <option value="6">��Ʒ</option>
                    </select>
                  </td>
                  <td class="txt">�Ƽ�ָ����&nbsp;
                    <input type="text" name="recommend" size="3" class="input">
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td class="txt">���&nbsp;
                    <select name="type">
                      <option value="">��ѡ��...</option>
                      <option value="��ѧ">��ѧ</option>
                      <option value="��ʷ">��ʷ</option>
                      <option value="��ѧ">��ѧ</option>
                      <option value="����">����</option>
                      <option value="����">����</option>
                      <option value="�Ļ�">�Ļ�</option>
                      <option value="������">������</option>
                      <option value="����">����</option>
                    </select>
                    <font color="#FF0000"> </font> </td>
                  <td class="txt">��棺&nbsp;&nbsp;��
                    <input type="text" size="6" name="stocknum1" class="input">
                    ��
                    <input type="text" size="6" name="stocknum2" class="input">
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td class="txt">����ʱ�䣺&nbsp;&nbsp;��
                    <input type="text" size="10" name="publishtime1" maxlength="4" class="input">
                    ��
                    <input type="text" size="10" name="publishtime2" maxlength="4" class="input">
                    </td>
                  <td class="txt">���ۣ�&nbsp;&nbsp;��
                    <input type="text" size="6" name="in_price1" class="input">
                    ��
                    <input type="text" size="6" name="in_price2" class="input">
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td class="txt">����ʱ�䣺&nbsp;&nbsp;��
                    <input type="text" size="10" name="upshelf1" onfocus="setday(this)" readonly class="input" class="input">
                    ��
                    <input type="text" size="10" name="upshelf2" onfocus="setday(this)" readonly class="input" class="input">
                    </td>
                  <td class="txt">���¼ۣ�&nbsp;&nbsp;��
                    <input type="text" size="6" name="saleprice1" class="input" class="input">
                    ��
                    <input type="text" size="6" name="saleprice2" class="input" class="input">
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                  <td class="txt">ӡ����&nbsp;&nbsp;��
                    <input type="text" size="6" name="printing_number1" class="input">
                    ��
                    <input type="text" size="6" name="printing_number2" class="input">
                  </td>
                  <td></td>
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
        <p><input type=button value="����" onclick="javascript:gotoSearch(document.all('publishtime1').value,document.all('publishtime2').value);"><br>
          <br>
        </p>
</td>
</tr>
</form>
</table>
</center>
</body>
</html>
