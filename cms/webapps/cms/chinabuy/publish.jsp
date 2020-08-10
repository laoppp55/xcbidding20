<%@ page import="java.util.*,
                 com.bizwink.cms.publish.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
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
    IPublishWMLManager publishWmlMgr = PublishWMLPeer.getInstance();
    IArticleManager articleMgr = ArticlePeer.getInstance();

    for (int i = 0; i < count; i++) {
        int articleID = ParamUtil.getIntParameter(request, "selected" + i, 0);
        isown = ParamUtil.getBooleanParameter(request, "isown" + i);
        if (articleID > 0) {
            boolean isTemplate = ParamUtil.getBooleanParameter(request, "template" + i);
            if (isTemplate)    //���·���ҳ���ύ /publish/articles.jsp
            {                  //����ʧ��ҳ���ύ /publish/publishfailed.jsp
                columnID = ParamUtil.getIntParameter(request, "column" + i, 0);
                int type = ParamUtil.getIntParameter(request, "type" + i, 0);
                if (type == 1) {
                    retcode = publishMgr.CreateArticlePage(articleID, siteid,samsiteid, appPath, sitename, username, imgflag, option);
                } else if (type == 0) {        //������Ŀҳ��
                    retcode = publishMgr.CreateColPage(columnID, siteid,samsiteid, appPath, sitename, username, imgflag, option, articleID);

                    //�����Ҫ����RSS������RSS
                    Column column = columnMgr.getColumn(currentID);
                    if (column.getRss() == 1) {
                        RssMaker rm = new RssMaker();
                        rm.createRss(siteid, currentID, column, appPath, username, sitename);
                    }
                } else if (type == 2) {        //����WEB��ҳ
                    retcode = publishMgr.createHomePage(siteid,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                } else if (type == 3) {        //����WEBר��ҳ��
                    retcode = publishMgr.CreateColPage(columnID, siteid,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                } else if (type == 4) {        //����WAP��Ŀҳ��
                    retcode = publishWmlMgr.CreateColPageForWML(columnID, siteid, appPath, sitename, username, imgflag, option, articleID);
                }

                if (columnMgr.getColumn(columnID).getParentID() == 0) {
                    retcode = publishMgr.createHomePage(siteid,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                } else {
                    retcode = publishMgr.CreateColPage(columnID, siteid,samsiteid, appPath, sitename, username, imgflag, option, articleID);
                }
            } else {       //��������                
                columnID = ParamUtil.getIntParameter(request, "column" + i, 0);
                retcode = publishMgr.CreateArticlePage(articleID, siteid,samsiteid, appPath, sitename, username, imgflag, option, isown, columnID);
            }
        }
    }

    if (source == 2)  //ģ�����ҳ���ύ /template/templates.jsp
    {
        int templateID = ParamUtil.getIntParameter(request, "template", 0);
        int modelType = ParamUtil.getIntParameter(request, "modelType", -1);
        columnID = ParamUtil.getIntParameter(request, "column", 0);
        System.out.println("columnID=" + columnID);
        if (modelType == 2) {    //������ҳ
            retcode = publishMgr.createHomePage(siteid,samsiteid, appPath, sitename, username, imgflag, option, templateID);
        } else if (modelType == 0) {
            retcode = publishMgr.CreateColPage(currentID, siteid,samsiteid, appPath, sitename, username, imgflag, option, templateID);

            //�����Ҫ����RSS������RSS
            Column column = columnMgr.getColumn(currentID);
            if (column.getRss() == 1) {
                RssMaker rm = new RssMaker();
                rm.createRss(siteid, currentID, column, appPath, username, sitename);
            }
        } else if (modelType == 3) {
            retcode = publishMgr.CreateColPage(currentID, siteid,samsiteid, appPath, sitename, username, imgflag, option, templateID);

            //�����Ҫ����RSS������RSS
            Column column = columnMgr.getColumn(currentID);
            if (column.getRss() == 1) {
                RssMaker rm = new RssMaker();
                rm.createRss(siteid, currentID, column, appPath, username, sitename);
            }
        } else if (modelType == 4) {
            retcode = publishWmlMgr.CreateColPageForWML(columnID, siteid, appPath, sitename, username, imgflag, option, templateID);
        } else if(modelType >= 10) {
            retcode = publishMgr.CreateProgramPage(currentID,siteid,samsiteid,appPath,sitename,username,imgflag,option,templateID);
        }
    }

    if (source == 3)   //���±༭����ҳ���ύ /article/article.jsp
    {
        int articleID = ParamUtil.getIntParameter(request, "article", 0);
        retcode = publishMgr.CreateArticlePage(articleID, siteid,samsiteid, appPath, sitename, username, imgflag, option, isown, currentID);
    }
    if (source == 1)         //���·���
        response.sendRedirect("republish.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
    else if (source == 2)    //����ģ��
        if (currentID > 0)           //����ģ��
            response.sendRedirect("../template/templates.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range + "&templateName=" + templateName);
        else                        //��������ģ��
            response.sendRedirect("../template/templatesforprogram.jsp?column="+currentID+"&msgno="+retcode+"&start="+start+"&range="+range);
    else if (source == 3)    //��������
        response.sendRedirect("articles.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
    else if(source == 4)     //����ʧ�ܵ�����
        response.sendRedirect("publishfailed.jsp?column=" + currentID + "&msg=" + retcode + "&start=" + start + "&range=" + range);
    else                     //��������
        response.sendRedirect("articles.jsp?column=" + currentID + "&msgno=" + retcode + "&start=" + start + "&range=" + range);
%>