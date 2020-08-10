<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }
    int id = ParamUtil.getIntParameter(request,"id",0);
    String projcode = ParamUtil.getParameter(request,"projcode");
    String majorcode = ParamUtil.getParameter(request,"majorcode");
    System.out.println("id="+id);
    IOrderManager orderMgr = orderPeer.getInstance();
    orderMgr.deleteClass(id);
    response.sendRedirect("Trainmajorclass.jsp?projcode="+projcode+"&majorcode="+majorcode);
%>