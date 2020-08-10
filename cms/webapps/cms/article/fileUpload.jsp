<%@page import="java.io.*,
                java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.news.*,
                com.bizwink.cms.publish.*,
                com.jspsmart.upload.*"
                contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  String username = authToken.getUserID();
  String sitename = authToken.getSitename();
  int siteID = authToken.getSiteID();
  boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
	String filename = ParamUtil.getParameter(request, "filename");
  int columnID = ParamUtil.getIntParameter(request, "column", 0);

  IColumnManager columnMgr = ColumnPeer.getInstance();
  Column column = columnMgr.getColumn(columnID);
  String dirName = column.getDirName();

  if (doCreate)
  {
    SmartUpload mySmartUpload = new SmartUpload();
    mySmartUpload.initialize(this.getServletConfig(), request, response);
    mySmartUpload.upload();

    com.jspsmart.upload.Files uploadFiles = mySmartUpload.getFiles();
    com.jspsmart.upload.File tempFile = uploadFiles.getFile(0);
    filename = tempFile.getFileName();

    String uploadPath = application.getRealPath("/") + "sites" + java.io.File.separator + sitename +
            java.io.File.separator + "download" + java.io.File.separator;

    java.io.File file = new java.io.File(uploadPath);
    if (!file.exists())
    {
      file.mkdirs();
    }

    mySmartUpload.save(uploadPath);

    //������WEB������
    String objDir = dirName + "download/";
    IPublishManager publishMgr = PublishPeer.getInstance();
    int retcode = publishMgr.publish(username, uploadPath+filename, siteID, objDir, 0);
    if (retcode != 0)
    {
      out.println("��WEB�����������ļ�ʧ�ܣ�");
      return;
    }
	  out.println("<script language=javascript>opener.createForm.filename.value='"+filename+"';window.close();</script>");
    return;
  }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link REL="stylesheet" TYPE="text/css" HREF="../style/global.css">
<title>�ļ��ϴ�</title>
<script language=javascript>
function check()
{
  if (document.uploadForm.filename.value == "")
  {
    alert("��ѡ���ϴ��ļ���");
    return false;
  }
  else
  {
    return true;
  }
}
</script>
</head>
<body bgcolor="#cccccc">
<FORM METHOD=POST ACTION="fileUpload.jsp?column=<%=columnID%>&doCreate=true" NAME="uploadForm" onsubmit="return check();" enctype="multipart/form-data">
<table width="100%" align=center border=0>
<%if (filename != null){%>
  <tr height=20>
    <td align=center>ԭ�ļ���Ϊ��<%=filename%></td>
  </tr>
<%}%>
  <tr height=45>
    <td align=center>�����ļ���<input type=file name="sfilename" size=30></td>
  </tr>
  <tr height=45>
    <td align=center>�����ļ���<input type=file name="tfilename" size=30></td>
  </tr>
  <tr height=60>
    <td align=center>
      <input type=submit value="  �ϴ�  " class=tine>&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="  ȡ��  " class=tine onclick="window.close();">
    </td>
  </tr>
</table>
</FORM>

</body>
</html>
