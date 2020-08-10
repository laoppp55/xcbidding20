<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.SmartUploadException" %>
<%@ page import="com.bizwink.webapps.survey.define.IDefineManager" %>
<%@ page import="com.bizwink.webapps.survey.define.DefinePeer" %>
<%@ page import="com.bizwink.webapps.survey.define.Define" %>
<%@ page import="com.bizwink.webapps.survey.define.DefineException" %>
<%@ page import="java.io.File" %>

<%
  //�ϴ�ͼƬ
  com.jspsmart.upload.SmartUpload mySmartUpload = new com.jspsmart.upload.SmartUpload();
  mySmartUpload.initialize(pageContext);
  mySmartUpload.setMaxFileSize(5 * 1024 * 1024);

  try {
    //�����ļ�
    mySmartUpload.upload();
  } catch (Exception e) {
    e.printStackTrace();
  }

  String sid = mySmartUpload.getRequest().getParameter("sid");
  String qid = mySmartUpload.getRequest().getParameter("qid");
  String aid = mySmartUpload.getRequest().getParameter("aid");
  String myFileName = "";

  //ȡ���������ص��ļ�
  if (mySmartUpload.getFiles().getCount() > 0) {
    //ȡ�����ص��ļ�
    com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
    if (!myFile.isMissing()) {
      long createtime = System.currentTimeMillis();
      //ȡ�ú�׺��
      String ext = myFile.getFileExt();
      myFileName = String.valueOf(createtime) + "." + ext;

      if ((ext.equalsIgnoreCase("gif")) || (ext.equalsIgnoreCase("jpg")) || (ext.equalsIgnoreCase("jpeg")) || (ext.equalsIgnoreCase("bmp"))) {
        //����·��
         String path = application.getRealPath("/");
        String trace = path + File.separator + "sites"+File.separator +"answerspic" + File.separator + myFileName;

        //���ļ������ڷ�������
        try {
          myFile.saveAs(trace);
        } catch (SmartUploadException e) {
          e.printStackTrace();
        }
      }
      mySmartUpload.stop();
      mySmartUpload = null;
    }
  }

  IDefineManager defineMgr = DefinePeer.getInstance();
  Define define = new Define();
  //�����
  define.setSid(Integer.parseInt(sid));
  define.setQid(Integer.parseInt(qid));
  define.setPicurl(myFileName);
  try {
    defineMgr.createDefinePicAnswer(define);
  } catch (DefineException e) {
    e.printStackTrace();
  }

  response.sendRedirect("addPAnswer.jsp?success=1&sid=" + sid + "&qid=" + qid);
%>