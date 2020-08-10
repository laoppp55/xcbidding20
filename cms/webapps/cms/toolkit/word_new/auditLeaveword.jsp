<%@ page import="java.sql.*,
                 com.bizwink.cms.audit.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.xml.XMLProperties,
                 com.bizwink.cms.markManager.*,
                 com.bizwink.webapps.leaveword.*"
         contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean success = false;
    int siteId = authToken.getSiteID();
    String username = authToken.getUserID();
    IAuditManager auditMgr = AuditPeer.getInstance();
    IWordManager wordMgr = LeaveWordPeer.getInstance();
    IMarkManager markMgr = markPeer.getInstance();

    boolean doAudit = ParamUtil.getBooleanParameter(request, "doAudit");
    boolean doReturn = ParamUtil.getBooleanParameter(request, "doReturn");
    int lwID = ParamUtil.getIntParameter(request, "id", 0);
    int formid = ParamUtil.getIntParameter(request, "markid", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    String act = ParamUtil.getParameter(request, "act");
    String prevAuditor = null;
    String comments = null;
    String editor = null;        //���±༭��

    String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(formid));
    str = StringUtil.replace(str, "[", "<");
    str = StringUtil.replace(str, "]", ">");
    str = StringUtil.replace(str, "{^", "[");
    str = StringUtil.replace(str, "^}", "]");
    //System.out.println(str);

    //��ȡ��˹�������Ϣ
    XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
    String auditRule = properties.getProperty(properties.getName().concat(".AUDITRULE"));
    auditRule = auditRule.substring(0,auditRule.length() - 1);

    System.out.println("doReturn=" + doReturn);
    System.out.println("doAudit=" + doAudit);
    //��������
    if (doReturn)//�˸�
    {
        int backtowho = ParamUtil.getIntParameter(request, "backtowho", -1);                //�˸��ĳ��
        prevAuditor = StringUtil.iso2gb(ParamUtil.getParameter(request, "prevAuditor"));  //�˸����һ�������
        comments = StringUtil.iso2gb(ParamUtil.getParameter(request, "comments"));        //����
        editor = StringUtil.iso2gb(ParamUtil.getParameter(request, "editor"));        //�༭

        auditMgr.updateAudit_Info("", lwID, "", 3,1);    //����ԭ���������ϢΪ������Ϣ
        Audit audit = new Audit();
        audit.setArticleID(lwID);
        audit.setSign(username);
        audit.setComments(comments);
        audit.setAudittype(1);

        if (backtowho == 0)            //�˸������
        {
            audit.setStatus(1);
            audit.setBackTo(editor);
        } else if (backtowho == 1)    //�˸����һ�������
        {
            audit.setStatus(2);
            audit.setBackTo(prevAuditor);
        }
        auditMgr.Create_Article_Audit_Info(audit);
        success = true;
    }

    //�������
    if (doAudit) {
        int isAudit = ParamUtil.getIntParameter(request, "isAudit", -1);                     //�Ƿ�ͨ�����
        int backtowho = ParamUtil.getIntParameter(request, "backtowho", -1);                 //�˸��ĳ��
        prevAuditor = StringUtil.iso2gb(ParamUtil.getParameter(request, "prevAuditor"));     //�˸����һ�������
        comments = StringUtil.iso2gb(ParamUtil.getParameter(request, "comments"));           //����
        editor = StringUtil.iso2gb(ParamUtil.getParameter(request, "editor"));               //�༭

        Audit audit = new Audit();
        audit.setArticleID(lwID);
        audit.setEditor(username);
        audit.setSign(username);
        audit.setComments(comments);
        audit.setAudittype(1);
        audit.setStatus(backtowho);
        if (backtowho == 0)
            audit.setBackTo(editor);
        else if (backtowho == 1)
            audit.setBackTo(prevAuditor);

        auditMgr.AuditingLeaveword(audit, auditRule,act, isAudit, siteId, formid);
        success = true;
    }

    if (success) {
        out.println("<script LANGUAGE=JavaScript>opener.history.go(0);window.close();</script>");
        return;
    }

    Word word = wordMgr.getAWord(lwID);
    String title = StringUtil.gb2iso4View(word.getTitle());
    String content = StringUtil.gb2iso4View(word.getContent());
    String retcontent = StringUtil.gb2iso4View(word.getRetcontent());
    String writedtae = word.getWritedate().toString();

    //�ж�������һ�������
    prevAuditor = auditMgr.queryPrev_Auditor("[" + username + "]", lwID,siteId);
    if (prevAuditor == null) prevAuditor = "";

    //�����޸�,����������
    if ("update".equals(act)) comments = auditMgr.getComments(username, lwID);
%>

<html>
<head>
    <title>�������</title>
    <link REL="stylesheet" TYPE="text/css" HREF="../../style/global.css">
    <script LANGUAGE="JavaScript">
        function OpenItem()
        {
            backto.style.display = "";
            noBgcolor.bgColor = "#EEEEEE";
            document.createForm.backtoauthor.checked = true;
        <%if (prevAuditor.length() > 0){%>
            document.createForm.backtoauditor.checked = false;
        <%}%>
        }

        function CloseItem()
        {
            backto.style.display = "none";
            noBgcolor.bgColor = "";
            document.createForm.backtoauthor.checked = false;
        <%if (prevAuditor.length() > 0){%>
            document.createForm.backtoauditor.checked = false;
        <%}%>
        }
    </script>
</head>
<body>
<%
    String[][] titlebars = {
            {"����û����Իظ���Ϣ", ""}
    };
    String[][] operations = {
            {"<a href='javascript:createForm.submit();'><img src='../../images/button_modi.gif' border=0></a>", ""},
            {"<a href='javascript:window.close();'><img src='../../images/button_cancel.gif' border=0></a>", ""}
    };
