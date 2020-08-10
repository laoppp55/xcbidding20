<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.toolkit.gwcase.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 5);
    int flag = ParamUtil.getIntParameter(request, "flag", 2);                        //Ĭ��ֵ��ʾ����ȫ����Ϣ
    int docreate = ParamUtil.getIntParameter(request,"docreate",-1);

    IGWcaseManager GWMgr = GwcasePeer.getInstance();
    List list = new ArrayList();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>����ҵ�����������ʾ</title>
</head>

<body>
<form action="addnew.jsp" method="post" name="addnew">
    <input type ="hidden" name="docreate" value="1">
    <input type="hidden" name="range" value="<%=range%>">
    <input type="hidden" name="startrow" value="<%=startrow%>">
    <input type="hidden" name="flag" value="<%=flag%>">
    <table width="735" border="0">
        <tr>
            <td width="221">������Ŀ����(caseID)��</td>
            <td width="354"><label>
                <input type="text" name="caseid" id="caseidld" />
            </label></td>
            <td width="146">&nbsp;</td>
        </tr>
        <tr>
            <td>������Ŀ����(caseName)��</td>
            <td><label>
                <input type="text" name="casename" id="casenameid" />
            </label></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>sn</td>
            <td><input type="text" name="sn" id="snid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>������(operator)��</td>
            <td><input type="text" name="operator" id="operatorid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>��������(applydate)��</td>
            <td><input name="year" type="text" id="yearid" size="4" />  <input name="month" type="text" id="monthid" size="4" /> <input name="day" type="text" id="dayid" size="4" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>�����˵绰(telephone)��</td>
            <td><input type="text" name="telephone" id="telephoneid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>���빫˾����(applicant)��</td>
            <td><input type="text" name="company" id="companyid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>���빫˾�绰(applicanttel)��</td>
            <td><input type="text" name="companytel" id="companytelid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>���빫˾ID(applicantid)��</td>
            <td><input type="text" name="applicantid" id="applicantidid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>ע���(registerno)��</td>
            <td><input type="text" name="registerno" id="registernoid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>����(charge)��</td>
            <td><input type="text" name="charge" id="chargeid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>dt_operate</td>
            <td><input type="text" name="dtoperqate" id="dtoperateid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>��ʼ����(starttingdate)��</td>
            <td><input name="syear" type="text" id="syearid" size="4" />  <input name="smonth" type="text" id="smonthid" size="4" />  <input name="sday" type="text" id="sdayid" size="4" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>���֤����(licensename)��</td>
            <td><input type="text" name="licensename" id="licensenameid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>���֤����(licensecode)��</td>
            <td><input type="text" name="licensecode" id="licensecodeid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>������(result)��</td>
            <td><input type="text" name="result" id="resultid" /></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td  align="center">
              <input type="submit" name="ok" id="ok" value="�ύ" />            </td>
            <td><label>
              <input type="button" name="cancel" id="cancel" onclick="javascript:window.close()" value="����" />
            </label></td>
            <td>&nbsp;</td>
        </tr>
    </table>
</form>
</body>
</html>
