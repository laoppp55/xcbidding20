<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.webapps.survey.define.Define" %>
<%@ page import="com.bizwink.webapps.survey.define.IDefineManager" %>
<%@ page import="com.bizwink.webapps.survey.define.DefinePeer" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page contentType="text/html;charset=GBK" %>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
  int range = ParamUtil.getIntParameter(request, "range", 20);
  int success = ParamUtil.getIntParameter(request, "success", 0);
    int siteid = authToken.getSiteID();

  IDefineManager defineMgr = DefinePeer.getInstance();
  List currentlist = new ArrayList();
  String msg;
  switch (success) {
    case 1:
      msg = "������ӳɹ�";
      break;
    case 2:
      msg = "����ɾ���ɹ�";
      break;
    case 3:
      msg = "�����޸ĳɹ�";
      break;
    default:
      msg = "";
      break;
  }

  int rows = 0;
  int totalpages = 0;
  int currentpage = 0;

  currentlist = defineMgr.getAllDefineSurvey(siteid,startrow, range);
  rows = defineMgr.getAllDefineSurveyNum(siteid);

  if (rows < range) {
    totalpages = 1;
    currentpage = 1;
  } else {
    if (rows % range == 0)
      totalpages = rows / range;
    else
      totalpages = rows / range + 1;

    currentpage = startrow / range + 1;
  }
%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
  <title>�������</title>
  <style type="text/css">
    <!--
    body {
      margin-top: 0px;
      margin-bottom: 0px;
    }
    -->
  </style>
  <link href="images/css.css" rel="stylesheet" type="text/css"/>
  <script type="text/javascript">
    function DeleteSurvey(ID)
    {
      var str = confirm("ȷ��Ҫɾ�����������ɾ�������ڸõ�������⼰�𰸽�һ��ɾ����");
      if (str)
        window.location = "deleteSurvey.jsp?sid=" + ID;
    }

    function Pop_Vote(ID)
    {
      window.open("display.jsp?ID=" + ID, "Display", "left=200,top=150,width=400,height=400");
    }
    function golist(r){
      window.location = "index.jsp?startrow="+r;
    }
    function upflag(id,flag){
        var flags;
        if(flag == 0){
            flags = 1;
        }
        if(flag == 1){
            flags = 0;
        }
        var val;
        val = confirm("��ȷ��������Ч��־��");
        if(val == 1){
             window.location = "flag.jsp?startflag=1"+"&flag="+flags+"&id="+id;
        }
    }
  </script>
</head>

<body>
<center>
<table width="900" border="0" cellpadding="0" cellspacing="0" class="bian">
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/></td>
        <td width="100" class="black12c">�������</td>
        <td width="550"></td>
        <td width="30" align="center"><img src="images/hb_01.jpg" width="11" height="7"/></td>
        <td width="100" class="black12c"><a
                href="addSurvey.jsp"><b>����µ���</b></a></td>
        <td width="30" align="center"><img src="images/lv_01.jpg" width="11" height="7"/></td>
        <td width="37" class="black12c"><a href="../index.jsp">����</a></td>
      </tr>
    </table>
  </td>
</tr>
<tr>
  <td height="1" bgcolor="#898898"></td>
</tr>
<tr>
  <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50" height="30" align="center" bgcolor="#F6F5F0" class="black12c">���</td>
        <td width="1" bgcolor="#898898"></td>
        <td width="200" align="center" bgcolor="#F6F5F0" class="black12c">����</td>
        <td width="1" bgcolor="#898898"></td>
        <td width="200" align="center" bgcolor="#F6F5F0" class="black12c">����</td>
        <td width="1" bgcolor="#898898"></td>
        <td width="75" align="center" bgcolor="#F6F5F0" class="black12c">����ʱ��</td>
          <td width="1" bgcolor="#898898"></td>
        <td width="75" align="center" bgcolor="#F6F5F0" class="black12c">�Ƿ���Ч</td>
        <td width="1" bgcolor="#898898"></td>
        <td width="300" align="center" bgcolor="#F6F5F0" class="black12c">����</td>
      </tr>

    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <%
        if (currentlist != null) {
          for (int i = 0; i < currentlist.size(); i++) {
            Define define = (Define) currentlist.get(i);
            int id = define.getId();
            String surveyname = define.getSurveyname();
            String notes = define.getNotes();
            Timestamp createtime = define.getCreatetime();

      %>
      <tr>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
          <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
      </tr>
      <tr>
        <td width="50" height="30" align="center" class="black12"><%=i + 1%>
        </td>
        <td width="1" bgcolor="#898898"></td>
        <td width="200" align="center" class="black12"><%=StringUtil.iso2gb(surveyname)%>
        </td>
        <td width="1" bgcolor="#898898"></td>
        <td width="200" align="center" class="black12"><%=StringUtil.iso2gb(notes)%>
        </td>
        <td width="1" bgcolor="#898898"></td>
        <td width="75" align="center" class="black12"><%=createtime.toString().substring(0, 19)%>
        </td>
        <td width="1" bgcolor="#898898"></td>
          <td width="75" align="center" class="black12"><a href="javascript:upflag(<%=id%>,<%=define.getUserflag()%>);"><%if(define.getUserflag()==0){%>��Ч<%}else{%>��Ч<%}%></a>
        </td>
        <td width="1" bgcolor="#898898"></td>
        <td width="300" align="center" class="black12">
          <a title="����������ӡ��޸ġ�ɾ������" href="addQuestion.jsp?sid=<%=id%>">����</a>
          <a title="ɾ������" href="javascript:DeleteSurvey('<%=id%>')">ɾ��</a>
          <a title="�޸ĵ���" href="updateSurvey.jsp?sid=<%=id%>">�޸�</a>
          <a title="����Ԥ������" href="viewSurvey.jsp?sid=<%=id%>">����Ԥ��</a>
          <a title="����Ԥ������" href="viewHSurvey.jsp?sid=<%=id%>"
             target=_blank>����Ԥ��</a><br>
          <a title="�鿴ͶƱ���" href="viewResult.jsp?sid=<%=id%>"
             target=_blank>ͶƱ���</a>
         <%-- <a title="��ѯͶƱ��" href="../result/index.jsp?sid=<%=id%>" target=_blank>��ѯͶƱ��</a>--%>
        </td>
      </tr>
      <%
          }
        }
      %>
    </table>
  </td>
</tr>
<tr>
  <td height="1" bgcolor="#898898"></td>
</tr>
<tr>
  <td height="40" align="right" class="black12">
    ����<%=rows%>����¼&nbsp;&nbsp;��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
    &nbsp;&nbsp;&nbsp;&nbsp;
    <%
      if ((startrow - range) >= 0) {
    %>
    [<a href="index.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
    <%}%>
    <%
      if ((startrow + range) < rows) {
    %>
    [<a href="index.jsp?startrow=<%=startrow+range%>">��һҳ</a>]
    <%
      }
      if (totalpages > 1) {
    %>
    &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
          <a href="###" onclick="golist((document.all('jump').value-1)*<%=range%>);">GO</a>
  <%}%>
</td>
</tr>
</table>
</td>
</tr>
</table>
</center>
</body>
</html>
