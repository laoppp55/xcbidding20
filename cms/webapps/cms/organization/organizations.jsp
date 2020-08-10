<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="com.bizwink.po.Companyinfo" %>
<%@ page import="com.bizwink.po.Department" %>
<%@ page import="com.bizwink.service.CompanyService" %>
<%@ page import="com.bizwink.service.DeptService" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-1-10
  Time: 下午11:50
  To change this template use File | Settings | File Templates.
--%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    List<Organization> organizations =null;
    List<Companyinfo> companyinfos = null;
    List<Department> departments = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        OrganizationService organizationService = (OrganizationService)appContext.getBean("organizationService");
        organizations = organizationService.getFirstLevelOrg(BigDecimal.valueOf(authToken.getSiteID()));
    }

    System.out.println("size:" + organizations.size());

    if (organizations!=null) {
        String jsondata="{\"total\":" + organizations.size() + ",\"rows\":[\r\n";
        CompanyService  companyService = (CompanyService)appContext.getBean("companyService");
        DeptService deptService = (DeptService)appContext.getBean("deptService");
        for(int ii=0;ii<organizations.size();ii++) {
            Organization organization = organizations.get(ii);
            String contactor = null;
            String phone = null;
            String mphone = null;
            String email = null;
            String code = null;
            int cotype = organization.getCOTYPE().intValue();
            if(cotype ==1) {
                companyinfos = companyService.getCompanyinfo(BigDecimal.valueOf(authToken.getSiteID()),organization.getID());
                contactor = companyinfos.get(0).getCONTACTOR();
                phone = companyinfos.get(0).getCOMPANYPHONE();
                mphone = companyinfos.get(0).getMPHONE();
                email = companyinfos.get(0).getCOMPANYEMAIL();
                code = companyinfos.get(0).getCOMPCODE();
            } else {
                departments = deptService.getDepartmentByOrgid(BigDecimal.valueOf(authToken.getSiteID()),organization.getID());
                contactor = departments.get(0).getLEADER();
                phone = departments.get(0).getTELEPHONE();
                mphone = departments.get(0).getTELEPHONE();
                email = departments.get(0).getEMAIL();
                code = departments.get(0).getENAME();
            }
            int pid = organization.getPARENT().intValue();
            if (ii<organizations.size()-1) {
                if (pid>0) {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code + "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"closed\"":"") + "},";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\""+organization.getNAME()  + "\",\"CODE\":\""+ code + "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) +  "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"closed\"":"") + "},";
                } else {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code + "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) +  "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"open\"":"") + "},";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code + "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"open\"":"") + "},";
                }
            } else {
                if (pid>0) {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code + "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"closed\"":"") + "}";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code + "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"closed\"":"") + "}";
                } else {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code +  "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"open\"":"") + "}";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"CODE\":\""+ code +  "\",\"CONTACTOR\":\"" + ((contactor==null)?"":contactor) + "\",\"PHONE\":\"" + ((phone==null)?"":phone) + "\",\"MPHONE\":\"" + ((mphone==null)?"":mphone) + "\",\"EMAIL\":\"" + ((email==null)?"":email) + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + ",\"ISLEAF\":" + organization.getISLEAF().intValue() + ((organization.getISLEAF().intValue()==1)?",\"state\":\"open\"":"") + "}";
                }
            }
        }
        jsondata = jsondata +"]}";
        //System.out.println(jsondata);
        out.print(jsondata);
        out.flush();
    } else {
        System.out.println("error");
        out.print("nodata");
        out.flush();
    }
%>