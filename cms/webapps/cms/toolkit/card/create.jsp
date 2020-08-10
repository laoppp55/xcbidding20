<%@ page import="com.bizwink.cms.util.ParamUtil"%>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager"%>
<%@ page import="com.bizwink.cms.business.Order.orderPeer"%>
<%@ page import="com.bizwink.cms.business.Order.Card" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@page contentType="text/html;charset=GBK"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
      if (authToken == null)
      {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
      }
      int siteid = authToken.getSiteID();
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);
    int start = ParamUtil.getIntParameter(request,"start",0);

    if(startflag == 1){
        int startrow = ParamUtil.getIntParameter(request,"start",0);
        IOrderManager orderMgr = orderPeer.getInstance();
        String cardnum = ParamUtil.getParameter(request,"cardnum");
        String code = ParamUtil.getParameter(request,"code");
        int denomination = ParamUtil.getIntParameter(request,"denomination",-1);
        String begintime = ParamUtil.getParameter(request,"begintime");
        String endtime = ParamUtil.getParameter(request,"endtime");
        Card card = new Card();
        card.setCardnum(cardnum);
        card.setCode(code);
        card.setDenomination(denomination);
        card.setBegintime(begintime);
        card.setEndtime(endtime);
        card.setSiteid(siteid);
        orderMgr.createCard(card);
        response.sendRedirect("index.jsp?startrow="+startrow);
    }
%>
<html>
<head>
<script language="JavaScript" src="include/setday.js" ></script>
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
.form{border-bottom:#000000 1px solid; background-color:#FFFFFF; border-left:#000000 1px solid; border-right:#000000 1px solid; border-top:#000000 1px solid; font-size: 9pt; font-family:"??��?";}
.botton{border-bottom:#000000 1px solid; background-color:#F1F1F1; border-left:#FFFFFF 1px solid; border-right:#333333 1px solid; border-top:#FFFFFF 1px solid; font-size: 9pt; font-family:"??��?"; height:20px; color: #000000; padding-bottom: 1px; padding-left: 1px; padding-right: 1px; padding-top: 1px; border-style: ridge}
</style>
</head>
<script type="text/javascript">
function check(){
    if(createForm.cardnum.value == ""){
        alert("���������кţ�");
        createForm.cardnum.focus();
        return false;
    }
    if(createForm.code.value == ""){
        alert("�����뼤���룡");
        createForm.code.focus();
        return false;
    }
    if(createForm.denomination.value == ""){
        alert("��������");
        createForm.denomination.focus();
        return false;
    }
    return true;
}
</script>
<body>
<center>
<table width="50%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
<form name="createForm" method="post" action="create.jsp" onsubmit="return check();">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="start" value="<%=start%>">
<tr>
  <td>
    <table width="100%" border="0" cellpadding="0">
      <tr bgcolor="#F4F4F4" align="center">
        <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">������߹����</td>
      </tr>
      <tr bgcolor="#d4d4d4" align="right">
        <td>
          <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
            <tr  bgcolor="#FFFFFF" class="css_001">
              <td width="8%" align="center" bgcolor="#FFFFFF">���к�</td>
              <td align="center" width="48%"><input name="cardnum" type="text" id="relation"></td>
            </tr>
            <tr  bgcolor="#FFFFFF" class="css_001">
              <td width="8%" align="center" bgcolor="#FFFFFF">������</td>
              <td align="center" width="48%"><input type="text" name="code"></td>
            </tr>
              <tr  bgcolor="#FFFFFF" class="css_001">
              <td width="8%" align="center" bgcolor="#FFFFFF">���</td>
              <td align="center" width="48%"><input type="text" name="denomination"></td>
            </tr>
              <tr bgcolor="#FFFFFF">
                <td valign="bottom" class="txt">����</td>
                <td bgcolor="#FFFFFF" class="txt"> ��(��ʼ����)
                <input type="text" size="10" name="begintime" onfocus="setday(this)" readonly>
                 ��(��������)
                  <input type="text" size="10" name="endtime" onfocus="setday(this)" readonly>
                </td>
             </tr>
           </table>
        </td>
      </tr>
    </table>
  </td>
</tr>
<tr>
<td align=center><input type="submit" value="���"></td>
</tr>
</form>
</table>
</center>
</body>
</html>