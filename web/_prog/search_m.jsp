<%@ page import="com.bizwink.search.SearchFilesServlet" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.util.StringUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.util.filter" %>
<%@ page import="org.apache.lucene.document.Document" %>
<%@ page language="java" contentType="text/html;charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	String sitename = request.getServerName();  //site name
	sitename = "www.bucgdx.com";
	sitename = StringUtil.replace(sitename,".","_");
	String pagesstr = filter.excludeHTMLCode(request.getParameter("currpage"));

	int pages = 1;  //当前页
	if (pagesstr == null) {
		pages = 1;
	} else {
		pages = Integer.parseInt(pagesstr);
	}
	int range = 20;
	String content = filter.excludeHTMLCode(request.getParameter("searchcontent"));
	SearchFilesServlet search = new SearchFilesServlet();

	List list = new ArrayList();
	int num = 0;

	if (content != null) {
		if (!content.isEmpty()) {
			String ip = request.getHeader("x-forwarded-for");
			if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			}
			if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
			num = search.getArticlesNum(sitename,content); //总的记录数
			list = search.getArticles(sitename,content,(pages-1) * range, pages * range);
		}
	}

	int totalPages = 0;  //总页数
	if (num % range == 0) {
		totalPages = num / range;
	} else {
		totalPages = num / range + 1;
	}
	sitename = request.getServerName();
%>
<!DOCTYPE html>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=EDGE"><meta name="viewport" content="width=device-width,user-scalable=no, initial-scale=1"><meta name="author" content="www.vancheer.com"><meta name="Keywords" content="北京城建集团党校"><meta name="Description" content="北京城建集团党校">
	<title>北京城建集团党校</title>
	<link href="/css/m_basis.css" rel="stylesheet" type="text/css" />
	<link href="/css/media.css" rel="stylesheet" type="text/css" />
	<link href="/css/m_program.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="/js/jquery-1.10.2.min.js" style="color: rgb(0, 0, 0);"></script>
    <script language="javascript" type="text/javascript" src="/js/js.js"></script>
	<script src="/js/users.js" type="text/javascript"></script>
</head>
<body class="home">
<div><!--#include virtual="/inc/menu_m.shtml"--></div>
<!--以上头部-->

<div class="colume_title">搜索结果</div>

<div class="colume"><img alt="" src="/images/banner02.jpg" /></div>

<div class="search_result">
	<div class="search_title">记录总数：<%=list.size()%>条</div>
	<%
		for(int ii=0; ii<list.size(); ii++) {
			Document doc = (Document)list.get(ii);
			String filename = doc.get("filename");
			String url = null;
			String colurl = doc.get("dirname");
			String colname = doc.get("colname");
			String summary = doc.get("summary");
			String createdate = doc.get("createdate");
			if (filename == null)
				url = colurl + createdate + "/" + doc.get("id") + "_m.shtml";
			else
				url = colurl + "download/" + filename;
	%>
	<div class="ss_bk">
		<h3>【<a href="<%=colurl%>" target="_blank"><%=colname%></a>】<a href="<%=url%>" target="_blank"><%=doc.get("maintitle")%></a> <%=createdate%></h3>

		<p align="left">&nbsp; &nbsp;<%=(summary!=null)?summary:""%><a href="<%=url%>" target="_blank">[详细]</a></p>
	</div>
	<%}%>
	<!--div class="ss_bk">
		<h3>【<a href="/annoucement/notics/" target="_blank">null</a>】<a href="/annoucement/notics/20190819/112.shtml" target="_blank">工程部召开首届一次职代会</a> 20190819</h3>

		<p align="left">日前，工程总承包部首届一次职工代表大会在北苑会议中心召开。集团公司工会副主席刘冬梅，集团第三监事会主席梁佳富、副主席邵民出席了会议，工程总承包部总经理罗岗、党委书记何万立等96名代表参加大会<a href="/annoucement/notics/20190819/112.shtml" target="_blank">[详细]</a></p>
	</div-->
</div>

<script>
    Pagination(<%=totalPages%>,<%=pages%>,"<%=content%>","search_m.jsp");
</script>

<!--div class="search_page" id="pagesid">
	<div class="page"><a href="/newscenter/internews/index.shtml">上一页</a> <span class="cur">1</span> <a href="/newscenter/internews/index1.shtml">2</a> <a href="/newscenter/internews/index1.shtml">3</a> <a href="/newscenter/internews/index1.shtml">4</a> <a href="/newscenter/internews/index1.shtml">5</a> <a href="/newscenter/internews/index1.shtml">下一页</a></div>
</div-->

<div class="footbox"><!--#include virtual="/inc/tail_m.shtml"--></div>
</body>
</html>
