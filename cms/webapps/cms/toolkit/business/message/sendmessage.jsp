<%@ page import="java.io.*,
                 java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
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

  String userid = ParamUtil.getParameter(request,"userid");
  int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
  IMessageManager messageMgr = messagePeer.getInstance();
  Message message = new Message();

  if(startflag == 1){
    String content = ParamUtil.getParameter(request, "content");
    message.setFlag(1);
    message.setSend_User("ϵͳ����Ա");
    message.setReceive_User(userid);
    message.setSiteID(siteid);
    message.setMessage(content);
    messageMgr.newMessage(message);

    out.println("<script language=\"javascript\">");
    out.println("alert(\"��Ϣ���ͳɹ���\");");
    out.println("window.close();");
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
  if((annoForm.content.value == "")||(annoForm.content.value == null)){
    alert("��������Ϣ���ݺ��ٷ��ͣ�");
    return false;
  }
  return true;
}

function getname()
{
  var userid = sendform.userid.value;
  if(userid=="")
  {
    alert('�������û�ID');
    return false;
  }

  var objXml = new ActiveXObject("Microsoft.XMLHTTP");
  objXml.open("POST", "../account/getnames.jsp?userid="+userid, false);
  objXml.Send();
  var content = objXml.responseText;
  var idx11 = content.indexOf('_USERNAME_');
  var idx12 = content.indexOf('_UOK_');
  var idx21 = content.indexOf('_REALNAME_');
  var idx22 = content.indexOf('_ROK_');
  var shown = '';
  if(idx11 != -1 && idx12 != -1)
  {
    var username = content.substring(idx11+10,idx12);
     shown = '�û���: '+username;
  }
  if(idx21 != -1 && idx22 != -1)
  {
    var realname = content.substring(idx21+10,idx22);
    shown =shown + '  ����: '+realname;
  }
  showname.innerText = shown
}

function syssend()
{
  if(sendform.sysmessage.checked)
  {
    sendform.userid.value='ϵͳ��Ϣ';
    showname.innerText='ϵͳ��Ϣ����ʾ��ÿ���û�';
    sendform.userid.disabled=1;
    sendform.btn.disabled=1;
  }else
  {
    showname.innerText='';
    sendform.userid.value='';
    sendform.userid.disabled=0;
    sendform.btn.disabled=0;
  }
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
<form action="sendmessage.jsp" method="post" name="sendform">
<input type="hidden" name="startflag" value="1">
<center>
<table width="600" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">������Ϣ</font></td>

          </tr>

          <tr bgcolor="#d4d4d4" align="right">
            <td>
                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                  <tr bgcolor="#FFFFFF">
                      <td width="15%">�ͻ�ID��</td>
                      <td width="15%"><input style="width:80" name="userid" type="text" value="<%="0".equals(String.valueOf(userid))?"":String.valueOf(userid)%>"> </td>
                      <td width="15%">
                       <button id=btn style="height:19;width:80;font-size:9pt;" onclick="getname()">�� ѯ</button>

                      </td>
                      <td id="showname" width="55%"></td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td >��Ϣ���ݣ�</td>
                    <td colspan=3>
                      <textarea rows="10" cols="70" name="content"></textarea>
                    </td>
                  </tr>
                </table>
            </td>
          </tr>
          <tr><td><input type="checkbox" id=sysmessage value=1 onclick="syssend()"><font color="#48758C">ϵͳ��Ϣ</font></td></tr>
          <tr align="center">
            <td><input type="submit" name="Submit" value="����" onclick="javascript:return check(this.form);">
                &nbsp;
                <input name="button" type="reset" id="Reset" value="�ر�" onclick="javascript:window.close();">
          </tr>
        </table>
      </td>
</tr>
</table>
</center>
</form>
</center>

<%if(userid != null && !userid.equals("") && !userid.equals("null"))
{
  out.println("<script language=\"javascript\">");
  out.println("getname();");
  out.println("</script>");
}else{
  out.println("<script language=\"javascript\">");
  out.println("sendform.sysmessage.checked=1;");
  out.println("syssend();");
  out.println("</script>");
}

%>
</body>
</html>
