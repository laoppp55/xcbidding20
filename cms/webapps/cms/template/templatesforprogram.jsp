<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*,
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
    int columnID            = ParamUtil.getIntParameter(request, "column", 0);
    int rightid             = ParamUtil.getIntParameter(request, "rightid", 0);
    int start               = ParamUtil.getIntParameter(request, "start", 0);
    int range               = ParamUtil.getIntParameter(request, "range", 20);
    int msgno               = ParamUtil.getIntParameter(request, "msgno", 2);
    int lockflag            = 1;
    String name = "����ģ��";

    int samsiteid=authToken.getSamSiteid();

    IModelManager modelManager = ModelPeer.getInstance();
    int total = 0;
    List templateList = new ArrayList();
    if(samsiteid>0)
    {
    total = modelManager.getModelCountForPragram(siteid,samsiteid,columnID);
    //System.out.println(System.currentTimeMillis());

    templateList = modelManager.getModelsForProgram(siteid,samsiteid, columnID, start, range) ;
    }else{
       total = modelManager.getModelCountForPragram(siteid,columnID);
    //System.out.println(System.currentTimeMillis());

    templateList = modelManager.getModelsForProgram(siteid, columnID, start, range) ;
    }
    //System.out.println(System.currentTimeMillis());

    int templateCount = templateList.size();
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="javascript">
        function UploadModel()
        {
            window.open("../upload/modelupload.jsp?column=<%=columnID%>","","width=650,height=500,left=200,top=100,status");
        }

        function CreateModel()
        {
            window.open("createtemplateforprogram.jsp?column=<%=columnID%>","","width=956,height=600,left=5,top=5,status");
        }

        function Preview(templateID, isArticle)
        {
            window.open("previewTemplateforprogram.jsp?column=<%=columnID%>&template="+templateID+"&isArticle="+isArticle,"PreviewTemplate","width=800,height=600,left=0,top=0,scrollbars");
        }

        function EditTemplate(templateID,isArticle,referModelID)
        {
            window.open("edittemplateforprogram.jsp?template="+templateID+"&column=<%=columnID%>&isArticle="+isArticle+"&rightid=<%=rightid%>","","width=956,height=600,left=5,top=5,status");
        }
        function opencopytemplate(templateID)
        {
            if(templateID>0)
            {
                window.open("copytemplate.jsp?template=" + templateID + "&column=<%=columnID%>", "", "width=956,height=600,left=5,top=5,status");
            }
        }
    </script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
<%
    String[][] titlebars = {
            { "ģ�����", "tempplatesmain.jsp" },
            { name, "" }
    };

    String[][] operations = {
            {"<a href=javascript:UploadModel();>�ϴ�ģ��</a>", ""},
            {"<a href=javascript:CreateModel();>ʹ��ģ��</a>",""}
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
            out.println("<a href=templatesforprogram.jsp?column="+columnID+"&range="+range+"&start="+(start-range)+"><img src=../images/btn_previous.gif align=bottom border=0></a>"+start);
        out.println("</td><td width=50% align=right class=line>");
        if (start + range < total)
        {
            int remain = ((start+range-total)<range)?(total-start-range):range;
            out.println(remain+"<a href=templatesforprogram.jsp?column="+columnID+"&range="+range+"&start="+(start+range)+"><img src=../images/btn_next.gif align=bottom border=0></a>");
        }
        out.println("</td></tr></table>");
    }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
    <tr bgcolor=#dddddd class=tine>
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
        for (int i=0; i<templateCount; i++)
        {
            Model template = (Model)templateList.get(i);

            int templateID = template.getID();
            lockflag = template.getLockStatus();
            int isArticle = template.getIsArticle();
            int referModelID = template.getReferModelID();
            String editor = template.getEditor();
            String lastupdated = template.getLastupdated().toString().substring(0,10);
            String templateName = template.getChineseName();
            if (templateName == null) templateName = "";
            templateName = StringUtil.gb2iso4View(templateName);

            String bgcolor = (i%2==0) ? "#EEC000" : "#FFCC00";
            out.println("<tr bgcolor=" + bgcolor + " height=22>");
            out.println("<td>&nbsp;" + templateName + "</td>");
            out.println("<td>&nbsp;" + template.getTemplateName() + "</td>");

            out.print("<td align=center>");
            if (isArticle == 11)
                out.print("��Ϣ����");
            else if (isArticle == 12)
                out.print("��ѯ���ﳵ");
            else if (isArticle == 13)
                out.print("��������");
            else if (isArticle == 14)
                out.print("��������");
            else if (isArticle == 15)
                out.print("������ѯ");
            else if (isArticle == 16)//�Ѿ����
                out.print("��Ϣ����");
            else if (isArticle == 17)//�Ѿ����
                out.print("�û�����");
            else if (isArticle == 18)
                out.print("�û�ע��");
            else if (isArticle == 19)
                out.print("�û���¼");
            else if (isArticle == 20)
                out.print("������ϸ��ѯ");
            else if (isArticle == 21)//�Ѿ����
                out.print("�û�����");
            else if (isArticle == 22)//�Ѿ����
                out.print("�޸�ע��");
            else
                out.print("JSPҳ��");

            out.println("</td>");
            out.println("<td align=center>" + lastupdated + "</td>");
            out.println("<td>&nbsp;" + editor + "</td>");
            out.println("<td align=center>&nbsp;</td>");
           if(siteid==template.getSiteID()){
            if (lockflag == 0)
                out.println("<td align=center><a href=javascript:EditTemplate("+templateID+","+isArticle+","+referModelID+");><img src=../images/edit.gif align=bottom border=0></a>");
            else if (SecurityCheck.hasPermission(authToken,2) || SecurityCheck.hasPermission(authToken,54))
                out.println("<td align=center><a href=javascript:EditTemplate("+templateID+","+isArticle+","+referModelID+");><img src=../images/a.gif align=bottom border=0></a></td>");
            else
                out.println("<td align=center><img src=../images/a.gif align=bottom border=0></a></td>");
            out.println("<td align=center><a href=removetemplateforprogram.jsp?template="+templateID + "&column="+ columnID + ">");
            out.println("<img src=../images/del.gif border=0></a></td>");
           } else{
                out.println("<td align=center><img src=\"../images/button/lock.gif\" align=bottom border=0 alt=\"ģ������\"></td>");
                out.println("<td align=center><!--a href='javascript:opencopytemplate("+templateID+")'>�鿴ģ��</a-->&nbsp;</td>");
            }
            out.println("<td align=center><a href=javascript:Preview("+templateID+","+isArticle+")>");
            out.println("<img src=../images/preview.gif border=0></a></td>");
            if (isArticle != 1)
                out.println("<td align=center><a href=\"../publish/publish.jsp?&column="+columnID+"&template="+templateID+"&modelType="+isArticle+"&source=2&start="+start+"&range="+range+"\"><img src=../images/publish.gif border=0></a></td></tr>");
            else
                out.println("<td align=center>&nbsp;</td></tr>");
        }
        //System.out.println(System.currentTimeMillis());
    %>
</table>
</center>
</BODY>
</html>
