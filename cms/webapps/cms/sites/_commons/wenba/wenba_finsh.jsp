<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParsePosition" %>
<%
	//��ȡ��ǰϵͳʱ��  ���ڼ������ش�������ж��
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date systemDate = new Date();
	ParsePosition pos1 = new ParsePosition(0);
	ParsePosition pos2 = new ParsePosition(0);
	String SystemDate = sdf.format(systemDate);
	Date systemdate = sdf.parse(SystemDate, pos1);

	User user = (User) session.getAttribute("user");
	int userType = 1;
	int uID = 0;
	if (user == null) {
		userType = 0;
	} else {
		uID = user.getUserid();
	}
	wenbaImpl firstcolumn = null, sc = null;
	int classid = ParamUtil.getIntParameter(request, "cid", 0);
	int locationid = ParamUtil.getIntParameter(request, "localid", 0);

	int id = Integer.parseInt((String) request.getParameter("id"));
	String fenLei = (String) request.getParameter("fenlei");
	
	IWenbaManager iwenba = wenbaManagerImpl.getInstance();
	iwenba.Pageview(id);//�����
	wenti wentiflag = iwenba.getQuestion(id);
	List list = iwenba.getCname();
	String Pro = (String) request.getParameter("pro");
	String sousuo = (String) request.getParameter("sss");
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba
			.getTop8QuestionsXuanshang(classid);
	List top10_wenti = iwenba.getTop10Questions(classid, 0);
	List top10_wenti_jiejue = iwenba.getTop10Questions(classid, 1);
	List top10_wenti_0anwser = iwenba.getTop10Questions0Answer(classid);
	wenti wt = new wenti();
	wt = (wenti)iwenba.getQuestion(id);

	String wtdate="0";
	wtdate = wt.getCreatedate().toString();
	System.out.println("null pointer------------------"+wtdate+"-------------------------");
	int wtposi = wtdate.indexOf(" ");
	wtdate = wtdate.substring(0, wtposi);
	//��ȡ����ʱ�����ڼ������ش��ж�����
	Date cDate = sdf.parse(wtdate, pos2);
	long day = systemdate.getTime() - cDate.getTime();
	String days = String.valueOf((day / (24 * 60 * 60 * 1000)));
	//���ûش�����Ϊ30��
	int szts = 30;
	//�������ش����������
	int dates = szts - Integer.parseInt(days);
	//������ش����������Ϊ0��  ѡȡ��Ʊ�����Ļش�Ϊ��Ѵ�

	if (dates <= 0) {
		int result = 0;
		result = iwenba.wentiguoqi(id);//�ж������Ƿ����
		//System.out.println("------------------------�����жϣ�"+result);
		//�������ж������Ƿ��лش� ����е�Ʊ���Ϊ��Ѵ� ���û�д� ����������Ϊ���ڡ�
		//iwenba.changeQuestionStatus(id);
		//if(wt.getAnwsernum()==0){
		//	iwenba.changeanwStatus_wenti(id);
		//}else{
		//	int aid = iwenba.getOneansid(id).getId();
		//	iwenba.changeAnwStatus(aid);//ѡ���Ʊ�����Ĵ�Ϊ���
			
		//}
	}
	String qid = String.valueOf(wt.getId());
	answer answer_stat;
	answer_stat = (answer) iwenba.getAnwserCon_zuijia(qid);
	String con = answer_stat.getAnwser();
	
	List dianjilist = iwenba.getTOP8DianJiShu(classid);
    List gradelist = iwenba.getTop8weekgrade();
%>
<%
	String linghuida = "��ش�����";
	linghuida = URLEncoder.encode(linghuida);
	String jiejue = "���½������";
	jiejue = URLEncoder.encode(jiejue);
	String lanmu = "�����������";
	lanmu = URLEncoder.encode(lanmu);
