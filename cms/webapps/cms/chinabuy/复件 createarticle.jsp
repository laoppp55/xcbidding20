<%@ page import="java.sql.*,
                 java.io.*,
                 java.util.*,
                 org.jdom.*,
                 org.jdom.input.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>
<%@ taglib uri="/FCKeditor" prefix="FCK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean errorTitle = false;
    boolean errorContent = false;
    boolean errors = false;
    boolean success = false;
    int siteid = authToken.getSiteID();
    String username = authToken.getUserID();
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    session.setAttribute("createtemplate_columnid", String.valueOf(columnID));

    //String baseURL = "http://" + request.getHeader("Host") + "/webbuilder/";
    String maintitle = null, vicetitle = null, content = null, summary = null, keyword = null, source = null, year = null,
            month = null, articlepic = null, day = null, hour = null, minute = null, author = null, brand = null,
            pic = null, bigpic = null, relatedID = null, filename = null, otherurl = null;
    int docLevel = 0, viceLevel = 0, sortid = 0, status = 0, subscriber = 0, weight = 0, stocknum = 0, modelID = 0, urltype = 0,score=0,voucher=0;
    float saleprice = 0, inprice = 0, marketprice = 0,istype=0,vipprice=0;

    //�����Ŀ��Ϣ
    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    int isDefine = column.getDefineAttr();
    int isProduct = column.getIsProduct();
    int isAudited = column.getIsAudited();
    List attechmentArticle = new ArrayList();
    List pubcolumns = new ArrayList();

     //�����Ŀ���·���
    //List inlist = columnManager.getInheritanceType(column.getParentID());//��ȡ�̳еķ���
    //List typeList  = columnManager.getAllTypeForColumn("select * from tbl_type where columnid = "+columnID+" and parentid = 0 and referid = 0 order by createdate desc");//��ȡ�Զ���ķ���
    //�ϲ��̳к��Զ���ķ���
    //for(int i = 0;i < inlist.size(); i++){
    //    Producttype pt = (Producttype)inlist.get(i);
    //    typeList.add(pt);
    //}

    if (doCreate) {
        maintitle = ParamUtil.getParameter(request, "maintitle");
        maintitle = (maintitle != null) ? maintitle.trim() : maintitle;
        vicetitle = ParamUtil.getParameter(request, "vicetitle");
        content = ParamUtil.getParameter(request, "content");
        author = ParamUtil.getParameter(request, "author");
        summary = ParamUtil.getParameter(request, "summary");
        keyword = ParamUtil.getParameter(request, "keyword");
        source = ParamUtil.getParameter(request, "source");
        relatedID = ParamUtil.getParameter(request, "relatedID");
        docLevel = ParamUtil.getIntParameter(request, "docLevel", 0);
        viceLevel = ParamUtil.getIntParameter(request, "viceDocLevel", 0);
        status = ParamUtil.getIntParameter(request, "status", 1);
        subscriber = ParamUtil.getIntParameter(request, "subscriber", 1);
        sortid = ParamUtil.getIntParameter(request, "sortid", 0);
        year = ParamUtil.getParameter(request, "year");
        month = ParamUtil.getParameter(request, "month");
        day = ParamUtil.getParameter(request, "day");
        hour = ParamUtil.getParameter(request, "hour");
        minute = ParamUtil.getParameter(request, "minute");
        filename = ParamUtil.getParameter(request, "filename");
        modelID = ParamUtil.getIntParameter(request, "modelID", 0);
        attechmentArticle = ParamUtil.getSelectParameterAllNamesAndValues(request, "attechment");
        pubcolumns = ParamUtil.getSelectParameterAllNamesAndValues(request, "pubcolumns");
        articlepic = ParamUtil.getParameter(request, "articlepic");
        urltype = ParamUtil.getIntParameter(request, "url", 0);
        otherurl = ParamUtil.getParameter(request, "aurl");
        if (isProduct == 1) {
            brand = ParamUtil.getParameter(request, "brand");
            pic = ParamUtil.getParameter(request, "pic");
            bigpic = ParamUtil.getParameter(request, "bigpic");
            weight = ParamUtil.getIntParameter(request, "weight", 0);
            stocknum = ParamUtil.getIntParameter(request, "stocknum", 0);
            saleprice = ParamUtil.getFloatParameter(request, "saleprice", 0);
            inprice = ParamUtil.getFloatParameter(request, "inprice", 0);
            marketprice = ParamUtil.getFloatParameter(request, "marketprice", 0);
            vipprice = ParamUtil.getFloatParameter(request, "vipprice", 0);
            score = ParamUtil.getIntParameter(request, "score", 0);
            voucher = ParamUtil.getIntParameter(request, "voucher", 0);
        }

        if (content != null) {
            content = StringUtil.replace(content, "cmstextarea", "textarea").trim();
        }
        if (maintitle == null) errorTitle = true;
        if (content == null) errorContent = true;
        errors = errorTitle || errorContent;
    }

    IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
    Article article = new Article();
    if (!errors && doCreate) {
        try {
            article.setSiteID(siteid);
            article.setColumnID(columnID);
            article.setMainTitle(maintitle);
            article.setViceTitle(vicetitle);
            article.setContent(content);
            article.setAuthor(author);
            article.setSummary(summary);
            article.setKeyword(keyword);
            article.setSortID(sortid);
            article.setRelatedArtID(relatedID);
            article.setPubFlag(1);
            article.setSource(source);
            article.setEditor(username);
            Timestamp create_date = new Timestamp(System.currentTimeMillis());
            article.setCreateDate(create_date);
            article.setLastUpdated(create_date);
            article.setDocLevel(docLevel);
            article.setViceDocLevel(viceLevel);
            article.setAuditFlag(isAudited);
            article.setStatus(status);
            article.setModelID(modelID);
            article.setSubscriber(subscriber);
            article.setUrltype(urltype);
            article.setOtherurl(otherurl);
            article.setFileName(filename);
            if (filename != null)
                article.setNullContent(1);
            else
                article.setNullContent(0);
            article.setArticlepic(articlepic);
            article.setT1(0);
            article.setT2(0);
            article.setT3(0);
            article.setT4(0);
            article.setT5(0);
            if (isProduct == 1) {
                article.setSalePrice(saleprice);
                article.setInPrice(inprice);
                article.setMarketPrice(marketprice);
                article.setBrand(brand);
                article.setProductPic(pic);
                article.setProductBigPic(bigpic);
                article.setProductWeight(weight);
                article.setStockNum(stocknum);
                article.setVIPPrice(vipprice);
                article.setScore(score);
                article.setVoucher(voucher);
            }

            if (year == null)
                article.setPublishTime(new Timestamp(System.currentTimeMillis()));
            else {
                Timestamp publishtime = new Timestamp(Integer.parseInt(year)-1900, Integer.parseInt(month)-1,Integer.parseInt(day),Integer.parseInt(hour),Integer.parseInt(minute),0,0);
                article.setPublishTime(publishtime);
            }

            List attrList = new ArrayList();
            if (isDefine == 1) {
                String xmlTemplate = extendMgr.getXMLTemplate(columnID);
                if (xmlTemplate != null && xmlTemplate.trim().length() > 0) {
                    SAXBuilder builder = new SAXBuilder();
                    Reader in = new StringReader(xmlTemplate);
                    Document doc = builder.build(in);
                    List nodeList = doc.getRootElement().getChildren();
                    for (int i = 0; i < nodeList.size(); i++) {
                        Element e = (Element) nodeList.get(i);
                        String ename = e.getName();
                        String value = ParamUtil.getParameter(request, ename);
                        if (value != null) value = value.replaceAll("&apos;", "\'");

                        if (value != null && value.trim().length() > 0) {
                            ExtendAttr extend = new ExtendAttr();
                            int dataType = Integer.parseInt(e.getAttributeValue("datatype"));

                            extend.setEName(ename);
                            extend.setDataType(dataType);
                            if (dataType == 1)
                                extend.setStringValue(value);
                            else if (dataType == 2)
                                extend.setNumericValue(Integer.parseInt(value));
                            else if (dataType == 3)
                                extend.setTextValue(value);
                            else if (dataType == 4)
                                extend.setFloatValue(Float.parseFloat(value));
                            attrList.add(extend);
                        }
                    }
                }
            }
            //���·���
            //List ptypelist = (List)session.getAttribute("articletypeids");

            //�����ֻ�ͼƬ
            List turnpic = (List)session.getAttribute("turn_pic");

            //attechmentArticle   �����б�
            //pubcolumns          ������Ҫ��������Ŀ�б�
            extendMgr.create(attrList, attechmentArticle, article, pubcolumns,turnpic);
            success = true;
        }
        catch (Exception e) {
            e.printStackTrace();
            errors = true;
        }
    }

    if (success) {
        session.removeAttribute("articletypeids");
        response.sendRedirect(response.encodeRedirectURL("../chinabuy/closewin.jsp?column=" + columnID + "&id=" + article.getID() + "&fromflag=c"));
        return;
    }

    Calendar today = Calendar.getInstance();
    int m_year = today.get(Calendar.YEAR);
    int m_day = today.get(Calendar.DAY_OF_MONTH);
    int m_month = today.get(Calendar.MONTH) + 1;
    int m_hour = today.get(Calendar.HOUR_OF_DAY);
    int m_minute = today.get(Calendar.MINUTE);
