<%@ page language="java" import="java.util.*,com.bizwink.wenba.*,com.bizwink.util.*,com.bizwink.user.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%@ page  import="java.text.*"%>
<%
User user = (User)session.getAttribute("user");
	String username = null;
	int loginid = 0;
	int userType = 1;
	if(user==null){
		userType = 0;
		//
	}else{
		username = user.getUsername();
		loginid = user.getUserid();
	}
	IWenbaManager iwenba = wenbaManagerImpl.getInstance();
	//wenbaImpl firstcolumn = null;
	//List list = iwenba.getCname();
	int classid = ParamUtil.getIntParameter(request,"cid",0);
	String CID = (String)request.getParameter("cid");
	List top8_wenti = iwenba.getTop8QuestionsWenti(classid);
	List top8_wenti_xuanshang = iwenba.getTop8QuestionsXuanshang(classid);
	String userid = request.getParameter("userid")==null?"0":request.getParameter("userid");
    
    //List zhuanjialist = iwenba.getzhuangjian();
    User zhuanjiauser = iwenba.getzhuanjiiainfo(Integer.parseInt(userid));
    List questionlist = iwenba.getquestion(Integer.parseInt(userid));
    
    String imgname = request.getParameter("imgname")==null?"0.jpg":request.getParameter("imgname");
    
    List dianjilist = iwenba.getTOP8DianJiShu(classid);
    List gradelist = iwenba.getTop8weekgrade();
    
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>ר&nbsp;&nbsp; ��</title>
<link href="/images/css.css" rel="stylesheet" type="text/css" />
<link href="/webbuilder/sites/www_fawu_com/images/hr-low.css" rel="stylesheet" type="text/css" />
<script language="javascript">  
 var   img=null;  
  function   changeimg()  
	 {  
	 	document.form1.tijiaoflag.value=0;
	     if(img)img.removeNode(true);  
	     img=document.createElement("img");  
	     img.style.position="absolute";  
	     img.style.visibility="hidden";  
	     img.attachEvent("onreadystatechange",orsc);  
	     img.attachEvent("onerror",oe);  
	     document.body.insertAdjacentElement("beforeend",img);  
	     img.src=document.form1.tplFile.value;  
	 }  
	 function   oe()  
	 {  
	     alert("�ϴ�ͼƬ����Ϊ:GIF��JPEG/JPG��BMP"); 
	     document.form1.tijiaoflag.value=1;
	     return false; 
	 }  
	 function   orsc()  
	 {  
	    if(img.readyState!="complete"){
	    	document.form1.tijiaoflag.value=1;
	    	return   false;
	    }else{
	   		if(img.fileSize>500*1024){
	   			alert('�ϴ�ͼƬ����500k');
	   			//document.form1.tijiaoflag.value=1;
	   			return false;
	   		}
	   }  
	 }  
 </script>

