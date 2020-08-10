<%@ page import="com.bizwink.search.SearchFilesServlet" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.lucene.document.Document" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.bizwink.util.StringUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.util.filter" %>
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
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京城建集团党校</title>
    <link href="/css/basis.css" rel="stylesheet" type="text/css">
    <link href="/css/column.css" rel="stylesheet" type="text/css">
    <script>
        function goSearchPage(page) {
            window.location.href="search.jsp?currpage=" + page + "&searchcontent=<%=content%>";
        }

        function Pagination(totalpages,curentpage,keyword) {
            var PaginationDiv = "";
            if (totalpages <= 1)
                PaginationDiv = "<div class=\"page\" style=\"display: \"none\">";
            else
                PaginationDiv = "<div class=\"page\" style=\"display: \"block\">";

            if (curentpage<=1)
                PaginationDiv = PaginationDiv + "<span>第1页</span>";
            else
                PaginationDiv = PaginationDiv + "<span><a href=\"search.jsp?currpage=1&searchcontent=" + keyword + "\">第1页</a></span>";

            PaginationDiv = PaginationDiv + "<span>共" + totalpages + "页</span>";

            if (curentpage<=1)
                PaginationDiv = PaginationDiv + "<span>上一页</span>";
            else
                PaginationDiv = PaginationDiv + "<span><a href=\"search.jsp?currpage=" + (curentpage-1) + "&searchcontent=" + keyword + "\">上一页</a></span>";

            for(var ii=0;ii<totalpages;ii++) {
                if ((ii+1) == pages)
                    PaginationDiv = PaginationDiv + "<span class=\"cur\">" + curentpage + "</span>";
                else
                    PaginationDiv = PaginationDiv + "<a href=\"search.jsp?currpage=" + (ii+1) + "&searchcontent=" + keyword + "\">" + (ii+1) + "</a>";
            }

            if (curentpage<totalpages)
                PaginationDiv = PaginationDiv + "<span><a href=\"search.jsp?currpage=" + (curentpage+1) + "&searchcontent=" + keyword + "\">下一页</a></span>";
            else
                PaginationDiv = PaginationDiv + "<span>下一页</span>";

            PaginationDiv = PaginationDiv + "<span class=\"txtl\">转到第</span>";
            PaginationDiv = PaginationDiv + "<span class=\"select-pager\">";
            PaginationDiv = PaginationDiv + "<form name=\"form\">";
            PaginationDiv = PaginationDiv + "<select name=\"turnPage\" size=\"1\" onchange=\"javascript:goSearchPage(this.form.turnPage.value)\">";

            for(var ii=0;ii<totalpages;ii++) {
                if ((ii+1) == pages)
                    PaginationDiv = PaginationDiv + "<option value=\"" + (ii+1) + "\" selected>" + (ii+1) +  "</option>";
                else
                    PaginationDiv = PaginationDiv + "<option value=\"" + (ii+1) + "\">" + (ii+1) + "</option>";
            }

            PaginationDiv = PaginationDiv + "</select>";
            PaginationDiv = PaginationDiv + "</form>";
            PaginationDiv = PaginationDiv + "</span>";
            PaginationDiv = PaginationDiv + "<span class=\"txtr\">页</span>";
            PaginationDiv = PaginationDiv + "</div>";
        }
    </script>
</head>

<body>
<div class="full_box">
    <div class="top_box">
        <%@include file="/inc/top.shtml" %>
    </div>
    <div class="logo_box clearfix">
        <%@include file="/inc/search.shtml" %>
    </div>
    <div class="menu_box">
        <%@include file="/inc/menu.shtml" %>
    </div>
</div>

<!--以上页面头-->
<div class="banner"><img alt="" src="/images/banner02.jpg"></div>
<div class="main div_top div_bottom clearfix">
    <div class="path_box">当前位置：<a href="#">首页</a>><a href="#">搜索结果</a></div>
    <div class="search_result">
        <div class="search_title">搜索结果--记录总数：<%=list.size()%>条</div>
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
                    url = colurl + createdate + "/" + doc.get("id") + ".shtml";
                else
                    url = colurl + "download/" + filename;
                System.out.println(url);
        %>
        <div class="ss_bk">
            <h3>【<a href="<%=colurl%>" target="_blank"><%=colname%></a>】<a href="<%=url%>" target="_blank"><%=doc.get("maintitle")%></a>         <%=createdate%></h3>
                <p align=left><%=(summary!=null)?summary:""%><a href="<%=url%>" target="_blank">[详细]</a></p>
        </div>
        <%}%>
    </div>
    <div class="search_page">
        <div class="page" style="display: <%=(totalPages<=1)?"none":"block"%>">
            <%=(pages<=1)?"<span>第1页</span>":"<span><a href=\"search.jsp?currpage=1&searchcontent=" + content + "\">第1页</a></span>"%>
            <span>共<%=totalPages%>页</span>
            <%=(pages<=1)?"<span>上一页</span>":"<span><a href=\"search.jsp?currpage=" + (pages-1) + "&searchcontent=" + content + "\">上一页</a></span>"%>
            <%
                for(int ii=0;ii<totalPages;ii++)
                    if ((ii+1) == pages)
                        out.print("<span class=\"cur\">" + pages + "</span>");
                    else
                        out.print("<a href=\"search.jsp?currpage=" + (ii+1) + "&searchcontent=" + content + "\">" + (ii+1) + "</a>");
            %>
            <%=(pages<totalPages)?"<span><a href=\"search.jsp?currpage=" + (pages+1) + "&searchcontent=" + content + "\">下一页</a></span>":"<span>下一页</span>"%>
            <span class="txtl">转到第</span>
            <span class="select-pager">
                <form name="form">
                <select name="turnPage" size="1" onchange="javascript:goSearchPage(this.form.turnPage.value)">
                    <%
                        for(int ii=0;ii<totalPages;ii++)
                            if ((ii+1) == pages)
                                out.print("<option value=\"" + (ii+1) + "\" selected>" + (ii+1) +  "</option>");
                            else
                                out.print("<option value=\"" + (ii+1) + "\">" + (ii+1) + "</option>");
                    %>
                </select>
            </form>
            </span>
            <span class="txtr">页</span>
        </div>
    </div>

</div>
<!--以下页面尾-->
<div>
    <%@include file="/inc/tail.shtml" %>
</div>
</body>
</html>