%>

<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link REL="stylesheet" TYPE="text/css" HREF="../style/editor.css">
<script type="text/javascript" src="../fckeditor/fckeditor.js"></script>
<script LANGUAGE="JavaScript" SRC="../toolbars/dhtmled.js"></script>

<script language=javascript>
function Editor(ename)
{
    window.open("editor.jsp?column=<%=columnID%>&ename=" + ename, "Editor", "width=870,height=600,left=0,top=0,status");
}

function upload_attrpic_onclick(attrname)
{
    window.open("../upload/upload.jsp?column=<%=columnID%>&attr=" + attrname, "", 'width=400,height=400,left=200,top=200');
}

//˫��ѡ�����·���
function addarticletype()
{
    window.open("selectarticletype.jsp?column=<%=columnID%>", "", "top=100,left=100,width=420,height=360");
}

//ѡ�����µ�ID��ΪȨ��
function AddRelatedArticleID(para)
{
    var winStr = "addRelatedArticle.jsp?from=1&param=" + para;
    //from=1 ����¼������������
    var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
    if (isMSIE) {
        var retval = showModalDialog(winStr, "AddRelatedArticleID", "font-family:Verdana; font-size:12; dialogWidth:55em; dialogHeight:35em; status=no");
        if (retval != "" && retval != undefined)
        {
            retval = retval.substring(0, retval.indexOf(","));
            if (para == 0)
                document.createForm.docLevel.value = retval;

            if (para == 1)
                document.createForm.viceDocLevel.value = retval;

            if (para == 2)
                document.createForm.relatedID.value = retval;
        }
    } else {
        var wins = window.open(winStr, "", "width=700,height=500");
        wins.focus();
    }
}

