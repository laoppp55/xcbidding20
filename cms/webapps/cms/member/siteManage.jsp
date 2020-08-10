<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.sitesetting.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK"%>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    if (authToken.getUserID().compareToIgnoreCase("admin") != 0) {
        request.setAttribute("message", "��ϵͳ����Ա��Ȩ��");
        response.sendRedirect("../index.jsp");
        return;
    }

    int resultnum = ParamUtil.getIntParameter(request, "resultnum", 20);
    int startnum = ParamUtil.getIntParameter(request, "startnum", 0);
    int searchflag = ParamUtil.getIntParameter(request, "searchflag", -1);
    String search = ParamUtil.getParameter(request, "search");
    ISiteInfoManager siteMgr = SiteInfoPeer.getInstance();
    List siteList = new ArrayList();
    int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

    if(searchflag == -1){
        rows = siteMgr.getAllSiteInfoNum();
        siteList = siteMgr.getAllSiteInfo(resultnum,startnum);
    }else{
        rows = siteMgr.getAllSearchSiteInfoNum(search);
        siteList = siteMgr.getAllSearchSiteInfo(resultnum,startnum,search);
    }
    row = siteList.size();

    if(rows < resultnum){
        totalpages = 1;
        currentpage = 1;
    }else{
        if(rows%resultnum == 0)
            totalpages = rows/resultnum;
        else
            totalpages = rows/resultnum + 1;

        currentpage = startnum/resultnum + 1;
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
        function create()
        {
            var iWidth=1200;                                                 //�������ڵĿ��;
            var iHeight=800;                                                //�������ڵĸ߶�;
            //var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            iTop = 0;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open("addsite.jsp", "", "top="+ iTop + ",left=" + iLeft + ",width=" + iWidth + ",height=" + iHeight + ",resizable=yes,scrollbars=yes");
        }

        function edit(siteid)
        {
            var iWidth=1200;                                                 //�������ڵĿ��;
            var iHeight=800;                                                //�������ڵĸ߶�;
            //var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            iTop = 0;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open("editSite.jsp?siteid=" + siteid, "", "top=" + iTop + ",left=" + iLeft + ",width=" + iWidth + ",height=" + iHeight + ",resizable=yes,scrollbars=yes");
        }

        function uploadsitepic(siteid)
        {
            window.open("../upload/uploadsitepic.jsp?site="+siteid + "&startnum=<%=startnum%>", "", "top=100,left=50,width=400,height=400");
        }

        function setupsite_to_template(siteid,validflag) {
            window.open("setsitetype.jsp?site="+siteid + "&startnum=<%=startnum%>", "", "top=100,left=50,width=400,height=400");
        }
    </script>
</head>
<body>
<%
    String[][] titlebars = {
            {"վ�����", ""}
    };
    String[][] operations = {
            {"<a href=javascript:create();>����վ��</a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="90%" align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td width="20%" align=center class="listHeader"><b>վ������</b></td>
        <td width="10%" align=center>������ʽ</td>
        <td width="15%" align=center>��������</td>
        <td width="15%" align=center>��Ϊģ��</td>
        <td width="10%" align=center>��ҳͼ</td>
        <td width="10%" align=center>�޸�</td>
        <td width="10%" align=center>��������</td>
        <td width="10%" align=center>ɾ��</td>
    </tr>
    <%
        SiteInfo siteInfo = null;
        for (int i=0; i<row; i++)
        {
            siteInfo = (SiteInfo)siteList.get(i);
            int siteid = siteInfo.getSiteid();
            String domainname = siteInfo.getDomainName();
            int imgflag = siteInfo.getImgeDir();
            int flag = siteInfo.getBindFlag();
            int tcFlag = siteInfo.getTcFlag();
            int pubflag = siteInfo.getPubFlag();
            int validflag = siteInfo.getValidFlag();
            String sitepic = siteInfo.getDomainPic();
            int samsiteid = siteInfo.getSamsiteid();
            String color = "";
            int type = 1;
            if (flag == 1)
            {
                color = "blue";
            }
            else if (flag == 2)
            {
                color = "red";
                type = 2;
            }
    %>
    <tr bgcolor="#ffffff" class=line>
        <td>&nbsp;<b><%=domainname%><%if (flag == 0) {%>(��ͣ)<%}%></b></td>
        <td align=center><%if (pubflag == 0) {%>�ֶ�<%} else if (pubflag == 1) {%>�Զ�<%} else {%>&nbsp;<%}%></td>
        <td align=center><%if (tcFlag == 0) {%>������<%} else if (tcFlag == 1) {%>����<%} else {%>&nbsp;<%}%></td>
        <td align=center>
            <% if (samsiteid == 0) {%>
            <a href="javascript:setupsite_to_template(<%=siteid%>,<%=validflag%>)"><%if (validflag == 0) {%><font color="red">ģ����վ</font><%} else if (validflag == 1) {%>��ͨ��վ<%} else if (validflag == 2) {%><font color="green">������վ</font><%} else {%>&nbsp;<%}%></a></td>
            <%} else {%>
                 <font color="blue">��ͨ��վ</font>
            <%}%>
        <td align=center><a href="javascript:uploadsitepic(<%=siteid%>)"><%if (sitepic != null) {%> <font color="red">��ҳͼ</font><% } else {%> ��ҳͼ <%}%></a></td>
        <td align="center"><input type="radio" name="action" onclick=edit(<%=siteid%>);></td>
        <td align="center"><input type="radio" name="action"
                                  onclick="location.href='siteIPManage.jsp?siteID=<%=siteid%>';"></td>
        <td align="center"><input type="radio" name="action"
                                  onclick="location.href='removeSite.jsp?siteId=<%=siteid%>&dname=<%=domainname%>';">
        </td>
    </tr>
    <%}%>
</table>
<br>
<center>
    <TABLE>
        <TBODY>
            <TR>
                <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp; ��<%=rows%>��&nbsp;&nbsp; ��ǰ��<%=currentpage%>ҳ&nbsp;
                    <%
                        if(startnum>0){
                    %>
                    <a href="siteManage.jsp?startnum=0&searchflag=<%=searchflag%>&search=<%=search%>">��һҳ</a>
                    <%}%>
                    <%if((startnum-resultnum)>=0){%>
                    <a href="siteManage.jsp?startnum=<%=startnum-resultnum%>&searchflag=<%=searchflag%>&search=<%=search%>">��һҳ</a>
                    <%}%>
                    <%if((startnum+resultnum)<rows){%>
                    <A href="siteManage.jsp?startnum=<%=startnum+resultnum%>&searchflag=<%=searchflag%>&search=<%=search%>">��һҳ</A>
                    <%}%>
                    <%if(currentpage != totalpages){%>
                    <A href="siteManage.jsp?startnum=<%=(totalpages-1)*resultnum%>&searchflag=<%=searchflag%>&search=<%=search%>">���һҳ</A>
                    <%}%>
                </TD>
                <TD>&nbsp;</TD>
            </TR></TBODY></TABLE><br>
    <table>
        <form name=searchform method=post action="siteManage.jsp">
            <input type="hidden" name="searchflag" value="1">
            <tr>
                <td>
                    վ������<input type="text" name="search">
                </td>
                <td>
                    <input type="submit" name="sbutton" value="����">
                </td>
            </tr>
        </form>
    </table>
</center>
</body>
</html>