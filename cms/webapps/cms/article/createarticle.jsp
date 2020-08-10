<%@ page import="java.sql.*,
                 java.io.*,
                 java.util.*,
                 org.jdom.*,
                 org.jdom.input.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="com.bizwink.cms.multimedia.Multimedia" %>
<%@ page import="com.bizwink.cms.multimedia.Attechment" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="com.bizwink.util.SendDataToSJH" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.net.http.Post" %>
<%@ page import="com.bizwink.cms.server.CmsServer" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.bizwink.images.Uploadimage" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!--%@ taglib uri="/FCKeditor" prefix="FCK" %-->

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean errorTitle = false;
    boolean errorContent = false;
    boolean errors = false;
    boolean success = false;
    int siteid = authToken.getSiteID();
    String username = authToken.getUserID();
    String sitename = authToken.getSitename();
    sitename = StringUtil.replace(sitename,".","_");
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    session.setAttribute("createtemplate_columnid", String.valueOf(columnID));
    String maintitle = null, vicetitle = null, content = null, summary = null, keyword = null, source = null,attechments=null,articlepic = null, author = null, brand = null,
            s_publishtime=null,pic = null, bigpic = null, relatedID = null, filename = null,mediafilename=null,mediafile=null, otherurl = null,beidate=null,markid="-1";
    int docLevel = 0, viceLevel = 0, sortid = 0, status = 0, subscriber = 0, stocknum = 0, modelID = 0, urltype = 0,score=0,voucher=0,changepic=0;
    float saleprice = 0f, inprice = 0f, marketprice = 0f,istype=0f,vipprice=0f,weight = 0f;
    int notearticleid = 0;

    Calendar today = Calendar.getInstance();
    today.setTimeInMillis(System.currentTimeMillis());
    SimpleDateFormat dtformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    //�����Ŀ��Ϣ
    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String uploadPath = application.getRealPath("/") + "sites" + java.io.File.separator + sitename + column.getDirName() + "images" + java.io.File.separator;
    int isDefine = column.getDefineAttr();
    int isProduct = column.getIsProduct();
    int isAudited = column.getIsAudited();
    int isPosition = column.getIsPosition();                                   //�Ƿ��������λ����Ϣ
    markid=ParamUtil.getParameter(request,"markid");
    List mmfiles = new ArrayList();                       //�����а����Ķ�ý���ļ��б�
    List pubcolumns = new ArrayList();                    //������Ϣ������Ŀ����Ŀ
    List recommends = new ArrayList();                    //�������±��Ƽ���λ��
    String figures = null;                                //���µĸ���ͼƬ��Ϣ��һ��json�ַ���
    if (doCreate) {
        maintitle = filter.excludeHTMLCode(ParamUtil.getParameter(request, "maintitle"));
        maintitle = (maintitle != null) ? maintitle.trim() : maintitle;
        vicetitle = filter.excludeHTMLCode(ParamUtil.getParameter(request, "vicetitle"));
        content = ParamUtil.getParameter(request, "content");
        author = filter.excludeHTMLCode(ParamUtil.getParameter(request, "author"));
        summary = filter.excludeHTMLCode(ParamUtil.getParameter(request, "summary"));
        keyword = filter.excludeHTMLCode(ParamUtil.getParameter(request, "keyword"));
        source = filter.excludeHTMLCode(ParamUtil.getParameter(request, "source"));
        relatedID = filter.excludeHTMLCode(ParamUtil.getParameter(request, "relatedID"));
        docLevel = ParamUtil.getIntParameter(request, "docLevel", 0);
        viceLevel = ParamUtil.getIntParameter(request, "viceDocLevel", 0);
        subscriber = ParamUtil.getIntParameter(request, "subscriber", 1);
        sortid = ParamUtil.getIntParameter(request, "sortid", 0);
        filename = ParamUtil.getParameter(request, "filename");
        modelID = ParamUtil.getIntParameter(request, "modelID", 0);
        status = ParamUtil.getIntParameter(request, "status", 1);
        figures = ParamUtil.getParameter(request, "picinfos");
        attechments = ParamUtil.getParameter(request, "attechments");
        notearticleid = ParamUtil.getIntParameter(request, "notesArticle", 1);
        mediafile = ParamUtil.getParameter(request, "media");                      //����Ƶ�Ի����ϴ�����Ƶ�ļ�
        mediafilename = ParamUtil.getParameter(request, "mediafilename");        //�ӹ��߰�����ϴ���Ƶ�ļ���ť�ϴ�����Ƶ�ļ�
        //System.out.println("mediafilename===" + mediafilename);
        if (mediafilename != null) {
            mediafilename = mediafilename.substring(0,mediafilename.length()-1);
            if (!mediafilename.endsWith(".flv")) status = 3;              //����´��������°�����ý���ļ������Ҷ�ý���ļ���չ����Ϊflv,�����ļ���״̬Ϊ3����ʾ���´��ڵȴ�״̬���ɶ�ý��ת�������޸ĸ�״̬
            Pattern p = Pattern.compile("\\|", Pattern.CASE_INSENSITIVE);
            String mmf[] = p.split(mediafilename);
            Multimedia mult = null;
            for(int i=0;i<mmf.length;i++) {
                mult = new Multimedia();
                mult.setSiteid(siteid);
                mult.setDirname(column.getDirName());
                mult.setFilepath(uploadPath);
                int posi = mmf[i].indexOf(":");
                mult.setOldfilename(mmf[i].substring(posi + 1).trim());
                mult.setNewfilename(mmf[i].substring(0,posi).trim());
                mult.setEncodeflag(0);
                mmfiles.add(mult);
            }
        }
        recommends = ParamUtil.getSelectParameterAllNamesAndValues(request, "recommend");
        pubcolumns = ParamUtil.getSelectParameterAllNamesAndValues(request, "pubcolumns");
        articlepic = ParamUtil.getParameter(request, "articlepic");
        urltype = ParamUtil.getIntParameter(request, "url", 0);
        otherurl = ParamUtil.getParameter(request, "aurl");
        beidate=ParamUtil.getParameter(request,"beidate");
        s_publishtime = ParamUtil.getParameter(request,"datetime");
        changepic = ParamUtil.getIntParameter(request,"changepic",0);
        pic = ParamUtil.getParameter(request, "pic");
        bigpic = ParamUtil.getParameter(request, "bigpic");

        if (isProduct == 1) {
            brand = ParamUtil.getParameter(request, "brand");
            weight = ParamUtil.getFloatParameter(request, "weight", 0);
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
            if(content.indexOf("/_commons/FLVPlayer_Progressive.swf")>0)
                article.setMultimediatype(1);
            else
                article.setMultimediatype(0);
            article.setMediafile(mediafile);
            article.setAuthor(author);
            article.setSummary(summary);
            article.setKeyword(keyword);
            article.setSortID(sortid);
            article.setRelatedArtID(relatedID);
            article.setPubFlag(1);
            article.setSource(source);
            article.setEditor(username);
            article.setCreator(username);
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
            article.setNotes(notearticleid);
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
            article.setChangepic(changepic);
            if(beidate!=null){
                article.setBbdate(Date.valueOf(beidate));
            }
            article.setProductPic(pic);
            article.setProductBigPic(bigpic);
            article.setMarkid(markid);
            if (isProduct == 1) {
                article.setSalePrice(saleprice);
                article.setInPrice(inprice);
                article.setMarketPrice(marketprice);
                article.setBrand(brand);
                article.setProductWeight(weight);
                article.setStockNum(stocknum);
                article.setVIPPrice(vipprice);
                article.setScore(score);
                article.setVoucher(voucher);
            }
            if (s_publishtime == null)
                article.setPublishTime(new Timestamp(System.currentTimeMillis()));
            else {
                Timestamp publishtime = new Timestamp(dtformat.parse(s_publishtime).getTime());
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
                            int controltype = Integer.parseInt(e.getAttributeValue("type"));

                            extend.setEName(ename);
                            extend.setDataType(dataType);
                            extend.setControlType(controltype);
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

            List<Attechment> attechmentList=null;
            if (attechments!=null && attechments!="") {
                String json_attechments = "[" +  attechments + "]";
                JSONArray json = JSONArray.fromObject(json_attechments);                   //json_attechments��json�ַ���
                attechmentList= (List<Attechment>) JSONArray.toCollection(json, Attechment.class);
            }

            //�����ֻ�ͼƬ
            List<Uploadimage> uploadimages = null;
            if (figures!=null && figures!="") {
                JSONObject jsonObject = JSONObject.fromObject(figures.substring(1,figures.length()-1));
                JSONArray json = JSONArray.fromObject(figures);
                uploadimages = (List<Uploadimage>)JSONArray.toCollection(json,Uploadimage.class);
            }
            //attechments   �����б�
            //pubcolumns    ������Ҫ��������Ŀ�б�
            //recommends    ���±��Ƽ��ı��λ��
            //auditlist     ¼������������Ϣ�б�
            List auditlist = (List)session.getAttribute("audit_article");
            extendMgr.create(attrList,attechmentList,article,pubcolumns,recommends,uploadimages,auditlist,mmfiles);
            success = true;

            if (sitename.equalsIgnoreCase("sjh.egreatwall.com")) {
                SendDataToSJH sendDataToSJH = new SendDataToSJH();
                String sjh_content = sendDataToSJH.MakeTheXMLFromSection(attrList, attechmentList, article, columnID);
                String posturl="http://ec.egreatwall.com/m/peripheralDataCollectAction.do";
                //String posturl="http://160103j5c8.iask.in/m/peripheralDataCollectAction.do";//post��ַ
                String sr= Post.sendPost(posturl, "data=" + URLEncoder.encode(sjh_content, "utf-8"));
                //System.out.println(sr);
                //OutputStreamWriter out1 = new OutputStreamWriter(new FileOutputStream("C:\\cms\\111.xml"), "utf-8");
                //out1.write(sjh_content);
                //out1.flush();
                //out1.close();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
            errors = true;
        }
    }

    if (success) {
        session.removeAttribute("turn_pic");
        session.removeAttribute("articletypeids");
        response.sendRedirect(response.encodeRedirectURL("../article/closewin.jsp?column=" + columnID + "&id=" + article.getID() + "&fromflag=c"));
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>��������</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link REL="stylesheet" TYPE="text/css" HREF="../style/editor.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/themes/icon.css">

    <script language="JavaScript" src="../js/setday.js"></script>
    <script language="JavaScript" src="../js/cities.js"></script>
    <script language="JavaScript" src="../toolbars/dhtmled.js"></script>
    <script type="text/javascript" src="../toolbars/btnclick<%=CmsServer.lang%>.js"></script>
    <script type="text/javascript" src="../fckeditor/fckeditor.js"></script>
    <script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
    <script language=javascript>
        $(document).ready(function() {
            init('province','city');
        })

        function Editor(ename)
        {
            window.open("editor.jsp?column=<%=columnID%>&ename=" + ename, "Editor", "width=870,height=600,left=0,top=0,status");
        }

        function upload_attrpic_onclick(attrname)
        {
            window.open("../upload/upload.jsp?column=<%=columnID%>&attr=" + attrname, "", 'width=400,height=400,left=200,top=200');
        }

        //˫��ѡ�����·���
        function addarticletype() {
            window.open("selectarticletype.jsp?column=<%=columnID%>", "", "top=100,left=100,width=420,height=360");
        }

        //ѡ�����µ�ID��ΪȨ��  jj
        function AddRelatedArticleID(para) {
            var winStr = "addRelatedArticle.jsp?from=1&param=" + para+"&column=<%=columnID%>";
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

        //���Ƽ������б��Ƽ�����
        function recommendArticle() {
            var winStr = "recommendArticle.jsp?column=<%=columnID%>";
            var iWidth=800;                                                 //�������ڵĿ��;
            var iHeight=600;                                                //�������ڵĸ߶�;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open(winStr, "recommend_window", "width=" + iWidth +",height=" + iHeight +",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
        }

        //��������Ŀ��������
        function AddPubColumns() {
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

        //ѡ������ģ��
        function selectArticleModel() {
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

        function create(createForm) {
            // alert(document.getElementById("markid").value);
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
            if (!checkFloat(createForm.weight.value))
            {
                alert("��Ʒ����ӦΪ���������ݣ�");
                createForm.weight.focus();
                return;
            }
            <%}%>
            <%if (isDefine == 1){%>
            if (!checkExtendAttr(createForm))
                return;
            <%}%>

            for (var i = 0; i < createForm.recommendID.length; i++) {
                createForm.recommendID[i].selected = true;
            }

            for (var i = 0; i < createForm.pcolumnsID.length; i++) {
                createForm.pcolumnsID[i].selected = true;
            }

            createForm.submit();
        }

        function checkFloat(str) {
            var retstr = false;
            var regstr = /[^0-9.]/gi;
            if (regstr.exec(str) == null)
            {
                retstr = true;
            }
            return retstr;
        }

        function checkInt(str) {
            var retstr = false;
            var regstr = /[^0-9]/gi;
            if (regstr.exec(str) == null)
            {
                retstr = true;
            }
            return retstr;
        }

        //˫��ѡ����ʷͼƬ
        function history(attrname) {
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

        function delItem() {
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

        function useMyUrl(f) {
            if (f == 1)
                createForm.aurl.disabled = 0;
            else
                createForm.aurl.disabled = 1;
        }

        function upload_turn_pic(){
            //window.open("../upload/uploadpicsForArticle.jsp?column=<%=columnID%>", "", 'width=800,height=600,left=200,top=200,status,scrollbars');
            window.open("../upload/upload_turn_pic.jsp?column=<%=columnID%>", "", 'width=900,height=600,left=20,top=20,status,scrollbars');
        }
        function upload_batcbh_pic(){
            var retval = window.showModalDialog("../upload/picbatch.jsp?template_or_article="+ parent.window.document.createForm.template_or_article_flag.value, "", 'width=800,height=600,left=200,top=200,status,scrollbars');
            if (retval != "" && retval != undefined)
            {
                document.getElementById("batchpic").value=retval;
            }

        }
        function upload_media_onclick() {
            window.open("../upload/mmupload.jsp?column=<%=columnID%>&fromflag=1", "", 'width=600,height=400,left=200,top=200');
        }

        function fileUploadList(createForm) {
            window.open('fileUploadList.jsp?column=<%=columnID%>', '', 'left=300,top=200,width=400,height=200');
        }

        function articleList(id,columnid) {
            var winStr = "../template/articlelistFrame.jsp?articleid="+id;
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                var retval = showModalDialog(winStr, window, "font-family:Verdana; font-size:12; dialogWidth:800px; dialogHeight:600px; status=no");
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

        function article_audit(){
            window.open("article_audit.jsp", "", 'width=800,height=600,left=200,top=200,status,scrollbars');
        }

        function getMoreType(columnid,itemnum,ename) {
            var rows = Math.ceil(itemnum/4);       //ÿ�з�4��ѡ��,����ȡ��������С���ͼ�1
            var iHeight = rows*50;
            var iWidth = 4*50;
            //��ô��ڵĴ�ֱλ��
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            //��ô��ڵ�ˮƽλ��
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var current_values = eval("createForm." + ename).value;
            var result = window.showModalDialog("getMoretypes.jsp?column="+columnid + "&textval="+current_values + "&ename="+ename,"","dialogLeft:" + iLeft + "dialogTop:" + iTop + "dialogHeight:" + iHeight + "dialogWidth:" + iWidth + "status:no; help:no;scroll:no");
            var nodes = eval('(' + result + ')');
            var textval = "";
            var values = "";
            for(var ii=0; ii<nodes.length; ii++) {
                textval = textval + nodes[ii].name + ",";
                values = values + nodes[ii].value + ",";
            }
            if (textval.length>0) {
                textval = textval.substring(0,textval.length-1);
                eval("createForm." + ename + "txt").value = textval;
            }
            if (values.length>0) {
                values = values.substring(0,values.length-1);
                eval("createForm." + ename).value = values;
            }
        }
    </script>

</head>
<body>
<form action=createarticle.jsp method=post name=createForm>
    <input type=hidden name=doCreate value="true">
    <input type=hidden name=column value="<%=columnID%>">
    <input type=hidden name=filename>
    <input type=hidden name=attechments value="">
    <input type=hidden name=picinfos value="">
    <input type=hidden name=modelSourceCodeFlag value=0>
    <input type=hidden name=template_or_article_flag value="1">
    <input type=hidden name=mediafilename value="">
    <input type=hidden name=markid id="markid" value="-1">
    <input type=hidden name=msword id="mswordid" value="">

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
                <!--input class=tine type=button value="  �����ϴ�  " onclick="fileUploadList(createForm);">&nbsp;&nbsp;-->
                <input class=tine type=button value="  ����  " onclick="create(createForm);">&nbsp;&nbsp;
                <input class=tine type=button value="  ȡ��  " onclick="cal();">&nbsp;&nbsp;
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
                <%=(isProduct==1)?"��Ʒ����":"����"%>(<a href="javascript:upload_attrpic_onclick('mt');">ͼ</a>)<input class=tine name=maintitle id="maintitle"
                                                                                                                size=36 onDblClick="history('mt');"
                                                                                                                title="˫������������ѡ����ʷͼƬ">
                <%=(isProduct==1)?"��Ʒ���":"������"%>(<a href="javascript:upload_attrpic_onclick('vt')">ͼ</a>)<input class=tine name=vicetitle
                                                                                                                id="vicetitle" size=20
                                                                                                                onDblClick="history('vt');"
                                                                                                                title="˫������������ѡ����ʷͼƬ">
                ����(<a href="javascript:upload_attrpic_onclick('au')">ͼ</a>)<input class=tine name=author id="author"
                                                                                  size=10 onDblClick="history('au');"
                                                                                  title="˫������������ѡ����ʷͼƬ">
                ��Դ(<a href="javascript:upload_attrpic_onclick('sr')">ͼ</a>)<input class=tine name=source id="source"
                                                                                  size=10 onDblClick="history('sr');"
                                                                                  title="˫������������ѡ����ʷͼƬ">
                �ؼ���(;)<input class=tine name=keyword size=30>
                <%=(isProduct==1)?"��ʾģ��":"����ģ��"%><input class=tine name=modelID id="modelID" size=8 value=0 title="˫�����������ɵ���ģ��ѡ��ҳ��"
                                                        onDblClick="selectArticleModel();">
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class=line>
                <%=(isProduct==1)?"��ƷժҪ":"ժҪ"%><!--input class=tine name=summary size=80-->
                <textarea cols="80" rows="3" id="summaryID" name="summary"></textarea>

                <a href=javascript:AddPubColumns();>������Ŀ</a>��
                <select size=3 name="pubcolumns" id="pcolumnsID" style="width:150" multiple></select>

                <a href=javascript:recommendArticle();>�Ƽ�</a>:
                <select size=3 name="recommend" id="recommendID" style="width:150" multiple></select>
            </td>
        </tr>
        <%if (isProduct == 1) {%>
        <tr bgcolor="#eeeeee">
            <td class=line>
                �ۼۣ�<input class=tine name=saleprice size=6>&nbsp;&nbsp;
                VIP�ۣ�<input class=tine name=vipprice size=6>&nbsp;&nbsp;
                ���ۣ�<input class=tine name=inprice size=6>&nbsp;&nbsp;
                �г��ۣ�<input class=tine name=marketprice size=6>&nbsp;&nbsp;
                ���֣�<input class=tine name=score size=6>&nbsp;&nbsp;
                �����<input class=tine name=voucher size=6>&nbsp;&nbsp;
                ��棺<input class=tine name=stocknum size=6>&nbsp;&nbsp;
                ���̣�<input class=tine name=brand size=20>&nbsp;&nbsp;
                ����ʽ��<input class=tine name=buyway size=20><br/>&nbsp;&nbsp;
                ������<input class=tine name=weight size=5>&nbsp;&nbsp;
                ��λ��<input class=tine name=uint size=5>&nbsp;&nbsp;
            </td>
        </tr>
        <%}%>
        <%if (isDefine == 1) {%>
        <%if ((isProduct == 0 && isPosition==0) || (isProduct == 1 && isPosition==1)) {%>
        <tr bgcolor="#eeeeee">
                <%} else { %>
        <tr bgcolor="#ffffff">
            <%}%>
            <td class=line><%=extendMgr.getExtendAttrForArticle(columnID, 0)%>
            </td>
        </tr>
        <%}%>
        <tr bgcolor="#eeeeee">
            <td class=line>
                �������ڣ�<input type=text  class="easyui-datetimebox" name="datetime" value="<%=dtformat.format(today.getTime())%>" style="width:200px">
                ����<input class=tine name="sortid" size=4 value=0>&nbsp;&nbsp;
                ��Ȩ�أ�<input class=tine id="docLevel" name="docLevel" size=4 value="0"
                           maxlength="6" onDblClick="AddRelatedArticleID(0);"
                           title="˫������������ѡ��ĳƪ����ID��Ϊ��ƪ���µ�Ȩ��">&nbsp;&nbsp;
                ��Ȩ�أ�<input class=tine id="viceDocLevel" name="viceDocLevel" size=4
                           value="0" maxlength="6"
                           onDblClick="AddRelatedArticleID(1);"
                           title="˫������������ѡ��ĳƪ����ID��Ϊ��ƪ���µĴ�Ȩ��">&nbsp;&nbsp;
                <%=(isProduct==1)?"����Ʒ":"������"%>��<input name="relatedID" size="4" id="relatedID"
                                                       onDblClick="AddRelatedArticleID(2);"
                                                       title="˫�����������ɵ���������ѡ��ҳ��">&nbsp;&nbsp;
                ���ģ�<input type=radio checked name="subscriber" value="1">��<input
                    type=radio name="subscriber" value="0">��&nbsp;&nbsp;
            </td>
        </tr>
        <tr bordercolor="#CCCCCC" bgcolor="#CCCCCC">
            <td class=line>
                �Զ���URL<input type=radio checked name="url" value="0" onclick="useMyUrl(0);">��
                <input type=radio name="url"  value="1" onclick="useMyUrl(1);">��
                <%=(isProduct==1)?"��ƷURL":"����URL"%><input type=text class=tine name=aurl size=31 disabled>&nbsp;&nbsp;
                <%if (isProduct == 0) {%>
                <!--font color="#FF0000"><b>ʹ��</b></font><input type=radio checked name="status" value="1">��<input
                    type=radio name="status" value="0">��<input type=radio name="status" value="2">�鵵&nbsp;&nbsp;-->
                <%=(isProduct==1)?"��Ʒ״̬":"����״̬"%>��<select name="status" size="1" style="width:60;font-size:9pt">
                <option value="1" selected>ʹ��</option>
                <option value="2" >�鵵</option>
                <option value="6" >�</option>
                <option value="0">δ��</option>
            </select>
                <%} else {%>
                <%=(isProduct==1)?"��Ʒ״̬":"����״̬"%>��<select name="status" size="1" style="width:60;font-size:9pt">
                <option value="1" selected>����</option>
                <option value="4" >����</option>
                <option value="5" >��Ʒ</option>
                <option value="6" >�</option>
                <option value="2" >�鵵</option>
                <option value="0">�¼�</option>
            </select>
                <%}%>
            </td>
        </tr>
        <tr bordercolor="#eeeeee" bgcolor="#eeeeee">
            <td>
                ��ЧͼƬ(<a href="javascript:upload_attrpic_onclick('apic')">ͼ</a>)<input
                    class=tine name="articlepic" id="articlepic" size=20 onDblClick="history('apic');"
                    title="˫������������ѡ����ʷͼƬ">&nbsp;&nbsp;

                СͼƬ(<a href="javascript:upload_attrpic_onclick('pic')">ͼ</a>)��<input class=tine name=pic id="pic" size=12
                                                                                     onDblClick="history('pic');"
                                                                                     title="˫������������ѡ����ʷͼƬ">&nbsp;&nbsp;

                ��ͼƬ(<a href="javascript:upload_attrpic_onclick('bigpic')">ͼ</a>)��<input class=tine name=bigpic id="bigpic"
                                                                                        size=12 onDblClick="history('bigpic');"
                                                                                        title="˫������������ѡ����ʷͼƬ">&nbsp;&nbsp;

                ��Ƶ�ļ�(<a href="javascript:upload_media_onclick()">��Ƶ</a>)��<input class=tine name=media id="mediaid" value="" size=30>&nbsp;&nbsp;

                <input type=button name=articletype id=turnpic size=30 value="��ͼ" onclick="javascript:upload_turn_pic();">&nbsp;&nbsp;
                <input type=button name=articletype id=attfiles size=30 value="����" onclick="javascript:upload_attachments();">
            </td>
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
        out.println("</script>");
    }
%>
</body>
</html>