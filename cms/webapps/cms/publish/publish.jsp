<%@ page import="java.util.*,
                 com.bizwink.cms.publish.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=utf-8"
        %>
<%@ page import="com.bizwink.cms.refers.Refers" %>
<%@ page import="com.bizwink.cms.refers.RefersPeer" %>
<%@ page import="com.bizwink.cms.refers.IRefersManager" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int currentID = ParamUtil.getIntParameter(request, "column", 0);
    int count = ParamUtil.getIntParameter(request, "count", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int source = ParamUtil.getIntParameter(request, "source", 0);
    boolean isown = ParamUtil.getBooleanParameter(request, "isown");
    int retcode = 1;
    int columnID = 0;

    String username = authToken.getUserID();
    String sitename = authToken.getSitename();
    int siteid = authToken.getSiteID();
    int sitetype = authToken.getSitetype();
    int samsiteid = authToken.getSamSiteid();

    int imgflag = authToken.getImgSaveFlag();
    int option = authToken.getPublishFlag();
    String appPath = application.getRealPath("/");
    String templateName = ParamUtil.getParameter(request, "templateName");
    if (templateName == null)
        templateName = "";
    else
        templateName = StringUtil.gb2iso(templateName);

    IPublishManager publishMgr = PublishPeer.getInstance();
    IColumnManager columnMgr = ColumnPeer.getInstance();
    IRefersManager refersManager = RefersPeer.getInstance();

    for (int i = 0; i < count; i++) {
        int articleID = ParamUtil.getIntParameter(request, "selected" + i, 0);
        isown = ParamUtil.getBooleanParameter(request, "isown" + i);
        if (articleID > 0) {
            boolean isTemplate = ParamUtil.getBooleanParameter(request, "template" + i);
            if (isTemplate) {    //文章发布页面提交 /publish/articles.jsp    发布失败页面提交 /publish/publishfailed.jsp
                columnID = ParamUtil.getIntParameter(request, "column" + i, 0);
                int type = ParamUtil.getIntParameter(request, "type" + i, 0);
                if (type == 1) {                           //1--发布文章，如果栏目设置多模板发布标志，有一个文章模板发布几套信息
                    retcode = publishMgr.CreateArticlePage(articleID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag,option,isown,columnID);
                } else if (type == 0 || type==4) {        //0--发布PC栏目页面  4--发布手机栏目模板
                    retcode = publishMgr.CreateColPage(columnID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleID);

                    //如果需要发布RSS，发布RSS
                    Column column = columnMgr.getColumn(currentID);
                    if (column.getRss() == 1) {
                        RssMaker rm = new RssMaker();
                        rm.createRss(siteid, currentID, column, appPath, username, sitename);
                    }
                } else if (type == 2 || type==5) {        //2--发布PC首页模板   5--发布手机首页模板
                    retcode = publishMgr.createHomePage(siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                } else if (type == 3  || type==6) {        //3--发布PC专题页面，6--智能手机专题页面
                    retcode = publishMgr.CreateColPage(columnID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                }

                /*if (columnMgr.getColumn(columnID).getParentID() == 0) {
                    retcode = publishMgr.createHomePage(siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                } else {
                    retcode = publishMgr.CreateColPage(columnID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                }*/
            } else {       //发布文章
                columnID = ParamUtil.getIntParameter(request, "column" + i, 0);
                System.out.println("isown==" + isown);
                retcode = publishMgr.CreateArticlePage(articleID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, isown, columnID);
                //如果文章被其它栏目引用，而且是内容引用，发布引用栏目的文章和模板
                List<Refers> refersList = refersManager.getRefersArticleContentByColumn(articleID,columnID,siteid);
                for(int jj=0; jj<refersList.size(); jj++) {
                    Refers refer = refersList.get(jj);
                    columnID = refer.getColumnid();
                    retcode = publishMgr.CreateArticlePage(articleID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, false, columnID);
                    System.out.println(refer.getTitle() + "==" + columnID);
                }
            }
        }
    }

    if (source == 2){  //模板管理页面提交 /template/templates.jsp
        int templateID = ParamUtil.getIntParameter(request, "template", 0);
        int modelType = ParamUtil.getIntParameter(request, "modelType", -1);
        columnID = ParamUtil.getIntParameter(request, "column", 0);

        if (modelType == 2 || modelType == 5) {    //发布首页或者手机首页模板
            retcode = publishMgr.createHomePage(siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, templateID);
        } else if (modelType == 0 || modelType == 4) {
            retcode = publishMgr.CreateColPage(currentID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, templateID);
            //如果需要发布RSS，发布RSS
            Column column = columnMgr.getColumn(currentID);
            if (column.getRss() == 1) {
                RssMaker rm = new RssMaker();
                rm.createRss(siteid, currentID, column, appPath, username, sitename);
            }
        } else if (modelType == 3 || modelType == 6) {      //发布专题模板
            retcode = publishMgr.CreateColPage(currentID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, templateID);

            //如果需要发布RSS，发布RSS
            Column column = columnMgr.getColumn(currentID);
            if (column.getRss() == 1) {
                RssMaker rm = new RssMaker();
                rm.createRss(siteid, currentID, column, appPath, username, sitename);
            }
        } else if(modelType >= 10) {
            retcode = publishMgr.CreateProgramPage(currentID,siteid,sitetype,samsiteid,appPath,sitename,username,imgflag,option,templateID);
        }
    }

    if (source == 1)  {       //重新发布
        response.sendRedirect("republish.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
    } else if (source == 2)  {              //发布模板
        if (currentID > 0)  {                //发布模板
            response.sendRedirect("/webbuilder/template1/templates.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
        } else {                            //发布程序模板
            response.sendRedirect("/webbuilder/template1/templatesforprogram.jsp?column="+currentID+"&msgno="+retcode+"&start="+start+"&range="+range);
        }
    } else if (source == 3)   {            //发布文章,文章编辑管理页面提交 /article/article.jsp
        int articleID = ParamUtil.getIntParameter(request, "article", 0);
        columnID = ParamUtil.getIntParameter(request, "column", 0);
        System.out.println("articleID=" + articleID);
        System.out.println("siteid=" + siteid);
        System.out.println("sitetype=" + sitetype);
        System.out.println("samsiteid=" + samsiteid);
        System.out.println("appPath=" + appPath);
        System.out.println("sitename=" + sitename);
        System.out.println("username=" + username);
        System.out.println("imgflag=" + imgflag);
        System.out.println("option=" + option);
        System.out.println("columnID=" + columnID);
        retcode = publishMgr.CreateArticlePage(articleID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, isown, currentID);
        //如果文章被其它栏目引用，而且是内容引用，发布引用栏目的文章和模板
        List<Refers> refersList = refersManager.getRefersArticleContentByColumn(articleID,columnID,siteid);
        for(int jj=0; jj<refersList.size(); jj++) {
            Refers refer = refersList.get(jj);
            columnID = refer.getColumnid();
            retcode = publishMgr.CreateArticlePage(articleID, siteid,sitetype,samsiteid, appPath, sitename, username, imgflag, option, false, columnID);
        }
        response.sendRedirect("../article1/articles.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
    } else if(source == 4)   {  //发布失败的文章
        response.sendRedirect("publishfailed.jsp?column=" + currentID + "&msg=" + retcode + "&start=" + start + "&range=" + range);
    } else {                     //正常发布
        response.sendRedirect("articles.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
    }
%>