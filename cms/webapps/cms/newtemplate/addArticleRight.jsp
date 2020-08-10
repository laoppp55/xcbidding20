<%@ page import="java.util.*,
                 com.bizwink.cms.xml.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.markManager.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.server.CmsServer"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="org.jdom.input.SAXBuilder" %>
<%@ page import="org.jdom.Element" %>
<%@ page import="java.io.File" %>
<%@ page import="org.jdom.Document" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteID = authToken.getSiteID();
    IViewFileManager viewfileMgr = viewFilePeer.getInstance();
    IMarkManager markMgr = markPeer.getInstance();
    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();

    int listType = 0;
    int innerFlag = 0;
    String notes = "";
    String cname = "�����б���ʽ";
    int columnID = ParamUtil.getIntParameter(request, "column", 2);
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    int type = ParamUtil.getIntParameter(request, "type", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");

    //��ȡ����Ŀ�ķ���
    IColumnManager columnManager = ColumnPeer.getInstance();
    List inlist = columnManager.getInheritanceType(columnID);//��ȡ�̳еķ���
    List typeList = columnManager.getAllTypeForColumn("select * from tbl_type where columnid = " + columnID + " and parentid = 0 and referid = 0 order by createdate desc");//��ȡ�Զ���ķ���
    //�ϲ��̳к��Զ���ķ���
    for (int i = 0; i < inlist.size(); i++) {
        Producttype pt = (Producttype) inlist.get(i);
        typeList.add(pt);
    }

    if (doCreate) {
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        listType = ParamUtil.getIntParameter(request, "listType", 0);
        String content = ParamUtil.getParameter(request, "content");
        boolean saveas = ParamUtil.getBooleanParameter(request, "saveas");
        String relatedCID = ParamUtil.getParameter(request, "columnIDs");
        relatedCID = relatedCID.substring(relatedCID.indexOf("("), relatedCID.indexOf(")") + 1);

        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(content);
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(innerFlag);
        mark.setFormatFileNum(listType);
        mark.setRelatedColumnID(relatedCID);
        mark.setMarkType(1);                    //maketype=1�����б�
        if (type == 1) mark.setMarkType(5);     //maketype=5�������б�
        if (type == 2) mark.setMarkType(8);     //maketype=8�ֵ������б�

        int orgmarkID = markID;
        if (orgmarkID > 0 && !saveas)
            markMgr.Update(mark);
        else  {
            //System.out.println("hhh");
            markID = markMgr.Create(mark);
        }
        String viewer = request.getHeader("user-agent");
        //System.out.println("gggggggg=" + viewer);
        String markname = "";
        if (type == 0)
            markname = "�����б�";
        else if (type == 1)
            markname = "�������б�";
        else
            markname = "�ֵ������б�";

        if (viewer.toLowerCase().indexOf("gecko") == -1) {
            System.out.println("orgmarkID=" + orgmarkID);
            System.out.println("saveas=" + saveas);
            out.println("<script>window.returnValue=\"[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]\";top.close();</script>");
        } else {
            if (orgmarkID > 0 && !saveas) {
                out.println("<script>top.close();</script>");
            } else {
                String returnvalue = "[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]";
                System.out.println(returnvalue);
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + markname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
        }
        session.removeAttribute("atids");
        return;
    }

    int archive = 0;
    int selectWay = -1;
    int color = 0;
    int navbar = 0;
    int daystyle = 0;
    int way = 0;
    int AID = 0;
    int CID = 0;
    int articleNum = 0;
    int exclude = 0;
    String order = "0,0,0";
    String letterNum = "0";
    String vicetitleNum = "0";
    String summaryNum = "0";
    String authorNum = "0";
    String sourceNum = "0";
    String contentNum = "0";
    String days = "0";
    String url = "";
    String param = "";
    String columnIDs = "";
    String columns = "";
    String powerrange1 = "";
    String powerrange2 = "";
    String timerange1 = "";
    String timerange2 = "";
    String orderrange1 = "";
    String orderrange2 = "";
    int articleID = 0;
    String str = "";
    String start_art_num = "";
    String end_art_num = "";
    XMLProperties properties = null;

    String pename = "";
    String pvalue = "";

    List articletype = new ArrayList();


    if (markID > 0) {
        str = markMgr.getAMarkContent(markID);
        if (str != null && str != "") {
            if (CmsServer.getInstance().getCustomer().equalsIgnoreCase("linktone"))
                str = StringUtil.gb2iso(str);
            else
                str = StringUtil.gb2iso4View(str);

            str = StringUtil.replace(str, "[", "<");
            str = StringUtil.replace(str, "]", ">");
            str = StringUtil.replace(str, "&", "&amp;");
            properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);

            columnIDs = properties.getProperty(properties.getName().concat(".COLUMNIDS"));
            columns = properties.getProperty(properties.getName().concat(".COLUMNS"));
            start_art_num = properties.getProperty(properties.getName().concat(".STARTARTNUM"));
            end_art_num = properties.getProperty(properties.getName().concat(".ENDARTNUM"));
            selectWay = Integer.parseInt(properties.getProperty(properties.getName().concat(".SELECTWAY")));
            articleNum = Integer.parseInt(properties.getProperty(properties.getName().concat(".ARTICLENUM")));
            listType = Integer.parseInt(properties.getProperty(properties.getName().concat(".LISTTYPE")));
            if (str.indexOf("<WAY>") > -1)
                way = Integer.parseInt(properties.getProperty(properties.getName().concat(".LINK.WAY")));
            innerFlag = Integer.parseInt(properties.getProperty(properties.getName().concat(".INNERHTMLFLAG")));
            cname = properties.getProperty(properties.getName().concat(".CHINESENAME"));
            order = properties.getProperty(properties.getName().concat(".ORDER"));
            String time_range = properties.getProperty(properties.getName().concat(".ORDER_RANGE.TIME_RANGE"));
            powerrange1 = properties.getProperty(properties.getName().concat(".ORDER_RANGE.POWER_RANGE"));
            powerrange2 = properties.getProperty(properties.getName().concat(".ORDER_RANGE.VICEPOWER_RANGE"));
            String order_range = properties.getProperty(properties.getName().concat(".ORDER_RANGE.NUMBER_RANGE"));
            pename = properties.getProperty(properties.getName().concat(".ARTICLEFIRSTTYPE"));
            pvalue = properties.getProperty(properties.getName().concat(".ARTICLESECONDTYPE"));

            letterNum = properties.getProperty(properties.getName().concat(".LETTERNUM"));
            if (str.indexOf("<ARTICLE_VICETITLE>") > -1)
                vicetitleNum = properties.getProperty(properties.getName().concat(".ARTICLE_VICETITLE"));
            if (str.indexOf("<ARTICLE_SUMMARY>") > -1)
                summaryNum = properties.getProperty(properties.getName().concat(".ARTICLE_SUMMARY"));
            if (str.indexOf("<ARTICLE_AUTHOR>") > -1)
                authorNum = properties.getProperty(properties.getName().concat(".ARTICLE_AUTHOR"));
            if (str.indexOf("<ARTICLE_SOURCE>") > -1)
                sourceNum = properties.getProperty(properties.getName().concat(".ARTICLE_SOURCE"));
            if (str.indexOf("<ARTICLE_CONTENT>") > -1)
                contentNum = properties.getProperty(properties.getName().concat(".ARTICLE_CONTENT"));

            if (type == 1 || type == 2)
                articleID = Integer.parseInt(properties.getProperty(properties.getName().concat(".ARTICLEID")));

            if (str.indexOf("<NAVBAR>") > -1)
                navbar = Integer.parseInt(properties.getProperty(properties.getName().concat(".NAVBAR")));

            if (str.indexOf("<NEW>") != -1)
                days = properties.getProperty(properties.getName().concat(".NEW"));

            if (str.indexOf("<EXCLUDE>") != -1)
                exclude = Integer.parseInt(properties.getProperty(properties.getName().concat(".EXCLUDE")));

            if (str.indexOf("<DAYSTYLE>") != -1)
                daystyle = Integer.parseInt(properties.getProperty(properties.getName().concat(".DAYSTYLE")));

            if (str.indexOf("<COLOR>") > -1)
                color = Integer.parseInt(properties.getProperty(properties.getName().concat(".COLOR")));

            if (str.indexOf("<ARCHIVE>") > -1)
                archive = Integer.parseInt(properties.getProperty(properties.getName().concat(".ARCHIVE")));

            if (str.indexOf("<AID>") > -1 && way == 1)
                AID = Integer.parseInt(properties.getProperty(properties.getName().concat(".LINK.AID")));
            if (str.indexOf("<CID>") > -1 && way == 1)
                CID = Integer.parseInt(properties.getProperty(properties.getName().concat(".LINK.CID")));
            if (str.indexOf("<URL>") > -1 && way == 1) {
                url = properties.getProperty(properties.getName().concat(".LINK.URL"));
                url = StringUtil.replace(url, "\"", "&quot;");
            }
            if (str.indexOf("<PARAM>") > -1 && way == 1) {
                param = properties.getProperty(properties.getName().concat(".LINK.PARAM"));
                if (param == null) param = "";
            }
            if (str.indexOf("<NOTES>") != -1) {
                notes = properties.getProperty(properties.getName().concat(".NOTES"));
                if (notes == null) notes = "";
            }

            if (time_range != null && time_range.trim().length() > 0) {
                timerange1 = time_range.substring(0, time_range.indexOf(","));
                timerange2 = time_range.substring(time_range.indexOf(",") + 1);
            }
            if (order_range != null && order_range.trim().length() > 0) {
                orderrange1 = order_range.substring(0, order_range.indexOf(","));
                orderrange2 = order_range.substring(order_range.indexOf(",") + 1);
            }
        }
        if (pvalue != null && !pvalue.equals("")) {
            articletype = columnManager.getTypes(pvalue);
        }
    } else {
        str = "��ǲ�����";
    }
    String typenames = "";
    String typeids = "";
    if (articletype.size() > 0) {
        for (int i = 0; i < articletype.size(); i++) {
            Producttype pt = (Producttype) articletype.get(i);
            if (i == 0) {
                typenames = String.valueOf(pt.getCname());
                typeids = String.valueOf(pt.getValueid());
            } else {
                typenames = typenames + "," + String.valueOf(pt.getCname());
                typeids = typeids + "," + String.valueOf(pt.getValueid());
            }
        }
    }

    int articleNum1 = 4;
    int articleNum2 = 20;
    if (selectWay == 0) articleNum1 = articleNum;
    if (selectWay == 2) articleNum2 = articleNum;
    String[] orderx = order.split(",");

    List articleList = viewfileMgr.getViewFileC(siteID, 1);    //��������б���ʽ
    List navList = viewfileMgr.getViewFileC(siteID, 2);        //��õ�������ʽ
    List colorList = viewfileMgr.getViewFileC(siteID, 5);      //��ñ������±�����ʽ
    List newList = viewfileMgr.getViewFileC(siteID, 7);        //�����������ʽ
    ViewFile viewfile = new ViewFile();

    //���������չ����,���ڿ�����չ������ʾ����
    List extendList = extendMgr.getExtendAttrForMark(columnID, properties, str);
%>

<html>
<head>
    <title>�����б�</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="javascript" src="../js/setday.js"></script>
    <script language="javascript" src="../js/mark.js"></script>
</head>
<script type="text/javascript">
    function addarticletype()
    {
        //window.open("selectarticletype.jsp?column=<%=columnID%>&mark=<%=markID%>", "", "top=100,left=100,width=420,height=360");
        var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
        var retstr = "";
        var winstrs = "";
        winstrs = "selectarticletype.jsp?column=<%=columnID%>&mark=<%=markID%>";
        if (isMSIE)
            retstr = showModalDialog(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:650px;dialogHeight:440px;status:no");
        else {
            listwin = window.open(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:650px;dialogHeight:440px;status:no");
            listwin.focus();
        }
        if (isMSIE) {
            if (retstr != "" && retstr != undefined) {
                document.getElementById("articletype").value = retstr.substring(0, retstr.indexOf(","));
                document.getElementById("typevalue").value = retstr.substring(retstr.indexOf(",") + 1);
            }
        }
    }
</script>
<body bgcolor="#CCCCCC">
<form action="addArticleRight.jsp" method="POST" name=markForm>
<input type=hidden name=doCreate value=true>
<input type=hidden name=saveas value=false>
<input type=hidden name=column value="<%=columnID%>">
<input type=hidden name=mark value="<%=markID%>">
<input type=hidden name=type value="<%=type%>">
<input type=hidden name=columnIDs>
<input type=hidden name=content>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="100%">
<tr>
<td>
<%
    if (type == 1 || type == 2) {
        String maintitle = "";
        String CName = "";
        if (articleID > 0) {
            IArticleManager articleMgr = ArticlePeer.getInstance();
            Article article = articleMgr.getArticle(articleID);
            maintitle = StringUtil.gb2iso4View(article.getMainTitle());
            IColumnManager columnMgr = ColumnPeer.getInstance();
            CName = StringUtil.gb2iso4View(columnMgr.getColumn(article.getColumnID()).getCName());
        }
%>
<input type=hidden id=article name=article value="<%=(articleID>0)?String.valueOf(articleID):""%>">
<b><font color="#0000FF">ѡ�����£�</font></b>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='99%'>
    <tr>
        <td width="100%">
            <table width="100%" border=0 cellpadding=0 cellspacing=1 bgcolor="#CCCCCC">
                <tr bgcolor="#F5F5F5">
                    <td align=center width="10%">ѡ��</td>
                    <td align=center width="15%">����ID</td>
                    <td align=center width="25%">������Ŀ</td>
                    <td align=center width="50%">����</td>
                </tr>
                <tr bgcolor="#F5F5F5">
                    <td align=center><input type=button value="ѡ��" style="height:20;width:40;font-size:9pt"
                                            onclick="AddRelatedArticleID(<%=columnID%>);"></td>
                    <td align=center>
                        <div id=articleID><%=(articleID > 0) ? String.valueOf(articleID) : ""%>
                        </div>
                    </td>
                    <td align=center>
                        <div id=cname><%=(articleID > 0) ? CName : ""%>
                        </div>
                    </td>
                    <td>
                        <div id=maintitle><%=(articleID > 0) ? maintitle : ""%>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%}%>
<table border=0>
    <tr height=6>
        <td></td>
    </tr>
</table>
<b><font color="#0000FF"><input type="radio" name="selectArtList" value="0" <%if(selectWay!=2){%>checked<%}%>
                                onclick="selectArticleList();">��ҳ�б�</font></b>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='99%'>
    <tr>
        <td>
            <table border="0">
                <tr>
                    <td>
                        ѡ��&nbsp;<input name="artNum" value="<%=articleNum1%>" size=4 <%if(selectWay==2){%>disabled<%}%>>&nbsp;ƪ����
                        &nbsp;&nbsp;
                        �ӵ�&nbsp;<input name="startArtNum" value="<%=(start_art_num!=null)?start_art_num:""%>" size=4
                                       <%if(selectWay==2){%>disabled<%}%>>
                        ƪ���� �� ��&nbsp;<input name="endArtNum" value="<%=(end_art_num!=null)?end_art_num:""%>" size=4
                                            <%if(selectWay==2){%>disabled<%}%>>&nbsp;ƪ����
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border=0 cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="100%">����������ʽ��
                                    <select id="sellink" style="width:120;font-size:9pt">
                                        <option value="0">ѡ�������ʽ</option>
                                        <%
                                            for (int i = 0; i < colorList.size(); i++) {
                                                viewfile = (ViewFile) colorList.get(i);
                                        %>
                                        <option value="<%=viewfile.getID()%>"
                                                <%if(viewfile.getID()==color){%>selected<%}%>><%=StringUtil.gb2iso4View(viewfile.getChineseName())%>
                                        </option>
                                        <%}%>
                                    </select>
                                    <input id="button1" type=button onClick="createStyle(5,0)" value="�½�"
                                           style="height:20;width:30;font-size:9pt"><input id="button2" type=button
                                                                                           onClick="updateStyle(5,sellink.options[sellink.selectedIndex].value,0)"
                                                                                           value="�޸�"
                                                                                           style="height:20;width:30;font-size:9pt"><input
                                        id="button3" type=button
                                        onClick="previewStyle(5,sellink.options[sellink.selectedIndex].value)"
                                        value="Ԥ��" style="height:20;width:30;font-size:9pt">
                                    &nbsp;&nbsp;<input type="checkbox" name="exclude" value="1"
                                                       <%if(exclude==1){%>checked<%}%>>&nbsp;�ų���ǰ����
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border=0>
    <tr height=6>
        <td></td>
    </tr>
</table>
<b><font color="#0000FF"><input type="radio" name="selectArtList" <%if(selectWay==2){%>checked<%}%> value="2"
                                onclick="selectArticleList();">��ҳ�б�</font></b>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='99%'>
    <tr>
        <td>
            <table border=0 width="100%">
                <tr>
                    <td width="45%">
                        ��ҳ��ʾ�������£�ÿҳ��ʾ
                        <input name="articleNumInPage" style="width:30" value="<%=articleNum2%>"
                               <%if(selectWay!=2){%>disabled<%}%>>ƪ����
                    </td>
                    <td width="55%"><input type="radio" name="navPosition" value="0" <%if(navbar!=0){%>checked<%}%>
                                           <%if(selectWay!=2){%>disabled<%}%> onclick="selectNavStyle();">Ĭ�ϵ�����λ��&nbsp;&nbsp;
                        <input type="radio" name="navPosition" value="1" <%if(navbar==0){%>checked<%}%>
                               <%if(selectWay!=2){%>disabled<%}%> onclick="selectNavStyle();">�Զ��嵼����λ��
                    </td>
                </tr>
                <tr>
                    <td width="100%" colspan=2>��ҳ��������ʽ��
                        <select id="navbar" style="width:120;font-size:9pt"
                                <%if(selectWay!=2||(selectWay==2&&navbar==0)){%>disabled<%}%>>
                            <option value="0">ѡ�񵼺�����ʽ</option>
                            <%
                                for (int i = 0; i < navList.size(); i++) {
                                    viewfile = (ViewFile) navList.get(i);
                            %>
                            <option value="<%=viewfile.getID()%>"
                                    <%if(navbar==viewfile.getID()){%>selected<%}%>><%=StringUtil.gb2iso4View(viewfile.getChineseName())%>
                            </option>
                            <%}%>
                        </select>
                        <input id=button4 type=button onclick="createStyle(2,0)"
                               <%if(selectWay!=2||(selectWay==2&&navbar==0)){%>disabled<%}%> value="�½�"
                               style="height:20;width:30;font-size:9pt"><input id=button5 type=button
                                                                               onclick="updateStyle(2,navbar.options[navbar.selectedIndex].value,0)"
                                                                               <%if(selectWay!=2||(selectWay==2&&navbar==0)){%>disabled<%}%>
                                                                               value="�޸�"
                                                                               style="height:20;width:30;font-size:9pt"><input
                            id=button6 type=button
                            onclick="previewStyle(2,navbar.options[navbar.selectedIndex].value)"
                            <%if(selectWay!=2||(selectWay==2&&navbar==0)){%>disabled<%}%> value="Ԥ��"
                            style="height:20;width:30;font-size:9pt">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border=0>
    <tr height=6>
        <td></td>
    </tr>
</table>
<%
    if (typeList.size() > 0) { //�������Ŀ�µķ����б����0 ����ʾ��ѡ��ķ���
%>
<b><font color="#0000FF">ѡ����ࣺ</font></b>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='100%'>
    <tr>
        <table border=0>
            <tr>
                <td>ѡ�����·��ࣺ<input type=text name=articletype id=articletype size=30
                                  value="<%=StringUtil.gb2iso4View(typenames)%>"
                                  onDblClick="javascript:addarticletype();" readonly></td>
                <input type=hidden name=typevalue id=typevalue value="<%=typeids%>">
                <%--<td>
                <select name=typelist style="width:120;font-size:9pt" onchange="selecttypevalue(<%=columnID%>,this.value);">
                    <option value=0>��ѡ��</option>
                <%
                    int ptid = 0;
                    for(int i = 0; i < inlist.size();i++){
                        Producttype pt = (Producttype)inlist.get(i);
                        String pcname = new String(pt.getCname().getBytes("iso8859_1"),"GBK");
                        String selectstr = ">";
                        if(!pename.equals("") && pename!=null){
                            if(pename.equals(String.valueOf(pt.getId()))){
                                selectstr = " selected>";
                                ptid = pt.getId();
                            }
                        }
                        out.print("<option value="+pt.getId()+selectstr+pcname+"</option>");
                    }
                %>
                </select>
                </td>
                <td>
                <div id=typevaluelist>
                    <%if(markID > 0){%>
                    <%
                         List pvalues = columnManager.getSecondType(ptid);
                    %>
                    <select name=typevalue style="width:120;font-size:9pt">
                        <option value=0>��ѡ��</option>
                        <%
                            if(!pvalue.equals("") && pvalue!=null){
                                if(pvalue.equals("0")){
                        %>
                        <option value=0 selected>ȫ��</option>
                        <%}else{%>
                         <option value=0>ȫ��</option>
                        <%}}%>
                        <%
                            for(int i = 0 ; i < pvalues.size(); i++){
                                Producttype pv = (Producttype)pvalues.get(i);
                                String vname = new String(pv.getValues().getBytes("iso8859_1"),"GBK");
                                String selectstr = "";
                                if(!pvalue.equals("") && pvalue!=null){
                                    if(pvalue.equals(String.valueOf(pv.getValueid()))){
                                        selectstr = " selected";
                                    }
                                }

                        %>
                        <option value=<%=pv.getValueid()%><%=selectstr%>><%=vname%></option>
                        <%}%>
                        </select>
                    <%}else{%>
                    <select name=typevalue style="width:120;font-size:9pt">
                        <option value=0>��ѡ��</option>
                        </select>
                    <%}%>
                 </div>
                </td>--%>
                <td>��ʾ����վ����Ϣ</td>
            </tr>
        </table>
    </tr>
</table>
<!--table border=0>
    <tr height=6>
        <td>hhhhhhhhhhhhhhhhhhhhhhhhhh</td>
    </tr>
</table-->
<%}%>
<b><font color="#0000FF">�б����ԣ�</font> </b>
<table border=1 borderColorDark="#ffffec" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width='99%'>
    <tr>
        <td>
            <table border="0" width="100%">
                <tr>
                    <td width="100%">
                        <table border="0" width="100%" cellspacing=0 cellpadding=0>
                            <tr height=30>
                                <td width="100%">
                                    ����<select id="order1" style="font-size:9pt;width:90" class=tine>
                                    <option value=0>��һѡ��</option>
                                    <option value=1 <%if(orderx[0].equals("1")){%>selected<%}%>>ʱ������</option>
                                    <option value=2 <%if(orderx[0].equals("2")){%>selected<%}%>>ʱ��˳��</option>
                                    <option value=3 <%if(orderx[0].equals("3")){%>selected<%}%>>��Ȩ������</option>
                                    <option value=4 <%if(orderx[0].equals("4")){%>selected<%}%>>��Ȩ��˳��</option>
                                    <option value=5 <%if(orderx[0].equals("5")){%>selected<%}%>>�������</option>
                                    <option value=6 <%if(orderx[0].equals("6")){%>selected<%}%>>���˳��</option>
                                    <option value=7 <%if(orderx[0].equals("7")){%>selected<%}%>>��Ȩ������</option>
                                    <option value=8 <%if(orderx[0].equals("8")){%>selected<%}%>>��Ȩ��˳��</option>
                                     <option value=9 <%if(orderx[0].equals("9")){%>selected<%}%>>��������</option>
                                    <option value=10 <%if(orderx[0].equals("10")){%>selected<%}%>>����˳��</option>
                                     <option value=11 <%if(orderx[0].equals("11")){%>selected<%}%>>����ʱ������</option>
                                    <option value=12 <%if(orderx[0].equals("12")){%>selected<%}%>>����ʱ��˳��</option>
                                     <option value=13 <%if(orderx[0].equals("13")){%>selected<%}%>>������������</option>
                                    <option value=14 <%if(orderx[0].equals("14")){%>selected<%}%>>��������˳��</option>
                                </select>
                                    <select id="order2" style="font-size:9pt;width:90" class=tine>
                                        <option value=0>�ڶ�ѡ��</option>
                                        <option value=1 <%if(orderx[1].equals("1")){%>selected<%}%>>ʱ������</option>
                                        <option value=2 <%if(orderx[1].equals("2")){%>selected<%}%>>ʱ��˳��</option>
                                        <option value=3 <%if(orderx[1].equals("3")){%>selected<%}%>>Ȩ������</option>
                                        <option value=4 <%if(orderx[1].equals("4")){%>selected<%}%>>Ȩ��˳��</option>
                                        <option value=5 <%if(orderx[1].equals("5")){%>selected<%}%>>�������</option>
                                        <option value=6 <%if(orderx[1].equals("6")){%>selected<%}%>>���˳��</option>
                                        <option value=7 <%if(orderx[1].equals("7")){%>selected<%}%>>��Ȩ������</option>
                                        <option value=8 <%if(orderx[1].equals("8")){%>selected<%}%>>��Ȩ��˳��</option>
                                    </select>
                                    <select id="order3" style="font-size:9pt;width:90" class=tine>
                                        <option value=0>����ѡ��</option>
                                        <option value=1 <%if(orderx[2].equals("1")){%>selected<%}%>>ʱ������</option>
                                        <option value=2 <%if(orderx[2].equals("2")){%>selected<%}%>>ʱ��˳��</option>
                                        <option value=3 <%if(orderx[2].equals("3")){%>selected<%}%>>Ȩ������</option>
                                        <option value=4 <%if(orderx[2].equals("4")){%>selected<%}%>>Ȩ��˳��</option>
                                        <option value=5 <%if(orderx[2].equals("5")){%>selected<%}%>>�������</option>
                                        <option value=6 <%if(orderx[2].equals("6")){%>selected<%}%>>���˳��</option>
                                        <option value=7 <%if(orderx[2].equals("7")){%>selected<%}%>>��Ȩ������</option>
                                        <option value=8 <%if(orderx[2].equals("8")){%>selected<%}%>>��Ȩ��˳��</option>
                                    </select>
                                    <a href="javascript:displayRange();">��Χ</a>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <div id=range style="display:none">
                                        ʱ��<input class=tine name=time1 size=7 onfocus="setday(this)"
                                                 value="<%=timerange1%>">-<input class=tine name=time2 size=7
                                                                                 onfocus="setday(this)"
                                                                                 value="<%=timerange2%>">
                                        ��Ȩ��<input class=tine name=power1 size=12
                                                  value="<%=(powerrange1==null)?"":powerrange1%>">
                                        ��Ȩ��<input class=tine name=power2 size=12
                                                  value="<%=(powerrange2==null)?"":powerrange2%>">
                                        ���<input class=tine name=num1 size=4 value="<%=orderrange1%>">-<input class=tine
                                                                                                              name=num2
                                                                                                              size=4
                                                                                                              value="<%=orderrange2%>">
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table border="0" width="100%" cellspacing=0 cellpadding=0>
                            <tr>
                                <td width="41%">
                                    �б���ʽ��<select id="listType" name="listType" style="width:115;font-size:9pt">
                                    <option value="0">ѡ���б���ʽ</option>
                                    <%
                                        for (int i = 0; i < articleList.size(); i++) {
                                            viewfile = (ViewFile) articleList.get(i);
                                    %>
                                    <option value="<%=viewfile.getID()%>"
                                            <%if(listType==viewfile.getID()){%>selected<%}%>><%=StringUtil.gb2iso4View(viewfile.getChineseName())%>
                                    </option>
                                    <%}%>
                                </select>
                                    <input id=button7 type=button onclick="createStyle(1,<%=columnID%>)" value="�½�"
                                           style="height:20;width:30;font-size:9pt"><input id=button8 type=button
                                                                                           onclick="updateStyle(1,listType.options[listType.selectedIndex].value,<%=columnID%>)"
                                                                                           value="�޸�"
                                                                                           style="height:20;width:30;font-size:9pt"><input
                                        id=button9 type=button
                                        onclick="previewStyle(1,listType.options[listType.selectedIndex].value)"
                                        value="Ԥ��" style="height:20;width:30;font-size:9pt">
                                </td>
                                <td width="18%">������������<input id="days" size=2 maxlength=2 value="<%=days%>"></td>
                                <td width="41%">
                                    ������ʽ��<select id="seldays" style="width:115;font-size:9pt"
                                                 <%if(days==""){%>disabled<%}%>>
                                    <option value="0">ѡ����������ʽ</option>
                                    <%
                                        for (int i = 0; i < newList.size(); i++) {
                                            viewfile = (ViewFile) newList.get(i);
                                    %>
                                    <option value="<%=viewfile.getID()%>"
                                            <%if(viewfile.getID()==daystyle){%>selected<%}%>><%=StringUtil.gb2iso4View(viewfile.getChineseName())%>
                                    </option>
                                    <%}%>
                                </select>
                                    <input id=button10 type=button onclick="createStyle(7,0)"
                                           <%if(days==""){%>disabled<%}%> value="�½�"
                                           style="height:20;width:30;font-size:9pt"><input id=button11 type=button
                                                                                           onclick="updateStyle(7,seldays.options[seldays.selectedIndex].value,0)"
                                                                                           <%if(days==""){%>disabled<%}%>
                                                                                           value="�޸�"
                                                                                           style="height:20;width:30;font-size:9pt"><input
                                        id=button12 type=button
                                        onclick="previewStyle(7,seldays.options[seldays.selectedIndex].value)"
                                        <%if(days==""){%>disabled<%}%> value="Ԥ��"
                                        style="height:20;width:30;font-size:9pt">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border=0>
    <tr height=6>
        <td></td>
    </tr>
</table>
<b><font color="#0000FF">��ʾ������</font></b>
<table border=1 bordercolordark="#ffffec" bordercolorlight="#5e5e00" cellpadding=0 cellspacing=0 width='99%'>
    <tr>
        <td>
            <table border=0 width="100%" cellpadding=1 cellspacing=1>
                <tr>
                    <td>
                        <table border=0 width="100%" cellpadding=0 cellspacing=0>
                            <tr>
                                <td width="16%">����<input name="titlesize" value="<%=letterNum%>" size="4" maxlength="3">
                                </td>
                                <td width="16%">������<input name="vicetitlesize" value="<%=vicetitleNum%>" size="4"
                                                          maxlength="3"></td>
                                <td width="16%">ժҪ<input name="summarysize" value="<%=summaryNum%>" size="4"
                                                         maxlength="3"></td>
                                <td width="16%">����<input name="authorsize" value="<%=authorNum%>" size="4"
                                                         maxlength="3"></td>
                                <td width="16%">��Դ<input name="sourcesize" value="<%=sourceNum%>" size="4"
                                                         maxlength="3"></td>
                                <td width="16%">����<input name="contentsize" value="<%=contentNum%>" size="4"
                                                         maxlength="3">
                                    <a href="javascript:displaySize();">����</a></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id=moresize style="display:none">
                            <%
                                if (extendList.size() > 0) {
                                    out.println("<table border=0 width=\"100%\" cellpadding=0 cellspacing=0 bgcolor=white>");
                                    for (int i = 0; i < extendList.size(); i++) {
                                        String content = (String) extendList.get(i);
                                        if (i % 5 == 0) out.println("<tr>");
                                        out.println("<td width=\"20%\">" + content + "</td>");
                                        if ((i + 1) % 5 == 0) out.println("</tr>");
                                    }
                                    out.println("</table>");
                                }
                            %>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table border=0>
    <tr height=6>
        <td></td>
    </tr>
</table>
<b><font color="#0000FF">�������ԣ�</font></b>
<table border=1 bordercolordark="#ffffec" bordercolorlight="#5e5e00" cellpadding=0 cellspacing=0 width='99%'>
    <tr>
        <td>
            <input type="radio" name="linkradio" value="0" onclick="selectLink();" <%if(way==0){%>checked<%}%>>Ĭ������
            <input type="radio" name="linkradio" value="1" onclick="selectLink();" <%if(way==1){%>checked<%}%>>�Զ�������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;URL���ƣ�
            <input type="text" name="urlname" value="<%=url%>" <%if(way==0){%>disabled<%}%>><br>�������壺
            <input type="text" name="param" value="<%=param%>" <%if(way==0){%>disabled<%}%>>&nbsp;&nbsp;&nbsp;
            <input type="checkbox" name="aid" value="1" <%if(AID==1){%>checked<%}%> <%if(way==0){%>disabled<%}%>>ʹ���������
            &nbsp;&nbsp;&nbsp;
            <input type="checkbox" name="cid" value="1" <%if(CID==1){%>checked<%}%> <%if(way==0){%>disabled<%}%>>ʹ����Ŀ���
        </td>
    </tr>
</table>
<table border=0>
    <tr height=6>
        <td></td>
    </tr>
</table>
<table border=1 bordercolordark="#ffffec" bordercolorlight="#5e5e00" cellpadding=0 cellspacing=0 width='99%'>
    <tr>
        <td>
            <table border="0" width="100%" cellspacing=2 cellpadding=2>
                <tr>
                    <td colspan=2><b><font color="#0000FF">��ѡ��Ŀ��</font></b></td>
                    <td><b><font color="#0000FF">������ԣ�</font></b></td>
                </tr>
                <tr>
                    <td width="40%">
                        <select id="selectedColumn" name="selectedColumn" style="width:280" size="7"
                                language="javascript" onDblClick="defineAttr();" class=tine>
                            <%
                                if (str != null && str.trim().length() > 0) {
                                    if (columnIDs != null && columnIDs.trim().length() > 0) {
                                        columnIDs = columnIDs.substring(1, columnIDs.length() - 1);

                                        String[] cnames = columns.split(",");
                                        String[] cids = columnIDs.split(",");

                                        for (int i = 0; i < cids.length; i++) {
                                            if (!cnames[i].equals("*")) {
                                                if (cids[i].indexOf("-getAllSubArticle") > -1) {
                                                    cids[i] = cids[i].substring(0, cids[i].indexOf("-"));
                                                    cnames[i] = cnames[i] + "-getAllSubArticle";
                                                }
                            %>
                            <option value="<%=cids[i]%>"><%=cnames[i]%>
                            </option>
                            <%
                                            }
                                        }
                                    }
                                }
                            %>
                        </select><br>
                        <input type=checkbox value=1 name=archive <%if(archive==1){%>checked<%}%>
                               <%if(archive==2){%>disabled<%}%> onclick="allarticle.disabled=archive.checked;">ֻ�г��鵵����
                        <input type=checkbox value=1 name=allarticle <%if(archive==2){%>checked<%}%>
                               <%if(archive==1){%>disabled<%}%> onclick="archive.disabled=allarticle.checked;">�г���������
                    </td>
                    <td width="10%"><input type="button" name="delete" value="ɾ��" onclick="delItem();"
                                           style="height:20;width:30;font-size:9pt"></td>
                    <td width="50%" valign=top>
                        <table border=0 cellpadding=0 cellspacing=0 width="100%">
                            <tr height=24>
                                <td>
                                    ����Ƿ�Ҫ���ɰ����ļ���
                                    <input type=radio name=innerFlag value=0 <%if(selectWay==2){%>disabled<%}%>
                                           <%if(innerFlag==0){%>checked<%}%>>��
                                    <input type=radio name=innerFlag value=1 <%if(selectWay==2){%>disabled<%}%>
                                           <%if(innerFlag==1){%>checked<%}%>>��
                                </td>
                            </tr>
                            <tr height=24>
                                <td>����������ƣ�<input name=chineseName size=20 value="<%=cname%>" class=tine></td>
                            </tr>
                            <tr height=80>
                                <td>���������<br><textarea rows="3" id="notes" cols="38" class=tine><%=notes%>
                                </textarea></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</td>
</tr>
<tr>
    <td align="center" height=40>
        <input type="button" class=tine value="  ����  "
               onClick="check(<%=type%>,'<%=extendMgr.getExtendAttrEName(columnID)%>',false,<%=typeList.size()%>);">&nbsp;&nbsp;&nbsp;
        <input type="button" class=tine value=" ���Ϊ "
               onClick="check(<%=type%>,'<%=extendMgr.getExtendAttrEName(columnID)%>',true,<%=typeList.size()%>);">&nbsp;&nbsp;&nbsp;
        <input type="button" class=tine value="  ȡ��  " onClick="cal();">
    </td>
</tr>
</table>
</form>
</body>
<script type="text/javascript">
    var content = document.getElementById('content').value;
</script>
</html>