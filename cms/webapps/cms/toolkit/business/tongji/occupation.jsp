<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.search.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
  int range               = ParamUtil.getIntParameter(request, "range", 20);
  String userid = authToken.getUserID();
  int siteid = 1;

  ISearchManager searchMgr = SearchPeer.getInstance();
  List list = new ArrayList();
  list = searchMgr.getTongJi2(1);
%>
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<meta http-equiv="Pragma" content="no-cache">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "ͳ�ƹ���", "" }
          };

      String[][] operations = {
              { "����ע����", "usermanager.jsp" },
              { "����ͳ��", "city.jsp" },
              { "ְҵͳ��", "occupation.jsp" },
              { "ѧ��ͳ��", "education.jsp" },
              { "�Ķ���Ȥͳ��", "read.jsp" },
              { "�ղ���Ȥͳ��", "save.jsp" }
      };
%>
<%@ include file="../inc/titlebar2.jsp" %>
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="80%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">ְҵͳ��</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">ְҵ����</td>
                  <td width="20%" align="center">ע������</td>
                </tr>
              <%
              for(int i=0;i<list.size();i++){
                String temp = (String)list.get(i);
                String occupation = "";
                String num = "";
                num = temp.substring(0, temp.indexOf(","));
                occupation = temp.substring(temp.indexOf(",")+1, temp.length());
                if((occupation != "")&&(occupation != null)&&(!occupation.equals("null"))){
              %>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center"><%=occupation==null?"":new String(occupation.getBytes("iso8859_1"),"GBK")%></td>
                  <td width="20%" align="center"><%=num%></td>
                </tr>
              <%}}%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</center>
</body>
</html>
