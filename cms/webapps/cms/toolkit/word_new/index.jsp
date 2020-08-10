<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.webapps.leaveword.*" %>
<%@ page import="com.bizwink.cms.markManager.*" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteid = authToken.getSiteID();
    String userid = authToken.getUserID();

    //��ȡ��¼�û���Ȩ��������԰��
    //IWordManager wordMgr = LeaveWordPeer.getInstance();
    //List words = wordMgr.getWordAuthorizedUser(userid,siteid);
    IMarkManager markMgr = markPeer.getInstance();
    mark mk = null;
    List marks = markMgr.getMarksByType(siteid,21);               //21��ʾ�����Ա��ı������
%>
<html>
<head>
    <title>�û����Թ���</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
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
<input type="hidden" name="updateflag" value="1">
<center>
    <form action="index.jsp" method="post" name="form">
        <table width="90%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
            <tr>
                <td>
                    <table width="100%" border="0" cellpadding="0">
                        <tr bgcolor="#F4F4F4" align="center">
                            <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">�û����Թ���</td>
                        </tr>
                        <tr bgcolor="#d4d4d4" align="right">
                            <td>
                                <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                                    <tr  bgcolor="#FFFFFF" class="css_001">
                                        
                                        <td align="center" width="30%">���Ա�����</td>
                                    </tr>
                                    <%
                                        //for(int i = 0; i < words.size();i++){
                                        //    mk = new mark();
                                        //    authorizedform f1 = (authorizedform)words.get(i);
                                        //    mk = markMgr.getAMark(f1.getLwid());
                                        for(int i = 0; i < marks.size();i++){
                                            mk = new mark();
                                            mk = (mark)marks.get(i);
                                            mk = markMgr.getAMark(mk.getID());
                                    %>
                                    <tr  bgcolor="#FFFFFF" class="css_001">

                                          <td align="center" width="30%"><a href="index1.jsp?markid=<%=mk.getID()%>"><%=mk.getChineseName()%></a> </td>

                                    </tr>
                                    <%}%>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

    </form>
</center>
</body>
</html>