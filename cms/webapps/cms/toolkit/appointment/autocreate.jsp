<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.webapps.appointment.IAppointmentManager" %>
<%@ page import="com.bizwink.webapps.appointment.AppointmentPeer" %>
<%@page contentType="text/html;charset=GBK" %>
<%
       String months = ParamUtil.getParameter(request,"month");
     Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
      if (authToken == null)
      {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
      }
      int siteid = authToken.getSiteID();
    if(months != null && !months.equals("") && !months.equals("null"))
    {
       String sqlnum = "select count(*) from tbl_Appointment where siteid = "+ siteid + " and appointmentdate >= '"+months+"-01' and appointmentdate <='"+months+"-31'";
        IAppointmentManager aMgr = AppointmentPeer.getInstance();
     int rows = aMgr.getAppointmentInfoNumForMonth(sqlnum);
        if(rows > 0 )
        {
            out.print("<script language=\"javascript\">alert(\"��������ԤԼ�룬�������ɣ�\");window.location=\"index.jsp\";</script>");
        }
        else
        {
             //����ԤԼ��
             aMgr.autoCreate(siteid,months);
            response.sendRedirect("index.jsp?month="+months+"-01");
        }
    }
    else
    {
        response.sendRedirect("index.jsp");
    }
%>