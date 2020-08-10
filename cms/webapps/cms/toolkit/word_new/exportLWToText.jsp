<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.webapps.leaveword.*" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page contentType="text/html;charset=gbk" pageEncoding="gbk" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String userid = authToken.getUserID();
    String sitename = authToken.getSitename();
    int siteid = authToken.getSiteID();
    int markid = ParamUtil.getIntParameter(request,"markid",0);
    //type=0 ���ŵ����԰����Ա������Ϣ   type=1���԰����Ա������Ϣ��ֻ���������԰����Ա�ش��������Ϣ
    int type = ParamUtil.getIntParameter(request,"type",0);
    String appPath = application.getRealPath("/");

    IUserManager uMgr = UserPeer.getInstance();
    IWordManager wordMgr = LeaveWordPeer.getInstance();
    User user = new User();
    user = uMgr.getUser(userid, siteid);
    String department = user.getDepartment();
    String filename = "";
    if (type == 0)
        filename = wordMgr.exportContentForLWManagerOfDept(siteid,markid,userid,department,sitename,appPath);
    else
        filename = wordMgr.exportContentForLWManager(siteid,markid,userid,sitename,appPath);
    if (filename != null && filename!="") {
        response.sendRedirect(response.encodeRedirectURL("download.jsp?file=" + filename + "&lwid=" + markid));
        return;
    }
%>