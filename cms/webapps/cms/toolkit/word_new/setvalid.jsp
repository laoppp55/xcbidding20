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
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 100);
    int id = ParamUtil.getIntParameter(request,"id",0);
    int lwid = ParamUtil.getIntParameter(request,"lwid",0);
    int doflag = ParamUtil.getIntParameter(request,"doflag",0);
    IWordManager wordMgr = LeaveWordPeer.getInstance();
    String title = null;
    String content = null;
    
    if (doflag == 1) {
        String reason = ParamUtil.getParameter(request,"valid");
        int validvalue = ParamUtil.getIntParameter(request,"validflag",0);
        System.out.println("validvalue=" + validvalue);
        boolean validflag = wordMgr.setValidForAWord(siteid,id,reason,validvalue);
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
    <title>�����û����Ե���Ч��</title>
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

<form action="setvalid.jsp" name="validform" method="post">
    <input type="hidden" name="lwid" value="<%=lwid%>">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="startrow" value="<%=startrow%>">
    <input type="hidden" name="range" value="<%=range%>">
    <input type="hidden" name="doflag" value="1">
    <table>
        <tr><td>���Ա��⣺</td><td><%=title%></td></tr>
        <tr><td>�������ݣ�</td><td><%=content%></td></tr>
        <tr><td colspan="2">    <select name="valid" id="validid">
            <option value ="0">��ѡ��</option>
            <%
                for(int i=0; i<valid.size(); i++) {
                    String itemcontent = (String)valid.get(i);
            %>
            <option value ="<%=i%>"><%=itemcontent%></option>
            <%}%>
        </select>
        </td></tr>
        <tr><td><input type="radio" name="validflag" value="0" <%=(word.getValid() == 0)?"checked":""%>>��Ч</td><td><input type="radio" name="validflag" value="1" <%=(word.getValid() == 1)?"checked":""%>>��Ч</td></tr>
        <tr><td><input type="image" src="/webbuilder/sites/images/buttons/1284261358390.gif" value="ȷ��"></td><td><input type="image" src="/webbuilder/sites/images/buttons/1284463162171.jpg" value="ȡ��" onclick="javascript:window.close()"></td></tr>
    </table>
</form>
</body>
</html>