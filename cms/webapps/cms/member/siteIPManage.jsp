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
        request.setAttribute("message","��ϵͳ�����Ȩ��");
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
            {"��������", "" }
    };
    String [][] operations = {
            {"<a href=javascript:create();>��������</a>",""},
            {"վ�����","siteManage.jsp"}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="95%" align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td width="15%" align=center>��������</td>
        <td width="20%" align=center class="listHeader"><b>��������</b></td>
        <td width="20%" align=center>������ַ</td>
        <td width="25%" align=center>����Ŀ¼</td>
        <td width="10%" align=center>������ʽ</td>
        <td width="5%" align=center>�޸�</td>
        <td width="5%" align=center>ɾ��</td>
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
            <%if(status==1){%>WEB����<%}else if(status == 0){%>ͼƬ/��ý��<%} else if (status == 2) {%>WAP����<%}%></b>
            </font>
        </td>
        <td align=center><b><%=ftpInfo.getSiteName()%></b></td>
        <td align=center><%=siteIP%></td>
        <td><%=docpath%></td>
        <td align=center>
            <%if(pubway==0){
               if (ftptype == 0)
                   out.print("FTP����");
               else
                   out.print("SFTP����");
            } else {
                out.print("���ط���");
            }%>
        </td>
        <td align="center"><input type="radio" name="action" onclick="edit(<%=ftpInfo.getID()%>);"></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='removeipinfo.jsp?ID=<%=ftpInfo.getID()%>';"></td>
    </tr>
    <%}%>
</table>

</body>
</html>