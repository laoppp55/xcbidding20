<%@page import="com.bizwink.cms.util.*,
                com.bizwink.cms.business.Users.*" contentType="text/html;charset=gbk"
%>
<%@ include file="../../../include/auth.jsp"%>
<%
  int siteid = authToken.getSiteID();
  String userid = ParamUtil.getParameter(request, "userid");
  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
  String username = ParamUtil.getParameter(request, "username");
  int status = ParamUtil.getIntParameter(request, "status", 0);

  IBUserManager buserMgr = buserPeer.getInstance();
  if(startflag == 1){
    buserMgr.updateLockFlag(status,userid,siteid);
    out.println("<script language=\"javascript\">");
    out.println("opener.history.go(0);");
    out.println("window.close();");
    out.println("</script>");
  }
%>
<html>
<head>
<title>�޸��û�״̬</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../images/pt9.css">
<link rel=stylesheet type=text/css href=../style/global.css>
<script language="javascript">
function closewin(){
  window.close();
}
</script>
</head>

<body bgcolor="#FFFFFF">
<center><br>
<form action="editflag.jsp" method="post">
<input type="hidden" name="userid" value="<%=userid%>">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="username" value="<%=username%>">
        <table width="347" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td class="moduleTitle"><font color="#48758C">�޸��û�״̬</font></td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                  <tr bgcolor="#FFFFFF">
                    <td align="center">�û�ID��</td>
                    <td align="center"><%=username%></td>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <td align="center">״̬��</td>
                    <td align="center">
                    <select name="status">
                    <option value="0" <%if(status==0){%>selected<%}%>>��ͨ</option>
                    <option value="1" <%if(status==1){%>selected<%}%>>��ͣ����</option>
                    <option value="2" <%if(status==2){%>selected<%}%>>��ͣ��¼</option>
                    <option value="3" <%if(status==6){%>selected<%}%>>���Ʒ���</option>
                    </select>
                    </td>
                  </tr>
                </table>
            </td>
          </tr>
          <tr><td>&nbsp;</td></tr>
        </table>
        <p align="center"><input type="submit" name="Ok" value="�޸�">&nbsp;&nbsp;<input type="button" name="close" value="�ر�" onclick="javascript:closewin();"></p>
</form>
<p>&nbsp; </p>
</center>
</body>
</html>
