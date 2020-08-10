<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.program.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=utf-8"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=系统超时，请重新登陆!"));
    return;
  }

  int id = ParamUtil.getIntParameter(request, "id", -1);
  int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
  int errcode = 0;

  IProgramManager programMgr = ProgramPeer.getInstance();
  Program program = programMgr.getAPrograms(id);
  if(startflag == 1){
    errcode = programMgr.removeProgram(id);
    if (errcode < 0) {
      response.sendRedirect("pmanager.jsp");
      return;
    } else {
      response.sendRedirect(response.encodeRedirectURL("closewin.jsp"));
      return;
    }
  }
%>
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="GENERATOR" content="Microsoft FrontPage 4.0">
  <meta name="ProgId" content="FrontPage.Editor.Document">
  <link href="/images/common.css" rel=stylesheet>
  <title>程序管理</title>
</head>

<body>
<table cellSpacing="0" cellPadding="0" width="770" border="0" align=center>
  <tr><td>
    <p class=line>删除程序模块 <b><%=StringUtil.gb2iso4View(program.getNotes())%></b> ?<p>
    <ul class=cur>警告: 此操作将删除该程序模块，您真的想删除吗?</ul>
    <form name="leavewordForm" method="post" action="premove.jsp">
      <input type="hidden" name="startflag" value="1">
      <input type="hidden" name="id" value="<%=id%>">
      <input type=image src="../images/button_dele.gif">
      &nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript:history.back();"><img src="../images/button_cancel.gif" border=0></a>
    </form>
  </td></tr>
</table>
</body>
</html>