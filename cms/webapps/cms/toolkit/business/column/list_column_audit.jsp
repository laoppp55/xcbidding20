<%@ page import = "java.io.*,
		   java.util.*,
		   java.sql.Timestamp,
		   com.bizwink.cms.util.*,
		   com.bizwink.cms.server.*,
		   com.bizwink.cms.security.*,
		   com.bizwink.cms.audit.*"
		   contentType = "text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if(authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  int ID = ParamUtil.getIntParameter(request, "ID", 0);
  int columnID = ParamUtil.getIntParameter(request, "columnID", -1);
  IAuditManager auditManager = AuditPeer.getInstance();

  //ɾ��������¼
  if (ID != 0)
  {
    try
    {
      auditManager.Del_Column_AuditRules(ID);
    }
    catch (CmsException e)
    {
      e.printStackTrace();
    }
    return;
  }

  //�������й���
  List rulesList = null;
  int rulesCount = 0;

  rulesList = auditManager.getAll_AuditRules(columnID);
  rulesCount = rulesList.size();

  //�ж�Ĭ�ϵĹ����Ƿ������֮��,����,�����޸�,ɾ���͸ı�Ĭ��
  boolean isAudited = auditManager.Query_Column_isAudited(columnID);
%>

<html>
<head>
<title>�޸���Ŀ��˹���</title>
<meta http-equiv="Pragma" content="no-cache">
<link rel=stylesheet type="text/css" href="../style/global.css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function window_close()
{
  window.returnValue = "close";
  window.close();
}

function Del_Audit_Rules(ID)
{
  var bln = confirm("���Ҫɾ����");
  if (bln)
  {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST","list_column_audit.jsp?columnID=<%=columnID%>&ID="+ID,false);
    objXml.Send();
    window.returnValue = "ok";
    window.close();
  }
}

function window_IsDefault(columnID)
{
  var i = 0;
  var k;
  var sign = false;

  var len = form1.isDefault.length;
  if (len == undefined)
    len = 1;

  if (len == 1)
  {
    if (form1.isDefault.checked)
    {
      k = form1.isDefault.value;
      sign = true;
    }
  }
  else if (len > 1)
  {
    do
    {
      if (form1.isDefault[i].checked)
      {
        k = form1.isDefault[i].value;
        sign = true;
      }
      i++;
    }while (i<form1.isDefault.length);
  }

  if (sign == false)
  {
    alert("��ѡ��Ĭ����˹���");
  }
  else
  {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST","default_column_audit.jsp?ID="+k+"&columnID="+columnID,false);
    objXml.Send();
  }
}
</script>
</head>

<body bgcolor="#D6D3CE">
<form action="" method="post" name=form1 id=form1>
<br>
<table border="1" width="95%" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" align=center>
  <tr height="22">
    <td width="7%"  align="center" bgcolor="#C0C0C0"><b>���</b></td>
    <td width="54%" align="center" bgcolor="#C0C0C0"><b>��������</b></td>
    <td width="18%" align="center" bgcolor="#C0C0C0"><b>����ʱ��</b></td>
    <td width="7%"  align="center" bgcolor="#C0C0C0"><b>�޸�</b></td>
    <td width="7%"  align="center" bgcolor="#C0C0C0"><b>ɾ��</b></td>
    <td width="7%"  align="center" bgcolor="#C0C0C0"><b>Ĭ��</b></td>
  </tr>
  <%
  for (int i=0; i<rulesCount; i++)
  {
    Audit audit = (Audit)rulesList.get(i);

    String auditRules = audit.getAuditRules();
    Timestamp createDate = audit.getCreateDate();
    ID = audit.getID();
    columnID = audit.getColumnID();
    int isDefault = Integer.parseInt(audit.getIsDefault());
  %>
  <tr>
    <td align="center"><%=i + 1%></td>
    <td align="center"><%=auditRules%></td>
    <td align="center"><%=createDate.toString().substring(0,10)%></td>
    <td align="center">
    	<%if (isAudited && isDefault == 1){%>
    	<img src="../images/edit.gif" border="0">
    	<%}else{%>
    	<a href=# onclick=javascript:window.open("update_column_audit.jsp?columnID=<%=columnID%>&ID=<%=ID%>&auditRules=<%=auditRules.trim().replace(' ','+')%>","column_open","left=100,top=100,width=450,height=350")><img src="../images/edit.gif" border="0"></a>
    	<%}%>
    </td>
    <td align="center">
	<%if (isAudited && isDefault == 1){%>
	<img src="../images/del.gif" border="0">
	<%}else{%>
    	<a href=# onclick="javascript:Del_Audit_Rules('<%=ID%>')"><img src="../images/del.gif" border="0"></a>
    	<%}%>
    </td>
    <td align="center">
	<%if (isAudited){%>
	<input type="radio" name="isDefault" value="<%=ID%>" <%if(isDefault == 1){%>checked<%}%> disabled>
	<%}else{%>
    	<input type="radio" name="isDefault" value="<%=ID%>" <%if(isDefault == 1){%>checked<%}%>>
    	<%}%>
    </td>
  </tr>
  <%}%>
</table>
<br>
<center>
    <%if (isAudited || rulesCount < 1){%>
    <input type="button" name="column_isDefault" value="��ΪĬ��" disabled>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%}else{%>
    <input type="button" name="column_isDefault" value="��ΪĬ��" onclick="javascript:window_IsDefault('<%=columnID%>');">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%}%>
    <input type="button" name=column_close 	value=" ȡ  �� "  onclick="javascript:window_close()">
</center>
<br>
<%if (isAudited){%>
&nbsp;&nbsp;&nbsp;<font color=red><b>����Ŀ��Ĭ�Ϲ������ڱ����֮�У����Բ����޸ġ�ɾ��<br>&nbsp;&nbsp;&nbsp;��ı�Ĭ�Ϲ���</b></font>
<%}%>
</form>

</body>
</html>
