<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.modelManager.history.ModelHistory" contentType="text/html;charset=GBK"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ taglib uri="/FCKeditor" prefix="FCK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean errors = false;
    boolean success = false;
    String username = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    String sitename = authToken.getSitename();
    String rootPath = application.getRealPath("/");

     int tempnum=ParamUtil.getIntParameter(request,"tempnum",0);
    long historyID = ParamUtil.getLongParameter(request, "historyID", 0);
    int ID = ParamUtil.getIntParameter(request, "template", 0);
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    int modelType = ParamUtil.getIntParameter(request, "modelType", 0);
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int isIncluded = ParamUtil.getIntParameter(request, "isIncluded", 0);
    String content = ParamUtil.getParameter(request, "content1");
    String cname = ParamUtil.getParameter(request, "cname");
    String modelname = ParamUtil.getParameter(request, "modelname");
    String modelnameBak = ParamUtil.getParameter(request, "modelnameBak");
    boolean publish = ParamUtil.getBooleanParameter(request, "publish");
    boolean doUpdate = ParamUtil.getBooleanParameter(request, "doUpdate");
    session.setAttribute("createtemplate_columnid", String.valueOf(columnID));

    //System.out.println(content);

    IModelManager modelManager = ModelPeer.getInstance();
    Model model;

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String columnName = StringUtil.gb2iso4View(column.getCName());

    if (doUpdate) {
        try {
            if (modelname == null || modelname.length() < 1) {
                out.println("ģ���ļ�������Ϊ�գ���<a href=javascript:history.go(-1);>����</a>");
                return;
            } else if (!modelnameBak.equalsIgnoreCase(modelname)) {
                if (modelManager.hasSameModelName(siteid,columnID, modelname)) {
                    out.println("ģ���ļ����Ʋ����ظ�����<a href=javascript:history.go(-1);>����</a>");
                    return;
                }
            }

            int posi = -1;
            while ((posi = content.toLowerCase().indexOf("<cmstextarea")) > -1)
                content = content.substring(0, posi) + "<textarea" + content.substring(posi + 12);
            while ((posi = content.toLowerCase().indexOf("</cmstextarea>")) > -1)
                content = content.substring(0, posi) + "</textarea>" + content.substring(posi + 14);

            //System.out.println(siteid);
            //System.out.println(samsiteid);
            model = new Model();
            model.setColumnID(columnID);
            model.setID(ID);
            model.setIsArticle(modelType);
            model.setContent(StringUtil.gb2isoindb(content));
            model.setEditor(username);
            model.setLastupdated(new Timestamp(System.currentTimeMillis()));
            model.setLockstatus(0);
            model.setChineseName(StringUtil.gb2isoindb(cname));
            model.setTemplateName(modelname);
            model.setRealPath(rootPath);
            model.setSiteName(sitename);
            model.setPublishArticle(publish);
            model.setIncluded(isIncluded);
            model.setTempnum(tempnum);
            modelManager.Update(model, siteid,samsiteid,0);
            success = true;
        } catch (ModelException e) {
            e.printStackTrace();
            errors = true;
        }
    }

    if (success) {
        response.sendRedirect(response.encodeRedirectURL("closewin.jsp?id=" + ID + "&column=" + columnID + "&rightid=" + rightid));
        return;
    }

    ModelHistory history = new ModelHistory(rootPath);
    List historylist = history.getModelList(sitename, ID);

    model = modelManager.getModel(ID, username);
    if (historyID > 0) {
        content = history.getModel(ID, historyID, sitename);
        model.setContent(content);
    }
    modelType = model.getIsArticle();
    content = model.getContent();
    int posi = -1;
    while ((posi = content.toLowerCase().indexOf("<textarea")) > -1)
        content = content.substring(0, posi) + "<cmstextarea" + content.substring(posi + 9);
    while ((posi = content.toLowerCase().indexOf("</textarea>")) > -1)
        content = content.substring(0, posi) + "</cmstextarea>" + content.substring(posi + 11);
    content = StringUtil.gb2iso4View(content);
    PrintWriter pw = new PrintWriter(new FileOutputStream(rootPath + java.io.File.separator + "sites" + java.io.File.separator + StringUtil.replace(sitename,".","_") + java.io.File.separator + "_model" + java.io.File.separator + ID + ".html"));
    pw.write(content);
    pw.close();
    //System.out.println(content);
    cname = StringUtil.gb2iso4View(model.getChineseName());
    modelname = model.getTemplateName();
    isIncluded = model.getIncluded();

    //����������չ���ԣ���������ģ��ı��
    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
    List attrList = extendMgr.getAttrForTemplate(columnID);
    attrList.add(0, "NO_SELECT,ѡ����");
    attrList.add("ARTICLEPIC,����ͼƬ");
    attrList.add("ARTICLE_SUMMARY,���¸���");
    attrList.add("ARTICLE_PT,����ʱ��");
    attrList.add("ARTICLE_LIST,�����б�");
    attrList.add("RELATED_ARTICLE,�������");
    attrList.add("TOP_STORIES,�ȵ�����");
    attrList.add("COLUMN_LIST,��Ŀ�б�");
    attrList.add("CHINESE_PATH,����·��");
    attrList.add("ENGLISH_PATH,Ӣ��·��");
    attrList.add("NAVBAR,������");
    attrList.add("SUBARTICLE_LIST,�������б�");
    attrList.add("BROTHER_LIST,�ֵ������б�");
    attrList.add("SUBCOLUMN_LIST,����Ŀ�б�");
    attrList.add("ARTICLE_COUNT,��������");
    attrList.add("SUBARTICLE_COUNT,����������");
    attrList.add("ARTICLEID,����ID");
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
    attrList.add("SITE_LOGO,��վLOGO");
    attrList.add("SITE_BANNER,��վ����ͼ��");
    attrList.add("SITE_MAIN_NAVIGATOR,��վ������");
    attrList.add("SITE_SIDE_NAVIGATOR,��վ��������");
    attrList.add("SEARCH,������");
    attrList.add("ORDERSEARCH_RESULT,������ѯ��");
    attrList.add("USER_LOGIN,�û���¼��");
    attrList.add("ARTICLE_COMMENT,�������۱�");
    attrList.add("TURN_PIC,����ͼƬ��Ч");
    attrList.add("COPY_RIGHT,��վ��Ȩ");
    attrList.add("INCLUDE_FILE,��������ļ�");
    attrList.add("SEECOOKIE,������");
    attrList.add("USED_MARK,ѡ�����б��");
