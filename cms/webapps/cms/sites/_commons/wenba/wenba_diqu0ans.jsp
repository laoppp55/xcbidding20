<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
	User user = (User)session.getAttribute("user");
	int userType = 1;
	int P_jifeng = 0;
	String userName = "";
	String userID ="";
	if(user==null){
		userType = 0;
	}else{
		P_jifeng = user.getUsergrade();
		userName = (String)user.getUsername();
		userID = String.valueOf(user.getUserid());
	}
	IWenbaManager iwenba = wenbaManagerImpl.getInstance();
	wenbaImpl firstcolumn = null;
	List list = iwenba.getCname();
	int classid = ParamUtil.getIntParameter(request,"cid",24);
	String CID = (String)request.getParameter("cid");
	String Pro = (String)request.getParameter("pro");
	String key = (String)request.getParameter("keys");
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
	List top10_wenti = iwenba.getTop10Questions(classid,0);
    List top10_wenti_jiejue= iwenba.getTop10Questions(classid,1);
    List top10_wenti_0anwser = iwenba.getTop10Questions0Answer(classid);
	String types = "diqu_oans";
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
		int intPageSize=10; //ÿҳ��ʾ�ļ�¼��
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
	    List pagelist = iwenba.getProQuestionsPagenum(Pro);
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
<title>�����ʴ�</title>
<link href="/images/css.css" rel="stylesheet" type="text/css"/>
<link href="/webbuilder/sites/www_fawu_com/images/hr-low.css" rel="stylesheet" type="text/css" />

<script type="text/JavaScript">
function wenti(){
    var types = <%= userType%>
	if(types==0){
		alert("��û�е�½���ܻش����½��");
		return false;
	}else{
		window.open("/wenba/wenba_woyaowen.jsp?cid=<%= classid%>");
	}
}

function selectfenlei(){
	var CID = document.getElementById("fenlei").value;
	var url = "wenba.jsp?cid=" +escape(CID);
	window.location.href=url;
}

function divchange(){
	var skey = document.getElementById("sss").value;
	var url = "wenba_sousuo.jsp?cid=<%= classid%>&sss=" +skey;
	
	if(skey == ""){
		alert("�����������ؼ���");
	}else{
			window.location.href=url; 
	}
}

function wenti_change(){
	var url = "wenba_diqu.jsp?cid=<%=classid%>&pro=<%= Pro%>&keys=<%= key%>";
	window.location.href=url;
}

function wenti_jiejue_change(){
	var url = "wenba_diqujj.jsp?cid=<%=classid%>&pro=<%= Pro%>&keys=<%= key%>";
	window.location.href=url;
}
//function wenti_ans_change(){
//	var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=<%= Pro%>";
//	window.location.href=url;
//}
function wenti(){
	window.open("/wenba/wenba_woyaowen.jsp?cid=<%= classid%>");
}

function difang(prov){
	switch(prov)
	{
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�Ϻ�' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '���' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�㶫' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�ӱ�' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '������' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '���ɹ�' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�ຣ' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case 'ɽ��' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case 'ɽ��' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�Ĵ�' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�½�' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '����' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
		case '�㽭' :
		var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=" +prov +"&keys=" +"";
		window.location.href=url;
		break;
	}
}

function sousuo_fenlei(){
	var fenleiID = document.getElementById("select_fenlei").value; 
	var keys = document.getElementById("sousuo_key").value;
	var url ="wenba_diqu0ans.jsp?pro=<%= Pro%>&cid=" +fenleiID +"&keys=" + keys;
	if(fenleiID==""){
		alert("��ѡ�����");
		return ;
	}
	if(keys==""){
		alert("�����������ؼ���");
		return ;
	}
	window.location.href=url;
}

function shuaxin(){
	document.all.cod.src="valid.jsp";
}

