<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%
    String UserName = ParamUtil.getParameter(request,"username");
    int siteid =  ParamUtil.getIntParameter(request,"siteid",0);

    IUregisterManager regMgr = UregisterPeer.getInstance();
    Uregister ure = null;
    ure = regMgr.getUserInfo(UserName,siteid);
    String username = ure.getMemberid();
    String pass = ure.getPassword();
    String Email = ure.getEmail();
%>

<html>
<head>
    <title></title>
    <script type="text/JavaScript">
        function updatereg(){
            var url = "updatereg.jsp?memberid=<%=UserName%>";
            window.location.href=url;
        }
    </script>
</head>

<body>
<table>
    <tr>
        <td> ��ϲ<%= UserName%>ע��ɹ� </td>
        <td>

        </td>
    </tr>

    <tr>
        <td>�û�����</td>
        <td>
            <%= UserName%>
        </td>
    </tr>
    <tr>
        <td>���룺</td>
        <td>
            <%= pass%>
        </td>
    </tr>
    <tr>
        <td>�ʼ���</td>
        <td>
            <%= Email%>
        </td>
    </tr>
    <tr>
        <td>
            <input type="button" value="�޸�����" onclick="javascript:updatereg()">
        </td>
        <td>  </td>
    </tr>
</table>
</body>
</html>