//�����������
function AddArticleAttechment()
{
    var winStr = "addArticleAttechment.jsp";
    var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
    if (isMSIE) {
        var retval = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:800px; dialogHeight:600px; status=no");
        if (retval != "" && retval != undefined)
        {
            var regexp = /\r\n/g;
            var rtnAry = retval.split(regexp);

            if (rtnAry != null) {
                var len = rtnAry.length;
                var i = 0;

                while (i < len) {
                    posi = rtnAry[i].indexOf("-");
                    value = rtnAry[i].substring(0, posi);
                    text = rtnAry[i].substring(posi + 1);
                    var oOption = document.createElement("OPTION");
                    oOption.value = rtnAry[i];
                    oOption.text = text;
                    document.createForm.attechmentID.add(oOption);
                    i++;
                }
            }
        }
    } else {
        var wins = window.open(winStr, "", "width=800,height=600");
        wins.focus();
    }
}

//��������Ŀ��������
function AddPubColumns()
{
    var winStr = "addPubColumns.jsp";
    var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
    if (isMSIE) {
        var retval = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:800px; dialogHeight:600px; status=no");
        if (retval != "" && retval != undefined)
        {
            var regexp = /\r\n/g;
            var rtnAry = retval.split(regexp);

            if (rtnAry != null) {
                var len = rtnAry.length;
                var i = 0;

                while (i < len) {
                    posi = rtnAry[i].indexOf("-");
                    value = rtnAry[i].substring(0, posi);
                    text = rtnAry[i].substring(posi + 1);
                    var oOption = document.createElement("OPTION");
                    oOption.value = rtnAry[i];
                    oOption.text = text;
                    document.createForm.pcolumnsID.add(oOption);
                    i++;
                }
            }
        }
    } else {
        var wins = window.open(winStr, "", "width=800,height=600");
        wins.focus();
    }
}