%>
<%@ include file="../../inc/titlebar.jsp" %>

<form action="auditLeaveword.jsp" method="post" name=createForm>
    <input type="hidden" name="act" value="<%=act%>">
    <input type="hidden" name="markid" value="<%=formid%>">
    <input type="hidden" name="editor" value="<%=editor%>">
    <input type="hidden" name="id" value="<%=lwID%>">
    <input type="hidden" name="range" value="<%=range%>">
    <input type="hidden" name="start" value="<%=start%>">
    <table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="100%">
        <%
            if (act.equals("return")) {
                String[] result = auditMgr.getArticleInfo(lwID, username, 2);
                if (result != null) {
        %>
        <input type="hidden" name="doReturn" value="true">
        <tr>
            <td class=line bgcolor="#CECFCE">
                <font color=red><b>�˸���ǩ����</b></font>
                <input class=tine size=16 value="<%=(result[0]!=null)?result[0]:""%>" disabled>&nbsp;&nbsp;
                <font color=red><b>�˸������</b></font>
                <input class=tine size=50 value="<%=(result[1]!=null)?StringUtil.gb2iso4View(result[1]):""%>" disabled>&nbsp;&nbsp;
                <font color=red><b>�˸�ʱ�䣺</b></font><%=(result[2] != null) ? result[2] : ""%>    </td>
        </tr>
        <%}%>
        <tr>
            <td class=line>
                <table border="0" width="100%" cellspacing="0" cellpadding="0">
                    <tr height=31>
                        <td width="30%" align=left><font color=red><b>�˸����</b></font>
                            <input type="radio" value="0" name="backtowho" id="backtoauthor" checked>�༭&nbsp;&nbsp;
                            <%if (prevAuditor.length() > 0) {%>
                            <input type=hidden name="prevAuditor" value="<%=prevAuditor%>">
                            <input type="radio" value="1" name="backtowho" id="backtoauditor">��һ�������(<b><%=prevAuditor%>
                            </b>)
                            <%}%>                </td>
                        <td width="10%"><p align="right"><font color=red><b>ǩ����</b></font></td>
                        <td width="10%">&nbsp;<input size="16" class=tine value="<%=username%>" disabled></td>
                        <td width="10%"><p align="right"><font color=red><b>���飺</b></font></td>
                        <td width="40%" rowspan="2">&nbsp;<input name="comments" size=40 maxlength=500></td>
                    </tr>
                </table>    </td>
        </tr>
        <%} else {%>
        <input type="hidden" name="doAudit" value="true">
        <tr>
            <td class=line>
                <table border="0" width="100%" cellspacing="0" cellpadding="0">
                    <tr height=31>
                        <td width="9%" align=left><font color=blue>�Ƿ�ͨ����</font></td>
                        <td width="12%" align=left>
                            <table border="0" width="100%" cellspacing="0" cellpadding="0" height=31>
                                <tr>
                                    <td><input type="radio" value="1" checked name="isAudit" onClick="javascript:CloseItem();">��                            </td>
                                    <td name=noBgcolor id=noBgcolor><input type="radio" value="0" name="isAudit"
                                                                           onclick="javascript:OpenItem();">��                            </td>
                                </tr>
                            </table>                </td>
                        <td width="9%"><p align="right"><font color=blue>ǩ����</font></td>
                        <td width="12%">&nbsp;<input size="16" class=tine disabled value="<%=username%>"></td>
                        <td width="8%"><p align="right"><font color=blue>���飺</font></td>
                        <td width="50%" rowspan="2">&nbsp;<textarea rows="3" name="comments" cols="68"
                                                                    class=tine><%=(comments == null) ? "" : StringUtil.gb2iso4View(comments)%>
                        </textarea></td>
                    </tr>
                    <tr height=31>
                        <td width="50%" colspan="5">
                            <div id=backto style="display:none">
                                <table border="0" width="100%" cellspacing="0" cellpadding="0" bgcolor=#EEEEEE height=31>
                                    <tr>
                                        <td>
                                            <font color=red><b>�˸���</b></font>&nbsp;
                                            <input type="radio" value="0" name="backtowho" id="backtoauthor">�༭&nbsp;&nbsp;
                                            <%if (prevAuditor.length() > 0) {%>
                                            <input type=hidden name="prevAuditor" value="<%=prevAuditor%>">
                                            <input type="radio" value="1" name="backtowho"
                                                   id="backtoauditor">��һ�������(<b><%=prevAuditor%>
                                        </b>)
                                            <%}%>                                </td>
                                    </tr>
                                </table>
                            </div>                </td>
                    </tr>
                </table>    </td>
        </tr>
        <%}%>
        <tr>
            <td height="26" class=line>���Ա��⣺
                <input class=tine name=maintitle size=50 value="<%=title%>" readonly="true">
                &nbsp;&nbsp;&nbsp;����ʱ�䣺
                <input name="writedate" type="text" value="<%=writedtae%>" readonly="true" class=tine size=35></td>
        </tr>
        <tr>
            <td height="26" class=line>�������ݣ�
                <label>
                    <textarea name="content" id="contentid" cols="100" rows="10" readonly="true"><%=(content==null)?"":content%></textarea>
                </label></td>
        </tr>
        <tr>
            <td height="26" class=line>�ظ����ݣ�
                <textarea name="retcontent" id="retcontentid" cols="100" rows="10" readonly="true"><%=(retcontent==null)?"":retcontent%></textarea></td>
        </tr>
    </table>
</form>
</body>
</html>
