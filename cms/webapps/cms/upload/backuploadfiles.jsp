<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=utf-8"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
    return;
  }

  String username = authToken.getUserID();
  int columnID = ParamUtil.getIntParameter(request,"column",0);
  int start = ParamUtil.getIntParameter(request,"start",0);
  int range = ParamUtil.getIntParameter(request,"range",20);
  String msg = ParamUtil.getParameter(request,"msg");

  IColumnManager columnManager = ColumnPeer.getInstance();
  Column column = columnManager.getColumn(columnID);
  String CName = StringUtil.gb2iso4View(column.getCName());

  IArticleManager articleMgr = ArticlePeer.getInstance();
  int total = articleMgr.getBackArticlesNum(columnID, username, 2);
  List articleList = articleMgr.getBackArticles(columnID, username, start, range, 2);
  int articleCount = articleList.size();
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<SCRIPT LANGUAGE=JavaScript>
function Preview(articleID)
{
  window.open("../article/Preview.jsp?article="+articleID, "Preview", "width=800,height=600,left=5,top=5,scrollbars");
}
</SCRIPT>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
	String[][] titlebars = {
		{ "文件上传管理", "index.jsp" },
		{ CName, "" }
	};
	String[][] operations = {
		{"新稿", "listuploadfiles.jsp?column="+columnID},
		{"未用", "unuseduploadfile.jsp?column="+columnID},
		{"审核", "audituploadfiles.jsp?column="+columnID}
	};
%>
<%@ include file="../inc/titlebar.jsp" %>
<%
  if (msg != null)	out.println("<span class=cur>" + msg + "</span>");
  if (articleCount > 0)
  {
    out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
    out.println("<tr><td width=50% align=left class=line>");
    if (start - range >= 0)
      out.println("<a href=listuploadfiles.jsp?column="+columnID+"&range="+range+"&start="+(start-range)+"><img src=../images/btn_previous.gif align=bottom border=0></a>"+start);
    out.println("</td><td width=50% align=right class=line>");
    if (start + range < total)
    {
      int remain = ((start+range-total)<range)?(total-start-range):range;
      out.println(remain+"<a href=listuploadfiles.jsp?column="+columnID+"&range="+range+"&start="+(start+range)+"><img src=../images/btn_next.gif align=bottom border=0></a>");
    }
    out.println("</td></tr></table>");
  }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
  <tr class=itm bgcolor="#dddddd">
    <td align=center width="8%">状态</td>
    <td align=center width="40%">标题</td>
    <td align=center width="20%">发布时间</td>
    <td align=center width="8%">排序</td>
    <td align=center width="8%">编辑</td>
    <td align=center width="8%">预览</td>
    <td align=center width="8%">修改</td>
  </tr>
<%
  for (int i=0; i<articleCount; i++)
  {
    Article article = (Article)articleList.get(i);

    int articleID = article.getID();
    String maintitle = StringUtil.gb2iso4View(article.getMainTitle());
    String editor = StringUtil.gb2iso4View(article.getEditor());
    String createdate = article.getPublishTime().toString().substring(0,16);
    int sortId = article.getSortID();
    String bgcolor = (i%2==0)?"#ffffcc":"#eeeeee";
    out.println("<tr bgcolor="+bgcolor+" class=itm height=20>");
    out.println("<td align=center><font color=green>退稿</font></td>");
%>
    <td>&nbsp;&nbsp;<%=maintitle%></td>
    <td align=center><%=createdate%></td>
    <td align=center><%=sortId%></td>
    <td align=center><%=editor%></td>
    <td align=center><a href=javascript:Preview(<%=articleID%>);><img src="../images/preview.gif" border=0></a></td>
    <td align=center><a href="edituploadfile.jsp?article=<%=articleID%>"><img src="../images/edit.gif" align="bottom" border=0></a></td>
  </tr>
<%}%>
</table>

</BODY>
</html>
