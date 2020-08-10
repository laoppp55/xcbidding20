<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  int columnID = ParamUtil.getIntParameter(request, "column", 0);
  int start = ParamUtil.getIntParameter(request, "start", 0);
  int range = ParamUtil.getIntParameter(request, "range", 20);
  int modeltype = ParamUtil.getIntParameter(request, "modeltype", 0);
  String msg = ParamUtil.getParameter(request, "msg");

  IColumnManager columnManager = ColumnPeer.getInstance();
  Column column = columnManager.getColumn(columnID);
  String extname = column.getExtname();
  String CName = StringUtil.gb2iso4View(column.getCName());
  String columnURL = column.getDirName();

  int noContent = 3;   //��ʾȡ�����е����£������Ƿ�������
  IArticleManager articleMgr = ArticlePeer.getInstance();
  int total = articleMgr.getLinkArticlesNum(columnID,"",modeltype);
  List articleList = articleMgr.getLinkArticles(columnID, start, range,"",modeltype);
  int articleCount = articleList.size();
%>

<html>
<head>
<title>Articles</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../style/global.css"></head>
<script language="JavaScript">
function PreviewArticle(articleID)
{
  window.open("../article/preview.jsp?article="+articleID,"Preview","width=800,height=600,left=0,top=0,scrollbars");
}

function PreviewTemplate(templateID, isArticle, columnID)
{
  window.open("previewTemplate.jsp?column="+columnID+"&template="+templateID+"&isArticle="+isArticle,"Preview","width=800,height=600,left=0,top=0,scrollbars");
}

function selectthis(para)
{
  oHref.value = para.value;
}

function check()
{
  if (oHref.value == "")
    return;

  var retstr = "window.open('"+oHref.value+"','','"+oStyle.value+"')";
  window.returnValue = retstr;
  window.close();
}
</script>

<BODY BGCOLOR="#ffffff" LINK="#000099" ALINK="#cc0000" VLINK="#000099" TOMARGIN=8>
<%
  if (msg!=null) out.println("<span class=cur>" + msg + "</span>");
  if (articleCount > 0)
  {
    out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
    out.println("<tr><td width=50% align=left class=line>");
    if (start - range >= 0)
      out.println("<a href=listarticle.jsp?column="+columnID+"&range="+range+"&start="+(start-range)+"><img src=../images/btn_previous.gif align=bottom border=0></a>"+start);
    out.println("</td><td width=50% align=right class=line>");
    if (start + range < total)
    {
      int remain = ((start+range-total)<range)?(total-start-range):range;
      out.println(remain+"<a href=listarticle.jsp?column="+columnID+"&range="+range+"&start="+(start+range)+"><img src=../images/btn_next.gif align=bottom border=0></a>");
    }
    out.println("</td></tr></table>");
  }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
  <tr>
    <td colspan=5>��ǰ������Ŀ-->><font color=red><%=CName%></font></td>
  </tr>
  <tr class=itm bgcolor="#dddddd">
    <td align=center width="10%">ѡ��</td>
    <td align=center width="60%">����</td>
    <td align=center width="17%">�޸�ʱ��</td>
    <td align=center width="13%">Ԥ��</td>
  </tr>
<%
    for (int i=0; i<articleCount; i++)
    {
        Article article = (Article)articleList.get(i);

        int articleID = article.getID();       //����ID��ģ��ID
        String bgcolor = (i%2==0)?"#ffffcc":"#eeeeee";
        String lastUpdated = article.getLastUpdated().toString().substring(0,10); //���»�ģ�������޸�ʱ��

        columnID = article.getColumnID();      //���»�ģ��������ĿID
        column = columnManager.getColumn(columnID);
        extname = column.getExtname();
        if (extname == null) extname="html";

        int isArticleTemplate = 0;             //������ģ�廹����Ŀģ�����ҳģ��
        String maintitle = StringUtil.gb2iso4View(article.getMainTitle());
        boolean isTemplate = article.getIsTemplate();    //�����»���ģ��
        if (isTemplate)
        {
          int status = article.getStatus();      //�Ƿ�ΪĬ��ģ��
          maintitle = article.getMainTitle();    //ģ����������
          if (maintitle == null)  maintitle = "";
          maintitle = StringUtil.gb2iso4View(maintitle);
          isArticleTemplate = article.getIsArticleTemplate();

          if (isArticleTemplate == 3)
          {
            maintitle = "<font color=red>" + maintitle + "(ר��ģ��)</font>";
          }
          else
          {
            if (status == 1)
              maintitle = "<font color=red>" + maintitle + "(Ĭ��ģ��)</font>";
            else
              maintitle = "<font color=red>" + maintitle + "(ģ��)</font>";
          }
        }

        out.println("<tr bgcolor=" + bgcolor + "class=itm>");
        if (isTemplate)
        {
          out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value="+columnURL+article.getFileName()+"."+extname+"></td>");
        }
        else
        {
          if (article.getNullContent() == 0)
            out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value="+columnURL+articleID+"."+extname+"></td>");
          else
            out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value="+columnURL+StringUtil.gb2iso4View(article.getFileName())+"></td>");
        }
        out.println("<td>" + maintitle + "</td>");
        out.println("<td>" + lastUpdated + "</td>");
        out.println("<td align=center>");
        if (isTemplate)
        {
          out.println("<a href=javascript:PreviewTemplate("+articleID+","+isArticleTemplate+","+columnID+");><img src=../images/preview.gif border=0></a>");
        }
        else
        {
          if (article.getContent() != null)
            out.println("<a href=javascript:PreviewArticle("+articleID+");><img src=../images/preview.gif border=0></a>");
          else
            out.println("<img src=../images/preview.gif border=0>");
        }
        out.println("</td></tr>");
    }
%>
    <tr>
      <td align=center><input type="radio" name=selectedLink onclick=selectthis(this) value="<%=columnURL+"index."+extname%>"></td>
      <td colspan=3><font color=blue>ѡ��ǰ��Ŀҳ��</font></td>
    </tr>
</table>

<table cellpadding="1" cellspacing="2" border="0">
  <tr>
    <td class="styled"><span style="font-size:10pt">���ӵ�ַ:</span></td>
    <td colspan="3"><input type="text" name="oHref" size="45" value=""></td>
  </tr>
  <tr>
    <td class="styled"><span style="font-size:10pt">��ʾ���:</span></td>
    <td colspan="3"><input type="text" name="oStyle" size="45" value="width=250,height=200,left=0,top=0,status=no,scrollbars=no,toolbar=no,menubar=no,resizable=no"></td>
  </tr>
</table>

<p align=center>
<input type=button value=" ȷ�� " onclick="check();">&nbsp;&nbsp;&nbsp;&nbsp;
<input type=button value=" ȡ�� " onclick="window.parent.close();">
</p>

</BODY>
</html>