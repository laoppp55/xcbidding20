<%@ page import="java.util.*,
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

  int columnID = ParamUtil.getIntParameter(request, "column", 0);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����б�����</title>
<script language="javascript">
function setlinkrules()
{
  var rule="[TAG][LINK][COLUMNS]"+linkrule.cnames.value + "[/COLUMNS][COLUMNIDS]" + linkrule.cids.value +
           "[/COLUMNIDS][WEIGHT]" + linkrule.weight.value +"[/WEIGHT][/LINK][/TAG]";
  parent.window.opener.document.linkform.oHref.value = rule;
  parent.window.close();
}
</script>
</head>
<body>
<form name=linkrule>
<input type="text" name=cnames value="">
<input type="hidden" name=cids value="">
<input type="text"  name = weight value="">
<input type="button" name="ok"  value="ȷ��" onclick=javascript:setlinkrules()>
<input type="button" name="cancel" value="����" onclick=javascript:parent.window.close()>
</form>
</body>
</html>