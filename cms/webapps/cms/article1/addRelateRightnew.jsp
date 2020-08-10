<%@ page import="com.bizwink.cms.extendAttr.ExtendAttrPeer,
                 com.bizwink.cms.extendAttr.IExtendAttrManager,
                 com.bizwink.cms.news.Article,
                 com.bizwink.cms.news.ArticlePeer,
                 com.bizwink.cms.news.IArticleManager,
                 com.bizwink.cms.news.relatedArticle,
                 com.bizwink.cms.security.Auth"
         contentType="text/html;charset=utf-8"
        %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int siteid = authToken.getSiteID();
    int articleid = ParamUtil.getIntParameter(request, "articleid", 0);
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int num = ParamUtil.getIntParameter(request, "num", 0);

    IArticleManager articleManager = ArticlePeer.getInstance();
    Article article = articleManager.getArticle(articleid);
    String maintitle = article.getMainTitle();
    maintitle = StringUtil.gb2iso4View(maintitle);
    List relArticle = articleManager.getRelatedArticles(articleid);
    if (doCreate) {
        List rlist = new ArrayList();
        int useArticleType = ParamUtil.getIntParameter(request, "useArticleType", 0);        
        for (int i = 0; i < num; i++) {
            int columnid = ParamUtil.getIntParameter(request, "columnid" + (i + 1), 0);
            String columnname = ParamUtil.getParameter(request, "columnname" + (i + 1));
            maintitle = ParamUtil.getParameter(request, "maintitle" + (i + 1));
            if ((maintitle != null) && (!maintitle.equals("")) && (!maintitle.equals("null"))) {
                relatedArticle relatedArticle = new relatedArticle();
                relatedArticle.setJointedID(columnid);
                relatedArticle.setChineseName(columnname);
                relatedArticle.setTitle(maintitle);
                relatedArticle.setContenttype(useArticleType);
                rlist.add(relatedArticle);
            }
        }
        IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
        extendMgr.addRelatedArticles(rlist, articleid,siteid);
        out.println("<script language=javascript>top.close();</script>");
    }
%>

<html>
<head>
    <title>相关栏目列表</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script type="text/javascript" src="../js/mark.js"></script>
</head>
<script type="text/javascript">
    function selectClass()
    {
        var tableobj = document.getElementById("relatearticle");
        markForm.num.value = tableobj.rows.length;
        markForm.submit();
    }

    function delete_row(i) {
        var tableobj = document.getElementById("relatearticle");
        tableobj.deleteRow(i);
    }
</script>
<body bgcolor="#CCCCCC">
<center>
    <form action="addRelateRightnew.jsp" method="POST" name=markForm>
        <input type=hidden name=doCreate value=true>
        <input type=hidden name=column value="<%=columnID%>">
        <input type=hidden name=mark value="<%=markID%>">
        <input type=hidden name=articleid value="<%=articleid%>">
        <input type=hidden name=num value="-1">
        <input type=hidden name=content>
        <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%"
               id="relatearticle" align="center">
            <tr height="20">
                <td width="10%" align="center">栏目ID</td>
                <td width="30%" align="center">栏目名称</td>
                <td width="50%" align="center">文章标题</td>
                <td width="10%" align="center">删除</td>
            </tr>
            <%
                if (relArticle.size() != 0) {
                    for (int i = 0; i < relArticle.size(); i++) {
                        relatedArticle relatearticle = (relatedArticle) relArticle.get(i);
                        String relateColumn = relatearticle.getChineseName();
                        relateColumn = StringUtil.gb2iso4View(relateColumn);
            %>
            <tr>
                <td width="10%"><input name="columnid<%=i+1%>" type="text" value="<%=relatearticle.getJointedID()%>"
                                       readonly></td>
                <td width="30%"><%=relateColumn%><input type="hidden" name="columnname<%=i+1%>"
                                                        value="<%=relateColumn%>"></td>
                <td width="50%"><input name="maintitle<%=i+1%>" type="text" 
                                       value="<%=relatearticle.getTitle()==null?maintitle:relatearticle.getTitle()%>"></td>
                <td width="10%"><input type="button" value="删除" onclick=delete_row(<%=i+1%>);></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <input type="radio" name="useArticleType" value="0" checked><font style="font-size:9pt">推荐文章链接</font>&nbsp;
                <input type="radio" name="useArticleType" value="1"><font style="font-size:9pt">推荐文章内容</font>
            </tr>
            <tr>
                <td colspan="3">
                    <div align="center">
                        <button class=tine onclick="selectClass();">确 定</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button class=tine onclick="top.close();">取 消</button>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>