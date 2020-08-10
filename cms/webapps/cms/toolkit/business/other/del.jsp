<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.other.*,
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

  int delflag = ParamUtil.getIntParameter(request, "delflag", 0);
  IOtherManager otherMgr = OtherPeer.getInstance();
  Other other = new Other();
  List list = new ArrayList();

    Timestamp createdate= null;
  if(delflag == 0){

    list = otherMgr.listZhuanTi();
  }
  if(delflag == 1){
    int id         = ParamUtil.getIntParameter(request, "id" ,0);
    otherMgr.delZhuanTi(id);
    otherMgr.SetZhuanTi(id);
    response.sendRedirect("del.jsp");
  }
%>
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href=../style/global.css>
<script language="javascript">
  function delzt(id){
    var val;
    val = confirm("��ȷ��Ҫɾ�����ר����");
    if(val){
      window.location = "del.jsp?id="+id+"&delflag=1";
    }
  }

  function updatezt(id){
    window.location = "edit.jsp?id="+id;
  }
</script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
      String[][] titlebars = {
              { "��ҳ", "" },
              { "ͼ��ר���ػݹ���", "index.jsp" },
              { "ר�����", "" }
          };

      String[][] operations = {
              { "�����ר��", "add.jsp" },
              {"ר�����","del.jsp"}
          };
%>
<%@ include file="../inc/titlebar.jsp" %>
<form method="post" action="dozhuanti.jsp" name="zhuantiForm">
  <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="100%">
    <tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">ͼ��ר�����</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="2" cellspacing="1">
                <tr  bgcolor="#FFFFFF">
                  <td align="center">ר����</td>
                  <td align="center">ר������</td>
                  <td align="center">��������</td>
                  <td align="center">ɾ��ר��</td>
                  <td align="center">�޸�ר��</td>
                </tr>
                <%
                for(int i=0;i<list.size();i++){
                  int id                     = 0;
                  String ztname              = "";
                  String ztdesc              = "";
                  other = (Other)list.get(i);
                  id = other.getID();
                  ztname = other.getZTName();
                  ztname = ztname==null?"":new String(ztname.getBytes("iso8859_1"),"GBK");
                  ztdesc = other.getZTDesc();
                  ztdesc = ztdesc==null?"":new String(ztdesc.getBytes("iso8859_1"),"GBK");
                  createdate = other.getCreateDate();
                %>
                <tr  bgcolor="#FFFFFF">
                  <td align="center"><%=ztname%></td>
                  <td align="center"><%=ztdesc%></td>
                  <td align="center"><%=String.valueOf(createdate).substring(0,19)%></td>
                  <td align="center"><a href="javascript:delzt('<%=id%>');">ɾ��</a></td>
                  <td align="center"><a href="javascript:updatezt('<%=id%>');">�޸�</a></td>
                </tr>
                <%}%>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</center>
</body>
</html>
