<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.xml.*" %>
<%@page contentType="text/html;charset=GBK"%>
<%
    int id = ParamUtil.getIntParameter(request,"id",0);
    IFormManager formMgr = FormPeer.getInstance();
    formMgr.deleteZiliao(id);
    response.sendRedirect("diantaiziliao.jsp");
%>