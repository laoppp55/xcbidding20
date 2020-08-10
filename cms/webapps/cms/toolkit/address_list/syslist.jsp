<%@page import="com.bizwink.cms.toolkit.addresslist.*,
                java.util.*,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.SessionUtil,
                java.sql.Timestamp" contentType="text/html;charset=GBK"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  int siteid = authToken.getSiteID();
  String memberid = authToken.getUserID();
  int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
  int range = ParamUtil.getIntParameter(request, "range", 20);
  if(startrow<0){
    startrow = 0;
  }

  IAddressListManager addresslistMgr = AddressListPeer.getInstance();
  List list = new ArrayList();
  List currentlist = new ArrayList();

  list = addresslistMgr.getSysAddressList(siteid);
  currentlist = addresslistMgr.getCurrentSysAddressList(startrow,range,siteid);

  int row = 0;
  int rows = 0;
  int totalpages = 0;
  int currentpage = 0;

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
%>
<HTML><HEAD><TITLE>New Page 1</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/common.css" type=text/css rel=stylesheet>
<LINK href="images/forum.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript>
function searchcheck(){
  if((form1.searchstr.value ==null)||(form1.searchstr.value == "")){
    alert("������Ҫ��ѯ�����ݣ�");
    return false;
  }
  form1.submit();
  return true;
}

function popwin(id,name,uid){
  window.open("send.jsp?id="+id+"&name="+name+"&userid="+uid,"","width=550,height=300,top=100,left=200");
}
</SCRIPT>
</HEAD>
<BODY>
<P align=right>
<%
  Timestamp messagedate = addresslistMgr.getNewMessageDate(memberid);
  Timestamp readdate = addresslistMgr.getNewReadDate(memberid);

  out.println("<table>");
  out.println("<tr>");
  if(readdate != null){
    if(messagedate.compareTo(readdate)>0){
      out.println("<td align=center>");
      out.println("<a href='messagelist.jsp?receiver='"+memberid+"><b><font color=red>��������Ϣ��</font></b></a>");
      out.println("</td>");
    }
  }
  out.println("<td><a href=\"messagelist.jsp\">�ѽ�����Ϣ</a></td>");
  out.println("<td>&nbsp;</td>");
  out.println("<td><a href=\"sendmsg.jsp\">�ѷ�����Ϣ</a></td>");
%>

<FORM name=form1 action=search.jsp method=post>
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
borderColorLight=#008000 border=1>
  <TBODY>
  <TR height=35>
    <TD align=middle width="5%">���</TD>
    <TD align=middle width="8%">����</TD>
    <td align=middle width="8%">��¼��</td>
    <TD align=middle width="10%">�ֻ�</TD>
    <TD align=middle width="9%">�绰</TD>
    <TD align=middle width="10%">�����ʼ�</TD>
    <TD align=middle width="5%">������Ϣ</TD></TR>
<%
  int id = 0;
  String username = "";
  String userid = "";
  String mobilephone = "";
  String phone = "";
  String email = "";
  for(int i=0;i<row;i++){
    AddressList addresslist = (AddressList)currentlist.get(i);
    id = addresslist.getID();
    username = addresslist.getName()==null?"":addresslist.getName();
    userid = addresslist.getMemberID();
    mobilephone = addresslist.getMobilephone();
    phone = addresslist.getPhone();
    email = addresslist.getEmail();

    if(addresslist.getMemberID().equalsIgnoreCase(memberid)){
      continue;
    }
%>
  <TR height=35>
    <TD align=middle width="5%"><%=(currentpage-1)*range+i+1%></TD>
    <TD align=middle width="8%"><A href="javascript:popwin('<%=id%>','<%=username%>','<%=userid%>');"><%=username%></a> </TD>
    <TD align=middle width="8%"><%=userid%></td>
    <TD align=middle width="10%"><%=mobilephone==null?"--":mobilephone%> </TD>
    <TD align=middle width="9%"><%=phone==null?"--":phone%> </TD>
    <TD align=middle width="10%"><%=email==null?"--":email%> </TD>
    <TD align=middle width="5%"><A href="javascript:popwin('<%=id%>','<%=username%>','<%=userid%>');"><IMG src="images/send_1.gif" border=0></A></TD>
</TR>
<%}%>
</TBODY></TABLE></p><BR>
<p align=center>
<TABLE>
  <TBODY>
  <TR>
    <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp;  ��ǰ��<%=currentpage%>ҳ&nbsp;
    <%
      if(startrow>0){
    %>
    <a href="list.jsp?startrow=0">��һҳ</a>
    <%}%>
    <%if((startrow-range)>=0){%>
    <a href="list.jsp?startrow=<%=startrow-range%>">��һҳ</a>
    <%}%>
    <%if((startrow+range)<list.size()){%>
    <A href="list.jsp?startrow=<%=startrow+range%>">��һҳ</A>
    <%}%>
    <%if(currentpage != totalpages){%>
    <A href="list.jsp?startrow=<%=(totalpages-1)*range%>">���һҳ</A>
    <%}%>
    </TD>
    <TD>&nbsp;</TD>
</TR></TBODY></TABLE></p><BR><BR>
</FORM></BODY></HTML>
