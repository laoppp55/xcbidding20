<%@ page import="java.io.*,
                 java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Other.*"
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
%>

<%
  boolean success = false;
  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);

  if(startflag == 1)
  {
    String kind      = ParamUtil.getParameter(request,"kind");
    String name      = ParamUtil.getParameter(request,"name");
    String lianxiren = ParamUtil.getParameter(request,"lianxiren");
    String address   = ParamUtil.getParameter(request,"address");
    String postcode  = ParamUtil.getParameter(request,"postcode");
    String telphone  = ParamUtil.getParameter(request,"telphone");
    String email     = ParamUtil.getParameter(request,"email");
 //   String fahuo     = ParamUtil.getParameter(request,"fahuo");
 //   String jiesuan   = ParamUtil.getParameter(request,"jiesuan");
    String notes    =ParamUtil.getParameter(request,"notes");

    IOtherManager otherMgr = otherPeer.getInstance();
    Other other = new Other();

    other.setGH_Adderss(address);
    other.setGH_Email(email);
    other.setGH_Kind(kind);
    other.setGH_Lianxiren(lianxiren);
    other.setGH_Name(name);
    other.setGH_Notes(notes);
    other.setGH_Phone(telphone);
    other.setGH_Postcode(postcode);
    other.setGH_Siteid(siteid);
    otherMgr.newGH(other);

    out.println("<script language=\"javascript\">");
    out.println("alert(\"��������Ϣ������\");");
    out.println("opener.history.go(0);");
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
function check(){
  if((addform.name.value == "")||(addform.name.value == null)){
    alert("�����빩Ӧ�����ƣ�");
    return false;
  }
  if((addform.kind.value == "")||(addform.kind.value == null)){
    alert("������������࣡");
    return false;
  }
  if((addform.lianxiren.value == "")||(addform.lianxiren.value == null)){
    alert("��������ϵ�ˣ�");
    return false;
  }
  if((addform.address.value == "")||(addform.address.value == null)){
    alert("�����빩Ӧ�̵�ַ��");
    return false;
  }
  if((addform.telphone.value == "")||(addform.telphone.value == null)){
    alert("�����빩Ӧ�̵绰��");
    return false;
  }
  addform.action="addnew.jsp";
  //addform.submit();
  return true;
}
</script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "�����̹���", "" }
          };

      String[][] operations = {
              { "��ӹ�����", "addnew.jsp" },{"",""}
          };
%>
<%@ include file="../inc/titlebar.jsp" %>


<form action="#" method="post" name="addform">
<input type="hidden" name="startflag" value="1">
<center>
<table width="770" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">��������Ϣ</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2">
                <tr>
                  <td>��������Ϣ<font color="#FF0000">*</font>����</td>
                </tr>
              </table>
                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                  <!--DWLayoutTable-->
                  <tr bgcolor="#FFFFFF">
                    <td width="20%">���������ƣ�</td>
                    <td width="30%"> <input name="name" type="text" id="name" size="20">
                      <font color="#FF0000"> * </font></td>
                    <td>������ϸ��д<font color="#FF0000">����������</font>����ϸ��Ϣ��</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�������ͣ�</td>
                    <td> <input type="text" name="kind" size="20"> <font color="#FF0000"> *
                      </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>��ϵ�ˣ�</td>
                    <td> <input name="lianxiren" type="text" size="20">
                      <font color="#FF0000"> * </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>��ַ��</td>
                    <td> <input name="address" type="text"  size="20">
                      <font color="#FF0000"> * </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�ʱࣺ</td>
                    <td> <input name="postcode" type="text"  size="20">
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�绰��</td>
                    <td> <input name="telphone" type="text"  size="20">
                      <font color="#FF0000"> * </font> </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>�����ʼ���</td>
                    <td> <input name="email" type="text"  size="20"></td>
                    <td></td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td>��ע��</td>
                    <td> <input name="notes" type="text" size="20">
                      &nbsp; </td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
          <tr align="center">
            <td>
                <input name="submit" type="submit"  value="�ύ" onclick="javascript:return check()"></td>
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