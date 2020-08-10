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
    reportGangdom = wsbsMgr.getByIddhjb(id);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>ʯ��ɽ��ɨ�ڳ���ר���</title>
    <link rel="stylesheet"  href="css/css_2008.css"/>

</head>

<body>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td><img src="images/2018-1pic.jpg" width="1000" height="131" /></td>
    </tr>
</table>
<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center" style="background-color:#e0f0fe;">
    <tr>
        <td align="center">
            <table width="900" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td><table width="900" border="1" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="50" colspan="4" align="center" bgcolor="#cae4ff">�ٱ�����Ϣ</td>
                        </tr>
                        <tr>
                            <td width="164" height="40" align="right">�ա�������</td>
                            <td width="376">&nbsp;<%=reportGangdom.getJbrname()==null?"--":reportGangdom.getJbrname()%></td>
                            <td width="139" align="right">�ԡ�����</td>
                            <td width="211">&nbsp;<%=reportGangdom.getSex()==1?"��":"Ů"%></td>
                        </tr>
                        <tr>
                            <td height="40" align="right">���֤�ţ� </td>
                            <td>&nbsp;<%=reportGangdom.getIdcardno()==null?"--":reportGangdom.getIdcardno()%></td>
                            <td align="right">��ϵ�绰��</td>
                            <td>&nbsp;<%=reportGangdom.getTelphone()==null?"--":reportGangdom.getTelphone()%></td>
                        </tr>
                        <tr>
                            <td height="40" align="right">��ϵ��ַ���ڵ�����</td>
                            <td>&nbsp;<%=reportGangdom.getAddress()==null?"--":reportGangdom.getAddress()%></td>
                            <td align="right">�������룺</td>
                            <td>&nbsp;<%=reportGangdom.getPostcode()==null?"--":reportGangdom.getPostcode()%></td>
                        </tr>
                        <!--tr>
                            <td height="40" align="right">��֤�룺</td>
                            <td>&nbsp;<input name="textfield4" type="text" id="textfield4" size="15" /></td>
                            <td>&nbsp;</td>
                            <td><a href="#">�����廻һ��</a></td>
                        </tr-->
                    </table></td>
                </tr>
                <tr>
                    <td><table width="900" border="1" cellspacing="0" cellpadding="0" style="margin-top:10px;">
                        <tr>
                            <td height="50" colspan="4" align="center" bgcolor="#cae4ff">���ٱ�����Ϣ</td>
                        </tr>
                        <tr>
                            <td width="161" height="40" align="right" class="red">�ա�������</td>
                            <td width="378">&nbsp;<%=reportGangdom.getReportedname()==null?"--":reportGangdom.getReportedname()%></td>
                            <td width="137" align="right">�¡����ţ�</td>
                            <td width="214">&nbsp;<%=reportGangdom.getEpithet()==null?"--":reportGangdom.getEpithet()%></td>
                        </tr>
                        <tr>
                            <td height="40" align="right">��ϵ�绰סַ�� </td>
                            <td>&nbsp;<%=reportGangdom.getRpaddress()==null?"--":reportGangdom.getRpaddress()%></td>
                            <td align="right">���֤�ţ�</td>
                            <td>&nbsp;<%=reportGangdom.getRpidcardno()==null?"--":reportGangdom.getRpidcardno()%></td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td><table width="900" border="1" cellspacing="0" cellpadding="0" style="margin-top:10px;">
                        <tr>
                            <td height="50" colspan="4" align="center" bgcolor="#cae4ff">�漰����</td>
                        </tr>
                        <tr>
                            <td width="195" height="40" align="right">ʡ���С��أ��������</td>
                            <td width="245">&nbsp;<%=reportGangdom.getProvince()==null?"--":reportGangdom.getProvince()%>
                                </td>
                            <td width="182">&nbsp;<%=reportGangdom.getCity()==null?"--":reportGangdom.getCity()%></td>
                            <td width="268">&nbsp;<%=reportGangdom.getCounty()==null?"--":reportGangdom.getCounty()%></td>
                        </tr>
                    </table></td></tr>
                <tr>
                    <td><table width="900" border="1" cellspacing="0" cellpadding="0" style="margin-top:10px;">
                        <tr>
                            <td height="50" align="center" bgcolor="#cae4ff" class="red">�ٱ�����</td>

                        </tr>
                        <tr>
                            <td align="center"><table width="98%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="left" valign="top">���������ʾ����д���ٱ���Υ�����������ʵ����������ʱ�䡢�ص㡢���ԭ�򡢺���������ˡ�֤�������������������ȡ�����������2000�֣��� </td>
                                </tr>
                                <tr>
                                    <td align="center"><label for="textarea"></label>
                                        <textarea name="textarea" id="textarea" cols="80" rows="10"><%=reportGangdom.getReportedcontent()%></textarea></td>
                                </tr>
                            </table></td>

                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td><table width="900" border="1" cellspacing="0" cellpadding="0" style="margin-top:10px;">
                        <tr>
                            <td height="50" align="center" bgcolor="#cae4ff">�Ƿ��й�ְ��Ա����</td>
                        </tr>
                        <tr>
                            <td>���Ǳ�������ǡ�����д�±�ְ��Ա�永��Ϣ������ʱ����д��</td>
                        </tr>
                        <tr>
                            <td><table width="898" border="1" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="40" colspan="6" align="center">�漰��ְ��Ա</td>
                                </tr>
                                <tr>
                                    <td width="114" height="40" align="right">�ա�������</td>
                                    <td width="141">&nbsp;<%=reportGangdom.getGzname()==null?"--":reportGangdom.getGzname()%></td>
                                    <td width="130" align="right">������λְ��</td>
                                    <td width="254">&nbsp;<%=reportGangdom.getUnittitle()==null?"--":reportGangdom.getUnittitle()%></td>
                                    <td width="103" align="right">��������</td>
                                    <td width="142">&nbsp;<%=reportGangdom.getUnlevel()==null?"--":reportGangdom.getUnlevel()%></td>
                                </tr>
                                <tr>
                                    <td colspan="6" style="padding:0px 8px;">�永��Ϣ����ʾ����д���ٱ���Υ�����������ʵ����������ʱ�䡢�ص㡢���ԭ�򡢺���������ˡ�֤�������������������ȡ�����������1000�֣���</td>
                                </tr>
                                <tr>
                                    <td colspan="6" align="center" style="padding:10px 0px;"><textarea name="textarea2" id="textarea2" cols="80" rows="10"><%=reportGangdom.getGzreportedcontent()==null?"":reportGangdom.getGzreportedcontent()%></textarea></td>
                                </tr>
                            </table></td>
                        </tr>
                    </table></td>
                </tr>

                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>


        </td>
    </tr>
</table>

</body>
</html>
