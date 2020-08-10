<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.program.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=utf-8"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    IProgramManager programMgr = ProgramPeer.getInstance();

    List list = programMgr.getAllPrograms();
%>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="GENERATOR" content="Microsoft FrontPage 4.0">
    <meta name="ProgId" content="FrontPage.Editor.Document">
    <link href="../style/common.css" rel=stylesheet>
    <title>程序管理</title>
    <script language="javascript">
        function addProgram()
        {
            window.open("paddprogram.jsp","增加程序模块","width=650,height=500,left=200,top=100,status");
        }

        function editor(pid)
        {
            window.open("pedit.jsp?id=" + pid,"修改程序模块","width=650,height=500,left=200,top=100,status");
        }

        function remove(pid)
        {
            window.open("premove.jsp?id=" + pid,"删除程序模块","width=650,height=500,left=200,top=100,status");
        }
    </script>
</head>

<body>
<center>
<%
    String[][] titlebars = {
            { "程序模块管理", "" }
    };

    String[][] operations = {
            {"<a href=javascript:addProgram();>增加程序</a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<table cellSpacing="0" cellPadding="0" width="770" border="0" align=center>
<form name="leavewordForm" method="post" action="pmanager.jsp">
<input type="hidden" name="startflag" value="1">
<tbody>
<tr>
    <td width="15%" height="35" class=txt>功能类型</td>
    <td width="15%" class=txt>语言类型</td>
    <td width="15%" class=txt>位置</td>
    <td width="35%" class=txt>说明</td>
    <td width="10%" class=txt>修改</td>
    <td width="10%" class=txt>删除</td>
</tr>
<%
    int program_type;
    int language_type;
    int posi;
    String notes;
    String explain;
    int id;

    for (int i = 0; i < list.size(); i++) {
        Program program = (Program) list.get(i);
        program_type = program.getP_type();
        language_type = program.getL_type();
        posi = program.getPosition();
        notes = StringUtil.gb2iso4View(program.getNotes());
        explain = StringUtil.gb2iso4View(program.getExplain());
        id = program.getId();
%>
<tr>
    <td height="35" class=txt>
        <%
            switch (program_type) {
                case 11:
                    out.println("信息检索");
                    break;
                case 12:
                    out.println("购物车");
                    break;
                case 13:
                    out.println("订单生成");
                    break;
                case 14:
                    out.println("订单回显");
                    break;
                case 15:
                    out.println("订单查询");
                    break;
                case 16:
                    out.println("信息反馈");
                    break;
                case 17:
                    out.println("用户评论");
                    break;
                case 18:
                    out.println("用户注册");
                    break;
                case 19:
                    out.println("用户登录");
                    break;
                case 20:
                    out.println("订单明细查询");
                    break;
                case 21:
                    out.println("用户留言");
                    break;
                case 22:
                    out.println("修改注册");
                    break;
                case 24:
                    out.println("地图标注");
                    break;
            }
        %>
    </td>
    <td class=txt>
        <%
            switch (language_type) {
                case 1:
                    out.println("Java");
                    break;
                case 2:
                    out.println("Javascript");
                    break;
            }
        %>
    </td>
    <td class=txt>
        <%
            switch (posi) {
                case 1:
                    out.println("页头");
                    break;
                case 3:
                    out.println("页尾");
                    break;
            }
        %>
    </td>
    <td class=txt>
        <%=notes%>
    </td>
    <td class=txt><a href="javascript:editor('<%=id%>');">修改</a></td>
    <td class=txt><a href="javascript:remove('<%=id%>');">删除</a></td>
</tr>
<%}%>
</tbody>
</form>
</table>
</center>
</body>

</html>