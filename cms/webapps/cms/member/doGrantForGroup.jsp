<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect( "../login.jsp?url=member/createMember.jsp" );
	  return;
  }
  if (!SecurityCheck.hasPermission(authToken, 54))
  {
    response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
    return;
  }

  int siteID = authToken.getSiteID();
  int groupID = ParamUtil.getIntParameter(request,"groupID",0);
	int rightID = ParamUtil.getIntParameter(request,"rightID",0);
  boolean doGrant = ParamUtil.getBooleanParameter(request,"doGrant");
  IRightsManager rightsManager = RightsPeer.getInstance();

  if (doGrant)
  {
    List columnList = ParamUtil.getParameterValues(request,"columnList");
    rightsManager.grantToGroup(groupID,rightID,columnList,siteID);
  }

	List rightList = rightsManager.getGrantedGroupRights(groupID,siteID);
	List columnList = new ArrayList();
	if (rightID > 0)
	  columnList = rightsManager.getGroupColumnRight(groupID,rightID);
%>

<html>
<head>
<title>�û�����Ȩ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script LANGUAGE="JavaScript" SRC="../js/check.js"></script>
<SCRIPT LANGUAGE=javascript>
function checkFrm(frm)
{
  if (frm.columnList.length > 0)
  {
    var el = form1.columnList;
    for (var i = el.options.length-1; i >=0; i--)
      el.options[i].selected = true;
  }
}

function delElement()
{
  var el = form1.columnList;
  for (var i = el.options.length-1; i >=0; i--) {
    if (el.options[i].selected) el.options[i] = null;
  }
}

function selectRight()
{
  var rightID = form1.rightList.value;
  window.location = "doGrantForGroup.jsp?groupID=<%=groupID%>&rightID="+rightID;
}
</SCRIPT>
</head>

<body bgcolor="#cccccc">
<form name="form1" method="post" action="doGrantForGroup.jsp">
<input type=hidden name=doGrant value=true>
<input type=hidden name=groupID value="<%=groupID%>">
<input type=hidden name=rightID value="<%=rightID%>">
<table width="90%" border="0" align=center>
  <tr height=35>
    <td>&nbsp;<select name="rightList" size="1" style="width:150" class=tine onchange="selectRight();">
      <option value=0>--ѡ��Ȩ��--</option>
      <%for (int i=0; i<rightList.size(); i++) {
	        Rights right = (Rights)rightList.get(i);
	        if (right.getRightID() < 50) {
      %>
      <option value="<%=right.getRightID()%>" <%if(rightID==right.getRightID()){%>selected<%}%>><%=StringUtil.gb2iso4View(right.getRightCName())%></option>
      <%}}%>
      </select>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%" border=0>
        <tr>
          <td width="65%">��Ȩ��Ŀ��<br>
            <select name="columnList" size="15" style="width:150" multiple>
            <%for (int i=0; i<columnList.size(); i++) {
	              ColumnUser column = (ColumnUser)columnList.get(i);
            %>
            <option value="<%=column.getColumnID()%>"><%=StringUtil.gb2iso4View(column.getColumnCname())%></option>
            <%}%>
            </select>
          </td>
          <td width="35%"><input type=button onclick="delElement();" value="ɾ��" class=tine></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height="40" align="center">
      <input type="submit" value=" ��Ȩ " class=tine onclick="return checkFrm(this.form);" <%if(rightID==0){%>disabled<%}%>>&nbsp;&nbsp;
      <input type="button" value=" ���� " class=tine onclick="parent.window.close();">
    </td>
  </tr>
</table>
</form>

</body>
</html>
