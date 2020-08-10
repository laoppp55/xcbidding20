<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
%>
<%@ include file="../include/auth.jsp"%>
<%
    //ע���ļ��ǳ���Ա����Ĺ���

    if (!SecurityCheck.hasPermission(authToken,54))
    {
        request.setAttribute("message","�޹����û���Ȩ��");
        response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
        return;
    }

    int siteid = authToken.getSiteID();
    String username = authToken.getUserID();

    IUserManager userMgr = UserPeer.getInstance();
    List userList = userMgr.getUsers(siteid);
    int userCount = userList.size();
%>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
        function createUser()
        {
            window.open("newuser.jsp","","top=100,left=100,width=700,height=700");
        }

        function editUser(userid)
        {
            window.open("editUser.jsp?userid="+userid,"","top=0,left=100,width=650,height=700");
        }

        function pubFlag()
        {
            window.open("pubflag.jsp","","top=200,left=200,width=300,height=150");
        }

        function copySiteFromSampleSite()
        {
            window.open("../register/webindex.jsp","selectmodel");
        }

        function grantUser(userid)
        {
            window.open("grantRightToUser.jsp?userid="+userid,"","top=100,left=100,width=420,height=360");
        }

        function programs()
        {
            window.open("programsfortoolkit.jsp","","top=100,left=100,width=900,height=600");
        }

        function orgmanager()
        {
            window.open("../organization/index.jsp","organizationwin","top=0,left=0,width=1300,height=800,resizable=yes,scrollbars=yes");
        }

        function createAttachType()
        {
            var bln = confirm("��ȷ��Ҫ�������¸����ķ�����");
            if (bln) {
                alert("hello world");
                window.open("createnewtype.jsp", "", "width=600,height=400,left=200,right=200,scrollbars,status");
            }
        }
    </script>
</head>
<%
    String[][] titlebars = {
            { "�û�����", "" }
    };
    String[][] operations = {
            {"<a href=javascript:createUser();>�����û�</a>", ""},
            {"�����", "groupManage.jsp"},
            {"��ʽ�ļ�", "listStyle.jsp"},
            {"�ؼ��ֹ���", "keyword.jsp"},
            {"���¹鵵", "archive.jsp"},
            {"���¸�������","attachTypeManager.jsp"},
            {"��֯�ܹ�����", "../organization/index.jsp"},
            //{"<a href=javascript:programs();>��������</a>",""},
            {"<a href=javascript:pubFlag();>������ʽ</a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="90%" align=center>
    <tr bgcolor="#eeeeee" class=tine>
        <td width="15%" align=center class="listHeader"><b>�û���</b></td>
        <td width="15%" align=center>�û�����</td>
        <td width="20%" align=center>��λ</td>
        <!--td width="15%" align=center>��ɫ</td-->
        <td width="10%" align=center>��Ȩ����</td>
        <td width="10%" align=center>����</td>
        <td width="10%" align=center>���</td>
        <td width="10%" align=center>����</td>
        <td width="10%" align=center>ɾ��</td>
    </tr>
    <%
        for (int i=0; i<userCount; i++)
        {
            User user = (User)userList.get(i);
            String userID = user.getID();
            String nickName = StringUtil.gb2iso4View(user.getNickName());
            String dept = user.getDepartment();
            String company = user.getCompany();
            Department d = null;
            String dname = null;
            if (dept != null) {
                if (!dept.isEmpty()) {
                    try {
                        d = userMgr.getOneDepartmentInfoById(Integer.parseInt(dept));
                        if(d != null ) {
                            dname = d.getCname();
                            dname = StringUtil.gb2iso4View(dname);
                        }
                    } catch(NumberFormatException exp) {
                        dname = dept;
                    }
                } else if (company!=null) {
                    if (!company.isEmpty()) dname = company;
                }
            } else if (company!=null && company!="") {
                dname = company;
            }

    %>
    <tr bgcolor="#ffffff" class=line>
        <td align=center><b><%=userID%></b></td>
        <td align=center><%=nickName%></td>
        <td align=center><%=(dname!=null)?dname:"&nbsp;&nbsp;"%></td>
        <!--td align="center"><input type="radio" name="action" onclick='grantUser("<%=userID%>");' <%if(userID.equalsIgnoreCase(username)){%>disabled<%}%>></td>
        <td align="center"><input type="radio" name="action" onclick='editUser("<%=userID%>");' <%if(userID.equalsIgnoreCase(username)){%>disabled<%}%>></td-->
        <td align="center"><input type="radio" name="action" onclick='grantUser("<%=userID%>");'></td>
        <td align="center"><input type="radio" name="action" onclick='editUser("<%=userID%>");'></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='editUserGroup.jsp?userid=<%=userID%>';" <%if(userID.equalsIgnoreCase(username)){%>disabled<%}%>></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='editPassword.jsp?userid=<%=userID%>';"></td>
        <td align="center"><input type="radio" name="action" onclick="location.href='removeUser.jsp?userid=<%=userID%>';" <%if(userID.equalsIgnoreCase(username)){%>disabled<%}%>></td>
    </tr>
    <%}%>
</table>

</body>
</html>