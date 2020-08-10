<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page language="java" contentType="text/html;charset=GBK" %>
<%
    int siteid = ParamUtil.getIntParameter(request, "siteid", -1);
    ICompanyinfoManager comMgr = CompanyinfoPeer.getInstance();
    int id = ParamUtil.getIntParameter(request, "id", -1);
    Companyinfo companyinfo = comMgr.getACompanyInfo(id);
    int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
    int sti = ParamUtil.getIntParameter(request, "startIndex", -1);
    int cuPage = ParamUtil.getIntParameter(request, "currPage", -1);

    if (startflag == 1) {
        String companyname = ParamUtil.getParameter(request, "companyname");
        String companyaddress = ParamUtil.getParameter(request, "companyaddress");
        String companyphone = ParamUtil.getParameter(request, "companyphone");
        String companyfax = ParamUtil.getParameter(request, "companyfax");
        String companywebsite = ParamUtil.getParameter(request, "companywebsite");
        String companyemail = ParamUtil.getParameter(request, "companyemail");
        String postcode = ParamUtil.getParameter(request, "postcode");
        String classification = ParamUtil.getParameter(request, "classification");
        String summary = ParamUtil.getParameter(request, "summary");
        float companylatitude = ParamUtil.getFloatParameter(request,"companylatitude",0f);
        float companylongitude = ParamUtil.getFloatParameter(request,"companylongitude",0f);
        String companypic = ParamUtil.getParameter(request,"companypic");
        
        int companyid = ParamUtil.getIntParameter(request, "companyid", -1);
        int startIndex = ParamUtil.getIntParameter(request, "startIndex", -1);
       // int currPage = ParamUtil.getIntParameter(request, "currPage", -1);

        Companyinfo company = new Companyinfo();
        company.setId(companyid);
        company.setCompanyname(companyname);
        company.setCompanyaddress(companyaddress);
        company.setCompanyphone(companyphone);
        company.setCompanyfax(companyfax);
        company.setCompanywebsite(companywebsite);
        company.setCompanyemail(companyemail);
        company.setPostcode(postcode);
        company.setClassification(classification);
        company.setSummary(summary);
        company.setCompanylatitude(companylatitude);
        company.setCompanylongitude(companylongitude);
        company.setCompanygooglecode(companygooglecode);
        company.setCompanypic(companypic);

        comMgr.modifyCompany(company);
        response.sendRedirect("index.jsp?siteid=" + siteid + "&startIndex=" + startIndex);
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
                    alert("��˾�绰�������������룡");
                    document.getElementById("companyphone").focus();
                    return false;
                }
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
        <form name="modifyForm" action="modifyCompany.jsp" method="post" onsubmit="javascritp:return check();">
            <input type="hidden" name="startflag" value="1">
            <input type="hidden" name="siteid" value="<%=siteid%>">
            <input type="hidden" name="companyid" value="<%=id%>">
            <input type="hidden" name="startIndex" value="<%=sti%>">
            <input type="hidden" name="currPage" value="<%=cuPage%>">

            <tr>
                <td>��˾����:</td>
                <td><input type="text" name="companyname"     size="30"
                           value="<%=companyinfo.getCompanyname()==null?"":StringUtil.gb2iso4View(companyinfo.getCompanyname())%>"></td>
            </tr>
            <tr>
                <td>��ַ:</td>
                <td><input type="text" name="companyaddress"  size="30"
                           value="<%=companyinfo.getCompanyaddress()==null?"":StringUtil.gb2iso4View(companyinfo.getCompanyaddress())%>"></td>
            </tr>
            <tr>
                <td>�绰:</td>
                <td><input type="text" name="companyphone"   size="30"
                           value="<%=companyinfo.getCompanyphone()==null?"":companyinfo.getCompanyphone()%>"></td>
            </tr>
            <tr>
                <td>����:</td>
                <td><input type="text" name="companyfax" size="30" value="<%=companyinfo.getCompanyfax()==null?"":companyinfo.getCompanyfax()%>">
                </td>
            </tr>
            <tr>
                <td>��ַ:</td>
                <td><input type="text" name="companywebsite"  size="30"
                           value="<%=companyinfo.getCompanywebsite()==null?"":companyinfo.getCompanywebsite()%>"></td>
            </tr>
            <tr>
                <td>����:</td>
                <td><input type="text" name="companyemail"  size="30"
                           value="<%=companyinfo.getCompanyemail()==null?"":companyinfo.getCompanyemail()%>"></td>
            </tr>
            <tr>
                <td>�ʱ�:</td>
                <td><input type="text" name="postcode" size="30" value="<%=companyinfo.getPostcode()==null?"":companyinfo.getPostcode()%>"
                           size="5"></td>
            </tr>
<tr>
    <td>����:</td>
    <td><input type="text" name="classification" size="30" value="<%=companyinfo.getClassification()==null?"":StringUtil.gb2iso4View(companyinfo.getClassification())%>"></td>
</tr>
<tr>
    <td>��γ:</td>
    <td><input type="text" name="companylatitude" size="30" value="<%=companyinfo.getCompanylatitude()==0?"":companyinfo.getCompanylatitude()%>"></td>
</tr>
<tr>
    <td>����:</td>
    <td><input type="text" name="companylongitude" size="30" value="<%=companyinfo.getCompanylongitude()==0?"":companyinfo.getCompanylongitude()%>"></td>
</tr>
<tr>
    <td>Google��:</td>
    <td><input type="text" name="companygooglecode" size="30" value="<%=companyinfo.getCompanygooglecode()==null?"":companyinfo.getCompanygooglecode()%>"></td>
</tr>
<tr>
    <td>ͼƬ:</td>
    <td><input type="file" name="companypic" size="30" value="<%=companyinfo.getCompanypic()==null?"":companyinfo.getCompanypic()%>" ></td>
</tr>
<tr>
    <td>���:</td>
    <td><textarea rows="5" cols="50" name="summary"></textarea></td>
</tr>
<tr>
    <td align="left" ><a href="index.jsp?siteid=<%=siteid%>&startIndex=<%=sti%>">����</a></td>
    <td align="right" ><input type="submit" value="�ύ�޸�"></td>

</tr>
        </form>
    </table>
</center>
</body>
</html></html>