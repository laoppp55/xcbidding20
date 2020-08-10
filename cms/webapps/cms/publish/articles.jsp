<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=utf-8" %>
<%@ page import="com.bizwink.cms.orderArticleListManager.orderArticleListPeer" %>
<%@ page import="com.bizwink.cms.orderArticleListManager.IOrderArticleListManager" %>
<%@ page import="com.bizwink.cms.tree.TreeManager" %>
<%@ page import="com.bizwink.cms.tree.Tree" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }
    request.setCharacterEncoding("UTF-8");
    int siteid=authToken.getSiteID();
    String sitename = authToken.getSitename();
    int samsiteid=authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();
    String username = authToken.getUserID();
    int listShow = authToken.getListShow();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int msgno = ParamUtil.getIntParameter(request, "msgno", 1);
    boolean doSearch = ParamUtil.getBooleanParameter(request, "doSearch");
    int total = 0;
    int totalpages = 0;
    int flag = 0;
    int extra = 0;
    int count = 0;
    IColumnManager columnManager = ColumnPeer.getInstance();
    IArticleManager articleMgr = ArticlePeer.getInstance();
    IOrderArticleListManager orderArticleMgr = orderArticleListPeer.getInstance();
    List list = null;
    if (doSearch) {
        String item = ParamUtil.getParameter(request,"item");
        String value = ParamUtil.getParameter(request,item);
        value = StringUtil.replace(value,"'","''");
        try {
            list = orderArticleMgr.searchArticles(columnID, item, value, username, start, range,siteid,flag,0);
            total = orderArticleMgr.searchArticlesCount(columnID, item, value, username,siteid);
            count = list.size();
            totalpages = total/20;
            if (total % 20 > 0) extra = total % 20;
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        //System.out.println("columnID:" + columnID);
        //System.out.println("start:" + start);
        //System.out.println("range:" + range);
        //System.out.println("listShow:" + listShow);
        //System.out.println("siteid:" + siteid);
        //System.out.println("samsiteid:" + samsiteid);
        //System.out.println("sitetype:" + sitetype);
        if (SecurityCheck.hasPermission(authToken, 6) || SecurityCheck.hasPermission(authToken, 54)) {    //用户是否有文章发布的权限
            total = articleMgr.getNewPublishArticlesNum(null,columnID, siteid, samsiteid, sitetype);
            list = articleMgr.getNewPublishArticles(null,columnID, start, range, listShow, siteid, samsiteid, sitetype);
            count = list.size();
            totalpages = total / 20;
            if (total % 20 > 0) extra = total % 20;
        } else if (SecurityCheck.hasPermission(authToken, 8)) {
            total = articleMgr.getNewPublishArticlesNum(username,columnID, siteid, samsiteid, sitetype);
            list = articleMgr.getNewPublishArticles(username,columnID, start, range, listShow, siteid, samsiteid, sitetype);
            count = list.size();
            totalpages = total / 20;
            if (total % 20 > 0) extra = total % 20;
        }
    }

    Tree colTree = null;
    if (sitetype == 0)
        colTree = TreeManager.getInstance().getSiteTree(siteid);
    else
        colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
    sitename = StringUtil.replace(sitename,"_",".");
    String cname = colTree.getChineseDirForArticle(colTree,columnID,sitename);
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language=javascript>
        function moreSearch()
        {
            if (searchDiv.style.display == "")
                searchDiv.style.display = "none";
            else
                searchDiv.style.display = "";
        }

        function golist(id, type) {
            var r = Headers.jump.value;
            var bor = (r - 1) * 20;
            if (isNumber(r)) {
                window.location = "articles.jsp?start=" + bor + "&column=" + id + "&flag=" + type;
            }
        }

        function isNumber(num) {
            var strRef = "1234567890";
            for (i = 0; i < num.length; i++)
            {
                tempChar = num.substring(i, i + 1);
                if (strRef.indexOf(tempChar, 0) == -1) {
                    alert("输入页码不正确！");
                    return false;
                }
            }
            return true;
        }

        function search(item)
        {
            Headers.action = "articles.jsp?doSearch=true&item=" + item;
            Headers.submit();
        }

        function checkNum(str)
        {
            var success = true;
            for (var i = 0; i < str.length; i++)
            {
                if (str.substring(i, i + 1) < '0' || str.substring(i, i + 1) > '9')
                {
                    success = false;
                    break;
                }
            }
            return success;
        }

        function CA()
        {
            for (var i = 0; i < document.Headers.elements.length; i++)
            {
                var e = document.Headers.elements[i];
                if (e.name!='columnall' && e.name != 'allbox' && e.type == 'checkbox' && e.name != 'option')
                {
                    e.checked = document.Headers.allbox.checked;
                }
            }

            document.Headers.columnall.checked = false;
        }

        function deselCA() {
            document.Headers.allbox.checked = false;
            for (var i = 0; i < document.Headers.elements.length; i++) {
                var e = document.Headers.elements[i];
                if (e.name!='columnall' && e.name != 'allbox' && e.type == 'checkbox' && e.name != 'option') {
                    e.checked = document.Headers.allbox.checked;
                }
            }
            document.Headers.columnall.checked = true;
        }

        function PreviewArticle(articleID, columnId) {
            window.open("../article/preview.jsp?article=" + articleID + "&column=" + columnId, "Preview", "width=800,height=600,left=0,top=0,scrollbars");
        }

        function PreviewTemplate(templateID, isArticle, columnID) {
            window.open("../template/previewTemplate.jsp?column=" + columnID + "&template=" + templateID + "&isArticle=" + isArticle, "Preview", "width=800,height=600,left=0,top=0,scrollbars");
        }

        function goPublish() {
            if (document.Headers.allbox.checked == true) {
                document.Headers.action="publish.jsp";
                document.Headers.submit();
                return true;
            } else if (document.Headers.columnall.checked == true) {
                document.Headers.action="publishall.jsp";
                document.Headers.submit();
                return true;
            } else {
                var count = <%=count%>;
                var selected_flag = false;
                for (var ii=0;ii<count; ii++){
                    selected_flag =eval("document.Headers.selected" + ii + ".checked");
                    if (selected_flag == true) break;
                }

                //判断是否有需要发布的文章被选择
                if (selected_flag == false) {
                    alert("请选择需要发布的信息！");
                    return false;
                } else {
                    document.Headers.action="publish.jsp";
                    document.Headers.submit();
                    return true;
                }
            }
        }
    </script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
    <%
        String[][] titlebars = {
                {"文章发布", ""},
                {StringUtil.gb2iso4View(cname), ""}
        };
        String[][] operations = {
                {"重新发布", "republish.jsp?column=" + columnID},
                {"发布失败的文章", "publishfailed.jsp?column=" + columnID}
        };
    %>
    <%@ include file="../inc/titlebar.jsp" %>
    <%
        if (msgno == 0)
            out.println("<span class=cur>页面发布成功！</span>");
        else if (msgno == -1)
            out.println("<span class=cur>读取文章时出现错误！</span>");
        else if (msgno == -2)
            out.println("<span class=cur>读取模板时出现错误！</span>");
        else if (msgno == -3)
            out.println("<span class=cur>处理标记时出现错误！</span>");
        else if (msgno == -4)
            out.println("<span class=cur>读取样式文件时出现错误！</span>");
        else if (msgno == -9)
            out.println("<span class=cur>发布出现意外错误！</span>");

        if (count > 0) {
            out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
            out.println("<tr><td width=50% align=left class=line>");
            if (start - range >= 0)
                out.println("<a href=articles.jsp?column=" + columnID + "&range=" + range + "&start=" + (start - range) + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
            out.println("</td><td width=50% align=right class=line>");
            if (start + range < total) {
                int remain = ((start + range - total) < range) ? (total - start - range) : range;
                out.println(remain + "<a href=articles.jsp?column=" + columnID + "&range=" + range + "&start=" + (start + range) + "><img src=../images/btn_next.gif align=bottom border=0></a>");
            }
            out.println("</td></tr></table>");
        }
    %>

    <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
        <form method="Post" name=Headers onsubmit="return goPublish();">
            <input type=hidden name=doSearch value="<%=doSearch%>">
            <input type=hidden name=count value="<%=count%>">
            <input type=hidden name=column value="<%=columnID%>">
            <input type=hidden name=start value="<%=start%>">
            <input type=hidden name=range value="<%=range%>">
            <tr class=itm bgcolor="#dddddd" height=20>
                <td align=center width="10%">状态</td>
                <td align=center width="8%">操作</td>
                <td align=center width="35%">标题</td>
                <td align=center width="14%">所属栏目</td>
                <td align=center width="15%">修改时间</td>
                <td align=center width="10%">编辑</td>
                <td align=center width="8%">预览</td>
            </tr>
                <%
          for (int i = 0; i < count; i++) {
            Article article = (Article) list.get(i);

            int articleID = article.getID();         //文章ID或模板ID
            boolean isown = article.isIsown();
            String editor = article.getEditor();     //文章或模板的编辑者
            String lastUpdated = article.getLastUpdated().toString().substring(0, 19); //文章或模板的最后修改时间
            int cid = article.getColumnID();         //文章或模板所属栏目ID
            String columnName = columnManager.getColumn(cid).getCName();  //当前栏目中文名称
            columnName = StringUtil.gb2iso4View(columnName);
            String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";

            int isArticleTemplate = 0;     //是文章模板还是栏目模板或首页模板
            String maintitle = StringUtil.gb2iso4View(article.getMainTitle());  //文章标题
            boolean isTemplate = article.getIsTemplate();    //是文章还是模板
            if (isTemplate) {
              int status = article.getStatus();      //是否为默认模板
              maintitle = article.getMainTitle();    //模板中文名称
              if (maintitle == null) maintitle = "";
              maintitle = StringUtil.gb2iso4View(maintitle);
              isArticleTemplate = article.getIsArticleTemplate();
              if (isArticleTemplate == 0) {
                if (status == 1)
                  maintitle = "<font color=red>" + maintitle + "(默认栏目模板)</font>";
                else
                  maintitle = "<font color=red>" + maintitle + "(栏目模板)</font>";
              } else if (isArticleTemplate == 2) {
                if (status == 1)
                  maintitle = "<font color=red>" + maintitle + "(默认首页模板)</font>";
                else
                  maintitle = "<font color=red>" + maintitle + "(首页模板)</font>";
              } else if (isArticleTemplate == 3) {
                maintitle = "<font color=red>" + maintitle + "(专题模板)</font>";
              } else if (isArticleTemplate == 4) {
                maintitle = "<font color=red>" + maintitle + "WAP栏目模板</font>";
              }
            } else {
              isArticleTemplate = 1;           //是发布文章，类型设置为1
            }

            out.println("<tr bgcolor=" + bgcolor + " height=25>");
            out.println("<td align=center><img src=\"../images/button/xin.gif\" border=0 alt=\"准备发布\"></td>");
            out.println("<td align=center>选中");
            out.println("<input type=checkbox name=selected" + i + " value=\"" + articleID + "\">");
            out.println("<input type=hidden name=template" + i + " value=\"" + isTemplate + "\">");
            out.println("<input type=hidden name=type" + i + " value=\"" + isArticleTemplate + "\">");
            out.println("<input type=hidden name=column" + i + " value=\"" + cid + "\">");
            out.println("<input type=hidden name=isown"+i+" value="+isown+">");
            out.println("</td>");
            out.println("<td>" + maintitle + "</td>");
            out.println("<td align=center>" + columnName + "</td>");
            out.println("<td align=center>" + lastUpdated + "</td>");
            out.println("<td>&nbsp;" + editor + "</td>");
            if (isTemplate)
              out.println("<td align=center><a href=javascript:PreviewTemplate(" + articleID + "," + isArticleTemplate + "," + cid + ");>");
            else
              out.println("<td align=center><a href=javascript:PreviewArticle(" + articleID + "," + cid + ");>");
            out.println("<img src=\"../images/button/view.gif\" border=0 alt=\"预览\"></a></td>");
            out.println("</tr>");
          }
        %>
    </table>
    <br>
    <table border=0 cellPadding=0 cellSpacing=0 width="100%">
        <tr>
            <td align=center><input type=submit name=publish value="  发 布  "></td>
            <td class=itm align=center><input type=checkbox name="allbox" value="CheckAll" onClick="CA();">全部选中</td>
            <td align=center><input type=checkbox name="columnall" value="all"  onClick="deselCA();">发布本栏目所有文章</td>
        </tr>
        <tr>
            <td height="50px">&nbsp;</td>
        </tr>

        <tr>
            <td align=center>标&nbsp;&nbsp;题：&nbsp;&nbsp;<input type="text" name=maintitle size=30></td>
            <td class=itm align=center><input style="height:20;width:40;font-size:9pt" type=button value=" 搜索 " onclick="search('maintitle');">
                <!--a href="javascript:moreSearch();">高级搜索</a-->
            </td>
            <td>当前栏目的文章总数为：<%=total%>&nbsp;&nbsp;
                <%if (totalpages >= 1) {%>总<%=totalpages%>页&nbsp;第<%=(start + range) / 20%>页&nbsp;&nbsp;
                到第<input type="text" name="jump" value="<%=(start+range)/20%>" size="2">
                <a href="javascript:golist(<%=columnID%>,<%=flag%>);">GO</a><%}%>
            </td>
        </tr>
    </table>
    </form>
</center>
</body>
</html>