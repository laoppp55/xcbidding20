<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.markManager.*,
                 com.bizwink.cms.xml.*,
                 com.bizwink.cms.server.CmsServer"
         contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    //��������б���ʽ
    int siteID = authToken.getSiteID();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");

    IMarkManager markMgr = markPeer.getInstance();
    IViewFileManager viewfileMgr = viewFilePeer.getInstance();
    ViewFile viewfile = new ViewFile();

    int listType = 0;
    int innerFlag = 0;
    int way = 0;
    int linkarticle = 1;
    String columns = null;
    String columnids = null;
    String cname = "��Ŀ�б�";
    String notes = "";
    String url = "";
    String param = "";
    int aid = 0;
    int cid = 0;
    int selectWay = -1;
    int columnNum = 10;
    int navbar = 0;

    if (doCreate) {
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        listType = ParamUtil.getIntParameter(request, "listType", 0);
        String content = ParamUtil.getParameter(request, "content");
        String relatedCID = ParamUtil.getParameter(request, "columnIDs");
        relatedCID = relatedCID.substring(relatedCID.indexOf("("), relatedCID.indexOf(")") + 1);

        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(content);
        mark.setMarkType(2);
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(innerFlag);
        mark.setFormatFileNum(listType);
        mark.setRelatedColumnID(relatedCID);

        int orgmarkID = markID;
        if (markID > 0)
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        if (viewer.toLowerCase().indexOf("gecko") == -1)
            out.println("<script>window.returnValue=\"[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]\";window.close();</script>");
        else {
            if (orgmarkID > 0){
                out.println("<script>top.close();</script>");
            }else{
                String returnvalue = "[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]";
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + cname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
        }
        return;
    }

    if (markID > 0) {
        String str = markMgr.getAMarkContent(markID);
        if (CmsServer.getInstance().getCustomer().equalsIgnoreCase("linktone"))
            str = StringUtil.gb2iso(str);
        else
            str = StringUtil.gb2iso4View(str);

        //System.out.println("str=" + str);

        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        str = StringUtil.replace(str, "&", "&amp;");
        XMLProperties tagxml = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);

        listType = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".LISTTYPE")));
        innerFlag = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".INNERHTMLFLAG")));
        columns = tagxml.getProperty(tagxml.getName().concat(".COLUMNS"));
        columnids = tagxml.getProperty(tagxml.getName().concat(".COLUMNIDS"));
        String s_selectWay = tagxml.getProperty(tagxml.getName().concat(".SELECTWAY"));
        if (s_selectWay != null && s_selectWay!="")
            selectWay = Integer.parseInt(s_selectWay);
        else
            selectWay = 0;
        cname = tagxml.getProperty(tagxml.getName().concat(".CHINESENAME"));
        notes = tagxml.getProperty(tagxml.getName().concat(".NOTES"));
        if (notes == null) notes = "";
        way = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".LINK.WAY")));
        if (way == 1) {
            url = tagxml.getProperty(tagxml.getName().concat(".LINK.URL"));
        }
        if (way == 2) {
            linkarticle = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".LINK.LINKARTICLE")));
            aid = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".LINK.AID")));
        }

        if (str.indexOf("<COLUMNNUM>") > -1)
            columnNum = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".COLUMNNUM")));

        if (str.indexOf("<NAVBAR>") > -1)
            navbar = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".NAVBAR")));

        if (way == 1 || way == 2) {
            param = tagxml.getProperty(tagxml.getName().concat(".LINK.PARAM"));
            if (param == null) param = "";
            cid = Integer.parseInt(tagxml.getProperty(tagxml.getName().concat(".LINK.CID")));
        }
    }

    List list = viewfileMgr.getViewFileC(siteID, 6);
    List navList = viewfileMgr.getViewFileC(siteID, 2);        //��õ�������ʽ
%>

<html>
<head>
    <title>��Ŀ�б�</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <meta http-equiv="Pragma" content="no-cache">
    <script language="javascript" src="../js/mark.js"></script>
</head>

