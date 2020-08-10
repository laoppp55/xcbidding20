<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"%>
<%@ include file="../../../include/auth.jsp"%>
<%
    if (!SecurityCheck.hasPermission(authToken, 54)){
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
        return;
    }

    boolean error = false;
    boolean success = false;

    User user = new User();
    int siteid = authToken.getSiteID();
    String userid = ParamUtil.getParameter(request,"userid");    //����Ȩ�˵�userid�����ǵ�¼�ߵ�userid
    String nickname         = ParamUtil.getParameter(request,"username");
    String password         = ParamUtil.getParameter(request,"passwd");
    String email            = ParamUtil.getParameter(request,"email");
    String phone            = ParamUtil.getParameter(request,"telephone");
    String mobilephone      = ParamUtil.getParameter(request,"mobilphone");

    boolean doCreate        = ParamUtil.getBooleanParameter(request,"doCreate");
    List oldColList = new ArrayList();      //�û�ԭ��ӵ�е���Ŀ�б�
    List curColList = new ArrayList();      //�¸����û�����Ŀ�б�

    IUserManager       userMgr  = UserPeer.getInstance();
    IColumnUserManager colMgr  = ColumnUserPeer.getInstance();
    IRightsManager     rightMgr = RightsPeer.getInstance();

    //�õ�ԭʼ����
    if (!doCreate)
    {
      user = userMgr.getUser(userid,siteid);
      //oldColList = colMgr.getUserColsFromTBL_Members_Rights(userid,siteid);
    }

    // check for errors
    if( doCreate )
    {
      user = userMgr.getUser(userid,1);
      user.setNickName(nickname);
      user.setPassword(password);
      user.setEmail(email);
      user.setPhone(phone);
      user.setMobilePhone(mobilephone);

      //oldColList = colMgr.getUserColsFromTBL_Members_Rights(userid,siteid);
      //curColList = ParamUtil.getParameterValues(request,"columnList");
      //colMgr.updateUser(user,1,oldColList,curColList);
    }

    String colCname = null;
    String colEname = null;
    int colId = 0;
%>

<html>
<head>
<title>�༭�û�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script LANGUAGE="JavaScript" SRC="../js/check.js">
</script>

<SCRIPT LANGUAGE=javascript>
function checkinput(form)
{
      if (!InputValid(form.email, 1, "email", 0, 0, 0,"�����ʼ�"))
            return (false);

      if (!validpassword(form.passwd.value, form.repasswd.value))
            return (false);

      if (!InputValid(form.username, 1, "string", 1, 2, 12,"�û�����"))
            return (false);

      if (!InputValid(form.telephone, 0, "fax", 1, 0, 11,"�û��绰"))
            return (false);

      if (!InputValid(form.mobilphone, 0, "fax", 1, 0, 11,"�û��ֻ�"))
            return (false);

      return true;
}

function window_close() {
    parent.window.close();
}

function submit_end() {
  <% if( !error && doCreate ) {%>
    parent.window.opener.location.href="index.jsp?msg=�û������ɹ�";
    parent.window.close();
  <%}%>
}

function delElement() {
  var el = newitem.columnList;
  for(var i = el.options.length-1; i >=0; i--) {
    if(el.options[i].selected == true) {
         el.options[i] = null;
    }
  }
}

function grant(frm)
{
  //frm.action = "editgrant.jsp";
  //frm.submit();

  var el = newitem.columnList;
  var param = "";
  var len = 0;

  for(var i = el.options.length-1; i >=0; i--)
  {
    if(el.options[i].selected == true)
    {
       	var t1 = el.options[i].value.indexOf(":");
	var t2 = el.options[i].value.lastIndexOf(":");
	param  = el.options[i].value.substring(t1+1,t2);

    	len++;
    }
  }

  if (len > 1)
  	alert("�Բ���ֻ��ѡ��һ����Ŀ��");
  else
  {
  	if (param != "")
  	    window.open( "editgrant.jsp?columnid=" + param + "&userid=<%=userid%>","SelectRight","top=200,left=300,width=365,height=350,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
  	else
  	    alert("��ѡ����Ŀ��");
  }
}

</SCRIPT>

</head>

<body bgcolor="#FFFFFF" onload="javascript:submit_end();">
<div align="center">
<form name="newitem" method="post"  onsubmit="return checkinput(this);">
<input type="hidden" name="doCreate" value="true">
<input type="hidden" name="deleted_cids" value="">
<input type="hidden" name="new_cids" value="">
    <div align="left">
      <table width="100%" border="1" bgcolor="#CCCCCC" height="300">
        <tr>
          <td width="34%" align="right"><font size="2">�û���ʶ����</font></td>
          <td width="66%">
            &nbsp;<input type="text" name="userid" size="12" readonly value="<%=(user.getID()!=null)?user.getID():""%>">
          </td>
        </tr>
    <tr>
      <td width="34%" align="right"><font size="2">���룺</font></td>
      <td width="66%">
        &nbsp;<input type="password" name="passwd" size="12" value="<%=user.getPassword()%>">
      </td>
        </tr>
    <tr>
      <td width="34%" align="right"><font size="2">ȷ�����룺</font></td>
      <td width="66%">
        &nbsp;<input type="password" name="repasswd" size="12" value="<%=user.getPassword()%>">
      </td>
        </tr>
        <tr>
          <td width="34%" align="right"><font size="2">�����ʼ���</font></td>
          <td width="66%">
            &nbsp;<input type="text" name="email" value="<%=(user.getEmail()!=null)?user.getEmail():""%>">
          </td>
        </tr>
        <tr>
          <td width="34%" align="right"><font size="2">�û�������</font></td>
          <td width="66%">
            &nbsp;<input type="text" name="username" value="<%=(user.getNickName()!=null)?StringUtil.gb2iso4View(user.getNickName()):""%>">
          </td>
        </tr>
        <tr>
          <td width="34%" align="right"><font size="2">�û��绰��</font></td>
          <td width="66%">
            &nbsp;<input type="text" name="telephone" value="<%=(user.getPhone()!=null)?user.getPhone():""%>">
          </td>
        </tr>
        <tr>
          <td width="34%" align="right"><font size="2">�û��ֻ���</font></td>
          <td width="66%">
            &nbsp;<input type="text" name="mobilphone" value="<%=(user.getMobilePhone()!=null)?user.getMobilePhone():""%>">
          </td>
        </tr>
        <tr>
          <td colspan="2" height="32">
            <div align="center">
              <input type="submit" name="adduser" value="�޸�">&nbsp;&nbsp;
              <input type="button" name="cancel" value="ȡ��" onclick="javascript:window_close()">
            </div>
          </td>
        </tr>
      </table>
    </div>
  </form>
</div>
</body>
</html>
