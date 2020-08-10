<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.po.Companyinfo" %>
<%@ page import="com.bizwink.po.Department" %>
<%@ include file="../include/auth.jsp"%>
<%
    if (!SecurityCheck.hasPermission(authToken, 54))
    {
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
        return;
    }

    boolean error = false;
    int siteID = authToken.getSiteID();
    String username = authToken.getUserID();

    String userid    = ParamUtil.getParameter(request,"userid");
    String nickname  = ParamUtil.getParameter(request,"username");
    String password  = ParamUtil.getParameter(request,"passwd");
    List rightList   = ParamUtil.getParameterValues(request,"rightList");
    boolean doCreate = ParamUtil.getBooleanParameter(request,"doCreate");
    List rolesList = ParamUtil.getParameterValues(request,"roles");
    int departmentarticles = ParamUtil.getIntParameter(request,"departmentarticle",0);
    List departmentarticleslist = ParamUtil.getParameterValues(request,"drList");
    String emailaccount = ParamUtil.getParameter(request,"emailaccount");
    String emailpasswd = ParamUtil.getParameter(request,"emailpasswd");
    String lw = ParamUtil.getParameter(request, "lw");
    String deptlw = ParamUtil.getParameter(request, "deptlw");
    ApplicationContext appContext = SpringInit.getApplicationContext();

    if (doCreate) {
        if (userid == null || password == null) error = true;
    }

    if (!error && doCreate) {
        int orgid = ParamUtil.getIntParameter(request,"org",0);
        String departmentarticleids = "";
        for(int i = 0;i<departmentarticleslist.size();i++){
            if(i == departmentarticleslist.size()-1) {
                departmentarticleids += (String)departmentarticleslist.get(i);
            }else {
                departmentarticleids += (String)departmentarticleslist.get(i) + ",";
            }
        }
        IUserManager userMgr = UserPeer.getInstance();
        try {
            List<Companyinfo> companyinfos = new ArrayList<Companyinfo>();
            List<Department> departments = new ArrayList<Department>();
            if (appContext!=null) {
                OrganizationService organizationService = (OrganizationService)appContext.getBean("organizationService");
                departments = organizationService.getADepartmentByOrgid(BigDecimal.valueOf(siteID),BigDecimal.valueOf(orgid));
                companyinfos = organizationService.getMainCompaniesByOrgid(BigDecimal.valueOf(siteID),BigDecimal.valueOf(orgid));
            }

            boolean IsExit = userMgr.existUser(userid,siteID);
            if (!IsExit) {
                User newUser = new User();
                newUser.setID(userid);
                newUser.setSiteid(siteID);
                newUser.setPassword(password);
                newUser.setNickName(nickname);
                newUser.setRightList(rightList);
                newUser.setOrgid(orgid);
                if (departments.size()>=1) {
                    newUser.setDepartment(departments.get(0).getCNAME());
                    newUser.setDeptid(departments.get(0).getID().intValue());
                }else {
                    newUser.setDepartment("");
                    newUser.setDeptid(0);
                }
                if (companyinfos.size()>=1) {
                    newUser.setCompany(companyinfos.get(0).getCOMPANYNAME());
                    newUser.setCompanyid(companyinfos.get(0).getID().intValue());
                }else {
                    newUser.setCompany("");
                    newUser.setCompanyid(0);
                }
                newUser.setRolesList(rolesList);
                newUser.setDepartmentarticlestype(departmentarticles);
                newUser.setDepartmentarticlesids(departmentarticleids);
                newUser.setEmailaccount(emailaccount);
                newUser.setEmailpasswd(emailpasswd);
                newUser.setLw(lw);
                newUser.setDeptlw(deptlw);
                userMgr.create(newUser,username);
                out.println("<SCRIPT LANGUAGE=javascript>opener.history.go(0);window.close();</SCRIPT>");
                return;
            } else {
                out.println("<SCRIPT LANGUAGE=javascript>alert('���û����Ѵ��ڣ�');history.go(-1);</SCRIPT>");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    IRightsManager rightsManager = RightsPeer.getInstance();
    rightList = rightsManager.getRights();       //��ȡ����Ȩ��
    IUserManager uMgr = UserPeer.getInstance();
    List departmentList = uMgr.getDepartments(siteID);

    List<Organization> organizations =null;
    String optionVals = null;
    if (appContext!=null) {
        OrganizationService organizationService = (OrganizationService) appContext.getBean("organizationService");
        optionVals = organizationService.getOrgOptionsByCustomerid(BigDecimal.valueOf(authToken.getSiteID()), -1);
    }

    /*String jsondata=null;
    if (organizations!=null) {
        jsondata = "[\r\n";
        for(int ii=0;ii<organizations.size();ii++) {
            Organization organization = organizations.get(ii);
            int pid = organization.getPARENT().intValue();
            if (ii<organizations.size()-1) {
                if (pid==0)
                    jsondata = jsondata + "{id:" +organization.getID().intValue() + ",pId:"+ pid + ",name:\"" + organization.getNAME() +"\",url:\"\"" + ",open:\"true\"" +"},\r\n";
                else
                    jsondata = jsondata + "{id:" +organization.getID().intValue() + ",pId:"+ pid + ",name:\"" + organization.getNAME() +"\",url:\"\"" + "},\r\n";
            } else {
                if (pid==0)
                    jsondata = jsondata + "{id:" +organization.getID().intValue() + ",pId:"+ pid + ",name:\"" + organization.getNAME() +"\",url:\"\"" + ",open:\"true\"" +"}\r\n";
                else
                    jsondata = jsondata + "{id:" +organization.getID().intValue() + ",pId:"+ pid + ",name:\"" + organization.getNAME() +"\",url:\"\"" + "}\r\n";
            }
        }
        jsondata = jsondata +"]";
    }*/
%>

<html>
<head>
    <title>�������û�</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script LANGUAGE="JavaScript" SRC="../js/check.js"></script>
    <SCRIPT LANGUAGE=javascript>
        function checkinput(form)
        {
            if (!InputValid(form.userid, 1, "string", 0, 0, 0,"�û���"))
                return (false);
            if (!validpassword( form.passwd.value, form.confirm.value ))
                return (false);
            if (!InputValid(form.username, 1, "string", 1, 2, 12,"�û�����"))
                return (false);

            var el = form.rightList;
            for (var i=el.options.length-1; i>=0; i--)
            {
                el.options[i].selected = true;
            }
            if(form.departmentarticle.value == 2)
            {
                var e2 = form.drList;
                if(e2.options.length == 0)
                {
                    alert("��ѡ����˵Ĳ��ţ�");
                    return false;
                }
                for (var a = e2.options.length - 1; a >= 0; a--)
                {
                    e2.options[a].selected = true;
                }
            }
            return true;
        }

        var rights_sel = "";
        function selectList(srcList,desList)
        {
            seleflg = false;
            for(i = srcList.length - 1; i >= 0; i--)
            {
                if(srcList.options[i].selected == true)
                {
                    var oOption = document.createElement("OPTION");
                    oOption.value = srcList.options[i].value;
                    oOption.text = srcList.options[i].text;
                    desList.add(oOption);
                    srcList.options[i] = null;
                    seleflag = true;
                }
                else
                {
                    continue;
                }
            }
            if (!seleflag)
            {
                alert ("��û��ѡ��Ȩ�ޣ���ѡ��");
                return false;
            }
        }
        function selectdepartmentarticles(type)
        {
            userForm.departmentarticle.value = type;
            if(type == 2)
            {
                userForm.add1.disabled = false;
                userForm.delete1.disabled = false;
            }
            else
            {
                userForm.add1.disabled = true;
                userForm.delete1.disabled = true;
            }
        }
    </SCRIPT>
</head>

<body bgcolor="#cccccc">
<form name="userForm" method="post"  onsubmit="return checkinput(this);">
    <input type="hidden" name="doCreate" value="true">
    <input type="hidden" name="departmentarticle" value="0">
    <input type="hidden" name="lw" value="">
    <input type="hidden" name="deptlw" value="">
    <table width="100%" border="0" align="center">
        <tr>
            <td align=right>�û�������</td>
            <td>&nbsp;<input type="text" name="username"></td>
        </tr>
        <tr>
            <td width="20%" align=right>�û�����</td>
            <td>&nbsp;<input type="text" name="userid" value="<%=((userid==null)?"":userid)%>"></td>
        </tr>
        <tr>
            <td align=right height="25">���룺</td>
            <td>&nbsp;<input type="password" name="passwd"></td>
        </tr>
        <tr>
            <td align=right>ȷ�����룺</td>
            <td>&nbsp;<input type="password" name="confirm"></td>
        </tr>
        <tr>
            <td align=right>��Ȩ�б�</td>
            <td>
                <table width="75%" border="0" cellspacing=2 cellpadding=1>
                    <tr>
                        <td width="44%">��ѡȨ��<br>
                            <select name="leftList" size="9" multiple style="width:200;font-size:9pt">
                                <%for (int i=0; i<rightList.size(); i++) {
                                    int rightid = ((Rights)(rightList.get(i))).getRightID();
                                    String rightname =  StringUtil.gb2iso4View(((Rights)(rightList.get(i))).getRightCName());
                                %>
                                <option value="<%=rightid%>">&nbsp;<%=rightname%></option>
                                <%}%>
                            </select>
                        </td>
                        <td valign="middle">
                            <input type="button" name="add" value=" > " onclick="return selectList(this.form.leftList,this.form.rightList)"><br><br>
                            <input type="button" name="delete" value=" < " onclick="return selectList(this.form.rightList,this.form.leftList)">
                        </td>
                        <td width="44%" valign="top" align="center">����Ȩ��<br>
                            <select name="rightList" size="9" multiple style="width:200;font-size:9pt"></select>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align=right>���ڵ�λ���ţ�</td>
            <td>&nbsp;<select name="org" id="orgid" style="width:200px;font-size:9pt">
                <option value="0">��ѡ��</option>
                <%=optionVals%>
            </select> </td>
        </tr>
        <tr>
            <td colspan="2" height="40" align="center">
                <input type="submit" class=tine value="  ����  ">&nbsp;&nbsp;
                <input type="button" class=tine value="  ȡ��  " onclick="window.close();">
            </td>
        </tr>
    </table>
</form>

</body>
</html>