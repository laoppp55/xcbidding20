<%@ page contentType="text/html;charset=gbk" import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.joincompany.IJoincompanyManager" %>
<%@ page import="com.bizwink.joincompany.JoincompanyPeer" %>
<%@ page import="com.bizwink.joincompany.Joincompany" %>
<%@ page import="com.bizwink.cms.util.ISequenceManager" %>
<%@ page import="com.bizwink.cms.util.SequencePeer" %><%
   int flag= ParamUtil.getIntParameter(request,"flag",-1);
    System.out.println(""+System.currentTimeMillis());
      
   if(flag==1)
   {
       String joinname=ParamUtil.getParameter(request,"joinname");
       String address=ParamUtil.getParameter(request,"address");
       String lianxipeople=ParamUtil.getParameter(request,"lianxipeople");
       String phone=ParamUtil.getParameter(request,"phone");
       String fax=ParamUtil.getParameter(request,"fax");
       String email=ParamUtil.getParameter(request,"email");
       String zhizhaonumber=ParamUtil.getParameter(request,"zhizhaonumber");
       String password=ParamUtil.getParameter(request,"password");
       String question=ParamUtil.getParameter(request,"question");
       String answer=ParamUtil.getParameter(request,"answer");




       String month="";
                if(request.getParameter("buyflag")!=null)
                {
                 String checkbox[]=request.getParameterValues("buyflag");
                 if (checkbox!=null)
                 {
                  //int size=java.lang.reflect.Array.getLength(checkbox);
                  int size=checkbox.length;
                //  out.println("��ѡ����" + size + "��ֱ�Ϊ��<br>");
                  for (int i=0;i<size;i++)
                  {
                //   out.println(checkbox[i]+"<br>");
                      month=month+"   "+checkbox[i];
                  }
                 }
                }





       int i=0;
       Joincompany join=new Joincompany();
        join.setBuyflag(month);
       join.setJoinname(joinname);
       join.setAddress(address);
       join.setLianxipeople(lianxipeople);
       join.setPhone(phone);
       join.setFax(fax);
       join.setEmail(email);
       join.setZhizhaonumber(zhizhaonumber);
       join.setPassword(password);
       join.setQuestion(question);
       join.setAnswer(answer);
       IJoincompanyManager jpeer= JoincompanyPeer.getInstance();
       ISequenceManager sequenceMgr = SequencePeer.getInstance();
       int ID = sequenceMgr.getSequenceNum("joincompany");
        String joinids="";
             String ids=String.valueOf(ID);
             joinids=""+System.currentTimeMillis();
             joinids=joinids.substring(joinids.length()-(6-ids.length()+1),joinids.length());
             joinids="8"+joinids+ID;
             join.setJoinid(joinids);
             join.setId(ID);
       i=jpeer.insertJoincompany(join,ID);
        if (i == 1) {
           
            session.setAttribute("join",join);
            out.write("<script type=\"text/javascript\">alert('�ύ�ɹ�');window.location='update.jsp'</script>");
        } else {
            out.write("<script type=\"text/javascript\">alert('�ύʧ��');window.location='register.jsp'</script>");
        }
       
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��վ����--��������</title>
<link href="coositecss.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" xml:space="preserve">
        var falg = false;
        var sucess = "";
        function ismail(mail)
        {

            falg = (new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(mail));
            if (falg)
            {
                sucess = "sucess";
            }
        }
        function tijiao()
        {
            var joinname=document.getElementById("joinname").value;
            var address=document.getElementById("address").value;
            var email=document.getElementById("email").value;
            var phone=document.getElementById("phone").value;
            var fax=document.getElementById("fax").value;
            var answer=document.getElementById("answer").value;
            var zhizhaonumber=document.getElementById("zhizhaonumber").value;
            var lianxipeople=document.getElementById("lianxipeople").value;
            var password=document.getElementById("password").value;
            if(joinname=="")
            {
                alert("���������Ʋ���Ϊ��");
                return;
            }
            if(address=="")
            {
                alert("��ַ����Ϊ��");
                return ;
            }
            if(lianxipeople=="")
            {
                alert("��ϵ�˲���Ϊ��");
                return ;
            }
            if(phone=="")
            {
                alert("�ֻ�����Ϊ��");
                return;
            }
            if(phone.length!=11)
            {
                 alert("�ֻ�λ������ȷ");
                return;
            }
            if(fax=="")
            {
                alert("���治��Ϊ��");
                return;
            }
            if(zhizhaonumber=="")
            {
                alert("��ҵִ�ղ���Ϊ��");
                return;
            }
            if(password=="")
            {
                alert("���벻��Ϊ��");
                return;
            }
            ismail(email)
            if (sucess == "")
            {
                alert("E-mail��ʽ����ȷ");
                return ;
            }
            
            var zhifus=document.getElementsByName("buyflag");

            var zhifu="";
            var zhifufalg=false;
            for(var i=0;i<zhifus.length;i++)
             {
                 if(zhifus[i].checked)
                 {
                     zhifufalg=true;
                     zhifu=zhifus[i].value;
                 }
             }
            if(zhifu=="")
            {
                alert("��ѡ����ʽ");
                return ;
            }
            
            document.form1.action = "register.jsp";
            document.form1.submit();

        }
    </script>
</head>

<body>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="25">&nbsp;</td>
    <td width="223" align="left" valign="top"><img src="images/logo_331.jpg" width="217" height="84" vspace="10" /></td>
    <td width="261" align="left" valign="top"><img src="images/Preview_331.jpg" width="261" height="152" /></td>
    <td width="491" align="left" valign="top"><table width="465" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="20" height="30">&nbsp;</td>
        <td width="435">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td align="right" valign="middle"><a href="#" class="inde"><br />
    ��Ϊ��ҳ |</a><a href="#" class="inde"> ��Ϊ�ղ� &nbsp;</a><a href="#"> </a></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td align="left" valign="top">
            <table>
            <tr><td><a href="index.jsp"><img src="images/coosite_14.gif"  border="0" /></a></td>
                <td><a href="/webbuilder/register/about.html"><img src="images/coosite_15.gif"  border="0"/></a></td>
                <td><a href="/webbuilder/joincompany/login.jsp"><img src="images/coosite_16.gif" border="0"/></a></td>
                <td><a href="/webbuilder/register/webpubindex.jsp"><img src="images/coosite_17.gif" border="0"/></a></td>
                 <td><a href="#"><img src="images/coosite_18.gif" border="0"/></a></td>
                  <td><a href="/webbuilder/register/gettouch.html"><img src="images/coosite_19.gif" border="0"/></a></td>
                </tr>
            </table>
		</td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="688" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" valign="top"><img src="images/Franchisee_login_1.gif" width="688" height="79" /></td>
  </tr>
  <tr>
    <td align="left" valign="top" background="images/coosite_login_2.gif">
		<table width="688" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="54">&nbsp;</td>
			<td width="298" align="left" valign="top">
			<form id="form1" name="form1" method="post" >
    <input type="hidden" name="flag" value="1">
				<table width="298" border="0" cellspacing="0" cellpadding="0">
					  <tr>
						<td width="87" height="20">&nbsp;</td>
						<td width="211">&nbsp;</td>
					  </tr>
				  <tr>
					<td align="right" valign="top" class="grey_font">���������ƣ�</td>
						<td align="left" valign="middle"><label>
						  <input type="text" name="joinname" id="joinname" class="txt_inde" style="vertical-align:middle" />
				    </label>					</td>
				  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="top" class="grey_font">��&nbsp;&nbsp;ַ��</td>
						<td align="left" valign="top"><label>
						 <input type="text" name="address" id="address" class="txt_inde" />
						</label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="top" class="grey_font">��ϵ�ˣ�</td>
						<td align="left" valign="top"><label>
						 <input type="text" name="lianxipeople" id="lianxipeople" class="txt_inde" />
						</label></td>
					  </tr>
					   <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="top" class="grey_font">��&nbsp;&nbsp;����</td>
						<td align="left" valign="top"><label>
						 <input type="text" name="phone" id="phone" class="txt_inde" />
						</label></td>
					  </tr>
					   <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="top" class="grey_font">��&nbsp;&nbsp;�棺</td>
						<td align="left" valign="top"><label>
						  <input type="text" name="fax" id="fax" class="txt_inde" />
						</label></td>
					  </tr><tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="top" class="grey_font">��&nbsp;&nbsp;����</td>
						<td align="left" valign="top"><label>
                         <input type="text" name="email" id="email" class="txt_inde" />
                        </label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="top" class="grey_font">��ҵִ�գ�</td>
						<td align="left" valign="top"><label>
                         <input type="text" name="zhizhaonumber" id="zhizhaonumber" class="txt_inde" />
                        </label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="middle" class="grey_font">��&nbsp;&nbsp;�룺</td>
						<td align="left" valign="top"><label>
                        <input type="text" name="password" id="password" class="txt_inde" />
                        </label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  
					  
					  <tr>
						<td align="right" valign="middle">����ʽ: </td>
						<td align="left" valign="middle"><label>
                       ��վ���� <input type="checkbox" name="buyflag" value="��վ����" id="buyflag" />&nbsp;&nbsp;�������<input type="checkbox" name="buyflag" value="�������" id="buyflag"  />
                        </label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  
					  
					  
					   <tr>
						<td align="right" valign="top" class="grey_font">�������⣺</td>
						<td align="left" valign="bottom"><label>
						<select name="question" class="txt_list">
						  <option value="���ĸ��׵ĵ�λ">���ĸ��׵ĵ�λ</option>
						  <option value="����ѧУ">����ѧУ</option>
						  <option value="��������">��������</option>
					    </select>
						</label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="right" valign="middle" class="grey_font">��&nbsp;&nbsp;����</td>
						<td align="left" valign="top"><label>
                          <input type="text" name="answer" id="answer" class="txt_inde" />
                        </label></td>
					  </tr>
					  <tr>
						<td height="19"></td>
						<td></td>
					  </tr>
					  <tr>
						<td align="left" valign="top">&nbsp;</td>
						<td><img src="images/ok_331.jpg"  onclick="tijiao()" width="62" height="27" /></td>
					  </tr> 
					  <tr>
						<td align="right" valign="middle" class="grey_font">&nbsp;</td>
						<td align="left" valign="top"><label></label></td>
					  </tr>
		      </table></form>			
		    </td>
			<td width="336" align="left" valign="top"><br />
		    <img src="images/coosite_login_4.gif" width="268" height="156" hspace="20" /></td>
		  </tr>
	  </table>
	</td>
  </tr>
  <tr>
    <td align="left" valign="top"><img src="images/coosite_login_3.gif" width="688" height="64" /></td>
  </tr>
</table>
</body>
</html>