function check(){
	var types = <%= userType%>
	if(types==0){
		alert("��û�е�½�����½��");
		return ;
	}
	if(document.all.titles.value==""){
		alert("�������������");
		return ;
	}
	if(document.all.Question.value==""){
		alert("����������ش�");
		return ;
	}
	if(document.all.tplFile.value!=""){
		var filename = document.all.tplFile.value;		
		var pos = filename.lastIndexOf(".");	
		var lastname = filename.substring(pos+1,filename.length);
		//alert(lastname);
		if(lastname.toLowerCase()!="jpg"&&lastname.toLowerCase()!="gif"){
			alert("ͼƬ���Ͳ���!ͼƬ��ʽΪJPG��GIF��ʽ");
			return ;
		}
	}
	if(document.all.tplFile1.value!=""){
		var filename = document.all.tplFile1.value;		
		var pos = filename.lastIndexOf(".");		
		var lastname = filename.substring(pos+1,filename.length);
		//alert(lastname);
		if(lastname.toLowerCase()!="txt"&&lastname.toLowerCase()!="doc"){
			alert("�ļ����Ͳ���!");
			return ;
		}
	}
	if(document.all.Select1.value=="1"){
		alert("��ѡ�����");
		return ;
	}
	if(document.all.Select2.value=="1"){
		alert("��ѡ�����");
		return ;
	}
	if(document.all.Select3.value=="1"){
		alert("��ѡ�����");
		return ;
	}
	if(document.all.Codes.value==""){
		alert("��������֤��");
		return ;
	}
	if(document.all.Emailnotify.checked){
		if(document.all.emails.value == ""){
			alert("�����������ַ");
			return ;
		}
	}
	document.all.form1.action = "tiwen_do.jsp";
	document.all.form1.submit();
}

function tiwenleixing(){
	var userid = document.getElementById("userId").value;
	var objXml1;
    	if (window.ActiveXObject)
        {
        	objXml1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        else if (window.XMLHttpRequest)
        {
            objXml1 = new XMLHttpRequest();
        }
        objXml1.open("POST", "/wenba/jifenyanzheng.jsp?userid="+userid, false);
        objXml1.send(null);
		var retstrs = objXml1.responseText;
		//alert(retstrs);
		if(retstrs<20){
    		document.getElementById("jifenyazheng").innerHTML = "<font color=red>"+"��������20�޷�ʹ���������ʣ�"+"</font>";
    	}else{
    		document.getElementById("twxs").style.display="block"; 
    	}	
}

function pttw(){
	document.getElementById("twxs").style.display="none"; 
}
</script>

<script language="javascript">
function LoadXML()
{
	var xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); 
	xmlDoc.async = "false";
	xmlDoc.load("XML\\Area.xml");
	return xmlDoc;
}

function InitArea()
{
	/*��ȡ���������������� */
	var dropElement1=document.getElementById("Select1"); 
    var dropElement2=document.getElementById("Select2"); 
    var dropElement3=document.getElementById("Select3"); 
	/*�Զ���һ������ �Ѵ������Ķ������	��������������������п��ѡ��*/  
    RemoveDropDownList(dropElement1);
    RemoveDropDownList(dropElement2);
    RemoveDropDownList(dropElement3);
	
	var pOption = document.createElement("option");
	pOption.value = "";
	pOption.text = "--��ѡ��--";
	dropElement1.add(pOption);
	
	var cOption = document.createElement("option");
	cOption.value = "";
	cOption.text = "--��ѡ��--";
	dropElement2.add(cOption);
	
	var aOption = document.createElement("option");
	aOption.value = " ";
	aOption.text = "--��ѡ��--";
	dropElement3.add(aOption);
	
	var xmlDoc= LoadXML();
	//var provinceNodes = xmlDoc.documentElement.childNodes[1].getAttribute("name");
	/*��ȡȫ�нڵ�*/
	var provinceNodes = xmlDoc.documentElement.childNodes;
	//var  TopnodeList=xmlDoc.selectSingleNode("Root").childNodes;
	//j = provinceNodes.length;
	//alert(j)
	if(provinceNodes.length > 0) //provinceNodes.length = 31
	{
		var province;
		var city;
		var area;
		
		for(var i=0; i<provinceNodes.length; i++)
		{
			province = provinceNodes[i];
			var pOption = document.createElement("option");
			pOption.value = province.getAttribute("name");
			pOption.text = province.getAttribute("name");
			dropElement1.add(pOption);
		}
	}
}

