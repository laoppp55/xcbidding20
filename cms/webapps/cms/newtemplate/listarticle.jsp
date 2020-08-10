<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int modeltype = ParamUtil.getIntParameter(request, "modeltype", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    String msg = ParamUtil.getParameter(request, "msg");
    String content = ParamUtil.getParameter(request, "content");
    String extname = null;
    String CName = null;
    String columnURL = null;

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);

    if (column !=null) {
        extname = column.getExtname();
        CName = StringUtil.gb2iso4View(column.getCName());
        columnURL = column.getDirName();
    } else{
        CName = "����ģ��";
        columnURL = "/_prog/";
    }

    if (modeltype == 4 || modeltype == 5)
        extname = "wml";

    IArticleManager articleMgr = ArticlePeer.getInstance();
    int total = articleMgr.getLinkArticlesNum(columnID, content, modeltype);
    List articleList = articleMgr.getLinkArticles(columnID, start, range, content, modeltype);
    int articleCount = articleList.size();
%>

<html>
<head>
    <title>Articles</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
</head>
<script language="JavaScript">
    var linkType;
    var DHTMLSafe;

    function linkit(flag)
    {
        if(flag == 1){
            window.returnValue = linkform.oHref.value;
            window.parent.close();
        }else if(flag == 2){
            window.returnValue = "";
            window.parent.close();
        }
    }

    function PreviewArticle(articleID)
    {
        window.open("../article/preview.jsp?article=" + articleID, "Preview", "width=800,height=600,left=0,top=0,scrollbars");
    }

    function PreviewTemplate(templateID, isArticle, columnID)
    {
        window.open("previewTemplate.jsp?column=" + columnID + "&template=" + templateID + "&isArticle=" + isArticle, "Preview", "width=800,height=600,left=0,top=0,scrollbars");
    }

    function selectthis(para)
    {
        linkform.oHref.value = para.value;
    }

    function setlinkrules(columnID)
    {
        window.open("addlinkrules.jsp?column=" + columnID, "setLinkRules", "width=800,height=600,left=0,top=0,scrollbars");
    }
</script>

<BODY BGCOLOR="#ffffff" LINK="#000099" ALINK="#cc0000" VLINK="#000099" TOMARGIN=8>
<%
    if (msg != null) out.println("<span class=cur>" + msg + "</span>");
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
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
    <tr>
        <td colspan=5>��ǰ������Ŀ-->><font color=red><%=CName%>
        </font></td>
    </tr>
    <tr class=itm bgcolor="#dddddd">
        <td align=center width="15%">ѡ�и�����</td>
        <td align=center width="50%">����</td>
        <td align=center width="15%">�޸�ʱ��</td>
        <td align=center width="10%">�༭</td>
        <td align=center width="10%">Ԥ��</td>
    </tr>
    <%
        for (int i = 0; i < articleCount; i++) {
            Article article = (Article) articleList.get(i);

            int articleID = article.getID();       //����ID��ģ��ID
            String editor = article.getEditor();   //���»�ģ��ı༭��
            String bgcolor = (i % 2 == 0) ? "#ffffcc" : "#eeeeee";
            String lastUpdated = article.getLastUpdated().toString().substring(0, 10); //���»�ģ�������޸�ʱ��

            columnID = article.getColumnID();      //���»�ģ��������ĿID

            //������´���ʱ�䣬���ɷ���·���е�һ����
            String createdate_path = "";
            if(article.getCreateDate() != null){
                createdate_path = article.getCreateDate().toString();
                createdate_path = createdate_path.substring(0, 10).replaceAll("-","") + "/";
            }

            column = columnManager.getColumn(columnID);

            if (modeltype == 4 || modeltype == 5)
                extname = "wml";
            else {
                extname = column.getExtname();
                if (extname == null) extname = "html";
            }

            int isArticleTemplate = 0;             //������ģ�廹����Ŀģ�����ҳģ��
            String maintitle = StringUtil.gb2iso4View(article.getMainTitle());
            boolean isTemplate = article.getIsTemplate();    //�����»���ģ��
            if (isTemplate) {
                int status = article.getStatus();      //�Ƿ�ΪĬ��ģ��
                maintitle = article.getMainTitle();    //ģ����������
                if (maintitle == null) maintitle = "";
                maintitle = StringUtil.gb2iso4View(maintitle);
                isArticleTemplate = article.getIsArticleTemplate();

                if (isArticleTemplate == 0) {
                    if (status == 1)
                        maintitle = "<font color=red>" + maintitle + "(Ĭ����Ŀģ��)</font>";
                    else
                        maintitle = "<font color=red>" + maintitle + "(��Ŀģ��)</font>";
                } else {
                    if (status == 1)
                        maintitle = "<font color=red>" + maintitle + "(Ĭ����ҳģ��)</font>";
                    else
                        maintitle = "<font color=red>" + maintitle + "(��ҳģ��)</font>";
                }
            }

            out.println("<tr bgcolor=" + bgcolor + "class=itm>");
            if (isTemplate) {
                out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=" + columnURL + article.getFileName() + "." + extname + "></td>");
            } else {
                if (article.getNullContent() == 0)
                    out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=" + columnURL + createdate_path + articleID + "." + extname + "></td>");
                else
                    out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=" + columnURL + createdate_path + "download/" + article.getFileName() + "></td>");
            }
            out.println("<td>" + maintitle + "</td>");
            out.println("<td>" + lastUpdated + "</td>");
            out.println("<td>" + editor + "</td>");
            out.println("<td align=center>");
            if (isTemplate) {
                out.println("<a href=javascript:PreviewTemplate(" + articleID + "," + isArticleTemplate + "," + columnID + ");><img src=../images/button/view.gif border=0></a>");
            } else {
                if (article.getContent() != null)
                    out.println("<a href=javascript:PreviewArticle(" + articleID + ");><img src=../images/button/view.gif border=0></a>");
                else
                    out.println("<img src=../images/button/view.gif border=0>");
            }
            out.println("</td></tr>");
        }
    %>
    <tr>
        <td align=center><input type="radio" name=selectedLink onclick=selectthis(this)
                                value="<%=columnURL%>"></td>
        <td colspan=4><font color=blue>ѡ��ǰ��Ŀ��������</font></td>
    </tr>
</table>

<table cellpadding="1" cellspacing="1" border="0">
    <form name="linkform" method=post action="listarticle.jsp?column=<%=columnID%>&modeltype=<%=modeltype%>">
        <input type=hidden name=doSearch value=true>
        <tr>
            <td colspan=2>�������:<input name=content size=35>&nbsp;<input type=submit value=" ���� "></td>
        </tr>
        <tr>
            <td>���ӵ�ַ:</td>
            <td><input name="oHref" size="35" value="/" ondblclick="javascript:setlinkrules(<%=columnID%>)"></td>
        </tr>
    </form>
</table>

<input type=button value="  ȷ��  " onclick="linkit(1);">&nbsp;&nbsp;
<input type=button value="  ȡ��  " onclick="linkit(2);">

</BODY>
</html>