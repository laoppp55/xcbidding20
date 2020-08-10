<%@page contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }
    String authUsername = authToken.getUserID();

    String msg = ParamUtil.getParameter(request,"msg");
    int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
    int pageno              = ParamUtil.getIntParameter(request, "page", 0);
    int range               = ParamUtil.getIntParameter(request, "range", 100);
    int searchflag          = ParamUtil.getIntParameter(request, "searchflag", 0);
    String projcode = ParamUtil.getParameter(request,"projcode");
    String jumpstr = "";
    int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;
    List currentlist = new ArrayList();
    IOrderManager orderMgr = orderPeer.getInstance();
    //获取某种状态的用户总数，0是所有状态用户的总数
    //rows = buserMgr.getTotalUsers(siteid,0);

    if(rows < range){
        totalpages = 1;
        currentpage = 1;
    }else{
        if(rows%range == 0)
            totalpages = rows/range;
        else
            totalpages = rows/range + 1;

        currentpage = startrow/range + 1;
    }
    int success = ParamUtil.getIntParameter(request, "success", 0);
    if(success == 1){
        out.println("<script language=\"javascript\">");
        out.println("alert(\"添加专业成功\");");
        out.println("</script>");
    }
    if(success == 2){
        out.println("<script language=\"javascript\">");
        out.println("alert(\"修改专业成功\");");
        out.println("</script>");
    }


    String nextDownPageUrlParam = "";
    String nextUpPageUrlParam = "";
    currentlist = orderMgr.getMajorList(projcode,startrow, range, "");
    row = currentlist.size();

%>
<html>
<head>
    <title><%=msg==null?"":new String(msg.getBytes("iso8859_1"),"GBK")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../business/style/global.css">
    <script language="javascript">
        function popup_window() {
            window.open( "addUser.jsp?flag=0","","top=100,left=100,width=500,height=300,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        function editflag(userid,username,v) {
            window.open( "editflag.jsp?userid="+userid+"&username="+username+'&status='+v,"","top=100,left=100,width=400,height=200,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        function sendmessage(userid) {
            window.open( "sendmessage.jsp?userid="+userid,"","top=100,left=100,width=600,height=300,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        function golistnew(r,jumpstr){
            //alert(userForm.page.value);
            window.location = "index2.jsp?startrow=" + r + "&page=" + userForm.page.value;

        }
        function gotoSearch(r){
            SearchForm.action = "index2.jsp?searchflag=1";
            SearchForm.submit();
        }

        function Delmajor(ID,projcode)
        {
            var str = confirm("确认要删除专业吗？如果删除，属于该专业的课程将一并删除！");
            if (str)
                window.location = "deleteMajor.jsp?id=" + ID +"&projcode="+projcode;
        }
    </script>
</head>
<%
    String str1 = "";
    String str2 = "";
    String str3 = "";
    String str4 = "";
    String str5 = "";

    if (authUsername.equals("admin"))
    {
        str1 = "用户管理";
        str2 = "创建系统管理用户";
    }

    String[][] titlebars = {
            { "首页", "../main.jsp" },
            { str1, "" }
    };

    String[][] operations = {
            //{"设置论坛斑竹", "setManager.jsp"},
            //{"添加新用户", "frontnewuser.jsp?flag=0"},
            {"添加专业", "addmajor.jsp?projcode="+projcode},
            // {"送报员", "index3.jsp"},
            {"<a href=javascript:popup_window()>" + str2 + "</a>", ""},
            {str4, "siteIPManage.jsp?siteid="+authToken.getSiteID()+"&dname="+authToken.getSitename()}
    };
%>
<%@ include file="../business/inc/titlebar.jsp" %>
<font class=line>项目列表</font>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
    <tr bgcolor="#eeeeee" class=tine>
        <td align=center width="10%">专业名称</td>
        <td align=center width="5%">专业编码</td>
        <td align=center width="10%">是否启用</td>
        <td align="center" width="5%">创建时间</td>
        <td align="center" width="5%">管理课程</td>
        <td align="center" width="5%">修改</td>
        <td align=center width="5%">删除</td>
    </tr>

    <%
        SimpleDateFormat formatDateAndTime=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        int id=0;
        String majorcode ="";
        for ( int i=0; i<row; i++){
            Training training = (Training)currentlist.get(i);
            id = Integer.valueOf(String.valueOf(training.getID()));
            majorcode = training.getMajorcode();
            int nouse = training.getNouse();
            String nousestr= "未用";
            if(nouse != 0){
                nousestr = "启用";
            }
    %>
    <tr bgcolor="#ffffff" class=line>
        <td align=center><%=training.getMajor()==null?"":training.getMajor()%></td>
        <td align=center><%=training.getMajorcode()==null?"":training.getMajorcode()%></td>
        <td align=center><%=nousestr%></td>
        <td align=center><%=training.getCreatedate()%></td>
        <td align=center><a href="Trainmajorclass.jsp?majorcode=<%=majorcode%>&projcode=<%=projcode%>">管理课程</a></td>
        <td align=center><a href="updateMajor.jsp?id=<%=id%>&projcode=<%=projcode%>">修改</a></td>
        <td align=center><a href="javascript:Delmajor('<%=id%>','<%=projcode%>')">删除</a></td>
    </tr>

    <% }  %>
</table>
<br><br>
<center>
    <form method="post" action="index2.jsp" name="userForm">
        <table>
            <tr valign="bottom">
                <td>
                    共有<%=rows%>用户&nbsp;&nbsp;总<%=totalpages%>页 第<%=currentpage%>页
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <%
                        if((startrow-range)>=0){
                    %>
                    [<a href="index2.jsp?startrow=<%=startrow-range%>&page=<%=pageno-1%>&searchflag=<%=searchflag%><%=nextDownPageUrlParam%>">上一页</a>]
                    <%}%>
                    <%
                        if((startrow+range)<rows){
                    %>
                    [<a href="index2.jsp?startrow=<%=startrow+range%>&page=<%=pageno+1%>&searchflag=<%=searchflag%><%=nextUpPageUrlParam%>">下一页</a>]
                    <%}%>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    跳转到
                    <select name="page" onchange="javascript:golistnew(<%=range%>*document.all('page').value,'<%=jumpstr%>');">
                        <%for(int i=0;i<totalpages;i++){%>
                        <option value="<%=i%>" <%if(currentpage==(i+1)){%>selected<%}%>>第<%=i+1%>页</option>
                        <%}%>
                    </select>
                </td>
            </tr>
        </table>
    </form>


</center>
</html>
