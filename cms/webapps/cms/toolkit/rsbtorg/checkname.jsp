<%@ page import="com.bizwink.webapps.register.*" %>
<%@ page contentType="text/html;charset=gbk"%>
<%
String userid= request.getParameter("userid")==null?"":request.getParameter("userid");
IUregisterManager regMgr = UregisterPeer.getInstance();
String strout = "";
if(userid.trim().equals("")){
	//strout = "empty";
	strout = "�û�������Ϊ�գ���������д�û���!";
}else if(userid.trim().indexOf("@")!=-1){
	strout = "�û������ܺ���@�������������û�����";
}else{
	if(regMgr.userExist(userid)){
		strout = "�û��Ѿ�����!";
	}else{
		strout = "success";
	}
}
out.write(strout);
%>




