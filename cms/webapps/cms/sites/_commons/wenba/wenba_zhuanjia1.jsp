<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,java.sql.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
	User user = (User)session.getAttribute("user");
	int userType = 1;
	String userName = "";
	String userID ="";
	if(user==null){
		userType = 0;
	}else{
		userName = (String)user.getUsername();
		userID = String.valueOf(user.getUserid());
	}
	IWenbaManager iwenba = wenbaManagerImpl.getInstance();
	wenbaImpl firstcolumn = null;
	List list = iwenba.getCname();
	int classid = ParamUtil.getIntParameter(request,"cid",24);
	String CID = (String)request.getParameter("cid");
	String Pro = (String)request.getParameter("pro");
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
	List top10_wenti = iwenba.getTop10Questions(classid,0);
    List top10_wenti_jiejue= iwenba.getTop10Questions(classid,1);
    List top10_wenti_0anwser = iwenba.getTop10Questions0Answer(classid); 
    String types = "zhuanjia";
%>
<%
	//�ж��û��Ƿ����ʰ�ר��
	List userlist = null;//�û�ID
	List wlist = null;//�ܴ�����
	List mlist = null;//�´�����
	List mlist_b = null;//����Ѵ�����
	userlist = iwenba.getUserIDList();//��ѯ���в���ר�ҵ��û�USERID
	for(int t=0;t<userlist.size();t++){
		wlist = iwenba.getUserAnwNum2(userlist.get(t).toString());
		mlist = iwenba.getUserNum_month(userlist.get(t).toString());
		mlist_b = iwenba.getUserNum_month_Status(userlist.get(t).toString());
		if(mlist.size()>0){
			double caina = (double)mlist_b.size()/(double)mlist.size();
			double cc = 0.2;		
			if(wlist.size() > 5 && caina > cc){
				iwenba.changeUserinfo(userlist.get(t).toString()); //�������������û�����Ϊ�ʰ�ר��
			}
		}
	}
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
	    List pagelist = iwenba.getConPage(0,classid);
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
<title>ר&nbsp;&nbsp; ��</title>
<link href="/images/css.css" rel="stylesheet" type="text/css" />
<link href="/webbuilder/sites/www_fawu_com/images/hr-low.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">
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
	var url = "wenba_diqu.jsp?cid=<%=classid%>&pro=<%= Pro%>";
	window.location.href=url;
}

function wenti_jiejue_change(){
	var url = "wenba_diqujj.jsp?cid=<%=classid%>&pro=<%= Pro%>";
	window.location.href=url;
}
function wenti_ans_change(){
	var url = "wenba_diqu0ans.jsp?cid=<%=classid%>&pro=<%= Pro%>";
	window.location.href=url;
}
function wenti(){
	window.open("/wenba/wenba_woyaowen.jsp?cid=<%= classid%>");
}

