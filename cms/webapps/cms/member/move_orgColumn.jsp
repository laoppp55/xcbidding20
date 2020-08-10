<%@page import="java.util.*,
                java.io.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.extendAttr.*,
                com.bizwink.cms.xml.*,
                com.bizwink.cms.util.*"
                contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  String str = ParamUtil.getParameter(request,"str");

  String[] columnsName = null;
  String[] columnsID = null;

  int columnID = ParamUtil.getIntParameter(request,"column",0);
  String rootPath = request.getRealPath("/");
  String siteName = authToken.getSitename();
%>
<html>
<head>
<link rel=stylesheet type=text/css href="../style/global.css">
<SCRIPT LANGUAGE=JavaScript>
function delItem()
{
  var select = false;
  for (var i=0; i<orgForm.selectedColumn.length; i++)
  {
    if (orgForm.selectedColumn[i].selected)
    {
      select = true;
      break;
    }
  }
  if (select)
  {
    for (var i=0; i<orgForm.selectedColumn.length; i++)
    {
      if (orgForm.selectedColumn[i].selected)
        orgForm.selectedColumn[i] = null;
    }
  }
  else
  {
    alert("��ѡ����Ŀ��");
  }
}

function check(){
  var columnlist;
  var columnIDlist;
  if (orgForm.selectedColumn.length > 0)
  {
    columnIDlist = orgForm.selectedColumn.options[0].value;
    columnlist = orgForm.selectedColumn.options[0].text;
    for (var i=1; i<orgForm.selectedColumn.length; i++)
    {
      columnIDlist = columnIDlist + "," + orgForm.selectedColumn.options[i].value;
      columnlist = columnlist + "," + orgForm.selectedColumn.options[i].text;
    }
    orgForm.action="move_aimColumn.jsp?columnIDlist="+columnIDlist+"&columnlist="+columnlist;
    orgForm.submit();
    return true;
  }else{
    alert("��û��ѡ��Ҫ�ƶ�����Ŀ��");
    return false;
  }
  return ture;
}
</SCRIPT>
</head>
<body bgcolor="#CCCCCC">
<br>
<form name="orgForm" method="post" action="move_aimColumn.jsp" onSubmit="javascript:return check();">
<table>
<tr>
  <td>
          ��ѡ��Ҫ�ƶ�����Ŀ��
          <select name="selectedColumn" style="width:270" size="6" language="javascript">
          <%if (str != null){
          for (int i=0; i<columnsID.length; i++){
          if (!columnsName[i].equals("*")){%>
          <option value="<%=columnsID[i]%>"><%=StringUtil.gb2iso4View(columnsName[i])%></option>
          <%}}}%>
          </select>
          <input type="button" name="delete" value="ɾ��" onclick="delItem();">
  </td>
</tr>
</table><br><br>
<table align="center">
  <tr>
    <td>
      <input type="submit" value="��һ��">&nbsp;&nbsp;<input type="button" value="ȡ ��" name="Reset" onclick="parent.window.close()">
    </td>
  </tr>
</table>
</form>
</body>
</html>