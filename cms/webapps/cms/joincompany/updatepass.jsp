<%@ page import="java.util.*,
		             com.bizwink.cms.util.*,
		             com.bizwink.cms.audit.*,
                 com.bizwink.cms.security.*"
                 contentType="text/html;charset=gbk"
%>

<%


	String userID = ParamUtil.getParameter(request, "name");
	int type = ParamUtil.getIntParameter(request, "type", 0);
	boolean doUpdate = ParamUtil.getBooleanParameter(request, "doUpdate");

	if (doUpdate)
	{
		String pass = ParamUtil.getParameter(request, "pass1");
		IAuditManager auditMgr = AuditPeer.getInstance();
		auditMgr.updatePassword(userID, pass);
        System.out.println("userID="+userID+"  pass="+pass);
        if (type == 1)
			out.write("<script>window.close();</script>");
		else
			out.write("<script>window.close();</script>");
		return;
	}
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<%
	String[][] titlebars = {
		{ "�޸�����", "" }
	};
	String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>

<p>
&nbsp;&nbsp;&nbsp;<font class=tine>�޸��û� <b><%= userID%></b>&nbsp;������</font>
<p>

<form action="updatepass.jsp" name="updateForm" onsubmit="javascript:return CheckPass();">
<input type="hidden" name="doUpdate" value="true">
<input type="hidden" name="name" value="<%=userID%>">
<input type="hidden" name="type" value="<%=type%>">
&nbsp;&nbsp;
<font class=tine>�����������룺</font><input type="password" name="pass1" size=12 class=tine>
<br><br>
&nbsp;&nbsp;
<font class=tine>�ٴ��������룺</font><input type="password" name="pass2" size=12 class=tine>
<br><br><br>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" value=" ȷ�� ">&nbsp;&nbsp;
<%if (type == 1){%>
<input type="button" value=" ȡ�� " onclick="location.href='sitlist.jsp';return false;">
<%}else{%>
<input type="button" value=" ȡ�� " onclick="location.href='sitlist.jsp';return false;">
<%}%>
</form>

<script language="JavaScript">
function CheckPass()
{
    if (document.updateForm.pass1.value == "" || document.updateForm.pass2.value == "")
    {
    	alert("���벻��Ϊ��");
    	return false;
    }
    else if (document.updateForm.pass1.value != document.updateForm.pass2.value)
    {
    	alert("������������벻��ͬ");
    	return false;
    }
    else
    {
    	return true;
    }
}
</script>

</body>
</html>