function selectProvince()
{
	var dropElement1=document.getElementById("Select1"); 
    var provinceName=dropElement1.options[dropElement1.selectedIndex].text;
	var xmlDoc= LoadXML();
	var provinceNode = xmlDoc.selectSingleNode("//root/province[@name='"+provinceName+"']");  //alert(provinceNode.getAttribute("name"));
	
	/*XmlNode node = doc.SelectSingleNode("//AllNode/Node[@ID = ��aaa��]");
   ������Xml�в���AllNode�ڵ��µĽڵ���ΪNode�Ľڵ㣬���ӽڵ��ID����ֵΪaaa*/
   
	var dropElement2=document.getElementById("Select2"); 
    var dropElement3=document.getElementById("Select3");
	
	RemoveDropDownList(dropElement2);
    RemoveDropDownList(dropElement3);
	
	var cOption = document.createElement("option");
	cOption.value = "0";
	cOption.text = "--��ѡ��--";
	dropElement2.add(cOption);
	
	var aOption = document.createElement("option");
	aOption.value = "0";
	aOption.text = "--��ѡ��--";
	dropElement3.add(aOption);
	
	for(var i=0; i<provinceNode.childNodes.length; i++)
		{
			city = provinceNode.childNodes[i];
			var cOption = document.createElement("option");
			cOption.value = city.getAttribute("name");
			cOption.text = city.getAttribute("name");
			dropElement2.add(cOption);
		}


}

function selectArea()
{
	var dropElement2=document.getElementById("Select2"); 
    var cityName=dropElement2.options[dropElement2.selectedIndex].text;
	var xmlDoc= LoadXML();
	var cityNode = xmlDoc.selectSingleNode("//root/province/city[@name='"+cityName+"']");
	
    var dropElement3=document.getElementById("Select3");
    RemoveDropDownList(dropElement3);
	var aOption = document.createElement("option");
	aOption.value = "0";
	aOption.text = "--��ѡ��--";
	dropElement3.add(aOption);
	
	for(var i=0; i<cityNode.childNodes.length; i++)
		{
			city = cityNode.childNodes[i];
			var aOption = document.createElement("option");
			aOption.value = city.getAttribute("name");
			aOption.text = city.getAttribute("name");
			dropElement3.add(aOption);
		}
}

