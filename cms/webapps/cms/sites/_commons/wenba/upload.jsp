<%@ page language="java" import="java.util.*" contentType="text/html;charset=GBK"%>
<%@ page import="java.net.*" %>
<%
//String urlid = request.getParameter("urlid")==null?"0":request.getParameter("urlid");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����</title>
<link href="/images/css.css" rel="stylesheet" type="text/css"/>
<link href="/webbuilder/sites/www_fawu_com/images/hr-low.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" type="text/javascript">

function check(){
	var urlid = document.form1.urlid.value;
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
	if(document.form1.imgheight.value==""){
		alert('����дͼ��ĸ߶�');
		return false;
	}
	if(document.form1.imgwidth.value==""){
		alert('����дͼ��Ŀ��');
		return false;
	}
	if(document.form1.tijiaoflag.value==1){
		alert('�ϴ�ͼƬ������');
		return false;
	}
	document.all.form1.action = "uploaddo.jsp?urlid="+urlid+"&imgheight="+document.form1.imgheight.value+"&imgwidth="+document.form1.imgwidth.value;
	document.all.form1.submit();
}
</script>
<script   language="javascript">  
 var   img=null;  
  function   s()  
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
	   			document.form1.tijiaoflag.value=1;
	   			return false;
	   		}
	   }  
	 }  
 </script>  

</head>
<body>
<form name="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="tijiaoflag" value="0">
<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>              
                  <td class="unnamed1">
                    <input type="file" id="tplFile" name="tplFile" onpropertychange="s()"/> ͼƬ����С��500k,JPG��GIF��ʽ</td>
                </tr>
                <tr>
                	<td>
                		ͼ��߶ȣ�<input type="text" name="imgheight" value="">
                	</td>
                </tr>
                <tr>
                	<td>
                		ͼ���ȣ�<input type="text" name="imgwidth" value="">
                	</td>
                </tr>
                <tr>
                	<td><input type="button" name="but" value="�ύ" onclick="check()"/></td>
                </tr>
</table>
</form>
</body>
</html>