//�����Ƽ�
/*function ArticleAttechment()
{
    var winStr = "addRelateListnew.jsp";
    window.open(winStr, "", "width=800,height=600,left=200,top=200,scrollbars=yes");
}*/

//ѡ������ģ��
function selectArticleModel()
{
    var winStr = "selectModel.jsp?column=<%=columnID%>";
    var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
    if (isMSIE) {
        var retval = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:800px; dialogHeight:600px; status=no");
        if (retval != "" && retval != undefined)
        {
            document.createForm.modelID.value = retval;
        }
    } else {
        var wins = window.open(winStr, "", "width=800,height=600");
        wins.focus();
    }
}

function create(createForm)
{
    if (createForm.maintitle.value == "")
    {
        alert("�����ⲻ��Ϊ�գ�");
        createForm.maintitle.focus();
        return;
    }
<%if (isProduct == 1){%>
    if (createForm.saleprice.value == "")
    {
        alert("��Ʒ�ۼ۲���Ϊ�գ�");
        createForm.saleprice.focus();
        return;
    }
    if (!checkFloat(createForm.saleprice.value))
    {
        alert("��Ʒ�ۼ�ӦΪС�������ݣ�");
        createForm.saleprice.focus();
        return;
    }
    if (!checkFloat(createForm.vipprice.value))
    {
        alert("VIP�ۼ�ӦΪС�������ݣ�");
        createForm.vipprice.focus();
        return;
    }
    if (createForm.inprice.value != "" && !checkFloat(createForm.inprice.value))
    {
        alert("��Ʒ����ӦΪС�������ݣ�");
        createForm.inprice.focus();
        return;
    }
    if (createForm.marketprice.value != "" && !checkFloat(createForm.marketprice.value))
    {
        alert("��Ʒ�г���ӦΪС�������ݣ�");
        createForm.marketprice.focus();
        return;
    }
    if (!checkInt(createForm.score.value))
    {
        alert("��Ʒ����ӦΪ�������ݣ�");
        createForm.score.focus();
        return;
    }
    if (!checkInt(createForm.voucher.value))
    {
        alert("��Ʒ���ù����ӦΪ�������ݣ�");
        createForm.voucher.focus();
        return;
    }
    if (createForm.stocknum.value == "")
    {
        alert("��Ʒ��治��Ϊ�գ�");
        createForm.stocknum.focus();
        return;
    }
    if (!checkInt(createForm.stocknum.value))
    {
        alert("��Ʒ���ӦΪ�������ݣ�");
        createForm.stocknum.focus();
        return;
    }
    if (createForm.weight.value == "")
    {
        alert("��Ʒ��������Ϊ�գ�");
        createForm.weight.focus();
        return;
    }
    if (!checkInt(createForm.weight.value))
    {
        alert("��Ʒ����ӦΪ�������ݣ�");
        createForm.weight.focus();
        return;
    }
<%}%>
<%if (isDefine == 1){%>
    if (!checkExtendAttr(createForm))
        return;
<%}%>

  /*  for (var i = 0; i < createForm.attechmentID.length; i++) {
        createForm.attechmentID[i].selected = true;
    }

    for (var i = 0; i < createForm.pcolumnsID.length; i++) {
        createForm.pcolumnsID[i].selected = true;
    }   */

    createForm.submit();
}

function checkFloat(str)
{
    var retstr = false;
    var regstr = /[^0-9.]/gi;
    if (regstr.exec(str) == null)
    {
        retstr = true;
    }
    return retstr;
}

function checkInt(str)
{
    var retstr = false;
    var regstr = /[^0-9]/gi;
    if (regstr.exec(str) == null)
    {
        retstr = true;
    }
    return retstr;
}

function fileUpload()
{
    window.open('fileUpload.jsp?column=<%=columnID%>', '', 'left=300,top=200,width=400,height=200');
}

//˫��ѡ����ʷͼƬ
function history(attrname)
{
    window.open("../upload/historypic.jsp?column=<%=columnID%>&pictype=1&attr=" + attrname, "", "left=100,top=100,width=800,height=600");
}

function cal() {
    var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
    if (isMSIE) {
        window.returnValue = "";
        top.close();
    } else {
        top.close();
    }
}

