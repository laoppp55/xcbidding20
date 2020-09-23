<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/27
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.bizwink.cms.news.Column,
                 com.bizwink.cms.news.ColumnPeer,
                 com.bizwink.cms.news.IColumnManager,
                 com.bizwink.cms.util.ParamUtil"
         contentType="text/html;charset=utf-8"
%>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="com.bizwink.cms.publish.IPublishManager" %>
<%@ page import="com.bizwink.cms.publish.PublishPeer" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="com.bizwink.cms.security.*" %>

<%
    request.setCharacterEncoding("utf-8");
    String session_value = ParamUtil.getParameter(request,"session");
    JSONObject jsStr = JSONObject.parseObject(session_value);
    Auth authToken = null;
    IAuthManager authManager = AuthPeer.getInstance();
    String userID = jsStr.getString("userID");
    String nickname = jsStr.getString("nickname");
    String sitename = jsStr.getString("sitename");
    int siteid=jsStr.getInteger("siteid");
    int samsiteid = jsStr.getInteger("samsiteid");
    int sitetype = jsStr.getInteger("sitetype");
    int sharetemplatenum = jsStr.getInteger("sharetemplatenum");
    int trypassnum = jsStr.getInteger("trypassnum");
    int errcode = jsStr.getInteger("errcode");
    int imgSaveFlag = jsStr.getInteger("imgSaveFlag");
    int cssjsDir = jsStr.getInteger("cssjsDir");
    int publishFlag = jsStr.getInteger("publishFlag");
    int listShow = jsStr.getInteger("listShow");
    int tagSite = jsStr.getInteger("tagSite");
    int copyColumn = jsStr.getInteger("copyColumn");
    int beCopyColumn = jsStr.getInteger("beCopyColumn");
    int pushArticle = jsStr.getInteger("pushArticle");
    int moveArticle = jsStr.getInteger("moveArticle");
    int orgid = jsStr.getInteger("orgid");
    int companyid = jsStr.getInteger("companyid");
    int deptid = jsStr.getInteger("deptid");
    PermissionSet permissionSet = authManager.getPermissionSetByUserid(userID);
    RolesSet roleSet = authManager.getRolesSetByUserid(userID,siteid);

    authToken = new Auth(null, null, null, null, userID, nickname, sitename, siteid, samsiteid, sitetype, sharetemplatenum, imgSaveFlag, cssjsDir,
            publishFlag, listShow, errcode, tagSite, copyColumn, beCopyColumn, pushArticle, moveArticle, orgid, companyid, deptid, permissionSet, roleSet);
    session.setAttribute("CmsAdmin", authToken);
    session.setMaxInactiveInterval(60*60*1000);

    /*Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    Enumeration enu=request.getParameterNames();
    while(enu.hasMoreElements()){
        String paraName=(String)enu.nextElement();
        System.out.println(paraName+": "+request.getParameter(paraName));
    }*/

    int encodeflag = 0;
    String username = authToken.getUserID();
    int siteID = authToken.getSiteID();
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    //判断是从工具棒上传视频文件还是从视频输入框上传视频文件
    int fromflag = ParamUtil.getIntParameter(request, "fromflag", 0);
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    if (columnID == 0) {
        String idstr = (String) session.getAttribute("createtemplate_columnid");
        if ((idstr != null) && (!idstr.equals("null")) && (!idstr.equals("")))
            columnID = Integer.parseInt(idstr);
    }

    IColumnManager columnMgr = ColumnPeer.getInstance();
    Column column = columnMgr.getColumn(columnID);
    String dirName = column.getDirName();
    String newfilename = "";
    String newname = "";
    String filename = "";

    System.out.println("doCreate==" + doCreate);

    if (doCreate) {
        try {
            String uploadPath = application.getRealPath("/") + "sites" + java.io.File.separator + sitename + dirName + "images" + java.io.File.separator;
            uploadPath = StringUtil.replace(uploadPath, "/", java.io.File.separator);
            java.io.File file = new java.io.File(uploadPath);
            if (!file.exists()) {
                file.mkdirs();
            }

            DiskFileItemFactory fac = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(fac);
            List uploadlist=upload.parseRequest(request);
            Iterator iter=uploadlist.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (!item.isFormField()) {
                    filename = item.getName();
                    if (!filename.equals("")) {
                        filename = FilenameUtils.getName(filename);
                        System.out.println("多媒体文件：" + filename);
                        int posi = filename.lastIndexOf(".");
                        String ext = null;
                        if (posi > -1) ext = filename.substring(posi + 1);

                        if (!ext.equalsIgnoreCase("flv"))
                            newfilename = username + String.valueOf(System.currentTimeMillis()) + "." + ext;
                        else
                            newfilename = username + String.valueOf(System.currentTimeMillis()) + ".flv";

                        String savepath = uploadPath + newfilename;
                        File saveFilepath = new File(savepath);
                        item.write(saveFilepath);
                        newname = newfilename.substring(0, newfilename.lastIndexOf(".")) + ".flv";

                        //如果上传的是FLV格式的文件，则直接将该文件发布到WEB服务器
                        if (ext.equalsIgnoreCase("flv")) {
                            IPublishManager publishMgr = PublishPeer.getInstance();
                            int errcode1 = publishMgr.publish(username, savepath, siteID, dirName + "images" + File.separator, 0);
                        }
                    }
                } else {
                    System.out.println(item.getFieldName() + "===" + item.getString());
                }
            }
        }catch(Exception ex){
            ex.printStackTrace();
            System.out.println("程序发生错误，抛出异常为 "+ex.getMessage());
        }

        out.println(newname + ":" + filename);
        out.flush();
        return;
    }
%>