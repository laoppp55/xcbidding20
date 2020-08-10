<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.webapps.leaveword.*" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteid = authToken.getSiteID();
    String userid = authToken.getUserID();
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 100);
    int id = ParamUtil.getIntParameter(request,"id",0);
    int lwid = ParamUtil.getIntParameter(request,"lwid",0);
    int doflag = ParamUtil.getIntParameter(request,"doflag",0);

    IWordManager wordMgr = LeaveWordPeer.getInstance();
    String userrole = "";
    List fl = wordMgr.getWordAuthorizedUser(userid,siteid);
    for (int i =0; i<fl.size(); i++) {
        authorizedform f1 = (authorizedform)fl.get(i);
        if (f1.getLwid() == lwid) {
            userrole = f1.getLwrole();
            break;
        }
    }

    String title = null;
    String content = null;

    if (doflag == 1) {
        boolean validflag = false;
        if (userrole.equalsIgnoreCase("���԰岿�Ź���Ա")) {
            validflag = wordMgr.retWordToManager(userid,siteid,lwid,id,1);            //���԰岿�Ź���Ա������Ϣ�����԰����Ա
        } else {
            validflag = wordMgr.retWordToManager(userid,siteid,lwid,id,0);            //��ͨԱ��������Ϣ�����԰岿�Ź���Ա
        }
        if (validflag == true) {
            response.sendRedirect(response.encodeRedirectURL("closewin.jsp?startrow=" + startrow + "&range=" + range + "&lwid=" + lwid));
            return;
        }
    }

    //��ȡ�û�������Ч�Ĵ�����Ϣ
    List valid = wordMgr.getValidReson(siteid);
    Word word = wordMgr.getAWord(id);

%>
<html>
<head>
    <title>�����û����Ը�����Ա</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <meta http-equiv="Pragma" content="no-cache">
</head>
<body>
<%
    if (word != null) {
        title = word.getTitle();
        content = word.getContent();
    }
%>

<form action="rettomanager.jsp" name="mform" method="post">
    <input type="hidden" name="lwid" value="<%=lwid%>">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="startrow" value="<%=startrow%>">
    <input type="hidden" name="range" value="<%=range%>">
    <input type="hidden" name="doflag" value="1">
    <table>
        <tr><td>���Ա��⣺</td><td><%=title%></td></tr>
        <tr><td>�������ݣ�</td><td><%=content%></td></tr>
        <tr><td colspan="2">�Ƿ���˸���Ϣ������Ա��</td></tr>
        <tr><td><input type="image" src="/webbuilder/sites/images/buttons/1284261358390.gif" value="ȷ��"></td><td><input type="image" src="/webbuilder/sites/images/buttons/1284463162171.jpg" value="ȡ��" onclick="javascript:window.close()"></td></tr>
    </table>
</form>
</body>
</html>