<body bgcolor="#CCCCCC">
<form action="addColumnRight.jsp" method="POST" name=markForm>
<input type=hidden name=doCreate value=true>
<input type=hidden name=column value="<%=columnID%>">
<input type=hidden name=mark value="<%=markID%>">
<input type=hidden name=columnIDs>
<input type=hidden name=content>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=2 cellSpacing=0 width="100%">
<tr>
    <td>
        <b><font color="#0000FF">�б����ͣ�</font></b>
        <table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='99%'>
            <tr>
                <td>
                    <table border=0 width="100%">
                        <tr>
                            <td width="25%">
                                <input type="radio" name="selectColList" value="0" <%if(selectWay!=2){%> checked<%}%>
                                       onclick="selectColumnList();">
                                ��ҳ��ʾ
                            </td>
                        </tr>
                        <tr>
                            <td width="45%"><input type="radio" name="selectColList" <%if(selectWay==2){%> checked<%}%>
                                                   value="2"
                                                   onclick="selectColumnList();">
                                ��ҳ��ʾ��ÿҳ��ʾ
                                <input name="colNumInPage" style="width:30" value="<%=columnNum%>" <%if(selectWay!=2){%>
                                       disabled<%}%>>����Ŀ
                            </td>
                            <td width="55%"><input type="radio" name="navPosition" value="0" <%if(navbar!=0){%>
                                                   checked<%}%> <%if(selectWay!=2){%> disabled<%}%>
                                                   onclick="selectColNavStyle();">Ĭ�ϵ�����λ��&nbsp;&nbsp;
                                <input type="radio" name="navPosition" value="1" <%if(navbar==0){%>
                                       checked<%}%> <%if(selectWay!=2){%>
                                       disabled<%}%> onclick="selectColNavStyle();">�Զ��嵼����λ��
                            </td>
                        </tr>
                        <tr>
                            <td width="100%" colspan=2>��ҳ��������ʽ��
                                <select id="navbar"
                                        style="width:120;font-size:9pt" <%if (selectWay != 2 || (selectWay == 2 && navbar == 0)) {%>
                                        disabled<%}%>>
                                    <option value="0">ѡ�񵼺�����ʽ</option>
                                    <%
                                        for (int i = 0; i < navList.size(); i++) {
                                            viewfile = (ViewFile) navList.get(i);
                                    %>
                                    <option value="<%=viewfile.getID()%>" <%if (navbar == viewfile.getID()) {%>
                                            selected<%}%> ><%=
                                        StringUtil.gb2iso4View(viewfile.getChineseName())%>
                                    </option>
                                    <%}%>
                                </select>
                                <input type="button" id=button1 style="height:20;width:30;font-size:9pt"
                                        onclick="createStyle(2,0)" <%if (selectWay != 2 || (selectWay == 2 && navbar == 0)) {%>
                                        disabled<%}%> value="�½�">
                                <input type="button" id=button2 style="height:20;width:30;font-size:9pt"
                                        onclick="updateStyle(2,navbar.options[navbar.selectedIndex].value,0)" <%if (selectWay != 2 || (selectWay == 2 && navbar == 0)) {%>
                                        disabled<%}%> value="�޸�">
                                <input type="button" id=button3 style="height:20;width:30;font-size:9pt"
                                        onclick="previewStyle(2,navbar.options[navbar.selectedIndex].value)" <%if (selectWay != 2 || (selectWay == 2 && navbar == 0)) {%>
                                        disabled<%}%> value="Ԥ��">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr height="20">
    <td><b><font color="#0000FF">��Ŀ�б�</font></b></td>
