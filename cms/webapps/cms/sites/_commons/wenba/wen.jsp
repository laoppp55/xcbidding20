<%@ page  import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParsePosition" %>
<%
	wenbaImpl firstcolumn = null,sc=null;
    int classid = ParamUtil.getIntParameter(request,"cid",24);
    int locationid = ParamUtil.getIntParameter(request,"localid",0);
    IWenbaManager iwenba = wenbaManagerImpl.getInstance();
%>
<%
	
	//��ȡ��ǰϵͳʱ��  ���ڼ������ش�������ж��
	
%>

<html>
<head></head>
<body>
<table>
<%
	List alllist = iwenba.getAllQuestions0(classid,0);
	String  wtdate = "";
	for(int l=0;l<alllist.size();l++){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date systemDate = new Date();
	ParsePosition pos1 = new ParsePosition(0);
	ParsePosition pos2 = new ParsePosition(0);
	String SystemDate = sdf.format(systemDate);
	Date systemdate = sdf.parse(SystemDate, pos1);
		wenti wt_status = new wenti();
		int id = Integer.parseInt((String)alllist.get(l));
		wt_status = iwenba.getQuestion(id);
%>

<%	
		wtdate = wt_status.getCreatedate().toString();
		int wtposi = wtdate.indexOf(" ");
		wtdate = wtdate.substring(0, wtposi);
		//��ȡ����ʱ�����ڼ������ش��ж�����
		Date cDate = sdf.parse(wtdate, pos2);
		long day = systemdate.getTime() - cDate.getTime();
		String days = String.valueOf((day / (24 * 60 * 60 * 1000)));
		int szts = 15;
		//�������ش����������
		int dates = szts - Integer.parseInt(days);
		if(dates==0){
			iwenba.changeQuestionStatus(id);
			if(wt_status.getAnwsernum()==0){
				iwenba.changeanwStatus_wenti(id);//�����������
			}else{
				int aid = iwenba.getOneansid(id).getId();
				iwenba.changeAnwStatus(aid);//ѡ���Ʊ�����Ĵ�Ϊ���
				
			}
		}
	
%>

<tr>
	<td><%= wtdate%></td>
</tr>
<% }%>
</table>
</body>
</html>
