<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String str = ParamUtil.getParameter(request, "str");
    String datestyle = "";
    String timestyle = "";
    if (str != null) {
        str = str.substring(str.indexOf("[ARTICLE_PT]") + 12, str.indexOf("[/ARTICLE_PT]"));
        datestyle = str.substring(0, str.indexOf("|")).toUpperCase();
        timestyle = str.substring(str.indexOf("|") + 1).toUpperCase();
    }
%>

<html>
<head>
    <title>����/ʱ����ʽ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <meta http-equiv="Pragma" content="no-cache">
    <SCRIPT LANGUAGE=JavaScript>
        var retstr = "";
        function submit()
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            retstr = "yes";
            if (isMSIE) {
                window.returnValue = "[TAG][ARTICLE_PT]" + datestyle.value + "|" + timestyle.value + "[/ARTICLE_PT][/TAG]";
                window.close();
            } else {
                var markname = "����ʱ��";
                var returnvalue = document.getElementById("datestyle").value + "|" + document.getElementById("timestyle").value;
                returnvalue = "[TAG][ARTICLE_PT]" + returnvalue + "[/ARTICLE_PT][/TAG]";
            <%if (str != null) {%>
                window.opener.parent.UpdateHTML('content', returnvalue);
                top.close();
            <%}else{%>
                returnvalue = "<INPUT name='" + returnvalue + "' type=button value='[" + markname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>";
                window.opener.InsertHTML('content', returnvalue);
                top.close();
            <%}%>
            }
        }

        function cancel()
        {
            if (retstr == "")
                window.returnValue = "";
            window.close();
        }
    </SCRIPT>
</head>

<body bgcolor="#CCCCCC" onunload="cancel();">
<table width="96%" border="0" align="center">
    <tr height="30">
        <td>������ʽ��
            <select name=datestyle style="width:140" class=tine>
                <option value="yyyy-MM-dd" <%if(datestyle.equals("YYYY-MM-DD")){%>selected<%}%>>YYYY-MM-DD</option>
                <option value="yyyyy/MM/dd" <%if(datestyle.equals("YYYY/MM/DD")){%>selected<%}%>>YYYY/MM/DD</option>
                <option value="MM/dd/yyyy" <%if(datestyle.equals("MM/DD/YYYY")){%>selected<%}%>>MM/DD/YYYY</option>
                <option value="MM-dd-yyyy" <%if(datestyle.equals("MM-DD-YYYY")){%>selected<%}%>>MM-DD-YYYY</option>
                <option value="yyyy��MM��dd��" <%if(datestyle.equals("YYYY��MM��DD��")){%>selected<%}%>>YYYY��MM��DD��</option>
                <option value="MM��dd��" <%if(datestyle.equals("MM��DD��")){%>selected<%}%>>MM��DD��</option>
                <option value="dd��" <%if(datestyle.equals("DD��")){%>selected<%}%>>DD��</option>
            </select>
        </td>
        <td>ʱ����ʽ��
            <select name=timestyle style="width:120" class=tine>
                <option value="" <%if(timestyle.equals("")){%>selected<%}%>>��ʱ��</option>
                <option value="HH:mm:ss" <%if(timestyle.equals("HH:MM:SS")){%>selected<%}%>>HH:MM:SS</option>
                <option value="HH:mm" <%if(timestyle.equals("HH:MM")){%>selected<%}%>>HH:MM</option>
                <option value="HH" <%if(timestyle.equals("HH")){%>selected<%}%>>HH</option>
            </select>
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