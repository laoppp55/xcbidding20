<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.sitesetting.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK"%>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    if (authToken.getUserID().compareToIgnoreCase("admin") != 0) {
        request.setAttribute("message", "��ϵͳ����Ա��Ȩ��");
        response.sendRedirect("../index.jsp");
        return;
    }

    ISiteInfoManager siteMgr = SiteInfoPeer.getInstance();
    int siteid = ParamUtil.getIntParameter(request, "site", 0);
    boolean doupdate = ParamUtil.getBooleanParameter(request,"doUpdate");
    int startnum = ParamUtil.getIntParameter(request, "startnum", 0);
    String userid = authToken.getUserID();
    SiteInfo siteInfo = siteMgr.getSiteInfo(siteid);
    String sitename = siteInfo.getDomainName();
    int sitetype = siteInfo.getValidFlag();
    if (doupdate == true) {
        sitetype = ParamUtil.getIntParameter(request,"stype",0);
        siteMgr.updatesitevalid(siteid,sitetype);
        out.println("<script language=\"javascript\">");
        out.println("window.opener.location='siteManage.jsp?startnum=" + startnum + "';");
        out.println("window.close();");
        out.println("</script>");
    }
%>
<html>
  <head>
      <title>����վ������</title>
      <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
      <link rel="stylesheet" type="text/css" href="../style/global.css">
      <script language="javascript">

      </script>
  </head>
  <body>
  <form action="#" name="sitetype" method="post">
      <input type="hidden" name="doUpdate" value="true">
      <input type="hidden" name="sitename" value="<%=sitename%>">
      <input type="hidden" name="userid" value="<%=userid%>">
      <input type="hidden" name="siteid" value="<%=siteid%>">
      <input type="hidden" name="startnum" value="<%=startnum%>">
  <table cellpadding="0" border="0" width="100%">
      <tr>
          <td>��������վ���ͣ� </td>
          <td><%=sitename%></td>
      </tr>
      <tr><td colspan="2">
          <input type="radio" name="stype" id="stypeid0" value="1" <%=(sitetype == 1)?"checked":""%>>��ͨվ��
          <input type="radio" name="stype" id="stypeid1" value="0" <%=(sitetype == 0)?"checked":""%>>����վ��
          <input type="radio" name="stype" id="stypeid2" value="2" <%=(sitetype == 2)?"checked":""%>>����վ��
      </td></tr>
      <tr><td><input type="submit" name="ok" value="�ύ"> </td><td><input type="button" name="cancel" value="����" onclick="javascript:window.close();"> </td></tr>
  </table>
  </form>
  </body>
</html>