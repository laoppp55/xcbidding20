<%@page import="java.util.*,
                com.bizwink.cms.viewFileManager.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.xml.*"
        contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.markManager.mark" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    //     �޸ı༭����ȡֵ
    int markID = ParamUtil.getIntParameter(request, "mark", 0);

    int siteID = authToken.getSiteID();
    IMarkManager markMgr = markPeer.getInstance();
    mark vmark=null;
    if(markID>0) vmark=markMgr.getAMark(markID);
    String sitename = authToken.getSitename();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);

    //��ȡϵͳ����ķ�ҳ����ʽ�ͱ�վ���Լ�����ķ�ҳ����ʽ ,����޸�ϵͳ����ķ�ҳ����ʽ��ϵͳ���Զ�����Ϊ��վ��ӵ�е��Զ����ҳ����ʽ
    IViewFileManager viewfileMgr = viewFilePeer.getInstance();
    List navList = viewfileMgr.getViewFileC(siteID, 2);
    ViewFile viewfile = new ViewFile();

    //��ȡ���԰���ı�Ƕ���
    List marks = markMgr.getMarksByType(siteID,21);
    String notes = "";
    String content = "";
    String cname = "�û������б�";
    String lwforms = "";                  //�������б�������ı�ID
    int lwforms_n = 0;                    //�������б�������ı�ID�����ֱ�ʾ
    int auditflag = 0;                    //0��ʾ���е��û�������Ϣ  1ֻ��ʾͨ����˵�������Ϣ
    int fenyestyle = -1;                  //��ҳ������ʽID

    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");

    if (doCreate) {
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        content = ParamUtil.getParameter(request, "content");
        lwforms = ParamUtil.getParameter(request, "lwforms");
        auditflag = ParamUtil.getIntParameter(request, "audit",0);
        String relatedCID = "()";
        int ranges = ParamUtil.getIntParameter(request,"ranges",0);
        fenyestyle = ParamUtil.getIntParameter(request,"fenyelist",0);
        String xmlstr = "[TAG][LEAVEMESSAGELIST][SITEID]"+siteID+"[/SITEID][FORMID]" + lwforms + "[/FORMID][RANGE]"+ranges+"[/RANGE]" +
                "[CHINESENAME]"+cname+"[/CHINESENAME][NOTES]"+notes+"[/NOTES][AUDIT]" + auditflag + "[/AUDIT][PAGES]" + fenyestyle +
                "[/PAGES][LISTSTYLE]<!{^CDATA{^" + content + ">^}^}>[/LISTSTYLE][/LEAVEMESSAGELIST]"+ "[/TAG]";

        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(xmlstr);
        mark.setMarkType(22);
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(0);
        mark.setRelatedColumnID(relatedCID);

        int orgmarkid = markID;
        if (markID > 0)
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        if (viewer.toLowerCase().indexOf("gecko") == -1)
            out.println("<script>window.returnValue=\"[TAG][MARKID]" + markID+"_"+columnID + "[/MARKID][/TAG]\";window.close();</script>");
        else {
            if(orgmarkid > 0){
                out.println("<script>top.close();</script>");
            }else{
                String returnvalue = "[TAG][MARKID]" + markID + "[/MARKID][/TAG]";
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + cname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
        }
        return;
    }

    int range = 10;
    String listStyle = null;
    if (markID > 0) {
        String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(markID));
        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        str = StringUtil.replace(str, "{^", "[");
        str = StringUtil.replace(str, "^}", "]");

        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
        range = Integer.parseInt(properties.getProperty(properties.getName().concat(".RANGE")));

        fenyestyle = Integer.parseInt(properties.getProperty(properties.getName().concat(".PAGES")));//��ҳ��ʽ
        cname = properties.getProperty(properties.getName().concat(".CHINESENAME"));
        listStyle = properties.getProperty(properties.getName().concat(".LISTSTYLE"));
        if (listStyle != null) listStyle = listStyle.substring(0,listStyle.length() -1);
        lwforms = properties.getProperty(properties.getName().concat(".FORMID"));
        if (lwforms != null) lwforms_n=Integer.parseInt(lwforms);
        if(cname == null) cname = "�û������б�";
        notes = properties.getProperty(properties.getName().concat(".NOTES"));
        if (notes == null) notes = "";
    }
%>

