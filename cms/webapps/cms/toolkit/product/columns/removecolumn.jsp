<%@ page import="java.sql.*,
    		 com.bizwink.cms.toolkit.companyinfo.*,
    		 com.bizwink.cms.modelManager.*,
    		 com.bizwink.cms.security.*,
		 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
    if( authToken == null ) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    // get parameters
    int ID   = ParamUtil.getIntParameter(request,"ID", 0);
    int siteid = authToken.getSiteID();
    boolean doDelete = ParamUtil.getBooleanParameter(request,"doDelete");

    boolean noColumnSpecified = (ID == 0);
    boolean errors = (noColumnSpecified);

    ICompanyinfoManager companyManager = CompanyinfoPeer.getInstance();
    companyClass companyType = new companyClass();

    // delete user if specified
    if( doDelete && !errors )
    {
        String message = "";
        try
        {
            //��������ɾ������Ŀ(��ɾ������Ŀ����˹�������������˹���)
            companyManager.remove(ID,siteid);

            message = "ɾ����Ŀ���!";
        }
        catch( Exception e )
        {
            System.err.println( e );
            message = "��Ŀδ�ҵ�";
        }


        request.setAttribute("message",message);
        response.sendRedirect("index.jsp");
        return;
    }
    companyType = companyManager.getCompanyClass(ID);

%>
<html><head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../css/global.css">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            { "ɾ��������Ϣ", "" }
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p class=line>
    ɾ��������Ϣ <b><%=StringUtil.gb2iso4View(companyType.getCname())%> </b>?
<p>
<ul class=cur>����: �˲����������Ե�ɾ���÷��༰�÷�������������ҵ��Ϣ���������ɾ����?</ul>
<form action="removecolumn.jsp" name="deleteForm">
    <input type=hidden name=doDelete value="true">
    <input type=hidden name=ID value="<%= ID %>">
    <input type=image src=../images/button_dele.gif onclick="document.all.deleteForm.submit()">
    &nbsp;
    <input type=image src=../images/button_cancel.gif onclick="location.href='index.jsp';return false;">
</form>
</body></html>