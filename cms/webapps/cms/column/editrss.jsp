<%@ page import="com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=GBK"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String errormsg = "";
    boolean error = false;
    int columnID = ParamUtil.getIntParameter(request, "ID", 0);
    int from = ParamUtil.getIntParameter(request, "from", 0);   //from=1������ҳ
    String act = ParamUtil.getParameter(request, "act");
    IColumnManager columnMgr = ColumnPeer.getInstance();
    Column column = new Column();
    int timelength = 0;

    //���沢�رմ���
    if (act != null && act.equals("doSave")) {
        int getRssArticleTime = ParamUtil.getIntParameter(request, "timelength", -2);

        column.setGetRssArticleTime(getRssArticleTime);
        column.setID(columnID);
        try {
            columnMgr.updateColumnRss(column);
        } catch (ColumnException e) {
            e.printStackTrace();
        }
        out.println("<script language=javascript>top.close();</script>");
        return;
    }else{
        column = columnMgr.getColumn(columnID);
        timelength = column.getGetRssArticleTime();
    }
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <title>RSS����</title>
    <script language=javascript>
        function CloseW()
        {
            this.window.close();
            this.window.opener.location.reload();
        }

        function control()
        {
            if (document.all("type").value == "3")
                picattr.style.display = "";
            else
                picattr.style.display = "none";
        }
    </script>
</head>

<body>
<table border="0" width="400" align="center">
    <form method="POST" action="editrss.jsp?from=<%=from%>&ID=<%=columnID%>">
        <input type=hidden name=act value=doSave>
        <tr>
            <td>��ѡ������RSS�����µ�ʱ���</td>
        </tr>
        <tr height=80>
            <td width="100%">
                <table border=0 cellspacing=2 cellpadding=2 width="100%">
                    <tr>
                        <td width="60%">
                            <input type="radio" name="timelength" value="0" <%if(timelength==0) out.println("checked");%>>&nbsp;���������
                        </td>
                    </tr>
                    <tr>
                        <td width="60%">
                            <input type="radio" name="timelength" value="1" <%if(timelength==1) out.println("checked");%>>&nbsp;���һ���ڵ�����
                        </td>
                    </tr>
                    <tr>
                        <td width="60%">
                            <input type="radio" name="timelength" value="2" <%if(timelength==2) out.println("checked");%>>&nbsp;��������ڵ�����
                        </td>
                    </tr>
                    <tr>
                        <td width="60%">
                            <input type="radio" name="timelength" value="3" <%if(timelength==3) out.println("checked");%>>&nbsp;��������ڵ�����
                        </td>
                    </tr>
                    <tr>
                        <td width="60%">
                            <input type="radio" name="timelength" value="-1" <%if(timelength==-1) out.println("checked");%>>&nbsp;����ʱ������
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height=40>
            <td align=center>
                <input type="submit" value="   ȷ��   " name="save" class=tine>&nbsp;&nbsp;
                <input type="button" value="   �ر�   " name="close" class=tine onclick="CloseW();">
            </td>
        </tr>
    </form>
</table>

</body>
</html>