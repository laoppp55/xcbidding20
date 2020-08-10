<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.sitesetting.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect( "../login.jsp" );
        return;
    }
    if (!SecurityCheck.hasPermission(authToken,54))
    {
        request.setAttribute("message","无系统管理的权限");
        response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
        return;
    }

    int siteID = ParamUtil.getIntParameter(request, "siteID", 0);
    IFtpSetManager ftpMgr = FtpSetting.getInstance();
    List ftpList = ftpMgr.getFtpInfoList(siteID);
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
        function create()
        {
            window.open("addsiteipinfo.jsp?siteid=<%=siteID%>","","top=50,left=150,width=600,height=400");
        }

        function edit(ID)
        {
            window.open("editipinfo.jsp?ID="+ID,"Edit_Site","top=50,left=150,width=600,height=400");
        }
    </script>
</head>

<body>
<%
    String[][] titlebars = {
            {"主机管理", "" }
    };
    String [][] operations = {
            {"<a href=javascript:create();>增加主机</a>",""},
            {"站点管理","siteManage.jsp"}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="95%" align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td width="15%" align=center>主机类型</td>
        <td width="20%" align=center class="listHeader"><b>主机名称</b></td>
        <td width="20%" align=center>发布地址</td>
        <td width="25%" align=center>发布目录</td>
        <td width="10%" align=center>发布方式</td>
        <td width="5%" align=center>修改</td>
        <td width="5%" align=center>删除</td>
    </tr>
    <%
        FtpInfo ftpInfo = null;
        for (int i=0; i<ftpList.size(); i++)
        {
            ftpInfo = (FtpInfo)ftpList.get(i);
            String siteIP = ftpInfo.getIp();
            String docpath = ftpInfo.getDocpath();
            int status = ftpInfo.getStatus();
            int pubway = ftpInfo.getPublishway();
            int ftptype = ftpInfo.getFtptype();
    %>
    <tr bgcolor="#ffffff" class=line>
        <td align=center>
            <font color=red><b>
            <%if(status==1){%>WEB发布<%}else if(status == 0){%>图片/多媒体<%} else if (status == 2) {%>WAP发布<%}%></b>
            </font>
        </td>
        <td align=center><b><%=ftpInfo.getSiteName()%></b></td>
        <td align=center><%=siteIP%></td>
        <td><%=docpath%></td>
        <td align=center>
            <%if(pubway==0){
               if (ftptype == 0)
                   out.print("FTP发布");
               else
                   out.print("SFTP发布");
            } else {
                out.print("本地发布");
            }%>
        </td>
        <td align="center"><input type="radio" name="action" onclick="edit(<%=ftpInfo.getID()%>);"></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='removeipinfo.jsp?ID=<%=ftpInfo.getID()%>';"></td>
    </tr>
    <%}%>
</table>

</body>
</html>