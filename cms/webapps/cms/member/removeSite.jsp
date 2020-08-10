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
        request.setAttribute("message", "��ϵͳ����Ա��Ȩ��");
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
    //վ���б�
    String[][] titlebars = {
            {"", "siteManage.jsp"},
            {"ɾ��վ��", ""}
    };
    String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<p>
    &nbsp;&nbsp;<font color="red" size="2">ȷ��Ҫɾ��վ�� <b><%=dname%></b> ?
</p>
<p>
    &nbsp;&nbsp;�ò�����ɾ�������й�վ�����Ϣ�������£�ģ�壬�û���������Ϣ��<b>�����ؿ���!!!</b></font>
</p>

<form action="removeSite.jsp" name="deleteForm" method="post">
    <input type="hidden" name="doDelete" value="true">
    <input type="hidden" name="siteId" value="<%=siteid%>">
    <input type="hidden" name="dname" value="<%=dname%>">
    &nbsp;&nbsp;
    <input type="submit" value=" ȷ�� ">
    &nbsp;&nbsp;&nbsp;
    <input type="button" name="cancel" value=" ȡ�� " style="font-weight:bold;"
           onclick="location.href='siteManage.jsp';return false;">
</form>

<script language="JavaScript" type="text/javascript">
    <!--
    document.deleteForm.cancel.focus();
    //-->
</script>

</body>
</html>
