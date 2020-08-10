<%@ page import="java.sql.*,
    java.util.*,
    java.text.*,
	com.bizwink.cms.news.*,
	com.bizwink.cms.security.*,
	com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
    if( authToken == null ) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int columnID  = ParamUtil.getIntParameter(request, "column", 0);
    int start = ParamUtil.getIntParameter(request,"start",0);
    int range = ParamUtil.getIntParameter(request,"range",20);
    String msg = ParamUtil.getParameter(request,"msg");

    IArticleManager articleMgr = ArticlePeer.getInstance();
    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String CName = StringUtil.gb2iso4View(column.getCName());
%>
<html><head>
<title>��������</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
<link rel=stylesheet type=text/css href="../style/global.css"></head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%	String[][] titlebars = {
	        { "���¹���", "articlesmain.jsp" },
	        { CName, "" }
	};
	String[][] operations = {
	        {"������","createarticle.jsp?column="+columnID },
                {"�˸�����","returnarticle.jsp?column="+columnID},
                {"��������","auditarticle.jsp?column="+columnID},
                {"δ������","unusedarticle.jsp?column="+columnID},
                {"��������","allarticles.jsp?column="+columnID}
	};
%>
<%@ include file="../inc/titlebar.jsp" %>
<%
    // get an list of articles
    List articleList = null;
    int articleCount = 0;
    int noContent = 1;
    int status = 1;
    articleList = articleMgr.getAllUsedArticles(columnID, start, range,noContent);
    int total = articleMgr.getArticleNum(columnID,noContent,status);
    articleCount = articleList.size();
    if( msg != null ) {
        out.println("<span class=cur>"+msg+"</span>");
    }

    if( (articleCount>0) ) {
        out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
        out.println("<tr><td width=50% align=left class=line>");
        if( (start-range) >= 0 ) {
         out.println("<a href=articles.jsp?column="+columnID+"&range="+range+"&start="+(start-range)+"><img src=../images/btn_previous.gif align=bottom border=0></a>"+start);
      } else {
         out.println("&nbsp;");
      }
      out.println("</td><td width=50% align=right class=line>");
      if( (start+range) < total ) {
	      int remain = ((start+range-total)<range)?(total-start-range):range;
	      out.println(remain+"<a href=articles.jsp?column="+columnID+"&range="+range+"&start="+(start+range)+"><img src=../images/btn_next.gif align=bottom border=0></a>");
      } else {
        out.println("&nbsp;");
      }
      out.println("</td></tr></table>");
   }
%>
    <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
    <tr class= itm bgcolor='#dddddd'>
    <td align=center width="5%">״̬</td>
    <td align=center width="35%">����</td>
    <td align=center width='15%'>����ʱ��</td>
    <td align=center width="5%">����</td>
    <td align=center width="8%">�༭</td>
    <td align=center width="8%">Ԥ��</td>
    <td align=center width="8%">����</td>
    <td align=center width="8%">ɾ��</td></tr>
    <%
    for ( int i=0; i<articleCount; i++) {
        Article article = (Article)articleList.get(i);
        int articleID = article.getID();
        String maintitle = StringUtil.gb2iso4View(article.getMainTitle());
        String editor = article.getEditor();
        String createdate = article.getPublishTime().toString().substring(0,16);
        int sortId = article.getSortID();
        status = article.getStatus();
        int auditflag = article.getAuditFlag();
        int pubflag = article.getPubFlag();
        String bgcolor = (i%2==0)?"#ffffcc":"#eeeeee";
    %>
    <tr bgcolor=<%=bgcolor%> class=itm>
    <%
        if (auditflag == 0) {
             switch (pubflag) {
    	        case 0:
    		    out.print("<td align=center><font color=green>�Է���</font></td>");
    		    break;
    	        case 1:
    		    out.print("<td align=center><font color=blue>�¸�</font></td>");
                    break;
                case 2:
    		     out.print("<td align=center><font color=red>����ʧ��</font></td>");
    		     break;
    	        default:
    		     break;
             }
        } else if (auditflag == 1){
    		    out.print("<td align=center><font color=blue>�����</font></td>");
        } else if (auditflag == 1) {
    		    out.print("<td align=center><font color=blue>�˸�</font></td>");
        }
    %>
    <td><%= maintitle %></td>
    <td><%= createdate %></td>
    <td><%= sortId %></td>
    <td><%= editor %></td>
    <td align=center>
<input type=image src="../images/preview.gif" onclick="window.open('previewarticle.jsp?article=<%=articleID%>','','width=800,height=600,scrollbars=yes');return false;">
</td>
   <%//if ((status == 0 )||(status == 98)) {%>
   <td align=center>
	<a href="editarticle.jsp?article=<%=articleID%>&range=<%=range%>&start=<%=start%>">
	<img src="../images/edit.gif" align="bottom" border=0></a>
   </td>

   <%//} else{%>
   	<!--
	<td align=center><a href="viewarticle.jsp?article=<%=articleID%>">
        <img src="../images/edit.gif" align="bottom" border=0></a></td>
	-->
   <%//}%>

   <td align=center><a href="removearticle.jsp?article=<%=articleID%>">
    <img src="../images/del.gif" align="bottom" border=0></a></td></tr>
    <%
       }
    %>
    </table>
</BODY></html>