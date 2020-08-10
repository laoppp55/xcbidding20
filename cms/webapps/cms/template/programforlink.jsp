<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%@ page import="com.bizwink.cms.server.CmsServer" %>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  int siteid              = authToken.getSiteID();
  String sitename         = authToken.getSitename();
  int samsiteid           = authToken.getSamSiteid();
  int templateSeriesnum   = authToken.getShareTemplatenum();
  int columnID            = ParamUtil.getIntParameter(request, "column", 0);
  int rightid             = ParamUtil.getIntParameter(request, "rightid", 0);
  int start               = ParamUtil.getIntParameter(request, "start", 0);
  int range               = ParamUtil.getIntParameter(request, "range", 20);
  int msgno               = ParamUtil.getIntParameter(request, "msgno", 2);
  int globalflag          = ParamUtil.getIntParameter(request, "global", 0);
  int lockflag            = 1;
  String name = "����ģ��";

  IModelManager modelManager = ModelPeer.getInstance();
  int total = 0;
  List templateList = new ArrayList();

  total = modelManager.getModelCount(siteid,columnID);
  templateList = modelManager.getModels(siteid, columnID, start, range);

  int templateCount = templateList.size();
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../style/global.css">
<script LANGUAGE="JavaScript" SRC="../toolbars/btnclick<%=CmsServer.lang%>.js"></script>
<script LANGUAGE="JavaScript" SRC="../toolbars/dhtmled.js"></script>
<script language="JavaScript">
var linkType;
var DHTMLSafe;

function initialize()
{
  DHTMLSafe = window.parent.opener.tbContentElement;
  var trSel=DHTMLSafe.DOM.selection;
  var range = trSel.createRange();
  var coll=DHTMLSafe.DOM.all.tags("A");
  var fBreak=false;

  for(i=0;i<coll.length&&!fBreak;i++)
  {
    trLink=DHTMLSafe.DOM.body.createTextRange();
    trLink.moveToElementText(coll[i]);

    if((range.compareEndPoints("EndToStart",trLink)==1)&&
       (range.compareEndPoints("StartToEnd",trLink)==-1))
    {
      if(range.compareEndPoints("StartToStart",trLink)==1)
        range.setEndPoint("StartToStart",trLink);
      if(range.compareEndPoints("EndToEnd",trLink)==-1)
        range.setEndPoint("EndToEnd",trLink);

      range.select();
      document.all.linkform.oHref.value=coll[i].href;
      document.all.linkform.oTarget.value=coll[i].target;
      document.all.linkform.oStyle.value=coll[i].style.cssText;
      document.all.linkform.oClass.value=coll[i].className;

      //document.all.oTitle.innerText="Update Hyperlink";
      //document.all.oInsert.innerText="Update Link";

      linkType="update";
      fBreak=true;
    }
  }
  if(!fBreak)
  {
    if(range.compareEndPoints("StartToEnd",range)==0)
    {
      // New Link
      linkType="new";
      document.all.linkform.oHref.select();
    }
    else
    {
      linkType="link";
    }
  }
}

function linkit()
{
  window.parent.opener.ae_hyperlink(1,
                                    document.all.linkform.oHref.value,
                                    document.all.linkform.oTarget.value,
                                    document.all.linkform.oStyle.value,
                                    document.all.linkform.oClass.value,
                                    document.all.linkform.oName.value
                                    );
  window.parent.close();
}

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
  linkform.oHref.value = para.value;
}
</script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
  String[][] titlebars = {
    { "", "" }
  };

  String[][] operations = {
    {"",""}
  };
