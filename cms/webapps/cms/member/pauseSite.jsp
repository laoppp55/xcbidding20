<%@ page import="java.util.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.register.*,
                 com.bizwink.cms.security.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect( "../login.jsp?url=member/removeRight.jsp" );
    return;
  }
  if (authToken.getUserID().compareToIgnoreCase("admin") != 0)
  {
    request.setAttribute("message","��ϵͳ����Ա��Ȩ��");
    response.sendRedirect("../index.jsp");
    return;
  }

  int siteid = ParamUtil.getIntParameter(request, "siteid", 0);
  int type = ParamUtil.getIntParameter(request, "type", 0);
  String dname = ParamUtil.getParameter(request, "dname");
  boolean doPause = ParamUtil.getBooleanParameter(request,"doPause");
  boolean error = (siteid == -1);

  if (doPause && !error)
  {
    IRegisterManager regMgr = RegisterPeer.getInstance();
    try
    {
      if (type == 1)          //��ͣվ��
      {
        regMgr.pause(siteid);
      }
      else if (type == 2)     //����վ��
      {
        regMgr.start(siteid);
      }
      else if (type == 3)     //������վ��
      {
        regMgr.start_new(siteid);            //�������,����EMAIL
        regMgr.copyIconToCMS(siteid, dname, request.getRealPath("/"));      //���������б��й��ļ���CMS������
      }
      response.sendRedirect("siteManage.jsp");
      return;
    }
    catch (Exception e)
    {
      error = true;
    }
  }
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<%
  String str = "����վ��";
  if (type == 1)
    str = "��ͣվ��";

  String[][] titlebars = {
    { "", "siteManage.jsp" },
    { str, "" }
  };
  String [][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>
&nbsp;&nbsp;ȷ��Ҫ<%if(type==2 || type==3){%>����<%}else{%>��ͣ<%}%>վ��&nbsp;<b><%=dname%></b>&nbsp;��
<p>

<form action="pauseSite.jsp" name="pauseForm">
<input type="hidden" name="doPause" value="true">
<input type="hidden" name="siteid" value="<%=siteid%>">
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="dname" value="<%=dname%>">
&nbsp;&nbsp;<input type="submit" value=" ȷ�� ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%if (type == 3){%>
<input type="button" name="cancel" value=" ȡ�� " style="font-weight:bold;" onclick="location.href='onlineManage.jsp';return false;">
<%}else{%>
<input type="button" name="cancel" value=" ȡ�� " style="font-weight:bold;" onclick="location.href='siteManage.jsp';return false;">
<%}%>
</form>

<script language="JavaScript" type="text/javascript">
<!--
document.pauseForm.cancel.focus();
//-->
</script>

</body>
</html>
