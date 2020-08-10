<%@ page import="java.util.*,
                  java.io.*,
                 java.sql.Timestamp,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.publish.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.upload.*,
                 com.bizwink.net.ftp.*,
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

  String dirName = "";
  int siteID = authToken.getSiteID();
  int columnID = ParamUtil.getIntParameter(request, "columnID", 0);
  if (columnID == 0)
  {
    dirName = "/";
  }
  else
  {
    Tree colTree = null;
    if (authToken.getUserID().equalsIgnoreCase("admin"))
      colTree = TreeManager.getInstance().getTree();
    else
      colTree = TreeManager.getInstance().getSiteTree(siteID);
    if (columnID == colTree.getTreeRoot())
      dirName = "/";
    else
      dirName = colTree.getDirName(colTree, columnID);
  }
  String sitename = StringUtil.replace(authToken.getSitename(), "_", ".");
  if (dirName.indexOf(sitename) != -1)
  {
    dirName = StringUtil.replace(dirName, "/"+sitename, "");
  }

  String path = request.getRealPath("/") + "sites" + File.separator + authToken.getSitename() +
                StringUtil.replace(dirName,"/",File.separator) + "images" + File.separator;
  String path1 = StringUtil.replace(path, File.separator, "/");

  //�������ļ�
  String name = ParamUtil.getParameter(request, "filename");
  if (name != null && name.trim().length() > 0)
  {
    IPublishManager publishMgr = PublishPeer.getInstance();
    int code = publishMgr.publish(authToken.getUserID(),path+name,siteID,dirName+"images/",0);
    if (code == 0)
      response.sendRedirect("includeFile.jsp?columnID="+columnID+"&msg="+name+StringUtil.gb2iso("�����ɹ�!"));
    else
      response.sendRedirect("includeFile.jsp?columnID="+columnID+"&msg="+name+StringUtil.gb2iso("����ʧ��!"));
    return;
  }

  //action=1�������а����ļ��� action=2����ĳһ�������ļ�
  int action = ParamUtil.getIntParameter(request, "action", 0);
  if (action == 1 || action == 2)
  {
    int count = 0;
    IPullContentManager pullContentMgr = PullContentPeer.getInstance();
    int pubWay = pullContentMgr.getPublishWay(siteID);

    if (pubWay == 0)    //FTP��ʽ
    {
      PullContent pullContent = pullContentMgr.getSiteInfo(siteID);
      String siteIP = pullContent.getSiteIP();
      String username = pullContent.getFtpUser();
      String password = pullContent.getFtpPasswd();

      FTPClient ftp = new FTPClient(siteIP, 21);
      ftp.login(username, password);
      ftp.chdir("/");

      try
      {
        ftp.chdir(dirName + "images/");
      }
      catch (FTPException f)
      {
        if (f.getReplyCode() == 550)
          ftp.mkdir(dirName + "images/");
      }

      ftp.setType(FTPTransferType.ASCII);
      if (action == 1)
      {
        String[] filename = ftp.dir(dirName + "images/", true);
        for (int i=0; i<filename.length; i++)
        {
          String temp = filename[i].substring(0, filename[i].indexOf(" "));
          if (temp.equals("total")) continue;
          String fname = filename[i].substring(filename[i].lastIndexOf(" ")+1,filename[i].length());

          if (fname.indexOf(".") > 0)
          {
            String ext = fname.substring(fname.lastIndexOf(".")+1,fname.length()).toLowerCase();
            if (ext.equals("css"))
            {
              ftp.get(path + fname, fname);
              count++;
            }
          }
        }
      }
      else
      {
        String file_name = ParamUtil.getParameter(request, "file_name");
        ftp.get(path + file_name, file_name);
        count++;
      }
      ftp.quit();
    }
    else    //���ط�ʽ
    {
      PullContent pullContent = pullContentMgr.getSiteInfo(siteID);
      String docPath = pullContent.getDocPath();
      if (docPath.substring(docPath.length()-1,docPath.length()).equals(File.separator))
      {
        docPath = docPath.substring(0, docPath.length()-1);
      }

      String newPath = docPath + StringUtil.replace(dirName, "/", File.separator) +
                       "images" + File.separator;
      if (action == 1)
      {
        File file = new File(newPath);
        if (file.exists())
        {
          File[] files = file.listFiles();
          for (int i=0; i<files.length; i++)
          {
            if (files[i].isFile())
            {
              String filename = files[i].getName();
              if (filename.indexOf(".") > 0)
              {
                String ext = filename.substring(filename.indexOf(".")+1,filename.length());
                if (ext.equalsIgnoreCase("css"))
                {
                  count++;
                  FileDeal.copy(newPath + filename, path + filename, 0);
                }
              }
            }
          }
        }
      }
      else
      {
        String file_name = ParamUtil.getParameter(request, "file_name");
        FileDeal.copy(newPath + file_name, path + file_name, 0);
        count++;
      }
    }
    response.sendRedirect("includeFile.jsp?columnID="+columnID+"&msg="+StringUtil.gb2iso("�������� ")+count+StringUtil.gb2iso(" ���ļ���"));
    return;
  }

  //��������CSS�ļ�
  List list = new ArrayList();
  File file = new File(path);
  if (file.exists())
  {
    File[] files = file.listFiles();
    for (int i=0; i<files.length; i++)
    {
      if (files[i].isFile())
      {
        String filename = files[i].getName();
        if (filename.indexOf(".") > 0)
        {
          String extname = filename.substring(filename.indexOf(".")+1,filename.length());
          if (extname.equalsIgnoreCase("css"))
          {
            String[] arr = new String[3];
            arr[0] = filename;
            arr[1] = String.valueOf(files[i].length());
            arr[2] = String.valueOf(new Timestamp(files[i].lastModified())).substring(0,19);
            list.add(arr);
          }
        }
      }
    }
  }

  String msg = ParamUtil.getParameter(request,"msg");
