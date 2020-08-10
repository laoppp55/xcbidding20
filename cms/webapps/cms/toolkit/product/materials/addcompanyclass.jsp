<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="com.bizwink.cms.toolkit.company.*" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page language="java" contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int comtype = ParamUtil.getIntParameter(request, "companytype", -1);
    int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
    if (startflag == 1) {
        int companytype = ParamUtil.getIntParameter(request, "companytype", -1);
        String companyname = ParamUtil.getParameter(request, "companyname");
        String companyaddress = ParamUtil.getParameter(request, "companyaddress");
        String companyphone = ParamUtil.getParameter(request, "companyphone");
        String companyfax = ParamUtil.getParameter(request, "companyfax");
        String companywebsite = ParamUtil.getParameter(request, "companywebsite");
        String companyemail = ParamUtil.getParameter(request, "companyemail");
        String postcode = ParamUtil.getParameter(request, "postcode");
        String districtnumber = ParamUtil.getParameter(request, "districtnumber");
        String classification = ParamUtil.getParameter(request, "classification");
        String area = ParamUtil.getParameter(request, "area");
        String summary = ParamUtil.getParameter(request, "summary");

        Company company = new Company();
        company.setCompanyname(companyname);
        company.setCompanyaddress(companyaddress);
        company.setCompanyphone(companyphone);
        company.setCompanyfax(companyfax);
        company.setCompanywebsite(companywebsite);
        company.setCompanyemail(companyemail);
        company.setPostcode(postcode);
        company.setDistrictnumber(districtnumber);
        company.setClsaaification(classification);
        company.setArea(area);
        company.setSummary(summary);
        company.setStation(companytype);

        ICompanyManager comMgr = CompanyPeer.getInstance();
        comMgr.addCompany(company);
        response.sendRedirect("index.jsp?companytype=" + companytype);
    }
%>
<html>
<head>
    <title>��˾���ҳ��</title>
    <style type="text/css">
        td {
            font-size: 12px
        }
    </style>
    <script type="text/javascript">
        function check() {
            var companyname = document.getElementById("companyname").value;
            if (companyname == "") {
                alert("��˾���Ʋ���Ϊ��");
                document.getElementById("companyname").focus();
                return false;
            }

            var companyaddress = document.getElementById("companyaddress").value;
            if (companyaddress == "") {
                alert("��˾��ַ����Ϊ��");
                document.getElementById("companyaddress").focus();
                return false;
            }

            var companyphone = document.getElementById("companyphone").value;
            if (companyphone == "") {
                alert("��˾�绰����Ϊ��");
                document.getElementById("companyphone").focus();
                return false;
            }


            if (companyphone != "") {
                var filter = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;
                flag = filter.test(companyphone);
                if (!flag) {
                    alert("�绰�����������������룡");
                    document.getElementById("companyphone").focus();
                    return false;
                }
            }

            var districtnumber = document.getElementById("districtnumber").value;
            if (districtnumber == "") {
                alert("���Ų���Ϊ��");
                document.getElementById("districtnumber").focus();
                return false;
            }

            var area = document.getElementById("area").value;
            if (area == "") {
                alert("��������Ϊ��");
                document.getElementById("area").focus();
                return false;
            }

            var companyemail = document.getElementById("companyemail").value;
            if (companyemail != "") {
                var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
                flag = reg.test(companyemail);
                if (!flag) {
                    alert("�����ʽ����ȷ��");
                    document.getElementById("companyemail").focus();
                    return false;
                }
            }

            var postcode = document.getElementById("postcode").value;
            if (postcode != "") {   //���������ж�
                var pattern = /^[0-9]{6}$/;
                flag = pattern.test(postcode);
                if (!flag) {
                    alert("�Ƿ����������룡")
                    document.getElementById("postcode").focus();
                    return false;
                }
            }


        }
    </script>
</head>
<body>
<center>
<table>
<form name="addForm" action="addCompany.jsp" method="post" onsubmit="javascript:return check();">
<input type="hidden" name="startflag" value="1">
<input type="hidden" name="companytype" value="<%=comtype%>">
<tr>
    <td>��˾����:</td>
    <td><input type="text" name="companyname"></td>
</tr>
<tr>
    <td>��ַ:</td>
    <td><input type="text" name="companyaddress"></td>
</tr>
<tr>
    <td>�绰:</td>
    <td><input type="text" name="companyphone"></td>
</tr>
<tr>
    <td>����:</td>
    <td><input type="text" name="companyfax"></td>
</tr>
<tr>
    <td>��ַ:</td>
    <td><input type="text" name="companywebsite"></td>
</tr>
<tr>
    <td>����:</td>
    <td><input type="text" name="companyemail"></td>
</tr>
<tr>
    <td>�ʱ�:</td>
    <td><input type="text" name="postcode" size="5"></td>
</tr>
<tr>
    <td>����:</td>
    <td><input type="text" name="districtnumber"></td>
</tr>
<tr>
    <td>����:</td>
    <td><input type="text" name="classification"></td>
</tr>
<tr>
<td>����:</td>

<td><select name="area">

<option value="����">
    ����
</option>
<option value="�Ϻ�">
    �Ϻ�
</option>
<option value="���">
    ���
</option>
<option value="����">
    ����
</option>
<option value="�Ĵ�">
    �Ĵ�
</option>
<option value="����">
    ����
</option>
<option value="�㶫">
    �㶫
</option>
<option value="�㽭">
    �㽭
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="ɽ��">
    ɽ��
</option>
<option value="ɽ��">
    ɽ��
</option>
<option value="����">
    ����
</option>
<option value="�ӱ�">
    �ӱ�
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="������">
    ������
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="�ຣ">
    �ຣ
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="�½�">
    �½�
</option>
<option value="����">
    ����
</option>
<option value="����">
    ����
</option>
<option value="���ɹ�">
    ���ɹ�
</option>
<option value="����">
    ����
</option>
<option value="���">
    ���
</option>
<option value="����">
    ����
</option>
<option value="̨��">
    ̨��
</option>
</select></td>
</tr>
<tr>
    <td>���:</td>
    <td><textarea rows="5" cols="50" name="summary"></textarea></td>
</tr>
<tr>
    <td align="right" colspan="2"><input type="submit" value="�ύ"></td>
</tr>
</form>
</table>
</center>
</body>
</html>