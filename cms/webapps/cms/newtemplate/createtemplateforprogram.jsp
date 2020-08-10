<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.fredck.FCKeditor.*" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.news.ColumnPeer" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.modelManager.IModelManager" %>
<%@ page import="com.bizwink.cms.modelManager.ModelPeer" %>
<%@ page import="com.bizwink.cms.news.IColumnManager" %>
<%@ page import="com.bizwink.cms.news.Column" %>
<%@ page import="com.bizwink.cms.modelManager.Model" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.cms.modelManager.ModelException" %>
<%@ page import="com.bizwink.upload.RandomStrg" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.extendAttr.ExtendAttrPeer" %>
<%@ page import="com.bizwink.cms.extendAttr.IExtendAttrManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.server.CmsServer" %>
<%@ taglib uri="/FCKeditor" prefix="FCK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String username = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int cssjsdir = authToken.getCssJsDir();
    String sitename = authToken.getSitename();
    int samsiteid = authToken.getSamSiteid();
    String appPath = application.getRealPath("/");
    int imgflag = authToken.getImgSaveFlag();
    boolean success = false;
    boolean errors = false;

    int tempnum=ParamUtil.getIntParameter(request,"tempnum",0);
    int modelType = ParamUtil.getIntParameter(request, "modelType", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    String filename = ParamUtil.getParameter(request, "modelfilename");
    String cname = ParamUtil.getParameter(request, "cname");
    String modelname = ParamUtil.getParameter(request, "modelname");
    int isIncluded = ParamUtil.getIntParameter(request, "isIncluded", 0);
    String content = "";
    session.setAttribute("createtemplate_columnid", String.valueOf(columnID));

    String columnName = "����ģ�����";
    String tempDir = "_programs";
    int parentColumnID = 0;

    //���ģ���ļ����ǿգ���ȡģ���ļ�������
    if (filename != null && !filename.equalsIgnoreCase("undefined") && !doCreate) {
        IModelManager modelPeer = ModelPeer.getInstance();
        content = modelPeer.readModelFile(filename,appPath,sitename,siteid,tempDir,imgflag,0,0);
        int posi = -1;
        while ((posi = content.toLowerCase().indexOf("<textarea")) > -1)
            content = content.substring(0, posi) + "<cmstextarea" + content.substring(posi + 9);
        while ((posi = content.toLowerCase().indexOf("</textarea>")) > -1)
            content = content.substring(0, posi) + "</cmstextarea>" + content.substring(posi + 11);

/*        if (lang == 2) {
            StringBuffer sb = new StringBuffer();
            char[] c = content.toCharArray();
            for (int i = 0; i < c.length; i++) {
                if ((c[i] > 65376 && c[i] < 65440) || (c[i] > 1000 && c[i] < 10000))  //Ƭ�������������
                    sb.append("&#" + Integer.toString(c[i]) + ";");
                else
                    sb.append(c[i]);
            }
            content = sb.toString();
        }
*/
    }

    IModelManager modelManager;
    if (doCreate) {
        modelManager = ModelPeer.getInstance();
        if (modelname == null || modelname.length() < 1) {
            out.println("ģ���ļ�������Ϊ�գ���<a href=javascript:history.go(-1);>����</a>");
            return;
        } else if (modelManager.hasSameModelName(siteid,columnID, modelname)) {
            out.println("ģ���ļ����Ʋ����ظ�����<a href=javascript:history.go(-1);>����</a>");
            return;
        }

        int posi;
        content = ParamUtil.getParameter(request, "content");
        while ((posi = content.toLowerCase().indexOf("<cmstextarea")) > -1)
            content = content.substring(0, posi) + "<textarea" + content.substring(posi + 12);
        while ((posi = content.toLowerCase().indexOf("</cmstextarea>")) > -1)
            content = content.substring(0, posi) + "</textarea>" + content.substring(posi + 14);
        //content = content.replaceAll("\"","&qute");

        try {
            Model model = new Model();

            model.setColumnID(columnID);
            model.setIsArticle(modelType);
            model.setContent(StringUtil.gb2isoindb(content));
            model.setCreatedate(new Timestamp(System.currentTimeMillis()));
            model.setLastupdated(new Timestamp(System.currentTimeMillis()));
            model.setEditor(username);
            model.setCreator(username);
            model.setLockstatus(0);
            model.setChineseName(StringUtil.gb2isoindb(cname));
            model.setTemplateName(modelname);
            model.setIncluded(isIncluded);
            model.setTempnum(tempnum);
            modelManager.Create(model, siteid,samsiteid);
            success = true;
        } catch (ModelException uaee) {
            errors = true;
        }
    }

    if (success) {
        response.sendRedirect(response.encodeRedirectURL("closewin.jsp?column=" + columnID + "&rightid=" + rightid));
        return;
    }

//�������ַ�����Ϊģ���ļ�����
    RandomStrg rstr = new RandomStrg();
    rstr.setCharset("a-z0-9");
    rstr.setLength(8);
    try {
        rstr.generateRandomObject();
    } catch (Exception e) {
        e.printStackTrace();
    }
    modelname = rstr.getRandom();
%>

<html>
<head>
<title>����ģ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
<script type="text/javascript" src="../toolbars/btnclick<%=CmsServer.lang%>.js"></script>
<script type="text/javascript" src="../toolbars/dhtmled.js"></script>
<script type="text/javascript" src="../fckeditor/fckeditor.js"></script>
<link rel=stylesheet type=text/css href="../style/editor.css">
<script type="text/javascript">
function checkoption()
{
    var para = document.createForm.modelType.value;
    // for (var i = 0; i < document.createForm.modelType.length; i++) {
    //     if (document.createForm.modelType[i].selected)
    //        para = document.createForm.modelType[i].value;
    //}

    var param = parseInt(para);
    if (param == 0)
        document.createForm.cname.value = "��Ŀģ��";
    else if (param == 1)
        document.createForm.cname.value = "����ģ��";
    else if (param == 2)
        document.createForm.cname.value = "��ҳģ��";
    else if (param == 3)
        document.createForm.cname.value = "ר��ģ��";
    else if (param >= 10)
        document.createForm.cname.value = "����ģ��";

    var selectlens = new Array;
    selectlens[0] = 32;
    var optionsname = new Array();
    var optionsvalue = new Array();

    optionsname[0] = new Array();
    optionsname[0][0] = "ѡ����";
    optionsname[0][1] = "�����б�";
    optionsname[0][2] = "��Ŀ�б�";
    optionsname[0][3] = "����·��";
    optionsname[0][4] = "Ӣ��·��";
    optionsname[0][5] = "�ȵ�����";
    optionsname[0][6] = "�Ƽ������б�";
    optionsname[0][7] = "�������б�";
    optionsname[0][8] = "�ֵ������б�";
    optionsname[0][9] = "����Ŀ�б�";
    optionsname[0][10] = "��������";
    optionsname[0][11] = "����������";
    optionsname[0][12] = "������";
    optionsname[0][13] = "��Ŀ����";
    optionsname[0][14] = "����Ŀ����";
    optionsname[0][15] = "��ĿURL";
    optionsname[0][16] = "������";
    optionsname[0][17] = "��¼��";
    optionsname[0][18] = "�������ҳ";
    optionsname[0][19] = "���ﳵҳ";
    optionsname[0][20] = "��������ҳ";
    optionsname[0][21] = "��������ҳ";
    optionsname[0][22] = "������ѯҳ";
    optionsname[0][23] = "��Ϣ����ҳ";
    optionsname[0][24] = "��������ҳ";
    optionsname[0][25] = "�û�ע��ҳ";
    optionsname[0][26] = "��¼��ʾҳ";
    optionsname[0][27] = "������ϸ��ѯҳ";
    optionsname[0][28] = "�û�����ҳ";
    optionsname[0][29] = "�޸�ע��ҳ";
    optionsname[0][30] = "ͼƬ��Ч";
    optionsname[0][31] = "�Զ����";
    optionsname[0][32] = "ѡ�����б��";

    optionsvalue[0] = new Array();
    optionsvalue[0][0] = "NO_SELECT";
    optionsvalue[0][1] = "ARTICLE_LIST";
    optionsvalue[0][2] = "COLUMN_LIST";
    optionsvalue[0][3] = "CHINESE_PATH";
    optionsvalue[0][4] = "ENGLISH_PATH";
    optionsvalue[0][5] = "TOP_STORIES";
    optionsvalue[0][6] = "COMMEND_ARTICLE";
    optionsvalue[0][7] = "SUBARTICLE_LIST";
    optionsvalue[0][8] = "BROTHER_LIST";
    optionsvalue[0][9] ="SUBCOLUMN_LIST";
    optionsvalue[0][10] ="ARTICLE_COUNT";
    optionsvalue[0][11] ="SUBARTICLE_COUNT";
    optionsvalue[0][12] ="NAVBAR";
    optionsvalue[0][13] ="COLUMNNAME";
    optionsvalue[0][14] ="PARENT_COLUMNNAME";
    optionsvalue[0][15] ="COLUMNURL";
    optionsvalue[0][16] ="SEARCH_FORM";
    optionsvalue[0][17] ="LOGIN_FORM";
    optionsvalue[0][18] ="SEARCH_RESULT-11";
    optionsvalue[0][19] ="SHOPPINGCAR_RESULT-12";
    optionsvalue[0][20] ="ORDER_RESULT-13";
    optionsvalue[0][21] ="ORDER_REDISPLAY-14";
    optionsvalue[0][22] ="ORDERSEARCH_RESULT-15";
    optionsvalue[0][23] ="FEEDBACK-16";
    optionsvalue[0][24] ="ARTICLE_COMMENT-17";
    optionsvalue[0][25] ="REGISTER_RESULT-18";
    optionsvalue[0][26] ="USER_LOGIN_DISPLAY-19";
    optionsvalue[0][27] ="ORDERSEARCH_DETAIL-20";
    optionsvalue[0][28] ="LEAVE_MESSAGE-21";
    optionsvalue[0][29] ="UPDATEREG-22";
    optionsvalue[0][30] = "XUAN_IMAGES";
    optionsvalue[0][31] = "SELF_DEFINE_FORM";
    optionsvalue[0][32] ="USED_MARK";

    if (param >= 10) param = 0;
    document.getElementById("MarkName").options.length = 0;
    for (var x = 0; x <= selectlens[param]; x++)
    {
        document.getElementById("MarkName").options.add(new Option(optionsname[param][x], optionsvalue[param][x]));
    }
}

function Form_Check(form)
{
    var val = form.modelType.value;
    //for(var i=0; i<form.modelType.length; i++) {
    //    if (form.modelType[i].selected) {
    //        val = form.modelType[i].value;
    //    }
    //}

    if (val < 10)
        return false;
    return true;
}
</script>
</head>

<body onload="checkoption();">
<form action="createtemplateforprogram.jsp" method="post" name=createForm onsubmit="return Form_Check(createForm)">
    <input type="hidden" name="textvalues" value="">   <!--�������XML��ʾ-->
    <input type=hidden name=doCreate value=true>
    <input type=hidden name=prog value=0>
    <input type=hidden name=column value="<%=columnID%>">
    <input type="hidden" name=modelType value=10>
    <input type=hidden name=rightid value="<%=rightid%>">
    <input type=hidden name="tempURL" value="<%=request.getRequestURL().toString()+"-"+siteid%>">
    <input type=hidden name=modelSourceCodeFlag value=0>
    <input type=hidden name=template_or_article_flag value="0">
    
    <table width="100%" border=0 cellspacing=0 cellpadding=0>
        <tr bgcolor=#003366>
            <td colspan=2 height=2></td>
        </tr>
        <tr height=30>
            <td width="70%"><%
                if (!success && errors) {
                    out.println("<span class=cur>����ģ��ʧ�ܣ����������ԡ�</span>");
                }
            %></td>
            <td width="30%" align=right>
                <input class=tine type=submit value="  ����  " name="savebutton">&nbsp;&nbsp;
                <input class=tine type=button value="  ȡ��  " onclick="window.close();">&nbsp;&nbsp;
            </td>
        </tr>
        <tr bgcolor=#003366>
            <td colspan=2 height=2></td>
        </tr>
        <tr>
            <td colspan=2 height=4></td>
        </tr>
    </table>

    <table width="100%" border=0 cellspacing=0 cellpadding=0>
        <tr>
            <td>
                &nbsp;&nbsp;ģ���������ƣ�<input name="cname" size=15  readonly>
                &nbsp;&nbsp;ģ���ļ�����<input name="modelname" size=15 value="<%=modelname%>"  readonly>
                &nbsp;&nbsp;ѡ���ǣ�<select ID="MarkName" name="theMarkName" onchange="return MarkName_Add(<%=columnID%>,'<%=sitename%>')"></select>
            &nbsp;&nbsp;&nbsp;ģ���<input type=text name="tempnum" size="4"></td>
        </tr>
        <tr>
            <td ID=bottomofFld></td>
        </tr>
    </table>
    <table border="0" width="100%">
        <tr>
            <td>
                <textarea id="content" name="content" style="WIDTH: 100%; HEIGHT: 530px"><%=content%>
                </textarea>
                <script type="text/javascript">
                    var oFCKeditor = new FCKeditor('content') ;
                    oFCKeditor.BasePath = "../fckeditor/";
                    oFCKeditor.Height = 530;
                    oFCKeditor.ToolbarSet = "ProgramDefault";
                    oFCKeditor.ReplaceTextarea();
                </script>
            </td>
        </tr>
    </table>
</form>
</body>
</html>