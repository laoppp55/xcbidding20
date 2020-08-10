<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.xml.*"
         contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteID = authToken.getSiteID();
    int type = ParamUtil.getIntParameter(request, "type", 0);
    String str = ParamUtil.getParameter(request, "str");
    IViewFileManager viewfileMgr = viewFilePeer.getInstance();
    ViewFile viewfile = new ViewFile();

    int styleID = 0;
    if (str != null && str.trim().length() > 0) {
        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
        styleID = Integer.parseInt(properties.getProperty(properties.getName()));
    }

    List list = viewfileMgr.getViewFileC(siteID, 8);
%>

<html>
<head>
    <title>��Ӣ��·��</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <meta http-equiv="Pragma" content="no-cache">
    <base target='_self'>    
    <script language="javascript" src="../js/mark.js"></script>
    <SCRIPT LANGUAGE=JavaScript>
        var retstr = "";
        function submit()
        {
            if (listType.selectedIndex == 0)
            {
                alert("��ѡȡ��ʽ�ļ���");
                return;
            }
            retstr = "yes";

            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = listType.options[listType.selectedIndex].value;
                window.close();
            } else {
                var returnvalue = document.getElementById("listType").options[listType.selectedIndex].value;
                var markname = "";
                <%if(type == 0){%>
                markname = "����·��";
                returnvalue = "[TAG][CHINESE_PATH]" + returnvalue + "[/CHINESE_PATH][/TAG]";
                <%}else if(type == 1){%>
                markname = "Ӣ��·��";
                returnvalue = "[TAG][ENGLISH_PATH]" + returnvalue + "[/ENGLISH_PATH][/TAG]";
                <%}
                if(styleID == 0){%>
                returnvalue = "<INPUT name='"+returnvalue+"' type=button value='["+markname+"]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>";
                window.opener.InsertHTML('content', returnvalue);
                top.close();
                <%}else{%>
                window.opener.parent.UpdateHTML('content', returnvalue);
                top.close();
                <%}%>
            }
        }

        function cancel()
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = "";
                window.close();
            }else{
                top.close();
            }
        }
    </SCRIPT>
</head>

<body bgcolor="#CCCCCC">
<table width="96%" border="0" align=center>
    <tr height="30">
        <td>��ѡ����Ӣ��·����ʽ��</td>
    </tr>
    <tr height="30">
        <td>
            �б����ͣ�
            <select name="listType" style="width:160" class=tine id="listType">
                <option value=0>ѡ����ʽ�ļ�</option>
                <%
                    for (int i = 0; i < list.size(); i++) {
                        viewfile = (ViewFile) list.get(i);
                %>
                <option value="<%=viewfile.getID()%>" <%if (styleID == viewfile.getID()) {%> selected<%}%>><%=
                    StringUtil.gb2iso4View(viewfile.getChineseName())%>
                </option>
                <%}%>
            </select>
            <input type="button" value="�½�" style="height:20;width:30;font-size:9pt" onclick="createStyle(8,0);">
            <input type="button" style="height:20;width:30;font-size:9pt"
                    onclick="updateStyle(8,listType.options[listType.selectedIndex].value,0);" value="�޸�">
            <input type="button" style="height:20;width:30;font-size:9pt"
                    onclick="previewStyle(8,listType.options[listType.selectedIndex].value);" value="Ԥ��">
        </td>
    </tr>
    <tr height="50">
        <td align=center>
            <input type="button" value=" ȷ�� " onclick="submit();" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" value=" ȡ�� " onclick="cancel();" class=tine>
        </td>
    </tr>
</table>

</body>
</html>