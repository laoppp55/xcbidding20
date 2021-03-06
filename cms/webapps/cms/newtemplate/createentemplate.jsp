<%@ page import="java.sql.*,
                 java.util.*,
                 java.io.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.upload.RandomStrg,
                 com.bizwink.cms.util.*,
                 java.net.URL"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp"));
        return;
    }

    String username = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int cssjsdir = authToken.getCssJsDir();
    String sitename = authToken.getSitename();
    String appPath = application.getRealPath("/");
    int imgflag = authToken.getImgSaveFlag();
    boolean success = false;
    boolean errors = false;

    int modelType = ParamUtil.getIntParameter(request, "modelType", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int rightid = ParamUtil.getIntParameter(request, "rightid", 0);
    String filename = ParamUtil.getParameter(request, "modelfilename");
    String cname = ParamUtil.getParameter(request, "cname");
    String modelname = ParamUtil.getParameter(request, "modelname");
    String content = "";

    IColumnManager columnMgr = ColumnPeer.getInstance();
    Column column = columnMgr.getColumn(columnID);
    String tempDir = column.getDirName();
    String columnName = column.getEName();

    String baseURL = "http://" + request.getHeader("Host") + "/webbuilder/";

    if (filename != null && !filename.equalsIgnoreCase("undefined") && !doCreate) {
        IModelManager modelPeer = ModelPeer.getInstance();
        content = modelPeer.readModelFile(filename, appPath, sitename, siteid, tempDir, imgflag, 2, cssjsdir);
        int posi = -1;
        while ((posi = content.toLowerCase().indexOf("<textarea")) > -1)
            content = content.substring(0, posi) + "<cmstextarea" + content.substring(posi + 9);
        while ((posi = content.toLowerCase().indexOf("</textarea>")) > -1)
            content = content.substring(0, posi) + "</cmstextarea>" + content.substring(posi + 11);

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

    IModelManager modelManager = null;
    if (doCreate) {
        modelManager = ModelPeer.getInstance();
        if (modelname == null || modelname.length() < 1) {
            out.println("Template's filename is NULL! Please <a href=javascript:history.go(-1);>return</a>");
            return;
        } else if (modelManager.hasSameModelName(columnID, modelname)) {
            out.println("Template's filename is REPEAT! Please<a href=javascript:history.go(-1);>return</a>");
            return;
        }

        content = ParamUtil.getParameter(request, "content");
        content = StringUtil.replace(content, "cmstextarea", "textarea").trim();

        try {
            Model model = new Model();

            model.setColumnID(columnID);
            model.setIsArticle(modelType);
            model.setContent(content);
            model.setCreatedate(new Timestamp(System.currentTimeMillis()));
            model.setLastupdated(new Timestamp(System.currentTimeMillis()));
            model.setEditor(username);
            model.setCreator(username);
            model.setLockstatus(0);
            model.setChineseName(cname);
            model.setTemplateName(modelname);

            modelManager.Create(model, siteid);

            //add by Eric 2004-10-29 for AD
            String sizeId = "";
            String positionId = "";
            String typeId = "";
            String url = "";
            if ((content.indexOf("[AD_SIZE]") != -1) && (content.indexOf("[/AD_SIZE]") != -1))
                sizeId = content.substring(content.indexOf("[AD_SIZE]") + 9, content.indexOf("[/AD_SIZE]"));
            if ((content.indexOf("[AD_POS]") != -1) && (content.indexOf("[/AD_POS]") != -1))
                positionId = content.substring(content.indexOf("[AD_POS]") + 8, content.indexOf("[/AD_POS]"));
            if ((content.indexOf("[AD_TYPE]") != -1) && (content.indexOf("[/AD_TYPE]") != -1))
                typeId = content.substring(content.indexOf("[AD_TYPE]") + 9, content.indexOf("[/AD_TYPE]"));
            if ((content.indexOf("[AD_URL]") != -1) && (content.indexOf("[/AD_URL]") != -1))
                url = content.substring(content.indexOf("[AD_URL]") + 8, content.indexOf("[/AD_URL]"));

            if ((!sizeId.equals("")) && (!positionId.equals("")) && (!typeId.equals(""))) {
                URL sendurl = new URL("http://demo.shop8888.com:8078/adserver/InsSiteResInfo?siteId=" + sitename.replaceAll("_", ".") + "&channelId=" + column.getDirName().replaceAll("/", ".") + "&posId=" + positionId + "&sizeId=" + sizeId + "&typeId=" + typeId + "&logo=" + url);
                sendurl.openStream();
            }
            success = true;
        }
        catch (ModelException uaee) {
            errors = true;
        }
    }

    if (success) {
        response.sendRedirect(response.encodeRedirectURL("closewin.jsp?column=" + columnID + "&rightid=" + rightid));
        return;
    }

    boolean blnFlag = false;
    if (content != null) blnFlag = true;

    RandomStrg rstr = new RandomStrg();
    rstr.setCharset("a-z0-9");
    rstr.setLength(8);
    rstr.generateRandomObject();
    modelname = rstr.getRandom();

    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
    List attrList = extendMgr.getEnglishAttrForTemplate(columnID);
    attrList.add(0, "NO_SELECT,Select Mark");
    attrList.add("ARTICLE_SUMMARY,Summary");
    attrList.add("ARTICLE_PT,PublishTime");
    attrList.add("ARTICLE_LIST,ArticleList");
    attrList.add("RELATED_ARTICLE,RelatedArticle");
    attrList.add("TOP_STORIES,TopStories");
    attrList.add("COLUMN_LIST,ColumnList");
    attrList.add("CHINESE_PATH,ChinesePath");
    attrList.add("ENGLISH_PATH,EnglishPath");
    attrList.add("NAVBAR,NavBar");
    attrList.add("SUBARTICLE_LIST,SubArticleList");
    attrList.add("ARTICLE_COUNT,ArticleCount");
    attrList.add("SUBARTICLE_COUNT,SubArticleCount");
    attrList.add("ADV_POSITION,AD");
    attrList.add("ARTICLEID,ArticleID");
    attrList.add("COLUMNID,ColumnID");
    attrList.add("RELATEID,RelatedID");
    attrList.add("COLUMNNAME,ColumnName");
    attrList.add("PARENT_COLUMNNAME,ParentColumnName");
    attrList.add("ARTICLE_DOCLEVEL,DocLevel");
    attrList.add("PAGINATION,Pagination");

    if (column.getParentID() == 0) modelType = 2;
%>

<html>
<head>
<title>New Template</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<meta http-equiv="Pragma" content="no-cache">
<link rel=stylesheet type=text/css href="../style/global.css">
<script LANGUAGE="JavaScript" SRC="../toolbars/btnclicken.js"></script>
<script LANGUAGE="JavaScript" SRC="../toolbars/dhtmled.js"></script>
<script ID="clientEventHandlersJS" LANGUAGE="JavaScript">
    <!--
    function tbContentElement_DocumentComplete()
    {
        if (!initialDocComplete)
        {
            if (<%=blnFlag%>)
            {
                var tempVar = createForm.content.value;

                var regexp1 = /cmstextarea/ig;
                tempVar = tempVar.replace(regexp1, "textarea");
                var regexp = /%=(([^%])*)%/g;
                var rtnAry = tempVar.match(regexp);
                if (rtnAry != null)
                {
                    var len = rtnAry.length;
                    var regexp0 = /["]/g;
                    var i = 0;
                    while (i < len)
                    {
                        temp = rtnAry[i].replace(regexp0, "'");
                        tempVar = tempVar.replace(rtnAry[i], temp);
                        i++;
                    }
                }

                tbContentElement.ShowBorders = true;
                tbContentElement.BrowseMode = false;
                tbContentElement.SourceCodePreservation = false;
                tbContentElement.ActivateActiveXControls = true;
                tbContentElement.ActivateDTCs = true;
                tbContentElement.UseDivOnCarriageReturn = true;
                //tbContentElement.ShowDetails = true;
                tbContentElement.DocumentHTML = tempVar;
            }
            else
            {
                tbContentElement.DocumentHTML = "";
            }

            initialDocComplete = true;
            docComplete = true;
            checkoption(<%=modelType%>, "createForm");
        }
        else
        {
            cover.style.visibility = "hidden";
            sending.style.visibility = "hidden";
        }
        tbContentElement.BaseURL = "<%=baseURL%>";
        return true;
    }
    //-->
</script>

<script LANGUAGE="javascript" FOR="tbContentElement" EVENT="DisplayChanged">
    <!--
    return tbContentElement_DisplayChanged();
    //-->
</script>

<script LANGUAGE="javascript" FOR="tbContentElement" EVENT="ShowContextMenu">
    <!--
    return tbContentElement_ShowContextMenu();
    //-->
</script>

<script LANGUAGE="javascript" FOR="tbContentElement" EVENT="ContextMenuAction(itemIndex)">
    <!--
    return tbContentElement_ContextMenuAction(itemIndex, <%=columnID%>);
    //-->
</script>

<script LANGUAGE="javascript" FOR=tbContentElement EVENT=DocumentComplete>
    <!--
    tbContentElement_DocumentComplete();
    //-->
</script>

<script LANGUAGE=javascript>
function DECMD_IMAGE_onclick()
{
    window.open('../upload/picupload.jsp?column=<%=columnID%>', "upload", 'width=610,height=380,scrollbars=yes,status=yes');
    return true;
}

if (window.Event)
{
    document.captureEvents(Event.MOUSEUP);
}

function nocontextmenu()
{
    event.cancelBubble = true
    event.returnValue = false;
    return false;
}

function norightclick(e)
{
    if (window.Event)
    {
        if (e.which == 2 || e.which == 3)
            return false;
    }
    else
        if (event.button == 2 || event.button == 3)
        {
            event.cancelBubble = true
            event.returnValue = false;
            return false;
        }
}

document.oncontextmenu = nocontextmenu;
// for IE5+
document.onmousedown = norightclick;
// for all others

function checkoption(para, para1)
{
    var param = parseInt(para);
    if (param == 0)
        document.createForm.cname.value = "ColumnTemplate";
    else if (param == 1)
        document.createForm.cname.value = "ArticleTemplate";
    else if (param == 2)
        document.createForm.cname.value = "IndexTemplate";
    else if (param == 3)
        document.createForm.cname.value = "SubjectTemplate";

    var selectlens = new Array;
    selectlens[0] = 13;
    selectlens[1] = <%=attrList.size() - 1%>;
    var optionsname = new Array();
    var optionsvalue = new Array();

    optionsname[0] = new Array();
    optionsname[0][0] = "Select Mark";
    optionsname[0][1] = "ArticleList";
    optionsname[0][2] = "ColumnList";
    optionsname[0][3] = "ChinesePath";
    optionsname[0][4] = "EnglishPath";
    optionsname[0][5] = "TopStories";
    optionsname[0][6] = "RelatedArticle";
    optionsname[0][7] = "SubArticleList";
    optionsname[0][8] = "ArticleCount";
    optionsname[0][9] = "SubArticleCount";
    optionsname[0][10] = "Navbar";
    optionsname[0][11] = "AD";
    optionsname[0][12] = "ColumnName";
    optionsname[0][13] = "ParentColumnName";

    optionsvalue[0] = new Array();
    optionsvalue[0][0] = "NO_SELECT";
    optionsvalue[0][1] = "ARTICLE_LIST";
    optionsvalue[0][2] = "COLUMN_LIST";
    optionsvalue[0][3] = "CHINESE_PATH";
    optionsvalue[0][4] = "ENGLISH_PATH";
    optionsvalue[0][5] = "TOP_STORIES";
    optionsvalue[0][6] = "RELATED_ARTICLE";
    optionsvalue[0][7] = "SUBARTICLE_LIST";
    optionsvalue[0][8] = "ARTICLE_COUNT";
    optionsvalue[0][9] = "SUBARTICLE_COUNT";
    optionsvalue[0][10] = "NAVBAR";
    optionsvalue[0][11] = "ADV_POSITION";
    optionsvalue[0][12] = "COLUMNNAME";
    optionsvalue[0][13] = "PARENT_COLUMNNAME";

    optionsname[1] = new Array();
    optionsvalue[1] = new Array();

<%for (int i=0; i<attrList.size(); i++){
  String temp = (String)attrList.get(i);
  String name = temp.substring(0, temp.indexOf(","));
  String value = temp.substring(temp.indexOf(",") + 1);
  out.println("optionsname[1]["+i+"] =\""+value+"\";\r\n");
  out.println("optionsvalue[1]["+i+"] =\""+name+"\";\r\n");
}%>

    if (param == 2 || param == 3) param = 0;
    MarkName.length = 0;
    for (x = 0; x <= selectlens[param]; x++)
    {
        oOption = document.createElement("OPTION");
        oOption.text = optionsname[param][x];
        oOption.value = optionsvalue[param][x];
        MarkName.add(oOption);
    }
}
</script>
</head>

<body LANGUAGE="javascript" onload="return window_onload()">
<%
    String[][] titlebars = {
            {"TemplateManage", "templatesmain.jsp"},
            {columnName, "templates.jsp?column=" + columnID},
            {"New", ""}
    };
    String[][] operations = {
            {"<a href='javascript:get_src(createForm)'><image src=../images/button_add.gif border=0></a>", " "},
            {"<a href=javascript:window.close();><image src=../images/button_cancel.gif border=0></a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<p><%if (!success && errors) {%><p><font class=cur>Error</font>

<p><%}%>

<table>
    <tr>
        <td align=center colspan=2>
            <form action="createentemplate.jsp" method="post" name=createForm>
                <input type=hidden name=doCreate value=true>
                <input type=hidden name=modelfilename>
                <input type=hidden name=column value="<%=columnID%>">
                <input type=hidden name=rightid value="<%=rightid%>">
                <input type="hidden" name="tempURL" value="<%=request.getRequestURL().toString()+"-"+siteid%>">
                <input type=hidden name=modelSourceCodeFlag value=0>

                <div id=div1 class="tbScriptlet"><textarea name=content><%=content%>
                </textarea></div>
                <%if (column.getParentID() == 0) {%>
                <input onclick=checkoption(2,"createForm") type=radio name=modelType value=2 checked>IndexTemplate
                <%} else {%>
                <input onclick=checkoption(0,"createForm") type=radio name=modelType value=0 checked>ColumnTemplate
                <%}%>
                <input onclick=checkoption(1,"createForm") type=radio name=modelType value=1>ArticleTemplate
                <input onclick=checkoption(3,"createForm") type=radio name=modelType value=3>SubjectTemplate
                &nbsp;&nbsp;&nbsp;&nbsp;ChineseName:<input type=text name="cname" size=20>
                &nbsp;&nbsp;&nbsp;&nbsp;EnglishName:<input type=text name="modelname" size=20 value="<%=modelname%>">
            </form>
        </td>
    </tr>
    <tr>
        <td ID=bottomofFld colspan=2></td>
    </tr>
</table>

<div class="tbToolbar" ID="StandardToolbar">
    <div class="tbButton" ID="ViewHTML" TITLE="View Source" TBSTATE="checked" LANGUAGE="javascript"
         onclick="return VIEW_HTML_onclick(ViewHTML,createForm)">
        <img class="tbIcon" src="../images/source.gif">
    </div>
    <div class="tbSeparator"></div>
    <div class="tbButton" ID="MENU_FILE_OPEN" TITLE="Open File" LANGUAGE="javascript"
         onclick="return Add_Template_onclick(<%=columnID%>)">
        <img class="tbIcon" src="../images/open.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_CUT" TITLE="Cut" LANGUAGE="javascript" onclick="return DECMD_CUT_onclick()">
        <img class="tbIcon" src="../images/cut.gif">
    </div>
    <div class="tbButton" ID="DECMD_COPY" TITLE="Copy" LANGUAGE="javascript" onclick="return DECMD_COPY_onclick()">
        <img class="tbIcon" src="../images/copy.gif">
    </div>
    <div class="tbButton" ID="DECMD_PASTE" TITLE="Paste" LANGUAGE="javascript" onclick="return DECMD_PASTE_onclick()">
        <img class="tbIcon" src="../images/paste.gif">
    </div>

    <div class="tbSeparator"></div>
    <div class="tbButton" ID="DECMD_FINDTEXT" TITLE="Search" LANGUAGE="javascript"
         onclick="return DECMD_FINDTEXT_onclick()">
        <img class="tbIcon" src="../images/find.gif">
    </div>
    <div class="tbButton" ID="DECMD_REPLACETEXT" TITLE="Replace" LANGUAGE="javascript"
         onclick="return DECMD_REPLACETEXT_onclick()">
        <img class="tbIcon" src="../images/replace.gif" WIDTH="23" HEIGHT="22">
    </div>
    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_BOLD" TITLE="Bold" TBTYPE="toggle" LANGUAGE="javascript"
         onclick="return DECMD_BOLD_onclick()">
        <img class="tbIcon" src="../images/bold.gif">
    </div>
    <div class="tbButton" ID="DECMD_ITALIC" TITLE="Italic" TBTYPE="toggle" LANGUAGE="javascript"
         onclick="return DECMD_ITALIC_onclick()">
        <img class="tbIcon" src="../images/italic.gif">
    </div>
    <div class="tbButton" ID="DECMD_UNDERLINE" TITLE="Underline" TBTYPE="toggle" LANGUAGE="javascript"
         onclick="return DECMD_UNDERLINE_onclick()">
        <img class="tbIcon" src="../images/under.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_UNDO" TITLE="Cancel" LANGUAGE="javascript" onclick="return DECMD_UNDO_onclick()">
        <img class="tbIcon" src="../images/undo.gif">
    </div>
    <div class="tbButton" ID="DECMD_REDO" TITLE="Redo" LANGUAGE="javascript" onclick="return DECMD_REDO_onclick()">
        <img class="tbIcon" src="../images/redo.gif">
    </div>
    <div class="tbButton" ID="DECMD_HYPERLINK" TITLE="URL" LANGUAGE="javascript"
         onclick="return DECMD_HYPERLINK_onclick(<%=columnID%>)">
        <img class="tbIcon" src="../images/link.gif">
    </div>
    <div class="tbButton" ID="DECMD_IMAGE" TITLE="Image" LANGUAGE="javascript" onclick="return DECMD_IMAGE_onclick()">
        <img class="tbIcon" src="../images/image.gif">
    </div>
    <div class="tbButton" ID="DECMD_SETFORECOLOR" TITLE="Foreground Color" LANGUAGE="javascript"
         onclick="return DECMD_SETFORECOLOR_onclick()">
        <img class="tbIcon" src="../images/fgcolor.gif">
    </div>
    <div class="tbButton" ID="DECMD_SETBACKCOLOR" TITLE="Background Color" LANGUAGE="javascript"
         onclick="return DECMD_SETBACKCOLOR_onclick()">
        <img class="tbIcon" src="../images/bgcolor.gif">
    </div>
</div>

<div class="tbToolbar" ID="TableToolbar">
    <div class="tbButton" ID="DECMD_INSERTTABLE" TITLE="Insert Table" LANGUAGE="javascript"
         onclick="return TABLE_INSERTTABLE_onclick()">
        <img class="tbIcon" src="../images/instable.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_INSERTROW" TITLE="Insert Row" LANGUAGE="javascript"
         onclick="return TABLE_INSERTROW_onclick()">
        <img class="tbIcon" src="../images/insrow.gif">
    </div>
    <div class="tbButton" ID="DECMD_DELETEROWS" TITLE="Delete Rows" LANGUAGE="javascript"
         onclick="return TABLE_DELETEROW_onclick()">
        <img class="tbIcon" src="../images/delrow.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_INSERTCOL" TITLE="Insert Column" LANGUAGE="javascript"
         onclick="return TABLE_INSERTCOL_onclick()">
        <img class="tbIcon" src="../images/inscol.gif">
    </div>
    <div class="tbButton" ID="DECMD_DELETECOLS" TITLE="Delete Columns" LANGUAGE="javascript"
         onclick="return TABLE_DELETECOL_onclick()">
        <img class="tbIcon" src="../images/delcol.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_INSERTCELL" TITLE="Insert Cell" LANGUAGE="javascript"
         onclick="return TABLE_INSERTCELL_onclick()">
        <img class="tbIcon" src="../images/inscell.gif">
    </div>
    <div class="tbButton" ID="DECMD_DELETECELLS" TITLE="Delete Cells" LANGUAGE="javascript"
         onclick="return TABLE_DELETECELL_onclick()">
        <img class="tbIcon" src="../images/delcell.gif">
    </div>
    <div class="tbButton" ID="DECMD_MERGECELLS" TITLE="Merge Cells" LANGUAGE="javascript"
         onclick="return TABLE_MERGECELL_onclick()">
        <img class="tbIcon" src="../images/mrgcell.gif">
    </div>
    <div class="tbButton" ID="DECMD_SPLITCELL" TITLE="Split Cells" LANGUAGE="javascript"
         onclick="return TABLE_SPLITCELL_onclick()">
        <img class="tbIcon" src="../images/spltcell.gif">
    </div>
    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_JUSTIFYLEFT" TITLE="Left" TBTYPE="toggle" NAME="Justify" LANGUAGE="javascript"
         onclick="return DECMD_JUSTIFYLEFT_onclick()">
        <img class="tbIcon" src="../images/left.gif">
    </div>
    <div class="tbButton" ID="DECMD_JUSTIFYCENTER" TITLE="Middle" TBTYPE="toggle" NAME="Justify" LANGUAGE="javascript"
         onclick="return DECMD_JUSTIFYCENTER_onclick()">
        <img class="tbIcon" src="../images/center.gif">
    </div>
    <div class="tbButton" ID="DECMD_JUSTIFYRIGHT" TITLE="Right" TBTYPE="toggle" NAME="Justify" LANGUAGE="javascript"
         onclick="return DECMD_JUSTIFYRIGHT_onclick()">
        <img class="tbIcon" src="../images/right.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_ORDERLIST" TITLE="OrderList" TBTYPE="toggle" LANGUAGE="javascript"
         onclick="return DECMD_ORDERLIST_onclick()">
        <img class="tbIcon" src="../images/numlist.gif">
    </div>
    <div class="tbButton" ID="DECMD_UNORDERLIST" TITLE="UnorderList" TBTYPE="toggle" LANGUAGE="javascript"
         onclick="return DECMD_UNORDERLIST_onclick()">
        <img class="tbIcon" src="../images/bullist.gif">
    </div>

    <div class="tbSeparator"></div>

    <div class="tbButton" ID="DECMD_OUTDENT" TITLE="Outdent" LANGUAGE="javascript"
         onclick="return DECMD_OUTDENT_onclick()">
        <img class="tbIcon" src="../images/deindent.gif">
    </div>
    <div class="tbButton" ID="DECMD_INDENT" TITLE="Indent" LANGUAGE="javascript"
         onclick="return DECMD_INDENT_onclick()">
        <img class="tbIcon" src="../images/inindent.gif">
    </div>
    <select ID="FontName" class="tbGeneral" style="width:60" TITLE="Font Name" LANGUAGE="javascript"
            onchange="return FontName_onchange()">
        <option value="bold">Bold
        <option value="MingLiU">MingLiU
        <option value="Arial">Arial
        <option value="Courier">Courier
        <option value="Script">Script
        <option value="System">System
        <option value="Verdana">Verdana
    </select>
    <select ID="FontSize" class="tbGeneral" TITLE="Font Size" LANGUAGE="javascript"
            onchange="return FontSize_onchange()">
        <option value="1">1
        <option value="2">2
        <option value="3">3
        <option value="4">4
        <option value="5">5
        <option value="6">6
        <option value="7">7
    </select>
    <select ID="MarkName" class="tbGeneral" TITLE="Font" LANGUAGE="javascript"
            onchange="return MarkName_Add(<%=columnID%>)"></select>
</div>

<object ID="tbContentElement" CLASS="tbContentElement" CLASSID="clsid:2D360201-FFF5-11D1-8D03-00A0C959BC0A"
        CODEBASE="#Version=6,1,0,8594" VIEWASTEXT>
    <param name=Scrollbars value=true>
</object>

<object ID="ObjTableInfo" CLASSID="clsid:47B0DFC7-B7A3-11D1-ADC5-006008A5848C" VIEWASTEXT></object>

<object ID="ObjBlockFormatInfo" CLASSID="clsid:8D91090E-B955-11D1-ADC5-006008A5848C" VIEWASTEXT></object>

<div id="cover" style="position:absolute; top:0; left:0; z-index:9; visibility:visible">
    <TABLE WIDTH=900 height=200 BORDER=0 CELLSPACING=0 CELLPADDING=0>
        <TR>
            <TD><br></td>
        </tr>
    </table>
</div>
<div id="sending" style="position:absolute; top:0; left:0; z-index:10; visibility:visible">
    <TABLE WIDTH=80% BORDER=0 CELLSPACING=0 CELLPADDING=0>
        <TR>
            <TD bgcolor=#ff9900>
                <TABLE WIDTH=100% height=80 BORDER=0 CELLSPACING=2 CELLPADDING=0>
                    <TR>
                        <td bgcolor=#eeeeee align=center>Initializing template now,please wait ...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
                                href="javascript:RefreshDiv();">Refresh</a></td>
                    </tr>
                </table>
            </td>
            <td width=25%></td>
            <td width=30%></td>
        </tr>
    </table>
</div>

<!-- Toolbar Code File. Note: This must always be the last thing on the page -->
<script LANGUAGE="Javascript" SRC="/webbuilder/toolbars/toolbarsfortemplate.js"></script>
<script LANGUAGE="Javascript">tbScriptletDefinitionFile = "/webbuilder/toolbars/menubody.htm";</script>
<script LANGUAGE="Javascript" SRC="/webbuilder/toolbars/tbmenus.js"></script>
</body>
</html>

<script LANGUAGE="Javascript">
    if (!tbContentElement.Busy)
    {
        cover.style.visibility = "hidden";
        sending.style.visibility = "hidden";
    }

    function RefreshDiv()
    {
        if (!tbContentElement.Busy)
        {
            cover.style.visibility = "hidden";
            sending.style.visibility = "hidden";
        }
    }
</script>