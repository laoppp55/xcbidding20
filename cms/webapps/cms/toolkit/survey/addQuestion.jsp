<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.survey.define.IDefineManager" %>
<%@ page import="com.bizwink.webapps.survey.define.DefinePeer" %>
<%@ page import="com.bizwink.webapps.survey.define.Define" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.webapps.survey.define.DefineException" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page contentType="text/html;charset=GBK" %>

<%

    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  int sid = ParamUtil.getIntParameter(request, "sid", -1);
  int qid = ParamUtil.getIntParameter(request, "qid", -1);
  int startflag = ParamUtil.getIntParameter(request, "startflag", -1);

  IDefineManager defineMgr = DefinePeer.getInstance();
  Define define = new Define();

  List list = new ArrayList();
  String qname = "";
  String surveyname = "";
  String notes = "";
  int qtype = 1;
  int qmust = 1;
  int nother = 0;
  int atype = 1;

  if (startflag == 1) {
    qname = ParamUtil.getParameter(request, "qname");
    qtype = ParamUtil.getIntParameter(request, "qtype", 1);
    qmust = ParamUtil.getIntParameter(request, "qmust", 1);
    nother = ParamUtil.getIntParameter(request, "nother", 0);
    atype = ParamUtil.getIntParameter(request, "atype", 1);

    if (qid == -1) {
      try {
        define.setSid(sid);
        define.setQname(qname);
        define.setQtype(qtype);
        define.setQmust(qmust);
        define.setNother(nother);
        define.setAtype(atype);
        defineMgr.createDefineQuestion(define);

        response.sendRedirect("addQuestion.jsp?success=1&sid=" + sid);
        return;
      } catch (DefineException e) {
        e.printStackTrace();
      }
    } else {
      try {
        define.setSid(sid);
        define.setQid(qid);
        define.setQname(qname);
        define.setQtype(qtype);
        define.setQmust(qmust);
        define.setNother(nother);
        define.setAtype(atype);
        defineMgr.updateDefineQuestion(define);

        response.sendRedirect("addQuestion.jsp?success=2&sid=" + sid);
        return;
      } catch (DefineException e) {
        e.printStackTrace();
      }
    }
  } else {
    try {
      define = defineMgr.getADefineSurvey(sid);
      surveyname = define.getSurveyname();
      notes = define.getNotes();

      list = defineMgr.getAllDefineQuestionsBySID(sid);
      if (qid != -1) {
        define = defineMgr.getADefineQuestion(qid);
        qname = define.getQname();
        qtype = define.getQtype();
        qmust = define.getQmust();
        atype = define.getAtype();
        nother = define.getNother();
      }
    } catch (DefineException e) {
      e.printStackTrace();
    }
  }
%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
  <title>�������-�������</title>
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
    function DeleteQuestion(qid, sid)
    {
      var str = confirm("ȷ��Ҫɾ�����������ɾ����������Ĵ𰸽�һ��ɾ����");
      if (str)
        window.location = "deleteQuestion.jsp?qid=" + qid + "&sid=" + sid;
    }

    function checkQName(){
      if((addQuestionForm.qname.value == null)||(addQuestionForm.qname.value == "")){
        alert("�����붨�����������");
        return false;
      }
      return true;
    }
  </script>
</head>

<body>
<center>
<table width="900" border="0" cellpadding="0" cellspacing="0" class="bian">
<tr>
<td height="360" align="center" valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form method="POST" action="addQuestion.jsp" name=addQuestionForm onsubmit="javascript:return checkQName();">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="sid" value="<%=sid%>">
<input type="hidden" name="qid" value="<%=qid%>">
<tr>
  <td valign="top">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50" height="40" align="center"><img src="images/qian_01.jpg" width="30" height="30"/></td>
        <td align="left"><span class="black12c">�������</span><span class="black12">--�������</span></td>
        <td width="30" align="center"><img src="images/lv_01.jpg" width="11" height="7"/></td>
        <td width="37" class="black12c"><a href="index.jsp">����</a></td>
      </tr>

    </table>
  </td>
</tr>
<tr>
  <td height="1" valign="top" bgcolor="#898898"></td>
