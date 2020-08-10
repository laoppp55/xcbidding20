<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.ICompanyinfoManager" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.CompanyinfoPeer" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.Meetting_sign" %>
<%@ page contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int success = ParamUtil.getIntParameter(request, "success", 0);

    ICompanyinfoManager meetingMgr = CompanyinfoPeer.getInstance();
    List currentlist = new ArrayList();


    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

    currentlist = meetingMgr.getAllmeeting_sign(startrow, range);
    rows = meetingMgr.getAllmeetingSignNum();

    if (rows < range) {
        totalpages = 1;
        currentpage = 1;
    } else {
        if (rows % range == 0)
            totalpages = rows / range;
        else
            totalpages = rows / range + 1;

        currentpage = startrow / range + 1;
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <title>�λ���ע����Ϣ����</title>
    <style type="text/css">
        <!--
        body {
            margin-top: 0px;
            margin-bottom: 0px;
        }
        -->
    </style>
    <link href="images/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        function golist(r){
            window.location = "index.jsp?startrow="+r;
        }

    </script>
</head>

<body>
<center>
    <table width="1000" border="0" cellpadding="0" cellspacing="0" class="bian">
        <tr>
            <td valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/></td>
                                    <td width="200" class="black12c">�λᵥλע����Ϣ����</td>
                                    <td width="450"></td>
                                    <td width="30" align="center"><img src="images/hb_01.jpg" width="11" height="7"/></td>
                                    <td width="100" class="black12c"></td>
                                    <td width="30" align="center"><img src="images/lv_01.jpg" width="11" height="7"/></td>
                                    <td width="37" class="black12c"><a href="../index.jsp">����</a></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td height="1" bgcolor="#898898"></td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="100" height="30" align="center" bgcolor="#F6F5F0" class="black12c">������</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" bgcolor="#F6F5F0" class="black12c">��˾����</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="100" align="center" bgcolor="#F6F5F0" class="black12c">��Ʊ̧ͷ</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" bgcolor="#F6F5F0" class="black12c">��Ʊ�ʼĵ�ַ</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="120" align="center" bgcolor="#F6F5F0" class="black12c">��������</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="100" align="center" bgcolor="#F6F5F0" class="black12c">��ѵ����</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="150" align="center" bgcolor="#F6F5F0" class="black12c">֧����ʽ</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" bgcolor="#F6F5F0" class="black12c">֧�����ں�ʱ��</td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" bgcolor="#F6F5F0" class="black12c">ע�����ں�ʱ��</td>
                                </tr>

                            </table>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <%
                                    if (currentlist != null) {
                                        for (int i = 0; i < currentlist.size(); i++) {
                                            Meetting_sign meetting_sign = (Meetting_sign) currentlist.get(i);
                                            int id = meetting_sign.getId();
                                            Long orderid = meetting_sign.getOrderid();
                                            String comapnyname = meetting_sign.getComapnyname();
                                            String invoicetitle = meetting_sign.getInvoicetitle();
                                            String address = meetting_sign.getAddress();
                                            String postcode = meetting_sign.getPostcode();
                                            Float fee = meetting_sign.getFee();
                                            int payway = meetting_sign.getPayway();
                                            Timestamp paytime = meetting_sign.getPaytime();
                                            Timestamp createtime = meetting_sign.getCreatedate();

                                %>
                                <tr>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td height="1" bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                    <td bgcolor="#898898"></td>
                                </tr>
                                <tr>
                                    <td width="100" height="30" align="center" class="black12c"><a href="sign_part.jsp?orderid=<%=orderid%>" target="_blank"><%=orderid%></a></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" class="black12c"><%=comapnyname==null?"":comapnyname%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="100" align="center" class="black12c"><%=invoicetitle==null?"":invoicetitle%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" class="black12c"><%=address==null?"":address%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="120" align="center"  class="black12c"><%=postcode==null?"":postcode%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="100" align="center" class="black12c"><%=fee%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="150" align="center" class="black12c"><%=payway==1?"����":"����֧��"%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" class="black12c"><%=paytime.toString().substring(0,10)%></td>
                                    <td width="1" bgcolor="#898898"></td>
                                    <td width="200" align="center" class="black12c"><%=createtime%></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td height="1" bgcolor="#898898"></td>
                    </tr>
                    <tr>
                        <td height="40" align="right" class="black12">
                            ����<%=rows%>����¼&nbsp;&nbsp;��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <%
                                if ((startrow - range) >= 0) {
                            %>
                            [<a href="index.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
                            <%}%>
                            <%
                                if ((startrow + range) < rows) {
                            %>
                            [<a href="index.jsp?startrow=<%=startrow+range%>">��һҳ</a>]
                            <%
                                }
                                if (totalpages > 1) {
                            %>
                            &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
                            <a href="###" onclick="golist((document.all('jump').value-1)*<%=range%>);">GO</a>
                            <%}%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</center>
</body>
</html>

