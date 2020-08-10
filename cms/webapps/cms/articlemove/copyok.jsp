<%@ page import="java.util.*,
                 java.io.File,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int columnID = ParamUtil.getIntParameter(request, "columnid", 0);
    int oldcolumnID = ParamUtil.getIntParameter(request, "oldcolumnID", 0);
    int execute = ParamUtil.getIntParameter(request, "execute", 0);
    int moveall = ParamUtil.getIntParameter(request, "moveall", 0);

    //先判断两个栏目之间的扩展属性是否相同
    if (execute == 0) {
        IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
        boolean isSame = extendMgr.querySameExtendAttr(oldcolumnID, columnID);
        if (!isSame) {
            response.sendRedirect("listarticle.jsp?column=" + oldcolumnID + "&msg=" + StringUtil.gb2iso("两个栏目扩展属性不相同！复制不成功！"));
            return;
        }
    }

    String articleids = "";
    int siteid = authToken.getSiteID();
    String username = authToken.getUserID();
    int artcount = ParamUtil.getIntParameter(request, "artcount", 0);

    IArticleManager articleMgr = ArticlePeer.getInstance();
    String appPath = application.getRealPath("/") + "sites" + File.separator + authToken.getSitename();

    if (moveall == 0) {
        for (int i = 0; i < artcount; i++) {
            int articleid = ParamUtil.getIntParameter(request, "selected" + Integer.toString(i), 0);
            if (articleid != 0) {
                if (articleids == "")
                    articleids = Integer.toString(articleid);
                else
                    articleids = articleids + "," + Integer.toString(articleid);
            }
        }
    } else {
        try {
            articleids = articleMgr.getArticlesIdofColumn(oldcolumnID);
        } catch (ArticleException e) {
            System.out.println("获得栏目下所有文章的ID出错，在/articlemove/copyok.jsp页面");
            e.printStackTrace();
        }
    }

    try {
        articleMgr.copyArticlesToColumn(oldcolumnID, columnID, articleids, siteid, appPath, username);
    }
    catch (ArticleException e) {
        e.printStackTrace();
    }
    response.sendRedirect(response.encodeRedirectURL("listarticle.jsp?column=" + columnID));
%>