<%@ page import="java.util.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.sitesetting.ISiteInfoManager" %>
<%@ page import="com.bizwink.cms.sitesetting.SiteInfoPeer" %>
<%@ page import="com.bizwink.cms.sitesetting.SiteInfo" %>
<%@ page import="com.bizwink.cms.sitesetting.SiteInfoException" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int sitetype = authToken.getSitetype();
    int tempnum=authToken.getShareTemplatenum();

    ISiteInfoManager siteInfoMgr = SiteInfoPeer.getInstance();
    int cssjsdir = 0;
    try {
        SiteInfo siteInfo = siteInfoMgr.getSiteInfo(siteid);
        cssjsdir = siteInfo.getCssjsDir();
    } catch (SiteInfoException e) {
        e.printStackTrace();
    }

    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int msgno = ParamUtil.getIntParameter(request, "msgno", 2);

    int modelType = ParamUtil.getIntParameter(request, "isArticle", 0);
    String templateName = "";
    if (modelType == 2)
        templateName = "��ҳģ��";
    else if (modelType == 5)
        templateName = "�ֻ���ҳģ��";
    else if (modelType == 3)
        templateName = "ר��ģ��";
    else if (modelType == 6)
        templateName = "�ֻ�ר��ģ��";
    else if (modelType == 0)
        templateName = "��Ŀģ��";
    else if (modelType == 4)
        templateName = "�ֻ���Ŀģ��";
    else if (modelType == 1)
        templateName = "����ģ��";

    int lockflag = 1;

    IModelManager modelManager = ModelPeer.getInstance();
    int total = modelManager.getModelCount(siteid,samsiteid,sitetype,columnID,tempnum);
    List templateList = modelManager.getModels(siteid,samsiteid,sitetype,columnID,tempnum, start, range);
    int templateCount = templateList.size();
%>

