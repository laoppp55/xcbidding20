<%@ page import="java.sql.*,com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%@ page import="java.net.URLDecoder" %>
<%
    String itemText = ParamUtil.getParameter(request,"item");
    //if (itemText!=null) itemText = URLDecoder.decode(itemText,"gbk");

    String cname = itemText;
    int p = 0;
    if ((p=itemText.indexOf("-getAllSubArticle")) > -1) {
        cname = itemText.substring(0, p);
    }

    System.out.println("cname===" + cname);
%>

<html>
<head>
    <title>���������б�����</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type="text/css" href="../style/global.css">
    <SCRIPT LANGUAGE=JavaScript FOR=Ok EVENT=onclick>
        var attrVal = "<%=itemText%>";
        var val = 0;

        //�Ƿ���ʾ����Ŀ�б�  0--��ʾ  1--����ʾ
        for (i=0; i<2; i++)
        {
            if (subCList[i].checked)  val = subCList[i].value;
        }
        if (val == 0 && attrVal.indexOf("-getAllSubArticle") == -1)
            attrVal = attrVal + "-getAllSubArticle";
        else if (val == 1 && attrVal.indexOf("-getAllSubArticle") > -1)
            attrVal = "<%=cname%>";

        window.returnValue = attrVal;
        window.close();
    </SCRIPT>

    <SCRIPT LANGUAGE=JavaScript FOR=Cancel EVENT=onclick>
        var attrVal = "<%=itemText%>";
        window.returnValue = attrVal;
        window.close();
    </SCRIPT>
</head>

<BODY bgcolor="#cccccc">
<table width="100%" border="0" align="center">
    <tr height="20">
        <td>��Ŀ���ƣ�<%=cname%></td>
    </tr>
    <tr height="25">
        <td>�Ƿ��ȡ��������Ŀ�����£�
            <input type="radio" name="subCList" value="0">��&nbsp;&nbsp;
            <input type="radio" name="subCList" value="1">��
        </td>
    </tr>
    <tr height="30">
        <td align="center">
            <input type="button" name="Ok" value=" ȷ�� " class=tine>&nbsp;&nbsp;
            <input type="button" name="Cancel" value=" ȡ�� " class=tine>
        </td>
    </tr>
</table>

</BODY>
</html>

<SCRIPT LANGUAGE=JavaScript>
    var attrVal = "<%=itemText%>";
    if (attrVal.indexOf("-getAllSubArticle") > -1)
        subCList[0].checked = true;
    else
        subCList[1].checked = true;
</SCRIPT>