<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>
<%@page contentType="text/html;charset=GBK" %>

<%
 java.util.Date date = new java.util.Date();
    SimpleDateFormat format = new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentDate=format.format(date);
     Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
      if (authToken == null)
      {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
      }
     IOrderManager imanager= orderPeer.getInstance();
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);

    int paywayid=Integer.parseInt(ParamUtil.getParameter(request,"paywayid"));

    InterfaceParam m =imanager.getInterfaceParam(paywayid);
    if(m != null ){
          response.sendRedirect("displayParam.jsp?paywayid="+m.getPaywayId());
    }
   if(startflag == 1)
    {

          String accountnumber=ParamUtil.getParameter(request,"accountnumber");
          String paywaykey=ParamUtil.getParameter(request,"paywaykey");
          String alipayaccount=ParamUtil.getParameter(request,"alipayaccount");
          InterfaceParam iparam = new InterfaceParam();
          iparam.setAccountNumber(accountnumber);
          iparam.setPaywayKey(paywaykey);
          iparam.setPaywayId(paywayid);
          iparam.setAlipayAccount(alipayaccount);
          iparam.setCreateDate(Timestamp.valueOf(currentDate));

        int t = imanager.addInterfaceParam(iparam);
        if(t >0){
            response.sendRedirect("index.jsp");
        }
        if(t==0){
            out.println("<script>alert('���ʧ��!');</script>");
        }

    }
%>
<html>
  <head>
  <title>֧����ʽ����</title>
      <meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
  <style type="text/css">
TABLE {FONT-SIZE: 12px;word-break:break-all}
BODY {FONT-SIZE: 12px;margin-top: 0px;margin-bottom: 0px; line-height:20px;}
.TITLE {FONT-SIZE:16px; text-align:center; color:#FF0000; font-weight:bold; line-height:30px;}
.FONT01 {FONT-SIZE: 12px; color:#FFFFFF; line-height:20px;}
.FONT02 {FONT-SIZE: 12px; color:#D04407; font-weight:bold; line-height:20px;}
.FONT03 {FONT-SIZE: 14px; color:#000000; line-height:25px;}
A:link {text-decoration:none;line-height:20px;}
A:visited {text-decoration:none;line-height:20px;}
A:active {text-decoration:none;line-height:20px; font-weight:bold;}
A:hover {text-decoration:none;line-height:20px;}
.pad {padding-left:4px; padding-right:4px; padding-top:2px; padding-bottom:2px; line-height:20px;}
.form{border-bottom:#000000 1px solid; background-color:#FFFFFF; border-left:#000000 1px solid; border-right:#000000 1px solid; border-top:#000000 1px solid; font-size: 9pt; font-family:"����";}
.botton{border-bottom:#000000 1px solid; background-color:#F1F1F1; border-left:#FFFFFF 1px solid; border-right:#333333 1px solid; border-top:#FFFFFF 1px solid; font-size: 9pt; font-family:"����"; height:20px; color: #000000; padding-bottom: 1px; padding-left: 1px; padding-right: 1px; padding-top: 1px; border-style: ridge}
</style>
      <script type="text/javascript">
          function chkSub(){
              var bessNo = document.getElementById("accountnumber").value;
               var key = document.getElementById("paywaykey").value;
               var sellerAcc = document.getElementById("alipayaccount").value;
              if(bessNo == null || bessNo == ""){
                  alert('����д�̻���!');
                  return false;
              }
              else if(key == null || key == ""){
                  alert('����д��Կ!');
                  return false;
              }
              else if(sellerAcc == null || sellerAcc == ""){
                  alert('����д����֧�����˻�!');
                  return false;
              }
              else{
                  return true;
              }
          }
          function bakurl(){
              window.location="index.jsp";
          }
      </script>
  </head>
  <body>
  <form action="interfaceParam.jsp" method="post">
   <input type="hidden" name="paywayid" value="<%=paywayid%>">
    <input type="hidden" name="startflag" value="1">
 <table width="50%" align="center" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                  <tr  bgcolor="#FFFFFF" class="css_001">
                    <td align="center">�̻���:</td>
                   <td><input type="text" name="accountnumber" id="accountnumber"></td>
                </tr>
                <tr  bgcolor="#FFFFFF" class="css_001">
                    <td align="center">��Կ:</td>
                   <td><input type="text" name="paywaykey" id="paywaykey"></td>
                </tr>
                  <tr  bgcolor="#FFFFFF" class="css_001">
                    <td align="center">����֧�����˻�:</td>
                    <td><input type="text" name="alipayaccount" id="alipayaccount"></td>
                  </tr>
                  <tr  bgcolor="#FFFFFF" class="css_001">
                    <td colspan="2" align="center"><input type="submit" name="sub" onclick="return chkSub();" value="���">
                    <input type="button" value="ȡ��" onclick="bakurl();">
                    </td>

                 </tr>
               </table>
            </td>
          </tr>
            </tr>
        </table>
      </td>
</tr>
</table>
</form>
</body>
</html>







