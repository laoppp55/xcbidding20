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
        <table border="0" width="100%" height="178">
            <tr>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/survey.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/mail.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/0079.GIF" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="18"><a href="survey/index.jsp">网上调查</a></td>
                <td width="15%" align="center" height="18"><a href="comment/index.jsp">评论管理</a></td>
                <td width="15%" align="center" height="18"><a href="HisArchive/index.jsp">档案管理</a></td>
                <td width="15%" align="center" height="18"><a href="keywords/index.jsp">关键词库管理</a></td>
                <td width="15%" align="center" height="18"><a href="logana/index.jsp">网站浏览量统计分析</a></td>
                <td width="15%" align="center" height="18"><a href="editorworking/index.jsp">信息维护量统计分析</a></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/survey.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/mail.gif" width="32" height="32"></td>
               <%-- <td width="15%" align="center" height="34"><img border="0" src="../images/toolkit/0079.GIF" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>--%>
            </tr>
            <tr>
                <td width="15%" align="center" height="18"><a href="business/member/index2.jsp">客户管理</a></td>
                <td width="15%" align="center" height="18"><a href="business/order/index.jsp">订单管理</a></td>
                <td width="15%" align="center" height="18"><a href="trainclass/index.jsp">课程管理</a></td>
                <td width="15%" align="center" height="18"><a href=""></a></td>
                <td width="15%" align="center" height="18"><a href=""></a></td>
                <td width="15%" align="center" height="18"><a href=""></a></td>
            </tr>
            <!--tr>
                <td width="15%" align="center" height="18"><a href="survey/index.jsp" target="_blank">网上调查</a></td>
                <td width="15%" align="center" height="18"><a href="comment/index.jsp" target="_blank">评论管理</a></td>
                <td width="15%" align="center" height="18"><a href="feedback/index.jsp" target="_blank">信息反馈</a></td>
                <td width="15%" align="center" height="18"><a href="product/index.jsp" target=_parent>物资管理</a></td>
                <td width="15%" align="center" height="18"><a href="address_list/list.jsp"  target="_blank">我的通讯录</a></td>
                <td width="15%" align="center" height="18"><a href="companyinfo/index.jsp"  target="_blank">企业信息管理</a></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/bbs.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/bbs.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="18"><a href="product/index.jsp" target=_parent>产品管理</a></td>
                <td width="15%" align="center" height="18"><a href="business/index1.jsp" target=_parent>电子商务</a></td>
                <td width="15%" align="center" height="18"><a href="fee/index.jsp"  target="_blank">送货方式管理</a></td>
                <td width="15%" align="center" height="18"><a href="sendway/index.jsp"  target="_blank">支付方式管理</a></td>
                <td width="15%" align="center" height="18"><a href="score/index.jsp"  target="_blank">积分抵扣管理</a></td>
                <td width="15%" align="center" height="18"><a href="card/index.jsp"  target="_blank">离线购物券</a></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="18"><a href="bjhqfw/index.jsp"  target="_blank">会议室预定管理</a></td>
                <td width="15%" align="center" height="18"><a href="business/member/index2.jsp"  target="_blank">用户信息管理</a></td>
                <td width="15%" align="center" height="18"><a href="meeting/index.jsp"  target="_blank">会议管理</a></td>
                <td width="15%" align="center" height="18"><a href="word/index.jsp"  target="_blank">网站留言管理</a></td>
                <td width="15%" align="center" height="18"><a href="rsbtorg/index.jsp" target="_blank">企业用户管理</a></td>
                <td width="15%" align="center" height="18"><a href="workday/index.jsp" target="_blank">工作日管理</a></td>
            </tr>
            <tr>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="15%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="18"><a href="appointment/index1.jsp"  target="_blank">业务预定信息管理</a></td>
                <td width="25%" align="center" height="18"><a href="appointment/index.jsp"  target="_blank">业务预定码管理</a></td>
                <td width="25%" align="center" height="18"><a href="sjs_log/index.jsp"  target="_blank">石景山网站群文章录入查询</a></td>
                <td width="25%" align="center" height="18"><a href="bjhqfw/index.jsp"  target="_blank">侨联专用后台管理功能</a></td>
            </tr>
            <tr>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
                <td width="25%" align="center" height="54"><img border="0" src="../images/toolkit/say.gif" width="32" height="32"></td>
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
