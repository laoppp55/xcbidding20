<%@ page import="com.bizwink.stockinfo.ISpiderManager" %>
<%@ page import="com.bizwink.stockinfo.SpiderPeer" %>
<%@ page language="java" contentType="text/html;charset=GBK" %>
<%
    ISpiderManager stoMgr = SpiderPeer.getInstance();
    long ttt = stoMgr.getStockpriceFormOraAndMysql("SOHU");
%>

<html>
<head>
    <title>�������ݿ����ʱ��</title>
</head>
<body>
<%=ttt%>
</body>
</html>