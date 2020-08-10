<%@ page import="java.util.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.sitesetting.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect( "../login.jsp?url=member/editGroup.jsp" );
    return;
  }
  if (!SecurityCheck.hasPermission(authToken,54))
  {
    request.setAttribute("message","��ϵͳ�����Ȩ��");
    response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
    return;
  }

  int ID = ParamUtil.getIntParameter(request, "ID", 0);
  IFtpSetManager ftpMgr = FtpSetting.getInstance();
  FtpInfo ftpinfo = ftpMgr.getFtpInfo(ID);
%>

<html>
<head>
<title>�޸�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script LANGUAGE="JavaScript" SRC="../js/check.js"></script>
<script language="javascript">
function check()
{
  if (editForm.sitename.value == "")
  {
    alert("����д�������ƣ�");
    return false;
  }
  else if (editForm.root.value == "")
  {
    alert("����д����Ŀ¼��");
    return false;
  }
  else if (editForm.pubway[1].checked)
  {
    if (editForm.ip.value == "")
    {
      alert("����д������ַ��");
      return false;
    }
    else if (editForm.ftp_username.value == "" || editForm.ftp_passwd.value == "")
    {
      alert("����дFTP�û��������룡");
      return false;
    }
  }
  return true;
}
</script>
</head>

<body bgcolor="#CCCCCC">
<form method="post" action="createnewipinfo.jsp" name="editForm" onsubmit="javascript:return check();">
<input type="hidden" name="doUpdate" value="true">
<input type="hidden" name="ID" value="<%=ID%>">
<table border="1" width="95%" cellpadding="0" cellspacing="0" borderColorDark="#ffffec" borderColorLight="#5e5e00" align=center>
   <tr>
      <td colspan=2 width="100%" bgcolor="#006699" align="center" height="16"><font color="#FFFFFF"><b>����ѡ�������ȷ��д</b></font></td>
   </tr>
    <tr>
       <td width="25%" align=right height=32>�������ƣ�</td>
       <td width="75%">&nbsp;<input name="sitename" value="<%=ftpinfo.getSiteName()%>" size=20></td>
    </tr>
    <tr>
       <td align=right height=32>������ʽ��</td>
       <td>
           <input type="radio" name="pubway" value="1" <%=(ftpinfo.getPublishway()==1)?"checked":""%>>���ط���
           <input type="radio" name="pubway" value="0" <%=(ftpinfo.getPublishway()==0)?"checked":""%>>FTP����
       </td>
    </tr>
    <tr>
        <td align=right height=32>����Ŀ¼��</td>
        <td>&nbsp;<input name="root" size="20" value="<%=ftpinfo.getDocpath()%>"></td>
    </tr>
    <tr>
        <td align=right height=32>������ַ��</td>
        <td>&nbsp;<input name="ip" value="<%=ftpinfo.getIp()%>"></td>
    </tr>
    <tr>
        <td align=right height=32>FTP�û�����</td>
        <td>&nbsp;<input name="ftp_username" maxlength="50" value="<%=(ftpinfo.getFtpuser()==null)?"":ftpinfo.getFtpuser()%>"></td>
    </tr>
    <tr>
        <td align=right height=32>FTP���룺</td>
        <td>&nbsp;<input type="password" name="ftp_passwd" maxlength="20" value="<%=(ftpinfo.getFtppwd()==null)?"":ftpinfo.getFtppwd()%>"></td>
    </tr>
    <tr>
        <td align=right height=32>�������ͣ�</td>
        <td>
           <select name="status" style="width: 135; height: 251">
             <option value=1 <%=(ftpinfo.getStatus()==1)?"selected":""%>>����WEB����</option>
             <option value=0 <%=(ftpinfo.getStatus()==0)?"selected":""%>>����ͼƬ/��ý�巢��</option>
             <option value=2 <%=(ftpinfo.getStatus()==2)?"selected":""%>>����WAP����</option>
           </select>
        </td>
        <!--td><input type="radio" name="status" value=1 <%if(ftpinfo.getStatus()==1){%>checked<%}%>>�������·���<input type="radio" name="status" value=0 <%if(ftpinfo.getStatus()==0){%>checked<%}%>>������������</td-->
    </tr>
</table>

<p align="center">
<input type="submit" value=" ���� ">&nbsp;&nbsp;&nbsp;
<input type="button" value=" ȡ�� " onclick="window.close()">
</p>
</form>

</body>
</html>