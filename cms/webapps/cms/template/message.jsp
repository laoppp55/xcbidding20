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

  int errcode = ParamUtil.getIntParameter(request,"retcode",0);
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ȷ����Ϣ</title>
<link rel=stylesheet type=text/css href=style/global.css></head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    switch(errcode) {
      case 0:
        out.println("ѡ��ģ��ɹ�");
        break;
      case -1:
        out.println("ѡ��ģ��ʧ��");
        break;
      case -2:
        out.println("ѡ��ģ��ʧ��");
        break;
      case -3:
        out.println("ѡ��ģ��ʧ��");
        break;
      case -4:
        out.println("ѡ��ģ��ʧ��");
        break;
      default:
        return;
    }
%>
</body>
</html>
