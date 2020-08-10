<%@page import="com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.sjswsbs.ReportGangdom" %>
<%@ page import="com.bizwink.cms.sjswsbs.IWsbsManager" %>
<%@ page import="com.bizwink.cms.sjswsbs.WsbsPeer" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int id = ParamUtil.getIntParameter(request, "id", 0);
    ReportGangdom reportGangdom = new ReportGangdom();
    IWsbsManager wsbsMgr = WsbsPeer.getInstance();
    reportGangdom = wsbsMgr.getByIdjwdh(id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>ʯ��ɽ��ɨ�ڳ���ר���</title>
    <link rel="stylesheet"  href="css/css_2008.css"/>
    <script type="text/javascript">
        function upaudit(){
            window.location.href="updateaudit.jsp?id=<%=reportGangdom.getId()%>&auditflag=<%=reportGangdom.getAuditflag()%>";
        }

    </script>
</head>

<body>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td><img src="images/2018-1pic.jpg" width="1000"/></td>
    </tr>
</table>
<div class="content">
    <div class="menu">
        <ul>
            <li><a href="3.html">���Ͼٱ���֪</a></li>
            <li><a href="6.html">�� �� �� ѯ </a></li>
        </ul>
    </div>
    <div class="nmjb">�����ٱ���</div>
    <table  width="1000"  border="0" cellspacing="0"  align="center">
        <tr>
            <td>
                <table width="900" border="1" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td height="50" colspan="4" align="center" bgcolor="#cae4ff">�ٱ�����Ϣ��ע��:���� <span class="red">*</span> �ı�����д��
                        </td>
                    </tr>
                    <tr>
                        <td width="154" height="40" align="right">�ա�������</td>
                        <td width="289">&nbsp;<%=reportGangdom.getJbrname()==null?"":reportGangdom.getJbrname()%></td>
                        <td width="152" align="right">���֤�ţ�</td>
                        <td width="295">&nbsp;<%=reportGangdom.getIdcardno()==null?"":reportGangdom.getIdcardno()%></td>
                    </tr>
                    <tr>
                        <td width="154" height="40" align="right">��ϵ��ʽ��</td>
                        <td width="289">&nbsp;<%=reportGangdom.getJbrlink()==null?"":reportGangdom.getJbrlink()%></td>
                        <td width="152" align="right">������ò��</td>
                        <td width="295">&nbsp;<%=reportGangdom.getJbrpolitical()==null?"":reportGangdom.getJbrpolitical()%></td>
                    </tr>
                    <tr>
                        <td width="154" height="40" align="right">�־�ס��ַ��</td>
                        <td width="289">&nbsp;<%=reportGangdom.getAddress()==null?"":reportGangdom.getAddress()%></td>
                        <td width="152" align="right">�� ��</td>
                        <td width="295">&nbsp;<%=reportGangdom.getJbrlevel()==null?"":reportGangdom.getJbrlevel()%></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="15"></td>
        </tr>
        <tr>
            <td> <table width="900" border="1" cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td height="50" colspan="4" align="center" bgcolor="#cae4ff">���ٱ��ˣ���λ����Ϣ��ע��:���� <span class="red">*</span> �ı�����д��
                    </td>
                </tr>
                <tr>
                    <td width="154" height="40" align="right">���ٱ���<span class="red">*</span>��</td>
                    <td width="289">&nbsp;<%=reportGangdom.getReportedname()==null?"":reportGangdom.getReportedname()%></td>
                    <td width="152" align="right">������λ<span class="red">*</span>��</td>
                    <td width="295">&nbsp;<%=reportGangdom.getDepartment()==null?"":reportGangdom.getDepartment()%></td>
                </tr>
                <tr>
                    <td width="154" height="40" align="right">ְ������<span class="red">*</span>��</td>
                    <td width="289">&nbsp;<%=reportGangdom.getRplevel()==null?"":reportGangdom.getRplevel()%></td>
                    <td width="152" align="right">���ڵ���<span class="red">*</span>��</td>
                    <td width="295">&nbsp;<%=reportGangdom.getCounty()==null?"":reportGangdom.getCounty()%></td>
                </tr>
                <tr>
                    <td width="154" height="40" align="right">��������<span class="red">*</span>��</td>
                    <td  colspan="4">&nbsp;<%=reportGangdom.getRplevel()==null?"":reportGangdom.getRplevel()%></td>
                </tr>
            </table></td>
        </tr>
        <tr>
            <td height="15"></td>
        </tr>
        <tr>
            <td>
                <table width="900" border="1" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td height="50" colspan="4" align="center" bgcolor="#cae4ff">�ٱ����ģ�ע��:���� <span class="red">*</span> �ı�����д��
                        </td>
                    </tr>
                    <tr>
                        <td width="210" height="40" align="right">����(���50��)<span class="red">*</span>��</td>
                        <td >&nbsp;<%=reportGangdom.getRepmaintitle()==null?"":reportGangdom.getRepmaintitle()%></td>

                    </tr>
                    <tr>
                        <td width="210" height="40" align="right">�������<span class="red">*</span>��</td>
                        <td >&nbsp;<%=reportGangdom.getRepclass()==null?"":reportGangdom.getRepclasses()%></td>
                    </tr>
                    <tr>
                        <td width="210" height="40" align="right">����ϸ��<span class="red">*</span>��</td>
                        <td >&nbsp;<%=reportGangdom.getRepclasses()==null?"":reportGangdom.getRepclasses()%></td>
                    </tr>
                    <tr>
                        <td width="210" align="right">��Ҫ���� (ʣ�� 3000��)<span class="red">*</span>��</td>
                        <td >&nbsp;<textarea name="" cols="" rows="" style="width:578px; height:250px; margin-top:10px;" readonly><%=reportGangdom.getReportedcontent()==null?"":reportGangdom.getReportedcontent()%></textarea></td>

                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="15"></td>
        </tr>
        <tr>
            <td>
                <table width="900" border="1" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td height="50" colspan="4" align="center" bgcolor="#cae4ff">����</td>
                    </tr>
                    <tr>
                        <td width="210" height="40" align="right">������</td>
                        <td >&nbsp;<%=reportGangdom.getFilename()==null?"":"<a target=\"_blank\" href='/sitesearch/download/"+reportGangdom.getFilename()+"'>�鿴����</a>"%></td>

                    </tr>
                    <tr>
                        <td width="210" height="40" align="right">��ѯ�룺</td>
                        <td >&nbsp;<%=reportGangdom.getSearchmsg()==null?"":reportGangdom.getSearchmsg()%></td>
                    </tr>
                    <tr>
                        <td width="210" height="40" align="right">����״̬��</td>
                        <td><font color="red"><%=reportGangdom.getAuditflag()==0?"δ����":"����"%></font></td>
                </table>
            </td>
        </tr>
        <tr>
            <td style=" padding-top:30px; padding-bottom:80px;" align="center"><input type="button" name="button" id="button" value="�ύ��������״̬" onclick="upaudit()" class="btn_2" /> &nbsp;&nbsp;&nbsp;
                </td>
        </tr>
    </table>
</div>
<div class="foot">
    <p>�й�������ʯ��ɽ�����ɼ��ίԱ�� ������ʯ��ɽ������ ��Ȩ����</p>
    <p>����������110107000001</p>
</div>
</body>
</html>