function sousuo_fenlei(){
	var fenleiID = document.getElementById("select_fenlei").value; 
	var keys = document.getElementById("sousuo_key").value;
	var url ="wenba_leibiao.jsp?cid=" +fenleiID +"&keys=" + keys;
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
	pOption.value = "1";
	pOption.text = "--��ѡ��--";
	dropElement1.add(pOption);
	
	var cOption = document.createElement("option");
	cOption.value = "1";
	cOption.text = "--��ѡ��--";
	dropElement2.add(cOption);
	
	var aOption = document.createElement("option");
	aOption.value = "1";
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
	cOption.value = "1";
	cOption.text = "--��ѡ��--";
	dropElement2.add(cOption);
	
	var aOption = document.createElement("option");
	aOption.value = "1";
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
	aOption.value = "1";
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
<table width="982" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="225"><img src="/images/wenba_r4_c2.jpg" width="225" height="27" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/wenba_difang.jsp?cid=<%=classid%>&pro=����" class="bai">�ط��ʴ�</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/wenba_leibiao.jsp?cid=<%= classid%>&keys="" " class="bai">�����������</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/wenba_leibiao1.jsp?cid=<%= classid%>&keys="" " class="bai">���½������</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/wenba_leibiao0a.jsp?cid=<%= classid%>&keys="" " class="bai">��ش�����</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r6_c5.jpg" width="4" height="7" align="absmiddle" />&nbsp;<a href="/wenba/wenba_zhuanjia.jsp?cid=<%=classid%>" class="bai">ר�ҽ���</a></td>
    <td width="192"><img src="/images/wenba_r4_c6.jpg" width="192" height="27" /></td>
  </tr>
</table>
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
                        <td><input type="image" src="/images/wen_ba_r2_c2.jpg" width="38" height="38"/></td>
                        <td>11111111111</td>
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
                          <td><img src="/images/wen_ba_r5_c8.jpg" width="60" height="38" border="0" align="absmiddle" /></td>
                          <td>2222222222</td>
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
                            <td height="25" class="blackc12c">&nbsp;<a href="#">ר�ҽ���</a></td>
                          </tr>
                          <tr>
                            <td><img src="/images/wen_ba_r6_c13.jpg" width="45" height="38" /></td>
                            <td>333333333</td>
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
          <td valign="top"><img src="/images/wenba_wentifenlei_r2_c2.jpg" width="763" height="6" /></td>
        </tr>
        <tr>
          <td valign="top" background="/images/wenba_wentifenlei_r4_c234.jpg"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/bai.gif" width="1" height="5" /></td>
              </tr>
            </table>
              <table width="740" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="25" class="blackc12c">&nbsp;<img src="/images/wenba_wentifenlei_r4_c4.jpg" width="7" height="11" align="absmiddle" />&nbsp;ר����</td>
                </tr>
                <tr>
                  <td><img src="/images/wenba_wentifenlei_r4_c3.jpg" width="740" height="2" /></td>
                </tr>
                <tr>
                  <td valign="top"><table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td><img src="/images/bai.gif" width="1" height="15" /></td>
                      </tr>
                    </table>
                      <table width="730" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="175" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="72"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian">
                                  <tr>
                                    <td><img src="/images/zhuanjiajieyi_r2ddd_c2.jpg" width="66" height="88" hspace="2" vspace="2" border="0" /></td>
                                  </tr>
                              </table></td>
                              <td width="5" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
							  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <%
                                	List list_zhuanjia;
                                	list_zhuanjia = iwenba.getzhuangjian();
                                	User us = null;
                                	String retstr = null;
                                	int retstr1 = 0;
                                	if(list_zhuanjia.size()>0){                               		
                           				us = (User)list_zhuanjia.get(0);
                           				int user_id = us.getUserid();
                           				retstr1 = us.getIsvip();	
                           				//out.print(retstr1);	
                           				if(retstr1>1&&retstr1<=300){
							            	retstr = "HRѧԱ";
							            }	
							            if(retstr1>300&&retstr1<=600){
							            	retstr = "HR����";
							            }  
							            if(retstr1>600&&retstr1<=1000){
							            	retstr = "HRרԱ";
							            }
							            if(retstr1>1000&&retstr1<=1500){
							            	retstr = "HR����";
							            }
							            if(retstr1>1500&&retstr1<=2000){
							            	retstr = "HR����";
							            }
							            if(retstr1>2000&&retstr1<=2500){
							            	retstr = "HR�߼�����";
							            }
							            if(retstr1>2500){
							            	retstr = "HR�ܼ�";
							            }
                                 %>               
                                <tr>
                                  <td height="20" class="black12"><%= us.getUsername()%></td>
                                </tr>
                                <tr>
                                  <td class="unnamed">ͷ�Σ�<%= retstr%></td>
                                </tr>      
                                <tr>
                                  <td class="unnamed">���֣�<%= us.getUsergrade()%></td>
                                </tr>
                                <tr>
                                  <td height="20"><a href="/wenba/aaaaa.jsp?userid=<%= user_id%>&cid=<%= CID%>" class="hei">���鿴���顿</a></td>
                                </tr>
                                <%}else{%> 
                                <tr>
                                  <td height="20" class="black12">Ŀǰ��û��ר��</td>
                                </tr> 	
                                <tr>
                                  <td class="unnamed">�޻��ֵȼ�</td>
                                </tr>
                                <tr>
                                  <td height="20"><a href="#" class="hei">���鿴���顿</a></td>
                                </tr>    	
                                <%}%> 
                              </table></td>
                            </tr>
                          </table></td>
                          <td width="10" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
                          <td width="175" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="72"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian">
                                  <tr>
                                    <td><img src="/images/zhuanjiajieyi_r2_c2.jpg" width="66" height="88" hspace="2" vspace="2" border="0" /></td>
                                  </tr>
                              </table></td>
                              <td width="5" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
                              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <%
                                  	if(list_zhuanjia.size()>1){
                                  		us = (User)list_zhuanjia.get(1);
                                  		int user_id = us.getUserid();
                                  		retstr1 = us.getIsvip();		
                           				if(retstr1>1&&retstr1<=300){
							            	retstr = "HRѧԱ";
							            }	
							            if(retstr1>300&&retstr1<=600){
							            	retstr = "HR����";
							            }  
							            if(retstr1>600&&retstr1<=1000){
							            	retstr = "HRרԱ";
							            }
							            if(retstr1>1000&&retstr1<=1500){
							            	retstr = "HR����";
							            }
							            if(retstr1>1500&&retstr1<=2000){
							            	retstr = "HR����";
							            }
							            if(retstr1>2000&&retstr1<=2500){
							            	retstr = "HR�߼�����";
							            }
							            if(retstr1>2500){
							            	retstr = "HR�ܼ�";
							            }
                                  %>
                                  <tr>
                                    <td height="20" class="black12"><%= us.getUsername()%></td>
                                  </tr> 
                                  <tr>
                                    <td class="unnamed">ͷ�Σ�<%= retstr%></td>
                                  </tr>         
                                  <tr>
                                    <td class="unnamed">���֣�<%= us.getUsergrade()%></td>
                                  </tr>
                                  <tr>
                                    <td height="20"><a href="/wenba/aaaaa.jsp?userid=<%= user_id%>&cid=<%= CID%>" class="hei">���鿴���顿</a></td>
                                  </tr>
                                  <%}else{%> 
                                  <tr>
                                    <td height="20" class="black12">Ŀǰ��û��ר��</td>
                                  </tr> 	
                                  <tr>
                                    <td class="unnamed">�޻��ֵȼ�</td>
                                  </tr>
                                  <tr>
                                    <td height="20"><a href="#" class="hei">���鿴���顿</a></td>
                                  </tr>    	
                                  <%}%> 
                              </table></td>
                            </tr>
                          </table></td>
						  <td width="10" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
                          <td width="175" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="72"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian">
                                  <tr>
                                    <td><img src="/images/zhuanjiajieyi_r2_c2.jpg" width="66" height="88" hspace="2" vspace="2" border="0" /></td>
                                  </tr>
                              </table></td>
                              <td width="5" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
                              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <%
                                  	if(list_zhuanjia.size()>2){
                                  		us = (User)list_zhuanjia.get(2);
                                  		retstr1 = us.getIsvip();		
                           				if(retstr1>1&&retstr1<=300){
							            	retstr = "HRѧԱ";
							            }	
							            if(retstr1>300&&retstr1<=600){
							            	retstr = "HR����";
							            }  
							            if(retstr1>600&&retstr1<=1000){
							            	retstr = "HRרԱ";
							            }
							            if(retstr1>1000&&retstr1<=1500){
							            	retstr = "HR����";
							            }
							            if(retstr1>1500&&retstr1<=2000){
							            	retstr = "HR����";
							            }
							            if(retstr1>2000&&retstr1<=2500){
							            	retstr = "HR�߼�����";
							            }
							            if(retstr1>2500){
							            	retstr = "HR�ܼ�";
							            }
                                  %>
                                  <tr>
                                    <td height="20" class="black12"><%= us.getUsername()%></td>
                                  </tr>  
                                  <tr>
                                    <td class="unnamed">ͷ�Σ�<%= retstr%></td>
                                  </tr>	
                                  <tr>
                                    <td class="unnamed">���֣�<%= us.getUsergrade()%></td>
                                  </tr>
                                  <tr>
                                    <td height="20"><a href="#" class="hei">���鿴���顿</a></td>
                                  </tr>
                                  <%}else{%> 
                                  <tr>
                                    <td height="20" class="black12">Ŀǰ��û��ר��</td>
                                  </tr> 	
                                  <tr>
                                    <td class="unnamed">�޻��ֵȼ�</td>
                                  </tr>
                                  <tr>
                                    <td height="20"><a href="#" class="hei">���鿴���顿</a></td>
                                  </tr>    	
                                  <%}%> 
                              </table></td>
                            </tr>
                          </table></td>
						  <td  width="10"valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
                          <td width="175" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="72"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="huibian">
                                  <tr>
                                    <td><img src="/images/zhuanjiajieyi_r2_c2.jpg" width="66" height="88" hspace="2" vspace="2" border="0" /></td>
                                  </tr>
                              </table></td>
                              <td width="5" valign="top"><img src="/images/bai.gif" width="10" height="1" /></td>
                              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <%
                                  	if(list_zhuanjia.size()>3){
                                  		us = (User)list_zhuanjia.get(3);
                                  		retstr1 = us.getIsvip();		
                           				if(retstr1>1&&retstr1<=300){
							            	retstr = "HRѧԱ";
							            }	
							            if(retstr1>300&&retstr1<=600){
							            	retstr = "HR����";
							            }  
							            if(retstr1>600&&retstr1<=1000){
							            	retstr = "HRרԱ";
							            }
							            if(retstr1>1000&&retstr1<=1500){
							            	retstr = "HR����";
							            }
							            if(retstr1>1500&&retstr1<=2000){
							            	retstr = "HR����";
							            }
							            if(retstr1>2000&&retstr1<=2500){
							            	retstr = "HR�߼�����";
							            }
							            if(retstr1>2500){
							            	retstr = "HR�ܼ�";
							            }
                                  %>
                                  <tr>
                                    <td height="20" class="black12"><%= us.getUsername()%></td>
                                  </tr>
                                  <tr>
                                    <td class="unnamed">ͷ�Σ�<%= retstr%></td>
                                  </tr>
                                  <tr>
                                    <td class="unnamed">���֣�<%= us.getUsergrade()%></td>
                                  </tr>
                                  <tr>
                                    <td height="20"><a href="#" class="hei">���鿴���顿</a></td>
                                  </tr>
                                  <%}else{%> 
                                  <tr>
                                    <td height="20" class="black12">Ŀǰ��û��ר��</td>
                                  </tr> 	
                                  <tr>
                                    <td class="unnamed">�޻��ֵȼ�</td>
                                  </tr>
                                  <tr>
                                    <td height="20"><a href="#" class="hei">���鿴���顿</a></td>
                                  </tr>    	
                                  <%}%> 
                              </table></td>
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
              </table>
            <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td><img src="/images/bai.gif" width="1" height="5" /></td>
                </tr>
            </table></td>
        </tr>
        <tr>
          <td valign="top"><img src="/images/wenba_wentifenlei_r4_c2.jpg" width="763" height="7" /></td>
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
                    <input name="sousuo_key" type="text" style="font-size:12px;color:#000000;width: 170px;border:#d1d1d1 1px solid;" value=" �������ѯ�ؼ���" />
&nbsp;              <a href="javascript:sousuo_fenlei()" ><img src="/images/wenba_woyaoda_r3_c5.jpg" width="58" height="19" border="0" align="absmiddle" /></a></span></td>
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
                            <td width="248" height="30" align="center" background="/images/wenba_woyaoda_r7_c5.jpg" class="blackc12c"><a href="#">�����������</a></td>
                            <td align="center"><img src="/images/bai.gif" width="1" height="1" /></td>
                            <td width="248" align="center" background="/images/wenba_woyaoda_r7_c7.jpg" class="blackc12c"><a href="#">�ѽ��������</a></td>
                            <td align="center"><img src="/images/bai.gif" width="1" height="1" /></td>
                            <td width="247" align="center" background="/images/wenba_woyaoda_r7_c10.jpg" class="blackc12c"><a href="#">��ش������</a></td>
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
		                    		List wenti_zuixin = iwenba.getQuestions(end_no,begin_no, 0,classid);
		                    		wenti wtz = null;
		                    		String date_str_zuixin = null;
		                    		String name_zuixin = "�����������";
		                    		String color1 = "#ECEDEF";
									String color2 = "#FFFFFF"; 
									String color = "";
		                    		for (int i = 0; i < wenti_zuixin.size(); i++) {
		                    			if(i%2==0){
											color = color2;
										}else{
											color = color1;
										}
		                    			wtz = (wenti) wenti_zuixin.get(i);
		                    			date_str_zuixin = wtz.getCreatedate().toString();
		                    			int posi = date_str_zuixin.indexOf(" ");
		                    			date_str_zuixin = date_str_zuixin.substring(0, posi);
		                    			String titles = wtz.getTitles().trim();  
                    					String str;
                    						if(titles.length()>20) {
                    					str = titles.substring(0,20) + "...";
                    					}else{
                    						str = titles;
                    					}           
	                    			
	                    		%>
		                        <tr>
		                          <td height="25" align="left" bgcolor="<%= color%>">&nbsp;&nbsp;[<%= wtz.getCname()%>]</td>
		                          <td align="left" bgcolor="<%= color%>">&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wtz.getId()%>&cid=<%= wtz.getColumnid()%>&fenlei=<%= name_zuixin%>"><%= str%></a></td>
		                          <td align="center" bgcolor="<%= color%>"><%= wtz.getProvince()%></td>
		                          <td align="center" bgcolor="<%= color%>"><%= wtz.getXuanshang()%>��</td>
		                          <td align="center" bgcolor="<%= color%>"><%= wtz.getAnwsernum()%></td>
		                          <td align="center" bgcolor="<%= color%>">[<%= date_str_zuixin%>]</td>
		                        </tr>
		                        <%} %>
                            </table></td>
                          </tr>
                          <tr>
                            <td height="40" align="right" valign="bottom">
                            	<%if (intPage > 1) {%>
                            	<a href="wenba_zhuanjia.jsp?page=<%=intPage - 1%>&cid=<%=classid%>"><img src="/images/wenba_woyaoda_r9_c12.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;
                            	<%} %>
                            	<!-- ��<%= intPageCount%>ҳ -->
	                    		<a href="wenba_zhuanjia.jsp?page=1&cid=<%=classid%>&pro=<%= Pro%>">��ҳ</a>
	                    		<%if (intPage > 1) {%>
	                    		<a href="wenba_zhuanjia.jsp?page=<%=intPage - 1%>&cid=<%=classid%>">��һҳ</a><%}%>
	                    		<%if (intPage < intPageCount) {%>
	                    		<a href="wenba_zhuanjia.jsp?page=<%=intPage + 1%>&cid=<%=classid%>">��һҳ</a><%}%>
	                            <a href="wenba_zhuanjia.jsp?page=<%=intPageCount%>&cid=<%=classid%>">βҳ</a>	 &nbsp;
								<%if (intPage < intPageCount) {%>
								<a href="wenba_zhuanjia.jsp?page=<%=intPage + 1%>&cid=<%=classid%>"><img src="/images/wenba_woyaoda_r9_c14.jpg" width="4" height="7" border="0" align="absmiddle" /></a>&nbsp;&nbsp;
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
                  <td><a href="/wenba/wenba_finsh.jsp?id=<%= wtx.getId()%>&fenlei=<%= namex%>"><%=str%></a></td>
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
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="/images/zhuce1_r19_c2.jpg" width="1000" height="3" /></td>
  </tr>
  <tr>
    <td height="25" align="center" class="black12"><a href="#" class="lan">��������&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;��ϵ����</a><a href="#" class="lan">&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">Ϊ������&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">HR&nbsp;��&nbsp;��&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">������ǲ&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">���Ͷ��&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">������ѯ&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">��վ��ͼ</a><a href="#" class="lan">&nbsp;&nbsp;</a>-<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">��������</a></td>
  </tr>
  <tr>
    <td><img src="/images/bai.gif" width="1" height="10" /></td>
  </tr>
  <tr>
    <td height="20" align="center">�й��Ͷ���������Ȩ����<a href="#" class="lan">&nbsp;&nbsp;</a><a href="#" class="lan">&nbsp;&nbsp;</a>��ICP��000000��</td>
  </tr>
  <tr>
    <td height="20" align="center">Copyright @ 2008-2010 Dreamstime.all right reserved. </td>
  </tr>
</table>
</body>
</html>