function RemoveDropDownList(obj)
{
	if(obj)//�������obj��Ϊ�� ��
	{
		var length=obj.options.length;
		if(length > 0)
		{
			for(var i=length; i>=0;i--)
			{
				obj.remove(i);
			}
		}
	}
}
window.onload=InitArea;
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
                        <td height="25" class="blackc12c">&nbsp;<a href="javascript:wenti()">��Ҫ��</a></td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="38"><a href="#" onclick="wenti()"><img src="/images/wen_ba_r2_c2.jpg" width="38" height="38" border="0" /></a></td>
                            <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                              	<%
								wenti wt2 = null;
								if(top10_wenti_jiejue.size()!=0){
								int wt_id2 = Integer.parseInt((String)top10_wenti_jiejue.get(0));
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
                                <td class="black12"><a href="/wenba/wenba_finsh.jsp?id=<%= wt2.getId()%>&cid=<%= wt2.getColumnid()%>&fenlei=<%= jiejue%>"><%= str%></a></td>
                              </tr>
                              <%} %>
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
                          <td height="25" class="blackc12c">&nbsp;<a href="#">������</a></td>
                        </tr>
                        <tr>
                          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="60"><img src="/images/wen_ba_r5_c8.jpg" width="60" height="38" /></td>
                                <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                                     <%
										wenti wt0 = null;
										if(top10_wenti_0anwser.size()!=0){
										int wt_id0 = Integer.parseInt((String)top10_wenti_0anwser.get(0));
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
                                      <td class="black12"><a href="/wenba/wenba_finsh.jsp?id=<%= wt0.getId()%>&cid=<%= wt0.getColumnid()%>&fenlei=<%= linghuida%>"><%= str%></a></td>
                                    </tr>
                                    <%} %>
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
                            <td height="25" class="blackc12c">&nbsp;<a href="/wenba/wenba_zhuanjia.jsp?cid=<%= classid%>">ר�ҽ���</a></td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="45"><img src="/images/wen_ba_r6_c13.jpg" width="45" height="38" /></td>
                                  <td><table width="95%" border="0" align="right" cellpadding="0" cellspacing="0">
                                       <%
										wenti wt1 = null;
										if(top10_wenti.size()!=0){
										int wt_id1 = Integer.parseInt((String)top10_wenti.get(0));
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
                                        <td class="black12"><a href="/wenba/wenba_finsh.jsp?id=<%= wt1.getId()%>&cid=<%= wt1.getColumnid()%>&fenlei=<%= lanmu%>"><%= str%></a></td>
                                      </tr>
                                      <%} %>
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
          <td height="30" class="black14">&nbsp;�ط��ʴ�</td>
        </tr>
        <tr>
          <td height="25" align="center" valign="bottom" bgcolor="#BDD6DB" class="blackc12c">ʡ���������б�</td>
        </tr>
        <tr>
          <td valign="top" class="bian1"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><img src="/images/bai.gif" width="1" height="10" /></td>
            </tr>
          </table>
            <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�Ϻ�')">�Ϻ�</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('���')">���</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�㶫')">�㶫</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�ӱ�')">�ӱ�</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
            </tr>
			<tr>
              <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('������')">������</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('���ɹ�')">���ɹ�</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�ຣ')">�ຣ</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('ɽ��')">ɽ��</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('ɽ��')">ɽ��</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
            </tr>
            <tr>
              <td height="25"><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�Ĵ�')">�Ĵ�</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�½�')">�½�</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('����')">����</a></td>
              <td><img src="/images/wen_ba_r30_c6.jpg" width="3" height="3" />&nbsp;<a href="#" onclick="difang('�㽭')">�㽭</a></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
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
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="1" /></td>
        </tr>
        <tr>
          <td height="39" background="/images/wenba_woyaoda_r2_c2.jpg">&nbsp;&nbsp;&nbsp;&nbsp;
            <select name="select_fenlei" style="font-size:12px;color:#000000;width: 170px;border:#d1d1d1 1px solid;" >
            	<option >--��ѡ��--</option>
			<%
				for(int i=0;i<list.size();i++){
				firstcolumn = (wenbaImpl)list.get(i);
			%>
				<option value="<%= firstcolumn.getID()%>"><%=StringUtil.gb2iso4View(firstcolumn.getCName()) %></option>
				<%}%>
            </select>&nbsp;&nbsp;<span class="unnamed">
                    <input name="sousuo_key" type="text" style="font-size:12px;color:#000000;width: 170px;border:#d1d1d1 1px solid;" / >
