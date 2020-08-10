<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Users.*,
                 com.bizwink.cms.business.Order.*" contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.util.SecurityUtil" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../../include/auth.jsp"%>
<%
    if (!SecurityCheck.hasPermission(authToken,54))
    {
        request.setAttribute("message","无管理用户的权限");
        response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
        return;
    }
    int siteid = authToken.getSiteID();
    int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
    int pageno              = ParamUtil.getIntParameter(request, "page", 0);
    int range               = ParamUtil.getIntParameter(request, "range", 100);
    int searchflag          = ParamUtil.getIntParameter(request, "searchflag", 0);
    String authUsername = authToken.getUserID();
    IOrderManager orderMgr = orderPeer.getInstance();
    //IUserManager userMgr = UserPeer.getInstance();
    //IBUserManager buserMgr = buserPeer.getInstance();


    List list = new ArrayList();
    List currentlist = new ArrayList();
    String msg = ParamUtil.getParameter(request,"msg");

    String jumpstr = "";
    int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

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
        out.println("alert(\"添加项目成功\");");
        out.println("</script>");
    }
    if(success == 2){
        out.println("<script language=\"javascript\">");
        out.println("alert(\"修改项目成功\");");
        out.println("</script>");
    }

    String s_usernames = "";
    String s_realnames = "";
    String s_addresss = "";
    String s_emails = "";
    int s_sexs = -1;
    int s_lockflags = 0;
    String s_occupations = "";
    int s_educations = -1;
    String s_citys = "";
    int s_ordernum1s = 0;
    int s_bidnum1s = 0;
    int s_ordernum2s = 0;
    int s_bidnum2s = 0;
    String s_ips = "";
    String mphone = null;
    String nextUpPageUrl = null;
    String nextDownPageUrl = null;
    String nextUpPageUrlCheckCode = null;
    String nextDownPageUrlCheckCode = null;
    String nextDownPageUrlParam = "";
    String nextUpPageUrlParam = "";


   /* if(searchflag==1){
        s_usernames             = ParamUtil.getParameter(request,"username");
        s_realnames             = ParamUtil.getParameter(request,"realname");
        s_addresss              = ParamUtil.getParameter(request,"address");
        s_emails                = ParamUtil.getParameter(request,"email");
        s_occupations           = ParamUtil.getParameter(request, "occupation");
        s_ips                   = ParamUtil.getParameter(request, "ip");
        s_lockflags             = ParamUtil.getIntParameter(request, "lockflag", -1);
        s_educations            = ParamUtil.getIntParameter(request, "education", -1);
        s_sexs                  = ParamUtil.getIntParameter(request, "sex", -1);
        s_ordernum1s            = ParamUtil.getIntParameter(request, "ordernum1", -1);
        s_ordernum2s            = ParamUtil.getIntParameter(request, "ordernum2", -1);
        s_bidnum1s              = ParamUtil.getIntParameter(request, "bidnum1", -1);
        s_bidnum2s              = ParamUtil.getIntParameter(request, "bidnum2", -1);
        mphone                  = ParamUtil.getParameter(request, "mphone");
        System.out.println("s_usernames="+s_usernames);
        if(s_usernames!=null){
            jumpstr = jumpstr + "&username="+s_usernames;
        }

        if(mphone!=null){
            jumpstr = jumpstr + "&mphone="+mphone;
        }

        if(s_realnames!=null){
            jumpstr = jumpstr + "&realname="+s_realnames;
        }

        if(s_addresss!=null){
            jumpstr = jumpstr + "&address="+s_addresss;
        }

        if(s_emails!=null){
            jumpstr = jumpstr + "&email="+s_emails;
        }

        if(s_lockflags!=-1){
            jumpstr = jumpstr + "&lockflag="+s_lockflags;
        }

        if((s_occupations!=null)&&(s_occupations!="")){
            jumpstr = jumpstr + "&occupation="+ s_occupations;
        }

        if((s_ips!=null)&&(s_ips!="")){
            jumpstr = jumpstr + "&ip="+ s_ips;
        }

        if(s_educations!=-1){
            jumpstr = jumpstr + "&education=" + s_educations;
        }

        if(s_ordernum1s!=-1){
            jumpstr = jumpstr + "&ordernum1="+s_ordernum1s;
        }
        if(s_ordernum2s!=-1){
            jumpstr = jumpstr + "&ordernum2="+s_ordernum2s;
        }
        if(s_bidnum1s!=-1){
            jumpstr = jumpstr + "&bidnum1="+s_bidnum1s;
        }
        if(s_bidnum2s!=-1){
            jumpstr = jumpstr + "&bidnum2="+s_bidnum2s;
        }

        BUser bUser = new BUser();
        bUser.setUserID(s_usernames);
        bUser.setRealName(s_realnames);
        bUser.setAddress(s_addresss);
        bUser.setEmail(s_emails);
        bUser.setSex(s_sexs);
        bUser.setOccupation(s_occupations);
        bUser.setEducation(s_educations);
        bUser.setLockFlag(s_lockflags);
        bUser.setIP(s_ips);
        bUser.setMobilePhone(mphone);

        currentlist = buserMgr.searchUserList(siteid,startrow,range,bUser);
        rows = buserMgr.searchUserListCount(siteid,bUser);
        row = currentlist.size();

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

        nextUpPageUrl ="index2.jsp?startrow=" + (startrow+range) + "&page=" + (pageno+1) + "&searchflag=" + searchflag;
        nextDownPageUrl ="index2.jsp?startrow=" + (startrow-range) + "&page=" + (pageno-1) + "&searchflag=" + searchflag;
        nextUpPageUrlCheckCode = URLEncoder.encode(SecurityUtil.Encrypto(nextUpPageUrl + jumpstr),"utf-8");
        nextDownPageUrlCheckCode = URLEncoder.encode(SecurityUtil.Encrypto(nextDownPageUrl + jumpstr),"utf-8");
        nextDownPageUrlParam = jumpstr + "&checkcode=" + nextDownPageUrlCheckCode;
        nextUpPageUrlParam = jumpstr + "&checkcode=" + nextUpPageUrlCheckCode;

        System.out.println("jumpstr==" + jumpstr);
        System.out.println("rows==" + rows);
        System.out.println("row==" + row);
        System.out.println("totalpages==" + totalpages);
        System.out.println("currentpage==" + currentpage);

    } else {*/
        currentlist = orderMgr.getTrainProjectList(siteid,startrow,range,"");
        row = currentlist.size();
   // }
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

        function DelPro(ID)
        {
            var str = confirm("确认要删除项目吗？如果删除，属于该项目的专业以及课程将一并删除！");
            if (str)
                window.location = "deleteTrain.jsp?proid=" + ID;
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
            {"添加新项目", "addproject.jsp"},
            // {"送报员", "index3.jsp"},
            {"<a href=javascript:popup_window()>" + str2 + "</a>", ""},
            {str4, "siteIPManage.jsp?siteid="+authToken.getSiteID()+"&dname="+authToken.getSitename()}
    };
