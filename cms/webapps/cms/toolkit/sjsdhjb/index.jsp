<%@page import="com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.sjswsbs.*" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    //System.out.println("==========="+siteid);
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int seltype = ParamUtil.getIntParameter(request, "seltype", 1);
    String querystr = ParamUtil.getParameter(request, "querystr");
    int qstr = ParamUtil.getIntParameter(request, "qstr",0);
    if (startrow < 0) {
        startrow = 0;
    }

    IWsbsManager wsbsMgr = WsbsPeer.getInstance();
    List list = new ArrayList();
    List currentlist = new ArrayList();
  //  List deptlist = new ArrayList();
  //  deptlist = wsbsMgr.getAllCatgEntity(2,3);
   // CatgEntity catg = new CatgEntity();
    //ReportGangdom reportGangdom = new ReportGangdom();


    //int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

    if(startflag == 1){
        String sqlstr = "";
        String sqlstr1 = "";

        if (seltype == 1) {
            sqlstr = "select * from tbl_report_gangdom_message  where reportedname like '@" + querystr + "@'";
            sqlstr1 = "select count(id) from tbl_report_gangdom_message  where reportedname like '@" + querystr + "@'";
        } else if (seltype == 2) {
            sqlstr = "select * from tbl_report_gangdom_message where epithet like '@" + querystr + "@'";
            sqlstr1 = "select count(id) from tbl_report_gangdom_message  where epithet like '@" + querystr + "@'";
        } /*else if (seltype == 3) {
            sqlstr = "select * from tbl_sjs_wsbs where depid =" + qstr;
            sqlstr1 = "select count(id) from tbl_report_gangdom_message  where depid =" + qstr;
        }*/

        rows = wsbsMgr.getAlldhjbNum(sqlstr1);
        currentlist = wsbsMgr.getCurrentQureydhjbList(sqlstr, startrow, range);
    }else{
        rows = wsbsMgr.getAlldhjbNum();
        currentlist = wsbsMgr.getCurrentdhjbList(startrow, range);
    }

    if (rows < range) {
        totalpages = 1;
        currentpage = 1;
    } else {
        if (rows % range == 0)
            totalpages = rows / range;
        else
            totalpages = rows / range + 1;

        currentpage = startrow / range + 1;
    }
%>
<HTML>
<HEAD><TITLE>��ھٱ�</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="images/common.css" type=text/css rel=stylesheet>
    <LINK href="images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function DelWsbs(id)
        {
            var bln = confirm("���Ҫɾ����");
            if (bln)
            {
                window.location = "delete.jsp?id=" + id;
            }
        }

        function searchcheck() {
            if(form1.seltype.value != 3){
                if ((form1.querystr.value == null) || (form1.querystr.value == "")) {
                    alert("������Ҫ��ѯ�����ݣ�");
                    return false;
                }
            }
            form1.submit();
            return true;
        }
        function t(obj)
        {
            if(obj.value=="3"){
                document.getElementById("a").style.display = "";
                document.getElementById("b").style.display = "none";
            }else{
                document.getElementById("a").style.display = "none";
                document.getElementById("b").style.display = "";
            }
        }
    </SCRIPT>
</HEAD>
<BODY>
<P align=right><FONT color=#0000ff><A href="index.jsp">�鿴ȫ��</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href="../index.jsp">����</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </FONT> <BR></P>

