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
  Deliver deliver = new Deliver();
  deliver.setCityType(1);

  String act = ParamUtil.getParameter(request, "act");
  if (act == null)  act = "";
  if (act.equals("doCreate"))
  {
    String provname = ParamUtil.getParameter(request, "provname");
    if (provname != null && provname.length() > 0)
    {
      float emfee = ParamUtil.getFloatParameter(request, "emsfee", 0);
      deliver.setProvName(provname);
      deliver.setEmsFee(emfee);
      deliverMgr.create(deliver);
    }
  }
  else if (act.equals("doUpdate"))
  {
    int provID = ParamUtil.getIntParameter(request, "ID", 0);
    String provname = ParamUtil.getParameter(request, "provName");
    if (provname != null && provname.length() > 0)
    {
      float emsfee = ParamUtil.getFloatParameter(request, "emsfee", 0);
      int orderID = ParamUtil.getIntParameter(request, "orderID", 0);
      deliver.setProvID(provID);
      deliver.setProvName(provname);
      deliver.setOrderID(orderID);
      deliver.setEmsFee(emsfee);
      deliverMgr.update(deliver);
    }
  }
  else if (act.equals("doDelete"))
  {
    int provID = ParamUtil.getIntParameter(request, "ID", 0);
    deliver.setProvID(provID);
    deliverMgr.delete(deliver);
  }
  if (act.length() > 0)
  {
    response.sendRedirect("provManage.jsp");
  }

  List list = deliverMgr.getCityList(deliver);
%>

<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language=javascript>
function Delete(provID)
{
  var ret = confirm("���Ҫɾ����");
  if (ret)
    window.location = "provManage.jsp?ID="+provID+"&act=doDelete";
}

function Update(provID)
{
  var provName = document.all("prov" + provID).value;
  var orderID = document.all("order" + provID).value;
  var emsFee = document.all("ems" + provID).value;
  window.location = "provManage.jsp?ID="+provID+"&act=doUpdate&provName="+provName+"&orderID="+orderID+"&emsfee="+emsFee;
}
</script>
</head>
<%
  String[][] titlebars = {
    { "�ͻ���ʽ����", "" },
    { "ʡ�й���", ""}
  };

  String[][] operations = {
    {"<a href=postManage.jsp>��������</a>", ""},
    {"<a href=emsManage.jsp>��ݹ�˾</a>", ""}
  };
%>
<%@ include file="../inc/titlebar.jsp" %>
<p align=center style="font-size:9pt"><b>ʡ�ݹ���</b></p>
<TABLE cellSpacing=1 cellPadding=0 width="70%" align=center bgColor=#000000 border=0 align="center">
    <tr bgColor=#ffffff>
      <td align="center" width="10%" height="18">ʡ��ID</td>
      <td align="center" width="20%" height="18">ʡ������</td>
      <td align="center" width="10%" height="18">���</td>
      <td align="center" width="20%" height="18">EMS����</td>
      <td align="center" width="20%" height="18">����</td>
      <td align="center" width="20%" height="18">��ϸ</td>
    </tr>
<%
  for (int i=0; i<list.size(); i++) {
    deliver = (Deliver)list.get(i);
    String color = (i % 2 == 0) ? "eeeeee" : "ffffff";
    int ID = deliver.getProvID();
    int orderID = deliver.getOrderID();
    float emsFee = deliver.getEmsFee();
    String provName = StringUtil.gb2iso4View(deliver.getProvName());
%>
    <tr bgColor=#<%=color%> height="26">
      <td align="center"><%=ID%></td>
      <td align="center"><input type=text name="prov<%=ID%>" size=16 value="<%=provName%>"></td>
      <td align="center"><input type=text name="order<%=ID%>" size=16 value="<%=orderID%>"></td>
      <td align="center"><input type=text name="ems<%=ID%>" size=16 value="<%=emsFee%>"></td>
      <td align="center"><a href="javascript:Update(<%=ID%>);">�޸�</a>&nbsp;&nbsp;&nbsp;<a href="javascript:Delete(<%=ID%>);">ɾ��</a></td>
      <td align="center"><a href="cityManage.jsp?provID=<%=ID%>">��ϸ</a></td>
    </tr>
<%}%>
    <tr bgColor=#ffffff>
      <td colspan="6" height="60" align="center">
      <form action="provManage.jsp" method="Post" name=createForm>
      <input type=hidden name=act value=doCreate>
      ʡ�����ƣ�<input type=text name=provname size=20>&nbsp;&nbsp;
      EMS���ã�<input type=text name=emsfee size=10>&nbsp;&nbsp;
      <input type=submit value="  ���  ">
      </form>
      </td>
    </tr>
</table>

</BODY>
</html>