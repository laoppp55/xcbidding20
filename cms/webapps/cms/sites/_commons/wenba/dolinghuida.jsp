<%@ page language="java" import="java.util.*,com.bizwink.wenba.*" contentType="text/html; charset=GBK"%>
<%
String pagenum = request.getParameter("thispage")==null?"0":request.getParameter("thispage");
String fenlei = request.getParameter("fenlei")==null?"0":request.getParameter("fenlei");
String province = request.getParameter("province")==null?"":request.getParameter("province");
String keyword = request.getParameter("keyword")==null?"":request.getParameter("keyword");
List list = new ArrayList();
IWenbaManager iwenba = wenbaManagerImpl.getInstance();
list = iwenba.getLingHuiDa(Integer.parseInt(fenlei),province,keyword);
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
if(fenlei.equals(""))
	fenlei = "-@";
if(province.equals(""))
	province = "-@";
if(keyword.equals(""))
	keyword = "-@";
String str3 = province + "," + fenlei + "," +keyword;
session.setAttribute("str3",str3);
session.setAttribute("LHDpagenum",String.valueOf(perpagenum));
session.setAttribute("LHDpagelist",pagelist);
session.setAttribute("LHDallpages",String.valueOf(allpages));
session.setAttribute("LHDthispage",String.valueOf(thispage));
session.setAttribute("zjlhdcid",fenlei);
response.sendRedirect("wenba_ZJLHD.jsp");
%>