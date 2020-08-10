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
  list = searchMgr.getLikeTongJi(1);
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
            <td class="moduleTitle"><font color="#48758C">�ղ���Ȥͳ��</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">�ղ���Ȥ</td>
                  <td width="20%" align="center">ͳ������</td>
                </tr>
              <%
              int guji = 0;
              int qianmingben = 0;
              int xinwenxue = 0;
              int wenxian = 0;
              int xinzha = 0;
              int huagao = 0;
              int huace = 0;
              int lianhuanhua = 0;
              int chuangkanhao = 0;
              int ditu = 0;
              int yinpu = 0;
              int baokan = 0;
              int minguoshu = 0;
              int beitie = 0;

              for(int i=0;i<list.size();i++){
                String temp = (String)list.get(i);
                if((temp != "")&&(temp != null)){
                  temp = new String(temp.getBytes("iso8859_1"), "GBK");
                }
                if(temp.indexOf("�ż�") != -1){
                  guji = guji + 1;
                }
                if(temp.indexOf("ǩ����") != -1){
                  qianmingben = qianmingben + 1;
                }
                if(temp.indexOf("����ѧ") != -1){
                  xinwenxue = xinwenxue + 1;
                }
                if(temp.indexOf("��������") != -1){
                  wenxian = wenxian + 1;
                }
                if(temp.indexOf("����") != -1){
                  xinzha = xinzha + 1;
                }
                if(temp.indexOf("�ָ廭��") != -1){
                  huagao = huagao + 1;
                }
                if(temp.indexOf("����") != -1){
                  huace = huace + 1;
                }
                if(temp.indexOf("������") != -1){
                  lianhuanhua = lianhuanhua + 1;
                }
                if(temp.indexOf("������") != -1){
                  chuangkanhao = chuangkanhao + 1;
                }
                if(temp.indexOf("��ͼ") != -1){
                  ditu = ditu + 1;
                }
                if(temp.indexOf("ӡ��") != -1){
                  yinpu = yinpu + 1;
                }
                if(temp.indexOf("����") != -1){
                  baokan = baokan + 1;
                }
                if(temp.indexOf("�����") != -1){
                  minguoshu = minguoshu + 1;
                }
                if(temp.indexOf("����") != -1){
                  beitie = beitie + 1;
                }
              }
              %>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">�ż�</td>
                  <td width="20%" align="center"><%=guji%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">ǩ����</td>
                  <td width="20%" align="center"><%=qianmingben%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����ѧ</td>
                  <td width="20%" align="center"><%=xinwenxue%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">��������</td>
                  <td width="20%" align="center"><%=wenxian%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����</td>
                  <td width="20%" align="center"><%=xinzha%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">�ָ廭��</td>
                  <td width="20%" align="center"><%=huagao%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����</td>
                  <td width="20%" align="center"><%=huace%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">������</td>
                  <td width="20%" align="center"><%=lianhuanhua%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">������</td>
                  <td width="20%" align="center"><%=chuangkanhao%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">��ͼ</td>
                  <td width="20%" align="center"><%=ditu%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">ӡ��</td>
                  <td width="20%" align="center"><%=yinpu%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����</td>
                  <td width="20%" align="center"><%=baokan%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">�����</td>
                  <td width="20%" align="center"><%=minguoshu%></td>
                </tr>
                <tr  bgcolor="#FFFFFF">
                  <td width="20%" align="center">����</td>
                  <td width="20%" align="center"><%=beitie%></td>
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
