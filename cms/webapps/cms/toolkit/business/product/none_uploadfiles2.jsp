<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  String userid = authToken.getUserID();
  int siteid = 1;

  long bookid = ParamUtil.getLongParameter(request, "bookid", 0);
  int num = ParamUtil.getIntParameter(request, "num", 0);
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function upload(num,bookid)
{
  uploadfile.action = "upload.jsp?num="+num+"&bookid="+bookid;
  uploadfile.submit();
}
</script>
</head>

<body bgcolor="#FFFFFF">
<center>
<p>��ѡ��Ҫ�ϴ����ļ���</p>
<form name=uploadfile enctype="multipart/form-data" method="post">
  <input type="file" name="file1">
  <input type="button" name="Ok" onclick="javascript:upload(<%=num%>,<%=bookid%>)" value="��ʼ�ϴ�">
</form>
</center>
</body>
</html>