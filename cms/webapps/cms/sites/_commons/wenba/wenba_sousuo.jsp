<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*" contentType="text/html;charset=gbk"%>
<%
    wenbaImpl firstcolumn = null,sc=null;
    int classid = ParamUtil.getIntParameter(request,"cid",24);
    int locationid = ParamUtil.getIntParameter(request,"localid",0);
    IWenbaManager iwenba = wenbaManagerImpl.getInstance();
    List list = iwenba.getCname();
	String Pro = (String)request.getParameter("pro");
	String sousuo = (String)request.getParameter("sss");
	//String sousuo = "��ѵ";
	List top10_wenti_sousuo = null;
	List top10_wenti_0anwser_sousuo = null;
	List top10_wenti_sousuo_jiejue =null;
	if(sousuo!=null||!"".equals(sousuo)){
		top10_wenti_sousuo = iwenba.getTop10QuestionsSousuo(classid,0,sousuo);
		top10_wenti_sousuo_jiejue = iwenba.getTop10QuestionsSousuo(classid,1,sousuo);
		top10_wenti_0anwser_sousuo = iwenba.getTop10Questions0AnswerSousuo(classid,sousuo);
	}		
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
    List top10_wenti = iwenba.getTop10Questions(classid,0);
    List top10_wenti_jiejue= iwenba.getTop10Questions(classid,1);
    List top10_wenti_0anwser = iwenba.getTop10Questions0Answer(classid); 
    List top10_wenti_0anwserp = iwenba.getTop10Questions0Answer(classid,Pro);
    
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

function selectfenlei(){
	var CID = document.getElementById("fenlei").value;
	var url = "wenba.jsp?cid=" +escape(CID);
	window.location.href=url;
}