<FORM name=form1 action=index.jsp method=post>
    <INPUT type=hidden value=1 name=startflag>
    <p align=center>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD align=middle width="4%">���</TD>
            <TD align=middle width="5%">���ٱ���</TD>
            <TD align=middle width="5%">�º�</TD>
            <TD align=middle width="10%">��ϵ�绰��סַ</TD>
            <TD align=middle width="10%">���֤��</TD>
            <TD align=middle width="10%">����</TD>
            <TD align=middle width="30%">���ٱ�����</TD>
            <TD align=middle width="5%">�ύʱ��</TD>
            <TD align=middle width="4%">���</TD>
            <TD align=middle width="4%">ɾ��</TD>

        </TR>
        <%
            if (currentlist != null) {
                for (int i = 0; i < currentlist.size(); i++) {
                    ReportGangdom reportGangdom = (ReportGangdom) currentlist.get(i);
        %>
        <TR height=35>
            <TD align=middle width="4%"><%=i + 1%>
            </TD>
            <TD align=middle width="5%"><%=reportGangdom.getReportedname()==null?"--":reportGangdom.getReportedname()%>
            </TD>
            <TD align=middle width="5%"><%=reportGangdom.getEpithet()==null?"--":reportGangdom.getEpithet()%>
            </TD>
            <TD align=middle width="10%"><%=reportGangdom.getRpaddress()==null?"--":reportGangdom.getRpaddress()%>
            </TD>
            <TD align=middle width="10%"><%=reportGangdom.getRpidcardno()==null?"--":reportGangdom.getRpidcardno()%>
            </TD>
            <TD align=middle width="10%"><%=reportGangdom.getCounty().endsWith("-1")?"--":reportGangdom.getCounty()%>
            </TD>
            <TD align=middle width="30%"><%=reportGangdom.getReportedcontent()==null?"--":reportGangdom.getReportedcontent()%>
            </TD>
            <TD align=middle width="10%"><%=reportGangdom.getCreatedate().toString().substring(0,19)%>
            </TD>
            <TD align=middle width="4%"><A
                    target="_blank" href="view.jsp?id=<%=reportGangdom.getId()%>"><IMG
                    src="images/preview.gif" border=0></A></TD>

            <TD align=middle width="4%">
                <A href="#" onclick="javascript:return DelWsbs(<%=reportGangdom.getId()%>);">
                    <IMG src="images/del.gif" border=0></A></TD>

        </TR>
        <%
                }
            }
        %>
        </TBODY>
    </TABLE></p>
    <BR>

    <p align=center>
    <TABLE>
        <TBODY>
        <TR>
            <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp; ��<%=rows%>��&nbsp;&nbsp; ��ǰ��<%=currentpage%>ҳ&nbsp;
                <%
                    if ((startrow - range) >= 0) {
                %>
                <a href="index.jsp?startrow=0&startflag=<%=startflag%>&seltype=<%=seltype%>&querystr=<%=querystr%>&qstr=<%=qstr%>">��һҳ</a>
                <%}%>
                <%if ((startrow - range) >= 0) {%>
                <a href="index.jsp?startrow=<%=startrow-range%>&startflag=<%=startflag%>&seltype=<%=seltype%>&querystr=<%=querystr%>&qstr=<%=qstr%>">��һҳ</a>
                <%}%>
                <%if ((startrow + range) < rows) {%>
                <A href="index.jsp?startrow=<%=startrow+range%>&startflag=<%=startflag%>&seltype=<%=seltype%>&querystr=<%=querystr%>&qstr=<%=qstr%>">��һҳ</A>
                <%}%>
                <%if (currentpage != totalpages) {%>
                <A href="index.jsp?startrow=<%=(totalpages-1)*range%>&startflag=<%=startflag%>&seltype=<%=seltype%>&querystr=<%=querystr%>&qstr=<%=qstr%>">���һҳ</A>
                <%}%>
            </TD>
            <TD>&nbsp;</TD>
        </TR>
        </TBODY>
    </TABLE></p>
    <BR><BR>

    <p align=center>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD>&nbsp;&nbsp;������<select name="seltype"  onchange="t(this)">
                <option value="1">���ٱ���</option>
                <option value="2">�º�</option>
                <%--<option value="3">����ί���</option>--%>
            </select>
               <%-- <select name="qstr" id="a" style="display:none">
                    <%
                        if(deptlist != null){
                            for(int i = 0; i < deptlist.size(); i++){
                                catg = (CatgEntity)deptlist.get(i);
                    %>
                    <option value="<%=catg.getId()%>"><%=catg.getName()%></option>
                    <%}}%>
                </select>--%>
                <input type="text" id="b" size=40 name="querystr">&nbsp;&nbsp;<input type="button" value=" �� ѯ "
                                                                                     onclick="javascript:return searchcheck();">
            </TD>
        </tr>
        </tbody>
    </table></p>

</FORM>
</BODY>
</HTML>
