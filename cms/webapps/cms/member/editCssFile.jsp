<%@ page import="java.util.*,
	 	 java.io.*,
                 com.bizwink.cms.server.*,
		 com.bizwink.cms.security.*,
                 com.bizwink.cms.publish.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken == null)
  {
    response.sendRedirect( "../login.jsp" );
    return;
  }
  if (!SecurityCheck.hasPermission(authToken,54))
  {
    request.setAttribute("message","�޹����û���Ȩ��");
    response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
    return;
  }

  String msg = null;
  String content = "";
  String sitename = authToken.getSitename();
  String path = ParamUtil.getParameter(request, "path");
  
  String dirName = path.substring(path.indexOf(sitename)+sitename.length(), path.length());
  dirName = StringUtil.replace(dirName, File.separator, "/");
  
  path = StringUtil.replace(path, "/", File.separator);
  String filename = ParamUtil.getParameter(request, "filename");
  boolean doUpdate = ParamUtil.getBooleanParameter(request, "doUpdate");
  
  //�����ļ�����
  if (doUpdate)
  {
    int pubflag = ParamUtil.getIntParameter(request, "pubflag", 0);
    content = ParamUtil.getParameter(request, "content");
    String oldFile = ParamUtil.getParameter(request, "oldFile");
    if (filename!=null && filename.trim().length()>0 && content!=null && content.trim().length()>0)
    {
      File file = new File(path+filename);
      if (!file.exists() || oldFile.equalsIgnoreCase(filename))
      {
        PrintWriter pw = new PrintWriter(new FileOutputStream(path+filename));
        pw.write(content.trim());
        pw.close();

        if (pubflag == 1)
        {
          IPublishManager publishMgr = PublishPeer.getInstance();
          publishMgr.publish(authToken.getUserID(), path+filename,authToken.getSiteID(), dirName, 0);
        }

        if (!oldFile.equalsIgnoreCase(filename))
        {
          File file1 = new File(path+oldFile);
          if (file1.exists()) file1.delete();
        }

        out.println("<script language=javascript>");
        out.println("opener.history.go(0);");
        out.println("window.close();");
        out.println("</script>");
        return;
      }
      else
      {
        msg = "<span class=line align=center>�ļ�����</span>";
      }
    }
  }

  //�����ļ�����
  try
  {
    File file = new File(path+filename);
    if (file.exists())
    {
      BufferedReader br = new BufferedReader(new FileReader(path+filename));
      String s = null;
      while ((s=br.readLine()) != null)
      {
        content = content + s + "\n";
      }
      br.close();
    }
  }
  catch (Exception e)
  {
    e.printStackTrace();
  }
%>

<html>
<head>
<title>��Ƭ����--�޸�CSS�ļ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language="javascript">
function check()
{
  var name = document.editForm.filename.value;
  var extname = name.substring(name.indexOf(".")+1, name.length);
  if (name == "")
  {
    alert("�ļ�������Ϊ�գ�");
    return false;
  }
  if (extname.toLowerCase() != "css")
  {
    alert("�ļ�����ʽ����ȷ��");
    return false;
  }
  if (document.editForm.content.value == "")
  {
    alert("CSS���ݲ���Ϊ�գ�");
    return false;
  }
  return true;
}
</script>
</head>

<body bgcolor="#CCCCCC">
<form method="POST" action="editCssFile.jsp" name="editForm" onsubmit="javascript:return check();">
<input type=hidden name=doUpdate value=true>
<input type=hidden name=oldFile value="<%=filename%>">
<input type=hidden name="path" value="<%=path%>">
<%if (msg != null) out.println(msg);%>
  <table border="0" width="100%">
    <tr height=50>
      <td width="10%" align=center>�ļ����ƣ�</td>
      <td width="90%">
        <input type="text" name="filename" size="30" value="<%=filename%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="pubflag" value="1" checked> ��Ҫ����
      </td>
    </tr>
    <tr>
      <td align=center valign=top>�ļ����ݣ�</td>
      <td><textarea rows="25" name="content" cols="82"><%=content%></textarea></td>
    </tr>
    <tr height="40">
      <td width="100%" colspan="2" align=center>
        <input type="submit" value="  ����  " name="submit">&nbsp;&nbsp;&nbsp;
        <input type="button" value="  ȡ��  " name="cancel" onclick="javascript:window.close();">
      </td>
    </tr>
  </table>
</form>

</body>
</html>