%>

<html>
<head>
<title>�޸�ģ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type="text/css" href="../style/editor.css">
<script type="text/javascript" src="../toolbars/newbtnclick.js"></script>
<script type="text/javascript" src="../toolbars/dhtmled.js"></script>
<script type="text/javascript" src="../fckeditor/fckeditor.js"></script>

<script language="javascript">
function checkoption(id)
{
    var para;
    for (var i = 0; i < document.createForm.modelType.length; i++) {
        if (document.createForm.modelType[i].selected)
            para = document.createForm.modelType[i].value;
    }

    var param = parseInt(para);
    if(id==1){
    if (param == 0)
        document.createForm.cname.value = "��Ŀģ��";
    else if (param == 1)
        document.createForm.cname.value = "����ģ��";
    else if (param == 2)
        document.createForm.cname.value = "��ҳģ��";
    else if (param == 3)
        document.createForm.cname.value = "ר��ģ��";
    }
    /*else if (param == 4)
        document.createForm.cname.value = "WAP��Ŀģ��";
    else if (param == 5)
        document.createForm.cname.value = "WAP����ģ��";*/

    var selectlens = new Array;
    selectlens[0] = 26;
    selectlens[1] = <%=attrList.size() - 1%>;
    var optionsname = new Array();
    var optionsvalue = new Array();

    optionsname[0] = new Array();
    optionsname[0][0] = "ѡ����";
    optionsname[0][1] = "�����б�";
    optionsname[0][2] = "��Ŀ�б�";
    optionsname[0][3] = "����·��";
    optionsname[0][4] = "Ӣ��·��";
    optionsname[0][5] = "�ȵ�����";
    optionsname[0][6] = "�������";
    optionsname[0][7] = "�������б�";
    optionsname[0][8] = "�ֵ������б�";
    optionsname[0][9] = "����Ŀ�б�";
    optionsname[0][10] = "��������";
    optionsname[0][11] = "����������";
    optionsname[0][12] = "������";
    optionsname[0][13] = "��Ŀ����";
    optionsname[0][14] = "����Ŀ����";
    optionsname[0][15] = "��ĿURL";
    optionsname[0][16] = "��վLOGO";
    optionsname[0][17] = "��վ����ͼ��";
    optionsname[0][18] = "��վ������";
    optionsname[0][19] = "��վ��������";
    optionsname[0][20] = "������";
    optionsname[0][21] = "������ѯ��";
    optionsname[0][22] = "�û���¼��";
    //optionsname[0][20] ="����";
    optionsname[0][23] = "ͼƬ��Ч";
    optionsname[0][24] = "��վ��Ȩ";
    optionsname[0][25] = "��������ļ�";
    optionsname[0][26] = "������";
    optionsname[0][27] = "ѡ�����б��";

    optionsvalue[0] = new Array();
    optionsvalue[0][0] = "NO_SELECT";
    optionsvalue[0][1] = "ARTICLE_LIST";
    optionsvalue[0][2] = "COLUMN_LIST";
    optionsvalue[0][3] = "CHINESE_PATH";
    optionsvalue[0][4] = "ENGLISH_PATH";
    optionsvalue[0][5] = "TOP_STORIES";
    optionsvalue[0][6] = "RELATED_ARTICLE";
    optionsvalue[0][7] = "SUBARTICLE_LIST";
    optionsvalue[0][8] = "BROTHER_LIST";
    optionsvalue[0][9] = "SUBCOLUMN_LIST";
    optionsvalue[0][10] = "ARTICLE_COUNT";
    optionsvalue[0][11] = "SUBARTICLE_COUNT";
    optionsvalue[0][12] = "NAVBAR";
    optionsvalue[0][13] = "COLUMNNAME";
    optionsvalue[0][14] = "PARENT_COLUMNNAME";
    optionsvalue[0][15] = "COLUMNURL";
    optionsvalue[0][16] = "SITE_LOGO";
    optionsvalue[0][17] = "SITE_BANNER";
    optionsvalue[0][18] = "SITE_MAIN_NAVIGATOR";
    optionsvalue[0][19] = "SITE_SIDE_NAVIGATOR";
    optionsvalue[0][20] = "SEARCH_FORM";
    optionsvalue[0][21] = "ORDERSEARCH_RESULT";
    optionsvalue[0][22] = "LOGIN_FORM";
    optionsvalue[0][23] = "XUAN_IMAGES";
    optionsvalue[0][24] = "COPY_RIGHT";
    optionsvalue[0][25] ="INCLUDE_FILE";
    optionsvalue[0][26] ="SEECOOKIE";

    optionsvalue[0][27] = "USED_MARK";

    optionsname[1] = new Array();
    optionsvalue[1] = new Array();

<%for (int i=0; i<attrList.size(); i++){
  String temp = (String)attrList.get(i);
  String name = temp.substring(0, temp.indexOf(","));
  String value = temp.substring(temp.indexOf(",") + 1);
  out.println("optionsname[1]["+i+"] =\""+value+"\";\r\n");
  out.println("optionsvalue[1]["+i+"] =\""+name+"\";\r\n");
}%>

    if (param == 2 || param == 3 || para == 4) param = 0;
    if (param == 5) param = 1;
    document.getElementById("MarkName").options.length=0;
    for (x = 0; x <= selectlens[param]; x++)
    {
        document.getElementById("MarkName").options.add(new Option(optionsname[param][x],optionsvalue[param][x]));
    }
}

