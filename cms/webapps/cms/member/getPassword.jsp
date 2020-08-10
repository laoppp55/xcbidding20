<%@ page import="java.util.*,
  		 com.bizwink.cms.register.*,
  		 com.bizwink.cms.util.*"
  		 contentType="text/html;charset=gbk"
%>

<%
  boolean error = false;
  String errormsg = "";
  boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");

  String UserID = null;
  String SiteName = null;

  if (doCreate)
  {
    UserID = StringUtil.iso2gb(ParamUtil.getParameter(request, "UserID"));
    SiteName = StringUtil.iso2gb(ParamUtil.getParameter(request, "SiteName"));

    if (UserID == null || SiteName == null)
    {
      error = true;
      errormsg = "�û�������������Ϊ�գ���������д��";
    }
  }

  if (doCreate && !error)
  {
    try
    {
      IRegisterManager regMgr = RegisterPeer.getInstance();

      regMgr.getPassword(UserID, SiteName);

      errormsg = "��ȴ����ǵ�ȷ�ϣ�����Ϣ��д��ȷ�����뽫�ᷢ�͵��������䣬�������ĵȺ�";
    }
    catch (Exception e)
    {
      e.printStackTrace();
      errormsg = "�û�������������Ϊ�գ���������д��";
    }
  }

  if (doCreate)
  {
%>
<script language=javascript>
alert("<%=errormsg%>");
window.location = "../index.jsp";
</script>
<%
    return;
  }
%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<title>ȡ������</title>
<script language=javascript>
function Form_Check()
{
    if (document.RegForm.UserID.value == "")
    {
    	alert("�û�������Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.SiteName.value == "")
    {
    	alert("��������Ϊ�գ�");
    	return false;
    }
    else
    {
    	return true;
    }
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" id="all" leftmargin="10" topmargin="10" marginwidth="10" marginheight="10" link="#000020" vlink="#000020" alink="#000020">
<br><p align="center"><b><font face="����" size="4">ȡ&nbsp;��&nbsp;��&nbsp;��</font></b></p>
<div align="center">
  <center>

<form method="POST" action="getPassword.jsp" name="RegForm" onsubmit="javascript:return Form_Check();">
<input type=hidden name="doCreate" value="true">
<table border="1" width="45%" cellpadding="0" cellspacing="0" borderColorDark=#ffffec borderColorLight=#5e5e00 height="160">
  <tr>
    <td width="100%" bgcolor="#006699" align="right" height="20" colspan="2">
      <p align="center"><font color="#FFFFFF"><b>������Ϣ������д��ȷ��ϵͳ�ŻὫ���뷢�͵���ע������䣡</b></font></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>�û�����</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input maxlength=20 type="text" name="UserID" size="15" style="border-style: solid; border-width: 1">
       <font color=red>(���ڵ�¼���ʺ�)</font></td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>��&nbsp; ����</b></td>
    <td width="79%" height="30">&nbsp;<input maxlength="80" type="text" name="SiteName" size="30" style="border-style: solid; border-width: 1"></td>
  </tr>
  <tr>
    <td width="21%" align="center" height="30" colspan="2">
    �����������⣬�뷢���ʼ���ϵͳ����Ա����&nbsp;<b><a href="mailto:customer@bizwink.com.cn">customer@bizwink.com.cn</a></b>
    </td>
  </tr>
</table>
<p><input type="submit" value="��  ��" name="Submit">&nbsp;&nbsp;&nbsp;
   <input type="button" value="��  ��" name="GoBack" onclick="history.go(-1)"></p>
</form>

  </center>
</div>

</body>
</html>
