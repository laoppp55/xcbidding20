<%@ page import="java.sql.*,
                 java.util.*,
                 com.bizwink.cms.tree.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }

  int columnID  = ParamUtil.getIntParameter(request, "column", 0);
  String sitename = authToken.getSitename();
  String baseDir = application.getRealPath("/");
  String rootDir = baseDir + "sites" + java.io.File.separator + sitename + java.io.File.separator + "_templates" + java.io.File.separator;
  System.out.println("rootDir==" + rootDir);
  Tree dirTree = TreeManager.getInstance().getDirTree(rootDir);         //��ȡ�ڷ����������ɵ�һ����
  node[] treeNodes = dirTree.getAllNodes();                             //��ȡ���������нڵ�
  String parentMenuName[] = new String[dirTree.getNodeNum()];           //�洢ĳ���ڵ�������ӽڵ�ĸ��˵�����
  String parentMenu="menu";                                             //�洢��ǰ�ڵ�ĸ��˵�����
  String menuName = "menu";                                             //�洢��ǰ�ڵ�Ĳ˵�����
  int currentID = 0;                                                    //��ǰ���ڴ���Ľڵ�
  int i=0,j=0;                                                          //ѭ������
  int[] ordernum = new int[dirTree.getNodeNum()];                       //��ǰ�ڵ������ӽڵ��˳���
  int orderNumber = 0;                                                  //��ǰ�ڵ���ͬ���ڵ��˳���
  int subflag = 1;                                                      //�жϵ�ǰ�ڵ��Ƿ����ӽڵ�
  StringBuffer buf = new StringBuffer();                                //�洢���ɵĲ˵���

  for (i=0; i< dirTree.getNodeNum(); i++)
  {
    currentID = i;

    //���õ�ǰ����ڵ�ĳ�ʼֵ
    if(currentID != 0){
      parentMenu = parentMenuName[i];
      orderNumber = ordernum[i];
      menuName = "menu"+currentID;
    }

    //�Ӵ���Ľڵ�������ȡ����ǰ���ڴ����Ԫ�أ����Ҹ�Ԫ���µ���Ԫ��
    //���������ӽڵ�ĸ��˵����ƣ����������ӽڵ�����кţ������е��ӽڵ����pid������
    subflag = 0;
    for(j=0; j<dirTree.getNodeNum(); j++) {
      if(treeNodes[j].getLinkPointer() == currentID) {
        parentMenuName[j] = menuName;
        ordernum[j] = subflag;
        subflag = subflag + 1;
      }
    }

    //�����ǰ�ڵ����ӽڵ㣬���ɵ�ǰ�ڵ�Ĳ˵�
    if (subflag != 0) {
      buf.append("var "+menuName+" = null;\n");
      buf.append(menuName+" = new MTMenu();\n");
    }
    for(j=0;j<dirTree.getNodeNum();j++) {
      if(treeNodes[j].getLinkPointer() == currentID) {
        int id = treeNodes[j].getId();
        String path = dirTree.getFileSystemDirName(dirTree,id);
        String name  = "<font class=line>"+treeNodes[j].getEnName() + "</font>";
        buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
        buf.append(name).append("\",\"listfile.jsp?path=" + path +  "&column=" + columnID + "\"" + "));");
        buf.append("\n");
      }
    }

    //������ǰ�˵������ĸ��˵�
    if(subflag != 0 && currentID != 0)
      buf.append(parentMenu+".items["+orderNumber+"].MTMakeSubmenu(" + menuName + ");\r\n");
  }
  System.out.println(buf.toString());
%>
<html>
<head>
<title></title>
<link rel=stylesheet type="text/css" href="../style/global.css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script type="text/javascript" src="../js/mtmcode.js"></script>
<script type="text/javascript">
var needDrag = 0;
<%
  if (buf.length() == 0)
  {
    buf.append("var menu = null;\n");
    buf.append("menu = new MTMenu();\n");
  }
  out.println(buf.toString());
%>
</script>
<BODY onload="MTMStartMenu(true)" leftMargin=0 topMargin=0 MARGINHEIGHT="0" MARGINWIDTH="0">
</BODY></html>