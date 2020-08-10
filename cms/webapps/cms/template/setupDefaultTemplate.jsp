
<%@ page import="java.sql.*,
    com.bizwink.cms.news.*,
    com.bizwink.cms.modelManager.*,
    com.bizwink.cms.security.*,
    com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
    if( authToken == null ) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean doSetup = ParamUtil.getBooleanParameter(request,"doSetup");
    int templateID  = ParamUtil.getIntParameter(request,"template", 0);
    int columnID  = ParamUtil.getIntParameter(request,"column", 0);
    int modelType  = ParamUtil.getIntParameter(request,"isArticle", 0);
    boolean success = false;

    IModelManager modelMgr = ModelPeer.getInstance();
    try {
        success = modelMgr.setupDefault(templateID,columnID,modelType);
    } catch (ModelException e) {
        e.printStackTrace();
    }

    //�޸ĳɹ�������ģ���б�ҳ��
    if(success) {
        response.sendRedirect(response.encodeRedirectURL("templates.jsp?column="+columnID+"&msgno=1&isArticle="+modelType));
        return;
    }
%>

<html>
<head>
<title>������Ŀ�б�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<body bgcolor="#FFFFFF">
<ul class=cur>����: ȷ��Ҫ�޸ı���Ŀ��Ĭ��ģ����</ul>
<form action=setupDefaultTemplate.jsp name="defaultForm">
<input type=hidden name=doSetup value="true">
<input type=hidden name=template value="<%=templateID %>">
<input type=image src=../images/button_modi.gif onclick="document.all.defaultForm.submit()">
&nbsp;
<input type=image src=../images/button_cancel.gif onclick="location.href='templates.jsp?column=<%=columnID%>';return false;">
</form>
<script language=JavaScript type="text/javascript">
<!--
document.deleteForm.cancel.focus();
//-->
</script>

</body>
</html>
