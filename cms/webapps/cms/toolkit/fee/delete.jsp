<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    int startflag = ParamUtil.getIntParameter(request,"startlfag",-1);
    int id = ParamUtil.getIntParameter(request,"id",-1);
    if(startflag == 1){
        IOrderManager oMgr = orderPeer.getInstance();
        int errcode = oMgr.deleteAFeeInfo(id);
        if(errcode == 0){
            out.print("<script language=javascript>alert(\"ɾ���ɹ���\");window.location='index.jsp';</script>");
            return;
        }
        else{
            out.print("<script language=javascript>alert(\"ɾ��ʧ�ܣ�\");window.location='index.jsp';</script>");
            return;
        }
    }
%>