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
%>

<html>
<head>
    <title></title>

</head>
<br>
    <br>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="90%"
       align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td align="center" colspan="4">�Խ���</td>
    </tr>

    <tr bgcolor="#ffffff" class=line>
        <td align=center><a href="ganrao/ganrao.jsp">���ߵ��������</a></td>
        <td align=center><a href="zhuduijiangji/zhuduijiangji.jsp">���ߵ�̨�걨������</a></td>
        <td align="center"><a href="diantaiziliao/diantaiziliao.jsp">���ߵ�̨�걨������</a></td>
    </tr>
</table>

</body>
</html>