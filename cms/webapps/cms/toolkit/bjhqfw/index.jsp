<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.jspsmart.upload.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.jspsmart.upload.File" %>
<%@page contentType="text/html;charset=GBK"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

%>
<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <script language="JavaScript" src="include/setday.js" ></script>
    <meta http-equiv="Pragma" content="no-cache">
    <style type="text/css">
        TABLE {FONT-SIZE: 12px;word-break:break-all}
        BODY {FONT-SIZE: 12px;margin-top: 0px;margin-bottom: 0px; line-height:20px;}
        A:link {text-decoration:none;line-height:20px;}
        A:visited {text-decoration:none;line-height:20px;}
        A:active {text-decoration:none;line-height:20px; font-weight:bold;}
        A:hover {text-decoration:none;line-height:20px;}
    </style>
</head>
<body>
<center>
    <form name="form1" method="post" action="index.jsp">
        <table width="80%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
            <tr>
                <td>
                    <table width="100%" border="0" cellpadding="0">
                        <tr bgcolor="#F4F4F4" align="center">
                            <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">���ȷ������Ĺ���</td>
                        </tr>
                        <tr bgcolor="#d4d4d4" align="right">
                            <td>
                                <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        <td align="center" width="25%"><a href="jiben/index.jsp">�����һ�����Ϣ����</a></td>
                                        <td width="25%" align="center"><a href="yuding/index.jsp">������Ԥ������</a></td>
                                        <td align="center" width="25%"><a href="shetuan/index.jsp">�����û�����</a></td>
                                        <td align="center" width="25%"><a href="activity/index.jsp">���Ϣ����</a></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table> <br>
                    <%--<table width="100%"><tr><td align="center"><a href="#" onclick="searchcheck()">�� ��</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:history.go(-1);">ȡ ��</a></td></tr></table>--%>
                </td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>