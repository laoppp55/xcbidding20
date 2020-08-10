<%@ page import="com.bizwink.cms.util.ParamUtil" %>

<%@ page import="com.bizwink.cms.modelManager.IModelManager" %>
<%@ page import="com.bizwink.cms.modelManager.ModelPeer" %>
<%@ page import="com.bizwink.cms.modelManager.Model" %>
<%@ page import="java.sql.*,
                 java.io.*,
                 java.util.*,
                 org.jdom.*,
                 org.jdom.input.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>
<%@ page import="com.usermodelnews.IUserModelNewsManager" %>
<%@ page import="com.usermodelnews.UserModelNewsPeer" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int columnid = ParamUtil.getIntParameter(request, "columnid", -1);
    int flag = ParamUtil.getIntParameter(request, "flag", -1);
    int columnID = columnid;
    IColumnManager columnManager = ColumnPeer.getInstance();
    //�Ȳ������� ���û�� �Ҹ���ľ����
    IModelManager modelpeer = ModelPeer.getInstance();
     IExtendAttrManager extendMgr = ExtendAttrPeer.getInstance();
     IUserModelNewsManager umnpeer = UserModelNewsPeer.getInstance();
    Model model = null;
    int parentcolumnid = -1;



     boolean errorTitle = false;
        boolean errorContent = false;
        boolean errors = false;
        boolean success = false;
        int siteid = authToken.getSiteID();
        String username = authToken.getUserID();
        //�����Ŀ��Ϣ
        //  IColumnManager columnManager = ColumnPeer.getInstance();
    //��չ����
        
        Column column = columnManager.getColumn(columnID);
       // System.out.println("column="+column+"     columnID="+columnID);
        boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
        int isDefine = column.getDefineAttr();
        int isProduct = column.getIsProduct();
        int isAudited = column.getIsAudited();
        List attechmentArticle = new ArrayList();
        List pubcolumns = new ArrayList();
        String maintitle = null, vicetitle = null, contents = null, summary = null, keyword = null, source = null, year = null,
                month = null, articlepic = null, day = null, hour = null, minute = null, author = null, brand = null,
                pic = null, bigpic = null, relatedID = null, filename = null, otherurl = null,modelcontent=null;
        int docLevel = 0, viceLevel = 0, sortid = 0, status = 0, subscriber = 0, weight = 0, stocknum = 0, modelID = 0, urltype = 0, score = 0, voucher = 0;
        float saleprice = 0, inprice = 0, marketprice = 0, istype = 0, vipprice = 0;

         try {
        do {
            model = modelpeer.getArticleModel(columnid);
            Column columns = columnManager.getParentColumn(columnid);
            columnid = columns.getID();
            //System.out.println("columnid="+columnid+"   model="+model);
        } while (model == null);
     modelcontent = model.getContent();
          //----------------------------------------------------
        if (flag != -1) {

        String  content="";
     if (doCreate) {
       // System.out.println("vvvvvvvvvvvvvvvvvvv");
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
        //beidate=ParamUtil.getParameter(request,"beidate");
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



         //-------------------------------���content�ֶ�----------------------------------------------
         List listnewscontent= umnpeer.getImgAllContent(modelcontent);
         content="";
       for(int i=0;i<listnewscontent.size();i++)
        {
           String newcontent=(String)listnewscontent.get(i);
           if(modelcontent.indexOf(newcontent)!=-1)
           {
               String str=newcontent.substring(newcontent.indexOf("[CHINESENAME]")+"[CHINESENAME]".length(),newcontent.indexOf("[/CHINESENAME]"));
               String width=newcontent.substring(newcontent.indexOf("[WIDTH]")+"[WIDTH]".length(),newcontent.indexOf("[/WIDTH]"));
               String height=newcontent.substring(newcontent.indexOf("[HEIGHT]")+"[HEIGHT]".length(),newcontent.indexOf("[/HEIGHT]"));

               String modelcontentstr="";
               String orderstr=newcontent.substring(newcontent.indexOf("[ORDER]")+"[ORDER]".length(),newcontent.indexOf("[/ORDER]"));
               modelcontentstr=modelcontentstr+ParamUtil.getParameter(request,orderstr);

               content=content+"<!--begin>[TAGA][IMGZUHECONTENT][CHINESENAME]"+str+"[/CHINESENAME][WIDTH]"+width+"[/WIDTH][HEIGHT]"+height+"[/HEIGHT][ORDER]"+orderstr+"[/ORDER][SRC]"+modelcontentstr+"[/SRC][ORDER]"+orderstr+"[/ORDER][/IMGZUHECONTENT][/TAGA]<end-->";

               //System.out.println("<TAG><IMGZUHECONTENT><CHINESENAME>"+str+"</CHINESENAME><WIDTH>"+width+"</WIDTH><HEIGHT>"+height+"</HEIGHT><ORDER>"+orderstr+"</ORDER><SRC>"+modelcontentstr+"</SRC></IMGZUHECONTENT></TAG>");
           }
        }


            List listtextnewscontent= umnpeer.getTextAllContent(modelcontent);
       for(int i=0;i<listtextnewscontent.size();i++)
       {
           String newcontent=(String)listtextnewscontent.get(i);
           if(modelcontent.indexOf(newcontent)!=-1)
           {
              // System.out.println(""+modelcontent);
               String str=newcontent.substring(newcontent.indexOf("[CHINESENAME]")+"[CHINESENAME]".length(),newcontent.indexOf("[/CHINESENAME]"));
              // String width=newcontent.substring(newcontent.indexOf("[WIDTH]")+"[WIDTH]".length(),newcontent.indexOf("[/WIDTH]"));
              // String height=newcontent.substring(newcontent.indexOf("[HEIGHT]")+"[HEIGHT]".length(),newcontent.indexOf("[/HEIGHT]"));

              // System.out.println("str="+str+  newcontent+"    0000");
               String orderstr=newcontent.substring(newcontent.indexOf("[ORDER]")+"[ORDER]".length(),newcontent.indexOf("[/ORDER]"));
               String modelcontentstr="";

               modelcontentstr=modelcontentstr+ParamUtil.getParameter(request,orderstr);

               content=content+"<!--begin>[TAGA][TEXTZUHECONTENT][CHINESENAME]"+str+"[/CHINESENAME][ORDER]"+orderstr+"[/ORDER][AREA]"+modelcontentstr+"[/AREA][ORDER]"+orderstr+"[/ORDER][/TEXTZUHECONTENT][/TAGA]<end-->";

           }
       }

         //---------------------------------------------------------------------------------------------


        if (content != null) {
            content = StringUtil.replace(content, "cmstextarea", "textarea").trim();

        }else{
            content="";
        }
        if (maintitle == null) errorTitle = true;
        if (content == null) errorContent = true;
        errors = errorTitle || errorContent;
    }


            Article article = new Article();
         //   System.out.println("aaaaaaaaaaaaaaaaa"+errors);
           if (!errors && doCreate) {
            try {
            //    System.out.println("bbbbbbbbbbbbbbbbbbbbbbb");
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
                    Timestamp publishtime = new Timestamp(Integer.parseInt(year) - 1900, Integer.parseInt(month) - 1, Integer.parseInt(day), Integer.parseInt(hour), Integer.parseInt(minute), 0, 0);
                    article.setPublishTime(publishtime);
                }

                List attrList = new ArrayList();
                if (isDefine == 1) {
                    String xmlTemplate = extendMgr.getXMLTemplate(columnid);
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
                List turnpic = (List) session.getAttribute("turn_pic");

                //attechmentArticle   �����б�
                //pubcolumns          ������Ҫ��������Ŀ�б�

                try {
                    extendMgr.create(attrList, attechmentArticle, article, pubcolumns, turnpic);
              //      System.out.println("=============================================");
                } catch (Exception es) {
                    System.out.println("" + es.toString());
                }
                success = true;
            }
            catch (Exception e) {
                System.out.println("" + e.toString() + "");
                e.printStackTrace();
                errors = true;
            }
           }
        }
   /* } catch (Exception e) {
        out.write("no  article");
    }*/
    // System.out.println("mode="+model+"   chinese="+model+"   columnid="+columnid);

%>
<html>
<head>
    <script type="text/javascript" src="../fckeditor/fckeditor.js"></script>
<script LANGUAGE="JavaScript" SRC="../toolbars/dhtmled.js"></script>

<script language=javascript>
function Editor(ename)
{
    window.open("editor.jsp?column=<%=columnID%>&ename=" + ename, "Editor", "width=870,height=600,left=0,top=0,status");
}

function upload_attrpic_onclick(attrname)
{
    window.open("../upload/upload_zhanqu.jsp?column=<%=columnID%>&attr=" + attrname, "", 'width=600,height=450,left=200,top=200');
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
<%if (isProduct == 1) if (modelcontent.indexOf("[TAG][PRODUCT_SALEPRICE]��Ʒ�ۼ�[/PRODUCT_SALEPRICE][/TAG]") != -1) {

        {%>
    
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

<%}}%>
<%if (isDefine == 1){%>
    //if (!checkExtendAttr(createForm))
    //    return;
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

<%

        out.write("<form action=createarticle.jsp?columnid="+columnID+" method=post name=createForm><input type=hidden value=1 name=flag><input type=hidden name=doCreate value=\"true\">\n" +
"<input type=hidden name=columnid value="+columnID+">\n" +
"<input type=hidden name=filename>\n" +
"<input type=hidden name=modelSourceCodeFlag value=0>\n" +
"<input type=hidden name=template_or_article_flag value=\"1\">\n" +
"<input type=hidden name=markid id=\"markid\" value=\"-1\">");

        //if (modelcontent.indexOf("[TAG][ARTICLE_MAINTITLE][/ARTICLE_MAINTITLE][/TAG]") != -1) {
            out.write("����(<a href=\"javascript:upload_attrpic_onclick('mt');\">ͼ</a>)<input class=tine name=maintitle id=\"maintitle\"\n" +
"                                                                        size=36 onDblClick=\"history('mt');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\"><br>");
       // }
        if (modelcontent.indexOf("[TAG][ARTICLE_VICETITLE][/ARTICLE_VICETITLE][/TAG]") != -1) {
            out.write("������ ������(<a href=\"javascript:upload_attrpic_onclick('vt')\">ͼ</a>)<input class=tine name=vicetitle\n" +
"                                                                         id=\"vicetitle\" size=30\n" +
"                                                                         onDblClick=\"history('vt');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\"><br>");
        }
        if (modelcontent.indexOf("[TAG][ARTICLE_CONTENT][/ARTICLE_CONTENT][/TAG]") != -1) {
        //    out.write("��������<input type=text><br>");
        }
        if (modelcontent.indexOf("[TAG][ARTICLE_AUTHOR][/ARTICLE_AUTHOR][/TAG]") != -1) {
            out.write("��������(<a href=\"javascript:upload_attrpic_onclick('au')\">ͼ</a>)<input class=tine name=author id=\"author\"\n" +
"                                                                        size=10 onDblClick=\"history('au');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\"><br>");
        }
        if (modelcontent.indexOf("[TAG][ARTICLE_SOURCE][/ARTICLE_SOURCE][/TAG]") != -1) {
            out.write("������Դ(<a href=\"javascript:upload_attrpic_onclick('sr')\">ͼ</a>)<input class=tine name=source id=\"source\"\n" +
"                                                                        size=10 onDblClick=\"history('sr');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\"><br>");
        }
        if (modelcontent.indexOf("[TAG][ARTICLE_KEYWORD][/ARTICLE_KEYWORD][/TAG]") != -1) {
            out.write("���¹ؼ���<input class=tine name=keyword size=30><br>");
        }
        //if (modelcontent.indexOf("[TAG][ARTICLEPIC]����ͼƬ[/ARTICLEPIC][/TAG]") != -1) {
            out.write("<font color=\"#FF0000\"><b>����ͼƬ</b></font>(<a href=\"javascript:upload_attrpic_onclick('apic')\">ͼ</a>)<input\n" +
"            class=tine name=\"articlepic\" id=\"articlepic\" size=20 onDblClick=\"history('apic');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\">&nbsp;&nbsp;<br>");
      //  }
        if (modelcontent.indexOf("[TAG][ARTICLE_SUMMARY][/ARTICLE_SUMMARY][/TAG]") != -1) {
            out.write("���¸���<textarea cols=\"60\" rows=\"2\" id=\"summaryID\" name=\"summary\"></textarea><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_BIGPIC]��Ʒ��ͼƬ[/PRODUCT_BIGPIC][/TAG]") != -1) {
            out.write("��ͼƬ(<a href=\"javascript:upload_attrpic_onclick('bigpic')\">ͼ</a>)��<input class=tine name=bigpic id=\"bigpic\"\n" +
"                                                                              size=12 onDblClick=\"history('bigpic');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\"><br>");
        }

        if (modelcontent.indexOf("[TAG][PRODUCT_PIC]��ƷСͼƬ[/PRODUCT_PIC][/TAG]") != -1) {
            out.write("��ƷСͼƬ(<a href=\"javascript:upload_attrpic_onclick('pic')\">ͼ</a>)��\n" +
"        <input class=tine name=pic id=\"pic\" size=12\n" +
"                                                                          onDblClick=\"history('pic');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\"><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_BRAND]��Ʒ������[/PRODUCT_BRAND][/TAG]") != -1) {
            out.write("��Ʒ������<input class=tine name=brand size=12><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_WEIGHT]��Ʒ����[/PRODUCT_WEIGHT][/TAG]") != -1) {
            out.write("��Ʒ����<input class=tine name=weight size=5><br>");
        }

        if (modelcontent.indexOf("[TAG][PRODUCT_STOCK]��Ʒ���[/PRODUCT_STOCK][/TAG]") != -1) {
            out.write("��Ʒ���<input class=tine name=inprice size=6><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_MARKETPRICE]��Ʒ�г���[/PRODUCT_MARKETPRICE][/TAG]") != -1) {
            out.write("��Ʒ�г���<input class=tine name=marketprice size=6><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_INPRICE]��Ʒ����[/PRODUCT_INPRICE][/TAG]") != -1) {
            out.write("��Ʒ����<input class=tine name=inprice size=6><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_VIPPRICE]VIP�ۼ�[/PRODUCT_VIPPRICE][/TAG]") != -1) {
            out.write("vip�ۼ�<input class=tine name=vipprice size=6><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_SALEPRICE]��Ʒ�ۼ�[/PRODUCT_SALEPRICE][/TAG]") != -1) {
            out.write("��Ʒ�ۼ�<input class=tine name=saleprice size=6><br>");
        }
        if (modelcontent.indexOf("[TAG][PRODUCT_SCORE]����[/PRODUCT_SCORE][/TAG]") != -1) {
            out.write("����<input class=tine name=score size=6><br>");
        }

        if (modelcontent.indexOf("[TAG][PRODUCT_VOUCHER]���Ѿ�[/PRODUCT_VOUCHER][/TAG]") != -1) {
            out.write("���Ѿ�<input class=tine name=voucher size=6><br>");
        }


        List list = umnpeer.getColumntemplatexml(column.getXMLTemplate());
      //  System.out.println("xml=" + column.getXMLTemplate()+"   list="+list.size());
        List textList = new ArrayList();
        List areaList = new ArrayList();
        for(int i=0;i<list.size();i++)
        {
            ExtendAttr ext=(ExtendAttr)list.get(i);
            String ename=ext.getEName();
            String cname=ext.getCName();
            if(modelcontent.indexOf("[TAGA]["+ename+"]"+cname+"[/"+ename+"][/TAGA]")!=-1)
            {
                out.write(extendMgr.getArticleTemplateExtendAttrForArticle(columnID,0,ext));
            }
            //System.out.println("ename="+ext.getEName());
        }
       List listnewscontent= umnpeer.getImgAllContent(modelcontent);
       for(int i=0;i<listnewscontent.size();i++)
       {
           String newcontent=(String)listnewscontent.get(i);
           if(modelcontent.indexOf(newcontent)!=-1)
           {
              // System.out.println(""+modelcontent);
               String str=newcontent.substring(newcontent.indexOf("[CHINESENAME]")+"[CHINESENAME]".length(),newcontent.indexOf("[/CHINESENAME]"));
               String width=newcontent.substring(newcontent.indexOf("[WIDTH]")+"[WIDTH]".length(),newcontent.indexOf("[/WIDTH]"));
               String height=newcontent.substring(newcontent.indexOf("[HEIGHT]")+"[HEIGHT]".length(),newcontent.indexOf("[/HEIGHT]"));

              // System.out.println("str="+str+  newcontent+"    0000");
               String orderstr=newcontent.substring(newcontent.indexOf("[ORDER]")+"[ORDER]".length(),newcontent.indexOf("[/ORDER]"));
               out.write(str+":(<a href=\"javascript:upload_attrpic_onclick('"+orderstr+"')\">ͼ</a>)<input\n" +
"            class=tine name=\""+orderstr+"\" id=\""+orderstr+"\" size=20 onDblClick=\"history('apic');\"\n" +
"        title=\"˫������������ѡ����ʷͼƬ\">&nbsp;&nbsp;<br>");
           }
       }
       //ƥ������
         List listtextnewscontent= umnpeer.getTextAllContent(modelcontent);
       for(int i=0;i<listtextnewscontent.size();i++)
       {
           String newcontent=(String)listtextnewscontent.get(i);
           if(modelcontent.indexOf(newcontent)!=-1)
           {
              // System.out.println(""+modelcontent);
               String str=newcontent.substring(newcontent.indexOf("[CHINESENAME]")+"[CHINESENAME]".length(),newcontent.indexOf("[/CHINESENAME]"));
              // String width=newcontent.substring(newcontent.indexOf("[WIDTH]")+"[WIDTH]".length(),newcontent.indexOf("[/WIDTH]"));
              // String height=newcontent.substring(newcontent.indexOf("[HEIGHT]")+"[HEIGHT]".length(),newcontent.indexOf("[/HEIGHT]"));

               System.out.println("str="+str+  newcontent+"    0000");
               String orderstr=newcontent.substring(newcontent.indexOf("[ORDER]")+"[ORDER]".length(),newcontent.indexOf("[/ORDER]"));
               out.write(str+":<textarea\n" +
"            class=tine name=\""+orderstr+"\" id=\""+orderstr+"\" size=20 onDblClick=\"history('apic');\"\n" +
"        ></textarea>&nbsp;&nbsp;<br>");
           }
       }



       out.write("<br><input class=tine type=button value=\"  ����  \" onclick=\"create(createForm);\">&nbsp;&nbsp;\n" +
"            <input class=tine type=button value=\"  ȡ��  \" onclick=\"cal();\">&nbsp;&nbsp;</form>");
      } catch (Exception e) {
            System.out.println(""+e.toString());
        out.write("no  article");
    }
%>
</body>
</html>