function wenti(){
	window.open("/wenba/wenba_woyaowen.jsp?cid=<%= classid%>");
}
function divchange(){
	var skey = document.getElementById("sss").value;
	var url = "wenba_sousuo.jsp?cid=<%= classid%>&sss=" +skey;
	
	if(skey == ""){
		alert("�����������ؼ���");
		//return false;
	}else{
			window.location.href=url; 
		 //document.all.sform.action = "wenba.jsp"
		// document.all.sform.submit();
		 //schange();	
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
	var url = "wenba_fenlei.jsp?sss=" +fenleis;
	window.location.href=url; 
}
//-->
</script>
</head>

<body>
<table width="973" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="214"><img src="/images/logo.jpg" width="214" height="112" /></td>
    <td width="536"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10" valign="top"><img src="/images/zhuce1_r2_c3.jpg" width="10" height="78" /></td>
        <td bgcolor="#EBEFF2"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class="black12"><a href="#" class="lan">��&nbsp;&nbsp;&nbsp;&nbsp;ҳ</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">Ҫ&nbsp;&nbsp;&nbsp;&nbsp;��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">�����ѯ</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">���ر�׼</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">��&nbsp;&nbsp;&nbsp;&nbsp;Ƶ</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">������ѯ</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">�ֻ���ѯ</a></td>
          </tr>
          <tr>
            <td height="25" class="black12"><a href="#" class="lan">�Ͷ���ͬ</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">��&nbsp;&nbsp;&nbsp;&nbsp;��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">��ᱣ��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">��Ƹ��ѵ</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">�Ͷ�����</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">�ٲü��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">HR&nbsp;��&nbsp;��</a></td>
          </tr>
          <tr>
            <td height="25" class="black12"><a href="#" class="lan">��ѵ�γ�</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">����˵��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">��&nbsp;&nbsp;&nbsp;&nbsp;��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">���߶���</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">��Ʒ����</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">ר&nbsp;��&nbsp;��</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" class="lan">HR&nbsp;��&nbsp;��</a></td>
          </tr>
        </table></td>
        <td width="10" valign="top"><img src="/images/zhuce1_r2_c5.jpg" width="10" height="78" /></td>
      </tr>
    </table></td>
    <td width="6" valign="top"><img src="/images/zhuce1_r3_c6.jpg" width="6" height="1" /></td>
    <td><table width="100%" border="0" cellpadding="2" cellspacing="0" bgcolor="#edf1f4">
      <tr>
        <td width="60" height="25" align="right">�û�����</td>
        <td align="left"><input name="textfield" type="text" style="font-size:12px;color:#000000;width: 130px;border:#000000 1px solid;" />
            <div id="Layer1" style="Z-INDEX: 1; VISIBILITY: visible; WIDTH: 59px; POSITION: absolute; TOP: 3px; HEIGHT: 42px; left: 942px;" align="center">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td align="left"><img src="/images/floating.gif" width="48" height="33" border="0" align="absmiddle" /></td>
                </tr>
              </table>
            </div></td>
      </tr>
      <tr>
        <td height="25" align="right">���룺</td>
        <td align="left"><input name="textfield2" type="text" style="font-size:12px;color:#000000;width: 130px;border:#000000 1px solid;" /></td>
      </tr>
      <tr>
        <td height="23" align="right">&nbsp;</td>
        <td align="left"><img src="/images/button-login.gif" width="36" height="20" border="0" align="absmiddle" />&nbsp;<img src="/images/button-sighin.gif" width="72" height="20" border="0" align="absmiddle" /></td>
      </tr>
    </table></td>
  </tr>
</table>
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
                        <td height="25" class="blackc12"><a href="/wenba/wenba_woyaowen.jsp">&nbsp;��Ҫ��</a></td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="38"><input type="image" src="/images/wen_ba_r2_c2.jpg" width="38" height="38" onclick="wenti()"/></td>
                            <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                              <tr>
                                <td class="black12"><a href="#">����ʡ��Ȫ�д��·���ٴ�Ϊ��ҵ�ṩ�Ͷ����Ϸ���</a></td>
                              </tr>
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
                                <td width="60"><a href="#"><img src="/images/wen_ba_r5_c8.jpg" width="60" height="38" border="0" /></a></td>
                                <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                                    <tr>
                                      <td class="black12"><a href="#">����ʡ��Ȫ�д��·���ٴ�Ϊ��ҵ�ṩ�Ͷ����Ϸ���</a></td>
                                    </tr>
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
                                      <tr>
                                        <td class="black12"><a href="#">����ʡ��Ȫ�д��·���ٴ�Ϊ��ҵ�ṩ�Ͷ����Ϸ���</a></td>
                                      </tr>
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
                         for(int i=0;i<list.size()/2; i++) {
                             firstcolumn = (wenbaImpl)list.get(2*i);
                             sc = (wenbaImpl)list.get(2*i+1);
                     %>
                    <tr>
                      <td width="95" height="25"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="wenba.jsp?cid=<%=firstcolumn.getID()%>"><%=firstcolumn.getCName()%></a></td>
                      <td width="95"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="wenba.jsp?cid=<%=sc.getID()%>"><%=sc.getCName()%></a></td>
                    </tr>
                    <%}%>
                     <% if (extra > 0) {
                        firstcolumn = (wenbaImpl)list.get(list.size()-1);
                     %>
                    <tr>
                      <td width="95" height="25"><img src="/images/wen_ba_r14_c4.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="wenba.jsp?cid=<%=firstcolumn.getID()%>"><%=firstcolumn.getCName()%></a></td>
                      <td width="95">&nbsp;&nbsp;</td>
                    </tr>
                     <%}%>
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
                          <td>&nbsp;<select name="fenlei" id="" onchange="selectfenlei()" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;">
										<option >--��ѡ��--</option>
										<%
										    for(int i=0;i<list.size();i++){
										    firstcolumn = (wenbaImpl)list.get(i);
					  		  			%>
										<option value="<%= firstcolumn.getID()%>"><%=StringUtil.gb2iso4View(firstcolumn.getCName()) %></option>
											<%}%>
                          			</select></td>
                        </tr>
                        <tr>
                          <td width="49" height="25"><img src="/images/wen_ba_r20_c3.jpg" width="49" height="19" align="absmiddle" /></td>
                          <td>&nbsp;<select name="wentifenlei" onchange="wenti_fenlei()" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;">
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
			<td height="40" align="right" bgcolor="#F1F5F6"><a href="#"><img onclick="divchange()" src="/images/wen_ba_r24_c12.jpg" width="41" height="23" border="0" align="absbottom" /></a>&nbsp;&nbsp;</td>
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
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����" onClick="province()">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�Ϻ�" onClick="province()">�Ϻ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=���">���</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�㶫">�㶫</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�ӱ�">�ӱ�</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=������">������</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=���ɹ�">���ɹ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�ຣ">�ຣ</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=ɽ��">ɽ��</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=ɽ��">ɽ��</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�Ĵ�">�Ĵ�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                        </tr>
						<tr>
                          <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�½�">�½�</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=����">����</a></td>
                          <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="wenba_diqu.jsp?cid=<%= classid%>&pro=�㽭">�㽭</a></td>
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
                <tr>
                  <td class="blackc12"><img src="/images/wen_ba_r26_c22.jpg" width="7" height="11" align="absmiddle" />&nbsp;�����������</td>
                  <td align="right"><a href="/wenba/wenba_third_fenlei.jsp">&gt;&gt;&nbsp;����</a></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="10" valign="top" background="/images/wenba_r3_c7.jpg"><img src="/images/bai.gif" width="10" height="1" /></td>
                  <td valign="top">
				  <div id="lanmu_tichu" style="display:none">
				  	<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                    <%
                    	String lanmu = "�����������";
                        wenti wt = null;
                        int wt_id = 0;
                        String date_str = null;
                        for(int i=0; i<top10_wenti.size(); i++) {
                            wt = new wenti();
                            wt_id=Integer.parseInt((String)top10_wenti.get(i));
                            wt = iwenba.getQuestion(wt_id);
                            date_str = wt.getCreatedate().toString();
                            int posi = date_str.indexOf(" ");
                            date_str = date_str.substring(0,posi);
                           
                        %>
                    <tr>
                      <td height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&cid=<%= wt.getColumnid()%>&fenlei=<%= lanmu%>"><%=wt.getTitles()%></a></td>
                      <td width="80" align="center" class="black12">[<%=date_str%>]</td>
                    </tr>
                    <%}%>
                  </table>
				  </div>
				  <div id="sousuo_tichu">
				  	<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                 	<%String s="������"; %><%=s %><%= top10_wenti_sousuo.size()%>
                 	<%
                      	if(top10_wenti_sousuo.size()>0){
                      	for(int i=0; i<top10_wenti_sousuo.size(); i++) {
                            wt = new wenti();
                            wt_id=Integer.parseInt((String)top10_wenti_sousuo.get(i).toString());
                            wt = iwenba.getQuestion(wt_id);
                            date_str = wt.getCreatedate().toString();
                            int posi = date_str.indexOf(" ");
                            date_str = date_str.substring(0,posi);
                      	
                    %>
                    <tr>
                      <td height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&circ=<%= wt.getColumnid()%>&fenlei=<%= lanmu%>"><%= wt.getTitles() %></a></td>
                      <td width="80" align="center" class="black12">[<%= date_str%>] </td>
                    </tr>
                  	 <%} }%>
                  </table>
				  </div>
				  </td>
                  <td width="10" valign="top" background="/images/wenba_r3_c9.jpg"><img src="/images/bai.gif" width="10" height="1"  /></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td valign="top"><img src="/images/wenba_r4_c7.jpg" width="530" height="20" /></td>
            </tr>
          </table>
            <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="13" /></td>
              </tr>
            </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian">
              <tr>
                <td height="34" background="/images/wenba_r8_c10.jpg"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="blackc12"><img src="/images/wen_ba_r26_c22.jpg" width="7" height="11" align="absmiddle" />&nbsp;���½������</td>
                    <td align="right"><a href="/wenba/wenba_third_fenlei.jsp">&gt;&gt;&nbsp;����</a></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td valign="top"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><img src="/images/bai.gif" width="1" height="5" /></td>
                  </tr>
                </table>
                  <div id="jiejue" style="display:none">
				  	<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                      <%
                      String jiejue = "���½������";
                          wt = null;
                          wt_id = 0;
                          for(int i=0; i<top10_wenti_jiejue.size(); i++) {
                              wt = new wenti();
                              wt_id=Integer.parseInt((String)top10_wenti_jiejue.get(i));
                              wt = iwenba.getQuestion(wt_id);
                              date_str = wt.getCreatedate().toString();
                              int posi = date_str.indexOf(" ");
                              date_str = date_str.substring(0,posi);
                          %>
                      <tr>
                      <td width="15" height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                      <td><a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&circ=<%= wt.getColumnid()%>&fenlei=<%= jiejue%>"><%=wt.getTitles()%>.</a></td>
                      <td width="80" align="center" class="black12">[<%=date_str%>]</td>
                    </tr>
                    <%}%>
                  </table>
				  </div>
				  <div id="sousuo_jiejue">
				  <table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                      <%
                          wt = null;
                          wt_id = 0;
                          if(top10_wenti_sousuo_jiejue.size()>0){
                          for(int i=0; i<top10_wenti_sousuo_jiejue.size(); i++) {
                              wt = new wenti();
                              wt_id=Integer.parseInt((String)top10_wenti_sousuo_jiejue.get(i).toString());
                              wt = iwenba.getQuestion(wt_id);
                              date_str = wt.getCreatedate().toString();
                              int posi = date_str.indexOf(" ");
                              date_str = date_str.substring(0,posi);
                          %>
                      <tr>
                      <td width="15" height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                      <td><a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&circ=<%= wt.getColumnid()%>&fenlei=<%= jiejue%>"><%=wt.getTitles()%>.</a></td>
                      <td width="80" align="center" class="black12">[<%=date_str%>]</td>
                    </tr>
                    <%}}%>
                  </table>
				  </div>
                  <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="/images/bai.gif" width="1" height="5" /></td>
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
                <td valign="top" bgcolor="#E9E9E9"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><img src="/images/bai.gif" width="1" height="10" /></td>
                  </tr>
                </table>
                  <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td valign="top" bgcolor="#FFFFFF"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td height="25" class="blackc12"><img src="/images/wen_ba_r26_c22.jpg" width="7" height="11" align="absmiddle" />&nbsp;��ش�����</td>
                          <td align="right"><a href="/wenba/wenba_third_fenlei.jsp">&gt;&gt;&nbsp;����</a></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td valign="top" bgcolor="#FFFFFF"><img src="/images/wen_ba_r39_c21.jpg" width="508" height="1" /></td>
                    </tr>
                    <tr>
                      <td valign="top" bgcolor="#FFFFFF"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td><img src="/images/bai.gif" width="1" height="10" /></td>
                        </tr>
                      </table>
                        <div id="0ans" style="display:none">
							<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                            <%
                            String linghuida = "��ش�����";
                                wt = null;
                                wt_id = 0;
                                for(int i=0; i<top10_wenti_0anwser.size(); i++) {
                                    wt = new wenti();
                                    wt_id=Integer.parseInt((String)top10_wenti_0anwser.get(i));
                                    wt = iwenba.getQuestion(wt_id);
                                    date_str = wt.getCreatedate().toString();
                                    int posi = date_str.indexOf(" ");
                                    date_str = date_str.substring(0,posi);
                                %>
                        <tr>
                          <td height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&circ=<%= wt.getColumnid()%>&fenlei=<%= linghuida%>"><%=wt.getTitles()%></a></td>
                          <td width="80" align="center" class="black12">[<%=date_str%>]</td>
                        </tr>
                       <%}%>
                      </table>
						</div>
					  <div id="sousuo_0ans">
					  	<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                            <%
                                wt = null;
                                wt_id = 0;
                                if(top10_wenti_0anwser_sousuo.size()>0){
                                for(int i=0; i<top10_wenti_0anwser_sousuo.size(); i++) {
                                    wt = new wenti();
                                    wt_id=Integer.parseInt((String)top10_wenti_0anwser_sousuo.get(i).toString());
                                    wt = iwenba.getQuestion(wt_id);
                                    date_str = wt.getCreatedate().toString();
                                    int posi = date_str.indexOf(" ");
                                    date_str = date_str.substring(0,posi);
                                %>
                        <tr>
                          <td height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&circ=<%= wt.getColumnid()%>&fenlei=<%= linghuida%>"><%=wt.getTitles()%></a></td>
                          <td width="80" align="center" class="black12">[<%=date_str%>]</td>
                        </tr>
                       <%}}%>
                      </table>
					  </div>
					  <div id="prov_0ans" style="display:none">
					  	<table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                            <%
                                wt = null;
                                wt_id = 0;
                                for(int i=0; i<top10_wenti_0anwserp.size(); i++) {
                                    wt = new wenti();
                                    wt_id=Integer.parseInt((String)top10_wenti_0anwserp.get(i));
                                    wt = iwenba.getQuestion(wt_id);
                                    date_str = wt.getCreatedate().toString();
                                    int posi = date_str.indexOf(" ");
                                    date_str = date_str.substring(0,posi);
                                %>
                        <tr>
                          <td height="20"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" />&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wt.getId()%>&circ=<%= wt.getColumnid()%>&fenlei=<%= linghuida%>"><%=wt.getTitles()%></a></td>
                          <td width="80" align="center" class="black12">[<%=date_str%>]</td>
                        </tr>
                       <%}%>
                      </table>
					  </div>
                        <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><img src="/images/bai.gif" width="1" height="10" /></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table>
                  <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td><img src="/images/bai.gif" width="1" height="10" /></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
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
                        for(int i=0; i<top8_wenti.size(); i++) {
                            wtw = new wenti();
                            wt_idw=Integer.parseInt((String)top8_wenti.get(i).toString());
                            wtw = iwenba.getQuestion(wt_idw); 
                                                    
                     %>
              <tr>
                <td width="15" height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                <td><a href="/wenba/wenba_finsh.jsp?id=<%= wtw.getId()%>&fenlei=<%= names%>"><%= wtw.getTitles()%></a></td>
                <td width="30" align="center" class="black12"><%= wtw.getXuanshang()%></td>
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
                        for(int i=0; i<top8_wenti_xuanshang.size(); i++) {
                            wtx = new wenti();
                            wt_idx=Integer.parseInt((String)top8_wenti_xuanshang.get(i).toString());
                            wtx = iwenba.getQuestion(wt_idx);                          
                     %>
                <tr>
                  <td width="15" height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" align="absmiddle" /></td>
                  <td><a href="/wenba/wenba_finsh.jsp?id=<%= wtx.getId()%>&fenlei=<%= namex%>"><%= wtx.getTitles()%></a></td>
                  <td width="30" align="center" class="black12"><%= wtx.getXuanshang()%></td>
                </tr>
                <%} %>
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
