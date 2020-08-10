<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.news.ArticlePeer" %>
<%@ page import="com.bizwink.cms.news.IArticleManager" %>
<%@ page import="com.bizwink.cms.news.ArticleException" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    String[] articleids = request.getParameterValues("article");
    String allArticleIds = ParamUtil.getParameter(request, "allArticleIds"); 
    int columnId = ParamUtil.getIntParameter(request, "column", -1);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    String doAct = ParamUtil.getParameter(request, "doAct");

    String articleIDs = "";
    if ((articleids != null) && (articleids.length > 0)) {
        for (int i = 0; i < articleids.length; i++) {
            articleIDs = articleIDs + articleids[i] + ",";
        }
    }

    if(articleIDs.indexOf(",") != -1)
        articleIDs = articleIDs.substring(0, (articleIDs.length()-1));

    IArticleManager articleMgr = ArticlePeer.getInstance();
    try {
        articleMgr.batchDel(articleIDs);
    } catch (ArticleException e) {
        e.printStackTrace();
    }
    response.sendRedirect("articles.jsp?column="+columnId+"&start="+start+"&range="+range+"&msgno=-5");
%>