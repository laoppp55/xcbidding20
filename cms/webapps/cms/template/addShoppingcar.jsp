<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.xml.*,
                com.bizwink.cms.viewFileManager.*"
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
    //System.out.println("markID="+markID);
    IMarkManager markMgr = markPeer.getInstance();
    mark vmark=null;




    int siteID = authToken.getSiteID();
    String sitename = authToken.getSitename();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);

    int listType = 0;
    int innerFlag = 0;
    String notes = "";
    String cname = "���ﳵ";

    int type = ParamUtil.getIntParameter(request, "type", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");


    if (doCreate) {
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        String content  = ParamUtil.getParameter(request, "content");
        String xmlstr = "[TAG][SHOPPINGCAR_RESULT][SITEID]"+siteID+"[/SITEID]" +
                        "[CHINESENAME]"+cname+"[/CHINESENAME][NOTES]"+notes+"[/NOTES]" +
                        "[LISTSTYLE]<!{^CDATA{^" + content + ">^}^}>[/LISTSTYLE][/SHOPPINGCAR_RESULT]"+ "[/TAG]";
        boolean saveas = ParamUtil.getBooleanParameter(request, "saveas");
        String relatedCID = "(0)";

        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(xmlstr);
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(innerFlag);
        mark.setFormatFileNum(listType);
        mark.setRelatedColumnID(relatedCID);
        mark.setMarkType(1);
        int orgmarkID = markID;
        if (orgmarkID > 0 && !saveas)
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        String markname = "���ﳵ";

        if (viewer.toLowerCase().indexOf("gecko") == -1)
            out.println("<script>window.returnValue=\"[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]\";top.close();</script>");
        else {
            if (orgmarkID > 0 && !saveas) {
                out.println("<script>top.close();</script>");
            } else {
                String returnvalue = "[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]";
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + markname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
        }
        return;
    }
     String listStyle = null;
    if (markID > 0) {
        String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(markID));
        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        str = StringUtil.replace(str, "{^", "[");
        str = StringUtil.replace(str, "^}", "]");

        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);


        cname = properties.getProperty(properties.getName().concat(".CHINESENAME"));
        listStyle = properties.getProperty(properties.getName().concat(".LISTSTYLE"));
        if (listStyle != null) listStyle = listStyle.substring(0,listStyle.length() -1);

        if(cname == null) cname = "���ﳵ";
        notes = properties.getProperty(properties.getName().concat(".NOTES"));
        if (notes == null || notes.equalsIgnoreCase("null")) notes = "";
    }
%>

<html>
<head>
    <base target="_self" >
    <title>���ﳵ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="javascript" src="../js/color.js"></script>
    <meta http-equiv="Pragma" content="no-cache">
    <script type="text/javascript">
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
            if (isMSIE) {
                markform.action = "addShoppingcar.jsp";
                markform.method = "post";
                markform.target = "_self"
                markform.submit();
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
            var str = "<" + "%%" + document.markform.fields.options[i].value + "%%" + ">";

            if (str != "" && str != "1" && document.markform.fields.options[i].value != "-1")
                insertAtCaret(document.markform.content, str);
            document.markform.fields.options[0].selected = true;
        }

        function storeCaret(textEl)
        {
            if (textEl.createTextRange)
                textEl.caretPos = document.selection.createRange().duplicate();
        }
    </script>
</head>

<body bgcolor="#CCCCCC">
<table width="100%" border="0" align="center">
    <form name="markform">
        <input type=hidden name=doCreate value=true>
        <input type=hidden name=saveas value=false>
        <input type=hidden name=column value="<%=columnID%>">
        <input type=hidden name=type value=12>
        <input type="hidden" name="mark" value="<%=markID%>">
        <tr height="30">
            <td width="20%">��ѡ����Ʒ��ǣ�</td>
            <td width="80%" align="left"><select id="fieldname" name="fields" onchange="SelectMarkName();">
                <option value ="-1">��ѡ����Ʒ���</option>
                <option value ="productno">��Ʒ���</option>
                <option value ="productname">��Ʒ����</option>
                <option value ="productnameurl">��Ʒ���ƣ�URL��</option>
                <option value ="saleprice">��Ʒ�ۼ�</option>
                <option value ="marketprice">��Ʒ�г���</option>
                <option value ="productnum">��Ʒ����</option>
                <option value ="totalproductnum">���ﳵ��Ʒ����</option>
                <option value ="score">������Ʒ����</option>
                <option value ="deleteproducturl">ɾ����Ʒ��URL��</option>
                <option value ="totalscore">���ﳵ��Ʒ�ܻ���</option>
                <option value ="historyscore">��ʷ�ܻ���</option>
                <option value ="nowscore">��ǰ�ܻ���</option>
                <option value ="producttotal">��Ʒ�۸�С��</option>
                <option value ="totalprice">��Ʒ�۸��ܼ�</option>
                <option value ="orderurl">���ﳵ���㣨URL��</option>
                <option value ="begin">ѭ����ʼ</option>
                <option value ="end">ѭ������</option>
            </select>
            </td>
        </tr>

        <tr height=24>
            <td colspan="2" align="left">
                <textarea name="content" style="width: 700px; height: 217px" WRAP="soft" ONSELECT="storeCaret(this);" ONCLICK="storeCaret(this);" ONKEYUP="storeCaret(this);"><%=(listStyle!=null)?listStyle:""%></textarea></td>
        </tr>
            <td colspan="2">����������ƣ�<input name=chineseName size=20 value="<%=cname%>" class=tine></td>
        </tr>
        <tr height=80>
            <td colspan="2">���������<br><textarea rows="3" id="notes" name="notes" cols="38" class=tine><%=notes%>
            </textarea></td>
        </tr>
        <tr height="50">
            <td align=center>
                <input type="button" value=" ȷ�� " onClick = "doit();" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value=" ȡ�� " onClick = "javascript:cal();" class=tine>
            </td>
        </tr>
    </form>
</table>

</body>
</html>