<script type="text/JavaScript">
function checkZXTW(){
	document.getElementById("ZXTWflag").background = "/images/wenba_woyaoda_r7_c5.jpg";
	document.getElementById("YJJflag").background = "/images/wenba_woyaoda_r7_c7.jpg";
	document.getElementById("LHDflag").background = "/images/wenba_woyaoda_r7_c7.jpg";
	document.getElementById("ZXTW").style.display = "";
	document.getElementById("YJJ").style.display = "none";
	document.getElementById("LHD").style.display = "none";
}
function checkYJJ(){
	document.getElementById("ZXTWflag").background = "/images/wenba_woyaoda_r7_c7.jpg";
	document.getElementById("YJJflag").background = "/images/wenba_woyaoda_r7_c5.jpg";
	document.getElementById("LHDflag").background = "/images/wenba_woyaoda_r7_c7.jpg";
	document.getElementById("ZXTW").style.display = "none";
	document.getElementById("YJJ").style.display = "";
	document.getElementById("LHD").style.display = "none";
}
function checkLHD(){
	document.getElementById("ZXTWflag").background = "/images/wenba_woyaoda_r7_c7.jpg";
	document.getElementById("YJJflag").background = "/images/wenba_woyaoda_r7_c7.jpg";
	document.getElementById("LHDflag").background = "/images/wenba_woyaoda_r7_c5.jpg";
	document.getElementById("ZXTW").style.display = "none";
	document.getElementById("YJJ").style.display = "none";
	document.getElementById("LHD").style.display = "";
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
function showZXbut(){
	var loginid = <%=loginid%>;
	var userid =<%=userid%>;
	if(loginid==userid){
		document.getElementById("editinfo").style.display = "";
		document.getElementById("uploadimg").style.display = "";
	}else{
		document.getElementById("editinfo").style.display = "none";
		document.getElementById("uploadimg").style.display = "none";
	}
}

function editjianjie(){
	document.form1.textarea1.readOnly = false;
	document.form1.textarea1.focus();
	
	document.getElementById("info2").style.display = "";
}
function imgup(){
	document.getElementById("showupimg").style.display = "";
}
function savejianjie(){
	var userid = <%=userid%>;
	var introduct = document.getElementById("textarea1").value;
	document.form1.action = "saveintroduct.jsp?userid="+userid+"&cid=<%=CID%>&introduct="+introduct+"&imgname=<%=imgname%>";
	document.form1.submit();
}
function check(){
	if(document.all.tplFile.value!=""){
		var filename = document.all.tplFile.value;		
		var pos = filename.lastIndexOf(".");	
		var lastname = filename.substring(pos+1,filename.length);
		//alert(lastname);
		if(lastname.toLowerCase()!="jpg"&&lastname.toLowerCase()!="gif"){
			alert("ͼƬ���Ͳ���!ͼƬ��ʽΪJPG��GIF��ʽ");
			return false;
		}
	}
	if(document.form1.tijiaoflag.value==1){
		alert('�ϴ�ͼƬ������');
		return false;
	}
	document.getElementById("showupimg").style.display = "none";
	document.all.form1.action = "uploaddo.jsp?userid="+<%=loginid%>;
	document.all.form1.submit();
}
</script>

</head>
<body onload="showZXbut()">
<form name="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="tijiaoflag" value="0">
<%@ include file="/include/laodongtop.shtml" %>
<table width="982" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="225"><img src="/images/wenba_r4_c2.jpg" width="225" height="27" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/wenba_difang.jsp?cid=<%= classid%>&pro=����" class="bai">�ط��ʴ�</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/doZXTW.jsp " class="bai">�����������</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/doYJJ.jsp " class="bai">���½������</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><a href="/wenba/doLHD.jsp " class="bai">��ش�����</a></td>
    <td width="1" align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r5_c5.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="/images/wenba_r4_c3.jpg"><img src="/images/wenba_r6_c5.jpg" width="4" height="7" align="absmiddle" />&nbsp;<a href="/wenba/dozhuanjia.jsp" class="bai">������</a></td>
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
    <td valign="top"><%@ include file="/include/wenbaZJL.jsp"%>
      <table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="/images/bai.gif" width="1" height="10" /></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top"><img src="/images/wenba_wentifenlei_r2_c2.jpg" width="763" height="6" /></td>
        </tr>
        <tr><td>ר����ϸ��Ϣ</td></tr>
        <tr>
        	<td>
        		<table>
        			<%
        					int meilizhi = zhuanjiauser.getMeilizhi();
        					System.out.println("meilizhi:"+meilizhi);
        					String touxian = "";
        					if(meilizhi>1&&meilizhi<=300){
								touxian = "HRѧԱ";
							}else if(meilizhi>300&&meilizhi<=600){
							    touxian = "HR����";
							}else if(meilizhi>600&&meilizhi<=1000){
							    touxian = "HRרԱ";
							}else if(meilizhi>1000&&meilizhi<=1500){
							    touxian = "HR����";
							}else if(meilizhi>1500&&meilizhi<=2000){
							    touxian = "HR����";
							}else if(meilizhi>2000&&meilizhi<=2500){
							    touxian = "HR�߼�����";
							}else if(meilizhi>2500){
							    touxian = "HR�ܼ�";
							}
        			%>
        			<tr>
        				<td>
        					<img src="http://www.hrlaw.com.cn/wenba/images/<%=imgname %>" width="80" height="100" hspace="2" vspace="2" border="0" />
        				</td>
        				<td>
        					<table>
        						<tr><td>ר��������<%=zhuanjiauser.getUsername() %></td></tr>
        						<tr><td>ͷ�Σ�<%=touxian %></td></tr>
        						<tr><td>���֣�<%=zhuanjiauser.getUsergrade() %></td></tr>
        						<tr id="editinfo" style="display:none"><td><input type="button" name="editinfo" value="�޸ļ��" onclick="editjianjie()"/></td></tr>
        						<tr id="uploadimg" style="display:none"><td><input type="button" name="uploadimg" value="�ϴ���Ƭ" onclick="imgup()"/></td></tr>
        						<tr><td><a href="wenba_woyaowen.jsp?cid=<%=CID %>&USERID=<%=zhuanjiauser.getUserid() %>"><img src="/images/zhuanjiatiwen.gif" border="0"></a></td></tr>
        						<tr><td></td></tr>
        					</table>
        				</td>
        				<td>
        					<table>
        					<tr><td>
        						<textarea name="textarea1" id="textarea1" rows="8" style="font-size:12px;color:#000000;width: 450px;border:#d1d1d1 1px solid;" readOnly="true"><%=zhuanjiauser.getZhuanjiajianjie()==null?"�й��Ͷ������������Ա�߳�Ϊ������":zhuanjiauser.getZhuanjiajianjie() %></textarea>
        						<span id="info1"><br/>��������800�����ڡ�<br/></span>
        						<span id="info2" style="display:none"><input type="button" name="but1" value="����" onclick="savejianjie()"/></span>
        					</td></tr>
        					<tr id="showupimg" style="display:none">
        						<td>
        							<input type="file" id="tplFile" name="tplFile" onpropertychange="changeimg()"/> ͼƬ����С��500k,JPG��GIF��ʽ</td>
        						</td>
        						<td>
        							<input type="button" name="but" value="�ύ" onclick="check()"/></td>
        						</td>
        					</tr>
        					</table>
        				</td>
        			</tr>
        		</table>
        	</td>
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
          <td valign="top">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="7" valign="top" background="/images/wenba_woyaoda_r7_c2.jpg"><img src="/images/bai.gif" width="7" height="1" /></td>
                <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td valign="top" background="/images/wenba_woyaoda_r8_c5.jpg"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                                <tr>
                                  <td width="120" height="25" align="center" bgcolor="#ECEDEF">����</td>
                                  <td align="center" bgcolor="#ECEDEF">����</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">����</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">�ش�</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">ʱ��</td>
                                  <td width="80" align="center" bgcolor="#ECEDEF">����</td>
                                </tr>
                                <%
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		                    	if(questionlist.size()>0){
		                    		for(int i=0;i<questionlist.size();i++){
	                    				WenbaBean wb = (WenbaBean)questionlist.get(i);
	                    		%>
		                        <tr>
		                          <td height="25" align="left" >&nbsp;&nbsp;[<%= wb.getCname()%>]</td>
		                          <td align="left" >&nbsp;&nbsp;<a href="/wenba/wenba_finsh.jsp?id=<%= wb.getId()%>&cid=<%= wb.getColumnid()%>&fenlei=<%= wb.getCname()%>"><%=wb.getTitle()%></a></td>
		                          <td align="center" ><%= wb.getProvince()%></td>
		                          <td align="center" ><%= wb.getAnswernum()==0?"δ�ش�":"�ѻش�"%></td>
		                          <td align="center" >[<%= sdf.format(wb.getCreatedate())%>]</td>
		                          <td align="center"><%if(wb.getStatus()==0) {out.print("<img src=\"/images/cross.gif\"/>");}else{ out.print("<img src=\"/images/check.gif\"/>");}%></td>
		                        </tr>
		                        <%}}%>
                            </table></td>
                          </tr>
                          
                          
                      </table></td>
                    </tr>   
                      
                </table></td>
                <td width="9" valign="top" background="/images/wenba_woyaoda_r7_c8.jpg"><img src="/images/bai.gif" width="9" height="1" /></td>
              </tr>
          </table>
		  </td>
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
</form>
</body>
</html>
