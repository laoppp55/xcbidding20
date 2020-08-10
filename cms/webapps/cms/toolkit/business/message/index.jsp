<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Message.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  int siteid = authToken.getSiteID();

  int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
  int range               = ParamUtil.getIntParameter(request, "range", 30);
  String username         = ParamUtil.getParameter(request,"username");


  IMessageManager messageMgr = messagePeer.getInstance();
  Message message = new Message();
  List list = new ArrayList();
  List currentlist = new ArrayList();
  int currentrows = 0;
  int totalrows = 0;
  list = messageMgr.getMessageList(0,-1,0,username,siteid,startrow,0);
  currentlist = messageMgr.getMessageList(0,-1,0,username,siteid,startrow,range);

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
    alert("����ѡ��Ҫɾ������Ϣ��");
    return false;
  }else{
    var val;
    val = confirm("��ȷ��Ҫɾ����Щ��Ϣ��");
    if(val)
      return true;
    else
      return false;
  }
}

function savemessage(id,userid)
{
  var objXml = new ActiveXObject("Microsoft.XMLHTTP");
  objXml.open("POST", "savemessage.jsp?id="+id+"&userid="+userid, false);
  objXml.Send();
  var content = objXml.responseText;
  alert('��Ϣ�ѱ����浽�ղؼ�');
}
</script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "��Ϣ����", "" }
          };

      String[][] operations = {
              { "������Ϣ", "sendmessage.jsp" },
              { "������", "index2.jsp" },
              { "�ռ���", "index.jsp" },
              { "�ղؼ�", "important.jsp" }
          };
%>
<%@ include file="../inc/titlebar.jsp" %>
<form method="post" action="deleteMess.jsp">
<input type="hidden" name="username" value="<%=username%>">
<input type="hidden" name="flag" value="1">
<input type="hidden" name="startrow" value="<%=startrow%>">
<input type="hidden" name="range" value="<%=range%>">
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="100%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">��Ϣ�б�</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td width="5%" align="center">&nbsp;</td>

                  <td width="15%" align="center">������</td>
                  <td width="65%" align="center">��Ϣ����</td>
                  <td width="15%" align="center">����ʱ��</td>
                  <td width="15%" align="center"></td>
                </tr>
                <%
                int id = 0;
                String send_user = "";
                String content = "";
                Timestamp send_date = null;
                String senddate = "";
                for(int i=0;i<currentlist.size();i++){
                  message = (Message)currentlist.get(i);

                  id = message.getID();
                  send_user = StringUtil.gb2iso4View(message.getSenderName());
                  content = StringUtil.gb2iso4View(message.getMessage());
                  send_date = message.getSendDate();
                  senddate = String.valueOf(send_date);
                  senddate = senddate.equals("null")?"":senddate.substring(0,16);
                %>
                <tr  bgcolor="#FFFFFF">
                  <td align="center"><input type="checkbox" name="delMessage" value="<%=id%>"></td>

                  <td align="center">
                      <table width="100%"><tr><td align="center" >
                       <a href="../member/detail_user.jsp?userid=<%=message.getSend_User()%>" target=_blank><%=send_user%></a>
                      </td>
                      <td class="txt" width=24>
                       <a href="sendmessage.jsp?userid=<%=message.getSend_User()%>" target=_blank>
                       <font color="#99B8D5">�ظ�</font>
                       </a>
                      </td></tr></table>
                  </td>
                  <td align="center"><%=content%></td>
                  <td align="center"><%=senddate%></td>
                  <td align="center"><button style="height:19;width:40;font-size:9pt" onclick="savemessage('<%=message.getID()%>','-1')">�ղ���Ϣ</button></td>
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
  <input type="submit" value="ɾ��" onclick="javascript:return check(this.form);">
</form>
<table>
<tr>
<td>
<%
  if((startrow-range)>=0){
%>
[<a href="index.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
<%}%>
<%
  if((startrow+range)<rows){
%>
[<a href="index.jsp?startrow=<%=startrow+range%>">��һҳ</a>]
<%}%>
</td>
</tr>
</table>
</center>
<script language="javascript">
function searchLeaveWord()
{
  if((searchLeaveWordForm.username.value == null))
  {
    alert("��������Ҫ��ѯ���û�����");
    return false;
  }
  searchLeaveWordForm.submit();
}
</script>
<form name="searchLeaveWordForm" method="post" action="index.jsp">
<input type="hidden" name="searchflag" value=1>
<table align="center">
<tr><td>
��ѯ���ԣ��û�ID&nbsp;<input type="text" name="username">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="��ѯ" onclick="javascript:return searchLeaveWord();">
</td></tr>
</table>
</form>
</body>
</html>
