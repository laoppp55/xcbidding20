<%@ page import="java.util.*,
                 com.bizwink.cms.publish.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.orderArticleListManager.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=utf-8"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int currentID = ParamUtil.getIntParameter(request, "column", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int retcode = 1;
    int columnID = 0;

    String username = authToken.getUserID();
    String sitename = authToken.getSitename();
    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();

    int imgflag = authToken.getImgSaveFlag();
    int option = authToken.getPublishFlag();
    String appPath = application.getRealPath("/");

    IPublishManager publishMgr = PublishPeer.getInstance();
    IColumnManager columnMgr = ColumnPeer.getInstance();
    IOrderArticleListManager orderArticleMgr = orderArticleListPeer.getInstance();
    List publish_article_list = orderArticleMgr.getPublishArticlesInColumn(currentID,siteid);

    for (int i = 0; i < publish_article_list.size(); i++) {
        Article article = (Article)publish_article_list.get(i);
       // System.out.println("publish article=" + article.getIsTemplate() + "===" + article.getID());
        int articleid = article.getID();
        if (articleid > 0) {
            boolean isTemplate = article.getIsTemplate();
            if (isTemplate) {
                columnID = article.getColumnID();
                int type = article.getIsArticleTemplate();
                if (type == 0) {        //发布栏目页面
                    retcode = publishMgr.CreateColPage(columnID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleid);

                    //如果需要发布RSS，发布RSS
                    Column column = columnMgr.getColumn(currentID);
                    if (column.getRss() == 1) {
                        RssMaker rm = new RssMaker();
                        rm.createRss(siteid, currentID, column, appPath, username, sitename);
                    }
                } else if (type == 2) {        //发布首页
                    retcode = publishMgr.createHomePage(siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleid);
                } else if (type == 3 || type==4) {        //发布专题页面和智能手机栏目页面
                    retcode = publishMgr.CreateColPage(columnID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleid);
                }
            } else {       //发布文章
                columnID = article.getColumnID();
                boolean isown = article.isIsown();
                retcode = publishMgr.CreateArticlePage(articleid, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, isown, columnID);
            }
        }
    }

    response.sendRedirect("articles.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
%>