<%@ page import="java.sql.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title></title>
    <link rel=stylesheet type=text/css href=style/global.css>
    <script language=javascript>
        function exit()
        {
            parent.window.location = "../../exit.jsp";
        }
    </script>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr bgcolor="#B30121">
        <td height="45">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td><img src="../../images/opencms.gif" width="163" height="45"></td>
                    <td align="right" valign="center">
                        <a href=../../help/index.htm target=_blank><img src=../../images/icon-help.gif width=37 height=43 border=0></a>
                        <a href=javascript:exit();><img src=../../images/icon-exit.gif width=34 height=43 border=0 alt=�˳�></a>
                    </td>
                </tr>
            </table>
        </td>
        <td bgcolor="#B30121">&nbsp;</td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr bgcolor="#000000">
        <td height="2"></td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFAD0C">
    <tr>
        <td height="23">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="100%" align="left">&nbsp;&nbsp;
                        <%
                            if((authToken != null)){
                                out.println("<a href=member/index2.jsp target=main>�ͻ�����</a>");
                            }else {
                                out.println("�ͻ�����");
                            }

                            /*if((authToken != null)){
                                out.println(" | <a href=supplier/supplier.jsp target=main>�����̹���</a>");
                            }else {
                                out.println(" | �����̹���");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=product/index.jsp target=main>��Ʒ����</a>");
                            }else {
                                out.println(" | ��Ʒ����");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=purchasemaster/purchasemaster.jsp target=main>��������</a>");
                            }else {
                                out.println(" | ��������");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=deliverymaster/deliverymaster.jsp target=main>��������</a>");
                            }else {
                                out.println(" | ��������");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=account/index.jsp target=main>�˻�����</a>");
                            }else {
                                out.println(" | �˻�����");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=changemaster/changemaster.jsp target=main>������</a>");
                            }else {
                                out.println(" | ������");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=account/index.jsp target=main>Ӧ���ʹ���</a>");
                            }else {
                                out.println(" | Ӧ���ʹ���");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=account/index.jsp target=main>Ӧ���ʹ���</a>");
                            }else {
                                out.println(" | Ӧ���ʹ���");
                            }*/

                            if((authToken != null)){
                                out.println("<a href=order/index.jsp target=main>��������</a>");
                            }else {
                                out.println("��������");
                            }

                            if((authToken != null)){
                                out.println(" | <a href=message/index.jsp target=main>վ����Ϣϵͳ</a>");
                            }else {
                                out.println(" | վ����Ϣϵͳ");
                            }


                            out.println(" | <a href=javascript:parent.window.location='../../index1.jsp';>����</a>");

                        %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>