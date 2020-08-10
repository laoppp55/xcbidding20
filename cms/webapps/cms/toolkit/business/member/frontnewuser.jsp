<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.webapps.register.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"%>
<%@ include file="../../../include/auth.jsp"%>
<%
    if (!SecurityCheck.hasPermission(authToken, 54)) {
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
        return;
    }

    int siteid = authToken.getSiteID();
    boolean error = false;
    boolean success = false;
    int flag=ParamUtil.getIntParameter(request, "flag",0);

    String errormsg = "";
    if (flag == 1) {
        String memberId = ParamUtil.getParameter(request, "memberid");
        String realName = ParamUtil.getParameter(request, "realname");
        String pass = ParamUtil.getParameter(request, "password");
        String linkMan = ParamUtil.getParameter(request, "linkman");
        String email = ParamUtil.getParameter(request, "email");
        String phone = ParamUtil.getParameter(request, "phone");
        String mobilePhone = ParamUtil.getParameter(request, "mobilephone");
        int userType = ParamUtil.getIntParameter(request, "usertype",0);
        String grade = ParamUtil.getParameter(request, "grade");

        Uregister uf = new Uregister();
        uf.setSiteid(siteid);
        uf.setMemberid(memberId);
        uf.setPassword(pass);
        uf.setLinkman(linkMan);
        uf.setEmail(email);
        uf.setPhoen(phone);
        uf.setGrade(grade);
        uf.setMobilephone(mobilePhone);
        uf.setUsertype(userType);
        uf.setName(realName);

        IUregisterManager uiMgr = UregisterPeer.getInstance();
        boolean bl = uiMgr.userExist(memberId);
        if (!bl) { //��֤�û�id�Ƿ���ڣ������������������û�
            int rel = uiMgr.insert_Info(uf);
            if (rel != 0) {
                errormsg = "<br><font color=red><b>��ӳɹ�!</b></font>";
            } else {
                errormsg = "<br><font color=red><b>���ʧ��!</b></font>";
            }
        } else {
            errormsg = "<br><font color=red><b>�Բ��𣬸��û����Ѵ���!</b></font>";
        }
    }
%>

<html>
<head>
    <title>�������û�</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">

    <link rel="stylesheet" type="text/css" href="../style/global.css">

    <SCRIPT LANGUAGE=javascript>

        function checkinput()
        {
            var memId=document.getElementById("memberid").value;
            var usertype=document.getElementById("usertype").value;
            if(memId == "" || memId == null){
                alert("�û�id����Ϊ��");
                return false;
            } else if(usertype == "-1" || usertype == null){
                alert("�û����Ͳ���Ϊ��");
                return false;
            }
            return true;

        }
    </SCRIPT>
</head>

<body bgcolor="#ffffec">
<div align="center">
    <form name="newitem" id="form1" action="frontnewuser.jsp" method="post" >
        <input type="hidden" name="flag" value="1">

        <div style="margin-top:40px; padding-top:40px">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                <tr bgcolor="#d4d4d4">
                    <td valign="top">
                        <table width="100%" border="0" cellpadding="4" cellspacing="1">
                            <tr bgcolor="#FFFFFF">

                                <td valign="top" class="txt" width="50%" colspan="2" align="center">������û���Ϣ

                                </td>

                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td class="txt">&nbsp;&nbsp;�û�ID��&nbsp;
                                    <input type="text" id="memberid" name="memberid" class="input">
                                </td>
                                <td valign="top" class="txt" width="50%">��ʵ������&nbsp;
                                    <input type="text" id="realname" name="realname" class="input">
                                </td>

                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td class="txt">�û����&nbsp;
                                    <input type="password" id="password" name="password" class="input">
                                </td>
                                <td class="txt">�����ʼ���&nbsp;
                                    <input type="text" name="email" id="email" class="input">
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td valign="top" class="txt" width="50%">&nbsp;&nbsp;&nbsp;&nbsp;�绰��&nbsp;
                                    <input type="text" name="phone" id="phone" class="input">
                                </td>
                                <td class="txt">�ƶ��绰��&nbsp;
                                    <input type="text" name="mobilephone" id="mobilephone" class="input">
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td valign="top" class="txt" width="50%">&nbsp;&nbsp;��ϵ�ˣ�&nbsp;
                                    <input type="text" name="linkman" id="linkman" class="input">
                                </td>
                                <td class="txt">�û�����&nbsp;
                                    <input type="text" id="grade" name="grade" class="input">
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td valign="top" class="txt" width="50%" colspan="2">�û����ͣ�&nbsp;
                                    <select name="usertype" id="usertype">
                                        <option value="-1">---��ѡ��---</option>
                                        <option value="0">��ͨ�û�</option>
                                        <option value="1">�ڲ��û�</option>
                                        <option value="2">��ҵ�û�</option>
                                        <option value="3">VIP�û�</option>
                                    </select>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td valign="top" class="txt" align="center" colspan="2">
                                    <input type="submit" value="���" onclick="return checkinput();">
                                    <input type="reset" value="����">
                                </td>

                            </tr>


                        </table>
                    </td>
                </tr>
            </table>
            <div id="msg"><%=errormsg%></div>
        </div>
    </form>
</div>
</body>
</html>
