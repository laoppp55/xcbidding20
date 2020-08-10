<%@ page import="com.bizwink.cms.security.*,com.bizwink.cms.util.*,com.bizwink.cms.register.*" contentType="text/html;charset=gbk"%>
<%@ page import="com.xml.IFormManager" %>
<%@ page import="com.xml.FormPeer" %>
<%@ page import="java.util.List" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    String userid = authToken.getUserID();
    String baseDir= application.getRealPath("/");
    String password = (String)session.getAttribute("AD_Pass");
    IFormManager formpeer= FormPeer.getInstance();
    String sitename=authToken.getSitename();
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
        <td width="50%" class=line><a href="index.jsp">工具箱</a></td>
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
                <% if (SecurityCheck.hasPermission(authToken, 58)) {%>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/survey.gif" width="32" height="32"></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 57)) {%>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 59)) {%>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/mail.gif" width="32" height="32"></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 62)) {%>
                <td width="25%" align="center" height="34"><img border="0" src="../images/toolkit/0079.GIF" width="32" height="32"></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
            </tr>
            <tr>
                <% if (SecurityCheck.hasPermission(authToken, 58)) {%>
                <td width="25%" align="center" height="18"><a href="survey/index.jsp" target="_blank">在线调查</a></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 57)) {%>
                <td width="25%" align="center" height="18"><a href="word/index.jsp"  target="_blank">网站留言</a></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>                
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 59)) {%>
                <td width="25%" align="center" height="18"><a href="/webbuilder/toolkit/business/member/index2.jsp"  target="_blank">注册用户管理</a></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 62)) {%>
                <td width="25%" align="center" height="18"><a href="gwcase/index.jsp"  target="_blank">业务审批结果确认</a></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
            </tr>
            <tr>
                <% if (SecurityCheck.hasPermission(authToken, 60)) {%>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>                
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 61)) {%>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <td width="25%" align="center" height="54">&nbsp;</td>
            </tr>
            <tr>
                <% if (SecurityCheck.hasPermission(authToken, 60)) {%>
                <td width="25%" align="center" height="18"><a href="rsbtorg/index.jsp" target="_blank">企业用户管理</a></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <% if (SecurityCheck.hasPermission(authToken, 61)) {%>
                <td width="25%" align="center" height="18"><a href="workday/index.jsp" target="_blank">工作日管理</a></td>
                <%} else {%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <%}%>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <td width="25%" align="center" height="54">&nbsp;</td>
                <!--td width="25%" align="center" height="18"><a href="appointment/index1.jsp"  target="_blank">业务预定信息管理</a></td>
                <td width="25%" align="center" height="18"><a href="appointment/index.jsp"  target="_blank">业务预定码管理</a></td-->
            </tr>
            <!--tr>
                <td width="25%" align="center" height="18"><a href="comment/index.jsp" target="_blank">文章评论</a></td>
                <td width="25%" align="center" height="18"><a href="feedback/index.jsp" target="_blank">用户反馈</a></td>
                <td width="25%" align="center" height="18"><a href="business/index1.jsp" target=_parent>电子商务</a></td>
                <td width="25%" align="center" height="18"><a href="companyinfo/index.jsp"  target="_blank">企业信息管理</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="fee/index.jsp"  target="_blank">送货方式管理</a></td>
                <td width="25%" align="center" height="18"><a href="sendway/index.jsp"  target="_blank">支付方式管理</a></td>
                <td width="25%" align="center" height="18"><a href="score/index.jsp"  target="_blank">积分抵扣管理</a></td>
                <td width="25%" align="center" height="18"><a href="card/index.jsp"  target="_blank">离线购物券</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="gwcase/index.jsp"  target="_blank">无线电管理</a></td>
                <td width="25%" align="center" height="18"><a href="interphone/index.jsp"  target="_blank">对讲机</a></td>
                <td width="25%" align="center" height="18"><a href="appointment/index.jsp"  target="_blank">业务预定码管理</a></td>
                <td width="25%" align="center" height="18"><a href="appointment/index1.jsp"  target="_blank">业务预定信息管理</a></td>
            </tr-->
            <% if (sitename.equalsIgnoreCase("www_zhwzg_com")) {%>}
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="book/index.jsp"  target="_blank">赠书管理</a></td>
                <td width="25%" align="center" height="18">&nbsp;</td>
                <td width="25%" align="center" height="18">&nbsp;</td>
                <td width="25%" align="center" height="18">&nbsp;</td>
            </tr>
            <%}%>
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
