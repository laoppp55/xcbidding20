<%@page import="com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.markManager.*,
                com.bizwink.cms.xml.*"
        contentType="text/html;charset=gbk"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
%>
<html>
<head>
    <base target="_self" >
    <title>���õ�¼�û����</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <meta http-equiv="Pragma" content="no-cache">
    <script type="text/javascript">
        function setupusertype()
        {
            var retval = "";
            if (userlogintype.uid[0].checked == true) {
                retval = retval + "<input type=\"radio\" name=\"uid\" value=\"0\">��ͨ�û�";
            }
            if (userlogintype.uid[1].checked == true) {
                retval = retval + "<input type=\"radio\" name=\"uid\" value=\"1\">��ҵ�û�";
            }
            if (userlogintype.uid[2].checked == true) {
                retval = retval + "<input type=\"radio\" name=\"uid\" value=\"2\">�ڲ��û�";
            }
            if (userlogintype.uid[3].checked == true) {
                retval = retval + "<input type=\"radio\" name=\"uid\" value=\"3\">VIP�û�";
            }
            parent.window.returnValue = retval;
            top.close();
        }
    </script>
</head>

<body>
<table>
    <tr>
        <td height="30" >
            &nbsp;
        </td>
    </tr>
</table>
<form name="userlogintype">
    <table cellspacing ="0" cellpadding="0">
        <tr>
            <td colspan="2" >
                <input type="checkbox" name="uid" value="0">��ͨ�û�
                <input type="checkbox" name="uid" value="1">��ҵ�û�
                <input type="checkbox" name="uid" value="2">�ڲ��û�
                <input type="checkbox" name="uid" value="3">VIP�û�
            </td>
        </tr>
        <tr>
            <td height="30" >
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <input type="button" name="ok" value="�ύ" onclick="javascript:setupusertype();">
            </td>
            <td>
                <input type="button" name="cancel" value="����" onclick="javascript:top.close();">
            </td>
        </tr>
    </table>
</form>
</body>
</html>