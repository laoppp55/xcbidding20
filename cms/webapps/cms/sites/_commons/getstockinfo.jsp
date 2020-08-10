<%@ page import="com.bizwink.stockinfo.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page language="java" contentType="text/html;charset=GBK" %>
<link href="/images/sinopec.css" type="text/css" rel="stylesheet" />
<%
    String stockid = ParamUtil.getParameter(request,"stockcode");
    ISpiderManager stoMgr = SpiderPeer.getInstance();
    StockInfo spider = stoMgr.getSpiderInfoBycode("600266.SS");

    String d = (ParamUtil.getParameter(request,"d",false) == null)? "":ParamUtil.getParameter(request,"d",false);
    java.util.Date sysDate = new java.util.Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String thedate = spider.getTrade_time().toString();
    int posi = thedate.indexOf(" ");
    thedate = thedate.substring(0,posi);
    out.write("<table>");
    out.write("<tr><td>��&nbsp;&nbsp;�ڣ�" + thedate + "</td></tr>");
    out.write("<tr><td>ǰ���̣�" + spider.getPrev_close() + "</td></tr>");
    out.write("<tr><td>���̼ۣ�" + spider.getOpen_money() + "</td></tr>");
    out.write("<tr><td>��ǰ�ۣ�" + spider.getLast_trade() + "</td></tr>");
    out.write("<tr><td>��&nbsp;&nbsp;Χ��" + spider.getDay_range_low() + "-" + spider.getDay_range_high() + "</td></tr>");
    out.write("<tr><td>�仯����" + spider.getThechange() + "</td></tr>");
    out.write("</table>");
%>
