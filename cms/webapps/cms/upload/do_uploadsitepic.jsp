<%@ page import="java.sql.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*,
		 com.jspsmart.upload.*,
		 com.bizwink.cms.util.*" contentType="text/html;charset=utf-8"%>
<%  ////////////////////////////////
    // Retreive parameters
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    if (authToken.getUserID().compareToIgnoreCase("admin") != 0) {
        request.setAttribute("message", "无系统管理员的权限");
        response.sendRedirect("../index.jsp");
        return;
    }

    String baseDir = request.getRealPath("/");
    String dir = baseDir + java.io.File.separator + "sitespic" + java.io.File.separator;
    boolean error = false;
    String filename = "";
    int siteid = 0;
    int startnum = 0;
    int doUpload = 0;

    SmartUpload mySmartUpload = new SmartUpload();
    mySmartUpload.initialize(this.getServletConfig(),request,response);
    com.jspsmart.upload.File  tmpFile = null;
    try {
        mySmartUpload.upload();
        siteid = Integer.parseInt(mySmartUpload.getRequest().getParameter("site"));
        startnum = Integer.parseInt(mySmartUpload.getRequest().getParameter("startnum"));
        doUpload = Integer.parseInt(mySmartUpload.getRequest().getParameter("doUpload"));
        tmpFile = mySmartUpload.getFiles().getFile(0);
        filename = tmpFile.getFileName();
        String picType = tmpFile.getContentType().substring(1);

        //简体文件
        java.io.File dirFile = new java.io.File( dir );
        if ( !dirFile.exists()) {
            dirFile.mkdirs();
        }
        mySmartUpload.save(dir);
    }catch ( Exception e ) {
        System.out.println(e.getMessage());
        error = true;
    }

    //System.out.println("doUpload=" + doUpload);
    //System.out.println("startnum=" + startnum);
    //System.out.println("siteid=" + siteid);
    //System.out.println("error=" + error);
    if(doUpload==1 && !error) {
        IRegisterManager regMgr = RegisterPeer.getInstance();
        regMgr.update_sitepic(siteid,filename);
    }
%>
<html>
<head>
    <script language="javascript">
        function refreshlist() {
            opener.location.href="../member/siteManage.jsp?startnum=" + "<%=startnum%>";
            window.close();
        }
    </script>
</head>
<body onload="javascript:refreshlist()">
</body>
</html>
