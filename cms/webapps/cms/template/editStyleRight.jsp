<%@page import="java.util.*,
                com.bizwink.cms.news.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.viewFileManager.*,
                com.bizwink.cms.extendAttr.*"
        contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String cname = "�б���ʽ�ļ�";
    String headstr = "";
    String content = "";
    String tailstr = "";

    int siteID = authToken.getSiteID();
    int styleID = ParamUtil.getIntParameter(request, "ID", 0);
    int type = ParamUtil.getIntParameter(request, "type", 0);
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    IViewFileManager viewfileMgr = viewFilePeer.getInstance();
    ViewFile viewfile = new ViewFile();

    if (doCreate)
    {
        cname = ParamUtil.getParameter(request, "cname");
        content = ParamUtil.getParameter(request, "content");
        headstr = ParamUtil.getParameter(request, "headstr");
        tailstr = ParamUtil.getParameter(request, "tailstr");
        if (headstr == null)  headstr = "";
        if (tailstr == null)  tailstr = "";

        viewfile.setSiteID(siteID);
        viewfile.setType(type);
        viewfile.setChineseName(cname);
        viewfile.setEditor(authToken.getUserID());
        viewfile.setNotes("");
        viewfile.setContent(headstr.trim() + "<!--ROW-->" + content.trim() + "<!--ROW-->" + tailstr.trim());
        viewfile.setID(styleID);

        int newID = 0;
        if (styleID > 0)
            viewfileMgr.update(viewfile);
        else
            newID = viewfileMgr.create(viewfile);

        String viewer = request.getHeader("user-agent");
        out.println("<script language=javascript>");
        if (viewer.toLowerCase().indexOf("gecko") == -1) {
            out.println("parent.window.returnValue = \"" + newID + "," + cname + "\";");
            out.println("parent.window.close();");
        }else{
            if(type == 1){
                out.println("window.parent.opener.top.frames[\"cmsright\"].document.getElementById(\"listType\").options.add(new Option('" + cname + "'," + newID + "));");
                out.println("window.parent.opener.top.frames[\"cmsright\"].document.getElementById(\"listType\").options[window.parent.opener.top.frames[\"cmsright\"].document.getElementById(\"listType\").length-1].selected=true;");
                out.println("top.close();");
            }else if(type == 4){
                out.println("window.parent.opener.document.getElementById(\"listType\").options.add(new Option('" + cname + "'," + newID + "));");
                out.println("window.parent.opener.document.getElementById(\"listType\").options[window.parent.opener.document.getElementById(\"listType\").length-1].selected=true;");
                out.println("top.close();");
            }else if(type == 3){
                out.println("window.parent.opener.document.getElementById(\"listType\").options.add(new Option('" + cname + "'," + newID + "));");
                out.println("window.parent.opener.document.getElementById(\"listType\").options[window.parent.opener.document.getElementById(\"listType\").length-1].selected=true;");
                out.println("top.close();");
            }
        }
        out.println("</script>");
        return;
    }

    if (styleID > 0) {
        viewfile = viewfileMgr.getAViewFile(styleID);
        cname = viewfile.getChineseName();
        String str = viewfile.getContent();
        cname = StringUtil.gb2iso4View(cname);
        str = StringUtil.gb2iso4View(str);

        headstr = str.substring(0, str.indexOf("<!--ROW-->")).trim();
        content = str.substring(str.indexOf("<!--ROW-->")+10, str.lastIndexOf("<!--ROW-->")).trim();
        tailstr = str.substring(str.lastIndexOf("<!--ROW-->") + 10).trim();
    }

    String marks = "";
    if (type == 6) {
        marks = marks + "<option value='<A HREF=<"+"%%COLUMNURL%%"+"> target=_blank><"+"%%COLUMNNAME%%"+"></A>'>��Ŀ����</option>";
        marks = marks + "<option value='<"+"%%COLUMNDESC%%"+">'>��Ŀ����</option>";
        marks = marks + "<option value='<"+"%%COLUMNID%%"+">'>��ĿID</option>";
        marks = marks + "<option value='<"+"%%sitename%%"+">'>վ������</option>";
    } else {
        IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
        List attrList = extendMgr.getAttrForStyle(columnID);
        marks = marks + "<option value='" + "<" + "%%__num%%" + ">'>���</option>";
        for (int i=0; i<attrList.size(); i++) {
            String temp = (String)attrList.get(i);
            String ename = temp.substring(0, temp.indexOf(","));
            String cname2 = temp.substring(temp.indexOf(",") + 1);
            marks = marks + "<option value='" + ename + "'>" + cname2 + "</option>";
        }
    }

    IColumnManager columnMgr = ColumnPeer.getInstance();
    String columnName = "";
    if(columnMgr.getColumn(columnID) != null){
        columnName = columnMgr.getColumn(columnID).getCName();
        columnName = StringUtil.gb2iso4View(columnName);
    }
