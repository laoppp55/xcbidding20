<%@ page import="java.sql.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.audit.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.extendAttr.*"
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
    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();

    boolean doAudit = ParamUtil.getBooleanParameter(request, "doAudit");
    boolean doReturn = ParamUtil.getBooleanParameter(request, "doReturn");
    int articleID = ParamUtil.getIntParameter(request, "article", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    String act = ParamUtil.getParameter(request, "act");

    String prevAuditor = null;
    String comments = null;
    String editor = null;        //���±༭��

    //��������
    IArticleManager articleManager = ArticlePeer.getInstance();
    Article article = articleManager.getArticle(articleID);
    int columnID = article.getColumnID();

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String columnName = StringUtil.gb2iso4View(column.getCName());
    int isDefine = column.getDefineAttr();
    int isProduct = column.getIsProduct();

    if (doReturn)     //�˸�
    {
        int backtowho = ParamUtil.getIntParameter(request, "backtowho", -1);                //�˸��ĳ��
        prevAuditor = StringUtil.iso2gb(ParamUtil.getParameter(request, "prevAuditor"));  //�˸����һ�������
        comments = StringUtil.iso2gb(ParamUtil.getParameter(request, "comments"));        //����
        editor = StringUtil.iso2gb(ParamUtil.getParameter(request, "editor"));        //�༭

        auditMgr.updateAudit_Info("", articleID, "", 3,0);    //����ԭ���������ϢΪ������Ϣ

        Audit audit = new Audit();
        audit.setArticleID(articleID);
        audit.setSign(username);
        audit.setComments(comments);

        if (backtowho == 0) {           //�˸������
            audit.setStatus(1);
            audit.setBackTo(editor);
        } else if (backtowho == 1) {   //�˸����һ�������
            audit.setStatus(2);
            audit.setBackTo(prevAuditor);
        }
        auditMgr.Create_Article_Audit_Info(audit,article.getProcessofaudit(),backtowho);
        success = true;
    }

    //�������
    if (doAudit) {
        int isAudit = ParamUtil.getIntParameter(request, "isAudit", -1);                  //�Ƿ�ͨ�����
        int backtowho = ParamUtil.getIntParameter(request, "backtowho", -1);                //�˸��ĳ��
        prevAuditor = StringUtil.iso2gb(ParamUtil.getParameter(request, "prevAuditor"));  //�˸����һ�������
        comments = StringUtil.iso2gb(ParamUtil.getParameter(request, "comments"));        //����
        editor = StringUtil.iso2gb(ParamUtil.getParameter(request, "editor"));        //�༭

        Audit audit = new Audit();
        audit.setArticleID(articleID);
        audit.setEditor(username);
        audit.setSign(username);
        audit.setComments(comments);
        audit.setStatus(backtowho);
        if (backtowho == 0)
            audit.setBackTo(editor);
        else if (backtowho == 1)
            audit.setBackTo(prevAuditor);

        auditMgr.Auditing(audit, act, isAudit, siteId, columnID,article.getProcessofaudit());
        success = true;
    }

    if (success) {
        out.println("<script LANGUAGE=JavaScript>opener.history.go(0);window.close();</script>");
        return;
    }

    String relatedID = article.getRelatedArtID();
    String maintitle = StringUtil.gb2iso4View(article.getMainTitle());
    String vicetitle = StringUtil.gb2iso4View(article.getViceTitle());
    String author = StringUtil.gb2iso4View(article.getAuthor());
    String summary = StringUtil.gb2iso4View(article.getSummary());
    String keyword = StringUtil.gb2iso4View(article.getKeyword());
    String source = StringUtil.gb2iso4View(article.getSource());
    editor = StringUtil.gb2iso4View(article.getEditor());
    int docLevel = article.getDocLevel();
    int status = article.getStatus();
    int subscriber = article.getSubscriber();
    int sortid = article.getSortID();
    String dates = article.getPublishTime().toString();
    String year = dates.substring(0, 4);
    int month = Integer.parseInt(dates.substring(5, 7));
    int day = Integer.parseInt(dates.substring(8, 10));
    int hour = Integer.parseInt(dates.substring(11, 13));
    int minute = Integer.parseInt(dates.substring(14, 16));

    //�ж�������һ�������
    prevAuditor = auditMgr.queryPrev_Auditor("[" + username + "]", articleID,siteId);
    if (prevAuditor == null) prevAuditor = "";

    //�����޸�,����������
    if ("update".equals(act)) comments = auditMgr.getComments(username, articleID);
%>

<html>
<head>
    <title>�������</title>
    <link REL="stylesheet" TYPE="text/css" HREF="../style/global.css">
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
            {"���¹���", "articlesmain.jsp"},
            {columnName, "articles.jsp?column=" + columnID},
            {"�������", ""}
    };
    String[][] operations = {
            {"<a href='javascript:createForm.submit();'><img src='../images/button_modi.gif' border=0></a>", ""},
            {"<a href='javascript:window.close();'><img src='../images/button_cancel.gif' border=0></a>", ""}
    };
