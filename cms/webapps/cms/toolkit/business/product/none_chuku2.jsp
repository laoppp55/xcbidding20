<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.booyee.order.*"
                 contentType="text/html;charset=gbk"%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  String userid = authToken.getUserID();
  int siteid = 1;
  int msgflag = ParamUtil.getIntParameter(request, "msgflag", 0);
  int orderid = ParamUtil.getIntParameter(request, "orderid", 0);

  IOrderManager orderMgr = OrderPeer.getInstance();

  orderMgr.chuku_detail(orderid);
  response.sendRedirect("chuku.jsp?msgflag="+msgflag);
%>


<html>
<head>
<title></title>
<body></body>
</html>