%>

<html>
<head>
    <title>ѡ���б���ʽ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language=javascript>
        function SelectMarkName()
        {
            var i = document.editForm.markname.selectedIndex;
            var str = document.editForm.markname.options[i].value;
            if (str != "" && str != "1")
                insertAtCaret(document.editForm.content, str);
            document.editForm.markname.options[0].selected = true;
        }

        function storeCaret(textEl)
        {
            if (textEl.createTextRange)
                textEl.caretPos = document.selection.createRange().duplicate();
        }

        function insertAtCaret(textObj, textFeildValue) {
            if (document.all) {
                if (textObj.createTextRange && textObj.caretPos) {
                    var caretPos = textObj.caretPos;
                    caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == '   '   ?textFeildValue + '   '   :   textFeildValue;
                } else {
                    textObj.value = textFeildValue;
                }
            } else {
                if (textObj.setSelectionRange) {
                    var rangeStart = textObj.selectionStart;
                    var rangeEnd = textObj.selectionEnd;
                    var tempStr1 = textObj.value.substring(0, rangeStart);
                    var tempStr2 = textObj.value.substring(rangeEnd);
                    textObj.value = tempStr1 + textFeildValue + tempStr2;
                } else {
                    alert("This   version   of   Mozilla   based   browser   does   not   support   setSelectionRange");
                }
            }
        }

        function save()
        {
            if (document.editForm.cname.value == "")
            {
                alert("��������ʽ�ļ��������ƣ�");
                document.editForm.cname.focus();
                return false;
            }
            else if (document.editForm.content.value == "")
            {
                alert("��������ʽ�ļ����ݣ�");
                document.editForm.content.focus();
                return false;
            }
            return true;
        }

        function insertpic()
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if(isMSIE){
                var retstr = showModalDialog("styleImage.jsp", "SelectStyleImage","font-family:Verdana;font-size:12;dialogWidth:36em;dialogHeight:28em;status:no");
                if (retstr != "" && retstr != undefined)
                {
                    insertAtCaret(document.editForm.content, retstr);
                }
            }else{
                wins = window.open("styleImage.jsp", "", "width=400,height=200");
                wins.focus();
            }
        }
    </script>
</head>

<body bgcolor="#CCCCCC">
<form method="POST" action="editStyleRight.jsp" name="editForm" onsubmit="javascript:return save();">
    <input type="hidden" name="doCreate" value="true">
    <input type="hidden" name="ID" value="<%=styleID%>">
    <input type="hidden" name="type" value="<%=type%>">
    <table border="0" width="100%">
        <tr>
            <td>��ǰ��Ŀ���ƣ�<b><font color=red><%=columnName%></font></b></td>
        </tr>
        <tr>
            <td width="100%">
                <table border="0" width="100%">
                    <tr height="30">
                        <td width="45%">�������ƣ�<input size=16 name="cname" value="<%=cname%>" class=tine></td>
                        <td width="55%">�б��ǣ�
                            <select size="1" name="markname" style="width:120" onchange="SelectMarkName();" class=tine>
                                <option value="">ѡ���б���</option>
                                <%=marks%>
                            </select>
                            <input type="button" value="ͼƬ" style="font-size:9pt;height:18" onclick="insertpic();">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center">
                <textarea rows="3" name="headstr" cols="86" style="font-size: 8pt; font-family: Georgia"><%=headstr%></textarea><br>
                <textarea rows="13" id="content" name="content" cols="86" WRAP="soft" ONSELECT="storeCaret(this);" ONCLICK="storeCaret(this);" ONKEYUP="storeCaret(this);" style="font-size: 8pt; font-family: Georgia"><%=content%></textarea><br>
                <textarea rows="3" name="tailstr" cols="86" style="font-size: 8pt; font-family: Georgia"><%=tailstr%></textarea>
            </td>
        </tr>
        <tr>
            <td align="center" height="50">
                <input type="submit" value="  ����  " class=tine>&nbsp;&nbsp;<input type="button" value="  ȡ��  " onclick="top.close();" class=tine>
            </td>
        </tr>
    </table>
</form>

</body>
</html>