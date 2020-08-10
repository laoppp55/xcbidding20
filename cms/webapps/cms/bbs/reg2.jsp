<%@page import="java.io.*,
                java.util.*,
                java.text.*,
                java.sql.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.server.*,
                com.bucid.bbs.*,
                com.bucid.register.*" contentType="text/html;charset=gbk"
%>
<%
  String userid          = ParamUtil.getParameter(request, "userid");
  String password        = ParamUtil.getParameter(request, "password");
  String email           = ParamUtil.getParameter(request, "email");
  String username        = ParamUtil.getParameter(request, "username");
  int sex                = ParamUtil.getIntParameter(request, "sex", 0);
  int birthday_year      = ParamUtil.getIntParameter(request, "birthday_year", 0);
  int birthday_month     = ParamUtil.getIntParameter(request, "birthday_month", 0);
  int birthday_day       = ParamUtil.getIntParameter(request, "birthday_day", 0);
  String phone           = ParamUtil.getParameter(request, "phone");
  String mobilephone     = ParamUtil.getParameter(request, "mobilephone");
  String address         = ParamUtil.getParameter(request, "address");
  String postcode        = ParamUtil.getParameter(request, "postcode");
  int startflag          = ParamUtil.getIntParameter(request, "startflag", -1);
	int isexist            = ParamUtil.getIntParameter(request, "isexist", -1);
  String idcard          = ParamUtil.getParameter(request, "idcard");

  String ip              = request.getRemoteAddr();
  if(startflag == 1){
    IRegisterManager registerMgr = RegisterPeer.getInstance();
		Register register = new Register();

		int id = registerMgr.getMaxUserID();
    id = id + 1;

		register.setID(id);
		register.setUserID(userid);
		register.setPassword(password);
		register.setEmail(email);
		register.setUserName(username);
		register.setSex(sex);
		register.setBirthday_year(birthday_year);
		register.setBirthday_month(birthday_month);
		register.setBirthday_day(birthday_day);
		register.setPhone(phone);
		register.setMobilePhone(mobilephone);
		register.setAddress(address);
		register.setPostCode(postcode);
		register.setIP(ip);
        register.setIDCard(idcard);

		//����û��Ƿ����
		boolean existflag = registerMgr.checkUser(register);
		if(!existflag){
			response.sendRedirect("reg2.jsp?isexist=1");
			return;
		}

		//������֤���Ƿ����
		boolean existipflag = registerMgr.checkIDCard(idcard);
		if(!existipflag){
			response.sendRedirect("reg2.jsp?isexist=2");
			return;
		}

		registerMgr.createUser(register);
		session.setAttribute("UserClass","������·");
		session.setAttribute("userid",userid);
		response.sendRedirect("regOk.jsp");
  }
%>

<html>
<head>
<title>��ӭ���ʱ����ǽ�Ͷ�ʷ�չ�ɷ����޹�˾</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet href="images/chengjian.css" style="text/css">
<script language=javascript>
function check(){
  if((regform.userid.value == "")||(regform.userid.value == null)){
	  alert("�����������û�����");
		return false;
	}

	if((regform.password.value == "")||(regform.password.value == null)){
	  alert("�������������룡");
		return false;
	}

	if((regform.repassword.value == "")||(regform.repassword.value == null)){
	  alert("����������ȷ�����룡");
		return false;
	}

	if(regform.password.value != regform.repassword.value){
	  alert("������������ȷ�����벻��ȷ��");
		return false;
	}

	if((regform.email.value == null)||(regform.email.value == "")){
	  alert("���������ĵ����ʼ���");
		return false;
	}
	return true;
}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<center>
<%@include file="head.jsp"%>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td><img src="images/space.gif" width="10" height="10"></td>
</tr>
</table>
<table width="778" border="0" cellspacing="0" cellpadding="0">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/dotline.gif">
<tr>
<td><img src="images/space.gif" width="3" height="3"></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="tittle">
<tr>
<td><b><span class="tittle">����λ��: </span></b><span class="tittle"><a href="/bbs/index.jsp">�ǽ���̳</a>
>> <a href="/bbs/reg1.jsp">�û�ע��</a></span></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/dotline.gif">
<tr>
<td><img src="images/space.gif" width="3" height="3"></td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="txt">
<tr bgcolor="F1F2EC" align="center">
<form  method="post" action="reg2.jsp" name="regform">
<input type="hidden" name="startflag" value="1">
<td><b>ע����Ϣ</b> </td>
</tr>
</table>
<table cellpadding=2 width="100%" border=0>
<tbody>
<tr>
<td class=txt>��Ա������Ϣ<font
              color=#ff0000>*</font>����</td>
