<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Users.*,
                 com.bizwink.cms.business.Order.*" contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.util.SecurityUtil" %>
<%@ page import="java.net.URLEncoder" %>

<%!
    private final String YES = "<font color='#006600' size='-1'><b>��</b></font>";
    private final String NO  = "<font color='#ff0000' size='-1'><b>��</b></font>";
%>
<%@ include file="../../../include/auth.jsp"%>
<%
    if (!SecurityCheck.hasPermission(authToken,54))
    {
        request.setAttribute("message","�޹����û���Ȩ��");
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
    IUserManager userMgr = UserPeer.getInstance();
    IBUserManager buserMgr = buserPeer.getInstance();
    List list = new ArrayList();
    List currentlist = new ArrayList();
    String msg = ParamUtil.getParameter(request,"msg");

    String jumpstr = "";
    int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

    //��ȡĳ��״̬���û�������0������״̬�û�������
    rows = buserMgr.getTotalBusinessUsers(siteid,0);

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
        out.println("alert(\"��Ϣ���ͳɹ�\");");
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
    String nextUpPageUrl = null;
    String nextDownPageUrl = null;
    String nextUpPageUrlCheckCode = null;
    String nextDownPageUrlCheckCode = null;
    String nextDownPageUrlParam = "";
    String nextUpPageUrlParam = "";

    if(searchflag==1){
        s_usernames              = ParamUtil.getParameter(request,"username");
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

        if(s_usernames!=null){
            jumpstr = jumpstr + "&username="+s_usernames;
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

        currentlist = buserMgr.searchBusinessUserList(siteid,startrow,range,bUser);
        rows = buserMgr.searchBusinessUserListCount(siteid, bUser);
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

        nextUpPageUrl ="index3.jsp?startrow=" + (startrow+range) + "&page=" + (pageno+1) + "&searchflag=" + searchflag;
        nextDownPageUrl ="index3.jsp?startrow=" + (startrow-range) + "&page=" + (pageno-1) + "&searchflag=" + searchflag;
        nextUpPageUrlCheckCode = URLEncoder.encode(SecurityUtil.Encrypto(nextUpPageUrl + jumpstr),"utf-8");
        nextDownPageUrlCheckCode = URLEncoder.encode(SecurityUtil.Encrypto(nextDownPageUrl + jumpstr),"utf-8");
        nextDownPageUrlParam = jumpstr + "&checkcode=" + nextDownPageUrlCheckCode;
        nextUpPageUrlParam = jumpstr + "&checkcode=" + nextUpPageUrlCheckCode;

        System.out.println("jumpstr==" + jumpstr);
        System.out.println("rows==" + rows);
        System.out.println("row==" + row);
        System.out.println("totalpages==" + totalpages);
        System.out.println("currentpage==" + currentpage);

    } else {
        currentlist = buserMgr.getBusinessUserList(siteid,startrow,range,"");
        row = currentlist.size();
    }
%>

<html>
<head>
    <title><%=msg==null?"":new String(msg.getBytes("iso8859_1"),"GBK")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script language="javascript">
        function popup_window() {
            window.open( "addUser.jsp?flag=0","","top=100,left=100,width=500,height=300,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        function editflag(userid,username,v) {
            window.open( "editflag.jsp?userid="+userid+"&username="+username+'&status='+v,"","top=100,left=100,width=400,height=200,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        function auditUserAndUploadImg(uid) {
            var iWidth=1000;                                                 //�������ڵĿ��;
            var iHeight=800;                                                //�������ڵĸ߶�;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open("auditBusinessUser.jsp?uid=" + uid + "&startrow=<%=startrow%>", "", "width=" + iWidth +",height=" + iHeight +",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
        }

        function sendmessage(userid) {
            window.open( "sendmessage.jsp?userid="+userid,"","top=100,left=100,width=600,height=300,resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no");
        }

        function golistnew(r,jumpstr){
            //alert(userForm.page.value);
            window.location = "index3.jsp?startrow=" + r + "&page=" + userForm.page.value;

        }
        function gotoSearch(r){
            SearchForm.action = "index3.jsp?searchflag=1";
            SearchForm.submit();
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
        str1 = "�û�����";
        str2 = "����ϵͳ�����û�";
    }

    String[][] titlebars = {
            { "��ҳ", "../main.jsp" },
            { str1, "" }
    };

    String[][] operations = {
            //{"������̳����", "setManager.jsp"},
            //{"������û�", "frontnewuser.jsp?flag=0"},
            {"ע���û�", "index2.jsp"},
            {"�ͱ�Ա", "index3.jsp"},
            {"<a href=javascript:popup_window()>" + str2 + "</a>", ""},
            {str4, "siteIPManage.jsp?siteid="+authToken.getSiteID()+"&dname="+authToken.getSitename()}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<font class=line>�û��б�</font>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
    <tr bgcolor="#eeeeee" class=tine>
        <td align=center width="10%">�ͻ����</td>
        <td align=center width="5%">״̬</td>
        <td align=center width="10%">USERID</td>
        <td align=center width="5%">����</td>
        <td align=center width="15%">��ַ</td>
        <!--td align=center width="5%">�ʱ�</td-->
        <td align=center width="10%">�绰</td>
        <!--td align=center width="10%">�����ʼ�</td-->
        <td align=center width="5%">�Ա�</td>
        <!--td align=center width="10%">ְҵ</td-->
        <!--td align=center>ѧ��</td-->
        <!--td align=center>����</td-->
        <!--td align=center>������</td-->
        <!--td align=center>������</td-->
        <!--td align=center>IP��ַ</td-->
        <td align=center  width="10%">�û�����</td>
        <!--td align=center  width="5%">����</td-->
        <td align=center>���</td>
    </tr>

    <%
        String userid = "";
        String username = "";
        String address = "";
        String postcode = "";
        String phone = "";
        String mphone = "";
        String email = "";
        int sex = 0;
        String sexstr = "";
        String occupation = "";
        int education = 0;
        String edustr = "";
        int lockflag = 0;
        String lockstr = "";
        String ip = "";
        int usertype = 0;
        int scores = 0;
        for ( int i=0; i<row; i++){
            BUser buser = (BUser)currentlist.get(i);
            userid = buser.getUserID();
            usertype = buser.getLevel();
            username = buser.getUserName();
            username = username==null?"--":StringUtil.gb2iso4View(username);
            address = buser.getAddress();
            address = address==null?"--":StringUtil.gb2iso4View(address);
            postcode = buser.getPostCode();
            scores = buser.getScore();
            phone = buser.getPhone();
            mphone = buser.getMobilePhone();
            if(phone == "" || phone == null){
                phone = buser.getMobilePhone();
            }
            phone = phone==null?"--":StringUtil.gb2iso4View(phone);
            lockflag = buser.getLockFlag();
            email = buser.getEmail();
            email = email==null?"--":StringUtil.gb2iso4View(email);
            sex = buser.getSex();
            if(sex == 0){
                sexstr = "��";
            }else{
                sexstr = "Ů";
            }
            occupation = buser.getOccupation();
            occupation = occupation==null?"--":StringUtil.gb2iso4View(occupation);
            education = buser.getEducation();
            if(education == -1){
                edustr = "--";
            }else if(education == 0){
                edustr = "����";
            }else if(education == 1){
                edustr = "����";
            }else if(education == 2){
                edustr = "��ר";
            }else if(education == 3){
                edustr = "����";
            }else if(education == 4){
                edustr = "˶ʿ";
            }else if(education == 5){
                edustr = "��ʿ";
            }else if(education == 6){
                edustr = "��ʿ��";
            }

            if(lockflag == 0){
                lockstr = "��ͨ";
            }else if(lockflag == 1){
                lockstr = "��ͣ����";
            }else if(lockflag == 2){
                lockstr = "��ͣ��¼";
            }else if(lockflag == 3){
                lockstr = "���Ʒ���";
            }

            ip = buser.getIP();

            //����û��Ķ�����
            //int ordernum = 0;

            //ordernum = orderMgr.getUserOrderNums(buser.getID());

            //����û�������
            //int bidnum = 0;
            //   IBidManager bidMgr = BidPeer.getInstance();
            //   bidnum = bidMgr.getBidNum(userid);
    %>
    <tr bgcolor="#ffffff" class=line>
        <td align=center><!--%=i*range+startrow+1%--><%=buser.getID()%></td>
        <td align=center><a href="javascript:editflag('<%=userid%>','<%=username%>','<%=lockflag%>');"><%=lockstr%></a></td>
        <td align=center><a href="detail_user.jsp?userid=<%=userid%>" target=_blank><%=userid%></a></td>
        <td align=center><%=username%></td>
        <td align=center><%=address%></td>
        <!--td align=center><%=(postcode==null)?"&nbsp;":postcode%></td-->
        <td align=center><%=mphone%></td>
        <!--td align=center><%=email%></td-->
        <td align=center><%=sexstr%></td>
        <!--td align=center><%=occupation%></td-->
        <%
            if(usertype == 5)
                out.println("<td align=center>��ͨ�û�</td>");
            else if (usertype == 6 || usertype == 7)
                out.println("<td align=center>ҵ��Ա</td>");
            else if (usertype == 2)
                out.println("<td align=center>��ҵ�û�</td>");
            else
                out.println("<td align=center>VIP�û�</td>");
        %>
        <!--td align=center><a href="../order/userorders.jsp?searchflag=1&userid=<!--%=userid%>&showname=<--%=username%>" target=_blank><--%=ordernum%></a></td-->
        <!--td align=center><%//=ip%></td-->
        <!--td align=center><a href="javascript:sendmessage('<-%=userid%>');">����</a></td-->
        <!--td align=center><%=scores%></td-->
        <% if (usertype == 7) {%>
        <td align=center><a href="#" onclick="javascript:auditUserAndUploadImg(<%=buser.getID()%>);"><font color="red">δ���</font></a></td>
        <%} else if (usertype == 6){%>
        <td align=center><font color="green">�����</font></td>
        <%}%>
    </tr>

    <% }  %>
</table>
<br><br>
<center>
    <form method="post" action="index3.jsp" name="userForm">
        <table>
            <tr valign="bottom">
                <td>
                    ����<%=rows%>�û�&nbsp;&nbsp;��<%=totalpages%>ҳ ��<%=currentpage%>ҳ
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <%
                        if((startrow-range)>=0){
                    %>
                    [<a href="index3.jsp?startrow=<%=startrow-range%>&page=<%=pageno-1%>&searchflag=<%=searchflag%><%=nextDownPageUrlParam%>">��һҳ</a>]
                    <%}%>
                    <%
                        if((startrow+range)<rows){
                    %>
                    [<a href="index3.jsp?startrow=<%=startrow+range%>&page=<%=pageno+1%>&searchflag=<%=searchflag%><%=nextUpPageUrlParam%>">��һҳ</a>]
                    <%}%>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    ��ת��
                    <select name="page" onchange="javascript:golistnew(<%=range%>*document.all('page').value,'<%=jumpstr%>');">
                        <%for(int i=0;i<totalpages;i++){%>
                        <option value="<%=i%>" <%if(currentpage==(i+1)){%>selected<%}%>>��<%=i+1%>ҳ</option>
                        <%}%>
                    </select>
                </td>
            </tr>
        </table>
    </form>

    <table width="770" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
        <form method="post" action="index3.jsp" name="SearchForm">
            <input type="hidden" name="searchflag" value="1">
            <tr>
                <td align="center" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="8">
                        <tr bgcolor="#F1F2EC">
                            <td class="txt"><strong><font color="6F4A06">�û�������</font></strong></td>
                        </tr>
                    </table>
                    <br>
                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                        <tr bgcolor="#d4d4d4">
                            <td valign="top">
                                <table width="100%" border="0" cellpadding="4" cellspacing="1">
                                    <tr bgcolor="#FFFFFF">
                                        <td  valign="top" class="txt" width="50%">�û�ID��&nbsp;
                                            <input type="text" name="username" class="input" value="<%=(s_usernames==null)?"":s_usernames%>">
                                        </td>
                                        <td class="txt">�û�������&nbsp;
                                            <input type="text" name="realname" class="input" value="<%=(s_realnames==null)?"":s_realnames%>">
                                        </td>
                                    </tr>
                                    <!--tr bgcolor="#FFFFFF">
                                        <td class="txt">���ڳ��У�&nbsp;
                                          <input type="text" name="city" class="input">
                                        </td>
                                        <td class="txt" colspan=2>��ַ��&nbsp;
                                            <input type="text" name="address" class="input" value="<%=(s_addresss==null)?"":s_addresss%>">
                                        </td>
                                    </tr-->
                                    <!--tr bgcolor="#FFFFFF">
                                        <td height="37" class="txt">Email��&nbsp;
                                            <input type="text" name="email" class="input" value="<%=(s_emails==null)?"":s_emails%>">
                                            <font color="#FF0000"> </font> </td>
                                        <td class="txt">IP��ַ��&nbsp;
                                            <input type="text" name="ip" class="input" value="<%=(s_ips==null)?"":s_ips%>">
                                        </td>
                                    </tr-->
                                    <tr bgcolor="#FFFFFF">
                                        <td class="txt">�û�״̬��&nbsp;
                                            <select name="lockflag">
                                                <option>��ѡ��...</option>
                                                <option value="0" <%=(s_lockflags==0)?"selected":""%>>����</option>
                                                <option value="1" <%=(s_lockflags==1)?"selected":""%>>��ͣ����</option>
                                                <option value="2" <%=(s_lockflags==2)?"selected":""%>>��ͣ��½</option>
                                                <option value="3" <%=(s_lockflags==3)?"selected":""%>>���Ʒ���</option>
                                            </select>
                                        </td>
                                        <td class="txt">�Ա�&nbsp;
                                            <select name="sex">
                                                <option value="-1">��ѡ��</option>
                                                <option value="0" <%=(s_sexs==0)?"selected":""%>>��</option>
                                                <option value="1" <%=(s_sexs==0)?"selected":""%>>Ů</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--tr bgcolor="#FFFFFF">
                                        <td class="txt">ְҵ��&nbsp;
                                            <select name="occupation">
                                                <option value="">��ѡ��</option>
                                                <option value="ѧ��" >ѧ��</option>
                                                <option value="ִ�й�/����" >ִ�й�/����</option>
                                                <option value="ר��" >ר��</option>
                                                <option value="����/��ʦ" >����/��ʦ</option>
                                                <option value="������Ա/����ʦ" >������Ա/����ʦ</option>
                                                <option value="������Ա" >������Ա</option>
                                                <option value="�����ɲ�" >�����ɲ�</option>
                                                <option value="����/�г�" >����/�г�</option>
                                                <option value="������">������</option>
                                                <option value="����ְҵ��" >����ְҵ��</option>
                                                <option value="��Ա/����" >��Ա/����</option>
                                                <option value="ʧҵ" >ʧҵ</option>
                                                <option value="��/����" >��/����</option>
                                                <option value="����" >����</option>
                                                <option value="��ְͨԱ" >��ְͨԱ</option>
                                                <option value="����" >����</option>
                                            </select>
                                            <font color="#FF0000"> </font> </td>
                                        <td class="txt">ѧ����&nbsp;
                                            <select name="education">
                                                <option value="-1">��ѡ��</option>
                                                <option value="0" >����</option>
                                                <option value="1" >����</option>
                                                <option value="2" >��ר</option>
                                                <option value="3" >����</option>
                                                <option value="4" >˶ʿ</option>
                                                <option value="5" >��ʿ</option>
                                                <option value="6" >��ʿ��</option>
                                            </select>
                                        </td>
                                    </tr-->


                                    <!--tr bgcolor="#FFFFFF">
                                      <td class="txt">��������&nbsp;&nbsp;��
                                        <input type="text" size="5" name="ordernum1" maxlength="6" class="input">
                                        ��
                                        <input type="text" size="5" name="ordernum2" maxlength="6" class="input">
                                        </td>
                                      <td class="txt">��������&nbsp;&nbsp;��
                                        <input type="text" size="5" name="bidnum1" class="input" maxlength="6">
                                        ��
                                        <input type="text" size="5" name="bidnum2" class="input" maxlength="6">
                                      </td>
                                    </tr-->

                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td><img src="images/space.gif" width="1" height="1"></td>
                        </tr>
                    </table>
                    <p><input type=button value="����" onclick="javascript:gotoSearch();"><br>
                        <br>
                    </p>
                </td>
            </tr>
        </form>
    </table>
</center>
</html>