</tr>
<tr height="36">
    <td>�б���ʽ��
        <select name="listType" style="width:150" class=tine>
            <option value=0>ѡ���б���ʽ</option>
            <%
                for (int i = 0; i < list.size(); i++) {
                    viewfile = (ViewFile) list.get(i);
            %>
            <option value="<%=viewfile.getID()%>" <%if (listType == viewfile.getID()) {%> selected<%}%>><%=
                StringUtil.gb2iso4View(viewfile.getChineseName())%>
            </option>
            <%}%>
        </select>
        <input type="button" id=button5 style="height:20;width:30;font-size:9pt" onclick="createStyle(6,<%=columnID%>)" value="�½�">
        <input type="button" id=button6 style="height:20;width:30;font-size:9pt"
                onclick="updateStyle(6,listType.options[listType.selectedIndex].value,<%=columnID%>)" value="�޸�">
        <input type="button" id=button7 style="height:20;width:30;font-size:9pt"
                onclick="previewStyle(6,listType.options[listType.selectedIndex].value)" value="Ԥ��">
    </td>
</tr>
<tr>
    <td>
        <br><font color="#0000FF"><b>�������ԣ�</b></font>
        <table border=1 bordercolordark=#ffffec bordercolorlight=#5e5e00 cellpadding=0 cellspacing=0 width='100%'>
            <tr height=30>
                <td>
                    <input name="linkradio" type="radio" value="0" <%if(way==0){%> checked<%}%>
                           onclick="activeArticle(0);">Ĭ������
                    <input type="radio" name="linkradio" value="1" <%if(way==1){%> checked<%}%>
                           onclick="activeArticle(1);">URL���ƣ�
                    <input name="urlname" size=16 <%if(way!=1){%> disabled<%}%> value="<%=url%>">
                    <input type="radio" name="linkradio" value="2" <%if(way==2){%> checked<%}%>
                           onclick="activeArticle(2);">���ӵ���Ŀ�ڣ�
                    <input name="linkArtNum" size=4 value="<%=linkarticle%>" <%if(way!=2){%> disabled<%}%>>����
                </td>
            </tr>
            <tr height=30>
                <td>
                    �������壺
                    <input name="param" <%if(way==0){%> disabled<%}%> value="<%=param%>">&nbsp;&nbsp;&nbsp;
                    <input type="checkbox" name="aid" <%if(aid==1){%> checked<%}%> <%if(way!=2){%> disabled<%}%>
                           value="1">ʹ���������&nbsp;&nbsp;&nbsp;
                    <input type="checkbox" name="cid" <%if(cid==1){%> checked<%}%> <%if(way==0){%> disabled<%}%>
                           value="1">ʹ����Ŀ���
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td>
        <table border=0 width='100%'>
            <tr>
                <td>
                    <font color="#0000FF"><b>��ѡ��Ŀ��</b></font><br>
                    <table>
                        <tr>
                            <td>
                                <select id="selectedColumn" name="selectedColumn" style="width:200" size="8">
                                    <%
                                        if (markID > 0) {
                                            if (columnids != null && columnids.length() > 0)
                                                columnids = columnids.substring(1, columnids.length() - 1);
                                            String[] cnames = columns.split(",");
                                            String[] cids = columnids.split(",");
                                            for (int i = 0; i < cids.length; i++) {
                                                if (!cnames[i].equals("*")) {
                                    %>
                                    <option value="<%=cids[i]%>"><%=cnames[i]%>
                                    </option>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                                </select></td>
                            <td>
                                <input type="button" name="delete" value="ɾ��" onclick="delItem();"
                                       style="height:20;width:30;font-size:9pt">
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border=0 cellpadding=2 cellspacing=2 width="100%">
                        <tr>
                            <td>
                                �Ƿ�Ҫ���ɰ����ļ���
                                <input type=radio name=innerFlag value=0 <%if(innerFlag==0){%> checked<%}%>>��
                                <input type=radio name=innerFlag value=1 <%if(innerFlag==1){%> checked<%}%>>��
                            </td>
                        </tr>
                        <tr>
                            <td>����������ƣ�<input name=chineseName size=20 value=<%=cname%> class=tine></td>
                        </tr>
                        <tr>
                            <td>���������<br><textarea rows="5" id="notes" cols="30" class=tine><%=notes%>
                            </textarea></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr height="50">
    <td align="center">
        <input type="button" value="  ȷ��  " onClick="createColumnList();" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="  ȡ��  " onClick="parent.window.close();" class=tine>
    </td>
</tr>
</table>
</form>
</body>
</html>