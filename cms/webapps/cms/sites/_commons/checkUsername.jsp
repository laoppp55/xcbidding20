<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%
  	String name = ParamUtil.getParameter(request,"username");
    int siteid =  ParamUtil.getIntParameter(request,"siteid",0);
    IUregisterManager regMgr = UregisterPeer.getInstance();

    int flag= regMgr.checkUserExist(name,siteid);
    if(flag==1 || flag == 2){
		out.write(1+"-������ʹ��!");
	}else{
		out.write(0+"-����ʹ��!");
	}
  %>
 