<html>
<head>
    <title>����ģ��</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="javascript" src="../js/setday.js"></script>
    <script language="javascript">
        <!--%if(cssjsdir == 1){%-->
        function UploadModel()
        {
            window.open("../upload/modelupload.jsp?column=<%=columnID%>", "", "width=650,height=520,left=200,top=100,status");
        }
        <!--%}else{%-->
        //function UploadModel()
        //{
        //    window.open("../upload/modelupload2.jsp?column=<%=columnID%>", "", "width=350,height=200,left=200,top=200");
        //}
        <!--%}%-->

        function SelectSystemModel()
        {
            window.open("cmstemplate.jsp?column=<%=columnID%>", "", "width=800,height=600,left=5,top=5,status");
        }

        function ReferModel(id)
        {
            window.open("refertemplate.jsp?column=<%=columnID%>&rightid=<%=rightid%>", "", "width=800,height=600,left=5,top=5,status");
        }

        function CreateModel()
        {
            window.open("createtemplate.jsp?column=<%=columnID%>", "", "width=1200,height=600,left=5,top=5,status");
        }

        function Preview(templateID, isArticle)
        {
            window.open("previewTemplate.jsp?column=<%=columnID%>&template=" + templateID + "&isArticle=" + isArticle, "PreviewTemplate", "width=800,height=600,left=0,top=0,scrollbars");
        }

        function EditTemplate(templateID, isArticle, referModelID)
        {
            if (referModelID > 0)
                window.open("editReferTemplate.jsp?template=" + templateID + "&column=<%=columnID%>", "", "width=400,height=200,left=300,top=200,status");
            else
                window.open("edittemplate.jsp?template=" + templateID + "&column=<%=columnID%>&isArticle=" + isArticle + "&rightid=<%=rightid%>", "", "width=1200,height=600,left=5,top=5,status");
        }

        function ref() {
            alert("aaa");
        }
        function opencopytemplate(templateID)
        {
            if(templateID>0)
            {
                window.open("copytemplate.jsp?template=" + templateID + "&column=<%=columnID%>", "", "width=956,height=600,left=5,top=5,status");
            }
        }
        function WebEdit()
{
    window.open("../webedit/index.jsp?column=<%=columnID%>&right=4", "WebEdit", "width=850,height=600,left=5,top=5,scrollbars");
}
    </script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"ģ�����", ""}
    };
    String[][] operations = {
            {"<a href=\"javascript:ReferModel(" + rightid + ");\">����ģ��</a>", ""},
            {"<a href=\"javascript:UploadModel();\">�ϴ�ģ��/ͼ��</a>", ""},
            {"<a href=\"javascript:CreateModel();\">װ��ģ��</a>", ""},
            {"<a href=javascript:WebEdit();>�ļ��й���</a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<%
    out.println("<center>");
    if (msgno != 2) out.print("<span class=cur>" + templateName + "</span> ");
    if (msgno == 0)
        out.println("<span class=cur>�����ɹ�</span>");
    else if (msgno == 1)
        out.println("<span class=cur>��ģ�屻����ΪĬ��ģ��</span>");
    else if (msgno == -1)
        out.println("<span class=cur>ĳ��Ŀû����������ҳģ��</span>");
    else if (msgno == -2)
        out.println("<span class=cur>д�ļ�ʱ���ִ���</span>");
    else if (msgno == -3)
        out.println("<span class=cur>���������б��ļ�ʱ���ִ���</span>");
    else if (msgno == -4)
        out.println("<span class=cur>ģ����ļ���Ϊ��</span>");
    else if (msgno == -5)
        out.println("<span class=cur>ģ�屻�ɹ�ɾ��</span>");
    out.println("</center>");

    if (templateCount > 0) {
        out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
        out.println("<tr><td width=50% class=line>");
        if (start - range >= 0)
            out.println("<a href=templates.jsp?column=" + columnID + "&range=" + range + "&start=" + (start - range) + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
        out.println("</td><td width=50% align=right class=line>");
        if (start + range < total) {
            int remain = ((start + range - total) < range) ? (total - start - range) : range;
            out.println(remain + "<a href=templates.jsp?column=" + columnID + "&range=" + range + "&start=" + (start + range) + "><img src=../images/btn_next.gif align=bottom border=0></a>");
        }
        out.println("</td></tr></table>");
    }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
    <tr bgcolor=#dddddd class=tine height=20>
        <td align=center width='15%'>��������</td>
        <td align=center width='11%'>Ӣ������</td>
        <td align=center width='12%'>ģ������</td>
        <td align=center width='10%'>�޸�ʱ��</td>
        <td align=center width='12%'>�༭</td>
        <td align=center width='8%'>Ĭ��</td>     
        <td align=center width='8%'>�޸�</td>
        <td align=center width='8%'>ɾ��</td>
        <td align=center width='8%'>Ԥ��</td>
        <td align=center width='8%'>����</td>
    </tr>
    <%
        for (int i = 0; i < templateCount; i++) {
            Model template = (Model) templateList.get(i);

            int templateID = template.getID();
            lockflag = template.getLockStatus();
            int isArticle = template.getIsArticle();
            int referModelID = template.getReferModelID();
            String editor = template.getEditor();
            String lastupdated = template.getLastupdated().toString().substring(0, 10);
            templateName = template.getChineseName();
            if (templateName == null) templateName = "";
            templateName = StringUtil.gb2iso4View(templateName);

            String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
            out.println("<tr bgcolor=" + bgcolor + " height=25 onmouseover=\"this.style.background='#CECEFF';\" onmouseout=\"this.style.background='" + bgcolor + "';\">");
            out.println("<td>&nbsp;" + templateName + "</td>");
            out.println("<td>&nbsp;" + template.getTemplateName() + "</td>");

            out.print("<td align=center>");
            if (isArticle == 2)
                out.print("��ҳģ��");
            else if (isArticle == 5)
                out.print("�ֻ���ҳģ��");
            else if (isArticle == 3)
                out.print("ר��ģ��");
            else if (isArticle == 6)
                out.print("�ֻ�ר��ģ��");
            else if (isArticle == 0)
                out.print("��Ŀģ��");
            else if (isArticle == 4)
                out.print("�ֻ���Ŀģ��");
            else if (isArticle == 1)
                out.print("����ģ��");

            if (referModelID > 0) out.print("(����)");
            out.println("</td>");

            out.println("<td align=center>" + lastupdated + "</td>");
            out.println("<td>&nbsp;" + editor + "</td>");

            if (isArticle != 3) {
                out.println("<td align=center><a href=\"setupDefaultTemplate.jsp?template=" + templateID + "&column=" + columnID + "&isArticle=" + isArticle + "&templateName=" + templateName + "\">");
                if (template.getDefaultTemplate() == 1)
                    out.println("<img src=\"../images/button/moren.gif\" align=bottom border=0 alt=\"Ĭ��ģ��\"></a></td>");
                else
                    out.println("<img src=\"../images/button/morenyuan.gif\" align=bottom border=0 alt=\"ѡΪĬ��\"></a></td>");
            } else {
                out.println("<td align=center>&nbsp;</td>");
            }

            if(siteid==template.getSiteID()){
            if (lockflag == 0)
                out.println("<td align=center><a href=\"javascript:EditTemplate(" + templateID + "," + isArticle + "," + referModelID + ");\"><img src=\"../images/button/edit.gif\" align=bottom border=0 alt=\"�޸�ģ��\"></a>");
            else if (SecurityCheck.hasPermission(authToken, 2) || SecurityCheck.hasPermission(authToken, 54))
                out.println("<td align=center><a href=\"javascript:EditTemplate(" + templateID + "," + isArticle + "," + referModelID + ");\"><img src=\"../images/button/lock.gif\" align=bottom border=0 alt=\"ģ������\"></a></td>");
            else
                out.println("<td align=center><img src=\"../images/button/lock.gif\" align=bottom border=0 alt=\"ģ������\"></td>");

            out.println("<td align=center><a href=\"removetemplate.jsp?template=" + templateID + "\">");
            out.println("<img src=\"../images/button/del.gif\" border=0 alt=\"ɾ��ģ��\"></a></td>");
            }
            else{
                out.println("<td align=center><img src=\"../images/button/lock.gif\" align=bottom border=0 alt=\"ģ������\"></td>");
                out.println("<td align=center><a href='javascript:opencopytemplate("+templateID+")'>�鿴ģ��</a></td>");
            }
            out.println("<td align=center><a href=\"javascript:Preview(" + templateID + "," + isArticle + ");\">");
            out.println("<img src=\"../images/button/view.gif\" border=0 alt=\"Ԥ��ģ��\"></a></td>");
            if (isArticle != 1 && (SecurityCheck.hasPermission(authToken, 6) || SecurityCheck.hasPermission(authToken, 54)))
                out.println("<td align=center><a href=\"../publish/publish.jsp?column=" + columnID + "&template=" + templateID + "&modelType=" + isArticle + "&source=2&start=" + start + "&range=" + range + "&templateName=" + templateName + "\"><img src=\"../images/button/pub.gif\" border=0></a></td></tr>");
            else
                out.println("<td align=center>&nbsp;</td></tr>");
        }
    %>
</table>

</BODY>
</html>
