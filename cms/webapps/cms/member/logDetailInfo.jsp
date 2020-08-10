<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.log.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.Timestamp" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int siteID = ParamUtil.getIntParameter(request, "site", 0);
    int flag = ParamUtil.getIntParameter(request, "flag", 0);
    int fid = ParamUtil.getIntParameter(request, "fid", 0);
    int groupId = ParamUtil.getIntParameter(request, "gid", 0);
    int searchflag = ParamUtil.getIntParameter(request, "searchflag", -1);
    String editor = ParamUtil.getParameter(request, "user");
    String date = ParamUtil.getParameter(request, "date");
    String bdate = ParamUtil.getParameter(request, "bdate");
    String edate = ParamUtil.getParameter(request, "edate");
    int columnid = ParamUtil.getIntParameter(request, "columnid", 0);

    String referurl = "logdetail.jsp?site=" + siteID + "&user=" + editor + "&flag=" + flag + "&fid=" + fid + "&gid=" +
            groupId + "&searchflag=" + searchflag + "&bdate=" + bdate + "&edate=" + edate + "&columnid=" + columnid;

    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;
    String doName = "";

    if (flag == 1)
        doName = "����";
    else if (flag == 2)
        doName = "�޸�";
    else if (flag == 3)
        doName = "ɾ��";

    List list = new ArrayList();
    if (siteID > 0 && editor != null) {
        ILogManager logMgr = LogPeer.getInstance();
        try {
            list = logMgr.getEditorDetailLogInfoGroupbyActTime(siteID, editor, flag, startrow, range, date);
            rows = logMgr.getEditorDetailLogInfoNumGroupbyActTime(siteID, editor, flag, date);
        } catch (LogException e) {
            e.printStackTrace();
        }
    }

    if (rows < range) {
        totalpages = 1;
        currentpage = 1;
    } else {
        if (rows % range == 0)
            totalpages = rows / range;
        else
            totalpages = rows / range + 1;

        currentpage = startrow / range + 1;
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script type="text/javascript">
        function golistnew() {
            var srow = (document.all('jump').value - 1) * <%=range%>;
            logForm.action = "logDetailInfo.jsp?searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>site=<%=siteID%>&flag=<%=flag%>&fid=<%=fid%>&gid=<%=groupId%>&user=<%=editor%>&columnid=<%=columnid%>&startrow=" + srow;
            logForm.submit();
        }
    </script>
</head>

<body>
<%
    String[][] titlebars = {
            {"ϵͳ����", "../main.jsp"},
            {"LOG��¼", ""}
    };
    String[][] operations = {
            {"���б�", "groupLogInfo.jsp?siteID=" + siteID},
            {"�����û��б�", "logInfo.jsp?siteID=" + siteID}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>

<table border=0 width="100%">
    <tr>
        <td><font class=line><%=doName%>������ϸ�б�</font></td>
    </tr>
</table>

<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
    <form action="logdetail.jsp" method="post" name="logForm">
        <input type="hidden" name="site" value="<%=siteID%>">
        <input type="hidden" name="flag" value="<%=flag%>">
        <input type="hidden" name="user" value="<%=editor%>">
        <input type="hidden" name="date" value="<%=date%>">
        <tr bgcolor="#eeeeee" class=tine>
            <td width="15%" align=center>�ʺ�</td>
            <td width="15%" align=center>����ʱ��</td>
            <td width="10%" align=center>����</td>
            <td width="60%" align=center>���±���</td>
        </tr>
        <%
            Log log = new Log();
            String maintitle = "";
            String acttime = "";
            for (int i = 0; i < list.size(); i++) {
                log = (Log) list.get(i);
                acttime = log.getActTime().toString().substring(0, 19);
                maintitle = log.getMaintitle();
                maintitle = maintitle == null ? "&nbsp;" : StringUtil.gb2iso4View(maintitle);
                String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
        %>
        <tr bgcolor="<%=bgcolor%>" height=21>
            <td>&nbsp;&nbsp;<font color=red><b><%=editor%>
            </b></font></td>
            <td align=center><%=acttime%>
            </td>
            <td align=center><%=doName%>����</td>
            <td align=left>&nbsp;<b><%=maintitle%>
            </b></td>
        </tr>
        <%}%>
        <tr>
            <td colspan=4 height=40 align=center>����<%=rows%>����¼&nbsp;&nbsp;��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
                &nbsp;&nbsp;&nbsp;&nbsp;
                <%
                    if ((startrow - range) >= 0) {
                %>
                [<a href="logDetailInfo.jsp?searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&startrow=<%=startrow-range%>&site=<%=siteID%>&flag=<%=flag%>&user=<%=editor%>&date=<%=date%>&fid=<%=fid%>&gid=<%=groupId%>&columnid=<%=columnid%>">��һҳ</a>]
                <%}%>
                <%
                    if ((startrow + range) < rows) {
                %>
                [<a href="logDetailInfo.jsp?searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&startrow=<%=startrow+range%>&site=<%=siteID%>&flag=<%=flag%>&user=<%=editor%>&date=<%=date%>&fid=<%=fid%>&gid=<%=groupId%>&columnid=<%=columnid%>">��һҳ</a>]
                <%
                    }
                    if (totalpages > 1) {
                %>
                &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
                <a href="javascript:golistnew();">GO</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%}%><a href="<%=referurl%>">����</a></td>
        </tr>
    </form>
</table>
</body>
</html>