<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%
	String Password = (String)request.getParameter("pass");
	String Name = (String)request.getParameter("username");
    IUregisterManager regMgr = UregisterPeer.getInstance();
    String sitename = request.getServerName();
    int Siteid = regMgr.getSiteid(sitename);

    int flag= regMgr.login(Name,Password,Siteid);
	if(flag==1){
		out.write(1+"."+"�û���������ȷ!"+flag);
	}else{
		out.write(0+"."+"�û����������!"+flag);
	}
%>