<%@ page import="java.sql.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.publish.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!");
        return;
    }

    int siteID = authToken.getSiteID();
    int samsiteid = authToken.getSamSiteid();
    int imgFlag = authToken.getImgSaveFlag();
    String baseURL = "http://" + request.getHeader("host") + "/webbuilder/";
    String appPath = application.getRealPath("/");
    String sitename = authToken.getSitename();
    int articleID = ParamUtil.getIntParameter(request, "article", 0);
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    IPublishManager publishManager = PublishPeer.getInstance();

    try {
        String result = publishManager.PreviewArticlePage(articleID, siteID,samsiteid, baseURL, appPath, sitename, imgFlag, columnID);

        if (result == "err1")
            out.println(StringUtil.iso2gb("����Ŀû������ģ�壬��Ϊ������ģ��"));
        else if (result == "err2")
            out.println(StringUtil.iso2gb("��ȡģ��ʱ���ݿ�ϵͳ���ִ���"));
        else if (result == "articleerror")
            out.println(StringUtil.iso2gb("��ȡ��Ʒʱ���ִ���"));
        else
            out.println(StringUtil.gb2iso4View(result));
    }
    catch (PublishException e) {
        e.printStackTrace();
    }
%>