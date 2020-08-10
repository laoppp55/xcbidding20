<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@page contentType="text/html;charset=utf-8" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken == null)
	{
		response.sendRedirect( "../login.jsp" );
		return;
	}
	if (!SecurityCheck.hasPermission(authToken, 54))
	{
		response.sendRedirect("../error.jsp?message=无管理用户的权限");
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
    function check()
    {
        if(form.cname.value == "")
        {
            alert("请输入部门中文名称");
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
                <td height="50" width="50%" align=right>部门中文名称：</td>
                <td height="50"  width="50%" align=left><input type="text" name="cname" value="<%=cname==null?"":StringUtil.gb2iso4View(cname)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td height="50"  width="50%" align=right>部门英文名称：</td>
                <td  height="50" width="50%" align=left><input type="text" name="ename" value="<%=ename==null?"":StringUtil.gb2iso4View(ename)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td height="50"  width="50%" align=right>电话：</td>
                <td width="50%"  height="50" align=left><input type="text" name="phone" value="<%=phone==null?"":StringUtil.gb2iso4View(phone)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="50%" height="50"  align=right>经理：</td>
                <td width="50%"  height="50" align=left><input type="text" name="manager" value="<%=manager==null?"":StringUtil.gb2iso4View(manager)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="50%"  height="50" align=right>副经理：</td>
                <td width="50%"  height="50" align=left><input type="text" name="vmanager" value="<%=vmanager==null?"":StringUtil.gb2iso4View(vmanager)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="50%"  height="50" align=right>主管主任：</td>
                <td width="50%"  height="50" align=left><input type="text" name="leader" value="<%=leader==null?"":StringUtil.gb2iso4View(leader)%>"></td>
            </tr>
            <tr bgcolor="#eeeeee" class=tine>
                <td width="80%" align=center colspan="2"><input type="submit" name="sub" value="提交"></td>
            </tr>
        </form>
    </table>
</center>
</body>
</html>