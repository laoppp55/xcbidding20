<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.log.LogPeer" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.log.ILogManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.log.LogException" %>
<%@ page import="com.bizwink.cms.server.FileProps" %>
<%@ page contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int siteID = ParamUtil.getIntParameter(request, "siteID", 0);
    int searchflag = ParamUtil.getIntParameter(request, "searchflag", -1);
    int columnid = ParamUtil.getIntParameter(request, "columnid", 0);

    String where ="";
    String bdate = "";
    String edate = "";
    FileProps fp = new FileProps("com/bizwink/cms/server/config.properties");
        String dbstr = fp.getProperty("main.db.type");
    if (searchflag == 1) {
        where = " and 1=1";
        bdate = ParamUtil.getParameter(request, "bdate");
        if ((bdate != null) && (bdate.length() > 1) && (bdate.indexOf("-") > -1)){
            bdate += " 00:00:00";
            if (dbstr.equals("oracle")) {
                  where = where + " and createdate >= TO_DATE('"+bdate+"', 'YYYY-MM-DD HH24:MI:SS')";
            }else{
                where = where + " and createdate >='" + bdate + "'";
            }
        }
        edate = ParamUtil.getParameter(request, "edate");
        if ((edate != null) && (edate.length() > 1) && (edate.indexOf("-") > -1)){
            edate += " 23:59:59";
            if (dbstr.equals("oracle")) {
                  where = where + " and createdate <= TO_DATE('"+edate+"', 'YYYY-MM-DD HH24:MI:SS')";
            }else{
                where = where + " and createdate <='" + edate + "'";
            }
        }

        if(columnid != 0)
            where = where + " and columnid = " + columnid;
    }

    List editList = new ArrayList();
    if (siteID > 0) {
        ILogManager logMgr = LogPeer.getInstance();
        try {
            editList = logMgr.getEditorLogInfo(siteID, where);
        } catch (LogException e) {
            e.printStackTrace();
        }
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript" src="../js/setday.js"></script>
    <script type="text/javascript">
        function selectTColumn() {
            win = window.open("selectColumnTree.jsp?siteid=<%=siteID%>", "", "width=500,height=400");
            win.focus();
        }
    </script>
</head>

<body>
<%
    String[][] titlebars = {
            {"LOG记录", ""}
    };
    String[][] operations = {
            {"组列表", "groupLogInfo.jsp?siteID=" + siteID},
            {"所有用户列表", "logInfo.jsp?siteID=" + siteID}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>

<table border=0 width="100%">
    <tr>
        <td><font class=line>编辑列表</font></td>
    </tr>
</table>

<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
    <tr bgcolor="#eeeeee" class=tine>
        <td width="20%" align=center>帐号</td>
        <td width="20%" align=center>名称</td>
        <td width="20%" align=center>创建文章</td>
        <td width="20%" align=center>修改文章</td>
        <td width="20%" align=center>删除文章</td>
    </tr>
    <%
        for (int i = 0; i < editList.size(); i++) {
            String info = (String) editList.get(i);
            String log[] = info.split(":");
            String nickname = log[1];
            if (nickname != null) nickname = StringUtil.gb2iso4View(nickname);

            String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
    %>
    <tr bgcolor="<%=bgcolor%>" height=22>
        <td>&nbsp;&nbsp;<font color=red><b><%=log[0]%>
        </b></font></td>
        <td>&nbsp;&nbsp;<%=nickname%>
        </td>
        <td align=center><b><a
                href="logdetail.jsp?site=<%=siteID%>&user=<%=log[0]%>&flag=1&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>"><%=log[2]%>
        </a></b></td>
        <td align=center><b><a
                href="logdetail.jsp?site=<%=siteID%>&user=<%=log[0]%>&flag=2&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>"><%=log[3]%>
        </a></b></td>
        <td align=center><b><a
                href="logdetail.jsp?site=<%=siteID%>&user=<%=log[0]%>&flag=3&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>"><%=log[4]%>
        </a></b></td>
    </tr>
    <%}%>
</table>
<br><br>
<table border="0" cellpadding="0" cellspacing="0" width="99%" align="center">
    <form action="logInfo.jsp" method="post" name="logform">
        <input type="hidden" name="siteID" value="<%=siteID%>">
        <input type="hidden" name="searchflag" value="1">
        <tr bgcolor="#eeeeee" height="30">
            <td>&nbsp;&nbsp;搜索：</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;&nbsp;选择栏目：<input id="columnname" name="columnname" size="22" readonly
                                        ondblclick="selectTColumn();">(请双击输入框选择栏目)
                <input type=hidden id="columnid" name="columnid" size="5" readonly>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;&nbsp;开始日期：<input type="text" name="bdate" readonly onfocus="setday(this)" size=10>
                ——
                结束日期：<input type="text" name="edate" readonly onfocus="setday(this)" size=10>
                <input type="submit" value="搜索">
            </td>
        </tr>
    </form>
</table>
</body>
</html>