function delItem()
{
    var select = false;
    for (var i = 0; i < createForm.attechment.length; i++)
    {
        if (createForm.attechment[i].selected)
        {
            select = true;
            break;
        }
    }

    if (select)
    {
        for (var i = 0; i < createForm.attechment.length; i++)
            if (createForm.attechment[i].selected)
                createForm.attechment[i] = null;
    }
    else
    {
        alert("��ѡ��������£�");
    }
}

function useMyUrl(f)
{
    if (f == 1)
        createForm.aurl.disabled = 0;
    else
        createForm.aurl.disabled = 1;
}

function upload_turn_pic(){
    window.open("../upload/upload_turn_pic.jsp?column=<%=columnID%>", "", 'width=400,height=400,left=200,top=200');
}
</script>

</head>
<body>
<form action=createarticle.jsp method=post name=createForm>
<input type=hidden name=doCreate value="true">
<input type=hidden name=column value="<%=columnID%>">
<input type=hidden name=filename>
<input type=hidden name=modelSourceCodeFlag value=0>
<table width="100%" border=0 cellspacing=0 cellpadding=0>
    <tr bgcolor=#003366>
        <td colspan=3 height=2></td>
    </tr>
    <tr height=40>
        <td width="25%">&nbsp;<%=StringUtil.gb2iso4View(column.getCName())%>&nbsp;>&nbsp;��������</td>
        <td width="50%"><%
            if (!success && errors) {
                out.println("<span class=cur>��������ʧ�ܣ����������ԡ�</span>");
            }
        %></td>
        <td width="25%" align=right>
            <input class=tine type=button value="  ����  " onClick="create(createForm);">&nbsp;&nbsp;
            <input class=tine type=button value="  ȡ��  " onClick="cal();">&nbsp;&nbsp;
        </td>
    </tr>
    <tr bgcolor=#003366>
        <td colspan=3 height=2></td>
    </tr>
    <tr>
        <td colspan=3 height=4></td>
    </tr>
</table>

<table border=1 borderColorDark="#ffffe0c" borderColorLight="#5e5e00" cellPadding=0 cellSpacing=0 width="100%">
<tr bgcolor="#eeeeee">
    <td class=line>
        ����(<a href="javascript:upload_attrpic_onclick('mt');">ͼ</a>)<input class=tine name=maintitle id="maintitle"
                                                                        size=36 onDblClick="history('mt');"
        title="˫������������ѡ����ʷͼƬ">
        ������(<a href="javascript:upload_attrpic_onclick('vt')">ͼ</a>)<input class=tine name=vicetitle
                                                                         id="vicetitle" size=30
                                                                         onDblClick="history('vt');"
        title="˫������������ѡ����ʷͼƬ">
        ����(<a href="javascript:upload_attrpic_onclick('au')">ͼ</a>)<input class=tine name=author id="author"
                                                                        size=10 onDblClick="history('au');"
        title="˫������������ѡ����ʷͼƬ">
        ��Դ(<a href="javascript:upload_attrpic_onclick('sr')">ͼ</a>)<input class=tine name=source id="source"
                                                                        size=10 onDblClick="history('sr');"
        title="˫������������ѡ����ʷͼƬ">
        ����ģ��<input class=tine name=modelID id="modelID" size=8 value=0 title="˫�����������ɵ���ģ��ѡ��ҳ��"
                   onDblClick="selectArticleModel();">
    </td>
</tr>
<tr bgcolor="#ffffff">
    <td class=line>
        ժҪ<!--input class=tine name=summary size=80-->
      <textarea cols="60" rows="2" id="summaryID" name="summary"></textarea></td>
