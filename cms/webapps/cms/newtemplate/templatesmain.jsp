<%@ page import="java.sql.*,
		 java.util.*,
		 java.text.*,
		 com.bizwink.cms.news.*,
		 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
   // get parameters
   int columnID  = ParamUtil.getIntParameter(request, "column", 0);
   int start = ParamUtil.getIntParameter(request,"start",0);
   int range = ParamUtil.getIntParameter(request,"range",10);
   String msg = ParamUtil.getParameter(request,"msg");

   IColumnManager columnManager = ColumnPeer.getInstance();
   Column column = columnManager.getColumn(columnID);
   String name = column.getCName();
%>
<html><head>
<title></title>
<link rel=stylesheet type=text/css href="../style/global.css">
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%-- begin tollbars --%>
<%
   String[][] titlebars = {
      { "ģ�����", "tempplatesmain.jsp" },
      { name, "" }
   };

   String[][] operations = {
      { "����ģ��", "createtemplate.jsp?column="+columnID }
   };
%>
<%@ include file="../inc/titlebar.jsp" %>

<%
   // get an list of templates
   ITemplateManager templateMgr = TemplatePeer.getInstance();
   int total = templateMgr.getTemplateCount(columnID);
   List templateList = null;
   int templateCount = 0;
   templateList = templateMgr.getTemplates(columnID, start, range);
   templateCount = templateList.size();
%>
<%
   if( msg != null ) {
%>
      <span class=cur><%= msg %></span>
<%
   }
%>

<%
   if( (templateCount>0) ) {
%>
   <table cellpadding=1 cellspacing=1 border=0 width=100%>
   <tr><td width=50% align=left nowrap class=tine>
<%
   if( (start-range) >= 0 ) {
%>
     &laquo; <a href="templates.jsp?column=<%=columnID%>&range=<%=range%>&start=<%=(start-range)%>">ǰһҳ <%= range %></a>
<%
   } else {
%>
   &nbsp;
<%
   }
%>
   </td>
   <td width=50% align=right nowrap class=tine>
<%
   if( (start+range) < total ) { %>
      <a href="templates.jsp?column=<%=columnID%>&range=<%=range%>&start=<%=(start+range)%>">��һҳ<%= ((start+range-total)<range)?(total-range):range %></a> &raquo;
<%
   } else {
%>
   &nbsp;
<%
   }
%>
   </td></tr></table>
<%
   }
%>

<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
<tr bgcolor=#dddddd class=tine>
<td align=center width='20%'>�������</td>
<td align=center width='20%'>����ģ��(Y/N)</td>
<td align=center width='20%'>�༭</td>
<td align=center width='20%'>�޸�</td>
<td align=center width='20%'>ɾ��</td></tr>

<%
   // iterate through users, show info
   int rowColor = 0;
   String bgcolor = "";
   for ( int i=0; i<templateCount; i++) {
        Template template = (Template)templateList.get(i);
        int templateID = template.getID();
        String partner  = template.getPartner();
        int isArticle  = template.getIsArticle();
        String editor  = template.getEditor();
        rowColor=i;
      if( rowColor%2 == 0 ) {
	 bgcolor = "#ffffcc";
      } else {
	 bgcolor = "#eeeeee";
      }
%>

<tr bgcolor=<%=bgcolor%> class=line>
<td><%=partner %></td>
<td><%= (isArticle == 1 )? "��":"����" %></td>
<td><%= editor %></td>
<td align=center><a href="edittemplate.jsp?template=<%=templateID%>">
<img src=../images/edit.gif align=bottom border=0></a>
<td align=center><a href="removetemplate.jsp?template=<%=templateID%>">
<img src="../images/del.gif" align="bottom" border=0></a></td>
</tr>
<%
   }
%>
</table></center>
</BODY></html>