<%@ page import="java.util.*,
  		 com.bizwink.server.*,
  		 com.bizwink.security.*,
  		 com.bizwink.register.*,
  		 com.bizwink.util.*"
  		 contentType="text/html;charset=gbk"
%>

<%
  boolean error = false;
  String errormsg = "";
  boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");

  String CorpName = null;
  String CorpAddr = null;
  String UserName = null;
  String TelePhone = null;
  String Fax = null;
  String Email = null;
  String Industry = null;
  String Product = null;
  String SiteName = null;
  String Memo = null;
  int pic = -1;
  int article = -1;

  if (doCreate)
  {
    CorpName = StringUtil.iso2gb(ParamUtil.getParameter(request, "CorpName"));
    CorpAddr = StringUtil.iso2gb(ParamUtil.getParameter(request, "CorpAddr"));
    UserName = StringUtil.iso2gb(ParamUtil.getParameter(request, "UserName"));
    TelePhone = StringUtil.iso2gb(ParamUtil.getParameter(request, "TelePhone"));
    Fax = StringUtil.iso2gb(ParamUtil.getParameter(request, "Fax"));
    Email = StringUtil.iso2gb(ParamUtil.getParameter(request, "Email"));
    Industry = StringUtil.iso2gb(ParamUtil.getParameter(request, "Industry"));
    Product = StringUtil.iso2gb(ParamUtil.getParameter(request, "Product"));
    SiteName = StringUtil.iso2gb(ParamUtil.getParameter(request, "SiteName"));
    Memo = StringUtil.iso2gb(ParamUtil.getParameter(request, "Memo"));
    pic = ParamUtil.getIntParameter(request, "pic", -1);
    article = ParamUtil.getIntParameter(request, "article", -1);

    if (CorpName == null || UserName == null || TelePhone == null ||
        SiteName == null || Email == null || pic == -1 || article == -1)
    {
      error = true;
      errormsg = "�û�ע��ʧ�ܣ�������ע�ᣡ";
    }
  }

  if (doCreate && !error)
  {
    try
    {
      IRegisterManager regMgr = RegisterPeer.getInstance();

      //���ж�������ͬ����
      boolean isExit = regMgr.QuerySiteName(SiteName.trim());
      if (isExit)
      {
      	  errormsg = "�������ѱ�ע�ᣬ�뻻����������";
%>
	<script language=javascript>
	alert("<%=errormsg%>");
	history.go(-1);
	</script>
<%
      	  return;
      }

      Register register = new Register();

      register.setCorpName(CorpName);
      register.setCorpAddr(CorpAddr);
      register.setUserName(UserName);
      register.setTelePhone(TelePhone);
      register.setFax(Fax);
      register.setEmail(Email);
      register.setIndustry(Industry);
      register.setProduct(Product);
      register.setSiteName(SiteName);
      register.setMemo(Memo);
      register.setImagesDir(pic);
      register.setArticleFlag(article);
      register.setBindFlag(0);

      regMgr.create(register);

      errormsg = "���ѳɹ�ע�ᣡ��ȴ����ǵ�ȷ�ϣ���ɹ��󣬽��ᷢ���û��������뵽�������䣬�������ĵȺ�";
    }
    catch (Exception e)
    {
      e.printStackTrace();
      errormsg = "�û�ע��ʧ�ܣ�������ע�ᣡ";
    }
  }

  if (doCreate)
  {
%>
<script language=javascript>
alert("<%=errormsg%>");
window.location = "index.jsp";
</script>
<%
    return;
  }
