<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
	User user = (User)session.getAttribute("user");
	String username = null;
		int P_jifeng = 0;
		int userType = 1;
		if(user==null){
			userType = 0;
			//
		}else{
			P_jifeng = user.getUsergrade();
			username = user.getUsername();
		}
    wenbaImpl firstcolumn = null,sc=null;
    int classid = ParamUtil.getIntParameter(request,"cid",24);
    int locationid = ParamUtil.getIntParameter(request,"localid",0);
    IWenbaManager iwenba = wenbaManagerImpl.getInstance();
    List list = iwenba.getCname();
	String Pro = (String)request.getParameter("pro");
	String keys = (String)request.getParameter("sss");
	String fanwei = (String)request.getParameter("fanwei");
	List top10_wenti = iwenba.getTop10Questions(classid,0);
    List top10_wenti_jiejue= iwenba.getTop10Questions(classid,1);
    List top10_wenti_0anwser = iwenba.getTop10Questions0Answer(classid); 
	
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
    
%>
<%
	String linghuida = "��ش�����";
	linghuida = URLEncoder.encode(linghuida);
	String jiejue = "���½������";
	jiejue = URLEncoder.encode(jiejue);
	String lanmu = "�����������";
	lanmu = URLEncoder.encode(lanmu);
%>
<% //������������ҳ
		int intRowCount=0;  //�ܵļ�¼��
		int intPageCount=0; //�ܵ�ҳ��
		int intPageSize=40; //ÿҳ��ʾ�ļ�¼��
		int intPage; //��ǰ��ʾҳ 
		int begin_no=0; //��ʼ��rownum��¼��
		int end_no=0;  //������rownum��¼��
		String strPage = request.getParameter("page"); //ȡ��ǰ��ʾҳ�� 
		if(strPage==null||strPage.equals(null)){
			intPage = 1; 
		} 
		else{
			intPage = java.lang.Integer.parseInt(strPage); 
			if(intPage<1) 
				intPage = 1; 
		}
		begin_no=(intPage-1) * intPageSize + 1; 
	    end_no = intPage * intPageSize;
	    List pagelist = iwenba.getSousuoQuestionsPidnum(classid,0,keys,Pro);
	    intRowCount = pagelist.size();
	    intPageCount = (intRowCount+intPageSize-1) / intPageSize; //�����ܹ�Ҫ�ֶ���ҳ
			if(intPage>intPageCount) {
				intPage = intPageCount; //��������ʾ��ҳ�� 
			}
	%>
	
	
	<% //�ѽ�������ҳ
		int intRowCount_jiejue=0;  //�ܵļ�¼��
		int intPageCount_jiejue=0; //�ܵ�ҳ��
		int intPageSize_jiejue=40; //ÿҳ��ʾ�ļ�¼��
		int intPage_jiejue; //��ǰ��ʾҳ 
		int begin_no_jiejue=0; //��ʼ��rownum��¼��
		int end_no_jiejue=0;  //������rownum��¼��
		String strPage_jiejue = request.getParameter("page_jiejue"); //ȡ��ǰ��ʾҳ�� 
		if(strPage_jiejue==null||strPage_jiejue.equals(null)){
			intPage_jiejue = 1; 
		} 
		else{
			intPage_jiejue = java.lang.Integer.parseInt(strPage_jiejue); 
			if(intPage_jiejue<1) 
				intPage_jiejue = 1; 
		}
		begin_no_jiejue=(intPage_jiejue-1) * intPageSize_jiejue + 1; 
	    end_no_jiejue = intPage_jiejue * intPageSize_jiejue;
	    List pagelist_jiejue = iwenba.getSousuoQuestionsPidnum(classid,1,keys,Pro);
	    intRowCount_jiejue = pagelist_jiejue.size();
	    intPageCount_jiejue = (intRowCount_jiejue+intPageSize_jiejue-1) / intPageSize_jiejue; //�����ܹ�Ҫ�ֶ���ҳ
			if(intPage_jiejue>intPageCount_jiejue) {
				intPage_jiejue = intPageCount_jiejue; //��������ʾ��ҳ�� 
			}
	%>
	
	<% //0�ش������ҳ
		int intRowCount_0ans=0;  //�ܵļ�¼��
		int intPageCount_0ans=0; //�ܵ�ҳ��
		int intPageSize_0ans=40; //ÿҳ��ʾ�ļ�¼��
		int intPage_0ans; //��ǰ��ʾҳ 
		int begin_no_0ans=0; //��ʼ��rownum��¼��
		int end_no_0ans=0;  //������rownum��¼��
		String strPage_0ans = request.getParameter("page_0ans"); //ȡ��ǰ��ʾҳ�� 
		if(strPage_0ans==null||strPage_0ans.equals(null)){
			intPage_0ans = 1; 
		} 
		else{
			intPage_0ans = java.lang.Integer.parseInt(strPage_0ans); 
			if(intPage_0ans<1) 
				intPage_0ans = 1; 
		}
		begin_no_0ans=(intPage_0ans-1) * intPageSize_0ans + 1; 
	    end_no_0ans = intPage_0ans * intPageSize_0ans;
	    List pagelist_0ans = iwenba.getSousuoQuestionsPidnum0an(classid,keys,Pro);
	    intRowCount_0ans = pagelist_0ans.size();
	    intPageCount_0ans = (intRowCount_0ans+intPageSize_0ans-1) / intPageSize_0ans; //�����ܹ�Ҫ�ֶ���ҳ
			if(intPage_0ans>intPageCount_0ans) {
				intPage_0ans = intPageCount_0ans; //��������ʾ��ҳ�� 
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
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
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

function wenti(){
    var types = <%= userType%>
	if(types==0){
		alert("��û�е�½���ܻش����½��");
		return false;
	}else{
		window.open("/wenba/wenba_woyaowen.jsp?cid=<%= classid%>");
	}
}

function schange(){
	document.getElementById("lanmu_tichu").style.display="none";
	document.getElementById("sousuo_tichu").style.display="block";
	document.getElementById("jiejue").style.display="none";
	document.getElementById("sousuo_jiejue").style.display="block";
	document.getElementById("0ans").style.display="none";
	document.getElementById("sousuo_0ans").style.display="block";
}

function wenti_fenlei(){
	var fenleis = document.getElementById("wentifenlei").value;
	var url = "wenba_fenlei.jsp?cid=<%=classid%>&sss=" +fenleis;
	window.location.href=url; 
}
//-->
</script>
</head>

<body>
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
                     	System.out.println("extra=" + extra);
                     	for (int i = 0; i < list.size() / 2; i++) {
                     		firstcolumn = (wenbaImpl) list.get(2 * i);
                     		sc = (wenbaImpl) list.get(2 * i + 1);
                     %>
                    <tr>
                      <td width="95" height="25"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="wenba.jsp?cid=<%=firstcolumn.getID()%>"><%=firstcolumn.getCName()%></a></td>
                      <td width="95"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="wenba.jsp?cid=<%=sc.getID()%>"><%=sc.getCName()%></a></td>
                    </tr>
                    <%
                    	}
                    %>
                     <%
                     	if (extra > 0) {
                     		firstcolumn = (wenbaImpl) list.get(list.size() - 1);
                     %>
                    <tr>
                      <td width="95" height="25"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="wenba.jsp?cid=<%=firstcolumn.getID()%>"><%=firstcolumn.getCName()%></a></td>
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
                          <td>&nbsp;<select name="fenlei" id=""style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;">
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
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����" onClick="province()">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�Ϻ�" onClick="province()">�Ϻ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=���">���</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�㶫">�㶫</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�ӱ�">�ӱ�</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=������">������</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=���ɹ�">���ɹ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�ຣ">�ຣ</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=ɽ��">ɽ��</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=ɽ��">ɽ��</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�Ĵ�">�Ĵ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�½�">�½�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%=classid%>&pro=�㽭">�㽭</a></td>
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="24" valign="bottom" background="/images/wenba_r6_c2.jpg" class="blackc12">&nbsp;&nbsp;ר�ҽ���</td>
              </tr>
              <tr>
                <td height="90" background="/images/wenba_r7_c2.jpg"><table width="205" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="56"><img src="/images/wenba_r9_c4.jpg" width="56" height="78" /></td>
                    <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                      <tr>
                        <td>������Դר�ң���ҵ����<br />
                          ��Դ����ʦ����ְҵ�ʸ�<br />
                          ��֤�ؼ���ѵʦ����</td>
                      </tr>
                      <tr>
                        <td align="right"><a href="#">��ϸ����&gt;&gt;</a></td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td><img src="/images/wenba_r9_c2.jpg" width="224" height="5" /></td>
              </tr>
            </table></td>
          <td valign="top" width="8"><img src="/images/bai.gif" width="8" height="1" /></td>
          <td valign="top">
		  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="45" background="/images/wenba_r2_c7.jpg"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <%
                	String titleName = null;
                  	if(fanwei == "zuixinwenti"||fanwei.equals("zuixinwenti")){
                  		titleName = "�����������";
                  	}
                  	if(fanwei == "jiejiewenti"||fanwei.equals("jiejiewenti")){
                  		titleName = "���½������";
                  	}
                  	if(fanwei == "0answenti"||fanwei.equals("0answenti")){
                  		titleName = "��ش�����";
                  	}
                  %>
                <tr>
                  <td class="blackc12"><img src="/images/wen_ba_r26_c22.jpg" width="7" height="11" align="absmiddle" />&nbsp;<%= titleName%></td>
                 
                </tr>
              </table></td>
            </tr>
            <tr>
              <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="10" valign="top" background="/images/wenba_r3_c7.jpg"><img src="/images/bai.gif" width="10" height="1" /></td>
                  <td valign="top">
				  	<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                    <%
                    	String panduan1 = "zuixinwenti";
                    	String panduan2 = "jiejiewenti";
                    	String panduan3 = "0answenti";
                    %>
                    <%
                    	if (fanwei == panduan1 || fanwei.equals(panduan1)) {
                    		List wenti_zuixin = iwenba.getSousuoQuestionsPid(end_no,begin_no,classid,0,keys,Pro);
                    		wenti wtz = null;
                    		String date_str_zuixin = null;
                    		for (int i = 0; i < wenti_zuixin.size(); i++) {
                    			wtz = (wenti) wenti_zuixin.get(i);
                    			date_str_zuixin = wtz.getCreatedate().toString();
                    			int posi = date_str_zuixin.indexOf(" ");
                    			date_str_zuixin = date_str_zuixin.substring(0, posi);
                    			String title = wtz.getTitles().trim();
                    			String str_t = "";
                    			if(title.length()>20){
                    				str_t = title.substring(0,20) + "...";
                    			}else{
                    				str_t = title;
                    			}
                    %>
	                    <tr>
	                      <td height="20">
	                      	<img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;
	                      	<a href="/wenba/wenba_finsh.jsp?id=<%= wtz.getId()%>&cid=<%= wtz.getColumnid()%>&fenlei=<%= lanmu%>"><%=str_t%></a>&nbsp;&nbsp;&nbsp;&nbsp;
	                      	<%if(wtz.getFilepath()!=null){ %>
                        	<a href="JavaScript:xiazai()">����</a>
                        	<%} %>
	                      </td>
	                      <script type="text/JavaScript">
	                      	function xiazai(){
	                      		var types = <%= userType%>;
	                      		var xuanshang = <%= P_jifeng%>;
	                      		//var name = <%=username%>;
									if(types==0){
										alert("ֻ�е�½�û���������������ϣ�");
										return ;
									}
		                      		if(xuanshang<30){
		                      			alert("���Ļ��ֲ��㣬��������������ϣ�");
		                      			return;
		                      		}else{
		                      			var con = confirm("���ظ����Ͻ��۳���10���֡�");
			                      		if(con==true){
				                      		var url = "/wenba/download.jsp?filepath=<%= wtz.getFilepath()%>&qid=<%=wtz.getId()%>&username=<%= username%>";
				                      		window.location.href=url; 	
			                      		}else{}
		                      		}
		                      	}
	                      </script>
	                      <td width="80" align="center" class="black12">[<%=date_str_zuixin%>]</td>
	                    </tr>     
                    <%
                         	}
                         %>
                    	<tr>
	                    	<td colspan="2" align="right" class="black12">
	                    	 <% if(intPageCount>1){	%> 
	                    		<%if (intPage > 1) {%>
                      			<a href="wenba_fenlei.jsp?page=<%=intPage - 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>"><img src="/images/wenba_woyaoda_r9_c12.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;
                            	<%} %>
	                    		<!-- ��<%= intPageCount%>ҳ -->
	                    		<a href="wenba_fenlei.jsp?page=1&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��ҳ</a>
	                    		<%if (intPage > 1) {%>
	                    		<a href="wenba_fenlei.jsp?page=<%=intPage - 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��һҳ</a><%}%>
	                    		<%if (intPage < intPageCount) {%>
	                    		<a href="wenba_fenlei.jsp?page=<%=intPage + 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��һҳ</a><%}%>
	                            <a href="wenba_fenlei.jsp?page=<%=intPageCount%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">βҳ</a>	                    	
	                       		<%if (intPage < intPageCount) {%>
	                    		<a href="wenba_fenlei.jsp?page=<%=intPage + 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>"><img src="/images/wenba_woyaoda_r9_c14.jpg" width="4" height="7" border="0" align="absmiddle" /></a>
	                    		<%} %>&nbsp;&nbsp;
	                    	  <%} %>
	                        </td>
						</tr>
                    <%
                    	}
                    %>
                    <%
                    	if (fanwei == panduan2 || fanwei.equals(panduan2)) {
                    		List wenti_zuixin = iwenba.getSousuoQuestionsPid(end_no_jiejue,begin_no_jiejue,classid,1,keys,Pro);
                    		wenti wtz = null;
                    		String date_str_zuixin = null;
                    		for (int i = 0; i < wenti_zuixin.size(); i++) {
                    			wtz = (wenti) wenti_zuixin.get(i);
                    			date_str_zuixin = wtz.getCreatedate().toString();
                    			int posi = date_str_zuixin.indexOf(" ");
                    			date_str_zuixin = date_str_zuixin.substring(0, posi);
                    			String title = wtz.getTitles().trim();
                    			String str_t = "";
                    			if(title.length()>20){
                    				str_t = title.substring(0,20) + "...";
                    			}else{
                    				str_t = title;
                    			}
                    %>
	                    <tr>
	                      <td height="20">
	                      	<img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;
	                      	<a href="/wenba/wenba_finsh.jsp?id=<%= wtz.getId()%>&cid=<%= wtz.getColumnid()%>&fenlei=<%= jiejue%>"><%=str_t%></a>&nbsp;&nbsp;&nbsp;&nbsp;
	                      	<%if(wtz.getFilepath()!=null){ %>
                        	<a href="javascript:xiazai1()">����</a>
                        	<%} %>
	                      </td>
	                      <script type="text/JavaScript">
	                      	function xiazai1(){
	                      		var types = <%= userType%>;
	                      		var xuanshang = <%= P_jifeng%>;
	                      		//var name = <%=username%>;
									if(types==0){
										alert("ֻ�е�½�û���������������ϣ�");
										return ;
									}
		                      		if(xuanshang<30){
		                      			alert("���Ļ��ֲ��㣬��������������ϣ�");
		                      			return;
		                      		}else{
		                      			var con = confirm("���ظ����Ͻ��۳���10���֡�");
			                      		if(con==true){
			                      			var url = "/wenba/download.jsp?filepath=<%= wtz.getFilepath()%>&qid=<%=wtz.getId()%>&username=<%= username%>";
			                      			window.location.href=url; 
			                      		}else{}
		                      		}
		                      	}
	                      </script>
	                      <td width="80" align="center" class="black12">[<%=date_str_zuixin%>]</td>
	                    </tr>
	                    
                    <%}%>
                        <tr>
	                      <td colspan="2" align="right" class="black12">
	                      	<%if(intPageCount_jiejue>1) {%>	
	                      		<%if (intPage_jiejue > 1) {%>
                      			<a href="wenba_fenlei.jsp?page_jiejue=<%=intPage_jiejue - 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>"><img src="/images/wenba_woyaoda_r9_c12.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;
                            	<%} %>
	                    		<a href="wenba_fenlei.jsp?page_jiejue=1&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��ҳ</a>
	                    		<%if (intPage_jiejue > 1) {%>
	                    		<a href="wenba_fenlei.jsp?page_jiejue=<%=intPage_jiejue - 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��һҳ</a><%}%>
	                    		<%if (intPage_jiejue < intPageCount_jiejue) {%>
	                    		<a href="wenba_fenlei.jsp?page_jiejue=<%=intPage_jiejue + 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��һҳ</a><%}%>
	                            <a href="wenba_fenlei.jsp?page_jiejue=<%=intPageCount_jiejue%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">βҳ</a>	
	                            <%if (intPage_jiejue < intPageCount_jiejue) {%>
	                    		<a href="wenba_fenlei.jsp?page_jiejue=<%=intPage_jiejue + 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>"><img src="/images/wenba_woyaoda_r9_c14.jpg" width="4" height="7" border="0" align="absmiddle" /></a>
	                    		<%} %>&nbsp;&nbsp;                    	
	                      	<%} %>
	                      </td>
                    	</tr>
                    <%}%>
                    <%
                    	if (fanwei == panduan3 || fanwei.equals(panduan3)) {
                    		List wenti_zuixin = iwenba.getSousuoQuestionsPid0an(end_no_0ans,begin_no_0ans,classid,keys,Pro);
                    		wenti wtz = null;
                    		String date_str_zuixin = null;
                    		for (int i = 0; i < wenti_zuixin.size(); i++) {
                    			wtz = (wenti) wenti_zuixin.get(i);
                    			date_str_zuixin = wtz.getCreatedate().toString();
                    			int posi = date_str_zuixin.indexOf(" ");
                    			date_str_zuixin = date_str_zuixin.substring(0, posi);
                    %>
	                    <tr>
	                      <td height="20">
	                      	<img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;
	                      	<a href="/wenba/wenba_finsh.jsp?id=<%= wtz.getId()%>&cid=<%= wtz.getColumnid()%>&fenlei=<%= linghuida%>"><%=wtz.getTitles()%></a>&nbsp;&nbsp;&nbsp;&nbsp;
	                      	<%if(wtz.getFilepath()!=null){ %>
                        	<a href="xiazai2">����</a>
                        	<%} %>
	                      </td>
	                      <script type="text/JavaScript">
	                      	function xiazai2(){
	                      		var types = <%= userType%>;
	                      		var xuanshang = <%= P_jifeng%>;
	                      		//var name = <%=username%>;
									if(types==0){
										alert("ֻ�е�½�û���������������ϣ�");
										return ;
									}
		                      		if(xuanshang<30){
		                      			alert("���Ļ��ֲ��㣬��������������ϣ�");
		                      			return;
		                      		}else{
		                      			var con = confirm("���ظ����Ͻ��۳���10���֡�");
			                      		if(con==true){
			                      			var url = "/wenba/download.jsp?filepath=<%= wtz.getFilepath()%>&qid=<%=wtz.getId()%>&username=<%= username%>";
			                      			window.location.href=url; 
			                      		}else{}
		                      		}
	                      	}
                          </script>
	                      <td width="80" align="center" class="black12">[<%=date_str_zuixin%>]</td>
	                    </tr>
	                    
                    <%}%>
                        <tr>
	                      <td colspan="2" align="right" class="black12">
	                    	  <%if(intPageCount_0ans>1){ %>
	                    	    <%if (intPage_0ans > 1) {%>
                      			<a href="wenba_fenlei.jsp?page_0ans=<%=intPage_0ans - 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>"><img src="/images/wenba_woyaoda_r9_c12.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;
                            	<%} %>
	                    	    <a href="wenba_fenlei.jsp?page_0ans=1&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��ҳ</a>
	                    		<%if (intPage_0ans > 1) {%>
	                    		<a href="wenba_fenlei.jsp?page_0ans=<%=intPage_0ans - 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��һҳ</a><%}%>
	                    		<%if (intPage_0ans < intPageCount_0ans) {%>
	                    		<a href="wenba_fenlei.jsp?page_0ans=<%=intPage_0ans + 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">��һҳ</a><%}%>
	                            <a href="wenba_fenlei.jsp?page_0ans=<%=intPageCount_0ans%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>">βҳ</a>	                    	
	                      		<%if (intPage_0ans < intPageCount_0ans) {%>
	                    		<a href="wenba_fenlei.jsp?page_0ans=<%=intPage_0ans + 1%>&cid=<%=classid%>&sss=<%=keys%>&fanwei=<%= fanwei%>"><img src="/images/wenba_woyaoda_r9_c14.jpg" width="4" height="7" border="0" align="absmiddle" /></a>
	                    		<%} %>&nbsp;&nbsp;  
	                          <%} %>
	                      </td>
                    	</tr>
                    <%}%>
                  	</table>
				  </td>
                  <td width="10" valign="top" background="/images/wenba_r3_c9.jpg"><img src="/images/bai.gif" width="10" height="1"  /></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td valign="top"><img src="/images/wenba_r4_c7.jpg" width="530" height="20" /></td>
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
          <td valign="top" background="/images/wen_ba_r18_c33.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><img src="/images/bai.gif" width="1" height="5" /></td>
            </tr>
          </table>
            <table width="185" border="0" align="center" cellpadding="0" cellspacing="0">
                    <%
                    	String names = "�����������а�";
                    	wenti wtw = null;
                    	int wt_idw = 0;
                    	for (int i = 0; i < top8_wenti.size(); i++) {
                    		wtw = new wenti();
                    		wt_idw = Integer
                    				.parseInt((String) top8_wenti.get(i).toString());
                    		wtw = iwenba.getQuestion(wt_idw);
                    		String titles = wtw.getTitles().trim();  
                    		String str;
		                    if(titles.length()>10) {
		                    	str = titles.substring(0,10) + "...";
		                    }else{
		                    	str = titles;
		                    }           
                    %>
              <tr>
                <td width="15" height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                <td><a href="/wenba/wenba_finsh.jsp?id=<%=wtw.getId()%>&fenlei=<%=names%>"><%=str%></a></td>
                <td width="30" align="center" class="black12"><%=wtw.getXuanshang()%></td>
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
          <td valign="top" background="/images/wen_ba_r18_c33.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="5" /></td>
              </tr>
            </table>
              <table width="185" border="0" align="center" cellpadding="0" cellspacing="0">
			  		<%
			  			String namex = "���ܻ������а�";
			  			wenti wtx = null;
			  			int wt_idx = 0;
			  			for (int i = 0; i < top8_wenti_xuanshang.size(); i++) {
			  				wtx = new wenti();
			  				wt_idx = Integer.parseInt((String) top8_wenti_xuanshang.get(i)
			  						.toString());
			  				wtx = iwenba.getQuestion(wt_idx);
					  		String titles = wtx.getTitles().trim();  
		                    String str;
		                    if(titles.length()>10) {
		                    	str = titles.substring(0,10) + "...";
		                    }else{
		                    	str = titles;
		                    }           
			  		%>
                <tr>
                  <td width="15" height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                  <td><a href="/wenba/wenba_finsh.jsp?id=<%=wtx.getId()%>&fenlei=<%=namex%>"><%=str%></a></td>
                  <td width="30" align="center" class="black12"><%=wtx.getXuanshang()%></td>
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
</table>
<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="/images/bai.gif" width="1" height="13" /></td>
  </tr>
</table>
<%@ include file="/include/low.shtml"%>
</body>
</html>
