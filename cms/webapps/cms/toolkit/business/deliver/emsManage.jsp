<%@ page import="java.util.*,
                 com.bizwink.cms.business.deliver.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if( authToken == null )
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  IDeliverManager deliverMgr = DeliverPeer.getInstance();
  String act = ParamUtil.getParameter(request, "act");
  if (act == null)  act = "";
  if (act.equals("doCreate"))
  {
    String corpName = ParamUtil.getParameter(request, "corpName");
    if (corpName != null && corpName.length() > 0)
    {
      deliverMgr.createExpCorp(corpName);
    }
  }
  else if (act.equals("doUpdate"))
  {
    int corpID = ParamUtil.getIntParameter(request, "ID", 0);
    String corpName = ParamUtil.getParameter(request, "corpName");
    if (corpName != null && corpName.length() > 0)
    {
      deliverMgr.updateExpCorp(corpID, corpName);
    }
  }
  else if (act.equals("doDelete"))
  {
    int corpID = ParamUtil.getIntParameter(request, "ID", 0);
    deliverMgr.deleteExpCorp(corpID);
  }
  if (act.length() > 0)
  {
    response.sendRedirect("emsManage.jsp");
  }

  List list = deliverMgr.getExpCorpList();
%>

<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language=javascript>
function Delete(corpID)
{
  var ret = confirm("���Ҫɾ����");
  if (ret)
    window.location = "emsManage.jsp?ID="+corpID+"&act=doDelete";
}

function Update(corpID)
{
  var corpName = document.all("corp" + corpID).value;
  window.location = "emsManage.jsp?ID="+corpID+"&act=doUpdate&corpName="+corpName;
}
</script>
</head>
<%
  String[][] titlebars = {
    { "�ͻ���ʽ����", "" },
    { "��ݹ�˾", "" }
  };
  String[][] operations = {
    {"<a href=provManage.jsp>ʡ�й���</a>", ""},
    {"<a href=postManage.jsp>��������</a>", ""}
  };
%>
<body>
<%@ include file="../inc/titlebar.jsp" %>
<p align=center style="font-size:9pt"><b>��ݹ�˾����</b></p>
<TABLE cellSpacing=1 cellPadding=0 width="70%" align=center bgColor=#000000 border=0 align="center">
    <tr bgColor=#ffffff>
      <td align="center" width="10%" height="18">��˾ID</td>
      <td align="center" width="50%" height="18">��ݹ�˾����</td>
      <td align="center" width="20%" height="18">����</td>
      <td align="center" width="20%" height="18">��ϸ</td>
    </tr>
<%
  for (int i=0; i<list.size(); i++)
  {
    String temp = (String)list.get(i);
    String color = (i % 2 == 0) ? "eeeeee" : "ffffff";
    int corpID = Integer.parseInt(temp.substring(0,temp.indexOf(",")));
    String corpName = StringUtil.gb2iso4View(temp.substring(temp.indexOf(",")+1));
%>
    <tr bgColor=#<%=color%> height="26">
      <td align="center"><%=corpID%></td>
      <td align="center"><input type=text name="corp<%=corpID%>" size=16 value="<%=corpName%>"></td>
      <td align="center"><a href="javascript:Update(<%=corpID%>);">�޸�</a>&nbsp;&nbsp;&nbsp;<a href="javascript:Delete(<%=corpID%>);">ɾ��</a></td>
      <td align="center"><a href="emsFeeManage.jsp?corpID=<%=corpID%>">��ϸ</a></td>
    </tr>
<%}%>
    <tr bgColor=#ffffff>
      <td colspan="4" height="60" align="center">
      <form action="emsManage.jsp" method="Post" name=createForm>
      <input type=hidden name=act value=doCreate>
      <input type=text name=corpName size=20>&nbsp;&nbsp;<input type=submit value="  ���  ">
      </form>
      </td>
    </tr>
</table>
</body>
</html>