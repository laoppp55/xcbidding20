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

  int provID = ParamUtil.getIntParameter(request, "provID", 0);
  IDeliverManager deliverMgr = DeliverPeer.getInstance();
  Deliver deliver = new Deliver();
  deliver.setCityType(2);
  deliver.setProvID(provID);

  String act = ParamUtil.getParameter(request, "act");
  if (act == null)  act = "";
  if (act.equals("doCreate"))
  {
    String cityName = ParamUtil.getParameter(request, "cityName");
    if (cityName != null && cityName.length() > 0)
    {
      deliver.setCityName(cityName);
      deliverMgr.create(deliver);
    }
  }
  else if (act.equals("doUpdate"))
  {
    int cityID = ParamUtil.getIntParameter(request, "ID", 0);
    String cityName = ParamUtil.getParameter(request, "cityName");
    if (cityName != null && cityName.length() > 0)
    {
      int orderID = ParamUtil.getIntParameter(request, "orderID", 0);
      deliver.setCityID(cityID);
      deliver.setCityName(cityName);
      deliver.setOrderID(orderID);
      deliverMgr.update(deliver);
    }
  }
  else if (act.equals("doDelete"))
  {
    int cityID = ParamUtil.getIntParameter(request, "ID", 0);
    deliver.setCityID(cityID);
    deliverMgr.delete(deliver);
  }
  if (act.length() > 0)
  {
    response.sendRedirect("cityManage.jsp?provID="+provID);
  }

  List list = deliverMgr.getCityList(deliver);
%>

<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language=javascript>
function Delete(cityID)
{
  var ret = confirm("���Ҫɾ����");
  if (ret)
    window.location = "cityManage.jsp?ID="+cityID+"&act=doDelete&provID=<%=provID%>";
}

function Update(cityID)
{
  var cityName = document.all("city" + cityID).value;
  var orderID = document.all("order" + cityID).value;
  window.location = "cityManage.jsp?ID="+cityID+"&provID=<%=provID%>&act=doUpdate&cityName="+cityName+"&orderID="+orderID;
}
</script>
</head>
<%
  String[][] titlebars = {
    { "�ͻ���ʽ����", "" },
    { "ʡ�й���", "" }
  };
  String[][] operations = {
    {"<a href=postManage.jsp>��������</a>", ""},
    {"<a href=emsManage.jsp>��ݹ�˾</a>", ""}
  };
%>
<body>
<%@ include file="../inc/titlebar.jsp" %>

<p align=center style="font-size:9pt"><b>���й���</b></p>
<TABLE cellSpacing=1 cellPadding=0 width="70%" align=center bgColor=#000000 border=0 align="center">
    <tr bgColor=#ffffff>
      <td align="center" width="10%" height="18">����ID</td>
      <td align="center" width="30%" height="18">��������</td>
      <td align="center" width="20%" height="18">���</td>
      <td align="center" width="20%" height="18">����</td>
      <td align="center" width="20%" height="18">��ϸ</td>
    </tr>
<%
  for (int i=0; i<list.size(); i++) {
    deliver = (Deliver)list.get(i);
    String color = (i % 2 == 0) ? "eeeeee" : "ffffff";
    int ID = deliver.getCityID();
    int orderID = deliver.getOrderID();
    String cityName = StringUtil.gb2iso4View(deliver.getCityName());
%>
    <tr bgColor=#<%=color%> height="26">
      <td align="center"><%=ID%></td>
      <td align="center"><input type=text name="city<%=ID%>" size=16 value="<%=cityName%>"></td>
      <td align="center"><input type=text name="order<%=ID%>" size=16 value="<%=orderID%>"></td>
      <td align="center"><a href="javascript:Update(<%=ID%>);">�޸�</a>&nbsp;&nbsp;&nbsp;<a href="javascript:Delete(<%=ID%>);">ɾ��</a></td>
      <td align="center"><a href="zoneManage.jsp?cityID=<%=ID%>">��ϸ</a></td>
    </tr>
<%}%>
    <tr bgColor=#ffffff>
      <td colspan="5" height="60" align="center">
      <form action="cityManage.jsp" method="Post" name=createForm>
      <input type=hidden name=act value=doCreate>
      <input type=hidden name=provID value=<%=provID%>>
      <input type=text name=cityName size=20>&nbsp;&nbsp;<input type=submit value="  ���  ">
      &nbsp;&nbsp;&nbsp;&nbsp;<a href="provManage.jsp">����</a>
      </form>
      </td>
    </tr>
</table>
</BODY>
</html>