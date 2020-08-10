<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.extendAttr.*"
         contentType="text/html;charset=utf-8"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int cid = ParamUtil.getIntParameter(request, "cid", 0);          //目的栏目
    int columnID = ParamUtil.getIntParameter(request, "column", 0);  //原始栏目
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 40);
    String msg = ParamUtil.getParameter(request, "msg");
    if (columnID == 0 || cid == 0) return;

    int articleID = 0;
    Article article = null;
    IArticleManager articleMgr = ArticlePeer.getInstance();
    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(cid);
    String CName = StringUtil.gb2iso4View(column.getCName());

    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    if (doCreate) {
        List articleList = ParamUtil.getParameterValues(request, "articleID");
        int useArticleType = ParamUtil.getIntParameter(request, "useArticleType", 0);
        if (articleList.size() > 0)
            try {
                extendMgr.referArticle(articleList, cid, authToken.getSiteID(), useArticleType);
            } catch (ExtendAttrException e) {
                e.printStackTrace();
            }

        out.println("<script language=\"JavaScript\">parent.opener.history.go(0);parent.window.close();</script>");
        return;
    }

    int total = articleMgr.getReferArticlesNum(columnID);
    List articleList = articleMgr.getReferArticles(columnID, start, range);
    int articleCount = articleList.size();
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=utf-8">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="JavaScript">
        function PreviewArticle(articleID)
        {
            window.open("../article/preview.jsp?article=" + articleID, "Preview", "width=800,height=600,left=0,top=0,scrollbars");
        }

        function CA()
        {
            for (var i = 0; i < form1.elements.length; i++)
            {
                var e = form1.elements[i];
                if (e.name != 'allbox' && e.type == 'checkbox' && e.name != 'option')
                {
                    e.checked = form1.allbox.checked;
                }
            }
        }
    </script>
</head>
<BODY BGCOLOR="#ffffff" LINK="#000099" ALINK="#cc0000" VLINK="#000099" TOMARGIN=8>
<%
    if (msg != null) out.println("<span class=cur>" + msg + "</span>");
    if (articleCount > 0) {
        out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
        out.println("<tr><td width=50% align=left class=line>");
        if (start - range >= 0)
            out.println("<a href=referArticleRight.jsp?cid=" + cid + "&column=" + columnID + "&range=" + range + "&start=" + (start - range) + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
        out.println("</td><td width=50% align=right class=line>");
        if (start + range < total) {
            int remain = ((start + range - total) < range) ? (total - start - range) : range;
            out.println(remain + "<a href=referArticleRight.jsp?cid=" + cid + "&column=" + columnID + "&range=" + range + "&start=" + (start + range) + "><img src=../images/btn_next.gif align=bottom border=0></a>");
        }
        out.println("</td></tr></table>");
    }
%>
<form action="referArticleRight.jsp?cid=<%=cid%>&column=<%=columnID%>" method="post" name=form1>
    <input type=hidden name=doCreate value=true>
    <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
        <tr>
            <td colspan=5>当前所在栏目-->><font color=red><%=CName%>
            </font></td>
        </tr>
        <tr bgcolor="#dddddd" height=20>
            <td align=center width="10%">选中</td>
            <td align=center width="50%">标题</td>
            <td align=center width="15%">编辑</td>
            <td align=center width="15%">创建时间</td>
            <td align=center width="10%">预览</td>
        </tr>
        <%
            for (int i = 0; i < articleCount; i++) {
                article = (Article) articleList.get(i);

                articleID = article.getID();       //文章ID或模板ID
                String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
                String createDate = article.getPublishTime().toString().substring(0, 16); //文章或模板的最后修改时间
                String maintitle = StringUtil.gb2iso4View(article.getMainTitle());

                out.println("<tr height=25 bgcolor=" + bgcolor + " onmouseover=\"this.style.background='#CECEFF';\" onmouseout=\"this.style.background='" + bgcolor + "';\">");
                out.println("<td align=center><input type=checkbox name=articleID value=" + articleID + "></td>");
                out.println("<td>&nbsp;" + maintitle + "</td>");
                out.println("<td>&nbsp;" + article.getEditor() + "</td>");
                out.println("<td align=center>" + createDate + "</td>");
                out.println("<td align=center>");
                if (article.getNullContent() == 0)
                    out.println("<a href=javascript:PreviewArticle(" + articleID + ");><img src=../images/button/view.gif border=0></a>");
                else
                    out.println("&nbsp;");
                out.println("</td></tr>");
            }
        %>
    </table>
    <input type=checkbox name=allbox value="CheckAll" onClick="CA();"><font style="font-size:9pt">全部选中</font>&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="radio" name="useArticleType" value="0" checked><font style="font-size:9pt">引用文章链接</font>&nbsp;
    <input type="radio" name="useArticleType" value="1"><font style="font-size:9pt">引用文章内容</font>
    <p align=center>
        <input type=submit value="  确定  ">&nbsp;&nbsp;
        <input type=button value="  取消  " onclick="window.parent.close();">
    </p>
</form>
</BODY>
</html>