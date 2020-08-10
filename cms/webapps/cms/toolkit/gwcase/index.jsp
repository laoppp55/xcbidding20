<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.toolkit.gwcase.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    int range = ParamUtil.getIntParameter(request, "range", 5);
    int flag = ParamUtil.getIntParameter(request, "flag", 2);                        //Ĭ��ֵ��ʾ����ȫ����Ϣ
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);


    IGWcaseManager GWMgr = GwcasePeer.getInstance();
    List list = new ArrayList();

    int rows = 0;

    String jumpstr = "";
    String sqlstr = "";
    String sqlcount = "";
    if(startflag != 1){
        if (flag == 1) {
            sqlstr = "select * from gw_case_info where publishflag=1";
            sqlcount = "select count(*) from gw_case_info  where publishflag=1";
        } else if (flag == 0) {
            sqlstr = "select * from gw_case_info where publishflag=0";
            sqlcount = "select count(*) from gw_case_info  where publishflag=0";
        } else {
            sqlstr = "select * from gw_case_info";
            sqlcount = "select count(*) from gw_case_info";
        }
        rows = GWMgr.getGwCount(sqlcount);
        list = GWMgr.getgw(startrow,range,sqlstr);

    }else{
        int radio = ParamUtil.getIntParameter(request,"radio",0);
        String searchname = ParamUtil.getParameter(request,"searchname");
        jumpstr = "&startflag=" + startflag + "&searchname=" + searchname + "&radio=" + radio;
        if(radio == 1){
            String sqlsearch = "select * from gw_case_info where operater like '@" + searchname + "@'";
            String sqlsearchcount = "select count(*) from gw_case_info where operater like '@" +searchname +"@'";
            rows = GWMgr.getGwCount(sqlsearchcount);
            list = GWMgr.getgw(startrow,range,sqlsearch);

        }else if(radio == 2){
            String sqlsearch = "select * from gw_case_info where telephone like '@" + searchname + "@'";
            String sqlsearchcount = "select count(*) from gw_case_info where telephone like '@" + searchname + "@'";
            rows = GWMgr.getGwCount(sqlsearchcount);
            list = GWMgr.getgw(startrow,range,sqlsearch);
        } else{
            String sqlsearch = "select * from gw_case_info where applicant like '@" + searchname + "@'";
            String sqlsearchcount = "select count(*) from gw_case_info where applicant like '@" + searchname + "@'";
            rows = GWMgr.getGwCount(sqlsearchcount);
            list = GWMgr.getgw(startrow,range,sqlsearch);
        }
    }


    int gwCount = list.size();
    int totalpages = 0;
    int currentpage = 0;
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


%>