%>
<%@ include file="../business/inc/titlebar.jsp" %>
<font class=line>项目列表</font>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
    <tr bgcolor="#eeeeee" class=tine>
        <td align=center width="10%">项目名称</td>
        <td align=center width="5%">项目编码</td>
        <td align=center width="10%">项目简介</td>
        <td align="center" width="5%">创建时间</td>
        <td align="center" width="5%">管理专业</td>
        <td align="center" width="5%">修改</td>
        <td align=center width="5%">删除</td>
    </tr>

    <%
        SimpleDateFormat formatDateAndTime=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        int proid=0;
        String projcode ="";
        for ( int i=0; i<row; i++){
            Training training = (Training)currentlist.get(i);
            proid = Integer.valueOf(String.valueOf(training.getID()));
            projcode = training.getProjcode();
    %>
    <tr bgcolor="#ffffff" class=line>
        <td align=center><%=training.getProjname()==null?"":training.getProjname()%></td>
        <td align=center><%=training.getProjcode()==null?"":training.getProjcode()%></td>
        <td align=center><%=training.getBrief()==null?"":training.getBrief()%></td>
        <td align=center><%=training.getCreatedate()%></td>
        <td align=center><a href="Trainmajor.jsp?projcode=<%=projcode%>">管理专业</a></td>
        <td align=center><a href="updateTrain.jsp?proid=<%=proid%>">修改</a></td>
        <td align=center><a href="javascript:DelPro('<%=proid%>')">删除</a></td>
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