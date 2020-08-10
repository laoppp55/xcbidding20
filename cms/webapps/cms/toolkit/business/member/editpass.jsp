<%@ page import="com.bizwink.cms.util.*,com.bizwink.cms.business.Users.*" contentType="text/html;charset=gbk"%>
<%@ include file="../../../include/auth.jsp"%>
<%
    int siteid = authToken.getSiteID();
    int startflag       = ParamUtil.getIntParameter(request, "startflag", 0);
    String pass         = ParamUtil.getParameter(request, "password");
    String userid       = ParamUtil.getParameter(request, "userid");

    IBUserManager buserMgr = buserPeer.getInstance();
    if(startflag == 1){
        if (pass!=null && pass!="") {
            if (pass.length()>6) {
                buserMgr.updatePassword(pass,userid,siteid);
                out.println("<script language=\"javascript\">");
                out.println("alert(\"�����޸ĳɹ���\");");
                out.println("window.close();");
                out.println("</script>");
            } else {
                out.println("<script language=\"javascript\">");
                out.println("alert(\"�����޸�ʧ�ܣ����볤������6λ��\");");
                out.println("window.close();");
                out.println("</script>");
            }
        } else {
            out.println("<script language=\"javascript\">");
            out.println("alert(\"�����޸�ʧ�ܣ�����Ϊ�գ�\");");
            out.println("window.close();");
            out.println("</script>");
        }
    }
%>
<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel="stylesheet" href="images/pt9.css">
    <link rel="stylesheet" href="include/common.css">
    <meta http-equiv="Pragma" content="no-cache">
    <script language="javascript">
        function trim(str){
            var i = 0;
            while (i<str.length && str.charAt(i)==' ') i++;
            str=str.substr(i);
            i=str.length-1;
            while (i>=0 && str.charAt(i)==' ') i--;
            str=str.substr(0,i+1);

            return str
        }

        function check(){
            var pass1 = regform.password.value;
            var pass2 = regform.repassword.value;
            var allValid = true;

            if( trim(pass1)=="" ) {
                alert("���������룬���벻��Ϊ�գ�");
                return false;
            }

            if( trim(pass2)=="" ) {
                alert("������ȷ�����룬ȷ�����벻��Ϊ�գ�");
                return false;
            }

            if (pass1.indexOf(" ") != -1) {
                alert("�����а����ո������������룡");
                return false;
            }

            if (pass2.indexOf(" ") != -1) {
                alert("ȷ�������а����ո�������ȷ�����룡");
                return false;
            }

            if( pass1.length < 6 ) {
                alert("���볤������6���ַ���");
                return false;
            }

            if( pass1.length != pass2.length ) {
                alert("������������볤�Ȳ�һ�£�");
                return false;
            }

            for(i=0;i<pass1.length;i++) {
                if( pass1.charAt(i) != pass2.charAt(i) ) {
                    alert("������������벻һ��!");
                    allValid = false;
                    break;
                }
            }

            return allValid;
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<form method="post" action="editpass.jsp" name="regform" onsubmit="return check()">
    <input type="hidden" name="startflag" value="1">
    <input type="hidden" name="userid" value="<%=userid%>">
    <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF" width="100%">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0">
                    <tr bgcolor="#F4F4F4" align="center">
                        <td class="moduleTitle"><font color="#48758C">�޸�����</font></td>
                    </tr>
                    <tr bgcolor="#d4d4d4" align="right">
                        <td>
                            <table width="100%" border="0" cellpadding="2" cellspacing="1">
                                <tr  bgcolor="#FFFFFF">
                                    <td width="10%" align="left" class="txt">���룺</td>
                                    <td width="15%" align="center" class="txt"><input type="password" name="password"></td>
                                </tr>
                                <tr  bgcolor="#FFFFFF">
                                    <td width="10%" align="left" class="txt">ȷ�����룺</td>
                                    <td width="15%" align="center" class="txt"><input type="password" name="repassword"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table><br><center>
    <input type="submit" value="�޸�">&nbsp;<input type="button" value="�ر�" onclick="javascript:window.close();"></center>
</form>
</body>
</html>
