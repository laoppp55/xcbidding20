<%@ page import="java.util.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.sitesetting.*,
                 com.bizwink.cms.security.*" contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp?url=member/removeRight.jsp");
        return;
    }
    if (authToken.getUserID().compareToIgnoreCase("admin") != 0) {
        request.setAttribute("message", "无系统管理员的权限");
        response.sendRedirect("../index.jsp");
        return;
    }

    int siteid = ParamUtil.getIntParameter(request, "siteId", -1);
    String dname = ParamUtil.getParameter(request, "dname");
    boolean doDelete = ParamUtil.getBooleanParameter(request, "doDelete");
    boolean error = (siteid == -1);

    if (doDelete && !error) {
        ISiteInfoManager siteMgr = SiteInfoPeer.getInstance();
        try {
            siteMgr.remove(siteid);
            response.sendRedirect("siteManage.jsp");
        }
        catch (SiteInfoException ue) {
            error = true;
        }
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
</head>
<body>
<%
    //站点列表
    String[][] titlebars = {
            {"", "siteManage.jsp"},
            {"删除站点", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>
    &nbsp;&nbsp;<font color="red" size="2">确信要删除站点 <b><%=dname%></b> ?
</p>
<p>
    &nbsp;&nbsp;该操作将删除所有有关站点的信息包括文章，模板，用户等所有信息，<b>请慎重考虑!!!</b></font>
</p>

<form action="removeSite.jsp" name="deleteForm" method="post">
    <input type="hidden" name="doDelete" value="true">
    <input type="hidden" name="siteId" value="<%=siteid%>">
    <input type="hidden" name="dname" value="<%=dname%>">
    &nbsp;&nbsp;
    <input type="submit" value=" 确定 ">
    &nbsp;&nbsp;&nbsp;
    <input type="button" name="cancel" value=" 取消 " style="font-weight:bold;"
           onclick="location.href='siteManage.jsp';return false;">
</form>

<script language="JavaScript" type="text/javascript">
    <!--
    document.deleteForm.cancel.focus();
    //-->
</script>

</body>
</html>
