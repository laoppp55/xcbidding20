<%@ page import="java.sql.*,
		 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
		 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%	////////////////////////////////

	// get parameters
	int picID   = ParamUtil.getIntParameter(request,"pic", 0);

	boolean doDelete = ParamUtil.getBooleanParameter(request,"doDelete");

	// global error variables
	String errorMessage = "";

	boolean noPicSpecified = (picID == 0);
	boolean errors = (noPicSpecified);

	IPicManager picManager = PicPeer.getInstance();
	Pic	pic = picManager.getPic(picID);
        int columnID = pic.getColumnID();

        Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
        if ( authToken == null){response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!");}
        if ( authToken != null && !SecurityCheck.hasPermission(authToken,"pic") ) {
            response.sendRedirect(
		response.encodeRedirectURL("pics.jsp?column="+columnID+"&msg=You have not right to access!")
	    );
                return;
        }

       	IColumnManager columnManager = ColumnPeer.getInstance();
	Column column = columnManager.getColumn(columnID);
	String columnName = column.getCName();

	// delete user if specified
	if( doDelete && !errors ) {
		String message = "";
		try {
			picManager.remove(picID);
			message = "ɾ��ͼƬ���!";
		}
		catch( PicException e ) {
			System.err.println( e );
			message = "ͼƬδ�ҵ�";
		}
		request.setAttribute("message",message);
		response.sendRedirect("pics.jsp?column="+columnID);
		return;
	}

%>

<html><head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
   String[][] titlebars = {
      { "���ŷ���", "picsmain.jsp" },
      { columnName, "pics.jsp?column="+columnID },
      {"ɾ������", ""}
   };
   String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>

<p class=line>ɾ������ <b><%= pic.getCName() %> </b>?<p>
<ul class=cur>����: ������ɾ�������£��������ɾ����?</ul>
<form action="removepic.jsp" name="deleteForm">
<input type="hidden" name="doDelete" value="true">
<input type=image src=../images/button_dele.gif onclick="document.all.deleteForm.submit()">&nbsp;
<input type=image src=../images/button_cancel.gif onclick="javascript:history.back()">
</form>
</body></html>
