<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
	User user = (User)session.getAttribute("user");
	int userType = 1;
	if(user==null){
		userType = 0;
	}
    wenbaImpl firstcolumn = null,sc=null;
    int classid = ParamUtil.getIntParameter(request,"cid",24);
    int locationid = ParamUtil.getIntParameter(request,"localid",0);
    
    int id =Integer.parseInt((String)request.getParameter("id"));
    String fenLei = (String)request.getParameter("fenlei");
    
    IWenbaManager iwenba = wenbaManagerImpl.getInstance();
    List list = iwenba.getCname();
	String Pro = (String)request.getParameter("pro");
	String sousuo = (String)request.getParameter("sss");
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
    List top10_wenti = iwenba.getTop10Questions(classid,0);
    List top10_wenti_jiejue= iwenba.getTop10Questions(classid,1);
    List top10_wenti_0anwser = iwenba.getTop10Questions0Answer(classid); 
   
    
%>
<%
	String linghuida = "��ش�����";
	linghuida = URLEncoder.encode(linghuida);
	String jiejue = "���½������";
	jiejue = URLEncoder.encode(jiejue);
	String lanmu = "�����������";
	lanmu = URLEncoder.encode(lanmu);
%>
<% //����𰸷�ҳ
		int intRowCount=0;  //�ܵļ�¼��
		int intPageCount=0; //�ܵ�ҳ��
		int intPageSize=5; //ÿҳ��ʾ�ļ�¼��
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
	    List pagelist = iwenba.getAnwserConnum(id);
	    intRowCount = pagelist.size();
	    intPageCount = (intRowCount+intPageSize-1) / intPageSize; //�����ܹ�Ҫ�ֶ���ҳ
			if(intPage>intPageCount) {
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
		return false;
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
.STYLE4 {font-size: larger}
-->
</style>
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
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="88" valign="top" background="/images/wenba_r11_c3.jpg" class="bian"><table width="753" border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td width="224" height="70" valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top"><img src="/images/wen_ba_r3_c2.jpg" width="224" height="9" /></td>
              </tr>
              <tr>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="6" valign="top"><img src="/images/wen_ba_r4_c2.jpg" width="6" height="70" /></td>
                    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="25" class="blackc12"><a href="javascript:wenti()">&nbsp;��Ҫ��</a></td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="38"><input type="image" src="/images/wen_ba_r2_c2.jpg" width="38" height="38" onclick="wenti()"/></td>
                            <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                             <%
                             	wenti wt2 = null;
                             	if (top10_wenti_jiejue.size() != 0) {
                             		int wt_id2 = Integer.parseInt((String) top10_wenti_jiejue
                             				.get(0));
                             		wt2 = iwenba.getQuestion(wt_id2);
                             		String titles = wt2.getTitles().trim();  
                    	String str;
                    	if(titles.length()>12) {
                    		str = titles.substring(0,12) + "...";
                    	}else{
                    		str = titles;
                   		}                     
                             %>
                              <tr>
                                <td class="black12"><a href="/wenba/wenba_finsh.jsp?id=<%=wt2.getId()%>&cid=<%=wt2.getColumnid()%>&fenlei=<%=jiejue%>"><%=str%></a></td>
                              </tr>
                              <%
                              	}
                              %>
                            </table></td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                    <td width="10" valign="top"><img src="/images/wen_ba_r4_c6.jpg" width="20" height="70" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td valign="top"><img src="/images/wen_ba_r8_c2.jpg" width="224" height="9" /></td>
              </tr>
            </table></td>
            <td width="265" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top"><img src="/images/wen_ba_r3_c7.jpg" width="264" height="9" /></td>
              </tr>
              <tr>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="6" valign="top"><img src="/images/wen_ba_r4_c2.jpg" width="6" height="70" /></td>
                      <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="25" class="blackc12">&nbsp;������</td>
                        </tr>
                        <tr>
                          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="60"><a href="#"><img src="/images/wen_ba_r5_c8.jpg" width="60" height="38" border="0" align="absmiddle" /></a></td>
                                <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                                     <%
                                     	wenti wt0 = null;
                                     	if (top10_wenti_0anwser.size() != 0) {
                                     		int wt_id0 = Integer.parseInt((String) top10_wenti_0anwser
                                     				.get(0));
                                     		wt0 = iwenba.getQuestion(wt_id0);
                                     		String titles = wt0.getTitles().trim();  
					                    	String str;
					                    	if(titles.length()>12) {
					                    		str = titles.substring(0,12) + "...";
					                    	}else{
					                    		str = titles;
					                   		}                     
                                     %>
                                    <tr>
                                      <td class="black12"><a href="/wenba/wenba_finsh.jsp?id=<%=wt0.getId()%>&cid=<%=wt0.getColumnid()%>&fenlei=<%=linghuida%>"><%=str%></a></td>
                                    </tr>
                                    <%
                                    	}
                                    %>
                                </table></td>
                              </tr>
                          </table></td>
                        </tr>
                      </table></td>
                      <td width="10" valign="top"><img src="/images/wen_ba_r4_c9.jpg" width="20" height="70" /></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td valign="top"><img src="/images/wen_ba_r8_c7.jpg" width="264" height="9" /></td>
              </tr>
            </table></td>
            <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top"><img src="/images/wen_ba_r3_c10.jpg" width="265" height="9" /></td>
              </tr>
              <tr>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="6" valign="top"><img src="/images/wen_ba_r4_c2.jpg" width="6" height="70" /></td>
                      <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="25" class="blackc12"><a href="/wenba/wenba_zhuanjia.jsp?cid=<%= classid%>">&nbsp;ר�ҽ���</a></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="45"><img src="/images/wen_ba_r6_c13.jpg" width="45" height="38" /></td>
                                  <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                                      <%
                                      	wenti wt1 = null;
                                      	if (top10_wenti.size() != 0) {
                                      		int wt_id1 = Integer.parseInt((String) top10_wenti.get(0));
                                      		wt1 = iwenba.getQuestion(wt_id1);
                                      		String titles = wt1.getTitles().trim();  
					                    	String str;
					                    	if(titles.length()>12) {
					                    		str = titles.substring(0,12) + "...";
					                    	}else{
					                    		str = titles;
					                   		}                     
                                      %>
                                      <tr>
                                        <td class="black12"><a href="/wenba/wenba_finsh.jsp?id=<%=wt1.getId()%>&cid=<%=wt1.getColumnid()%>&fenlei=<%=lanmu%>"><%=str%></a></td>
                                      </tr>
                                      <%
                                      	}
                                      %>
                                  </table></td>
                                </tr>
                            </table></td>
                          </tr>
                      </table></td>
                      <td width="10" valign="top"><img src="/images/wen_ba_r4_c11.jpg" width="20" height="70" /></td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td valign="top"><img src="/images/wen_ba_r8_c10.jpg" width="265" height="9" /></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table>
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
		  	<iframe name="jieshou" src="wenba.jsp" height="0" width="0"></iframe>
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
                  <td align="right"><a href="#">&nbsp;��һ������</a></td>
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
      <tr><%
      	wenti wt = new wenti();
      	wt = iwenba.getQuestion(id);
      	String url = wt.getPicpath();
      	int UserID = wt.getUserid();
      %>
        <td height="33" valign="bottom" >&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE2"><%=wt.getTitles()%></span></td>
      </tr>
      <tr>
        <td align="right">���������ͣ�<%=wt.getXuanshang()%>&nbsp;<span class="STYLE1">E��</span>&nbsp;</td>
      </tr>
	  <tr>
        <td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
      </tr>
	  <tr>
        <td height="30">&nbsp;&nbsp;&nbsp;&nbsp;������ࣺ<%=wt.getCname()%>&nbsp;&nbsp;&nbsp;����������<%=wt.getProvince()%>&nbsp;&nbsp;&nbsp;����ʱ�䣺<%=wt.getCreatedate()%></td>
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
			<td height="24" align="right" background="/images/wenba_finsh_19.gif"><%=wt.getCreatedate()%>&nbsp;&nbsp;����ش��������0��</td>
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
          %>
          
          <%
          	} if (user != null){
          		String username = user.getUsername().toString();
          		String UserName = wt.getUsername();
          		if(username==UserName||username.equals(UserName)){
          %>
	          <tr>
	            <td width="150" height="50" align="center" class="blackc12c">��&nbsp; ��&nbsp; ��&nbsp; ��</td>
	            <td>&nbsp;&nbsp;���лش��ǣ�<%=wt.getAnwsernum()%>��</td>
	            <td width="180" align="right" valign="top">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					    <td width="60" height="50" align="right" valign="top"><img src="/images/wenba_finsh_015.gif" width="28" height="28"/>&nbsp;</td>
					    <td width="60" align="right" valign="top"><img src="/images/wenba_finsh_017.gif" width="28" height="28"/>&nbsp;</td>
					    <td width="60" align="right" valign="top"><img src="/images/wenba_finsh_019.gif" width="28" height="28"/>&nbsp;</td>
					  </tr>
					</table>
				</td>
	          </tr>
	          <%} else{%>
	          <tr>
	            <td width="150" height="50" align="right"><img src="/images/wenba_finsh_022.gif" width="110" height="31" border="0" align="absmiddle"></td>
	            <td>&nbsp;&nbsp;���лش��ǣ�<%=wt.getAnwsernum()%>��</td>
	            <td width="180" align="right" valign="top">
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					    <td width="60" height="50" align="right" valign="top"><img src="/images/wenba_finsh_015.gif" width="28" height="28" />&nbsp;</td>
					    <td width="60" align="right" valign="top"><img src="/images/wenba_finsh_017.gif" width="28" height="28" />&nbsp;</td>
					    <td width="60" align="right" valign="top"><img src="/images/wenba_finsh_019.gif" width="28" height="28" />&nbsp;</td>
					  </tr>
					</table>
				</td>
	          </tr>
          <%}}%>  
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
						  <tr>
							<td height="25" valign="middle">&nbsp;&nbsp;Ŀǰ�ش�(<%=wt.getAnwsernum()%>)</td>
						  </tr>
						  <tr>
							<td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
						  </tr>
						  <%
						  	String qid = String.valueOf(wt.getId());
						  	answer ans = null;
						  	List answerlist = new ArrayList();
						  	answerlist = iwenba.getAnwserCon(end_no, begin_no, qid);	  
						  %>
						  <%
						  	for (int i = 0; i < answerlist.size(); i++) {
						  			ans = (answer) answerlist.get(i);
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
									<%
										if (url_ans == null || url_ans.equals("")) {
									%>
                                      <tr>
                                        <td width="15">&nbsp;</td>
                                        <td><%=ans.getAnwser()%></td>
										<td width="120" align="right" valign="top">
										  <img src="/images/wenba_finsh1_03.gif" width="81" height="48" border="0" align="absmiddle" />&nbsp;<br/>  
										</td>
                                      </tr>
                                      <%} else { %>
                                      <tr>
                                        <td width="15">&nbsp;</td>
                                        <td align="center" valign="middle"><img src="<%=url_ans%>" height="120" width="160" /></td>
										<td width="120" align="right" valign="top"></td>
                                      </tr>
                                      <tr>
                                        <td width="15">&nbsp;</td>
                                        <td><%=ans.getAnwser()%></td>
										<td width="120" align="right" valign="top"><img src="/images/wenba_finsh1_03.gif" width="81" height="48" border="0" align="absmiddle" />&nbsp;&nbsp;</td>
                                      </tr>
                                      <%
                                      	}
                                      %>
                                    </table>
                                   
                                    </td>
								  </tr>
								  <tr>
									<td height="20" valign="middle">&nbsp;&nbsp;<%=ans.getCreatedate()%></td>
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
								%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<%
									}
								%>							</td>
						  </tr>
						
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
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="245" height="26" align="right"><a href="#"><img src="/images/wenbafinsh_003.gif" width="72" height="26" border="0" align="absmiddle" onclick="top()"/></a>&nbsp;</td>
				<td width="53%">&nbsp;<a href="/wenba/wenba.jsp"><img src="/images/wenbafinsh_005.gif" width="121" height="26" border="0" align="absmiddle"></a></td>
			  </tr>
			  <tr>
				<td width="245" height="30" valign="middle"  class="blackc12c">&nbsp;&nbsp;<img src="/images/wenbafinsh_010.gif" width="17" height="14" />&nbsp;&nbsp;<%=wt.getCname()%>�ʰ�</td>
				<td>&nbsp;</td>
			  </tr>
			  <tr>
				<td colspan="2" valign="bottom">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><img src="/images/wenbazuizhongye_r2_c2.jpg" width="529" height="8" /></td>
                </tr>
                <tr>
                  <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="10" valign="top" background="/images/wenba_r3_c7.jpg"><img src="/images/bai.gif" width="10" height="1" /></td>
                        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td id="zx_finsh" width="197" height="30" align="center" background="/images/wenbazuizhongye_r3_c3.jpg" class="blackc12c"><a href="#" onclick="changNone()">�����������</a></td>
                                          <td align="center"><img src="images/bai.gif" width="1" height="1" /></td>
                                          <td  id="jj_finsh"width="173" align="center" background="/images/wenbazuizhongye_r3_c5.jpg" class="blackc12c"><a href="#" onclick="changNone1()">�ѽ��������</a></td>
                                          <td align="center"><img src="images/bai.gif" width="1" height="1" /></td>
                                          <td  id="0a_finsh"width="149" align="center" background="/images/wenbazuizhongye_r3_c7.jpg" class="blackc12c"><a href="#" onclick="changNone2()">��ش������</a></td>
                                        </tr>
                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td valign="top">
                                    <div id="finsh_z"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                          <td valign="top">
                                          
                                            <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                              <tr>
                                                <td height="25" bgcolor="#ECEDEF" class="black12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
                                                <td width="145" align="center" bgcolor="#ECEDEF" class="black12">ʱ��</td>
                                              </tr>
                                              <%
                                              	wenti wtz = null;
                                              	int wt_id = 0;
                                              	String date_str = null;
                                              	String color1 = "#ECEDEF";
                                              	String color2 = "#FFFFFF";
                                              	String color = "";
                                              	for (int i = 0; i < top10_wenti.size(); i++) {
                                              		if (i % 2 == 0) {
                                              			color = color2;
                                              		} else {
                                              			color = color1;
                                              		}
                                              		wtz = new wenti();
                                              		wt_id = Integer.parseInt((String) top10_wenti.get(i));
                                              		wtz = iwenba.getQuestion(wt_id);
                                              		date_str = wtz.getCreatedate().toString();
                                              		int posi = date_str.indexOf(" ");
                                              		date_str = date_str.substring(0, posi);
					                                String titles = wtz.getTitles().trim();  
							                    	String str;
							                    	if(titles.length()>20) {
							                    		str = titles.substring(0,20) + "...";
							                    	}else{
							                    		str = titles;
							                   		}                     
                                              %>
                                              <tr>
                                                <td height="25" bgcolor="<%=color%>">&nbsp;&nbsp;
                                                	<a href="/wenba/wenba_finsh.jsp?id=<%=wtz.getId()%>&cid=<%=wtz.getColumnid()%>&fenlei=<%=lanmu%>"><%=str%></a>&nbsp;&nbsp;
                                                	<%if(wtz.getFilepath()!=null){ %>
                        							<a href="/wenba/download.jsp?filepath=<%= wtz.getFilepath()%>">����</a>
                        							<%} %>
                                                </td>
                                                <td width="145" align="center" bgcolor="<%=color%>">[<%=date_str%>]</td>
                                              </tr>
                                              <%
                                              	}
                                              %>    
                                          </table>
                                         </td>
                                        </tr>
                                        <tr>
                                          <td height="20" align="right" valign="bottom" class="blackc12c"><a href="/wenba/wenba_third_fenlei.jsp?cid=<%=classid%>">&gt;&gt;&nbsp;����</a>&nbsp;&nbsp;</td>
                                        </tr>
                                    </table></div>
                                    <div id="finsh_jie"  style="display:none;">
                                    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                          <td valign="top">
                                          
                                            <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                              <tr>
                                                <td height="25" bgcolor="#ECEDEF" class="black12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
                                                <td width="145" align="center" bgcolor="#ECEDEF" class="black12">ʱ��</td>
                                              </tr>
                                              <%
                                              	wt = null;
                                              	wt_id = 0;
                                              	for (int i = 0; i < top10_wenti_jiejue.size(); i++) {
                                              		if (i % 2 == 0) {
                                              			color = color2;
                                              		} else {
                                              			color = color1;
                                              		}
                                              		wt = new wenti();
                                              		wt_id = Integer.parseInt((String) top10_wenti_jiejue.get(i));
                                              		wt = iwenba.getQuestion(wt_id);
                                              		date_str = wt.getCreatedate().toString();
                                              		int posi = date_str.indexOf(" ");
                                              		date_str = date_str.substring(0, posi);
                                              		String titles = wt.getTitles().trim();  
							                    	String str;
							                    	if(titles.length()>20) {
							                    		str = titles.substring(0,20) + "...";
							                    	}else{
							                    		str = titles;
							                   		}                     
                                              %>
                                              <tr>
                                                <td height="25" bgcolor="<%=color%>">&nbsp;&nbsp;
                                                	<a href="/wenba/wenba_finsh.jsp?id=<%=wt.getId()%>&cid=<%=wt.getColumnid()%>&fenlei=<%=jiejue%>"><%=str%></a>&nbsp;&nbsp;
                                                	<%if(wt.getFilepath()!=null){ %>
						                        	<a href="/wenba/download.jsp?filepath=<%= wt.getFilepath()%>">����</a>
						                        	<%} %>
                                                </td>
                                                <td width="145" align="center" bgcolor="<%=color%>">[<%=date_str%>]</td>
                                              </tr>
                                              <%
                                              	}
                                              %>    
                                          </table>
                                         </td>
                                        </tr>
                                        <tr>
                                          <td height="20" align="right" valign="bottom" class="blackc12c"><a href="/wenba/wenba_third_fenleijj.jsp?cid=<%=classid%>">&gt;&gt;&nbsp;����</a>&nbsp;&nbsp;</td>
                                        </tr>
                                    </table>
                                    </div>
                                    <div id="finsh_0"  style="display:none;">
                                    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                          <td valign="top">
                                          
                                            <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                              <tr>
                                                <td height="25" bgcolor="#ECEDEF" class="black12">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����</td>
                                                <td width="145" align="center" bgcolor="#ECEDEF" class="black12">ʱ��</td>
                                              </tr>
                                              <%
                                              	wt0 = null;
                                              	int wt_id0 = 0;
                                              	for (int i = 0; i < top10_wenti_0anwser.size(); i++) {
                                              		if (i % 2 == 0) {
                                              			color = color2;
                                              		} else {
                                              			color = color1;
                                              		}
                                              		wt0 = new wenti();
                                              		wt_id0 = Integer.parseInt((String) top10_wenti_0anwser.get(i));
                                              		wt0 = iwenba.getQuestion(wt_id0);
                                              		date_str = wt0.getCreatedate().toString();
                                              		int posi = date_str.indexOf(" ");
                                              		date_str = date_str.substring(0, posi);
                                              		String titles = wt0.getTitles().trim();  
							                    	String str;
							                    	if(titles.length()>20) {
							                    		str = titles.substring(0,20) + "...";
							                    	}else{
							                    		str = titles;
							                   		}                     
                                              %>
                                              <tr>
                                                <td height="25" bgcolor="<%=color%>">&nbsp;&nbsp;
                                                	<a href="/wenba/wenba_finsh.jsp?id=<%=wt0.getId()%>&cid=<%=wt0.getColumnid()%>&fenlei=<%=linghuida%>"><%=str%></a>&nbsp;&nbsp;
                                                	<%if(wt0.getFilepath()!=null){ %>
						                        	<a href="/wenba/download.jsp?filepath=<%= wt0.getFilepath()%>">����</a>
						                        	<%} %>
                                                </td>
                                                <td width="145" align="center" bgcolor="<%=color%>">[<%=date_str%>]</td>
                                              </tr>
                                              <%
                                              	}
                                              %>    
                                          </table>
                                         </td>
                                        </tr>
                                        <tr>
                                          <td height="20" align="right" valign="bottom" class="blackc12c"><a href="/wenba/wenba_third_fenlei0ans.jsp?cid=<%=classid%>">&gt;&gt;&nbsp;����</a>&nbsp;&nbsp;</td>
                                        </tr>
                                    </table>
                                    </div>
                                    </td>
                                  </tr>
                              </table></td>
                            </tr>
                           
                        </table></td>
                        <td width="10" valign="top" background="/images/wenba_r3_c9.jpg"><img src="/images/bai.gif" width="10" height="1" /></td>
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
        </tr>
      </table>
    </td>
    <td width="10" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
    <td width="210" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="159" background="/images/bg-4.gif"><table width="190" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="63" height="45" align="center"><img src="/images/icon-1.gif" width="48" height="44" /></td>
            <td width="63" align="center"><img src="/images/icon-2.gif" width="49" height="43" /></td>
            <td align="center"><a href="wenba.jsp"><img src="/images/icon-3.gif" width="35" height="36" border="0"/></a></td>
          </tr>
          <tr>
            <td height="20" align="center" class="blackc12"><a href="#">������ѯ</a></td>
            <td align="center" class="blackc12">�ֻ���ѯ</td>
            <td align="center" class="blackc12"><a href="wenba.jsp">�� ��</a> </td>
          </tr>
          <tr>
            <td align="center" valign="top"><img src="/images/bai.gif" width="1" height="5" /></td>
            <td align="center" valign="top"><img src="/images/bai.gif" width="1" height="5" /></td>
            <td align="center" valign="top"><img src="/images/bai.gif" width="1" height="5" /></td>
          </tr>
          <tr>
            <td height="45" align="center"><img src="/images/icon-4.gif" width="32" height="38" /></td>
            <td align="center"><img src="/images/icon-5.gif" width="40" height="39" /></td>
            <td align="center"><img src="/images/icon-6.gif" width="37" height="40" /></td>
          </tr>
          <tr>
            <td height="20" align="center" class="blackc12"><a href="#">רҵ����</a></td>
            <td align="center" class="blackc12">Ϊ������</td>
            <td align="center" class="blackc12">��Ʒͼ��</td>
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
                <td><a href="/wenba/wenba_finsh.jsp?id=<%=wtw.getId()%>&cid=<%=wtw.getColumnid()%>&fenlei=<%=URLEncoder.encode(names)%>"><%=str%></a></td>
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
                  <td><a href="/wenba/wenba_finsh.jsp?id=<%=wtx.getId()%>&cid=<%=wtx.getColumnid()%>&fenlei=<%=URLEncoder.encode(namex)%>"><%=str%></a></td>
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
</body>
</html>
