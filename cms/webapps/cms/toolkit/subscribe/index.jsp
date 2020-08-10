<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.sinopec.subscribe.ISubscribeManager" %>
<%@ page import="com.sinopec.subscribe.SubscribePeer" %>
<%@ page import="com.sinopec.subscribe.Subscribe" %>
<%@ page language="java" contentType="text/html;charset=GBK" %>
<%
    String href = request.getRequestURI();
    ISubscribeManager subMgr = SubscribePeer.getInstance();
    String email = ParamUtil.getParameter(request, "email");
    int type = ParamUtil.getIntParameter(request, "type", -1);
    boolean flag = subMgr.checkEmail(email);
    int subflag = subMgr.getSubFlag(email);

    if (type != -1) {
        Subscribe subscribe = new Subscribe();
        subscribe.setEmail(email);
        subscribe.setSubflag(type);
        if (type == 1) {
            if (!flag) {
                subMgr.addSubscribe(subscribe);
            } else {
                if (subflag == 0) {
                    subMgr.updateSubFlag(subscribe);
                }
            }
            out.println("<script language=javascript>");
            out.println("alert(\"���ĳɹ�\");");
            out.println("window.location='"+href+"'");
            out.println("</script>");
        } else if(type == 0) {
            if (flag) {
                subMgr.updateSubFlag(subscribe);
            }
            out.println("<script language=javascript>");
            out.println("alert(\"ȡ�����ĳɹ�\");");
            out.println("window.location='"+href+"'");
            out.println("</script>");
        }
    }
%>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function check(t) {

            //�ǿ���֤
            var email = document.emailForm.email.value;
            if (email == "" || email == null) {
                document.getElementById("emailmess").innerText = "������email��ַ";
                document.emailForm.email.focus();
                return false;
            }

            //�����ʽ��֤
            var checkemail = document.getElementById("email").value;
            if (checkemail != "") {
                var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
                flag = reg.test(checkemail);
                if (!flag) {
                    document.getElementById("emailmess").innerText = "email��ַ��������";
                    document.getElementById("email").focus();
                    return false;
                }
            }

            if (t == 0) {     //����
                emailForm.action = "index.jsp?type=0&email=" + email;
                emailForm.submit();
            } else {         //�˶�
                emailForm.action = "index.jsp?type=1&email=" + email;
                emailForm.submit();
            }


        }

    </script>
</head>
<body>
<center>
    <table>
        <form name="emailForm" method="post">

            <tr height="26">
                <td colspan="2"><input type="text" name="email"></td>
            </tr>
            <tr height="26">
                <td align="center" id="emailmess" style="color:red;font:12px" colspan="2"></td>
            </tr>
            <tr height="26">
                <td align="center"><input type="button" value="����" onclick="return check(1);"></td>
                <td align="center"><input type="button" value="�˶�" onclick="return check(0);"></td>
            </tr>
        </form>
    </table>
</center>
</body>
</html>