<html>
<head>
    <title>ҵ�����������ʾ</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <meta http-equiv="Pragma" content="no-cache">
    <style type="text/css">
        TABLE {FONT-SIZE: 12px;word-break:break-all}
        BODY {FONT-SIZE: 12px;margin-top: 0px;margin-bottom: 0px; line-height:20px;}
        .TITLE {FONT-SIZE:16px; text-align:center; color:#FF0000; font-weight:bold; line-height:30px;}
        .FONT01 {FONT-SIZE: 12px; color:#FFFFFF; line-height:20px;}
        .FONT02 {FONT-SIZE: 12px; color:#D04407; font-weight:bold; line-height:20px;}
        .FONT03 {FONT-SIZE: 14px; color:#000000; line-height:25px;}
        A:link {text-decoration:none;line-height:20px;}
        A:visited {text-decoration:none;line-height:20px;}
        A:active {text-decoration:none;line-height:20px; font-weight:bold;}
        A:hover {text-decoration:none;line-height:20px;}
        .pad {padding-left:4px; padding-right:4px; padding-top:2px; padding-bottom:2px; line-height:20px;}
        .form{border-bottom:#000000 1px solid; background-color:#FFFFFF; border-left:#000000 1px solid; border-right:#000000 1px solid; border-top:#000000 1px solid; font-size: 9pt; font-family:"����";}
        .botton{border-bottom:#000000 1px solid; background-color:#F1F1F1; border-left:#FFFFFF 1px solid; border-right:#333333 1px solid; border-top:#FFFFFF 1px solid; font-size: 9pt; font-family:"����"; height:20px; color: #000000; padding-bottom: 1px; padding-left: 1px; padding-right: 1px; padding-top: 1px; border-style: ridge}
    </style>
    <script language="javascript">
        function golist(r,jumpstr){
            window.location = "index.jsp?flag=<%=flag%>&startrow="+r + jumpstr;
        }
        function CA(){
            for (var i = 0; i < document.form1.elements.length; i++)
            {
                var e = document.form1.elements[i];
                if (e.name != 'allbox' && e.type == 'checkbox')
                {
                    e.checked = document.form1.allbox.checked;
                }
            }
        }

        function checksearch(){
            var search  = document.form2.searchname.value;
            if( search == "" ){
                alert("��������������");
                return false;
            }
            return true;
        }

        function uploaddb(){
            var winstr="upload.jsp";
            window.open(winstr,"uploadaccessfile","width=400,height=400,left=200,top=200");
        }

        function addnew(){
            var winstr="addnew.jsp";
            window.open(winstr,"uploadaccessfile","width=800,height=800,left=20,top=20");
        }

        function uploadfilelist(){
            var   w=screen.availWidth-10;
            var   h=screen.availHeight-30;
            var winstr="uploadlist.jsp";
            window.open(winstr,"uploadmdbfilelist", "fullscreen=0,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1,width= "   +   w   +   ",height= "   +   h   +   ",top=0,left=0 ",true);
        }
    </script>
</head>

<body>
<form action="doGwpublish.jsp" method="post" name="form1">
    <input type=hidden name=startrow value="<%=startrow%>">
    <input type=hidden name=range value="<%=range%>">
    <input type="hidden" name="startflag" value="1">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0">
                    <tr bgcolor="#F4F4F4">
                        <td>ҵ�����������ʾ</td>
                        <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003"><a href="#" onclick="javascript:uploaddb()">�ϴ�ACCESS�ļ�</a>&nbsp;&nbsp;<a href="#" onclick="javascript:uploadfilelist()">�Ѿ��ϴ���ACCESS�ļ�</a></td>
                        <td align="left"><!--a href="#" onclick="javascript:addnew()">����</a-->    <a href="index.jsp?flag=1&startrow=<%=startrow%>">����</a>     <a href="index.jsp?flag=0&startrow=<%=startrow%>">δ��</a>    <a href="index.jsp?flag=2&startrow=<%=startrow%>">ȫ��</a></td>
                    </tr>
                    <tr bgcolor="#d4d4d4">
                        <td colspan="3" >
                            <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                                <tr  bgcolor="#FFFFFF" class="css_001">
                                    <td align="center" width="5%">���ͨ��</td>
                                    <td width="5%" align="center">ҵ�����</td>
                                    <td align="center" width="5%">ҵ������</td>
                                    <td align="center" width="5%">�걨��</td>
                                    <td align="center" width="5%">�걨������</td>
                                    <td align="center" width="5%">�����˵绰</td>
                                    <td align="center" width="15%">�������������</td>
                                    <td align="center" width="10%">���������֤������</td>
                                    <td align="center" width="5%">����ע���</td>
                                    <td align="center" width="5%">��������˵绰</td>
                                    <td align="center" width="5%">��ȡ����</td>
                                    <td align="center" width="5%">���ڰ�����</td>
                                    <td align="center" width="5%">���ڰ�������</td>
                                    <td align="center" width="5%">�������</td>
                                    <td align="center" width="5%">���֤������</td>
                                    <td align="center" width="5%">���֤���ĺ�</td>
                                    <td align="center" width="5%">��������</td>
                                    <!--td align="center" width="5%">�޸�</td>
                                    <td align="center" width="5%">ɾ��</td-->
                                </tr>

                                <%
                                    String allsns = "";
                                    for(int i=0;i< list.size(); i++){
                                        Gwcase gw = (Gwcase)list.get(i);
                                        allsns = allsns +"'"+ gw.getSn()+"'" + "," ;
                                        String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
                                        out.println("<tr bgcolor=" + bgcolor + " class=itm onmouseover=\"this.style.background='#CECEFF';\" onmouseout=\"this.style.background='" + bgcolor + "';\" height=25><td align=center>");
                                        if (gw.getPublishflag() == 1)
                                            out.print("<input checked type=checkbox name=sn value=" + gw.getSn() + ">");
                                        else
                                            out.print("<input type=checkbox name=sn value=" + gw.getSn() + ">");
                                        out.println("</td>");

                                %>

                                <td align="center" width="5%"><%=gw.getCaseID()==null?"-":gw.getCaseID()%></td>
                                <td align="center" width="5%"><%=gw.getCaseName()==null?"-":gw.getCaseName()%></td>
                                <td width="5%" align="center"><%=gw.getSn()==null?"-":gw.getSn()%></td>
                                <td align="center" width="5%"><%=gw.getOperater()==null?"-":gw.getOperater()%></td>
                                <td align="center" width="5%"><%=gw.getTelephone()==null?"-":gw.getTelephone()%></td>
                                <td align="center" width="5%"><%=gw.getApplicant()==null?"-":gw.getApplicant()%></td>
                                <td align="center" width="15%"><%=gw.getApplicantID()==null?"-":gw.getApplicantID()%></td>
                                <td align="center" width="10%"><%=gw.getRegisterNO()==null?"-":gw.getRegisterNO()%></td>
                                <td align="center" width="5%"><%=gw.getApplicanttel()==null?"-":gw.getApplicanttel()%></td>
                                <td align="center" width="5%"><%= Float.toString(gw.getCharge())== null ?"-":gw.getCharge()%></td>
                                <td align="center" width="5%"><%=gw.getResult()==null?"-":gw.getResult()%></td>
                                <td align="center" width="5%"><%=gw.getDt_operate()==null?"-":gw.getDt_operate().substring(0,10)%></td>
                                <td align="center" width="5%"><%=gw.getStartingDate()==null?"-":gw.getStartingDate().subSequence(0,10)%></td>
                                <td align="center" width="5%"><%=gw.getLicenceName()==null?"-":gw.getLicenceName()%></td>
                                <td align="center" width="5%"><%=gw.getLicenceCode()==null?"-":gw.getLicenceCode()%></td>

                                <%
                                        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        Timestamp time  = new Timestamp(System.currentTimeMillis()) ;
                                        String curdate = df.format(time);
                                        int workdays = GWMgr.getWorkdays(curdate.substring(0,10),gw.getDt_operate().substring(0,10),siteid);
                                        if( !gw.getResult().equals("ͨ��") &&  workdays > 20 ){
                                            out.print("<td align=center width= 5% ><font color = #FF0000>���촦��</font></td>");
                                        }else{
                                            out.print("<td align=center width= 5% >״̬����</td>");
                                        }
                                        //out.print("<td align=\"center\" width=\"5%\"><font color=\"red\">��</font></td>");
                                        //out.print("<td align=\"center\" width=\"5%\"><font color=\"red\">ɾ</font></td>");
                                        out.print("</tr>");
                                    }
                                %>
                            </table></td></tr></table></td></tr></table>

    <%if (gwCount > 0) {%>
    <table border="0" width="98%" cellspacing=0 cellpadding=0 align=center>
        <tr>
            <td><input type=checkbox name=allbox value="CheckAll" onClick="CA();">ȫ��ѡ��
                &nbsp;&nbsp;<input type=submit value=" ������� " class=tine>
            </td>
        </tr>
    </table>
    <input type="hidden" name="allsns" value="<%=allsns%>">
    <%}%>
</form>

<form action="index.jsp" method="post" name="form2">
    <table width="70%" class="css_002">
        <tr valign="bottom" width=100%>
            <td width="30%" align="center" colspan="2">
                ��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ&nbsp;  ��<%=rows%>��&nbsp;   ÿҳ��ʾ<%=range%>��
            </td>

            <td class="css_002" width="30%" align="center" colspan="2" >
                <%
                    if((startrow-range)>=0){
                %>
                [<a href="index.jsp?flag=<%=flag%>&startrow=<%=startrow-range%><%=jumpstr%>" class="css_002">��һҳ</a>]
                <%}
                    if((startrow+range)<rows){
                %>
                [<a href="index.jsp?flag=<%=flag%>&startrow=<%=startrow+range%><%=jumpstr%>" class="css_002">��һҳ</a>]
                <%}

                    if(totalpages>1){%>
                &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
                <a href="#" class="css_002" onclick="golist((document.all('jump').value-1) * <%=range%>,'<%=jumpstr%>');">GO</a>
                <%}%>
            </td>

            <td align="right" width="40%" colspan="3">
                <input type="hidden" name="startflag" value="1">
                <select name="radio">
                    <option value="1">�걨����������</option>
                    <option value="2">�걨��������ϵ�绰</option>
                    <option value="3">�������������(��λ����)</option>
                </select>

                <input type="text" name="searchname" >
                <input type="submit" value="��ѯ" onclick="return checksearch();">
            </td>
        </tr>
    </table>
</form>

</body>
</html>