&nbsp;                    <a href="javascript:sousuo_fenlei()" ><img src="/images/wenba_woyaoda_r3_c5.jpg" width="58" height="19" border="0" align="absmiddle" /></a></span></td>
        </tr>
      </table>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="761" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top"><img src="/images/wenba_woyaoda_r6_c2.jpg" width="761" height="8" /></td>
        </tr>
        <tr>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="7" valign="top" background="/images/wenba_woyaoda_r7_c2.jpg"><img src="/images/bai.gif" width="7" height="1" /></td>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="248" height="30" align="center" background="/images/wenba_woyaoda_r7_c7.jpg" class="blackc12c"><a href="#" onclick="wenti_change()">�����������</a></td>
                            <td align="center"><img src="/images/bai.gif" width="1" height="1" /></td>
                            <td width="248" align="center" background="/images/wenba_woyaoda_r7_c10.jpg" class="blackc12c"><a href="#" onclick="wenti_jiejue_change()">�ѽ��������</a></td>
                            <td align="center"><img src="/images/bai.gif" width="1" height="1" /></td>
                            <td width="247" align="center" background="/images/wenba_woyaoda_r7_c5.jpg" class="blackc12c"><a href="#">��ش������</a></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td valign="top" background="/images/wenba_woyaoda_r8_c5.jpg"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                                <tr>
                                  <td width="120" height="25" align="center" bgcolor="#ECEDEF">����</td>
                                  <td align="center" bgcolor="#ECEDEF">����</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">����</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">����</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">�ش�</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">ʱ��</td>
                                </tr>
								<%
									//String lanmu ="��ش�����";
									wenti wt_zuixin = null;
									String date_zuixin = null;
									String color1 = "#ECEDEF";
									String color2 = "#FFFFFF"; 
									String color = "";
									List wenti_zuixin = iwenba.getProQuestion0ans(end_no,begin_no,Pro,key,classid);
									for(int i=0;i<wenti_zuixin.size();i++){
										if(i%2==0){
											color = color2;
										}else{
											color = color1;
										}
										wt_zuixin = (wenti)wenti_zuixin.get(i);
										date_zuixin = wt_zuixin.getCreatedate().toString();
                    					int posi = date_zuixin.indexOf(" ");
                    					date_zuixin = date_zuixin.substring(0, posi);
                    					String titles = wt_zuixin.getTitles().trim();  
				                    	String str;
				                    	if(titles.length()>18) {
				                    		str = titles.substring(0,18) + "...";
				                    	}else{
				                    		str = titles;
				                   		}                     
								%>
                                <tr>
                                  <td height="25" align="left" bgcolor="<%= color%>">&nbsp;&nbsp;[<%= wt_zuixin.getCname()%>]</td>
                                  <td align="left" bgcolor="<%= color%>">
                                  	<a href="/wenba/wenba_finsh.jsp?cid=<%= wt_zuixin.getColumnid()%>&id=<%= wt_zuixin.getId()%>&fenlei=<%= linghuida%> ">&nbsp;&nbsp;<%= str%></a>&nbsp;&nbsp;
                                  	<%if(wt_zuixin.getFilepath()!=null){ %>
                        			<a href="javascript:xiazai()">����</a>
                        			<%} %>
                                  </td>
                                  <script type="text/JavaScript">
			                      	function xiazai(){
			                      		var types = <%= userType%>;
			                      		var xuanshang = <%= P_jifeng%>;
			                      		//var name = <%=userName%>;
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
					                      			var url = "/wenba/download.jsp?filepath=<%= wt_zuixin.getFilepath()%>&qid=<%=wt_zuixin.getId()%>&username=<%= userName%>";
					                      			window.location.href=url; 
					                      		}else{}          
				                      		}
				                     }
				                  </script>          
                                  <td align="center" bgcolor="<%= color%>"><%= wt_zuixin.getProvince()%></td>
                                  <td align="center" bgcolor="<%= color%>"><%= wt_zuixin.getXuanshang()%></td>
                                  <td align="center" bgcolor="<%= color%>"><%= wt_zuixin.getAnwsernum()%></td>
                                  <td align="center" bgcolor="<%= color%>">[<%= date_zuixin%>]</td>
                                </tr>
                                <%
                                	}if(wt_zuixin==null){
                                %>
                                <tr>
		                          <td height="25" colspan="5" align="center">�Բ���û�������ҵ���������������Ը���������������������</td>
		                          <td align="center"></td>
		                        </tr>
		                        <%} %>
                            </table></td>
                          </tr>
                          <tr>
                            <td height="40" align="right" valign="bottom">
                              <%if(intPageCount>1){ %>	
                            	<!-- ��<%= intPageCount%>ҳ -->
                            	<%if (intPage > 1) {%>
                            	<a href="wenba_diqu0ans.jsp?page=<%=intPage - 1%>&cid=<%=classid%>&pro=<%= Pro%>"><img src="/images/wenba_woyaoda_r9_c12.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;
                            	<%} %>
	                    		<a href="wenba_diqu0ans.jsp?page=1&cid=<%=classid%>&pro=<%= Pro%>">��ҳ</a>
	                    		<%if (intPage > 1) {%>
	                    		<a href="wenba_diqu0ans.jsp?page=<%=intPage - 1%>&cid=<%=classid%>&pro=<%= Pro%>">��һҳ</a><%}%>
	                    		<%if (intPage < intPageCount) {%>
	                    		<a href="wenba_diqu0ans.jsp?page=<%=intPage + 1%>&cid=<%=classid%>&pro=<%= Pro%>">��һҳ</a><%}%>
	                            <a href="wenba_diqu0ans.jsp?page=<%=intPageCount%>&cid=<%=classid%>&pro=<%= Pro%>">βҳ</a>&nbsp;
								<%if (intPage < intPageCount) {%>
								<a href="wenba_diqu0ans.jsp?page=<%=intPage + 1%>&cid=<%=classid%>&pro=<%= Pro%>"><img src="/images/wenba_woyaoda_r9_c14.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;&nbsp;
								<%} %>
							  <%} %>
							</td>
                          </tr>
                      </table></td>
                    </tr>
                </table></td>
                <td width="9" valign="top" background="/images/wenba_woyaoda_r7_c8.jpg"><img src="/images/bai.gif" width="9" height="1" /></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td valign="top"><img src="/images/wenba_woyaoda_r8_c2.jpg" width="761" height="18" /></td>
        </tr>
      </table>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="761" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="45" background="/images/wenba_woyaowen_r2_c2.jpg"><table width="97%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td class="blackc12c"><img src="/images/wen_ba_r26_c22.jpg" width="7" height="11" align="absmiddle" />&nbsp;��������</td>
                <td align="right"><a href="#">&gt;&gt;&nbsp;����</a></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="8" valign="top" background="/images/wenba_woyaowen_r3_c2.jpg"><img src="/images/bai.gif" width="8" height="1" /></td>
                <td valign="top"><form name="form1" method="post" enctype="multipart/form-data">
			  <input type="hidden" name="types" value="<%= types%>" />
			  <input type="hidden" name="CLLUMNIDS" value="<%= CID%>"/>
			  <input type="hidden" name="Xuanshang" value="10"/>
			  <input type="hidden" name="userName" value="<%= userName%>" />
			  <input type="hidden" name="userId" value="<%= userID%>" />
			  <table width="560" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="90" height="25">��&nbsp;&nbsp;�⣺</td>
                  <td><input type="text" name="titles" style="font-size:12px;color:#000000;width: 450px;border:#d1d1d1 1px solid;" value="������6��30����֮�䣬����Խ��ϸ���ش�Խ׼ȷ��" onFocus="if (value =='������6��30����֮�䣬����Խ��ϸ���ش�Խ׼ȷ��'){value =''}"/></td>
                </tr>
                <tr>
                  <td valign="top">��&nbsp;&nbsp;�ݣ�</td>
                  <td class="unnamed1"><textarea name="Question" rows="8" style="font-size:12px;color:#000000;width: 450px;border:#d1d1d1 1px solid;"></textarea><br/>���ʿ�����2000�����ڣ�����Խ��ϸ���ش�Խ׼ȷ�� <br/>
                    <input type="file" id="tplFile" name="tplFile"  style="font-size:12px;color:#000000;width: 200px;border:#d1d1d1 1px solid;" /> ͼƬ����С��1M,JPG��GIF��ʽ</td>
                </tr>
                <tr>
                  <td valign="top"></td>
                  <td class="unnamed1">
                    <input type="file" id="tplFile1" name="tplFile1"  style="font-size:12px;color:#000000;width: 200px;border:#d1d1d1 1px solid;" /> �ϴ��ļ���txt��doc��ʽ
                  </td>
                </tr>
                <tr>
                  <td height="25">������ࣺ</td>
                  <td><select name="fenlei" style="font-size:12px;color:#000000;width: 120px;border:#d1d1d1 1px solid;" >
                  		<option value="">--��ѡ�����--</option>
                  	  	<%
							for(int i=0;i<list.size();i++){
							firstcolumn = (wenbaImpl)list.get(i);
							StringBuffer values = new StringBuffer();
							values.append(firstcolumn.getCName().toString()).append(",").append(String.valueOf(firstcolumn.getID()));
					  	%>
						<option value="<%= values%>"><%=StringUtil.gb2iso4View(firstcolumn.getCName())%></option>
						<%
							}
						%>
					  </select>				  </td>
                </tr>
                <tr>
                  <td height="25">����������</td>
                  <td><select id="Select1" name="Select1"  onchange="selectProvince()" style="font-size:12px;color:#000000;width: 120px;border:#d1d1d1 1px solid;" >
                  </select>
                    ʡ
                    <select id="Select2" name="Select2" onChange="selectArea()" style="font-size:12px;color:#000000;width: 120px;border:#d1d1d1 1px solid;" >
                    </select>
                    ��
                    <select id="Select3" name="Select3" style="font-size:12px;color:#000000;width: 120px;border:#d1d1d1 1px solid;" >
                    </select>
                    ��</td>
                </tr>
                <tr>
                  <td valign="top">�����ַ��</td>
                  <td class="unnamed">
                    <input type="text" name="emails" style="font-size:12px;color:#000000;width: 120px;border:#d1d1d1 1px solid;" />
                    <br />
                    <span class="black12a">����ȷ���������ַ���ش𽫷����������䣬200������</span><br />
                    <input type="checkbox" name="Emailnotify" onClick="checkemail()"/>
                    <span class="unnamed1">�����˻ش�����ʱ��ͨ��������֪ͨ��</span><br/></td>
                </tr>
				
                <tr>
                  <td height="30" colspan="2" valign="top">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
						<td width="90" height="30">�������ͣ�</td>
						<td align="left" valign="middle" class="unnamed1">
						  <input type="radio" name="xstw" value="radiobutton" onClick="pttw()"/>��ͨ����
						  <input type="radio" name="xstw" value="radiobutton" onClick="tiwenleixing()" />��������
						  </td>
					  </tr>
					</table>				  </td>
                </tr>
                <tr>
                  <td colspan="2" valign="top">
				    <div id="twxs" style="display:none;">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
						  <td width="90" valign="middle">�� �� �֣�</td>
						  <td class="unnamed1"><select name="xsjf">
								<option value="0">��ѡ��</option>
								<option value="5">+5</option>
								<option value="10">+10</option>
								<option value="15">+15</option>
								<option value="20">+20</option>
							  </select> 
						  + ϵͳĬ�����ͷ�10�֡��������ͷ�Խ�߻�ûش�ļ���Խ��
						  </td>
						  <td></td>
					  </tr>
                    </table>
					</div>
				  </td>
                </tr>
                <tr>
                  <td height="40" valign="middle">�� ֤ �룺</td>
                  <td valign="bottom" class="unnamed"><span class="unnamed1">
                    <input name="Codes" type="text" style="font-size:12px;color:#000000;width: 120px;border:#d1d1d1 1px solid;" />
                    <img name="cod" src="valid.jsp" width="100" height="21" align="absmiddle" /></span><a href="#" onClick="shuaxin()">����������ٻ�һ��</a><br/>
                    <span class="black12a">��������ͼ�е���֤�룬�ַ������ִ�Сд��</span></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td height="40">
                  <a href="javascript:check()"><img src="/images/wenba_woyaowen_r6_c4.jpg" width="60" height="19" border="0" align="absmiddle" /></a></td>
                </tr>
              </table>
			  </form></td>
                <td width="10" valign="top" background="/images/wenba_woyaowen_r3_c4.jpg"><img src="/images/bai.gif" width="10" height="1" /></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td valign="top"><img src="/images/wenba_woyaowen_r4_c2.jpg" width="761" height="30" /></td>
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
          <td height="24" background="/images/wen_ba_r30_c34.jpg">&nbsp;<a href="#" class="blackc12c">�����������а�</a></td>
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
                <td><a href="/wenba/wenba_finsh.jsp?id=<%= wtw.getId()%>&fenlei=<%= names%>"><%= str%></a></td>
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
          <td height="24" background="/images/wen_ba_r30_c34.jpg"><a href="#" class="blackc12">&nbsp;</a><a href="#" class="blackc12c">���ܻ������а�</a></td>
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
                  <td><a href="/wenba/wenba_finsh.jsp?id=<%= wtx.getId()%>&fenlei=<%= namex%>"><%= str%></a></td>
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


