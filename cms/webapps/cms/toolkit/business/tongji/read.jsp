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
  list = searchMgr.getLikeTongJi(0);
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
            <td class="moduleTitle"><font color="#48758C">�Ķ���Ȥͳ��</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">�Ķ���Ȥ</td>
                  <td width="20%" align="center">ͳ������</td>
                </tr>
              <%
              int wenxue = 0;
              int lishi = 0;
              int zhexue = 0;
              int yishu = 0;
              int yuyan = 0;
              int wenhua = 0;
              int gongjushu = 0;

              for(int i=0;i<list.size();i++){
                String temp = (String)list.get(i);
                if((temp != "")&&(temp != null)){
                  temp = new String(temp.getBytes("iso8859_1"), "GBK");
                }
                if(temp.indexOf("��ѧ") != -1){
                  wenxue = wenxue + 1;
                }
                if(temp.indexOf("��ʷ") != -1){
                  lishi = lishi + 1;
                }
                if(temp.indexOf("��ѧ") != -1){
                  zhexue = zhexue + 1;
                }
                if(temp.indexOf("����") != -1){
                  yishu = yishu + 1;
                }
                if(temp.indexOf("����") != -1){
                  yuyan = yuyan + 1;
                }
                if(temp.indexOf("�Ļ�") != -1){
                  wenhua = wenhua + 1;
                }
                if(temp.indexOf("������") != -1){
                  gongjushu = gongjushu + 1;
                }
              }
              %>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">��ѧ</td>
                  <td width="20%" align="center"><%=wenxue%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">��ʷ</td>
                  <td width="20%" align="center"><%=lishi%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">��ѧ</td>
                  <td width="20%" align="center"><%=zhexue%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����</td>
                  <td width="20%" align="center"><%=yishu%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����</td>
                  <td width="20%" align="center"><%=yuyan%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">�Ļ�</td>
                  <td width="20%" align="center"><%=wenhua%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">������</td>
                  <td width="20%" align="center"><%=gongjushu%></td>
                </tr>
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
