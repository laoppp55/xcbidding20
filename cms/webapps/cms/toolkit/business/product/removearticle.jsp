<%@ page import="java.sql.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int articleID = ParamUtil.getIntParameter(request, "article", 0);
    boolean doDelete = ParamUtil.getBooleanParameter(request, "doDelete");
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 0);
    String from = ParamUtil.getParameter(request, "from");
    int delwebflag = ParamUtil.getIntParameter(request, "delwebflag", 0);

    IArticleManager articleManager = ArticlePeer.getInstance();
    Article article = articleManager.getArticle(articleID);
    int columnID = article.getColumnID();
    boolean success = false;
    String editor = authToken.getUserID();

    int siteid = authToken.getSiteID();
    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String columnName = StringUtil.gb2iso4View(column.getCName());

    if (doDelete) {
        try {
            articleManager.remove(articleID, siteid, editor, delwebflag);
            success = true;
        }
        catch (ArticleException e) {
            e.printStackTrace();
        }
    }

    if (success) {
        if (from.equalsIgnoreCase("u"))
            response.sendRedirect(response.encodeRedirectURL("unusedarticle?column=" + columnID + "&start=" + start + "&range=" + range));
        else
            response.sendRedirect(response.encodeRedirectURL("articles.jsp?column=" + columnID + "&start=" + start + "&range=" + range));
        return;
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script type="text/javascript">
        function delWebFiles() {
            var val = confirm("�Ƿ�ɾ��WEB�������ϵ��ļ���");
            if (val) {
                deleteForm.delwebflag.value = "1";
                deleteForm.submit();
            } else {
                deleteForm.delwebflag.value = "0";
                deleteForm.submit();
            }
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"���¹���", "articlesmain.jsp"},
            {columnName, "articles.jsp?column=" + columnID},
            {"ɾ������", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p class=line>ɾ����Ʒ <b><%=StringUtil.gb2iso4View(article.getMainTitle())%>
</b> ?

<p>
<ul class=cur>����: �˲�����ɾ������Ʒ����˹����������ɾ����?</ul>
<form action="removearticle.jsp" name=deleteForm method="POST">
    <input type=hidden name=doDelete value=true>
    <input type=hidden name=article value="<%=articleID%>">
    <input type=hidden name=start value="<%=start%>">
    <input type=hidden name=range value="<%=range%>">
    <input type=hidden name=from value="<%=from%>">
    <input type=hidden name=delwebflag value="">
    <a href="javascript:delWebFiles();"><img src="../images/button_dele.gif" border=0></a>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:history.back();"><img src="../images/button_cancel.gif" border=0></a>
</form>

</body>
</html>
