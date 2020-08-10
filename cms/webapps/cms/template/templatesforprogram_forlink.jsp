<%@ page import="java.util.*,
                 com.bizwink.cms.modelManager.*,
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

    int siteid              = authToken.getSiteID();
    String sitename         = authToken.getSitename();
    String dotsitename    = StringUtil.replace(sitename,"_",".");
    int columnID            = ParamUtil.getIntParameter(request, "column", 0);
    int start               = ParamUtil.getIntParameter(request, "start", 0);
    int range               = ParamUtil.getIntParameter(request, "range", 20);

    int samsiteid=authToken.getSamSiteid();
    String name = "����ģ��";
    int modeltype = 0;

    IModelManager modelManager = ModelPeer.getInstance();
    int total = 0;
    List templateList = new ArrayList();

    total = modelManager.getModelCountForPragram(siteid,columnID);
    System.out.println(System.currentTimeMillis());

    templateList = modelManager.getModelsForProgram(siteid, columnID, start, range) ;
    System.out.println(System.currentTimeMillis());

    int templateCount = templateList.size();
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="javascript">
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

        function PreviewTemplateForProgram(templateID, isArticle, columnID)
        {
            window.open("previewTemplateforprogram.jsp?column=" + columnID + "&template=" + templateID + "&isArticle=" + isArticle, "Preview", "width=800,height=600,left=0,top=0,scrollbars");
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
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    if (templateCount > 0) {
        out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
        out.println("<tr><td width=50% align=left class=line>");
        if (start - range >= 0)
            out.println("<a href=templatesforprogram_forlink.jsp?column=" + columnID + "&range=" + range + "&start=" + (start - range) + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
        out.println("</td><td width=50% align=right class=line>");
        if (start + range < total) {
            int remain = ((start + range - total) < range) ? (total - start - range) : range;
            out.println(remain + "<a href=templatesforprogram_forlink.jsp?column=" + columnID + "&range=" + range + "&start=" + (start + range) + "><img src=../images/btn_next.gif align=bottom border=0></a>");
        }
        out.println("</td></tr></table>");
    }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
    <tr>
        <td colspan=5>��ǰ������Ŀ-->><font color=red><%=name%>
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
        String bgcolor = "";
        for (int i=0; i<templateCount; i++)
        {
            Model template = (Model)templateList.get(i);

            int templateID = template.getID();
            int isArticle = template.getIsArticle();
            modeltype =  isArticle;
            String editor = template.getEditor();
            String lastupdated = template.getLastupdated().toString().substring(0,10);
            String templateName = template.getChineseName();
            if (templateName == null) templateName = "";
            templateName = StringUtil.gb2iso4View(templateName);

            bgcolor = (i%2==0) ? "#EEC000" : "#FFCC00";
            out.println("<tr bgcolor=" + bgcolor + " height=22>");
            if (modeltype == 17)   //��������ģ��
                out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=/" + sitename + "/_prog/" + template.getTemplateName()+ ".jsp?articleid=" + "[%%articleid%%]" + "></td>");
            else
                out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=/" + sitename + "/_prog/" + template.getTemplateName()+ ".jsp" + "></td>");
            out.println("<td>&nbsp;" + templateName + "</td>");

            out.println("<td align=center>" + lastupdated + "</td>");
            out.println("<td>&nbsp;" + editor + "</td>");

            out.println("<td align=center><a href=javascript:PreviewTemplateForProgram("+templateID+","+isArticle+")>");
            out.println("<img src=../images/preview.gif border=0></a></td></tr>");
        }

        out.println("<tr bgcolor=" + bgcolor + " height=22>");

           out.println("<td align=center><input type=radio name=selectedLink onclick=selectthis(this) value=/_commons/doshopping.jsp?num=1&pid=[%%articleid%%]&sitename=[%%sitename%%]></td>");
        
            out.println("<td>&nbsp;��Ʒ���빺�ﳵ</td>");

        out.println("<td align=center>&nbsp;</td>");
        out.println("<td>&nbsp;</td>");

        out.println("<td align=center>");
        out.println("<img src=../images/preview.gif border=0></td></tr>");

    %>
</table>

<table cellpadding="1" cellspacing="1" border="0">
    <form name="linkform" method=post action="templatesforprogram_forlink.jsp?column=<%=columnID%>&modeltype=<%=modeltype%>">
        <input type=hidden name=doSearch value=true>
        <tr>
            <td colspan=2>�������:<input name=content size=35>&nbsp;<input type=submit value=" ���� "></td>
        </tr>
        <tr>
            <td>���ӵ�ַ:</td>
            <td><input name="oHref" size="100" value="/" ondblclick="javascript:setlinkrules(<%=columnID%>)" readonly="true"></td>
        </tr>
    </form>
</table>

<input type=button value="  ȷ��  " onclick="linkit(1);">&nbsp;&nbsp;
<input type=button value="  ȡ��  " onclick="linkit(2);">
</BODY>
</html>