%>
<%@ include file="../inc/titlebar.jsp" %>

<form action="editarticle.jsp" method="post" name=createForm>
<input type="hidden" name=act value="<%=act%>">
<input type="hidden" name=editor value="<%=editor%>">
<input type="hidden" name="article" value="<%=articleID%>">
<input type="hidden" name="range" value="<%=range%>">
<input type="hidden" name="start" value="<%=start%>">
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="100%">
<%
    if (act.equals("return")) {
        String[] result = auditMgr.getArticleInfo(articleID, username, 2);
        if (result != null) {
%>
<input type="hidden" name="doReturn" value="true">
<tr>
    <td class=line bgcolor="#CECFCE">
        <font color=red><b>�˸���ǩ����</b></font>
        <input class=tine size=16 value="<%=(result[0]!=null)?result[0]:""%>" disabled>&nbsp;&nbsp;
        <font color=red><b>�˸������</b></font>
        <input class=tine size=50 value="<%=(result[1]!=null)?StringUtil.gb2iso4View(result[1]):""%>" disabled>&nbsp;&nbsp;
        <font color=red><b>�˸�ʱ�䣺</b></font><%=(result[2] != null) ? result[2] : ""%>
    </td>
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
                    <%}%>
                </td>
                <td width="10%"><p align="right"><font color=red><b>ǩ����</b></font></td>
                <td width="10%">&nbsp;<input size="16" class=tine value="<%=username%>" disabled></td>
                <td width="10%"><p align="right"><font color=red><b>���飺</b></font></td>
                <td width="40%" rowspan="2">&nbsp;<input name="comments" size=40 maxlength=500></td>
            </tr>
        </table>
    </td>
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
                            <td><input type="radio" value="1" checked name="isAudit" onclick="javascript:CloseItem();">��
                            </td>
                            <td name=noBgcolor id=noBgcolor><input type="radio" value="0" name="isAudit"
                                                                   onclick="javascript:OpenItem();">��
                            </td>
                        </tr>
                    </table>
                </td>
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
                                    <%}%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>
<%}%>
<tr>
    <td class=line>
        ���⣺ <input class=tine name=maintitle size=20 value="<%=maintitle%>" disabled>
        �����⣺<input class=tine name=vicetitle size=20 value="<%=(vicetitle!=null)?vicetitle:""%>" disabled>
        ���ߣ� <input class=tine name=author size=10 value="<%=(author!=null)?author:""%>" disabled>
        ��Դ�� <input class=tine name=source size=10 value="<%=(source!=null)?source:""%>" disabled>
        ժҪ�� <input class=tine name=summary size=35 value="<%=(summary!=null)?summary:""%>" disabled>
    </td>
