<%@ page isErrorPage="true" %>
<%@ page import="java.util.*,
    java.net.*,
    com.bizwink.util.*" contentType="text/html;charset=gbk"%>
<%
    String errorMessage = ParamUtil.getParameter(request,"msg");
    String errorMessage2 = (String)request.getParameter("message");
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����</title>
<link rel=stylesheet type=text/css href=style/global.css></head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    if( errorMessage != null ) {
        out.println("������Ϣ:"+errorMessage);
    } else if(errorMessage2 !=null){
        out.println("������Ϣ:"+errorMessage2);
    }else{
        out.println("ͨ�ô���.exception:"+ exception);
    }
%>
</body></html>