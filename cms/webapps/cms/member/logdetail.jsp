<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.log.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int siteID = ParamUtil.getIntParameter(request, "site", 0);
    int flag = ParamUtil.getIntParameter(request, "flag", 0);           //0-������1-�޸ģ�2-ɾ��
    int fid = ParamUtil.getIntParameter(request, "fid", 0);             //��ת��Դ 1-groupUsersLog.jsp
    int groupId = ParamUtil.getIntParameter(request, "gid", 0);
    String editor = ParamUtil.getParameter(request, "user");
    int searchflag = ParamUtil.getIntParameter(request, "searchflag", -1);
    int columnid = ParamUtil.getIntParameter(request, "columnid", 0);

    String where = " and 1=1";
    String bdate = "";
    String edate = "";
    if (searchflag == 1) {
        bdate = ParamUtil.getParameter(request, "bdate");
        if ((bdate != null) && (bdate.length() > 1) && (bdate.indexOf("-") > -1))
            where = where + " and createdate >='" + bdate + "'";
        edate = ParamUtil.getParameter(request, "edate");
        if ((edate != null) && (edate.length() > 1) && (edate.indexOf("-") > -1))
            where = where + " and createdate <='" + edate + "'";
        if(columnid != 0)
            where = where + " and columnid = " + columnid;
    }

    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;
    String doName = "";
    String referurl = "";
    if (fid == 1)
        referurl = "groupUsersLog.jsp?gid=" + groupId + "&sid=" + siteID + "&searchflag=" + searchflag + "&bdate=" + bdate + "&edate=" + edate + "&columnid=" + columnid;
    else
        referurl = "logInfo.jsp?siteID=" + siteID + "&searchflag=" + searchflag + "&bdate=" + bdate + "&edate=" + edate + "&columnid=" + columnid;

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
            list = logMgr.getEditorLogInfoGroupbyActTime(siteID, editor, flag, startrow, range, where);
            rows = logMgr.getEditorLogInfoNumGroupbyActTime(siteID, editor, flag, where);
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
            logForm.action = "logdetail.jsp?site=<%=siteID%>&flag=<%=flag%>&fid=<%=fid%>&gid=<%=groupId%>&user=<%=editor%>&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>&startrow=" + srow;
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
        <tr bgcolor="#eeeeee" class=tine>
            <td width="30%" align=center>�ʺ�</td>
            <td width="20%" align=center>վ��ID</td>
            <td width="20%" align=center><%=doName%>��������</td>
            <td width="30%" align=center>����</td>
        </tr>
        <%
            for (int i = 0; i < list.size(); i++) {
                String info = (String) list.get(i);
                String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
        %>
        <tr bgcolor="<%=bgcolor%>" height=21>
            <td>&nbsp;&nbsp;<font color=red><b><%=editor%>
            </b></font></td>
            <td align=center><%=siteID%>
            </td>
            <td align=center><b><%=info.substring(11)%>
            </b></td>
            <td align=center><b>
                <a href="logDetailInfo.jsp?site=<%=siteID%>&flag=<%=flag%>&user=<%=editor%>&date=<%=info.substring(0, 10)%>&fid=<%=fid%>&gid=<%=groupId%>&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>"><%=info.substring(0, 10)%></a>
            </b></td>
        </tr>
        <%}%>
        <tr>
            <td colspan=4 height=40 align=center>����<%=rows%>����¼&nbsp;&nbsp;��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
                &nbsp;&nbsp;&nbsp;&nbsp;
                <%
                    if ((startrow - range) >= 0) {
                %>
                [<a href="logdetail.jsp?startrow=<%=startrow-range%>&site=<%=siteID%>&flag=<%=flag%>&user=<%=editor%>&fid=<%=fid%>&gid=<%=groupId%>&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>">��һҳ</a>]
                <%}%>
                <%
                    if ((startrow + range) < rows) {
                %>
                [<a href="logdetail.jsp?startrow=<%=startrow+range%>&site=<%=siteID%>&flag=<%=flag%>&user=<%=editor%>&fid=<%=fid%>&gid=<%=groupId%>&searchflag=<%=searchflag%>&bdate=<%=bdate%>&edate=<%=edate%>&columnid=<%=columnid%>">��һҳ</a>]
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