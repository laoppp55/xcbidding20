<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,"
          contentType="text/html;charset=gbk"
        %>
<%@ page import="java.util.List" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    int deptid = ParamUtil.getIntParameter(request,"dept",0);
    int lwid = ParamUtil.getIntParameter(request,"lwid",0);
    IUserManager userMgr = UserPeer.getInstance();
    List users = userMgr.getUsersBYDepartment(String.valueOf(deptid),siteid,lwid,"���԰岿�Ź���Ա");

    String users_str = "";
    for (int i=0; i<users.size(); i++) {
        User user = new User();
        user = (User)users.get(i);
        users_str = users_str + user.getNickName() + ":" + user.getUserID()+ ";";
    }
    if (users_str != null && users_str!="") {
        users_str = users_str.substring(0,users_str.length() - 1);
    }
    out.write(users_str);
%>