%>

<html>
<head>
<title>��Ƭ����--CSS�ļ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
<script language="javascript">
function CreateFile()
{
  window.open("createCssFile.jsp?path=<%=path1%>","CreateFile","width=700,height=500,left=50,top=50");
}

function EditFile(filename)
{
  window.open("editCssFile.jsp?path=<%=path1%>&filename="+filename,"EditFile","width=700,height=500,left=50,top=50");
}

function PublishFile(filename)
{
  var retval = confirm("��ȷ��Ҫ������");
  if (retval)
    window.location = "includeFile.jsp?columnID=<%=columnID%>&filename="+filename;
}

function getAllFile()
{
  var retval = confirm("��ȷ��Ҫ��������CSS�ļ���");
  if (retval)
    window.location = "includeFile.jsp?columnID=<%=columnID%>&action=1";
}

function getFile(filename)
{
  var retval = confirm("��ȷ��Ҫ���ظ��ļ���");
  if (retval)
    window.location = "includeFile.jsp?columnID=<%=columnID%>&action=2&file_name="+filename;
}
</script>
</head>

<body>
<%
  String[][] titlebars = {
    { "ϵͳ����", "../main.jsp" },
    { "CSS�ļ�", "" }
  };
  String[][] operations = {
    {"����CSS", "javascript:CreateFile();"},
    {"��ʽ�ļ�", "javascript:parent.location='listStyle.jsp'"},
    {"�����ļ�", "javascript:parent.location='fragManage.jsp'"},
    {"ϵͳ����", "javascript:parent.location='index.jsp'"}
  };
%>
<%@ include file="../inc/titlebar.jsp" %>
<table border=0 width="100%"><tr><td width="50%"><font class=line>CSS�ļ��б�</font></td><td width="50%">
<%if (msg != null) out.println("<span class=cur>"+msg+"</span>");%></td></tr></table>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
<tr bgcolor="#eeeeee" class=tine>
   <td width="5%"  align=center>���</td>
   <td width="20%" align=center><b>�ļ�����</b></td>
   <td width="15%" align=center>�ļ�����</td>
   <td width="15%" align=center>�ļ���С</td>
   <td width="20%" align=center>�޸�����</td>
   <td width="8%" align=center>�޸�</td>
   <td width="8%" align=center>����</td>
   <td width="9%" align=center>����</td>
</tr>
<%
  for (int i=0; i<list.size(); i++)
  {
    String[] arr = (String[])list.get(i);
    String bgcolor = (i%2==0)?"#ffffcc":"#eeeeee";
%>
<tr bgcolor="<%=bgcolor%>" height=22>
   <td align=center><font color=red><%=i+1%></font></td>
   <td>&nbsp;&nbsp;<%=arr[0]%></td>
   <td align=center>CSS&nbsp;����</td>
   <td align=center><%=arr[1]%>&nbsp;Bytes</td>
   <td align=center><%=arr[2]%></td>
   <td align=center><a href="javascript:EditFile('<%=arr[0]%>');"><img src="../images/edit.gif" border=0></a></td>
   <td align=center><a href="javascript:PublishFile('<%=arr[0]%>');"><img src="../images/edit.gif" border=0></a></td>
   <td align=center><a href="javascript:getFile('<%=arr[0]%>');"><img src="../images/edit.gif" border=0></a></td>
</tr>
<%}%>
<tr><td colspan=8 align=right height=40><input type=button name=getFile value=��������CSS�ļ� onclick="getAllFile();">&nbsp;</td></tr>
</table>
</body>
</html>