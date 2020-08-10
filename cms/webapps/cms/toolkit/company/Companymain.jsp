<%@ page import="com.bizwink.cms.toolkit.companyinfo.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>

<%@ page language="java" contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
        if (authToken == null)
        {
            response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
            return;
        }
    int siteid = authToken.getSiteID();
    int comcolumnid = ParamUtil.getIntParameter(request,"id",0);
     out.print(comcolumnid);
    int startIndex = ParamUtil.getIntParameter(request, "startIndex", 0);
    int rowsInPage = ParamUtil.getIntParameter(request, "rowsInPage", 20);


    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);

    ICompanyinfoManager comMgr = CompanyinfoPeer.getInstance();
    String sql = "select * from tbl_company_info where siteid =" + siteid + " order by id desc";
    String sqlcount = "select count(id) from tbl_company_info where siteid =" + siteid;
    int totalNum = 0;
    int totalPage = 0;


    List companyList = new ArrayList();
    String jumpstr = "";
    if (startflag != 1) {
        totalNum = comMgr.getCompanyNum(sqlcount);
        companyList = comMgr.getCompanyInfo(startIndex, rowsInPage, sql);
    } else {
        //startIndex = 0;//
        String searchname = ParamUtil.getParameter(request, "searchname");
        System.out.println("search=" + searchname);
        jumpstr = "&startflag=" + startflag + "&searchname=" + searchname;
        String sqlsearch = "select * from tbl_company_info where siteid =" + siteid + " and companyname like '@" + searchname + "@' order by id desc";
        String sqlsearchcount = "select count(id) from tbl_company_info where siteid =" + siteid + " and companyname like '@" + searchname + "@'";
        totalNum = comMgr.getCompanyNum(sqlsearchcount);

        companyList = comMgr.getCompanyInfo(startIndex,rowsInPage, sqlsearch);
    }

    if (totalNum == 0) {
        totalPage = 0;
    } else if (totalNum <= rowsInPage) {
        totalPage = 1;
    } else {
        if (totalNum % rowsInPage == 0) {
            totalPage = totalNum / rowsInPage;
        } else {
            totalPage = totalNum / rowsInPage + 1;
        }
    }
%>
<html>
<head>
    <title>��ҵ��Ϣ����</title>
    <script type="text/javascript" language="javascript">
        function goPage(page, siteid, currPage, jumpstr) {
            var getpagenum = document.getElementById("num").value;
            window.location = "index.jsp?startIndex=" + ( getpagenum - 1) * page + "&siteid=" + siteid + "&currPage=" + currPage + jumpstr;
        }

    </script>
    <style type="text/css">
        td {
            font-size: 12px;
        }
    </style>
</head>
<body vLink=#000099 aLink=#cc0000 link=#000099 bgColor=#ffffff TOMARGIN="8">

<table cellSpacing=0 borderColorDark=#ffffec cellPadding=0 width="100%"
       borderColorLight=#5e5e00 border=1>
    <tr>
        <td align="center" width="50%"><a href="addCompany.jsp?siteid=<%=siteid%>&comcolumnid=<%=comcolumnid%>">�����ҵ��Ϣ</a></td>
        <td align="center"><a  href="publish.jsp?siteid=<%=siteid%>">����</a></td>
    </tr>
    <br>
    <br>
</table>
<br>
<br>
<table cellSpacing=0 borderColorDark=#ffffec cellPadding=0 width="100%"
       borderColorLight=#5e5e00 border=1>
    <form name="ListForm" action="index.jsp" method="post">
        <input type="hidden" name="startflag" value="1">
        <input type="hidden" name="siteid" value="<%=siteid%>">
        <tr class=itm bgColor=#dddddd height=20>
            <td align="center">��˾����</td>
            <td align="center">��ַ</td>
            <td align="center">�绰</td>
            <td align="center">����</td>
            <td align="center">����</td>
            <td colspan="2" align="center">����</td>
        </tr>
        <%
            for (int i = 0; i < companyList.size(); i++) {
                Companyinfo companyinfo = (Companyinfo) companyList.get(i);
        %>
        <%if (i % 2 == 0) {%>
        <tr class=itm onmouseover="this.style.background='#CECEFF';"
            onmouseout="this.style.background='#ffffff';" bgColor=#ffffff height=25><%}else{%>
        <tr class=itm onmouseover="this.style.background='#CECEFF';"
            onmouseout="this.style.background='#eeeeee';" bgColor=#eeeeee height=25>
            <%}%>
            <td><%=companyinfo.getCompanyname() == null ? "&nbsp;" : StringUtil.gb2iso4View(companyinfo.getCompanyname())%>
            </td>
            <td><%=companyinfo.getCompanyaddress() == null ? "&nbsp;" : StringUtil.gb2iso4View(companyinfo.getCompanyaddress())%>
            </td>
            <td align="center"><%=companyinfo.getCompanyphone() == null ? "&nbsp;" : companyinfo.getCompanyphone()%>
            </td>
            <td align="center"><%=companyinfo.getCompanyemail() == null ? "&nbsp;" : companyinfo.getCompanyemail()%>
            </td>
            <td align="center"><%=companyinfo.getCompanyfax() == null ? "&nbsp;" : companyinfo.getCompanyfax()%>
            </td>
            <td align="center"><a
                    href="modifyCompany.jsp?id=<%=companyinfo.getId()%>&siteid=<%=siteid%>&currPage=<%=startIndex / rowsInPage%>&startIndex=<%=startIndex%>">��ϸ</a>
            </td>
            <td align="center"><a
                    href="deleteCompany.jsp?id=<%=companyinfo.getId()%>&siteid=<%=siteid%>&currPage=<%=startIndex / rowsInPage%>&startIndex=<%=startIndex%>">ɾ��</a>
            </td>

        </tr>
        <%
            }
        %>
        <tr>
            <td colspan="13" align="center">��<%=totalPage%>ҳ ��ǰ��<%=startIndex / rowsInPage + 1%>ҳ ��<%=totalNum%>����¼

<%if (startIndex >= rowsInPage) {%><a
    href="index.jsp?startIndex=0&siteid=<%=siteid%><%=jumpstr%>">��ҳ</a><%} else {%>
��ҳ<%}%>
<%if (startIndex >= rowsInPage) {%><a
    href="index.jsp?startIndex=<%=startIndex-rowsInPage%>&siteid=<%=siteid%><%=jumpstr%>">��һҳ</a><%} else {%>
��һҳ<%}%>
<%if (totalNum > (startIndex + rowsInPage)) {%><a
    href="index.jsp?startIndex=<%=startIndex+rowsInPage%>&siteid=<%=siteid%><%=jumpstr%>">��һҳ</a><%} else {%>
��һҳ<%}%>
<%if (totalNum > (startIndex + rowsInPage)) {%><a
    href="index.jsp?startIndex=<%=(totalPage-1)*rowsInPage%>&siteid=<%=siteid%><%=jumpstr%>">ĩҳ</a><%} else {%>
ĩҳ<%}%>

ת��<input type="text" name="num" size="5" id="num">ҳ<a
    href="javascript:goPage(<%=rowsInPage%>,<%=siteid%>,<%=startIndex / rowsInPage+1%>,'<%=jumpstr%>')">GO</a>&nbsp;&nbsp;
������ҵ���ƹؼ��ֲ�ѯ<input type="text" name="searchname"><input type="submit" value="�ύ��ѯ">
</td>
</tr>
</form>
</table>
</body>
</html>