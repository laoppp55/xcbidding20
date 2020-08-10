<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.news.Producttype" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.news.IColumnManager" %>
<%@ page import="com.bizwink.cms.news.ColumnPeer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    int columnId = ParamUtil.getIntParameter(request, "column", 0);
    int selectT = ParamUtil.getIntParameter(request, "selectT", 0);
    int addlink = ParamUtil.getIntParameter(request, "addlink", 0);
    String str = ParamUtil.getParameter(request, "str");

    String selectTStr = "";
    if ((str != null) && (!str.equals("")) && (!str.equals("null"))) {
        selectTStr = str.substring(str.indexOf("[ARTICLE_TYPE]") + 14, str.indexOf("[/ARTICLE_TYPE]"));
        columnId = Integer.parseInt(selectTStr.substring(selectTStr.indexOf("_") + 1, selectTStr.lastIndexOf("_")));
        addlink = Integer.parseInt(selectTStr.substring(selectTStr.lastIndexOf("_") + 1));
        selectTStr = selectTStr.substring(0, selectTStr.indexOf("_"));
        selectTStr = "," + selectTStr + ",";
    }

    List typeList = new ArrayList();
    String selectType = "";
    if (selectT != 0) {
        typeList = ParamUtil.getParameterValues(request, "showtypes");

        if ((typeList != null) && (typeList.size() > 0)) {
            for (int i = 0; i < typeList.size(); i++) {
                selectType = selectType + typeList.get(i) + ",";
            }

            if (selectType.endsWith(","))
                selectType = selectType.substring(0, selectType.lastIndexOf(","));

            String viewer = request.getHeader("user-agent");
            String markname = "���·�����";

            if (viewer.toLowerCase().indexOf("gecko") == -1)
                out.println("<script>window.returnValue=\"[TAG][ARTICLE_TYPE]" + selectType + "_" + columnId + "_" + addlink + "[/ARTICLE_TYPE][/TAG]\";top.close();</script>");
            else {
                String returnvalue = "[TAG][ARTICLE_TYPE]" + selectType + "_" + columnId + "_" + addlink + "[/ARTICLE_TYPE][/TAG]";
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + markname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
            return;
        } else {
            out.println("<script>top.close();</script>");
        }
    }
%>
<html>
<head>
    <title>���·����б�</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <meta http-equiv="Pragma" content="no-cache">
    <SCRIPT LANGUAGE=JavaScript>
        function submit()
        {
            if ((!typeForm.addlink[0].checked) && (!typeForm.addlink[1].checked)) {
                alert("��ѡ������Ƿ������");
                return false;
            }
            typeForm.submit();
        }

        function cancel()
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = "";
                window.close();
            } else {
                top.close();
            }
        }
    </SCRIPT>
</head>

<body bgcolor="#CCCCCC" onunload="cancel();">
<table width="90%" border="0" align="center">
    <form name="typeForm" method="post" action="addArticleTypeList.jsp">
        <input type="hidden" name="selectT" value="1">
        <input type="hidden" name="column" value="<%=columnId%>">
        <%
            IColumnManager columnMgr = ColumnPeer.getInstance();
            typeList = columnMgr.getArticlesTopTypes(columnId);
            for (int i = 0; i < typeList.size(); i++) {
                Producttype pt = (Producttype) typeList.get(i);
                String cname = StringUtil.gb2iso4View(pt.getCname());
                int typeid = pt.getId();
        %>
        <tr>
            <td align="left"><input type="checkbox" value="<%=typeid%>" name="showtypes"
                                    <%if(selectTStr.indexOf(","+typeid+",")!=-1){%>checked<%}%>>&nbsp;<%=cname%>
            </td>
        </tr>
        <%}%>
        <tr>
            <td align="center"><input type="radio" value="1" name="addlink" <%if(addlink==1){%>checked<%}%>>&nbsp;������&nbsp;&nbsp;&nbsp;<input
                    type="radio" value="0" name="addlink" <%if(addlink==0){%>checked<%}%>>&nbsp;��������
            </td>
        </tr>
        <tr height="50">
            <td align=center>
                <input type="button" value=" ȷ�� " onclick="return submit();" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value=" ȡ�� " onclick="cancel();" class=tine>
            </td>
        </tr>
    </form>
</table>

</body>
</html>