function historyback(historyID)
{
    if (historyID > 0 && confirm("�Ƿ����Ҫ�ָ���ʷģ�壿"))
        window.location = "edittemplate.jsp?template=<%=ID%>&column=<%=columnID%>&isArticle=<%=modelType%>&rightid=2&historyID=" + historyID;
    else
        createForm.historyID[0].selected = true;
}

function saveModel()
{
    if (document.createForm.modelType[1].selected)
    {
        var ret = confirm("Ҫ���·����������ø�����ģ���������");
        if (ret) {
            document.createForm.publish.value = "true";
        }
    }
    edit_src(createForm);
}
</script>
</head>

<body onload="return checkoption(0);">
<form action="newedittemplate.jsp" method="post" name="createForm">
    <input type="hidden" name="backidx">
    <input type="hidden" name="textvalues" value="">   <!--�������XML��ʾ-->
    <input type="hidden" name="publish" value="false">
    <input type="hidden" name=doUpdate value=true>
    <input type=hidden name=column value="<%=columnID%>">
    <input type=hidden name=right value="<%=rightid%>">
    <input type="hidden" name=modelnameBak value="<%=modelname%>">
    <input type="hidden" name=template value="<%=ID%>">
    <input type="hidden" name=columnCode value="<%=columnID%>">
    <input type="hidden" name=modelSourceCodeFlag value=0>
    <input type=hidden name=template_or_article_flag value="0">    
    <input type="hidden" name=editor value="<%=username%>">
    <input type="hidden" name="username" value="<%=username%>">
    <input type="hidden" name="tempURL" value="<%=request.getRequestURL().toString()+"-"+siteid%>">
    <input type="hidden" name="usermodelnewsadd" id="usermodelnewsadd" >
    <div id=div1 class="tbScriptlet"><textarea name=content1><%=content%></textarea></div >
    <table width="100%" border=0 cellspacing=0 cellpadding=0>
        <tr bgcolor=#003366>
            <td colspan=3 height=2></td>
        </tr>
        <tr height=30>
            <td width="30%">��ǰ��Ŀ&nbsp;>&nbsp;<%=columnName%>
            </td>
            <td width="40%"><%
                if (!success && errors) {
                    out.println("<span class=cur>�޸�ģ��ʧ�ܣ����������ԡ�</span>");
                }
            %></td>
            <td width="30%" align=right>
                <input class=tine type=button value="  ����  " name="savebutton" onclick="saveModel();">&nbsp;&nbsp;
                <input class=tine type=button value="  ȡ��  " onclick="window.location='closewin.jsp?id=<%=ID%>&column=<%=columnID%>&rightid=<%=rightid%>';">&nbsp;&nbsp;
            </td>
        </tr>
        <tr bgcolor=#003366>
            <td colspan=3 height=2></td>
        </tr>
        <tr>
            <td colspan=3 height=4></td>
        </tr>
    </table>

    <table width="100%" border=0 cellspacing=0 cellpadding=0>
        <tr>
            <td>
                <!--input type=radio name=insertTemplat value=0 onclick="javascript:Add_Template_onclick(<%//=columnID%>);">װ��ģ��-->
                &nbsp;ģ�����ͣ�<select name=modelType onchange="checkoption(1);">
                <%if (column.getParentID() == 0) {%>
                <option value=2 <%if (modelType == 2) {%> selected<%}%>>��ҳģ��</option>
                <%}else{%>
                <option value=0 <%if (modelType == 0) {%> selected<%}%>>��Ŀģ��</option>
                <%}%>
                <option value=1 <%if (modelType == 1) {%> selected<%}%>>����ģ��</option>
                <option value=3 <%if (modelType == 3) {%> selected<%}%>>ר��ģ��</option>
            </select>
                &nbsp;ģ���������ƣ�<input name="cname" size=15 value="<%=cname%>">
                &nbsp;ģ���ļ�����<input name="modelname" size=15 value="<%=modelname%>">
                &nbsp;<select class=tine name="historyID" style="width:114px" onchange="historyback(this.value);">
                <option value="0">ѡ����ʷģ��</option>
                <%for (int i = historylist.size() - 1; i > -1; i--) {%>
                <option value="<%=historylist.get(i)%>"><%=
                    (new Timestamp(Long.parseLong((String) historylist.get(i)))).toString().substring(0, 19)%>
                </option>
                <%}%>
            </select>
                &nbsp;<select ID="MarkName" onchange="return MarkName_Add(<%=columnID%>,'<%=sitename%>')"></select>
                &nbsp;<input type=checkbox name="isIncluded" value=1 <%if(isIncluded==1){%> checked<%}%>>�����ļ�&nbsp;ģ���<input type=text name="tempnum" size="3" value="<%=model.getTempnum()%>">
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
                <object id="UserControl1" classid="clsid:42d2de86-975a-4ac1-bd46-faccd9117eda" Width="1000" Height="900"> </object>
            </td>
        </tr>
    </table>
</form>
                <script type="text/javascript">
                    var wmp=document.getElementById("UserControl1");
                    //wmp.SetDocumentHTML("<html><head><title>gggggggg</title></head><body>hello <a href=\"/vvvv/mmm.html\">word</a> <br> \"hello word\"</body></html>");
                    wmp.SetDocumentHTML(document.all.content1.value,document.createForm.column.value,document.createForm.template.value,document.createForm.modelType.value,document.createForm.right.value);
                </script>

</body>
</html>