%>

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=style/global.css>
<title>����ע��</title>
<script language=javascript>
function Form_Check()
{
    if (document.RegForm.CorpName.value == "")
    {
    	alert("��ҵ���Ʋ���Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.UserName.value == "")
    {
    	alert("��ϵ����������Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.TelePhone.value == "")
    {
    	alert("��ϵ�˵绰����Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.Email.value == "")
    {
    	alert("�����ʼ���ַ����Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.SiteName.value == "")
    {
    	alert("��������Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.pic[0].value == "" && document.RegForm.pic[1].value == "")
    {
    	alert("ͼ��洢��ʽ����Ϊ�գ�");
    	return false;
    }
    else if (document.RegForm.article[0].value == "" && document.RegForm.article[1].value == "")
    {
    	alert("������ʾ��ʽ����Ϊ�գ�");
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
<br><p align="center"><b><font face="����" size="4">��&nbsp; ��&nbsp; ע&nbsp;
��</font></b></p>
<div align="center">
  <center>

<form method="POST" action="register.jsp" name="RegForm" onsubmit="javascript:return Form_Check();">
<input type=hidden name="doCreate" value="true">
<table border="1" width="75%" cellpadding="0" cellspacing="0" borderColorDark=#ffffec borderColorLight=#5e5e00 height="446">
  <tr>
    <td width="100%" bgcolor="#006699" align="right" height="20" colspan="2">
      <p align="center"><font color="#FFFFFF"><b>�� * ���������д</b></font></td>
  </tr>
<!--
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>�û�����</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input type="text" name="userid" size="15" style="border-style: solid; border-width: 1">
      * (���ڵ�¼���ʺţ�����ĸ���������)</td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>��&nbsp; �룺</b></td>
    <td width="79%" height="30">&nbsp;<input type="password" name="password1" size="15" style="border-style: solid; border-width: 1">
      * (���ڵ�¼�����룬���6λ����)</td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>ȷ�����룺</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input type="password" name="password2" size="15" style="border-style: solid; border-width: 1">
      *</td>
  </tr>
-->
  <tr>
    <td width="21%" align="right" height="30"><b>��ҵ���ƣ�</b></td>
    <td width="79%" height="30">&nbsp;<input maxlength="40" type="text" name="CorpName" size="35" style="border-style: solid; border-width: 1">
      *</td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>��&nbsp;
      ַ��</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input maxlength="50" type="text" name="CorpAddr" size="50" style="border-style: solid; border-width: 1"></td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>��ϵ�ˣ�</b></td>
    <td width="79%" height="30">&nbsp;<input maxlength="10" type="text" name="UserName" size="15" style="border-style: solid; border-width: 1">
      *</td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>��&nbsp;
      ����</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input maxlength="20" type="text" name="TelePhone" size="20" style="border-style: solid; border-width: 1">
      *</td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>��&nbsp; �棺</b></td>
    <td width="79%" height="30">&nbsp;<input maxlength="20" type="text" name="Fax" size="20" style="border-style: solid; border-width: 1"></td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>�����ʼ���</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input maxlength="40" type="text" name="Email" size="35" style="border-style: solid; border-width: 1">
      * <font color=red>(�û��������뽫���͵������䣬����ȷ��д�ʼ���ַ)</font></td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>��&nbsp; ҵ��</b></td>
    <td width="79%" height="30">&nbsp;<select name="Industry" size="1">
<OPTION value=notselect>--��ѡ����ҵ---</OPTION>
<OPTION VALUE=��Ϣ�����ͻ�����(�������Ӳ��,ͨѶ)>��Ϣ�����ͻ�����(�������Ӳ��,ͨѶ)</OPTION>
<OPTION VALUE=���Ӽ���>���Ӽ���</OPTION>
<OPTION VALUE=����(����,���ջ���)>����(����,���ջ���)</OPTION>
<OPTION VALUE=ó��>ó��</OPTION>
<OPTION VALUE=��������Ʒ(ʳƷ,����,��ױƷ)>��������Ʒ(ʳƷ,����,��ױƷ)</OPTION>
<OPTION VALUE=��������Ʒ(��װ,��֯,�Ҿ�,�ҵ�,����Ʒ)>��������Ʒ(��װ,��֯,�Ҿ�,�ҵ�,����Ʒ)</OPTION>
<OPTION VALUE=��ѯҵ>��ѯҵ</OPTION>
<OPTION VALUE=����/��ҩ/����/ҽҩ>����/��ҩ/����/ҽҩ</OPTION>
<OPTION VALUE=����/���/װ��>����/���/װ��</OPTION>
<OPTION VALUE=����ҵ>����ҵ</OPTION>
<OPTION VALUE=�Ƶ�/����>�Ƶ�/����</OPTION>
<OPTION VALUE=���ҵ>���ҵ</OPTION>
<OPTION VALUE=ý��/����>ý��/����</OPTION>
<OPTION VALUE=�ӹ�/����(��ҵ�Զ���,�豸,�㲿��)>�ӹ�/����(��ҵ�Զ���,�豸,�㲿��)</OPTION>
<OPTION VALUE=ӡˢ/��װ>ӡˢ/��װ</OPTION>
<OPTION VALUE=�ɾ�ҵ/ұ��>�ɾ�ҵ/ұ��</OPTION>
<OPTION VALUE=����/����>����/����</OPTION>
<OPTION VALUE=����>����</OPTION>
<OPTION VALUE=����/��Դ>����/��Դ</OPTION>
<OPTION VALUE=����>����</OPTION>
<OPTION VALUE=��ͨ/����/����>��ͨ/����/����</OPTION>
<OPTION VALUE=����������>����������</OPTION>
<OPTION VALUE=����/��ѵ>����/��ѵ</OPTION>
<OPTION VALUE=ѧ��/����/����>ѧ��/����/����</OPTION>
<OPTION VALUE=����ҵ>����ҵ</OPTION>
<OPTION VALUE=���ز����н�>���ز����н�</OPTION>
<OPTION VALUE=����ҵ>����ҵ</OPTION>
<OPTION VALUE=��ӯ������/����>��ӯ������/����</OPTION>
<OPTION VALUE=ũҵ/��ҵ/��ҵ>ũҵ/��ҵ/��ҵ</OPTION>
<OPTION VALUE=������ҵ>������ҵ</OPTION>
</select>
</td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>��&nbsp;
      Ʒ��</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30">&nbsp;<input maxlength="100" type="text" name="Product" size="50" style="border-style: solid; border-width: 1"></td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>��&nbsp; ����</b></td>
    <td width="79%" height="30">&nbsp;<input maxlength="80" type="text" name="SiteName" size="50" style="border-style: solid; border-width: 1">
      *</td>
  </tr>
  <tr>
    <td width="21%" align="right" height="80" bgcolor="#EFEFEF"><b>��&nbsp;   �ܣ�</b></td>
    <td width="79%" height="80" bgcolor="#EFEFEF">&nbsp;<textarea rows="4" name="Memo" cols="49" style="border-style: solid; border-width: 1"></textarea>&nbsp;</td>
  </tr>
  <tr>
    <td width="21%" align="right" height="30"><b>ͼ��洢��ʽ��</b></td>
    <td width="79%" height="30"><input type="radio" value="0" name="pic" checked>վ���Ŀ¼images��&nbsp;
      <input type="radio" value="1" name="pic">����Ŀimages�� *</td>
  </tr>
  <tr>
    <td width="21%" bgcolor="#EFEFEF" align="right" height="30"><b>������ʾ��ʽ��</b></td>
    <td width="79%" bgcolor="#EFEFEF" height="30"><input type="radio" value="0" name="article" checked>����ʾ����Ŀ������&nbsp;
      <input type="radio" value="1" name="article">��ʾ��������Ŀ������
      *</td>
  </tr>
</table>
<p><input type="submit" value="ע  ��" name="Register">&nbsp;&nbsp;&nbsp;
   <input type="button" value="ȡ  ��" name="Reset" onclick="history.go(-1)"></p>
</form>

  </center>
</div>

</body>
</html>
