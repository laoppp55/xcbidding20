<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken == null)
	{
		response.sendRedirect( "../login.jsp" );
		return;
	}
	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
		return;
	}


	int siteID = authToken.getSiteID();
    int startflag = ParamUtil.getIntParameter(request,"startflag",0);
    int id = ParamUtil.getIntParameter(request,"id",0);
    IUserManager uMgr = UserPeer.getInstance();
    if(startflag == 1)
    {
        String cname = ParamUtil.getParameter(request,"cname");
        String ename = ParamUtil.getParameter(request,"ename");
        String phone = ParamUtil.getParameter(request,"phone");
        String manager = ParamUtil.getParameter(request,"manager");
        String vmanager = ParamUtil.getParameter(request,"vmanager");
        String leader = ParamUtil.getParameter(request,"leader");
        Department dept = new Department();
        dept.setId(id);
        dept.setCname(cname);
        dept.setEname(ename);
        dept.setLeader(leader);
        dept.setManager(manager);
        dept.setVicemanager(vmanager);
        dept.setTelephone(phone);
        dept.setSiteid(siteID);

        uMgr.update(dept) ;
        out.print("<script language=\"javascript\">window.opener.history.go(0);window.close();</script>");
    }
    Department depts = uMgr.getOneDepartmentInfoById(id);
    String cname = null,ename=null,phone=null,manager=null,vmanager=null,leader=null;
    if(depts != null){
        cname = depts.getCname();
        ename = depts.getEname();
        phone = depts.getTelephone();
        manager = depts.getManager();
        vmanager = depts.getVicemanager();
        leader = depts.getLeader();
    }
%>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
    function check()
    {
        if(form.cname.value == "")
        {
            alert("�����벿����������");
            form.cname.onfocus();
            return false;
        }
        returnr true;
    }
    </script>
</head>
<body>
<center>
    <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="90%"
           align=center>
        <form name="form" action="editdepartment.jsp" method="post" onsubmit="return check();">
            <input type="hidden" name="startflag" value="1">
            <input type="hidden" name="id" value="<%=id%>">
            <tr bgcolor="#eeeeee" class=tine>
                <td height="50" width="50%" align=right>�����������ƣ�</td>
                <td height="50"  width="50%" align=left><input type="text" name="cname" value="<%=cname==null?"":StringUtil.gb2iso4View(cname)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td height="50"  width="50%" align=right>����Ӣ�����ƣ�</td>
                <td  height="50" width="50%" align=left><input type="text" name="ename" value="<%=ename==null?"":StringUtil.gb2iso4View(ename)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td height="50"  width="50%" align=right>�绰��</td>
                <td width="50%"  height="50" align=left><input type="text" name="phone" value="<%=phone==null?"":StringUtil.gb2iso4View(phone)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="50%" height="50"  align=right>����</td>
                <td width="50%"  height="50" align=left><input type="text" name="manager" value="<%=manager==null?"":StringUtil.gb2iso4View(manager)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="50%"  height="50" align=right>������</td>
                <td width="50%"  height="50" align=left><input type="text" name="vmanager" value="<%=vmanager==null?"":StringUtil.gb2iso4View(vmanager)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="50%"  height="50" align=right>�������Σ�</td>
                <td width="50%"  height="50" align=left><input type="text" name="leader" value="<%=leader==null?"":StringUtil.gb2iso4View(leader)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="80%" align=center colspan="2"><input type="submit" name="sub" value="�ύ"></td>
            </tr>
        </form>
    </table>
</center>
</body>
</html>