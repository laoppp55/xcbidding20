<%@ page import="com.bizwink.cms.security.*,
        com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.cms.security.SecurityCheck" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    String userid = authToken.getUserID();
    if (authToken == null)
    {
        return;
    }
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=style/global.css>
    <title></title>
    <script language=javascript>
        function go()
        {
            parent.document.location="exit.jsp";
        }

        function publish()
        {
            window.open("autoPublish/publish.jsp","SelectRight","top=10,left=10,width=190,height=80,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        <%if (authToken != null){%>
        window.status = "��ǰ�û�[<%=userid%>]    ��ǰվ��[<%=authToken.getSitename()%>]";
        <%}%>
    </script>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr bgcolor="#B30121">
        <td width="900" height="45">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="650"><img src="images/logo.gif" width="163" height="45">
                    </td>
                    <td width="250" align="center" valign="center">
                        &nbsp;&nbsp;&nbsp;
                        <a href=index1.jsp?type=0 target=_parent>��ҳ����</a>
                        <a href=index1.jsp?type=1 target=_parent>��Ʒ����</a>
                        <a href=help.html target=main><img src=images/icon-help.gif width=37 height=43 border=0></a>
                        <a href=javascript:go()><img src=images/icon-exit.gif width=34 height=43 border=0 alt=�˳�></a>
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
        <td width="900" height="25">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="700" align="left">
                        <%
                            out.println("&nbsp;&nbsp;&nbsp;&nbsp;");
                            if (userid.compareToIgnoreCase("admin") != 0)
                            {
                                if(((authToken != null) && SecurityCheck.hasPermission(authToken,1)) || SecurityCheck.hasPermission(authToken,54) ||SecurityCheck.hasPermission(authToken,9)){
                                    out.println("<a href=product/type/index.jsp?rightid=1 target=main>��Ʒ�������</a>");
                                }else {
                                    out.println("��Ʒ�������");
                                };

                                if(((authToken != null) && SecurityCheck.hasPermission(authToken,2)) || SecurityCheck.hasPermission(authToken,54) || SecurityCheck.hasPermission(authToken,9) ){
                                    out.println(" | <a href=product/template/index.jsp?rightid=2 target=main>ģ�����</a>");
                                }else {
                                    out.println(" | ģ�����");
                                }

                                if(((authToken != null) && SecurityCheck.hasPermission(authToken,3)) || SecurityCheck.hasPermission(authToken,54) || SecurityCheck.hasPermission(authToken,9) ){
                                    out.println(" | <a href=product/info/index.jsp?rightid=3 target=main>��Ʒ��Ϣ����</a>");
                                }else {
                                    out.println(" | ��Ʒ��Ϣ����");
                                }

                                if(((authToken != null)  && SecurityCheck.hasPermission(authToken,4)) || SecurityCheck.hasPermission(authToken,54) || SecurityCheck.hasPermission(authToken,9) ){
                                    out.println(" | <a href=product/upload/index.jsp?rightid=4 target=main>�ļ��ϴ�</a>");
                                }else {
                                    out.println(" | �ļ��ϴ�");
                                }

                                if(((authToken != null) && SecurityCheck.hasPermission(authToken,6)) || SecurityCheck.hasPermission(authToken,54) || SecurityCheck.hasPermission(authToken,9)){
                                    out.println(" | <a href=product/publish/index.jsp?rightid=6 target=main>��Ʒ��Ϣ����</a>");
                                }else {
                                    out.println(" | ��Ʒ��Ϣ����");
                                }
                            }
                            else
                            {
                                out.println("<a href=member/admin_index.jsp target=main>ϵͳ����</a>");
                                out.println(" | <a href='javascript:publish();'>�Զ�����</a>");
                            }
                        %>
                    </td>
                    <td width="20"></td>
                    <td width="180" align="center" valign="middle">&nbsp;&nbsp;����ӯ�̶�������������޹�˾</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>