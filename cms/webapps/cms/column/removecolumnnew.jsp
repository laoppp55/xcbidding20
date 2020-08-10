<%@ page import="java.sql.*,
    		 com.bizwink.cms.news.*,
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
    int ParentID = ParamUtil.getIntParameter(request,"pid", 0);
    int siteid = authToken.getSiteID();
    boolean doDelete = ParamUtil.getBooleanParameter(request,"doDelete");
    boolean success = false;
    boolean noColumnSpecified = (ID == 0);
    boolean errors = (noColumnSpecified);

    IColumnManager columnManager = ColumnPeer.getInstance();
    IArticleManager articleManager = ArticlePeer.getInstance();
    IModelManager modelManager = ModelPeer.getInstance();

    // delete user if specified
    Column column = null;
    if(doDelete && !errors ){
        String message = "";
        try{
/*
		//��һ����ɾ������Ŀ�µ���������
		articleManager.removeArticlesInColumn(ID,siteid);

		//�ڶ�����ɾ������Ŀ�µ�����ģ��
		modelManager.removeModelsInColumn(ID,siteid);
*/
            //��������ɾ������Ŀ(��ɾ������Ŀ����˹�������������˹���)
            columnManager.remove(ID,siteid);
            message = "ɾ����Ŀ���!";
            success = true;
        } catch( ColumnException e ){
            System.err.println( e );
            message = "��Ŀδ�ҵ�";
        }
    } else {
        column = columnManager.getColumn(ID);
        ParentID = column.getParentID();
    }
%>
<html><head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script language=javascript>
        $(document).ready(function(){
            var successflag = <%=success%>;
            if (successflag === true){
                window.opener.deletenodeinfo(<%=ID%>,<%=ParentID%>);
                window.close();
            }
        })

        function cancelTheDel() {
            window.close();
            return false;
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            { "��Ŀ����", "indexnew.jsp" },
            { "ɾ����Ŀ", "" }
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p class=line>
    ɾ����Ŀ <b><%=(column!=null)?StringUtil.gb2iso4View(column.getCName()):""%> </b>?
<p>
<ul class=cur>����: �˲����������Ե�ɾ������Ŀ�����������¡�ģ�弰��˹����������ɾ����?</ul>
<form action="removecolumnnew.jsp" name="deleteForm">
    <input type=hidden name=doDelete value="true">
    <input type=hidden name=ID value="<%= ID %>">
    <input type=hidden name=pid value="<%=ParentID%>">
    <input type=image src=../images/button_dele.gif onclick="document.all.deleteForm.submit()">
    &nbsp;
    <input type=image src=../images/button_cancel.gif onclick="javascript:cancelTheDel();">
</form>
</body>
</html>