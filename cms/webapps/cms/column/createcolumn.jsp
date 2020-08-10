<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    session.setAttribute("Current_URL", request.getRequestURI());
    int siteid = authToken.getSiteID();
    String editor = authToken.getUserID();
    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = new Column();
    Tree colTree = TreeManager.getInstance().getSiteTree(siteid);
    int rootID = colTree.getTreeRoot();

    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int parentID = ParamUtil.getIntParameter(request, "parentID", 0);

    boolean errors = false;
    boolean success = false;
    boolean errorCName = false;
    boolean errorEName = false;
    String CName = "";
    String EName = "";
    String extfilename = "";
    int orderid = 0;
    int isAudited = 0;
    int isProduct = 0;
    int isLocation = 0;
    int publicflag = 0;
    int isPublishMore = 0;
    int languageType = 0;
    boolean dualName = false;
    String desc = "";
    int contentshowtype = 0;
    int userflag = 0;
    int userlevel = 0;
    String titlepic = "";
    String vtitlepic = "";
    String sourcepic = "";
    String authorpic = "";
    String contentpic = "";
    String specialpic = "";
    String productpic = "";
    String productsmallpic = "";
    String xmlTemplate = "";
    int isDefineAttr = 0;
    int extattrscope = 0;

    if (doCreate) {
        CName = ParamUtil.getParameter(request, "CName");
        EName = ParamUtil.getParameter(request, "EName");
        extfilename = ParamUtil.getParameter(request, "extfilename");
        orderid = ParamUtil.getIntParameter(request, "orderid", 1);
        desc = ParamUtil.getParameter(request, "desc");
        isAudited = ParamUtil.getIntParameter(request, "isAudited", 0);
        isProduct = ParamUtil.getIntParameter(request, "isProduct", 0);
        isLocation = ParamUtil.getIntParameter(request, "islocation", 0);
        isPublishMore = ParamUtil.getIntParameter(request, "isPublishMore", 0);
        languageType = ParamUtil.getIntParameter(request, "languageType", 0);
        contentshowtype = ParamUtil.getIntParameter(request, "showtype", 0);
        userflag = ParamUtil.getIntParameter(request,"userflag",0);
        publicflag = ParamUtil.getIntParameter(request,"publicflag",0);
        xmlTemplate = ParamUtil.getParameter(request, "xmlTemplate");
        isDefineAttr = ParamUtil.getIntParameter(request, "isDefineAttr", 0);
        extattrscope = ParamUtil.getIntParameter(request, "extattrscope", 0);

        if(ParamUtil.getParameter(request,"titlepicheight")!=null && ParamUtil.getParameter(request,"titlepicwidth")!=null){
            titlepic = ParamUtil.getParameter(request,"titlepicheight") + "X" + ParamUtil.getParameter(request,"titlepicwidth");
        }
        if(ParamUtil.getParameter(request,"vtitlepicheight") != null &&  ParamUtil.getParameter(request,"vtitlepicwidth")!= null){
            vtitlepic = ParamUtil.getParameter(request,"vtitlepicheight") + "X" + ParamUtil.getParameter(request,"vtitlepicwidth");
        }
        if(ParamUtil.getParameter(request,"sourcepicheight") != null && ParamUtil.getParameter(request,"sourcepicwidth") != null){
            sourcepic = ParamUtil.getParameter(request,"sourcepicheight") + "X" + ParamUtil.getParameter(request,"sourcepicwidth");
        }
        if(ParamUtil.getParameter(request,"authorpicheight") != null && ParamUtil.getParameter(request,"authorpicwidth") != null){
            authorpic = ParamUtil.getParameter(request,"authorpicheight") + "X" + ParamUtil.getParameter(request,"authorpicwidth");
        }
        if(ParamUtil.getParameter(request,"contentpicheight")!=null && ParamUtil.getParameter(request,"contentpicwidth")!=null){
            contentpic = ParamUtil.getParameter(request,"contentpicheight") + "X" + ParamUtil.getParameter(request,"contentpicwidth");
        }
        if(ParamUtil.getParameter(request,"specialpicheight") != null && ParamUtil.getParameter(request,"specialpicwidth") != null){
            specialpic = ParamUtil.getParameter(request,"specialpicheight") + "X" + ParamUtil.getParameter(request,"specialpicwidth");
        }
        if(ParamUtil.getParameter(request,"productpicheight") != null && ParamUtil.getParameter(request,"productpicwidth") != null) {
            productpic = ParamUtil.getParameter(request,"productpicheight") + "X" + ParamUtil.getParameter(request,"productpicwidth");
        }
        if(ParamUtil.getParameter(request,"productsmallpicheight") != null && ParamUtil.getParameter(request,"productsmallpicwidth") !=null){
            productsmallpic = ParamUtil.getParameter(request,"productsmallpicheight") + "X" + ParamUtil.getParameter(request,"productsmallpicwidth");
        }

        if(userflag == 1){
            userlevel = ParamUtil.getIntParameter(request,"userlevel",0);
        }

        if (CName == null) {
            errorCName = true;
            errors = true;
        }
        if (EName == null) {
            errorEName = true;
            errors = true;
        }
        if (desc != null)
            desc = desc.trim();
        else
            desc = "";
    }

    if (!errors && doCreate) {
        dualName = columnManager.duplicateEnName(parentID, EName);
        if (!dualName) {
            try {
                column.setSiteID(siteid);
                column.setParentID(parentID);
                column.setCName(StringUtil.gb2isoindb(CName));
                column.setEName(EName);
                column.setExtname(extfilename);
                column.setCreateDate(new Timestamp(System.currentTimeMillis()));
                column.setLastUpdated(new Timestamp(System.currentTimeMillis()));
                column.setOrderID(orderid);
                column.setEditor(editor);
                column.setDesc(StringUtil.gb2isoindb(desc));
                column.setDefineAttr(isDefineAttr);
                column.setXMLTemplate(xmlTemplate);
                column.setExtattrscope(extattrscope);
                column.setIsAudited(isAudited);
                column.setIsProduct(isProduct);
                column.setIsPosition(isLocation);
                column.setIsPublishMoreArticleModel(isPublishMore);
                column.setLanguageType(languageType);
                column.setContentShowType(contentshowtype);
                column.setUserflag(userflag);
                column.setPublicflag(publicflag);
                column.setUserlevel(userlevel);
                column.setTitlepic(titlepic);
                column.setVtitlepic(vtitlepic);
                column.setSourcepic(sourcepic);
                column.setAuthorpic(authorpic);
                column.setContentpic(contentpic);
                column.setSpecialpic(specialpic);
                column.setProductpic(productpic);
                column.setProductsmallpic(productsmallpic);
                columnManager.create(column);
                success = true;
            }
            catch (ColumnException uaee) {
                uaee.printStackTrace();
                errors = true;
            }
        }
    }

    if (success) {
        //out.println("<script>top.close();</script>");
        //out.println("<script>top.close();opener.location.href = \"/webbuilder/column/index.jsp\"</script>");
        response.sendRedirect(response.encodeRedirectURL("index.jsp?rightid=1&msgno=0"));
        return;
    }
    //����Ѵ��ڵ�վ����Ϣ
    column = columnManager.getColumn(parentID);
    String parentName = StringUtil.gb2iso4View(column.getCName());
    String seperator = "*";
    titlepic = column.getTitlepic();
    System.out.println("titlepic=" + titlepic + "ffffff");
    int posi = -1;
    if (titlepic!= null) posi = titlepic.indexOf(seperator);
    if (posi == -1) seperator = "X";
    vtitlepic = column.getVtitlepic();
    sourcepic = column.getSourcepic();
    authorpic = column.getAuthorpic();
    contentpic = column.getContentpic();
    specialpic = column.getSpecialpic();
    productpic = column.getProductpic();
    productsmallpic = column.getProductsmallpic();
    //�����ҳ�ļ���չ��
    String extname = columnManager.getIndexExtName(siteid);

    IViewFileManager viewMgr = viewFilePeer.getInstance();
    List viewList = viewMgr.getViewFileC(siteid, 11);
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <script language=javascript>
        function editAttr(){
            //var bln = confirm("��Ҫ�̳и���Ŀ����չ������");
            //if (!bln)
            //    window.open("editnewattr.jsp", "", "width=1000,height=600,left=200,right=200,scrollbars,status");

            var result = window.showModalDialog("confirm.jsp","","dialogHeight:100px;dialogWidth:280px;status:no; help:no;scroll:no");
            if (result == "self")
                window.open("editnewattr.jsp", "", "width=1000,height=600,left=200,right=200,top=10,scrollbars,status");
        }

        function check(frm)
        {
            if (frm.CName.value == "")
            {
                alert("��Ŀ�������Ʋ���Ϊ�գ�");
                return false;
            }
            if (frm.CName.value.indexOf(",") > -1)
            {
                alert("��Ŀ���������в��ܺ��ж��ţ�");
                return false;
            }
            if (frm.EName.value == "")
            {
                alert("��ĿӢ�����Ʋ���Ϊ�գ�");
                return false;
            }
            else if (!checkEname(frm.EName.value))
            {
                alert("��ĿӢ�����Ʋ��Ϸ���Ӧ������ĸ�����ּ��»�����ɣ�");
                return false;
            }
            if (frm.userflag[1].checked) {
                var num = frm.userlevel.value;
                if (!isNumber(num)) {
                    alert("�û����������������");
                    frm.userlevel.focus();
                    return false;
                }
            }
            if(frm.titlepicheight.value != ""){
                if( !isNumber(frm.titlepicheight.value)){
                    alert("������������ ��:36");
                    frm.titlepicheight.focus();
                    return false;
                }
            }
            if(frm.titlepicwidth.value != ""){
                if( !isNumber(frm.titlepicwidth.value)){
                    alert("������������ ��:36");
                    frm.titlepicwidth.focus();
                    return false;
                }
            }
            if(frm.vtitlepicheight.value != ""){
                if( !isNumber(frm.vtitlepicheight.value)){
                    alert("������������ ��:36");
                    frm.vtitlepicheight.focus();
                    return false;
                }
            }
            if(frm.vtitlepicheight.value != ""){
                if( !isNumber(frm.vtitlepicheight.value)){
                    alert("������������ ��:36");
                    frm.vtitlepicheight.focus();
                    return false;
                }
            }
            if(frm.sourcepicheight.value != ""){
                if( !isNumber(frm.sourcepicheight.value)){
                    alert("������������ ��:36");
                    frm.sourcepicheight.focus();
                    return false;
                }
            }
            if(frm.sourcepicwidth.value != ""){
                if( !isNumber(frm.sourcepicwidth.value)){
                    alert("������������ ��:36");
                    frm.sourcepicwidth.focus();
                    return false;
                }
            }
            if(frm.authorpicheight.value != ""){
                if( !isNumber(frm.authorpicheight.value)){
                    alert("������������ ��:36");
                    frm.authorpicheight.focus();
                    return false;
                }
            }
            if(frm.authorpicwidth.value != ""){
                if( !isNumber(frm.authorpicwidth.value)){
                    alert("������������ ��:36");
                    frm.authorpicwidth.focus();
                    return false;
                }
            }
            if(frm.contentpicheight.value != ""){
                if( !isNumber(frm.contentpicheight.value)){
                    alert("������������ ��:36");
                    frm.contentpicheight.focus();
                    return false;
                }
            }
            if(frm.contentpicwidth.value != ""){
                if( !isNumber(frm.contentpicwidth.value)){
                    alert("������������ ��:36");
                    frm.contentpicwidth.focus();
                    return false;
                }
            }
            if(frm.specialpicheight.value != ""){
                if( !isNumber(frm.specialpicheight.value)){
                    alert("������������ ��:36");
                    frm.specialpicheight.focus();
                    return false;
                }
            }
            if(frm.specialpicwidth.value != ""){
                if( !isNumber(frm.specialpicwidth.value)){
                    alert("������������ ��:36");
                    frm.specialpicwidth.focus();
                    return false;
                }
            }
            if(frm.productpicheight.value != ""){
                if( !isNumber(frm.productpicheight.value)){
                    alert("������������ ��:36");
                    frm.titlepicheight.focus();
                    return false;
                }
            }
            if(frm.productpicwidth.value != ""){
                if( !isNumber(frm.productpicwidth.value)){
                    alert("������������ ��:36");
                    frm.productpicwidth.focus();
                    return false;
                }
            }
            if(frm.productsmallpicheight.value != ""){
                if( !isNumber(frm.productsmallpicheight.value)){
                    alert("������������ ��:36");
                    frm.productsmallpicheight.focus();
                    return false;
                }
            }
            if(frm.productsmallpicwidth.value != ""){
                if( !isNumber(frm.productsmallpicwidth.value)){
                    alert("������������ ��:36");
                    frm.productsmallpicwidth.focus();
                    return false;
                }
            }

            function isNumber(num) {
                strRef = "1234567890";
                for (i = 0; i < num.length; i++)
                {
                    tempChar = num.substring(i, i + 1);
                    if (strRef.indexOf(tempChar, 0) == -1) {
                        return false;
                    }
                }
                return true;
            }
            return true;
        }

        function checkEname(str)
        {
            var regstr = /[^0-9a-zA-Z_]/gi;
            if (regstr.exec(str) != null)
                return false;
            else
                return true;
        }

        function Upload()
        {
            window.open("../upload/upload.jsp?column=<%=rootID%>&attr=createDesc", "Upload", "width=400,height=200,left=200,top=200");
        }

        function displayProdPic() {
            var radio = document.getElementsByName("isProduct");
            var radioval = null;
            for (i=0; i<radio.length; i++) {
                if (radio[i].checked) {
                    radioval = radio[i].value;
                    break;
                }
            }
            if (parseInt(radioval,10) == 1) {
                var prodLargePicRow = document.getElementById("prod_largepic_id");
                prodLargePicRow.style.display = "block";
                var prodSmallPicRow = document.getElementById("prod_smallpic_id");
                prodSmallPicRow.style.display = "block";
            } else {
                var prodLargePicRow = document.getElementById("prod_largepic_id");
                prodLargePicRow.style.display = "none";
                var prodSmallPicRow = document.getElementById("prod_smallpic_id");
                prodSmallPicRow.style.display = "none";
            }
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"�½���Ŀ", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>
    <%
        if (!success && errors) {
            out.println("<p class=cur>");
            if (!success)
                out.println("��Ŀ " + EName + " �Ѿ����ڡ�����һ����Ŀ����");
            else
                out.println("�����д������������ֶΣ����ԡ�");
        }
    %>
</p>
<center>
    <form action="createcolumn.jsp" method="post" name="createForm" onsubmit="return check(this);">
        <input type="hidden" name="doCreate" value="true">
        <input type="hidden" name="parentID" value="<%=parentID%>">
        <input type=hidden name="xmlTemplate" value="">
        <input type=hidden name="extattrscope" value="0">
        <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="60%">
            <tr height=20>
                <td align=right class=line>����Ŀ����</td>
                <td class=tine>&nbsp;<%= parentName %>
                </td>
            </tr>
            <tr height=30>
                <td align=right><font class=line <%= (errorCName) ? (" color=\"#ff0000\"") : "" %>>��Ŀ���ƣ�</font></td>
                <td>&nbsp;<input class=tine name=CName size=30 value="<%= (CName!=null)?CName:"" %>">*</td>
            </tr>
            <tr height=30>
                <td align=right><font class=line <%= (errorEName) ? (" color=\"#ff0000\"") : "" %>>��ĿĿ¼��</font></td>
                <td>&nbsp;<input class=tine name=EName size=30 value="<%= (EName!=null)?EName:"" %>">*&nbsp;&nbsp;
                    <font color=red>Ŀ¼����ĸ�����ּ��»������</font>
                </td>
            </tr>
            <tr height=30>
                <td align=right class=line>��Ŀ����</td>
                <td>&nbsp;<input class=tine name=orderid size=30 value="0">*</td>
            </tr>
            <tr height=30>
                <td class=line align=right>�ļ���չ����</td>
                <td class=tine>&nbsp;<select name=extfilename size=1 class=tine style="width:100">
                    <option value="html" <%if(extname.equalsIgnoreCase("html")){%>selected<%}%>>html</option>
                    <option value="htm" <%if(extname.equalsIgnoreCase("htm")){%>selected<%}%>>htm</option>
                    <option value="jsp" <%if(extname.equalsIgnoreCase("jsp")){%>selected<%}%>>jsp</option>
                    <option value="asp" <%if(extname.equalsIgnoreCase("asp")){%>selected<%}%>>asp</option>
                    <option value="shtm" <%if(extname.equalsIgnoreCase("shtm")){%>selected<%}%>>shtm</option>
                    <option value="shtml" <%if(extname.equalsIgnoreCase("shtml")){%>selected<%}%>>shtml</option>
                    <option value="php" <%if(extname.equalsIgnoreCase("php")){%>selected<%}%>>php</option>
                    <option value="wml" <%if(extname.equalsIgnoreCase("wml")){%>selected<%}%>>wml</option>
                </select></td>
            </tr>
            <tr height=30>
                <td class=line align=right>��Ŀ�������ͣ�</td>
                <td class=tine>&nbsp;<select name=languageType size=1 class=tine style="width:100">
                    <option value="0" selected>��������</option>
                    <option value="1">��������</option>
                    <option value="2">����</option>
                </select>
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>չʾ��ʽ��</td>
                <td class=tine>&nbsp;<input type="radio" name="showtype" value="0" checked> WEB
                    <input type="radio" name="showtype" value="1"> WAP��WEB
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>�Ƿ���Ҫ��ˣ�</td>
                <td class=tine>&nbsp;<input type=radio name="isAudited" checked value="0">��&nbsp;&nbsp;
                    <input type=radio name="isAudited" value="1">��
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>�Ƿ���Ҫ��չ���ԣ�</td>
                <td class=tine>&nbsp;<input type=radio name="isDefineAttr" value="0" checked>��&nbsp;&nbsp;
                    <input type=radio name="isDefineAttr" value="1" onclick="editAttr();">��
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>�Ƿ������վע���û�������Ϣ��</td>
                <td class=tine>&nbsp;<input type=radio name="publicflag" checked value="0">��&nbsp;&nbsp;
                    <input type=radio name="publicflag" value="1">��
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>����λ����Ϣ��</td>
                <td class=tine>&nbsp;<input type=radio name="islocation" checked value="0">��&nbsp;&nbsp;
                    <input type=radio name="islocation" value="1">��
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>�����������ģ�壺</td>
                <td class=tine>&nbsp;<input type=radio name="isPublishMore" checked value="0">��&nbsp;&nbsp;
                    <input type=radio name="isPublishMore" value="1">��
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>��Ŀ���ԣ�</td>
                <td class=tine>
                    &nbsp;<input type=radio name="isProduct"  value="0" checked onclick="javascript:displayProdPic();">����
                    <input type=radio name="isProduct"  value="1"  onclick="javascript:displayProdPic();">��Ʒ
                </td>
            </tr>
            <tr height=30>
                <td class=line align=right>��Ŀ����Ȩ�޿��ƣ�</td>
                <td class=tine>
                    &nbsp;<input type=radio name="userflag" value="0" onclick='javascript:userlevel.readOnly=true;'
                                 checked>�����û��ɼ�
                    <input type=radio name="userflag" value="1" onclick='javascript:userlevel.readOnly=false;'>ֻ��ע���û��ɼ�&nbsp;&nbsp;
                    �û�����
                    <select name="userlevel" id="userlevel">
                        <option value="-1">---��ѡ��---</option>
                        <option value="0">��ͨ�û�</option>
                        <option value="1">�ڲ��û�</option>
                        <option value="2">��ҵ�û�</option>
                        <option value="3">VIP�û�</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class=line align=right>��Ŀ������</td>
                <td class=tine>&nbsp;<textarea class=tine rows="4" name="desc" cols="40"></textarea>
                    <a href="javascript:Upload();">ͼƬ</a>
                </td>
            </tr>

            <tr height=20>
                <td align=right class=line>����ͼƬ��С��</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="titlepicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="titlepicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20>
                <td align=right class=line>������ͼƬ��С��</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="vtitlepicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="vtitlepicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20>
                <td align=right class=line>��ԴͼƬ��С��</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="sourcepicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="sourcepicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20>
                <td align=right class=line>����ͼƬ��С��</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="authorpicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="authorpicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20>
                <td align=right class=line>����ͼƬ��С��</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="contentpicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="contentpicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20>
                <td align=right class=line>������ЧͼƬ��С��</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="specialpicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="specialpicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20 id="prod_largepic_id" style="display: none">
                <td align=right class=line>��Ʒ��ͼƬ��С:</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="productpicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="productpicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20 id="prod_smallpic_id"  style="display: none">
                <td align=right class=line>��ƷСͼƬ��С:</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="productsmallpicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="productsmallpicwidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20 id="mediafile_id" style="display: <%=(isProduct==1)?"block":"none"%>">
                <td align=right class=line>��Ƶ�ļ�:</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="mediaheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="mediawidth" type="text" size="3" value="">px
                </td>
            </tr>
            <tr height=20 id="mediapic_id" style="display: <%=(isProduct==1)?"block":"none"%>">
                <td align=right class=line>��Ƶ��ȡͼƬ:</td>
                <td class=tine>&nbsp;�߶ȣ�<input name="mediapicheight" type="text" size="3" value="">px &nbsp; ��ȣ�<input name="mediapicwidth" type="text" size="3" value="">px
                </td>
            </tr>
        </table>
        <br>
        <input type=submit value="  ����  ">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type=button value="  ����  " onclick="history.go(-1);">
    </form>
</center>

</BODY>
</html>
