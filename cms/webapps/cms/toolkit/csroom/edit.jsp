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

  int id = ParamUtil.getIntParameter(request, "id", 0);
  int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
  String username = ParamUtil.getParameter(request, "username");
  String company = ParamUtil.getParameter(request, "company");
  String address = ParamUtil.getParameter(request, "address");
  String postcode = ParamUtil.getParameter(request, "postcode");
  String mobilephone = ParamUtil.getParameter(request, "mobilephone");
  String phone = ParamUtil.getParameter(request, "phone");
  String fax = ParamUtil.getParameter(request, "fax");
  String email = ParamUtil.getParameter(request, "email");

  AddressList addresslist = new AddressList();
  IAddressListManager addresslistMgr = AddressListPeer.getInstance();

  if(startflag == 1){
    long nowtime = System.currentTimeMillis();

    addresslist.setName(username);
    addresslist.setCorporation(company);
    addresslist.setAddress(address);
    addresslist.setPostCode(postcode);
    addresslist.setMobilephone(mobilephone);
    addresslist.setPhone(phone);
    addresslist.setFax(fax);
    addresslist.setEmail(email);
    addresslist.setWriteDate(nowtime);
    addresslist.setMemberID(memberid);
    addresslistMgr.updateAddressList(addresslist, id);
    response.sendRedirect("list.jsp");
  }

  addresslist = addresslistMgr.getA_AddressList(id);
%>
<HTML><HEAD><TITLE>��ϵ����Ϣ�޸�</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/common.css" type=text/css rel=stylesheet>
<LINK href="images/forum.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript>
function check()
{
  if(form1.name.value=="")
  {
    alert("��������ϵ��������");
    return false;
  }

  if(form1.postcode.value!="")
  {
    var digits = "0123456789";
    var i = 0;
    var sLength = form1.postcode.value.length;
    while ((i < sLength))
    {
       var c = form1.postcode.value.charAt(i);
       if (digits.indexOf(c) == -1)
       {
         alert("�ʱ��������");
         return false;
       }
       i++;
    }
  }

  if(form1.fax.value!="")
  {
    var digits = "0123456789-()";
    var i = 0;
    var sLength = form1.fax.value.length;
    while ((i < sLength))
    {
       var c = form1.fax.value.charAt(i);
       if (digits.indexOf(c) == -1)
       {
         alert("�����������");
         return false;
       }
       i++;
    }
  }
  if(form1.telephone.value!="")
  {
    var digits = "0123456789-()";
    var i = 0;
    var sLength = form1.telephone.value.length;
    while ((i < sLength))
    {
       var c = form1.telephone.value.charAt(i);
       if (digits.indexOf(c) == -1)
       {
         alert("�绰�������");
         return false;
       }
       i++;
    }
  }
  if(form1.mobilephone.value!="")
  {
    var digits = "0123456789-()";
    var i = 0;
    var sLength = form1.mobilephone.value.length;
    while ((i < sLength))
    {
       var c = form1.mobilephone.value.charAt(i);
       if (digits.indexOf(c) == -1)
       {
         alert("�ֻ��������");
         return false;
       }
       i++;
    }
  }

  if(form1.email.value!="")
  {
        if (form1.email.value.length > 100)
        {
                window.alert("email��ַ���Ȳ��ܳ���100λ!");
                return false;
        }

         var regu = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$"
         var re = new RegExp(regu);
         if (form1.email.value.search(re) != -1) {
               return true;
         } else {
               window.alert ("��������Ч�Ϸ��ĵ����ʼ� ��")
               return false;
         }
  }
  return true;
}

function goto()
{
  form1.action="list.jsp";
  form1.submit();
}
</SCRIPT>

<META content="MSHTML 6.00.2800.1479" name=GENERATOR></HEAD>
<BODY bgColor=#ffffff>
<FORM name=form1 action=edit.jsp method=post>
<INPUT type=hidden value=1 name=startflag>
<input type=hidden name="id" value="<%=id%>">
<CENTER>
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80%
borderColorLight=#008000 border=1>
  <TBODY>
  <TR>
    <TD bgColor=#33ccff colSpan=2 height=32>
      <P align=center>�޸���ϵ����Ϣ</P></TD></TR>
  <TR height=32>
    <TD align=right width=30% height=32>��ϵ��������</TD>
    <TD align=left width=70% height=32>&nbsp;<INPUT name=username value="<%=addresslist.getName()==null?"":addresslist.getName()%>"> <FONT
      color=red>*</FONT> </TD></TR>
  <TR height=32>
    <TD align=right>��˾���ƣ�</TD>
    <TD align=left>&nbsp;<INPUT size=50 name=company value="<%=addresslist.getCorporation()==null?"":addresslist.getCorporation()%>">
  </TD></TR>
  <TR height=32>
    <TD align=right>��ַ��</TD>
    <TD align=left>&nbsp;<INPUT size=50 name=address value="<%=addresslist.getAddress()==null?"":addresslist.getAddress()%>"> </TD></TR>
  <TR height=32>
    <TD align=right>�ʱࣺ</TD>
    <TD align=left>&nbsp;<INPUT size=13 name=postcode value="<%=addresslist.getPostCode()==null?"":addresslist.getPostCode()%>">
  </TD></TR>
  <TR height=32>
    <TD align=right>�ֻ���</TD>
    <TD align=left>&nbsp;<INPUT name=mobilephone value="<%=addresslist.getMobilephone()==null?"":addresslist.getMobilephone()%>"> </TD></TR>
  <TR height=32>
    <TD align=right>�绰��</TD>
    <TD align=left>&nbsp;<INPUT size=16 name=phone value="<%=addresslist.getPhone()==null?"":addresslist.getPhone()%>">
  </TD></TR>
  <TR height=32>
    <TD align=right>���棺</TD>
    <TD align=left>&nbsp;<INPUT size=16 name=fax value="<%=addresslist.getFax()==null?"":addresslist.getFax()%>"> </TD></TR>
  <TR height=32>
    <TD align=right>�����ʼ���</TD>
    <TD align=left>&nbsp;<INPUT size=50 name=email value="<%=addresslist.getEmail()==null?"":addresslist.getEmail()%>"> </TD></TR>
  <TR height=32>
    <TD colSpan=2><FONT
      color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע������*����Ϊ������</FONT></TD></TR></TBODY></TABLE>
<P align=center><INPUT onclick="javascript:return check();" type=submit value=" ȷ �� " name=Ok>&nbsp;&nbsp;
<INPUT onclick=javascript:goto(); type=button value=�����б� name=golist>
</P>
</FORM></CENTER></BODY></HTML>
