<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
	wenti we = new wenti();
	int user_id = Integer.parseInt((String)request.getParameter("uid"));
	int ID = Integer.parseInt((String)request.getParameter("id"));
	int classid = ParamUtil.getIntParameter(request,"cid",24);
	String fenLei = (String)request.getParameter("fenlei");
	int qid =Integer.parseInt((String)request.getParameter("qid"));
	IWenbaManager iwenba = wenbaManagerImpl.getInstance();
	iwenba.changeQuestionStatus(qid);
	iwenba.changeAnwStatus(ID);
	we = (wenti)iwenba.getQuestion(qid);
	int num = we.getXuanshang();
	if(num>0){
	//�������߻���
		int userid = we.getUserid(); //��������ߵ�ID
		iwenba.changuser_xuanshang(num,userid);
		iwenba.weekgrade(userid,-num);//�ܻ��ּ���
	}
	//�ӻش��߻���
	iwenba.changbestAans(num,user_id);
	//һ����ͳ�ƻ���
	iwenba.weekgrade(user_id,num);
	//iwenba.weekgrade(num,user_id);
	//iwenba.changeUseranwnum(userid,2);
	response.sendRedirect("/wenba/wenba_finsh.jsp?cid="+classid+"&fenlei=" + URLEncoder.encode(fenLei)+"&id=" + qid);
	
%>
