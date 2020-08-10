<%@ page contentType="text/html;charset=GBK" %>
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
<%@ page import="com.bizwink.cms.server.CmsServer" %>
<!--%@ taglib uri="/FCKeditor" prefix="FCK" %-->

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String username = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int cssjsdir = authToken.getCssJsDir();
    String sitename = authToken.getSitename();
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

    IColumnManager columnMgr = ColumnPeer.getInstance();
    Column column = columnMgr.getColumn(columnID);
    String tempDir = column.getDirName();
    int lang = column.getLanguageType();

    //���ģ���ļ����ǿգ���ȡģ���ļ�������
    if (filename != null && !filename.equalsIgnoreCase("undefined") && !doCreate) {
        IModelManager modelPeer = ModelPeer.getInstance();
        content = modelPeer.readModelFile(filename, appPath, sitename, siteid, tempDir, imgflag, lang, cssjsdir);
        int posi = -1;
        while ((posi = content.toLowerCase().indexOf("<textarea")) > -1)
            content = content.substring(0, posi) + "<cmstextarea" + content.substring(posi + 9);
        while ((posi = content.toLowerCase().indexOf("</textarea>")) > -1)
            content = content.substring(0, posi) + "</cmstextarea>" + content.substring(posi + 11);

        /*if (lang == 2) {
            StringBuffer sb = new StringBuffer();
            char[] c = content.toCharArray();
            for (int i = 0; i < c.length; i++) {
                if ((c[i] > 65376 && c[i] < 65440) || (c[i] > 1000 && c[i] < 10000))  //Ƭ�������������
                    sb.append("&#" + Integer.toString(c[i]) + ";");
                else
                    sb.append(c[i]);
            }
            content = sb.toString();
        }*/
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
            modelManager.Create(model, siteid,samsiteid,0);
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

//����������չ���ԣ���������ģ��ı��
    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
    List attrList = extendMgr.getAttrForTemplate(columnID);
    attrList.add(0, "NO_SELECT,ѡ����");
    attrList.add("ARTICLEPIC,����ͼƬ");
    attrList.add("ARTICLE_SUMMARY,���¸���");
    attrList.add("ARTICLE_MEDIA,��Ƶ����");
    attrList.add("ARTICLE_PT,����ʱ��");
    attrList.add("ARTICLE_LIST,�����б�");
    attrList.add("RELATED_ARTICLE,�������");
    //attrList.add("COMMEND_ARTICLE,�Ƽ������б�");
    attrList.add("TOP_STORIES,�ȵ�����");
    attrList.add("COLUMN_LIST,��Ŀ�б�");
    attrList.add("ARTICLE_PATH,����·��");
    attrList.add("CHINESE_PATH,����·��");
    attrList.add("ENGLISH_PATH,Ӣ��·��");
    attrList.add("NAVBAR,������");
    attrList.add("SUBARTICLE_LIST,�������б�");
    attrList.add("BROTHER_LIST,�ֵ������б�");
    attrList.add("SUBCOLUMN_LIST,����Ŀ�б�");
    attrList.add("ARTICLE_COUNT,��������");
    attrList.add("SUBARTICLE_COUNT,����������");
    attrList.add("ARTICLEID,����ID");
    attrList.add("ARTICLESTATUS,����״̬");
    attrList.add("COLUMNID,��ĿID");
    attrList.add("RELATEID,������ID");
    attrList.add("COLUMNNAME,��Ŀ����");
    attrList.add("PARENT_COLUMNNAME,����Ŀ����");
    attrList.add("COLUMNURL,��ĿURL");
    attrList.add("PARENT_PATH,������·��");
    attrList.add("ARTICLE_DOCLEVEL,����Ȩ��");
    attrList.add("PAGINATION,��ҳ���");
    attrList.add("PREV_ARTICLE,��һƪ");
    attrList.add("NEXT_ARTICLE,��һƪ");
    attrList.add("ARTICLE_TYPE,���·���");
    attrList.add("TURN_PIC,���¸�ͼ�б�");
    attrList.add("COMPANYNAME,��˾����");
    attrList.add("TELEPHONE,��˾��ϵ�绰");
    attrList.add("EMAIL,��˾�ʼ�");
    attrList.add("WEIBO,��˾΢��");
    attrList.add("SEARCH,������");
    attrList.add("ORDERSEARCH_RESULT,������ѯ��");
    attrList.add("LOGIN_FORM,�û���¼��");
    attrList.add("USER_LOGIN_DISPLAY,�û���¼ҳ");
    attrList.add("DEFINEINFO,�����");
    attrList.add("ARTICLE_COMMENT,�������۱�");
    attrList.add("QQ,QQ����");
    attrList.add("INCLUDE_FILE,��������ļ�");
    attrList.add("SEECOOKIE,������");
    attrList.add("TURNPIC,ͼƬ�ֻ�Ч��");
    attrList.add("LEAVEMESSAGE,�û����Ա�");
    attrList.add("LEAVEMESSAGELIST,�û������б�");
    attrList.add("USED_MARK,ѡ�����б��");

    if (column.getParentID() == 0) modelType = 2;
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
    function checkoption() {
        var para;
        for (var i = 0; i < document.createForm.modelType.length; i++) {
            if (document.createForm.modelType[i].selected)
                para = document.createForm.modelType[i].value;
        }

        var param = parseInt(para);
        if (param == 0)
            document.createForm.cname.value = "��Ŀģ��";
        else if (param == 1)
            document.createForm.cname.value = "����ģ��";
        else if (param == 2)
            document.createForm.cname.value = "��ҳģ��";
        else if (param == 3)
            document.createForm.cname.value = "ר��ģ��";
        else if (param == 4)
            document.createForm.cname.value = "�ֻ���Ŀģ��";
        else if (param == 5)
            document.createForm.cname.value = "�ֻ���ҳģ��";
        else if (param == 6)
            document.createForm.cname.value = "�ֻ�ר��ģ��";

        var selectlens = new Array;
        selectlens[0] = 34;
        selectlens[1] = <%=attrList.size() - 1%>;
        var optionsname = new Array();
        var optionsvalue = new Array();

        optionsname[0] = new Array();
        optionsname[0][0] = "ѡ����";
        optionsname[0][1] = "�����б�";
        optionsname[0][2] = "��Ŀ�б�";
        optionsname[0][3] = "�Ƽ��б�";
        optionsname[0][4] = "����·��";
        optionsname[0][5] = "Ӣ��·��";
        optionsname[0][6] = "�ȵ�����";
        optionsname[0][7] = "�������";
        optionsname[0][8] = "�Ƽ������б�";
        optionsname[0][9] = "�������б�";
        optionsname[0][10] = "�ֵ������б�";
        optionsname[0][11] = "����Ŀ�б�";
        optionsname[0][12] = "��������";
        optionsname[0][13] = "����������";
        optionsname[0][14] = "������";
        optionsname[0][15] = "��Ŀ����";
        optionsname[0][16] = "����Ŀ����";
        optionsname[0][17] = "��ĿURL";
        optionsname[0][18] = "��˾����";
        optionsname[0][19] = "��˾��ϵ�绰";
        optionsname[0][20] = "��˾�ʼ�";
        optionsname[0][21] = "��˾΢��";
        optionsname[0][22] = "������";
        optionsname[0][23] = "������ѯ��";
        optionsname[0][24] = "�û���¼��";
        optionsname[0][25] = "�����";
        optionsname[0][26] = "ͼƬ��Ч";
        optionsname[0][27] = "QQ����";
        optionsname[0][28] = "��������ļ�";
        optionsname[0][29] = "������";
        optionsname[0][30] = "ͼƬ�ֻ�Ч��";
        optionsname[0][31] = "�û����Ա�";
        optionsname[0][32] = "�û������б�";
        optionsname[0][33] = "�û���¼ҳ";
        optionsname[0][34] = "ѡ�����б��";

        optionsvalue[0] = new Array();
        optionsvalue[0][0] = "NO_SELECT";
        optionsvalue[0][1] = "ARTICLE_LIST";
        optionsvalue[0][2] = "COLUMN_LIST";
        optionsvalue[0][3] = "RECOMMEND_LIST";
        optionsvalue[0][4] = "CHINESE_PATH";
        optionsvalue[0][5] = "ENGLISH_PATH";
        optionsvalue[0][6] = "TOP_STORIES";
        optionsvalue[0][7] = "RELATED_ARTICLE";
        optionsvalue[0][8] = "COMMEND_ARTICLE";
        optionsvalue[0][9] = "SUBARTICLE_LIST";
        optionsvalue[0][10] = "BROTHER_LIST";
        optionsvalue[0][11] = "SUBCOLUMN_LIST";
        optionsvalue[0][12] = "ARTICLE_COUNT";
        optionsvalue[0][13] = "SUBARTICLE_COUNT";
        optionsvalue[0][14] = "NAVBAR";
        optionsvalue[0][15] = "COLUMNNAME";
        optionsvalue[0][16] = "PARENT_COLUMNNAME";
        optionsvalue[0][17] = "COLUMNURL";
        optionsvalue[0][18] = "COMPANYNAME";
        optionsvalue[0][19] = "TELEPHONE";
        optionsvalue[0][20] = "EMAIL";
        optionsvalue[0][21] = "WEIBO";
        optionsvalue[0][22] = "SEARCH_FORM";
        optionsvalue[0][23] = "ORDERSEARCH_RESULT";
        optionsvalue[0][24] = "LOGIN_FORM";
        optionsvalue[0][25] = "DEFINEINFO_FORM";
        optionsvalue[0][26] = "XUAN_IMAGES";
        optionsvalue[0][27] = "QQ";
        optionsvalue[0][28] = "INCLUDE_FILE";
        optionsvalue[0][29] = "SEECOOKIE";
        optionsvalue[0][30] = "TURNPIC";
        optionsvalue[0][31] = "LEAVEMESSAGE";
        optionsvalue[0][32] = "LEAVEMESSAGELIST";
        optionsvalue[0][33] = "USER_LOGIN_DISPLAY";
        optionsvalue[0][34] = "USED_MARK";

        optionsname[1] = new Array();
        optionsvalue[1] = new Array();

    <%for (int i=0; i<attrList.size(); i++){
      String temp = (String)attrList.get(i);
      String name = temp.substring(0, temp.indexOf(","));
      String value = temp.substring(temp.indexOf(",") + 1);
      out.println("optionsname[1]["+i+"] =\""+value+"\";\r\n");
      out.println("optionsvalue[1]["+i+"] =\""+name+"\";\r\n");
    }%>

        /*
         0--��Ŀģ�壬2--��ҳģ�壬3--ר��ģ�� 4--�ֻ���Ŀģ��   5--�ֻ���ҳģ��   6--�ֻ�ר��ģ��
         1--����ģ��
         */
        if (param == 0 || param == 2 || param == 3 || para == 4 || param == 5 || param == 6)
            param = 0;
        else
            param = 1;

        document.getElementById("MarkName").options.length = 0;
        for (var x = 0; x <= selectlens[param]; x++)
        {
            document.getElementById("MarkName").options.add(new Option(optionsname[param][x], optionsvalue[param][x]));
        }
    }
</script>
</head>

<body onload="checkoption();">
<form action="createtemplate.jsp" method="post" name="createForm">
    <input type="hidden" name="getreturnvalue" value="">
    <input type=hidden name=doCreate value=true>
    <input type=hidden name=modelfilename>
    <input type=hidden name=column value="<%=columnID%>">
    <input type=hidden name=rightid value="<%=rightid%>">
    <input type=hidden name="tempURL" value="<%=request.getRequestURL().toString()+"-"+siteid%>">
    <input type=hidden name=modelSourceCodeFlag value=0>
    <input type=hidden name=template_or_article_flag value="0">    
     <input type="hidden" name="usermodelnewsadd" id="usermodelnewsadd" >
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
                <!--input type=radio name=insertTemplat value=0 onclick="javascript:Add_Template_onclick(<%//=columnID%>);">װ��ģ��-->
                &nbsp;&nbsp;ģ�����ͣ�<select name=modelType onchange="checkoption();">
                <%if (column.getParentID() == 0) {%>
                <option value=2 selected>��ҳģ��</option>
                <option value=5>�ֻ���ҳģ��</option>
                <%} else {%>
                <option value=0 selected>��Ŀģ��</option>
                <option value=4>�ֻ���Ŀģ��</option>
                <%}%>
                <option value=1>����ģ��</option>
                <option value=3>ר��ģ��</option>
                <option value=6>�ֻ�ר��ģ��</option>
            </select>
                &nbsp;&nbsp;ģ���������ƣ�<input name="cname" size=15>
                &nbsp;&nbsp;ģ���ļ�����<input name="modelname" size=15 value="<%=modelname%>">
                &nbsp;&nbsp;ѡ���ǣ�<select ID="MarkName" onchange="return MarkName_Add(<%=columnID%>,'<%=sitename%>')"></select>
                &nbsp;&nbsp;<input type=checkbox name="isIncluded" value=1>�����ļ�  &nbsp;&nbsp;&nbsp;ģ���<input type=text name="tempnum" size="4">
            </td>
        </tr>
        <tr style="height: 100%">
            <td id="selhtmlcode" valign="top"><input type="hidden" name="hcode" id="htmlcodeid" value=""></td>
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
                    oFCKeditor.ToolbarSet = "Default";
                    oFCKeditor.ReplaceTextarea();
                </script>
            </td>
        </tr>
    </table>
</form>
</body>
</html>