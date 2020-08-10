<%@ page import="java.util.*,
                 com.bizwink.cms.toolkit.companyinfo.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.server.CmsServer" contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.cms.util.Map" %>
<%@ page import="com.bizwink.cms.refers.IRefersManager" %>
<%@ page import="com.bizwink.cms.refers.RefersPeer" %>
<%@ page import="com.bizwink.cms.tree.*" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String username = authToken.getUserID();
    String sitename = authToken.getSitename();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int flag = ParamUtil.getIntParameter(request, "flag", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int msgno = ParamUtil.getIntParameter(request, "msgno", 1);
    boolean doSearch = ParamUtil.getBooleanParameter(request, "doSearch");
    int siteid=authToken.getSiteID();
    ICompanyinfoManager companyManager = CompanyinfoPeer.getInstance();
    List companyList = new ArrayList();
    int total = 0;
    String href = null;
    try {
        companyList = companyManager.getCompanyInfos(siteid,columnID, start, range, username,flag);
        total = companyManager.getCompanyInfos_num(siteid,columnID, username,0);
    } catch (Exception e) {
        e.printStackTrace();
    }

    int companyCount = companyList.size();
    int totalpages = 0;
    if (total > 0) {
        if (total % 20 == 0) {
            totalpages = total / 20;
        } else {
            totalpages = total / 20 + 1;
        }
    }
%>

<html>
<head>
    <title>��ҵ�����б�</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../css/global.css">
    <script language="javascript" src="../js/setday.js"></script>
    <script language="javascript">
        function createCompany(columnID)
        {
            window.open("createcompany.jsp?column=" + columnID, "", "width=800,height=600,left=100,top=50,status,scrollbars");
        }

        function editCompany(columnID, companyID, range, start, from)
        {
            window.open("editcompany.jsp?column=" + columnID + "&company=" + companyID + "&range=" + range + "&start=" + start + "&fromflag=" + from, "", "width=935,height=650,left=5,top=5,status,scrollbars");
        }

        function upload(columnid,companyid)
        {
            window.open("upload.jsp?column="+columnid + "&id="+companyid, "UploadPics", "width=600,height=400,left=20,top=20,scrollbars");
        }

        function Preview(articleID, columnId)
        {
            window.open("preview.jsp?article=" + articleID + "&column=" + columnId, "Preview", "width=800,height=600,left=5,top=5,scrollbars");
        }

        function checkNum(str)
        {
            var success = true;
            for (var i = 0; i < str.length; i++)
            {
                if (str.substring(i, i + 1) < '0' || str.substring(i, i + 1) > '9')
                {
                    success = false;
                    break;
                }
            }
            return success;
        }

        function search(item)
        {
            if (item == 'doclevel')
            {
                if (!checkNum(searchForm.doclevel1.value) || !checkNum(searchForm.doclevel2.value))
                {
                    alert("Ȩ��ӦΪ������");
                    return;
                }
            }

            searchForm.action = "articles.jsp?item=" + item;
            searchForm.submit();
        }

        function moreSearch()
        {
            if (searchDiv.style.display == "")
                searchDiv.style.display = "none";
            else
                searchDiv.style.display = "";
        }

        function CA()
        {
            for (var i = 0; i < document.form1.elements.length; i++)
            {
                var e = document.form1.elements[i];
                if (e.name != 'allbox' && e.type == 'checkbox')
                {
                    e.checked = document.form1.allbox.checked;
                }
            }
        }

        function WebEdit()
        {
            window.open("../webedit/index.jsp?column=<%=columnID%>&right=4", "WebEdit", "width=850,height=600,left=5,top=5,scrollbars");
        }

        function golist(r, id, type) {
            var bor = (r - 1) * 20;
            if (isNumber(r)) {
                window.location = "articles.jsp?start=" + bor + "&column=" + id + "&flag=" + type;
            }
        }
        function isNumber(num) {
            var strRef = "1234567890";
            for (i = 0; i < num.length; i++)
            {
                tempChar = num.substring(i, i + 1);
                if (strRef.indexOf(tempChar, 0) == -1) {
                    alert("����ҳ�벻��ȷ��");
                    return false;
                }
            }
            return true;
        }
    </script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%
    String[][] titlebars = {
            {"��ҵ��Ϣ����", ""}
    };

    String[][] operations = {
            {"<a href=javascript:createCompany(" + columnID + ")>�½�</a>&nbsp;", ""},
            {"δ��", "unusedarticle.jsp?column=" + columnID}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>
<table cellpadding=1 cellspacing=1 width=100% border=0>
    <tr>
        <td align=center class=cur>
            <%
                if (msgno == 0)
                    out.println("ҳ�淢���ɹ���");
                else if (msgno == -1)
                    out.println("ĳ��Ŀû����������ҳģ�壡");
                else if (msgno == -2)
                    out.println("д�ļ�ʱ���ִ���");
                else if (msgno == -3)
                    out.println("���������б��ļ�ʱ���ִ���");
                else if (msgno == -4)
                    out.println("ĳ��Ŀģ����ļ���Ϊ�գ�");
                else if (msgno == 2)
                    out.println("����RSS�ɹ���");
            %>
        </td>
    </tr>
</table>
<%
    if (companyCount > 0) {
        out.println("<table cellpadding=1 cellspacing=1 width=100% border=0>");
        out.println("<tr><td width=50% align=left class=line>");
        if (start - range >= 0) {
            if (href == null)
                out.println("<a href=articles.jsp?flag=" + flag + "&column=" + columnID + "&range=" + range + "&start=" + (start - range) + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
            else
                out.println("<a href=" + href + "&range=" + range + "&start=" + (start - range) + "><img src=../images/btn_previous.gif align=bottom border=0></a>" + start);
        }
        out.println("</td><td width=50% align=right class=line>");
        if (start + range < total) {
            int remain = ((start + range - total) < range) ? (total - start - range) : range;
            if (href == null)
                out.println(remain + "<a href=articles.jsp?flag=" + flag + "&column=" + columnID + "&range=" + range + "&start=" + (start + range) + "><img src=../images/btn_next.gif align=bottom border=0></a>");
            else
                out.println(remain + "<a href=" + href + "&range=" + range + "&start=" + (start + range) + "><img src=../images/btn_next.gif align=bottom border=0></a>");
        }
        out.println("</td></tr></table>");
    }
%>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
<form action="doArticleRSS.jsp" method=Post name=form1>
<input type=hidden name=column value="<%=columnID%>">
<input type=hidden name=start value="<%=start%>">
<input type=hidden name=range value="<%=range%>">
<tr class=itm bgcolor="#dddddd" height=20>
    <td align=center width="4%">ѡ��</td>
    <td align=center width="4%">״̬</td>
    <td align=center width="23%"><a href="articles.jsp?flag=1&column=<%=columnID%>">����</a></td>
    <td align=center width="11%"><a href="articles.jsp?flag=0&column=<%=columnID%>">����ʱ��</a></td>
    <td align=center width="10%">�༭��</td>
    <td align=center width="10%">�ϴ�</td>
    <td align=center width="6%">�޸�</td>
    <td align=center width="6%">ɾ��</td>
</tr>
    <%
  for (int i = 0; i < companyCount; i++) {
    Companyinfo company = (Companyinfo) companyList.get(i);

    int companyID = company.getId();
    columnID = company.getCompanyclassid();    
    String maintitle = StringUtil.gb2iso4View(company.getCompanyname());
    int pubflag = company.getPublishflag();
    String publishtime = "&nbsp;";
    if (company.getLastupdated() != null) publishtime = company.getLastupdated().toString().substring(0, 16);

    //�Ƿ����������,Ϊ��,���ʾ��������л���������
    String bgcolor = (i % 2 == 0) ? "#ffffff" : "#eeeeee";
    out.println("<tr bgcolor=" + bgcolor + " class=itm onmouseover=\"this.style.background='#CECEFF';\" onmouseout=\"this.style.background='" + bgcolor + "';\" height=25><td align=center>");
    out.print("<input type=checkbox name=article value=" + companyID + ">");
    out.println("</td>");
              switch (pubflag) {
            case 0:
              out.println("<td align=center><img src=\"../images/yi.gif\" border=0 alt=\"�ѷ���\"></td>");
              break;
            case 1:
                   out.println("<td align=center><img src=\"../images/xin.gif\" border=0 alt=\"�¸�\"></td>");
              break;
            case 2:
              out.println("<td align=center><font color=red>������</font></td>");
              break;
            default:
              break;
          }
    out.println("</td>");

    out.println("<td><a href=javascript:editCompany(" + columnID + "," + companyID + "," + range + "," + start + ",'c');" + "'>" + maintitle + "</a></td>");

    out.println("<td align=center>" + publishtime + "</td>");
    out.println("<td align=center>&nbsp;</td>");
    out.println("<td align=center><a href=javascript:upload(" + columnID+ "," + companyID + ")>�ϴ�</></td>");
    out.println("<td align=center>");
    out.println("<a href=javascript:editCompany(" + columnID + "," + companyID + "," + range + "," + start + ",'c');><img src=\"../images/edit.gif\" alt=\"�༭����\" align=bottom border=0></a>");
    out.println("</td>");
    out.println("<td align=center>");
        out.println("<a href=\"deleteCompany.jsp?column=" + columnID + "&company=" + companyID + "&start=" + start + "&range=" + range + "&fromflag=a\"><img src=\"../images/del.gif\" align=bottom border=0 alt=\"ɾ������\"></a>");
    out.println("</td>");
    out.println("</tr>");
  }
%>
</table>
</form>
<form action="" method=Post name=searchForm>
    <input type=hidden name=doSearch value=true>
    <input type=hidden name=column value="<%=columnID%>">
    <table border="0" width="98%" cellspacing=0 cellpadding=0 align=center>
        <tr>
            <td width="40%">��&nbsp;&nbsp;�⣺&nbsp;&nbsp;<input name=maintitle size=30></td>
            <td width="20%"><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                   onclick="search('maintitle');">&nbsp;&nbsp;&nbsp;&nbsp;<a
                    href="javascript:moreSearch();">�߼�����</a>
            </td>
            <td width="40%">��ǰ��Ŀ����������Ϊ��<%=total%>&nbsp;&nbsp;
                <%if (totalpages >= 1) {%>��<%=totalpages%>ҳ&nbsp;��<%=(start + range) / 20%>ҳ&nbsp;&nbsp;
                ����<input type="text" name="jump" value="<%=(start+range)/20%>" size="2">
                <a href="javascript:golist(document.all('jump').value,<%=columnID%>,<%=flag%>);">GO</a><%}%>
            </td>
        </tr>
        <tr>
            <td colspan=3></td>
        </tr>
    </table>
    <div id=searchDiv style="display:none">
        <table border="0" width="98%" cellspacing=0 cellpadding=0 align=center>
            <tr>
                <td width="40%">����ID��&nbsp;&nbsp;<input name=id size=30></td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('id');"></td>
            </tr>
            <tr>
                <td width="40%">�ؼ��֣�&nbsp;&nbsp;<input name=keyword size=30></td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('keyword');"></td>
            </tr>
            <tr>
                <td width="40%">�����⣺&nbsp;&nbsp;<input name=vicetitle size=30></td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('vicetitle');"></td>
            </tr>
            <tr>
                <td width="40%">��&nbsp;&nbsp;�ߣ�&nbsp;&nbsp;<input name=author size=30></td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('author');"></td>
            </tr>
            <tr>
                <td width="40%">��&nbsp;&nbsp;Դ��&nbsp;&nbsp;<input name=source size=30></td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('source');"></td>
            </tr>
            <tr>
                <td width="40%">�������ڣ�<input name=publishtime1 size=12 onfocus="setday(this)">&nbsp;��&nbsp;&nbsp;<input
                        name=publishtime2 size=12 onfocus="setday(this)"></td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('publishtime');"></td>
            </tr>
            <tr>
                <td width="40%">Ȩ�ط�Χ��<input name=doclevel1 size=12>&nbsp;��&nbsp;&nbsp;<input name=doclevel2 size=12>
                </td>
                <td width="60%" colspan=2><input style="height:20;width:40;font-size:9pt" type=button value=" ���� "
                                                 onclick="search('doclevel');"></td>
            </tr>
            <tr>
                <td width="40%">����״̬��<input type=radio name=status value=1>�¸�
                    <input type=radio name=status value=2>�ѷ���
                    <input type=radio name=status value=3>δ��
                    <input type=radio name=status value=4>����
                    <input type=radio name=status value=5>�˸�
                </td>
                <td width="10%"><input style="height:20;width:40;font-size:9pt" type=button value=" ���� " onclick="search('status');"></td>
                <td width="50%"><input class=tine type=button value=" ������� " onclick="search('all');"></td>
            </tr>
        </table>
    </div>
</form>

</BODY>
</html>
