<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect( "../login.jsp" );
    return;
  }
  if (authToken.getUserID().compareToIgnoreCase("admin") != 0)
  {
    request.setAttribute("message","��ϵͳ����Ա��Ȩ��");
    response.sendRedirect("../index.jsp");
    return;
  }

  IRegisterManager regMgr = RegisterPeer.getInstance();
  List siteList = regMgr.getNotBindSite();
  int siteCount = siteList.size();
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language="javascript">
function edit_window(param)
{
  window.open("editSite.jsp?"+param,"","top=0,left=0,width=500,height=640,resizable=no,status=no,toolbar=no,menubar=no,location=no");
}
</script>
</head>
<body>
<%
  String[][] titlebars = {
    { "", "../main.jsp" },
    { "�����������", "" }
  };
  String [][] operations = {
    {"վ�����","siteManage.jsp"}
  };
%>
<%@ include file="../inc/titlebar.jsp" %>
<font class=line>վ���б�</font>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
<tr bgcolor="#eeeeee" class=tine>
<td width="18%" align=center class="listHeader"><b>վ������</b></td>
<td width="30%" align=center>��ҵ����</td>
<td width="13%" align=center>ͼ��洢</td>
<td width="15%" align=center>����</td>
<td width="8%" align=center>�޸�</td>
<td width="8%" align=center>ɾ��</td>
<td width="8%" align=center>����</td>
</tr>
<%
  for (int i=0; i<siteCount; i++)
  {
    Register register = (Register)siteList.get(i);

    int SiteID = register.getSiteID();
    String SiteName = register.getSiteName();
    int imgflag = register.getImagesDir();
    int tcflag = register.getTCFlag();
    String CorpName = register.getCorpName();
    CorpName = StringUtil.gb2iso4View(CorpName);
%>
<tr bgcolor="#ffffff" class=line>
<td align=left>&nbsp;&nbsp;<b><%=SiteName%></b></td>
<td align=left>&nbsp;&nbsp;<b><%=(CorpName==null)?"":CorpName%></b></td>
<td align=center><%if(imgflag==0){%>��Ŀ¼Images��<%}else if(imgflag==1){%>����ĿImages��<%}else{%>&nbsp;<%}%></td>
<td align=center><%if(tcflag==0){%>��<%}else if(tcflag==1){%>��<%}else{%>&nbsp;<%}%></td-->
<td align="center"><input type="radio" name="action" onclick='edit_window("siteid=<%=SiteID%>")'></td>
<td align="center"><input type="radio" name="action" onclick="location.href='removeSite.jsp?type=3&siteid=<%=SiteID%>&dname=<%=SiteName%>';"></td>
<td align="center"><input type="radio" name="action" onclick="location.href='pauseSite.jsp?type=3&siteid=<%=SiteID%>&dname=<%=SiteName%>';"></td>
</tr>
<% }%>
</body>
</table>
</html>