<html>
<head>
    <base target="_self" >
    <title>���������б�</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="javascript" src="../js/mark.js"></script>
    <meta http-equiv="Pragma" content="no-cache">
    <script type="text/javascript">
        function createStyle(type, columnID){
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            winstrs = "../template/editOtherStyle.jsp?type=" + type;
            if (isMSIE)
                retstr = showModalDialog(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
            else {
                artwin = window.open(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
                artwin.focus();
            }

            if (retstr != "" && retstr != undefined) {
                var newoption = document.createElement("OPTION");
                newoption.value = retstr.substring(0, retstr.indexOf(","));
                newoption.text = retstr.substring(retstr.indexOf(",") + 1);

                document.all("fenyelist").add(newoption);
                document.all("fenyelist").options[document.all("fenyelist").length - 1].selected = true;
            }
        }

        function updateStyle(type, styleID, columnID){
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                var retstr = showModalDialog("../template/editOtherStyle.jsp?type=" + type + "&ID=" + styleID, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
            } else {
                wins = window.open("../template/editOtherStyle.jsp?type=" + type + "&ID=" + styleID, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
                wins.focus();
            }
        }

        function previewStyle(type, styleID)
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                if (styleID > 0) {
                    showModalDialog("../template/getviewfile.jsp?id=" + styleID + "&type=" + type, "", "font-family:Verdana;font-size:12;dialogWidth:40em;dialogHeight:16em;status:no");
                }
            } else {
                if (styleID > 0) {
                    wins = window.open("../template/getviewfile.jsp?id=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
                    wins.focus();
                }
            }
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

        function SelectMarkName()
        {
            var i = document.markform.fields.selectedIndex;
            var str = "";
            if (document.markform.fields.options[i].text!="��ʾ����")
                str = "<" + "%%" + document.markform.fields.options[i].value + "%%" + ">";
            else
                str = "<a href=\"/_commons/displeavemessage.jsp?lid=<" + "%%" + document.markform.fields.options[i].value + "%%" + ">\" target=\"_blank\"><"+"%%title%%" + "></a>";

            if (str != "" && str != "1")
                insertAtCaret(document.markform.content, str);
            document.markform.fields.options[0].selected = true;
        }

        function storeCaret(textEl)
        {
            if (textEl.createTextRange)
                textEl.caretPos = document.selection.createRange().duplicate();
        }

        function getFormFileds(p1,p2) {
            var objXml;
            if (window.ActiveXObject) {
                objXml = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                objXml = new XMLHttpRequest("");
            }

            if (p1 != 0) {                           //p1=0 ��ʾ�Ǵ���һ���µ������б�û�����κ����Ա������ p1=1��ʾ�༭һ���Ѿ����ڵ������б�
                if (p2 == 0)                         //p2=0��ʾ�ı���������б�������ı� p2=1��ʾ����༭ҳ��
                    objXml.open("POST", "../sites/_commons/getFormFields.jsp?markid="+markform.lwforms.value, false);
                else
                    objXml.open("POST", "../sites/_commons/getFormFields.jsp?markid=<%=lwforms%>", false);
                objXml.send(null);
                var retstr = objXml.responseText;
                if (retstr != null && retstr.length > 0) {
                    var arrdata = retstr.split("~~!");
                    document.getElementById("fieldname").options.length=0;
                    document.getElementById("fieldname").options.add(new Option("��ѡ��",""));
                    document.getElementById("fieldname").options.add(new Option("����ID","id"));
                    document.getElementById("fieldname").options.add(new Option("�����û�����","username"));
                    document.getElementById("fieldname").options.add(new Option("��ʾ����","id"));
                    for (var i = 0; i < arrdata.length; i++)
                    {
                        //���� ���� ��˾  �����ʼ�  ����  ��ϵ��ַ  ��������  ��ϵ�绰 �ظ�

                        if (arrdata[i].indexOf("�ż�����")>-1)
                            document.getElementById("fieldname").options.add(new Option("�ż�����","title"));

                        if (arrdata[i] == "�ż�����")
                            document.getElementById("fieldname").options.add(new Option("�ż�����","content"));

                        if (arrdata[i] == "���Ź�˾")
                            document.getElementById("fieldname").options.add(new Option("���Ź�˾","company"));

                        if (arrdata[i] == "�����ʼ�")
                            document.getElementById("fieldname").options.add(new Option("�����ʼ�","email"));

                        if (arrdata[i] == "��    ��")
                            document.getElementById("fieldname").options.add(new Option("��    ��","contactor"));

                        if (arrdata[i] == "��ϵ��ַ")
                            document.getElementById("fieldname").options.add(new Option("��ϵ��ַ","contactway"));

                        if (arrdata[i] == "��������")
                            document.getElementById("fieldname").options.add(new Option("��������","postcode"));

                        if (arrdata[i] == "��ϵ�绰")
                            document.getElementById("fieldname").options.add(new Option("��ϵ�绰","telephone"));
                    }
                    document.getElementById("fieldname").options.add(new Option("����ʱ��","writedate"));
                    document.getElementById("fieldname").options.add(new Option("�ظ�����","return"));
                    document.getElementById("fieldname").options.add(new Option("�ظ�ʱ��","rettime"));
                    document.getElementById("fieldname").options.add(new Option("ѭ����ʼ","begin"));
                    document.getElementById("fieldname").options.add(new Option("ѭ������","end"));
                }
            }
        }


        function cal() {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = "";
                top.close();
            } else {
                top.close();
            }
        }

        function doit()
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            var relatedformid = markform.lwforms.value;
            if (relatedformid == 0) {
                alert("����ѡ���������б�����������Ա������û�����Ա������ȶ������Ա�");
                return false;
            }
            if (isMSIE) {
                markform.action = "addUserLeavemessageListForm.jsp";
                markform.method = "post";
                markform.target = "_self"
                markform.submit();
            }
        }
    </script>
</head>

<body bgcolor="#CCCCCC" onload="getFormFileds(<%=lwforms_n%>,1)">
<table width="100%" border="0" align="center">
    <form name="markform">
        <input type=hidden name=doCreate value=true>
        <input type=hidden name=saveas value=false>
        <input type=hidden name=column value="<%=columnID%>">
        <input type=hidden name=type value=23>
        <input type="hidden" name="mark" value="<%=markID%>">

        <input type="hidden" name="contents" id="contents">
        <tr>
            <td style="height: 31px" colspan="4"><strong>���������б���ʽ��</strong></td>
        </tr>
        <tr>
            <td align="left" style="width: 120px; height: 24px;">ÿҳ��ʾ���Ե�������</td>
            <td align="left" style="height: 24px; width: 16px;"><input name=ranges size=6 value="<%=range%>" class=tine></td>
            <td align="left" style="width: 120px; height: 24px;">��ҳ������ʽ��</td>
            <td align="left" style="height: 24px;">
                <SELECT NAME="fenyelist" id="fenyelistid" style="width: 163px">
                    <option value="0">ѡ���ҳ����ʽ</option>
                    <%
                        for (int i = 0; i < navList.size(); i++) {
                            viewfile = (ViewFile) navList.get(i);
                    %>
                    <option value="<%=viewfile.getID()%>"
                            <%if(fenyestyle==viewfile.getID()){%>selected<%}%>><%=StringUtil.gb2iso4View(viewfile.getChineseName())%>
                    </option>
                    <%}%>
                </SELECT>&nbsp;&nbsp;
                <input name="Button1" type="button" onclick="createStyle(2,0)" value="����">
                <input name="Button2" type="button" onclick="updateStyle(2,fenyelist.options[fenyelist.selectedIndex].value,0)" value="�޸�">
                <input name="Button3" type="button" onclick="previewStyle(2,fenyelist.options[fenyelist.selectedIndex].value)" value="Ԥ��"></td>
        </tr>
        <tr>
            <td align="left" valign="middle" style="height: 24px">ѡ��������Ա�:</td>
            <td align="left" valign="middle" style="height: 24px; width: 16px;">
                <select name="lwforms" style="width: 169px" onchange="javascript:getFormFileds(1,0)">
                    <option value="0">��ѡ�����Ա�</option>
                    <%
                        mark mk = null;
                        for (int i=0; i<marks.size(); i++) {
                            mk = (mark)marks.get(i);
                            if (lwforms_n == mk.getID())
                                out.println("<option value=\"" + mk.getID() +"\" selected>" + mk.getChineseName() + "</option>");
                            else
                                out.println("<option value=\"" + mk.getID() +"\">" + mk.getChineseName() + "</option>");
                        }
                    %>
                </select></td>
            <td align="left" valign="middle" style="height: 24px">ѡ�������ֶ����ƣ�</td>
            <td align="left" valign="middle" style="height: 24px"><select ID="fieldname" name="fields" style="width: 159px" onchange="SelectMarkName();">
                <option value ="">��ѡ���ֶ�</option>
                <!-- ���� ���� ��˾  �����ʼ�  ��ϵ��  ��ϵ��ʽ  ��������  �绰 �ظ�-->
                <option value ="id">����ID</option>
                <option value ="username">�����û�����</option>
                <option value ="title">�ż�����</option>
                <option value ="content">�ż�����</option>
                <option value ="company">���Ź�˾</option>
                <option value ="email">�����ʼ�</option>
                <option value ="contactor">��    ��</option>
                <option value ="contactway">��ϵ��ַ</option>
                <option value ="postcode">��������</option>
                <option value ="telephone">��ϵ�绰</option>
                <option value ="return">�ظ�����</option>
                <option value ="rettime">�ظ�ʱ��</option>
            </select></td>
        </tr>

        <tr height=24>
            <td colspan="4" align="left">
                <input name="audit" value="0" type="radio" checked>���б�����ʾ������Ϣ&nbsp;&nbsp;&nbsp;
                <input name="audit" value="1" type="radio">���б���ֻ��ʾ���ͨ������Ϣ</td>
        </tr>

        <tr height=24>
            <td colspan="4" align="left">
                <textarea name="content" style="width: 700px; height: 217px" WRAP="soft" ONSELECT="storeCaret(this);" ONCLICK="storeCaret(this);" ONKEYUP="storeCaret(this);"><%=(listStyle!=null)?listStyle:""%></textarea></td>
        </tr>

        <tr height=24>
            <td colspan="4" align="left">����������ƣ�<input name=chineseName size=20 value="<%=cname%>" class=tine></td>
        </tr>

        <tr height=80>
            <td colspan="4" align="left">���������<br><textarea name="notes" rows="3" id="notes" cols="38" class=tine><%=(notes!=null)?notes:""%></textarea>
            </td>
        </tr>
        <tr height="50">
            <td align=center colspan="4" align="left">
                <input type="button" value=" ȷ�� " onClick = "doit();" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value=" ȡ�� " onClick = "javascript:cal();" class=tine>
            </td>
        </tr>
    </form>
</table>

</body>
</html>