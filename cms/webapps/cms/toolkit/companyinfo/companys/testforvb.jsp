<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.*" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page language="java" contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteid = authToken.getSiteID();
    System.out.println("siteid=" + siteid);
    String sitename = authToken.getSitename();
    sitename = StringUtil.replace(sitename,".","_");
    String baseDir = request.getRealPath("/");
    String dir = baseDir + "sites" + java.io.File.separator + sitename + java.io.File.separator + "_company" + java.io.File.separator;
    int columnid = ParamUtil.getIntParameter(request,"column",0);
    ICompanyinfoManager companyManager = CompanyinfoPeer.getInstance();

    SmartUpload mySmartUpload = new SmartUpload();
    mySmartUpload.initialize(this.getServletConfig(),request,response);
    com.jspsmart.upload.File  tmpFile = null;
    try {
        mySmartUpload.upload();
        String startflag_s = mySmartUpload.getRequest().getParameter("startflag");
        System.out.println("startflag_s=" + startflag_s);
        int startflag = 0;
        if (startflag_s != null && startflag_s != "") startflag = Integer.parseInt(startflag_s);
        if (startflag == 1) {
            tmpFile = mySmartUpload.getFiles().getFile(0);
            columnid = Integer.parseInt(mySmartUpload.getRequest().getParameter("column"));
            companyClass companyclass = companyManager.getCompanyClass(columnid);
            String companyname = mySmartUpload.getRequest().getParameter("companyname");
            String companyaddress = mySmartUpload.getRequest().getParameter("companyaddress");
            String companyphone = mySmartUpload.getRequest().getParameter("companyphone");
            String companyfax = mySmartUpload.getRequest().getParameter("companyfax");
            String companywebsite = mySmartUpload.getRequest().getParameter("companywebsite");
            String companyemail = mySmartUpload.getRequest().getParameter("companyemail");
            String postcode = mySmartUpload.getRequest().getParameter("postcode");
            float companylatitude = Float.parseFloat(mySmartUpload.getRequest().getParameter("companylatitude"));
            float companylongitude = Float.parseFloat(mySmartUpload.getRequest().getParameter("companylongitude"));
            String summary = mySmartUpload.getRequest().getParameter("summary");

            Companyinfo company = new Companyinfo();
            company.setSiteid(siteid);
            company.setCompanyname(companyname);
            company.setCompanyaddress(companyaddress);
            company.setCompanyphone(companyphone);
            company.setCompanyfax(companyfax);
            company.setCompanywebsite(companywebsite);
            company.setCompanyemail(companyemail);
            company.setPostcode(postcode);
            company.setClassification(StringUtil.gb2iso4View(companyclass.getCname()));
            company.setCompanyclassid(columnid);
            company.setCompanylatitude(companylatitude);
            company.setCompanylongitude(companylongitude);
            company.setCompanypic(tmpFile.getFileName());
            company.setSummary(summary);

            ICompanyinfoManager comMgr = CompanyinfoPeer.getInstance();
            int companyid = comMgr.addCompanyInfo(company);

            //��������ļ�
            dir = dir + companyid + java.io.File.separator + "images";
            java.io.File dirFile = new java.io.File( dir );
            if ( !dirFile.exists()) {
                dirFile.mkdirs();
            }

            System.out.println("dir=" + dir);

            mySmartUpload.save( dir);
            mySmartUpload.stop();
            response.sendRedirect(response.encodeRedirectURL("../companys/closewin.jsp?column=" + columnid + "&siteid=" + siteid + "&fromflag=c"));
            return;
        }
    }catch ( Exception e ) {
        e.printStackTrace();
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

        function openmap() {
            //alert("hello word!!!");
            window.open("selectpoint.jsp?column=<%=columnid%>", "", "width=820,height=680,left=100,top=50,status,scrollbars");
        }
    </script>
</head>
<body>
<center>
    <table>
        <form name="addForm" action="createcompany.jsp" method="post" enctype="multipart/form-data" onsubmit="javascript:return check();">
            <input type="hidden" name="startflag" value="1">
            <input type="hidden" name="column" value="<%=columnid%>">
            <tr>
                <td>��ҵ����:</td>
                <td><input type="text" name="companyname" size="30" ></td>
            </tr>
            <tr>
                <td>��ַ:</td>
                <td><input type="text" name="companyaddress" size="30"></td>
            </tr>
            <tr>
                <td>�绰:</td>
                <td><input type="text" name="companyphone" size="30"></td>
            </tr>
            <tr>
                <td>����:</td>
                <td><input type="text" name="companyfax" size="30"></td>
            </tr>
            <tr>
                <td>��ַ:</td>
                <td><input type="text" name="companywebsite" size="30"></td>
            </tr>
            <tr>
                <td>����:</td>
                <td><input type="text" name="companyemail" size="30"></td>
            </tr>
            <tr>
                <td>�ʱ�:</td>
                <td><input type="text" name="postcode"size="30" ></td>
            </tr>
            <tr>
                <td>��γ:</td>
                <td><input type="text" name="companylatitude" size="30" readonly="true">&nbsp;&nbsp;
                    <input type="button" name="point" value="ѡ��γ��" onclick="javascript:openmap();"></td>
            </tr>
            <tr>
                <td>����:</td>
                <td><input type="text" name="companylongitude" size="30" readonly="true"></td>
            </tr>
            <tr>
                <td>ͼƬ:</td>
                <td><input type="file" name="companypic" size="30"></td>
            </tr>
            <tr>
                <td>���:</td>
                <td><textarea rows="5" cols="50" name="summary"></textarea></td>
            </tr>
            <tr>
                <td align="left"><input type="button" value="����" onclick="javascript:window.close();"></td>
                <td align="center"><input type="submit" value="�ύ"></td>
            </tr>
        </form>
    </table>
</center>
</body>
</html>