<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.user.*" contentType="text/html; charset=GBK"%>
<%
String pagenum = request.getParameter("thispage")==null?"0":request.getParameter("thispage");
List list = new ArrayList();
IWenbaManager iwenba = wenbaManagerImpl.getInstance();
iwenba.setzhuanjia();
list = iwenba.getzhuangjian();
List pagelist = new ArrayList();
		//�ܼ�¼��
int allnum = list.size();
		//ÿҳ��¼��
int perpagenum = 2;
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
		User user = (User)list.get(i);
		pagelist.add(user);
	}	
}else if(thispage>=allpages&&allpages>0){

	for(int i=(allpages-1)*perpagenum;i<list.size();i++){
		User user = (User)list.get(i);
		pagelist.add(user);
	}
}else if(thispage>=allpages&&allpages==0){
	for(int i=0;i<list.size();i++){
		String str = (String)list.get(i);
		pagelist.add(str);
	}
}else if(thispage==0&&allpages>1){
	for(int i=0;i<perpagenum;i++){
		User user = (User)list.get(i);
		pagelist.add(user);
	}
}else if(thispage==0&&allpages==1){
	for(int i=0;i<perpagenum;i++){
		User user = (User)list.get(i);
		pagelist.add(user);
	}
}
session.setAttribute("zhuanjiapagenum",String.valueOf(perpagenum));
session.setAttribute("zhuanjialist",pagelist);
session.setAttribute("zhuanjiaallpages",String.valueOf(allpages));
session.setAttribute("zhuanjiathispage",String.valueOf(thispage));
response.sendRedirect("wenba_zhuanjia.jsp");
%>