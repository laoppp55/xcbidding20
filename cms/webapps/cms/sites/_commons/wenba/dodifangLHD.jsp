<%@ page language="java" import="java.util.*,com.bizwink.wenba.*" contentType="text/html; charset=GBK"%>
<%
String pagenum = request.getParameter("thispage")==null?"0":request.getParameter("thispage");
String proname = request.getParameter("proname")==null?"":request.getParameter("proname");
String columnid  = request.getParameter("cid")==null?"0":request.getParameter("cid");
String keyword = request.getParameter("keys")==null?"":request.getParameter("keys");
List list = new ArrayList();
IWenbaManager iwenba = wenbaManagerImpl.getInstance();
list = iwenba.getdifangLHD(proname,Integer.parseInt(columnid),keyword);
List pagelist = new ArrayList();
		//�ܼ�¼��
int allnum = list.size();
		//ÿҳ��¼��
int perpagenum = 10;
		//ÿҳ����
int allpages = allnum%perpagenum==0?allnum/perpagenum:allnum/perpagenum+1;
		//��ǰҳ
int thispage = Integer.parseInt(pagenum);

if(thispage<1){
	thispage = 1;
}else if(thispage>allpages){
	thispage = allpages;
}
if(thispage>0&&thispage<allpages){
	for(int i=(thispage-1)*perpagenum;i<thispage*perpagenum;i++){
		WenbaBean wt = (WenbaBean)list.get(i);
		pagelist.add(wt);
	}	
}else if(thispage>=allpages&&allpages>0){

	for(int i=(allpages-1)*perpagenum;i<list.size();i++){
		WenbaBean wt = (WenbaBean)list.get(i);
		pagelist.add(wt);
	}
}else if(thispage>=allpages&&allpages==0){
	for(int i=0;i<list.size();i++){
		String str = (String)list.get(i);
		pagelist.add(str);
	}
}else if(thispage==0&&allpages>1){
	for(int i=0;i<perpagenum;i++){
		WenbaBean wt = (WenbaBean)list.get(i);
		pagelist.add(wt);
	}
}else if(thispage==0&&allpages==1){
	for(int i=0;i<perpagenum;i++){
		WenbaBean wt = (WenbaBean)list.get(i);
		pagelist.add(wt);
	}
}
String str3 = proname+ "," +columnid+ "," +keyword;
session.setAttribute("str3",str3);
session.setAttribute("difanglinghdpagenum",String.valueOf(perpagenum));
session.setAttribute("difanglinghdpagelist",pagelist);
session.setAttribute("difanglinghdallpages",String.valueOf(allpages));
session.setAttribute("difanglinghdthispage",String.valueOf(thispage));
response.sendRedirect("wenba_diqulhd.jsp");
%>