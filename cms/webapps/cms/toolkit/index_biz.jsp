<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*,com.bizwink.cms.register.*" contentType="text/html;charset=gbk"%>
<%@ page import="com.xml.IFormManager" %>
<%@ page import="com.xml.FormPeer" %>
<%@ page import="java.util.List" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    RolesSet roleSet = authToken.getRoleSet();
    String baseDir= application.getRealPath("/");
    IFormManager formpeer= FormPeer.getInstance();
    String sitename=authToken.getSitename();
    System.out.println("���԰����" + SecurityCheck.hasPermission(authToken, 57));
    System.out.println("���ϵ���" + SecurityCheck.hasPermission(authToken, 58));
    System.out.println("ע���û�����" + SecurityCheck.hasPermission(authToken, 59));
    System.out.println("��ҵע���û�����" + SecurityCheck.hasPermission(authToken, 60));

    List list=formpeer.getFileXML(baseDir+"\\sites\\"+sitename+"\\_prog");
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <title></title>
</head>

<body>
<table class=line width="100%" border=0 cellspacing=0 cellpadding=0>
    <tr bgcolor=#003366><td height=2 colspan=2></td></tr>
    <tr>
        <td width="50%" class=line><a href="index.jsp">������</a></td>
        <td width="50%" align=right class=line></td>
    </tr>
    <tr bgcolor=#003366><td colspan=2 height=2></td></tr>
</table>

<br>
<br>
<br>
<div align="center">
    <center>
        <table border="0" width="90%" height="178">
            <tr>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/survey.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/mail.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/0079.GIF" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="survey/index.jsp" target="_blank">���ߵ���</a></td>
                <td width="25%" align="center" height="18"><a href="comment/index.jsp" target="_blank">��������</a></td>
                <td width="25%" align="center" height="18"><a href="feedback/index.jsp" target="_blank">�û�����</a></td>
                <td width="25%" align="center" height="18"><a href="business/index1.jsp" target=_parent>��������</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/bbs.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/bbs.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <!--%if (roleSet.contains("���԰����Ա") || roleSet.contains("���԰沿�Ź���Ա")) {%-->
                <td width="25%" align="center" height="18"><a href="word/index.jsp"  target="_blank">��վ����</a></td>
                <!--%} else {%-->
                 <!--td width="25%" align="center" height="18"></td-->
                <!--%}%-->
                <td width="25%" align="center" height="18"><a href="/webbuilder/toolkit/business/member/index2.jsp"  target="_blank">ע���û�����</a></td>
                <td width="25%" align="center" height="18"><a href="address_list/list.jsp"  target="_blank">�ҵ�ͨѶ¼</a></td>
                <td width="25%" align="center" height="18"><a href="companyinfo/index.jsp"  target="_blank">��ҵ��Ϣ����</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="fee/index.jsp"  target="_blank">�ͻ���ʽ����</a></td>
                <td width="25%" align="center" height="18"><a href="sendway/index.jsp"  target="_blank">֧����ʽ����</a></td>
                <td width="25%" align="center" height="18"><a href="score/index.jsp"  target="_blank">���ֵֿ۹���</a></td>
                <td width="25%" align="center" height="18"><a href="card/index.jsp"  target="_blank">���߹���ȯ</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="appointment/index1.jsp"  target="_blank">ҵ��Ԥ����Ϣ����</a></td>
                <td width="25%" align="center" height="18"><a href="appointment/index.jsp"  target="_blank">ҵ��Ԥ�������</a></td>
                <td width="25%" align="center" height="18"><a href="rsbtorg/index.jsp" target="_blank">��ҵ�û�����</a></td>
                <td width="25%" align="center" height="18"><a href="workday/index.jsp" target="_blank">�����չ���</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="invoice/index.jsp"  target="_blank">��Ʊ���ݹ���</a></td>
                <td width="25%" align="center" height="18"><a href="websites/index.jsp"  target="_blank">վ����Ϣ����</a></td>
                <td width="25%" align="center" height="18"><a href="../wenba/column/index.jsp" target="_blank">�ʰɷ��ඨ��</a></td>
                <td width="25%" align="center" height="18"><a href="../wenba/content/index.jsp" target="_blank">�ʰ����ݹ���</a></td>
            </tr>
            <!--tr>
                <%
                    int j=0;
                    for(int i=0;i<list.size();i++)
                    {
                        String xmlname=(String)list.get(i);
                        if(i%4==0&&i!=0)
                        {
                            out.write("<td width=\"25%\" align=\"center\" height=\"100\">&nbsp;</td>\n</tr><tr>      <td width=\"25%\" align=\"center\" height=\"34\"><img border=\"0\" src=\"../images/toolkit/say.gif\" width=\"32\" height=\"32\"></td>\n" +
                                    "      </tr>\n" +
                                    "      \n" +
                                    "      <tr>\n" +
                                    "      <td width=\"25%\" align=\"center\" height=\"54\">&nbsp;</td>\n" +

                                    "    </tr>");
                        }else{
                %>
                <td width="25%" align="center" height="18"><a href="xmlformlist/index.jsp?xmlname=<%=xmlname%>" target="_blank"><%=xmlname%></a></td>


                <%}  }
                %>
            </tr-->
        </table>
    </center>
</div>

</body>
</html>
