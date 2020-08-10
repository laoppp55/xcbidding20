<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.cms.refers.IRefersManager" %>
<%@ page import="com.bizwink.cms.refers.RefersPeer" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.news.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.orderArticleListManager.orderArticleException" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int articleID = ParamUtil.getIntParameter(request, "article", 0);
    int columnId = ParamUtil.getIntParameter(request, "column", 0);
    boolean doDelete = ParamUtil.getBooleanParameter(request, "doDelete");
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 0);

    IArticleManager articleManager = ArticlePeer.getInstance();
    Article article = articleManager.getArticle(articleID);

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnId);
    String columnName = StringUtil.gb2iso4View(column.getCName());

    if (doDelete) {
        try {
            IRefersManager refersManager = RefersPeer.getInstance();
            refersManager.remove(articleID, columnId);
        } catch (orderArticleException e) {
            e.printStackTrace();
        }
        response.sendRedirect(response.encodeRedirectURL("articles.jsp?column=" + columnId + "&start=" + start + "&range=" + range));
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script type="text/javascript">
        function delWebFiles() {
            deleteForm.submit();
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"文章管理", "articlesmain.jsp"},
            {columnName, "articles.jsp?column=" + columnId},
            {"删除文章", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p class=line>删除文章 <b><%=StringUtil.gb2iso4View(article.getMainTitle())%>
</b>

<p>
<ul class=cur>警告: 您真的想删除引用的文章吗?</ul>
<form action="removeRefersArticle.jsp" name=deleteForm method="POST">
    <input type=hidden name=doDelete value=true>
    <input type=hidden name=article value="<%=articleID%>">
    <input type=hidden name=start value="<%=start%>">
    <input type=hidden name=range value="<%=range%>">
    <input type=hidden name=column value="<%=columnId%>">
    <input type=hidden name=delwebflag value="">
    <a href="javascript:delWebFiles();"><img src="../images/button_dele.gif" border=0></a>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:history.back();"><img src="../images/button_cancel.gif" border=0></a>
</form>

</body>
</html>