</tr>
<%
  if(isexist == 1){
%>
<tr>
<td class=txt><font color=red>��ע����û����Ѿ����ڣ�������ע�ᣡ</font></td>
</tr>
<%}else if(isexist == 2){%>
<tr>
<td class=txt><font color=red>�����֤���Ѿ�ע�ᣡ�����ظ�ע�ᣡ</font></td>
</tr>
<%}%>
</tbody>
</table>
<table cellspacing=1 cellpadding=2 width="100%"
              border=0>
<tbody>
<tr bgcolor=#ffffff>
<td class=txt valign=top width="20%" height=1>�����û�����</td>
<td class=txt valign=top width="30%" height=1>
<input size=15 name=userid>
<font color=#ff0000>* </font></td>
<td class=txt
                  height=1>ע��ɹ����û����������޸ģ��û����������С�Ӣ�ġ����֣��»��߼��̺����е���ϡ�(��󳤶ȣ����ֽ�)��
<br>
</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>�������룺</td>
<td class=txt height=25>
<input type=password size=15
                  name=password>
<font color=#ff0000>* </font></td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>���ٴ�����������ȷ�ϣ�</td>
<td class=txt height=25>
<input type=password size=15
                  name=repassword>
<font color=#ff0000>* </font></td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>����email��</td>
<td class=txt height=25>
<input size=28 name=email>
<font
                  color=#ff0000>* </font></td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>������</td>
<td class=txt height=25>
<input size=14 name=username></td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>�����Ա�</td>
<td class=txt height=25>
<select name=sex>
<option value=0>��</option>
<option value=1>Ů</option>
</select></td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>�������ڣ�</td>
<td class=txt height=25>
<input maxlength=4 size=4
                  name=birthday_year>
��
<select name=birthday_month>
<option
                    value=0 selected>ѡ��</option>
<option value=1>1</option>
<option value=2>2</option>
<option value=3>3</option>
<option value=4>4</option>
<option value=5>5</option>
<option value=6>6</option>
<option value=7>7</option>
<option value=8>8</option>
<option value=9>9</option>
<option value=10>10</option>
<option value=11>11</option>
<option value=12>12</option>
</select>
��
<select
                  name=birthday_day>
<option value=0 selected>ѡ��</option>
<option value=1>1</option>
<option value=2>2</option>
<option value=3>3</option>
<option value=4>4</option>
<option value=5>5</option>
<option value=6>6</option>
<option value=7>7</option>
<option value=8>8</option>
<option value=9>9</option>
<option value=10>10</option>
<option value=11>11</option>
<option value=12>12</option>
<option value=13>13</option>
<option value=14>14</option>
<option value=15>15</option>
<option value=16>16</option>
<option value=17>17</option>
<option value=18>18</option>
<option value=19>19</option>
<option value=20>20</option>
<option value=21>21</option>
<option value=22>22</option>
<option value=23>23</option>
<option value=24>24</option>
<option value=25>25</option>
<option value=26>26</option>
<option value=27>27</option>
<option value=28>28</option>
<option value=29>29</option>
<option value=30>30</option>
<option value=31>31</option>
</select>
�� </td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=34>���֤�ţ�</td>
<td class=txt height=34>
<input size=28 name=idcard>
</td>
<td class=txt height=34>��������Ч���֤��</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=34>��ϵ�绰��</td>
<td class=txt height=34>
<input size=28 name=phone>
</td>
<td class=txt height=34>����ϵ�����ĵ绰���룬����д������ö��Ÿ鿪��</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>�ֻ���</td>
<td class=txt height=25>
<input size=18 name=mobilephone>
</td>
<td height=25>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=34>��ͥ��ַ��</td>
<td class=txt height=34>
<input size=28 name=address>
</td>
<td height=34>&nbsp;</td>
</tr>
<tr bgcolor=#ffffff>
<td class=txt height=25>�������룺</td>
<td class=txt height=25>
<input size=13 name=postcode>
</td>
<td height=25>&nbsp;</td>
</tr>
</tbody>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="8">
<tr>
<td align="right">
<input type="submit" name="Submit" value="ȷ��" onclick="javascript:return check();">
</td>
<td>
<input type="reset" name="Submit2" value="����">
</td>
</tr>
</table>
</td>
</tr>
</form>
</table>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td><img src="images/space.gif" width="25" height="25"></td>
</tr>
</table>
<%@include file="tail.jsp"%>
</center>
</body>
</html>

