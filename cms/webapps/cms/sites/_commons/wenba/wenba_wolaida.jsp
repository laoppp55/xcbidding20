<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*,java.text.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
User user = (User)session.getAttribute("user");
	String username = null;
	int userType = 1;
	if(user==null){
		userType = 0;
		//
	}else{
		username = user.getUsername();
	}
	String linghuida = "��ش�����";
	linghuida = URLEncoder.encode(linghuida);
	String jiejue = "���½������";
	jiejue = URLEncoder.encode(jiejue);
	String lanmu = "�����������";
	lanmu = URLEncoder.encode(lanmu);
	
	
%>
<% //������������ҳ
wenbaImpl firstcolumn = null,sc=null;
int classid = ParamUtil.getIntParameter(request,"cid",0);
String thispage = (String)session.getAttribute("wldthispage")==null?"0":(String)session.getAttribute("wldthispage");
String allpages = (String)session.getAttribute("wldallpages")==null?"0":(String)session.getAttribute("wldallpages");
String perpagenum = session.getAttribute("wldperpagenum")==null?"0":(String)session.getAttribute("wldperpagenum");
List list = new ArrayList();
list = (List)session.getAttribute("wldpagelist");
if(list==null){
	response.sendRedirect("dowld.jsp");
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
IWenbaManager iwenba = wenbaManagerImpl.getInstance();
List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
List top10_wenti = iwenba.getTop10Questions(classid,0);
List top10_wenti_jiejue= iwenba.getTop10Questions(classid,1);

List cnamelist = iwenba.getCname();

List prolist = iwenba.getProvince();

List dianjilist = iwenba.getTOP8DianJiShu(classid);
List gradelist = iwenba.getTop8weekgrade();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�й��Ͷ�������--��������</title>
<link href="/images/css.css" rel="stylesheet" type="text/css"/>
<link href="/webbuilder/sites/www_fawu_com/images/hr-low.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/JavaScript">
function divchange(){
	var skey = document.getElementById("sss").value;
	var FenLei = document.getElementById("fenlei").value;
	var FanWei = document.getElementById("fanwei").value;
	var url = "wenba_fenlei.jsp?cid="+ FenLei + "&sss=" +skey +"&fanwei=" +FanWei;
	if(skey == ""){
		alert("�����������ؼ���");
		return ;
	}
	if(FenLei == ""){
		alert("��ѡ�����");
		return ;
	}
	if(FanWei == ""){
		alert("��ѡ��Χ")
		return ;
	}
	window.location.href=url; 
}
function gonum(){
    	var gopagenum = document.form1.gopagenum.value;
    		
    	if(gopagenum==""){
    		return false;
    	}else{
    		document.form1.thispage.value = gopagenum;
    		document.form1.action = "dowld.jsp";
    		document.form1.submit();
    	}
    }
function wenti(){
    var types = <%=userType%>
	if(types==0){
		alert("��û�е�½���ܻش����½��");
		return;
	}else{
		window.open("/wenba/wenba_woyaowen.jsp?cid=<%=classid%>");
	}
}

function sousuo(){
	var fenlei = "";
	var province = "";
	var keyword = "";
	fenlei = document.form1.fenlei.value;
	province = document.form1.proname.value;
	keyword = document.form1.sss.value;
	document.form1.action = "dowld.jsp?fenlei="+fenlei+"&province="+province+"&keyword="+keyword;
    document.form1.submit();
}
</script>
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
    <td height="609" valign="top"><%@ include file="/include/wenbaZJL.jsp"%>
      <table width="100%" height="70" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="1" /></td>
        </tr>
        <tr>
          <td><img src="/images/wen_ba_r18_c3.jpg" align="absmiddle"/>&nbsp;<select name="fenlei" id="">
				<option >--��ѡ��--</option>
				<%
					for(int i=0;i<cnamelist.size();i++){
					firstcolumn = (wenbaImpl)cnamelist.get(i);
				%>
				<option value="<%= StringUtil.gb2iso4View(firstcolumn.getCName())%>"><%=StringUtil.gb2iso4View(firstcolumn.getCName()) %></option>
				<%}%>
          </select></td>
          
         <td><img src="/images/wen_ba_r20_c3.jpg" align="absmiddle" />&nbsp;<select name="proname" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;">
				<option value="">-��ѡ�����-</option>
				<%for(int i=0;i<prolist.size();i++){ 
					WenbaBean wb = (WenbaBean)prolist.get(i);
					
				%>
				<option value="<%=wb.getProvince() %>"><%=wb.getProvince() %></option>
				<%} %>
		</select></td>
		
		<td><img src="/images/wen_ba_r22_c3.jpg" align="absmiddle" />&nbsp;<input type="text" name="sss" style="font-size:12px;color:#000000;width: 130px;border:#d1d1d1 1px solid;" value=""/></td>
       	<td><img src="/images/wen_ba_r24_c12.jpg" width="41" height="23" border="0" style="cursor:hand" align="absbottom" onclick="sousuo()"/></td>
        </tr>
      </table>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="760" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top" colspan="4"><img src="/images/wenba_woyaoda_r6_c2.jpg" width="761" height="8" /></td>
        </tr>
        <tr>
          <td  background="/images/wenba_woyaoda_r8_c5.jpg" class="ju-bookname-lj">
            ����          </td>
          <td  class="ju-bookname-lj">
          ����          </td>
          <td  class="ju-bookname-lj">
            ʱ��          </td>
          <td class="ju-bookname-lj">�ش���</td>
        </tr>
                <%if(list.size()!=0){ 
                	for(int i=0;i<list.size();i++){
                		wenti wt = (wenti)list.get(i);
                		System.out.println("----------------------------------�ش�����"+wt.getAnwsernum());
                		
                %>
                
                <tr>
                	<td height="25" align="left">&nbsp;<a href="wenba_finsh.jsp?id=<%= wt.getId()%>&cid=<%= wt.getColumnid()%>&fenlei=<%= lanmu%>"><%=wt.getTitles() %><span class="font">
                	  
                	</span></a></td>
                	<td align="left">&nbsp;<%=wt.getProvince()==null?"&nbsp":wt.getProvince() %></td>
                	<td align="left">&nbsp;<%=sdf.format(wt.getCreatedate())%></td>
                	<td align="left">&nbsp;<%=wt.getAnwsernum() %></td>
                </tr>
                
                <%} } %>
                
                <tr>
        		<td align="center" valign="top" class="font" colspan="4">
        		<%
					if (Integer.parseInt(thispage) >1){
				%>
                <a href="dowld.jsp?thispage=1">��ҳ</a>&nbsp;&nbsp;&nbsp;<a href="dowld.jsp?thispage=<%=Integer.parseInt(thispage)-1 %>">��һҳ</a>
                <%
					}
					if (Integer.parseInt(allpages) > Integer.parseInt(thispage)){
				%>
                &nbsp;&nbsp;<a href="dowld.jsp?thispage=<%=Integer.parseInt(thispage)+1 %>">��һҳ</a>&nbsp;&nbsp; &nbsp;<a href="dowld.jsp?thispage=<%=Integer.parseInt(allpages)%>">ĩҳ</a>
              <%
							}
							%>
              &nbsp;��ǰ�ǵ�<%=thispage%>ҳ  &nbsp;&nbsp;��<%=allpages%>ҳ&nbsp;
              ��
              <input name="gopagenum" type="text" class="txtgo" value="" size="2" />
              ҳ
            <input name="gobutton" type="button" class="madgo" onClick="gonum()" value="GO" /></td>
      </tr>
        <tr>
          <td valign="top" colspan="4"><img src="/images/wenba_woyaoda_r8_c2.jpg" width="761" height="18" /></td>
        </tr>
      </table>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table></td>
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
          <td height="24" background="/images/wen_ba_r30_c34.jpg"><a href="#" class="blackc12c">&nbsp;�����������а�</a></td>
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
          <td height="24" background="/images/wen_ba_r30_c34.jpg"><a href="#" class="blackc12">&nbsp;</a><a href="#" class="blackc12c">���ܻ������а�</a></td>
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
                  <td class="black12"><%=wb.getUsername() %></td>
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
      </table></td>
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