</tr>
<tr>
  <td valign="top">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="160" height="50" align="center" bgcolor="#F6F5F0" class="black12c">�������ƣ�</td>
        <td width="1" bgcolor="#898898"></td>
        <td align="left" class="black12">&nbsp;&nbsp;<%=StringUtil.iso2gb(surveyname)%>
        </td>
      </tr>
      <tr>
        <td height="1" bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
        <td bgcolor="#898898"></td>
      </tr>
      <tr>
        <td width="160" height="50" align="center" bgcolor="#F6F5F0" class="black12c">����������</td>
        <td bgcolor="#898898"></td>
        <td align="left" class="black12">&nbsp;&nbsp;<%=StringUtil.iso2gb(notes)%>
        </td>
      </tr>
      <tr>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
      </tr>
      <tr>
        <td width="160" height="80" align="center" bgcolor="#F6F5F0" class="black12c">�������ƣ�</td>
        <td bgcolor="#898898"></td>
        <td align="left" class="black12">
          &nbsp;&nbsp;
          <textarea rows="3" cols="80" name="qname"><%if ((qname != null) && (!qname.equals(""))) {%><%=
            StringUtil.iso2gb(qname)%><%}%></textarea></td>
      </tr>
      <tr>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
      </tr>
      <tr>
        <td width="160" height="50" align="center" bgcolor="#F6F5F0" class="black12c">�������ͣ�</td>
        <td bgcolor="#898898"></td>
        <td align="left" valign="middle" class="black12">
          &nbsp;
          <input type="radio" value="1" name="qtype" <%if(qid != -1){if(qtype == 1){%> checked<%}}else{%>checked<%}%>>��ѡ&nbsp;&nbsp;
          <input type="radio" value="2" name="qtype" <%if(qid != -1){if(qtype == 2){%> checked<%}}%>>��ѡ
        </td>
      </tr>
      <tr>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
      </tr>
      <tr>
        <td width="160" height="50" align="center" bgcolor="#F6F5F0" class="black12c">�����ͣ�</td>
        <td bgcolor="#898898"></td>
        <td align="left" valign="middle" class="black12">
          &nbsp;
          <input type="radio" value="1" name="atype" <%if(qid != -1){if(atype == 1){%> checked<%}}else{%>checked<%}%>>�ı�&nbsp;&nbsp;
          <input type="radio" value="2" name="atype" <%if(qid != -1){if(atype == 2){%> checked<%}}%>>ͼƬ
        </td>
      </tr>
      <tr>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
        <td height="1" bgcolor="#898898"></td>
      </tr>
      <tr>
        <td width="160" height="50" align="center" bgcolor="#F6F5F0" class="black12c">�Ƿ���</td>
        <td bgcolor="#898898"></td>
        <td align="left" valign="middle" class="black12">
          &nbsp;
          <input type="radio" value="1" name="qmust" <%if(qid != -1){if(qmust == 1){%> checked<%}}else{%>checked<%}%>>ѡ��&nbsp;&nbsp;
          <input type="radio" value="2" name="qmust" <%if(qid != -1){if(qmust == 2){%> checked<%}}%>>����
        </td>
      </tr>
      <tr>
        <td height="1" align="center" bgcolor="#898898" class="black12c"></td>
        <td bgcolor="#898898"></td>
        <td align="left" valign="middle" bgcolor="#898898"></td>
      </tr>
      <tr>
        <td height="50" align="center" bgcolor="#F6F5F0" class="black12c">��Ҫ�����</td>
        <td bgcolor="#898898"></td>
        <td align="left" valign="middle" class="black12">
          &nbsp;<input type="checkbox" name="nother" value="1" <%if(nother == 1){%> checked<%}%>>&nbsp;��Ҫ��д�ı���
        </td>
      </tr>
    </table>
  </td>
</tr>
<tr>
  <td height="1" valign="top" bgcolor="#898898"></td>
</tr>
<tr>
  <td height="80" align="center" valign="middle">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="310"></td>
        <td width="52"><input type="submit" value="��  ��" name="survey_submit"></td>
        <td width="60"></td>
        <td width="52"><input type="reset" value="��  д" name="survey_reset"></td>
        <td width="60"></td>
        <td width="52"><input type="button" value="��  ��" name="survey_back" onclick="window.location='index.jsp';"></td>
        <td width="310"></td>
      </tr>
    </table>
  </td>
</tr>
</form>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="1" bgcolor="#898898"></td>
          <td bgcolor="#898898"></td>
          <td bgcolor="#898898"></td>
        </tr>
        <tr>
          <td width="600" height="40" align="center" bgcolor="#F6F5F0" class="black12c">����</td>
          <td width="1" bgcolor="#898898"></td>
          <td align="center" bgcolor="#F6F5F0" class="black12c">����</td>
        </tr>
        <tr>
          <td height="1" bgcolor="#898898"></td>
          <td height="1" bgcolor="#898898"></td>
          <td height="1" bgcolor="#898898"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <%
        for (int i = 0; i < list.size(); i++) {
          define = (Define) list.get(i);
          qid = define.getQid();
          qname = define.getQname();
          atype = define.getAtype();
      %>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="600" height="40" align="center" class="black12"><%=StringUtil.iso2gb(qname)%>
          </td>
          <td width="1" bgcolor="#898898"></td>
          <td width="297" align="center" class="black12">
            <a href="javascript:DeleteQuestion(<%=qid%>,<%=sid%>)">ɾ��</a>
            <a href="addQuestion.jsp?qid=<%=qid%>&sid=<%=sid%>">�޸�</a>
            <%if (atype == 1) {%>
            <a href="addAnswer.jsp?qid=<%=qid%>&sid=<%=sid%>">����</a>
            <%} else {%>
            <a href="addPAnswer.jsp?qid=<%=qid%>&sid=<%=sid%>">����</a>
            <%}%>
          </td>
        </tr>
        <tr>
          <td width="1" bgcolor="#898898"></td>
          <td width="1" bgcolor="#898898"></td>
          <td width="1" bgcolor="#898898"></td>
        </tr>
      </table>
      <%
        }
      %>
    </td>
  </tr>
  <tr>
    <td height="40"></td>
  </tr>
</table>
</td>
</tr>
</table>
</center>
</body>
</html>


