<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html;charset=GBK"%>
<%@ page import="com.bizwink.wenba.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<LINK href="sites/www_gdmoa_org/images/ziti.css" type=text/css rel=stylesheet>
<title>�ޱ����ĵ�</title>
<script type="text/JavaScript">
function select_fw(){
	if(document.getElementById("fa_ss").value=="0"){
		alert("��ѡ����࣡");
		return false;
	}
	if(document.getElementById("key_w").value==""){
		alert("�����������ؼ��֣�");
		return false;
	}else{
		var key_w = document.getElementById("key_w").value;//�����ؼ���
		var fa_ss = document.getElementById("fa_ss").value;//���桢������֪ʶ�ʴ����ġ��ʰ� ID
		var fa_fl = document.getElementById("fenlei").value;//1 �Ͷ���ͬ 2���� 3��ᱣ�� 4��Ƹ��ѵ 5�Ͷ����� 6�ٲü��
		var url = "/wenba/fawusousuo/2.jsp?key_w="+key_w+"&fa_ss=" +fa_ss+"&fa_fl="+fa_fl;
		window.location.href = url;
	}
}

</script>
</head>
<BODY>
<input type="hidden" id="fenlei" name="fenlei" value="1" />
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TR>
       <TD bgColor=#2b8087 height=30>&nbsp;       
        <SELECT id="fa_ss" style="BORDER-RIGHT: #ffffff 1px solid; BORDER-TOP: #ffffff 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #ffffff 1px solid; WIDTH: 80px; COLOR: #000000; BORDER-BOTTOM: #ffffff 1px solid"  name="fa_ss"> 
	    	<OPTION value="0">��������</OPTION>
	        <OPTION value="597">����</OPTION> 
	        <OPTION value="489">����</OPTION> 
	  		<OPTION value="481">֪ʶ�ʴ�</OPTION>
	  		<OPTION value="497">����</OPTION>
	  		<OPTION value="498">�ʰ�</OPTION>
  		</SELECT> 
  		<INPUT id = "key_w"style="BORDER-RIGHT: #ffffff 1px solid; BORDER-TOP: #ffffff 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #ffffff 1px solid; WIDTH: 120px; COLOR: #000000; BORDER-BOTTOM: #ffffff 1px solid" name="key_w"/>&nbsp;&nbsp;   
  		<INPUT id="" style="FONT-SIZE: 12px; HEIGHT: 18px" type=submit value=���� name=button  onclick="javascript:select_fw()"/>&nbsp;&nbsp;
       </TD>         
	</TR>
</TABLE>   
</BODY>
</html>
