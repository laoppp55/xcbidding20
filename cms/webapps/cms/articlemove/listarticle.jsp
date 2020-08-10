<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.tree.TreeManager" %>
<%@ page import="com.bizwink.cms.tree.Tree" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }
    int siteid=authToken.getSiteID();
    String sitename = authToken.getSitename();
    int samsiteid = authToken.getSamSiteid();

    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    String msg = ParamUtil.getParameter(request, "msg");
    String content = ParamUtil.getParameter(request, "content");

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String CName = StringUtil.gb2iso4View(column.getCName());

    IArticleManager articleMgr = ArticlePeer.getInstance();
    List articleList = articleMgr.getMoveArticles(columnID, start, range, content,siteid);
    int total = articleMgr.getMoveArticlesNum(columnID, content,siteid);
    int articleCount = articleList.size();

    Tree colTree = null;
    if (samsiteid == 0)
        colTree = TreeManager.getInstance().getSiteTree(siteid);
    else
        colTree = TreeManager.getInstance().getSiteTreeIncludeSampleSite(siteid,samsiteid);
    sitename = StringUtil.replace(sitename,"_",".");
    String cname = colTree.getChineseDirForArticle(colTree,columnID,sitename);
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
</head>
<script language="javascript">
    function checkwhat() {
        var strVal = movearticle.columnid.value;
        var strVal1 = movearticle.oldcolumnID.value;
        var selectone = false;

        if (strVal == "") {
            alert("目的栏目不能为空，请选择文章需要移到的栏目名称")
            return false;
        }

        if (strVal == strVal1) {
            alert("目的栏目不能和源栏目相同")
            return false;
        }

        for (var i = 0; i < document.movearticle.elements.length; i++) {
            var e = document.movearticle.elements[i];
            if (e.name != 'allbox' && e.type == 'checkbox' && e.name != 'option') {
                if (e.checked) {
                    selectone = true;
                    break;
                }
            }
        }

        if (!selectone) {
            alert("请您选择需要移动或者需要拷贝的文章");
            return false;
        }
        return true;
    }

    function submitit() {
        if (checkwhat()) {
            movearticle.action = "moveok.jsp";
            movearticle.submit();
            return true;
        } else {
            return false;
        }
    }

    function copyit() {
        if (checkwhat()) {
            movearticle.action = "copyok.jsp";
            movearticle.submit();
            return true;
        } else {
            return false;
        }
    }

    function cancelit() {
        document.movearticle.columnname.value = "";
        document.movearticle.columnid.value = "";
    }

    function CA() {
        for (var i = 0; i < document.movearticle.elements.length; i++) {
            var e = document.movearticle.elements[i];
            if (e.name != 'allbox' && e.name != 'execute' && e.name != 'moveall' && e.type == 'checkbox' && e.name != 'option')
                e.checked = document.movearticle.allbox.checked;
        }
    }

    function Preview(articleID) {
        window.open("../article/preview.jsp?article=" + articleID, "Preview", "width=800,height=600,left=5,top=5,scrollbars");
    }

    function searchit() {
        movearticle.action = "listarticle.jsp?column=<%=columnID%>&start=<%=start%>&range=<%=range%>";
        movearticle.submit();
    }

    function selectTColumn() {
        win = window.open("selectColumnTree.jsp", "", "width=500,height=400");
        win.focus();
    }
</script>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"文章移动", ""},
            {StringUtil.gb2iso4View(cname), ""}
    };
    String[][] operations = {
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<%
    if (msg != null) out.println("<center><span class=cur>" + msg + "</span></center>");
    if (articleCount > 0) {
        if (content == null) content = "";
        out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
        out.println("<tr><td width=50% align=left class=line>");
        if (start - range >= 0)
            out.println("<a href=listarticle.jsp?column=" + columnID + "&range=" + range + "&start=" + (start - range) + "&content=" + content + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
        out.println("</td><td width=50% align=right class=line>");
        if (start + range < total) {
            int remain = ((start + range - total) < range) ? (total - start - range) : range;
            out.println(remain + "<a href=listarticle.jsp?column=" + columnID + "&range=" + range + "&start=" + (start + range) + "&content=" + content + "><img src=../images/btn_next.gif align=bottom border=0></a>");
        }
        out.println("</td></tr></table>");
    }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
    <form name="movearticle" method="Post">
        <input type=hidden name=artcount value=<%=articleCount%>>
        <input type=hidden name=oldcolumnID value=<%=columnID%>>
        <tr class=itm bgcolor="#dddddd" height=20>
            <td align=center width="6%">选中</td>
            <td align=center width="60%">标题</td>
            <td align=center width="8%">排序</td>
            <td align=center width="10%">创建时间</td>
            <td align=center width="10%">编辑</td>
            <td align=center width="6%">预览</td>
        </tr>
        <%

          for (int i=0; i<articleCount; i++)
          {
            Article article = (Article)articleList.get(i);

            int articleID = article.getID();
            String maintitle = StringUtil.gb2iso4View(article.getMainTitle());
            String editor = StringUtil.gb2iso4View(article.getEditor());
            String createdate = article.getPublishTime().toString().substring(0,10);
            int sortId = article.getSortID();
            String bgcolor = (i%2==0)?"#ffffff":"#eeeeee";

            out.println("<tr height=25 bgcolor=" + bgcolor + " onmouseover=\"this.style.background='#CECEFF';\" onmouseout=\"this.style.background='" + bgcolor + "';\">");
            out.println("<td align=center><input type=checkbox name=selected"+i+" value="+articleID +"></td>");
            out.println("<td>" + maintitle + "</td>");
            out.println("<td align=center>" + sortId + "</td>");
            out.println("<td align=center>" + createdate + "</td>");
            out.println("<td>" + editor + "</td>");
            out.println("<td align=center>");
            out.println("<a href=javascript:Preview("+articleID+");><img border=0 src=../images/preview.gif></a>");
            out.println("</td>");
            out.println("</tr>");
          }

        %>
        <tr>
            <td colspan=6 class=itm align=center>
                <input type=checkbox name=allbox value="CheckAll" onClick="CA();">全选&nbsp;&nbsp;&nbsp;&nbsp;
                <input type=checkbox name=execute value=1>强制执行&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" name="moveall" value="1">源栏目下所有文章
            </td>
        </tr>
</table>
<table cellpadding="1" cellspacing="1" border="0" width="100%">
    <tr>
        <td width="40%">目的栏目名称：<input id="columnname" name="columnname" size="22" readonly ondblclick="selectTColumn();">(请双击输入框选择栏目)
            <input type=hidden id="columnid" name="columnid" size="5" readonly></td>
        <td width="20%">
            <input type=button value=" 移动 " onclick="submitit();">&nbsp;&nbsp;
            <input type=button value=" 拷贝 " onclick="copyit();">&nbsp;&nbsp;
            <input type=button value=" 取消 " onclick="cancelit();">
        </td>
        <td width="40%" align=right>标题：<input id="content" name="content" size="25"><input type=button value=" 搜索 "
                                                                                           onclick="searchit();"></td>
    </tr>
</table>
</form>

</BODY>
</html>