%>
<%
	//����𰸷�ҳ
	int intRowCount = 0; //�ܵļ�¼��
	int intPageCount = 0; //�ܵ�ҳ��
	int intPageSize = 5; //ÿҳ��ʾ�ļ�¼��
	int intPage; //��ǰ��ʾҳ 
	int begin_no = 0; //��ʼ��rownum��¼��
	int end_no = 0; //������rownum��¼��
	String strPage = request.getParameter("page"); //ȡ��ǰ��ʾҳ�� 
	if (strPage == null || strPage.equals(null)) {
		intPage = 1;
	} else {
		intPage = java.lang.Integer.parseInt(strPage);
		if (intPage < 1)
			intPage = 1;
	}
	begin_no = (intPage - 1) * intPageSize + 1;
	end_no = intPage * intPageSize;
	List pagelist = iwenba.getAnwserConnum(id);
	intRowCount = pagelist.size();
	intPageCount = (intRowCount + intPageSize - 1) / intPageSize; //�����ܹ�Ҫ�ֶ���ҳ
	if (intPage > intPageCount) {
		intPage = intPageCount; //��������ʾ��ҳ�� 
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�й��Ͷ�������--�ʰ�</title>
<link href="/images/css.css" rel="stylesheet" type="text/css"/>
<link href="/webbuilder/sites/www_fawu_com/images/hr-low.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">
<!--
function vote(){
	//window.open("http://www.hrlaw.com.cn/uermanager/regist/zhuce.jsp");
	alert("����û�е�½�����½��");
}
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function wenti_fenlei(){
	var fenleis = document.getElementById("wentifenlei").value;
	var url = "wenba_fenlei.jsp?sss=" +fenleis;
	window.location.href=url; 
}

function divchange(){
	var skey = document.getElementById("sss").value;
	var FenLei = document.getElementById("fenlei").value;
	var FanWei = document.getElementById("fanwei").value;
	var url = "wenba_fenlei.jsp?cid="+ FenLei + "&sss=" +skey +"&fanwei=" +FanWei;
	if(skey == ""){
		alert("�����������ؼ���");
		return false;
	}
	if(FenLei == ""){
		alert("��ѡ�����");
		return false;
	}
	if(FanWei == ""){
		alert("��ѡ��Χ")
		return false;
	}
	window.location.href=url; 
}

function selectfenlei(){
	var CID = document.getElementById("fenlei").value;
	var url = "wenba.jsp?cid=" +escape(CID);
	window.location.href=url;
}

function wenti(){
    var types = <%=userType%>
	if(types==0){
		alert("��û�е�½���ܻش����½��");
		return ;
	}else{
		window.open("/wenba/wenba_woyaowen.jsp?cid=<%=classid%>");
	}
}
function top(){
	window.history.go();
}

function tijiaohuida(){
	var url = "/wenba/wenba_huida.jsp";
	window.location.href=url;
}

function changNone(){
	document.getElementById("finsh_z").style.display="block";
	document.getElementById("finsh_jie").style.display="none";
	document.getElementById("finsh_0").style.display="none";
	document.getElementById("zx_finsh").background="/images/wenbazuizhongye_r3_c3.jpg";
	document.getElementById("jj_finsh").background="/images/wenbazuizhongye_r3_c5.jpg";
	document.getElementById("0a_finsh").background="/images/wenbazuizhongye_r3_c7.jpg";
}

function changNone1(){
	document.getElementById("finsh_z").style.display="none";
	document.getElementById("finsh_jie").style.display="block";
	document.getElementById("finsh_0").style.display="none";
	document.getElementById("zx_finsh").background="/images/wenbazuizhongye_r3_c3_1.jpg";
	document.getElementById("jj_finsh").background="/images/wenbazuizhongye_r3_c5_1.jpg";
	document.getElementById("0a_finsh").background="/images/wenbazuizhongye_r3_c7.jpg";
}

function changNone2(){
	document.getElementById("finsh_z").style.display="none";
	document.getElementById("finsh_jie").style.display="none";
	document.getElementById("finsh_0").style.display="block";
	document.getElementById("zx_finsh").background="/images/wenbazuizhongye_r3_c3_1.jpg";
	document.getElementById("jj_finsh").background="/images/wenbazuizhongye_r3_c5.jpg";
	document.getElementById("0a_finsh").background="/images/wenbazuizhongye_r3_c7_1.jpg";
}

function checkzhuanjia(){
	var userid = <%=uID%>;
	var questionuid = <%=wentiflag.getUserid_hd()%>;
	if(userid==0){
		alert('����û�е�½�����ȵ�½���ٽ��д˲�����');
		return false;
	}
	if(userid==questionuid||questionuid==0){
		document.form1.action = "/wenba/wenba_huida.jsp?id=<%=wt.getId()%>&cid=<%=classid%>&fenlei=<%=URLEncoder.encode(fenLei)%>";
		document.form1.submit();
	}else{
			alert('�Բ��������ܻش�����⣡');
			return false;
	}
}
function nextquestion(){
	document.form1.action = "doNextQuestion.jsp?id=<%=id%>&fenlei=<%=URLEncoder.encode(fenLei)%>";
	document.form1.submit();
}
//-->
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.STYLE2 {
	font-size: medium;
	font-family: "������";
	font-weight: bold;
}
.STYLE3 {color: #FF0066}
-->
</style>
</head>

<body>
<form name="form1" method="post">
<%@ include file="/include/laodongtop.shtml" %>
<%@ include file="/include/wenbacitou.shtml" %>
<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="/images/bai.gif" width="1" height="8" /></td>
  </tr>
</table>
<table width="982" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><%@ include file="/include/wenbaZJL.jsp"%>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="225" valign="top">
		<form name="sform" method="post"> 
		  	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian">
            <tr>
              <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="22" bgcolor="#BDD6DB" class="blackc12">&nbsp;&nbsp;�ʴ����</td>
                </tr>
                <tr>
                  <td bgcolor="#F1F5F6"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="/images/bai.gif" width="1" height="5" /></td>
                    </tr>
                  </table>
                    <table width="190" border="0" align="center" cellpadding="0" cellspacing="0">
                     <%
                     	int extra = list.size() % 2;
                     	for (int i = 0; i < list.size() / 2; i++) {
                     		firstcolumn = (wenbaImpl) list.get(2 * i);
                     		sc = (wenbaImpl) list.get(2 * i + 1);
                     %>
                    <tr>
                      <td width="95" height="25"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="doZXTW.jsp?fenlei=<%=firstcolumn.getID()%>"><%=firstcolumn.getCName()%></a></td>
                      <td width="95"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="doZXTW.jsp?fenlei=<%=sc.getID()%>"><%=sc.getCName()%></a></td>
                    </tr>
                    <%
                    	}
                    %>
                     <%
                     	if (extra > 0) {
                     		firstcolumn = (wenbaImpl) list.get(list.size() - 1);
                     %>
                    <tr>
                      <td width="95" height="25"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="doZXTW.jsp?fenlei=<%=firstcolumn.getID()%>"><%=firstcolumn.getCName()%></a></td>
                      <td width="95">&nbsp;&nbsp;</td>
                    </tr>
                     <%
                     	}
                     %>
                  </table>
                    <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td><img src="/images/bai.gif" width="1" height="5" /></td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="22" bgcolor="#BDD6DB" class="blackc12">&nbsp;&nbsp;��������</td>
                </tr>
                <tr>
                  <td bgcolor="#F1F5F6"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td><img src="/images/bai.gif" width="1" height="5" /></td>
                      </tr>
                    </table>
                      <table width="200" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="49" height="25"><img src="/images/wen_ba_r18_c3.jpg" width="49" height="19" align="absmiddle" /></td>
                          <td>&nbsp;<select name="fenlei" id="" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;">
										<option >--��ѡ��--</option>
										<%
											for (int i = 0; i < list.size(); i++) {
												firstcolumn = (wenbaImpl) list.get(i);
										%>
										<option value="<%=firstcolumn.getID()%>"><%=StringUtil.gb2iso4View(firstcolumn.getCName())%></option>
											<%
												}
											%>
                          			</select></td>
                        </tr>
                        <tr>
                          <td width="49" height="25"><img src="/images/wen_ba_r20_c3.jpg" width="49" height="19" align="absmiddle" /></td>
                          <td>&nbsp;<select name="fanwei" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;">
						  				<option value="">-��ѡ��Χ-</option>
						  				<option value="zuixinwenti">�����������</option>
										<option value="jiejiewenti">���½������</option>
										<option value="0answenti">��ش�����</option>
						  			</select>
                          </td>
                        </tr>
                        <tr>
                          <td width="49" height="25"><img src="/images/wen_ba_r22_c3.jpg" width="49" height="19" align="absmiddle" /></td>
                          <td>&nbsp;<input type="text" name="sss" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;" /></td>
                        </tr>
                      </table>
                      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td><img src="/images/bai.gif" width="1" height="5" /></td>
                        </tr>
                    </table></td>
                </tr>
              </table></td>
            </tr>
			<tr>
			<td height="40" align="right" bgcolor="#F1F5F6"><a href="#" onclick="divchange()"><img src="/images/wen_ba_r24_c12.jpg" width="41" height="23" border="0" align="absbottom" /></a>&nbsp;&nbsp;</td>
			</tr>
          </table>
		  </form>   
		  	<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="13" /></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="44" background="/images/wenba_r2_c2.jpg" class="blackc12">&nbsp;&nbsp;<img src="/images/diqiu.gif" width="30" height="31" align="absbottom" />&nbsp;�ط��ʴ�</td>
              </tr>
              <tr>
                <td valign="top" background="/images/wen_ba_r26_c2.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><img src="/images/bai.gif" width="1" height="5" /></td>
                  </tr>
                </table>
                  <table width="213" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td valign="top"><img src="/images/wen_ba_r28_c3.jpg" width="213" height="15" /></td>
                    </tr>
                    <tr>
                      <td valign="top" background="/images/wen_ba_r30_c31.jpg"><table width="190" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�Ϻ�" >�Ϻ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=���">���</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�㶫">�㶫</a></td>
                        </tr>
                        <tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�㽭">�㽭</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�½�">�½�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�ӱ�">�ӱ�</a></td>
                        </tr>
                        <tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=������">������</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                        </tr>
                        <tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=���ɹ�">���ɹ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�ຣ">�ຣ</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=ɽ��">ɽ��</a></td>
                        </tr>
                        <tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=ɽ��">ɽ��</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=�Ĵ�">�Ĵ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="dodifangZXTW.jsp?proname=����">����</a></td>
                          <td>&nbsp;</td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td valign="top"><img src="/images/wen_ba_r30_c3.jpg" width="213" height="15" /></td>
                    </tr>
                  </table>
                  <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="/images/bai.gif" width="1" height="5" /></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td valign="top"><img src="/images/wen_ba_r28_c2.jpg" width="224" height="6" /></td>
              </tr>
            </table>
            <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="10" /></td>
              </tr>
            </table>
          </td>
          <td valign="top" width="8"><img src="/images/bai.gif" width="8" height="1" /></td>
          <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="/images/wenba_finsh_1.gif"></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td  height="20" background="/images/wenba_finsh_2.gif" width="3"></td>
            <td background="/images/wenba_finsh_3.gif"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td class="blackc12c"><img src="/images/wen_ba_r26_c22.jpg" width="7" height="11" align="absmiddle" />&nbsp;<%=fenLei%></td>
                  <td align="right"><a href="javascript:nextquestion()">&nbsp;��һ������</a></td>
                </tr>
              </table></td>
            <td width="3" background="/images/wenba_finsh_5.gif"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><img src="/images/wenba_finsh_8.gif"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="/images/wenba_finsh_28.gif" width="10">&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      <%
      	String url = wt.getPicpath();
      	int UserID = wt.getUserid();
      	
      %>
        <td height="33" valign="bottom" >&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE2"><%=wt.getTitles()%></span></td>
      </tr>
      <tr>
        <td align="right">���������ͣ�<%=wt.getXuanshang()%>&nbsp;<span class="STYLE1">����</span>&nbsp;</td>
      </tr>
	  <tr>
        <td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
      </tr>
	  <tr>
        <td height="30">&nbsp;&nbsp;&nbsp;&nbsp;������ࣺ<%=wt.getCname()%>&nbsp;&nbsp;&nbsp;����������<%=wt.getProvince()%>&nbsp;&nbsp;&nbsp;����ʱ�䣺<%=wtdate%>&nbsp;&nbsp;&nbsp;�����ˣ�<%= wt.getUsername()%></td>
      </tr>
	  <tr>
        <td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="25">&nbsp;</td>
				<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <%
                  	if (url == null || url.equals("")) {
                  %>
				  <tr>
                    <td><%=wt.getQuestion()%></td>
                  </tr>
                  <%
                  	} else {
                  %>
                  <tr>
                    <td align="center" valign="middle"><img src="<%=url%>" height="180" width="220" /></td>
                  </tr>
				  <tr>
                    <td><%=wt.getQuestion()%></td>
                  </tr>
                  <%
                  	}
                  %>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                </table></td>
				<td width="25">&nbsp;</td>
			  </tr>
			</table>
	   </td>
      </tr>
	  <tr>
        <td height="20">&nbsp;</td>
      </tr>
      <tr>
        <td>
		  <table width="100%" border="0" cellpadding="0" cellspacing="0">
		    <td width="10"></td>
			<td height="24" align="right" background="/images/wenba_finsh_19.gif">
			  <%=wtdate%>&nbsp;&nbsp;
			  <%
			  	if (con != null) {
			  %>
			  �������ѽ�����ٽ��ܻش�
			  <%
			  	}
			  	if(dates <= 0&&con == null){
			  %>
			  �������ѹ��ڲ��ٽ��ܻش�
			 
			  <%
			  	}
			  	if(con == null&&dates > 0){
			  %>
			  ����ش��������<span class="STYLE3">&nbsp;<%=dates%>&nbsp;</span>��
			  <%
			  	}
			  %>
			</td>
			<td width="10"></td>
		  </table>
		</td>
      </tr>
	  <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="10">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <%
          	if (user == null) {
          		if (con != null) {
          %>
          <tr>
	            <td width="150" height="50" align="center" class="blackc12c">��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</td>
	            <td>&nbsp;&nbsp;���лش��ǣ�<%=wt.getAnwsernum()%>��</td>
	            <td width="180" align="right" valign="top">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  </tr>
					</table>
				</td>
	      </tr>
	      <%
	      		}
	      		if( dates <= 0&&con==null){
	      %>
	       <tr>
	           <td width="150" height="50" align="center" class="blackc12c">��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</td>
	           <td>&nbsp;&nbsp;���лش��ǣ�<%=wt.getAnwsernum()%>��</td>
	           <td width="180" align="right" valign="top">
	             <table width="100%" border="0" cellspacing="0" cellpadding="0">
					 <tr>
					    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  </tr>
				 </table>
				</td>
	        </tr>
	      
	      <%
	      		} 
				if(con==null&&dates > 0) {
	      %>
          <tr>
            <td width="150" height="50" align="right" class="blackc12c">
			<img src="/images/wenba_finsh_022.gif" width="110" height="31" border="0" align="absmiddle" onclick="checkzhuanjia()" style="cursor:hand"/>
			</td>
            <td>&nbsp;&nbsp;Ŀǰ�ش��ǣ�<%=wt.getAnwsernum()%>��</td>
            <td width="180" align="right" valign="top">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  </tr>
				</table>
			</td>
          </tr>
          <%
          	}
          }else{
          		String username = user.getUsername().toString();
          		String UserName = wt.getUsername();
          		if (username == UserName || username.equals(UserName)) {
          %>
	          <tr>
	            <td width="150" height="50" align="center" class="blackc12c">��&nbsp; ��&nbsp; ��&nbsp; ��</td>
	            <td>&nbsp;&nbsp;Ŀǰ�ش��ǣ�<%=wt.getAnwsernum()%>��</td>
	            <td width="180" align="right" valign="top">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  </tr>
					</table>
				</td>
	          </tr>
	          <%
	          	} else {
	          		if(con==null&&dates > 0){
	          %>
    
          			<tr>
			            <td width="150" height="50" align="right">
			            
			            <img src="/images/wenba_finsh_022.gif" width="110" height="31" border="0" align="absmiddle" onclick="checkzhuanjia()" style="cursor:hand"/></td>
			            <td>&nbsp;&nbsp;Ŀǰ�ش��ǣ�<%=wt.getAnwsernum()%>��</td>
			            <td width="180" align="right" valign="top">
			            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
							    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  </tr>
							</table>
						</td>
			         </tr>
          			<%}else{%>
          					
          			 <tr>
			            <td width="150" height="50" align="center" class="blackc12c">��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</td>
			            <td>&nbsp;&nbsp;���лش��ǣ�<%=wt.getAnwsernum()%>��</td>
			            <td width="180" align="right" valign="top">
			            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
							    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  </tr>
							</table>
						</td>
			      	  </tr>		
          				<%} %>	
          			<% 
          				}
          			%>
        
          
          			<%
                    }
                    %>  
        </table></td>
      </tr>
    </table></td>
    <td background="/images/wenba_finsh_30.gif" width="10">&nbsp;</td>
  </tr>
</table>
</td>
  </tr>
  <tr>
    <td><img src="/images/wenba_finsh_032.gif" width="530" height="12"/></td>
  </tr>
</table>
<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="13" /></td>
              </tr>
            </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" bgcolor="#E9E9E9"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><img src="/images/bai.gif" width="1" height="10" /></td>
                  </tr>
                </table>
                  <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td valign="top" bgcolor="#FFFFFF">
                     
					  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  	 <%
					  	 	if (con != null) {
					  	 %>
			                  <tr>
								<td height="25" valign="middle">&nbsp;&nbsp;<strong>��ѻش�</strong></td>
							  </tr>
							  <tr>
								<td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
							  </tr>
							  
		                      <tr>
								<td height="20" valign="middle">&nbsp;&nbsp;</td>
							  </tr>
							  <tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="15">&nbsp;</td>
											<td><%=con%></td>
											<td width="120" align="right" valign="top"><img src="/images/finsh_3.gif" width="81" height="48" border="0" align="absmiddle" />&nbsp;&nbsp;</td>
									    </tr>
								    </table>
							    </td>
							  </tr> 
							  <tr>
							    <td>&nbsp;</td>
							  </tr>
							  <tr>
								<td height="20" valign="middle">&nbsp;&nbsp;&nbsp;�ش�ʱ��:<%=answer_stat.getCreatedate()%>&nbsp;&nbsp;&nbsp;�ش���:<%= answer_stat.getUsername()%></td>
							  </tr>
							  <tr>
								<td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
							  </tr> 
						  <%}%>    
						  <%if (con != null) {%>
						  <tr>
							<td height="30" valign="middle">&nbsp;&nbsp;<strong>�����ش�</strong>(<%=wt.getAnwsernum() - 1%>)</td>
						  </tr>
						  <%} else { %>
						  <tr>
							<td height="25" valign="middle">&nbsp;&nbsp;<strong>Ŀǰ�ش�</strong>(<%=wt.getAnwsernum()%>)</td>
						  </tr>
						  <%}%>
						  <tr>
							<td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
						  </tr>
						  <%
						  	List answerlist = new ArrayList();
						  	answer ans = null;
						  	answerlist = iwenba.getAnwserCon(end_no, begin_no, qid);
						  	if (wt.getAnwsernum() == 0) {
						  %>
						  <tr>
						  	<td height="30" valign="middle">&nbsp;&nbsp;Ŀǰû�лش�!</td>
						  </tr>
						  <%
						  	} else {
						  %>
						  <%
						  	for (int i = 0; i < answerlist.size(); i++) {
						  			ans = (answer) answerlist.get(i);
						  			ans.getUsername();
						  			String url_ans = ans.getPicpath();
						  %>
						  <tr>
							<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td height="10"></td>
								  </tr>
								  <tr>
									<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
									  <tr>
                                        <td width="15">&nbsp;</td>
                                        <%if (url_ans == null || url_ans.equals("")) {%>
                                        <td align="center" valign="middle">&nbsp;</td>
										<%}else{ %> 
										<td align="center" valign="middle"><img src="<%=url_ans%>" height="120" width="160" /></td>
										<%}%>   
										<td width="120" align="right" valign="top"></td>
                                      </tr>                                                                           
                                      <tr>
                                        <td width="15">&nbsp;</td>
                                        <td><%=ans.getAnwser()%></td>
                                        <%
                                        	if (con == null || con.equals("")) {
                                        		if(user == null){
                                        %>
                                        <td width="120" align="right" valign="top"><a href="#"  onclick="vote()"><img src="/images/wenba_finsh1_03.gif" width="81" height="48" border="0" align="absmiddle" /></a>&nbsp;&nbsp;<br/>
												<%}else{
													String username = "";
													String UserName = wt.getUsername();
													username = user.getUsername().toString();
													if (username == UserName|| username.equals(UserName)) {
												%>
									    <td width="120" align="right" valign="top"><a href="/wenba/wenba_status.jsp?id=<%=ans.getId()%>&cid=<%=classid%>&fenlei=<%=URLEncoder.encode(fenLei)%>&qid=<%=ans.getQid()%>&uid=<%=ans.getUserid()%>"><img src="/images/wenba_vote2.gif" width="81" height="48" border="0" align="absmiddle" /></a>&nbsp;&nbsp;</td>
									          		<%
									          			}else{
									          				if(username.equals(ans.getUsername())){
									          		%>
									    <td width="120" align="right" valign="top"><img src="/images/finsh_4.gif" width="81" height="48" border="0" align="absmiddle" />&nbsp;&nbsp;</td> 
									    			<%}else{ %>     		
									    <td width="120" align="right" valign="top"><a href="/wenba/wenba_vote.jsp?id=<%=ans.getId()%>&cid=<%=classid%>&fenlei=<%=URLEncoder.encode(fenLei)%>&qid=<%=ans.getQid()%>&uid=<%= uID%>"><img src="/images/1.gif" width="81" height="48" border="0" align="absmiddle" /></a>&nbsp;&nbsp;<br/></td>
													<%}}}} else {%>
										<td >&nbsp;&nbsp;</td>
														<%}%>
                                      </tr>  
                                    </table>
                                    </td>
								  </tr>
								  <tr>
									<td>
									  <table width="100%" border="0" cellpadding="0" cellspacing="0">
									  	<tr>
									  	  <td>&nbsp;</td>
									  	  <td>�ο����ϣ�<%=ans.getCahkaoziliao()==null?"":ans.getCahkaoziliao() %></td>
									  	</tr>
										<tr>
											<td width="15">&nbsp;</td>
											<td height="20" valign="middle">�ش�ʱ��:<%=ans.getCreatedate()%>&nbsp;&nbsp;&nbsp;�ش���:<%= ans.getUsername() %>:</td>
										</tr>
										  <tr>
											<td colspan="2" valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
						  				</tr> 
									  </table>
									</td>
								  </tr>
								</table>
							</td>
						  </tr>
						  <tr>
							<td height="10"  bgcolor="#FFFFFF"></td>
						  </tr>
						  <%
						  	}
						  %>
						  <tr>
							<td align="right" bgcolor="#FFFFFF">
								<%
									if (intRowCount > intPageSize) {
								%>
								<!-- ��<%=intPageCount%>ҳ -->
								<%
									if (intPage > 1) {
								%>
								<a href="wenba_finsh.jsp?page=<%=intPage - 1%>&cid=<%=classid%>&id=<%=id%>&fenlei=<%=fenLei%>"><img src="/images/wenba_woyaoda_r9_c12.jpg" width="4" height="7" border="0" align="absmiddle" /></a>
	                    		<%
	                    			}
	                    		%>
	                    		<a href="wenba_finsh.jsp?page=1&cid=<%=classid%>&id=<%=id%>&fenlei=<%=fenLei%>">��ҳ</a>
	                    		<%
	                    			if (intPage > 1) {
	                    		%>
	                    		<a href="wenba_finsh.jsp?page=<%=intPage - 1%>&cid=<%=classid%>&id=<%=id%>&fenlei=<%=fenLei%>">��һҳ</a><%
	                    			}
	                    		%>
	                    		<%
	                    			if (intPage < intPageCount) {
	                    		%>
	                    		<a href="wenba_finsh.jsp?page=<%=intPage + 1%>&cid=<%=classid%>&id=<%=id%>&fenlei=<%=fenLei%>">��һҳ</a><%
	                    			}
	                    		%>
	                            <a href="wenba_finsh.jsp?page=<%=intPageCount%>&cid=<%=classid%>&id=<%=id%>&fenlei=<%=fenLei%>">βҳ</a>
	                            <%
	                            	if (intPage < intPageCount) {
	                            %>
								<a href="wenba_finsh.jsp?page=<%=intPage + 1%>&cid=<%=classid%>&id=<%=id%>&fenlei=<%=fenLei%>"><img src="/images/wenba_woyaoda_r9_c14.jpg" width="4" height="7" border="0" align="absmiddle" /></a><%
									}
								%>
								<%
									}
								%>							&nbsp;&nbsp;&nbsp;&nbsp;</td>
						  </tr>
						  <%
						  	}
						  %>
						</table>
					  </td>
                    </tr>
                    <tr>
                      <td valign="top" bgcolor="#FFFFFF">
					  

					  </td>
                    </tr>
                  </table>
                  <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="/images/bai.gif" width="1" height="10" /></td>
                    </tr>
                  </table></td>
              </tr>
            </table> 
			<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="13" /></td>
              </tr>
            </table>
</td>
          </tr>
      </table>
    </td>
    <td width="10" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
    <td width="210" valign="top">
	<%@ include file="/include/liulei.shtml" %>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian1">
        <tr>
          <td valign="top" background="/images/wen_ba_r18_c33.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><img src="/images/bai.gif" width="1" height="5" /></td>
            </tr>
          </table>
            <table width="180" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="25"><img src="/images/wen_ba_r19_c34.jpg" width="15" height="14" align="absmiddle" />&nbsp;<a href="#">������ʣ�</a></td>
              </tr>
              <tr>
                <td height="25"><img src="/images/wen_ba_r21_c35.jpg" width="15" height="14" align="absmiddle" />&nbsp;<a href="#">��λش�</a></td>
              </tr>
              <tr>
                <td height="25"><img src="/images/wen_ba_r23_c35.jpg" width="15" height="14" align="absmiddle" />&nbsp;<a href="#">ʲô��ר�ҽ��ɣ�</a></td>
              </tr>
              <tr>
                <td height="25"><img src="/images/wen_ba_r25_c35.jpg" width="15" height="14" align="absmiddle" />&nbsp;<a href="#">�淶/���ֹ�����ʲô��</a></td>
              </tr>
            </table>
            <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="5" /></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian1">
        <tr>
          <td height="24" background="/images/wen_ba_r30_c34.jpg"><a href="#" class="blackc12">&nbsp;�����������а�</a></td>
        </tr>
        <tr>
          <td height="210" valign="top" background="/images/wen_ba_r18_c33.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><img src="/images/bai.gif" width="1" height="5" /></td>
            </tr>
          </table>
            <table width="185" border="0" align="center" cellpadding="0" cellspacing="0">
                    <%
                    	String names = "�����������а�";
                    	int wt_idx = 0;
                        String str = "";
                        for(int i=0; i<dianjilist.size(); i++) {
                            WenbaBean wb = (WenbaBean)dianjilist.get(i);
                            String title = wb.getTitle();
							if(title.length()>10){
								str = title.substring(0,10) + "...";
							}else{
								str = title ;
							}     
                                                                        
                     %>
              <tr>
                <td width="15" height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                <td><a href="/wenba/wenba_finsh.jsp?id=<%= wb.getId()%>&fenlei=<%= names%>"><%= str%></a></td>
                <td width="30" align="center" class="black12"><%= wb.getFenshu() %></td>
              </tr>
              
			 <%} %>
            </table>
            <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="5" /></td>
              </tr>
          </table></td>
        </tr>
      </table>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian1">
        <tr class="blackc12">
          <td height="24" background="/images/wen_ba_r30_c34.jpg"><a href="#" class="blackc12">&nbsp;</a><a href="#">���ܻ������а�</a></td>
        </tr>
        <tr>
          <td height="210" valign="top" background="/images/wen_ba_r18_c33.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="5" /></td>
              </tr>
            </table>
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			  		<%
			  			String namex = "���ܻ������а�";
                        for(int i=0; i<gradelist.size(); i++) {
                            WenbaBean wb = (WenbaBean)gradelist.get(i);                   
                     %>
                <tr>
                  <td width="15" height="25" align="center"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                  <td class="black12"><a href="dopersonQW.jsp?personid=<%=wb.getUserid() %>"><%=wb.getUsername() %></a></td>
                  <td width="30" align="center" class="black12"><%=wb.getWeekgrade() %></td>
                </tr>
                <%} %>
              </table>
              <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td><img src="/images/bai.gif" width="1" height="5" /></td>
                </tr>
          </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="/images/bai.gif" width="1" height="13" /></td>
  </tr>
</table>
<%@ include file="/include/low.shtml"%>
</form>
</body>
</html>

