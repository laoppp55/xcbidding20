<%@ page import="com.bizwink.cms.security.Auth,
                 com.bizwink.cms.util.SessionUtil"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    /*if (!SecurityCheck.hasPermission(authToken,54))
 {
   request.setAttribute("message","�޹����û���Ȩ��");
   response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
   return;
 }

 int siteid = authToken.getSiteID();
 String username = authToken.getUserID();

 IUserManager userMgr = UserPeer.getInstance();
 List userList = userMgr.getUsers(siteid);
 int userCount = userList.size();*/
%>

<html>
<head>
    <title></title>

</head>
<P align=right><FONT color=#0000ff><A href="../../index.jsp">����</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT><br>
    <br>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="90%"
       align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td align="center" colspan="4">��ӭ��������������ϵͳ</td>
    </tr>

    <tr bgcolor="#ffffff" class=line>
        <td align=center><a href="supplier.jsp">����������</a></td>
        <td align=center><a href="../product/product.jsp">��Ʒ����</a></td>
        <td align="center"><a href="../purchasemaster/purchasemaster.jsp">������</a></td>
        <td align="center"><a href="../purchasedetail/purchasedetail.jsp">��������ϸ</a></td>
    </tr>

    <tr bgcolor="#ffffff" class=line>
        <td align=center><a href="../changemaster/changemaster.jsp">����䶯������</a></td>
        <td align=center><a href="../changedetail/changedetail.jsp">����䶯����ϸ��</a></td>
        <td align="center"><a href="../deliverymaster/deliverymaster.jsp">����������</a></td>
        <td align="center"><a href="../deliverydetail/deliverydetails.jsp">��������ϸ��</a></td>
    </tr>

</table>

</body>
</html>