</tr>
<%if (isProduct == 1) {%>
<tr bgcolor="#eeeeee">
    <td class=line>
        �ۼۣ�<input class=tine name=saleprice size=6>
        VIP�ۣ�<input class=tine name=vipprice size=6>
        ���ۣ�<input class=tine name=inprice size=6>
        �г��ۣ�<input class=tine name=marketprice size=6>
        ���֣�<input class=tine name=score size=6>
        �����<input class=tine name=voucher size=6>
        ��棺<input class=tine name=stocknum size=6>
        ���̣�<input class=tine name=brand size=12>
        ����(��)��<input class=tine name=weight size=5>

        ͼƬ(<a href="javascript:upload_attrpic_onclick('pic')">ͼ</a>)��<input class=tine name=pic id="pic" size=12
                                                                          onDblClick="history('pic');"
        title="˫������������ѡ����ʷͼƬ">
        ��ͼƬ(<a href="javascript:upload_attrpic_onclick('bigpic')">ͼ</a>)��<input class=tine name=bigpic id="bigpic"
                                                                              size=12 onDblClick="history('bigpic');"
        title="˫������������ѡ����ʷͼƬ">
    </td>
</tr>
<%}%>
<%if (isDefine == 1) {%>
<tr bgcolor="#eeeeee">
    <td class=line><%=extendMgr.getExtendAttrForArticle(columnID, 0)%>
    </td>
</tr>
<%}%>
<tr bgcolor="#eeeeee">
    <td class=line colspan=2>
        <font color="#FF0000"><b>�ؼ���(;)</b></font><input class=tine name=keyword size=30>
        <font color="#FF0000"><b>����</b></font><input class=tine name="sortid" size=4 value=0>
        <font color="#FF0000"><b>��Ȩ��</b></font><input class=tine id="docLevel" name="docLevel" size=4 value="0"
                                                      maxlength="6" onDblClick="AddRelatedArticleID(0);"
                                                      title="˫������������ѡ��ĳƪ����ID��Ϊ��ƪ���µ�Ȩ��">
        <font color="#FF0000"><b>��Ȩ��</b></font><input class=tine id="viceDocLevel" name="viceDocLevel" size=4
                                                      value="0" maxlength="6"
                                                      onDblClick="AddRelatedArticleID(1);"
                                                      title="˫������������ѡ��ĳƪ����ID��Ϊ��ƪ���µĴ�Ȩ��">
        <font color="#FF0000"><b>������</b></font><input name="relatedID" size="4" id="relatedID"
                                                      onDblClick="AddRelatedArticleID(2);"
                                                      title="˫�����������ɵ���������ѡ��ҳ��">
      <font color="#FF0000"><b>����ͼƬ</b></font>(<a href="javascript:upload_attrpic_onclick('apic')">ͼ</a>)<input
            class=tine name="articlepic" id="articlepic" size=20 onDblClick="history('apic');"
        title="˫������������ѡ����ʷͼƬ">&nbsp;&nbsp;</td>
</tr>
<tr bgcolor="#ffffff">
    <td class=line>
        <font color="#FF0000"><b>��������</b></font><input class=tine type=text size=3 maxlength=4 name=year
                                                       value=<%=m_year%>>��
        <select name=month size=1 class=tine>
            <%for (int i = 1; i < 13; i++) {%>
            <option value=<%=i%> <%=(m_month == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>��
        <select name=day size=1 class=tine>
            <%for (int i = 1; i < 32; i++) {%>
            <option value=<%=i%> <%=(m_day == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>��
        <select name=hour size=1 class=tine>
            <%for (int i = 1; i < 24; i++) {%>
            <option value=<%=i%> <%=(m_hour == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>ʱ
        <select name=minute size=1 class=tine>
            <%for (int i = 1; i < 61; i++) {%>
            <option value=<%=i%> <%=(m_minute == i) ? "selected" : ""%>><%=i%>
            </option>
            <%}%>
        </select>��

      <!--(<a href="javascript:fileUpload();">�ļ��ϴ�</a>)--></td>
</tr>
<!--��Ŀ����-->
<tr bordercolor="#CCCCCC" bgcolor="#CCCCCC">
    <td>&nbsp;</td>
</tr>
</table>
<table border="0" width="100%">
    <tr>
        <td>
            <textarea id="content" name="content" style="WIDTH: 100%; HEIGHT: 530px"></textarea>
            <script type="text/javascript">
                var oFCKeditor = new FCKeditor('content') ;
                oFCKeditor.BasePath = "../fckeditor/";
                oFCKeditor.Height = 520;
                oFCKeditor.ToolbarSet = "ArticleDefault";
                oFCKeditor.ReplaceTextarea();
            </script>
        </td>
    </tr>
</table>
</form>
<%
    if (errors) {
        out.println("<script lanagage='javascript'>");
        if (maintitle == null)
            out.println("createForm.maintitle.focus();");
        //if (content == null)
        //  out.println("tbContentElement.focus();");
        out.println("</script>");
    }
%>
</body>
</html>