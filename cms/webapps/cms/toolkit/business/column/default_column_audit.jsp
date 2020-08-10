<%@ page import = "java.io.*,
		   java.util.*,
		   java.sql.Timestamp,
		   com.bizwink.cms.util.*,
		   com.bizwink.cms.server.*,
		   com.bizwink.cms.security.*,
		   com.bizwink.cms.audit.*"
		   contentType = "text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if(authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  int ID = ParamUtil.getIntParameter(request, "ID", 0);
  int columnID = ParamUtil.getIntParameter(request, "columnID", -1);
  Timestamp lastUpdated = new Timestamp(System.currentTimeMillis());
  String editor = authToken.getUserID();

  IAuditManager auditManager = AuditPeer.getInstance();

  //����Ĭ�Ϲ���
  if (ID != 0 && columnID != -1)
  {
    try
    {
      //������������е�Ĭ�Ϲ���
      auditManager.reset_Default_AuditRules(columnID);

      //������µ�Ĭ�Ϲ���,ͬʱ����LastUpdated,Editor
      auditManager.setup_Default_AuditRules(ID,lastUpdated,editor);
    }
    catch (CmsException c)
    {
      c.printStackTrace();
    }
  }
%>

<html>
<body onload="javascript:window.close();">
</body>
</html>
