<%@ page contentType="text/html;charset=GBK" import="com.jspsmart.upload.*" %>
<%@ page import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*" %>
<%
	IWenbaManager iwenba = wenbaManagerImpl.getInstance();
	String FilePath = (String)request.getParameter("filepath");
	String id = (String)request.getParameter("qid");
	int ID = Integer.parseInt(id);
	String UserName = (String)request.getParameter("username");
	//wenti wen = new wenti();
	//wen = iwenba.getQuestion(ID);
	//int xuanshi = wen.getXuanshang();
	//if(xuanshi<300){
		//System.out.print("");
	//}else{
		SmartUpload su = new SmartUpload();  
		su.initialize(pageContext); 
		// �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ��� 
		//��֤������Ӻ��������ļ��������趨�������ص��ļ���չ��Ϊ 
		//docʱ����������Զ���word��������չ��Ϊpdfʱ
		//���������acrobat�򿪡� 
		su.setContentDisposition(null); 
		// �����ļ�
		su.downloadFile(FilePath);
	//}
	
%>