%>
<%@ include file="../inc/titlebar.jsp" %>
<%
  if (msgno == 0)
    out.println("<span class=cur>ҳ�淢���ɹ���</span>");
  else if (msgno == 1)
    out.println("<span class=cur>��ģ�屻����ΪĬ��ģ��</span>");
  else if (msgno == -1)
    out.println("<span class=cur>ĳ��Ŀû����������ҳģ�壡</span>");
  else if (msgno == -2)
    out.println("<span class=cur>д�ļ�ʱ���ִ���</span>");
  else if (msgno == -3)
    out.println("<span class=cur>���������б��ļ�ʱ���ִ���</span>");
  else if (msgno == -4)
    out.println("<span class=cur>ĳ��Ŀģ����ļ���Ϊ�գ�</span>");

  if (templateCount > 0)
  {
    out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
    out.println("<tr><td width=50% class=line>");
    if (start - range >= 0)
      out.println("<a href=templates.jsp?column="+columnID+"&range="+range+"&start="+(start-range)+"><img src=../images/btn_previous.gif align=bottom border=0></a>"+start);
    out.println("</td><td width=50% align=right class=line>");
    if (start + range < total)
    {
      int remain = ((start+range-total)<range)?(total-start-range):range;
      out.println(remain+"<a href=templates.jsp?column="+columnID+"&range="+range+"&start="+(start+range)+"><img src=../images/btn_next.gif align=bottom border=0></a>");
    }
    out.println("</td></tr></table>");
  }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
  <tr>
    <td colspan=5>��ǰ������Ŀ-->><font color=red>����ҳ��</font></td>
  </tr>
  <tr class=itm bgcolor="#dddddd">
    <td align=center width="15%">ѡ�и�����</td>
    <td align=center width="50%">����</td>
    <td align=center width="15%">�޸�ʱ��</td>
    <td align=center width="10%">�༭</td>
    <td align=center width="10%">Ԥ��</td>
  </tr>
<%
  for (int i=0; i<templateCount; i++)
  {
    Model template = (Model)templateList.get(i);

    int templateID = template.getID();
    lockflag = template.getLockStatus();
    int isArticle = template.getIsArticle();
    int ownflag = template.getOwnFlag();
    int referModelID = template.getReferModelID();
    String editor = template.getEditor();
    String lastupdated = template.getLastupdated().toString().substring(0,10);
    String templateName = template.getChineseName();
    if (templateName == null) templateName = "";
    templateName = StringUtil.gb2iso4View(templateName);

    String bgcolor = (i%2==0) ? "#EEC000" : "#FFCC00";
    out.println("<tr bgcolor=" + bgcolor + " height=22>");
    out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=/webapp/"+sitename+"/"+template.getTemplateName()+"." + "jsp></td>");
    out.println("<td>&nbsp;" + templateName + "</td>");

    out.println("<td align=center>" + lastupdated + "</td>");
    out.println("<td>&nbsp;" + editor + "</td>");

    out.println("<td align=center><a href=javascript:Preview("+templateID+","+isArticle+")>");
    out.println("<img src=../images/preview.gif border=0></a></td>");
  }
%>
</table>

<table cellpadding="1" cellspacing="2" border="0">
  <form name="linkform">
  <tr>
    <td class="styled"><span style="font-size:10pt">���ӵ�ַ:</span></td>
    <td colspan="3"><input type="text" name="oHref" size="35" value="http://"></td>
  </tr>
  <tr>
    <td class="styled"><span style="font-size:10pt">��������:</span></td>
    <td colspan="3"><select name="oTarget"><option value="">ԭʼ����<option value="_blank">��������</select></td>
  </tr>
  <tr>
    <td class="styled"><span style="font-size:10pt">��ʾ���:</span></td>
    <td colspan="3"><input type="text" name="oStyle" size="35" value=""></td>
  </tr>
  <tr>
    <td class="styled"><span style="font-size:10pt">��ʶ��:</span></td>
    <td><input type="text" name="oClass" size="8" value=""></td>
    <td class="styled"><span style="font-size:10pt">��������:</span></td>
    <td><input type="text" name="oName" size="8" value=""></td>
  </tr>
  </form>
</table>

<input type=button value="ȷ��" onclick="javascript:linkit()">
<input type=button value="ȡ��" ONCLICK="javascript:window.parent.close();">

</center>
</BODY>
</html>
