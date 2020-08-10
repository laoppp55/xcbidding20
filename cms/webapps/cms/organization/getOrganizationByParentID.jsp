<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
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
    ApplicationContext appContext = SpringInit.getApplicationContext();
    int orgid = ParamUtil.getIntParameter(request,"orgid",0);

    if (appContext!=null) {
        OrganizationService organizationService = (OrganizationService)appContext.getBean("organizationService");
        organizations = organizationService.getSubOrgtreeByParant(BigDecimal.valueOf(authToken.getSiteID()), BigDecimal.valueOf(orgid));
    }

    if (organizations!=null) {
        String jsondata="{\"total\":" + organizations.size() + ",\"rows\":[\r\n";
        for(int ii=0;ii<organizations.size();ii++) {
            Organization organization = organizations.get(ii);
            int cotype = organization.getCOTYPE().intValue();
            int pid = organization.getPARENT().intValue();
            if (ii<organizations.size()-1) {
                if (organization.getID().intValue()>orgid) {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\"" + organization.getNAME() + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "},\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\"" + organization.getNAME() + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "},\r\n";
                } else {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "},\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "},\r\n";
                }
            } else {
                if (organization.getID().intValue()>orgid) {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\""+organization.getNAME() + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "}\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"_parentId\":" + pid + ",\"NAME\":\""+organization.getNAME() + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "}\r\n";
                } else {
                    if (cotype == 1)
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"COTYPE\":\"公司\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "}\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + organization.getID().intValue() + ",\"NAME\":\""+organization.getNAME() + "\",\"COTYPE\":\"部门\"" + ",\"ORDERID\":" + organization.getORDERID().intValue() + "}\r\n";
                }
            }
        }
        jsondata = jsondata +"]}";
        out.print(jsondata);
        out.flush();
    } else {
        out.print("nodata");
        out.flush();
    }
%>