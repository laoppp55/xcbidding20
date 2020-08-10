<%@page import="com.bizwink.cms.toolkit.addresslist.*,
                java.util.*,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.SessionUtil" contentType="text/html;charset=GBK"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  String memberid = authToken.getUserID();
  String searchstr = ParamUtil.getParameter(request, "searchstr") ;
  int seltype = ParamUtil.getIntParameter(request, "seltype", 1);
  int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
  int range = ParamUtil.getIntParameter(request, "range", 20);
  if(startrow<0){
    startrow = 0;
  }

  IAddressListManager addresslistMgr = AddressListPeer.getInstance();
  List list = new ArrayList();
  List currentlist = new ArrayList();
  String sqlstr = "";
  if(seltype == 1){
    sqlstr = "select * from tbl_userinfos where username like '@" + searchstr + "@' and memberid = '"+memberid+"'";
  }else if(seltype == 2){
    sqlstr = "select * from tbl_userinfos where corporation like '@" + searchstr + "@' and memberid = '"+memberid+"'";
  }

  list = addresslistMgr.getSearchAddressList(sqlstr);
  currentlist = addresslistMgr.getCurrentSearchAddressList(sqlstr,startrow,range);

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
function DelPeople(id)
{
    var bln = confirm("���Ҫɾ����");
    if (bln)
    {
	    window.location = "delete.jsp?id="+id;
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
<P align=right><FONT color=#0000ff><A href="list.jsp">�����б�</A>&nbsp;&nbsp;<A
href="add.jsp">����³�Ա</A></FONT> <BR>
<FORM name=form1 action=search.jsp method=post>
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
borderColorLight=#008000 border=1>
  <TBODY>
  <TR height=35>
    <TD align=middle width="5%">���</TD>
    <TD align=middle width="8%">����</TD>
    <TD align=middle width="25%">������λ</TD>
    <TD align=middle width="10%">�ֻ�</TD>
    <TD align=middle width="9%">�绰</TD>
    <TD align=middle width="10%">�����ʼ�</TD>
    <TD align=middle width="5%">���</TD>
    <TD align=middle width="5%">�޸�</TD>
    <TD align=middle width="5%">ɾ��</TD></TR>
<%
  int id = 0;
  String username = "";
  String corporation = "";
  String mobilephone = "";
  String phone = "";
  String email = "";
  for(int i=0;i<row;i++){
    AddressList addresslist = (AddressList)currentlist.get(i);
    id = addresslist.getID();
    username = addresslist.getName();
    corporation = addresslist.getCorporation();
    mobilephone = addresslist.getMobilephone();
    phone = addresslist.getPhone();
    email = addresslist.getEmail();
%>
  <TR height=35>
    <TD align=middle width="5%"><%=(currentpage-1)*range+i+1%></TD>
    <TD align=middle width="8%"><%=username==null?"--":username%> </TD>
    <TD align=middle width="25%"><%=corporation==null?"--":corporation%> </TD>
    <TD align=middle width="10%"><%=mobilephone==null?"--":mobilephone%> </TD>
    <TD align=middle width="9%"><%=phone==null?"--":phone%> </TD>
    <TD align=middle width="10%"><%=email==null?"--":email%> </TD>
    <TD align=middle width="5%"><A
      href="view.jsp?id=<%=id%>"><IMG
      src="images/preview.gif" border=0></A></TD>
    <TD align=middle width="5%"><A
      href="edit.jsp?id=<%=id%>"><IMG
      src="images/dx.gif" border=0></A></TD>
    <TD align=middle width="5%">
    <A href="#" onclick="javascript:return DelPeople(<%=id%>);">
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
</TR></TBODY></TABLE></p><BR><BR>
<p align=right>
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
borderColorLight=#008000 border=1>
  <TBODY>
  <TR height=35>
    <TD>&nbsp;&nbsp;������<select name="seltype">
    <option value="1">�û���</option>
    <option value="2">������λ</option>
    </select>
    <input type="text" size=40 name="searchstr">&nbsp;&nbsp;<input type="button" value=" �� ѯ " onclick="javascript:return searchcheck();"></TD>
  </tr>
  </tbody>
</table>
</p>
</FORM></BODY></HTML>