</tr>
<%if (isProduct == 1) {%>
<tr bgcolor="#eeeeee">
    <td class=line>
        �ۼۣ�<input class=tine name=saleprice size=6 value="<%=article.getSalePrice()%>" disabled>
        ���ۣ�<input class=tine name=inprice size=6 value="<%=article.getInPrice()%>" disabled>
        �г��ۣ�<input class=tine name=marketprice size=6 value="<%=article.getMarketPrice()%>" disabled>
        ��棺<input class=tine name=stocknum size=6 value="<%=article.getStockNum()%>" disabled>
        ���̣�<input class=tine name=brand size=12
                  value="<%=(article.getBrand()==null)?"":StringUtil.gb2iso4View(article.getBrand())%>" disabled>
        ����(��)��<input class=tine name=weight size=5 value="<%=article.getProductWeight()%>" disabled>
        ͼƬ��<input class=tine name=pic size=12 value="<%=(article.getProductPic()==null)?"":article.getProductPic()%>"
                  disabled>
        ��ͼƬ��<input class=tine name=bigpic size=12
                   value="<%=(article.getProductBigPic()==null)?"":article.getProductBigPic()%>" disabled>
    </td>
</tr>
<%}%>
<%if (isDefine == 1) {%>
<tr bgcolor="#eeeeee">
    <td class=line><%=extendMgr.getExtendAttrForAudit(columnID, articleID)%>
    </td>
</tr>
<%}%>
<tr bordercolor="#CCCCCC" bgcolor="#CCCCCC">
    <td class=line>
        <font color="#FF0000"><b>�ؼ���(;):</b></font><input class=tine name=keyword size=10
                                                          value="<%=(keyword!=null)?keyword:""%>" disabled>
        <font color="#FF0000"><b>����:</b></font><input class=tine name=sortid size=4 value="<%=sortid%>" disabled>
        <font color="#FF0000"><b>Ȩ��:</b></font><input class=tine name=docLevel size=4 value="<%=docLevel%>"
                                                      maxlength="5" disabled>
        <font color="#FF0000"><b>���:</b></font><input name="relatedID" size="4" onclick="AddRelatedArticleID();"
                                                      value="<%=(relatedID==null)?"":relatedID%>" disabled>
        <font color="#FF0000"><b>ʹ��:</b></font><input type=radio <%=(status==1)?"checked":""%> name="status" value="1"
                                                      disabled>��<input type=radio <%=(status==0)?"checked":""%>
                                                                       name="status" value="0" disabled>��
        <font color="#FF0000"><b>����:</b></font><input type=radio <%=(subscriber==1)?"checked":""%> name="subscriber"
                                                      value="1" disabled>��<input
            type=radio <%=(subscriber==0)?"checked":""%> name="subscriber" value="0" disabled>��
        <font color="#FF0000"><b>����:</b></font><input class=tine type=text size=3 maxlength=4 name=year
                                                      value="<%=(year!=null)?year:""%>" disabled>��
        <select name=month size=1 class=tine disabled>
            <%for (int i = 1; i < 13; i++) {%>
            <option value=<%=i%> <%=(month == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>��
        <select name=day size=1 class=tine disabled>
            <%for (int i = 1; i < 32; i++) {%>
            <option value=<%=i%> <%=(day == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>��
        <select name=hour size=1 class=tine disabled>
            <%for (int i = 1; i < 24; i++) {%>
            <option value=<%=i%> <%=(hour == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>ʱ
        <select name=minute size=1 class=tine disabled>
            <%for (int i = 1; i < 61; i++) {%>
            <option value=<%=i%> <%=(minute == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>��
    </td>
</tr>
<tr>
    <td>
        <iframe src="getContent.jsp?article=<%=articleID%>" width="100%" height="400" marginwidth="2" marginheight="2"
                scrolling="auto" frameborder="1"></iframe>
    </td>
</tr>
</table>
</form>
</body>
</html>
