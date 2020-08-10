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
  String memberid = authToken.getUserID();
  int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
  int range = ParamUtil.getIntParameter(request, "range", 20);
  if(startrow<0){
    startrow = 0;
  }

  IAddressListManager addresslistMgr = AddressListPeer.getInstance();
  List list = new ArrayList();
  List currentlist = new ArrayList();

  list = addresslistMgr.getMessageList(memberid);
  currentlist = addresslistMgr.getCurrentMessageList(memberid,startrow,range);
  addresslistMgr.updateMessageDate(memberid);

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
function DelMessage(id)
{
    var bln = confirm("���Ҫɾ����");
    if (bln)
    {
	    window.location = "deletemessage.jsp?id="+id+"&flag=1";
    }
}

function searchcheck(){
  if((form1.searchstr.value ==null)||(form1.searchstr.value == "")){
    alert("������Ҫ��ѯ�����ݣ�");
    return false;
  }
  form1.submit();
  return true;
}
</SCRIPT>
</HEAD>
<BODY>
<P align=right>
<FORM name=form1 action=search.jsp method=post>
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
borderColorLight=#008000 border=1>
  <TBODY>
  <TR height=35>
    <TD align=middle width="5%">���</TD>
    <TD align=middle width="8%">������</TD>
    <TD align=middle width="25%">����</TD>
    <TD align=middle width="10%">��������</TD>
    <TD align=middle width="5%">ɾ��</TD></TR>
<%
  int id = 0;
  String sender = "";
  String content = "";
  long senddate = 0;
  for(int i=0;i<row;i++){
    AddressList addresslist = (AddressList)currentlist.get(i);
    id = addresslist.getID();
    sender = addresslist.getSender();
    content = addresslist.getContent();
    senddate = addresslist.getSendDate();
%>
  <TR height=35>
    <TD align=middle width="5%"><%=(currentpage-1)*range+i+1%></TD>
    <TD align=middle width="8%"><%=sender==null?"--":sender%> </TD>
    <TD align=middle width="25%"><%=content==null?"--":content%> </TD>
    <TD align=middle width="10%"><%=new Timestamp(senddate)%> </TD>
    <TD align=middle width="5%">
    <A href="#" onclick="javascript:return DelMessage(<%=id%>);">
    <IMG src="images/del.gif" border=0></A></TD></TR>
<%}%>
</TBODY></TABLE></p><BR>
<p align=center>
<TABLE>
  <TBODY>
  <TR>
    <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp; ��<%=rows%>��&nbsp;&nbsp; ��ǰ��<%=currentpage%>ҳ&nbsp;
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
    <td><a href="syslist.jsp">����</a></td>
</TR></TBODY></TABLE></p>
</FORM></BODY></HTML>
