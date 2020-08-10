<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.*" %>
<%@page language="java" contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    ICompanyinfoManager companyManager = CompanyinfoPeer.getInstance();
    int id= ParamUtil.getIntParameter(request,"company",-1);
    int columnID=ParamUtil.getIntParameter(request,"column",-1);
    int currPage=ParamUtil.getIntParameter(request,"currPage",-1);
    int startIndex=ParamUtil.getIntParameter(request,"startIndex",-1);
    boolean doDelete = ParamUtil.getBooleanParameter(request, "doDelete");

    Companyinfo com = null;
    com = companyManager.getACompanyInfo(id,siteid);
    if(doDelete) {
        companyManager.delCompany(id,siteid);
        response.sendRedirect("companys.jsp?column="+columnID+"&currPage="+currPage+"&startIndex="+startIndex);
    }
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../../style/global.css">
    <script type="text/javascript">
        function delWebFiles() {
            var val = confirm("ȷ��Ҫɾ��������˾��Ϣ��");
            deleteForm.submit();
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<p class=line>ɾ����˾��Ϣ <b><%=com.getCompanyname()%>
</b> ?

<p>
<ul class=cur>����: �˲�����ɾ�������빫˾��ص���Ϣ���������ɾ����?</ul>
<form action="deleteCompany.jsp" name=deleteForm method="POST">
    <input type=hidden name=doDelete value=true>
    <input type=hidden name=article value="<%=id%>">
    <input type=hidden name=currPage value="<%=currPage%>">
    <input type=hidden name=startIndex value="<%=startIndex%>">
    <a href="javascript:delWebFiles();"><img src="../images/button_dele.gif" border=0></a>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:history.back();"><img src="../images/button_cancel.gif" border=0></a>
</form>

</body>
</html>
