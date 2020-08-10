<%@ page import="java.util.*,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.security.*,
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
    request.setAttribute("message","无管理用户的权限");
    response.sendRedirect("editMember.jsp?user="+authToken.getUserID());
    return;
  }

  //读出所有文章列表样式文件
  int siteID = authToken.getSiteID();
  int type = ParamUtil.getIntParameter(request, "type", 0);
  boolean doDelete = ParamUtil.getBooleanParameter(request, "doDelete");
  IViewFileManager fileMgr = viewFilePeer.getInstance();

  if (doDelete)
  {
    int ID = ParamUtil.getIntParameter(request, "ID", 0);
    fileMgr.delete(ID);
    response.sendRedirect("listStyle.jsp?type="+type);
  }

  List list = new ArrayList();
  if (type > 0)
  {
    list = fileMgr.getViewFileC(siteID, type);
  }
%>

<html>
<head>
  <title></title>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <link rel="stylesheet" type="text/css" href="../style/global.css">
  <script language="javascript">
      function EditStyle(type, styleID) {
          var siteID = <%=siteID%>;
          if (siteID > 0){
              if (type == 1 || type == 3 || type == 4) {
                  var iWidth = 1000;
                  var iHeight = 600;
                  var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                  var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                  var win = window.open("../template1/editStyle.jsp?ID=" + styleID + "&type=" + type + "&from=system", "updateStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                  //var retstr = showModalDialog("../template/editStyle.jsp?ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:650px;dialogHeight:440px;status:no");
              }else if (type == 6) {
                  var iWidth = 1000;
                  var iHeight = 600;
                  var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                  var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                  var win = window.open("../template1/editColumnStyle.jsp?ID=" + styleID + "&type=" + type + "&from=system", "updateStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                  //var retstr = showModalDialog("../template/editColumnStyle.jsp?ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:500px;dialogHeight:420px;status:no");
              }else {
                  var iWidth = 1000;
                  var iHeight = 600;
                  var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                  var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                  var win = window.open("../template1/editOtherStyle.jsp?ID=" + styleID + "&type=" + type + "&from=system", "updateStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                  //var retstr = showModalDialog("../template/editOtherStyle.jsp?ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
              }
          }else {
              if (type == 1 || type == 3 || type == 4 || type == 6) {
                  var iWidth = 1000;
                  var iHeight = 600;
                  var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                  var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                  var win = window.open("../template1/editColumnStyle.jsp?ID=" + styleID + "&type=" + type + "&from=system", "updateStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                  //var retstr = showModalDialog("../template/editColumnStyle.jsp?ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:500px;dialogHeight:420px;status:no");
              } else {
                  var iWidth = 1000;
                  var iHeight = 600;
                  var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                  var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                  var win = window.open("../template1/editOtherStyle.jsp?ID=" + styleID + "&type=" + type + "&from=system", "updateStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                  //var retstr = showModalDialog("../template/editOtherStyle.jsp?ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
              }
          }
          //if (retstr != undefined && retstr != "") window.location = "listStyle.jsp?type="+type;
      }

      function PreviewStyle(type, styleID) {
          window.open("../template/getviewfile.jsp?id="+styleID+"&type="+type,"PreviewStyle","width=500,height=150,left=150,top=225,scrollbars=yes");
      }

      function DeleteStyle(styleID) {
          var msg = confirm("真要删除吗？");
          if (msg) window.location = "listStyle.jsp?doDelete=true&type=<%=type%>&ID="+styleID;
      }

      function CreateStyle(type) {
          var siteID = <%=siteID%>;
          if (type > 0) {
              if (siteID > 0){
                  if (type == 1 || type == 3 || type == 4) {
                      var iWidth = 1000;
                      var iHeight = 600;
                      var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                      var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                      var win = window.open("../template1/editStyle.jsp?type=" + type + "&from=system", "createStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                      //var retstr = showModalDialog("../template/editStyle.jsp?type=" + type, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:650px;dialogHeight:440px;status:no");
                  }else if (type == 6) {
                      var iWidth = 1000;
                      var iHeight = 600;
                      var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                      var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                      var win = window.open("../template1/editColumnStyle.jsp?type=" + type + "&from=system", "createStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                      //var retstr = showModalDialog("../template/editColumnStyle.jsp?type=" + type, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:500px;dialogHeight:420px;status:no");
                  }else {
                      var iWidth = 1000;
                      var iHeight = 600;
                      var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                      var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                      var win = window.open("../template1/editOtherStyle.jsp?type=" + type + "&from=system", "createStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                      //var retstr = showModalDialog("../template/editOtherStyle.jsp?type=" + type, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
                  }
              }else{
                  if (type == 1 || type == 3 || type == 4 || type == 6) {
                      var iWidth = 1000;
                      var iHeight = 600;
                      var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                      var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                      var win = window.open("../template1/editColumnStyle.jsp?type=" + type + "&from=system", "createStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                      //var retstr = showModalDialog("../template/editColumnStyle.jsp?type=" + type, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:500px;dialogHeight:420px;status:no");
                  }else {
                      var iWidth = 1000;
                      var iHeight = 600;
                      var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                      var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                      var win = window.open("../template1/editOtherStyle.jsp?type=" + type + "&from=system", "createStyle", "width=" + iWidth + ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft + ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no,alwaysRaised=yes,depended=yes");
                      //var retstr = showModalDialog("../template/editOtherStyle.jsp?type=" + type, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
                  }
              }
              //if (retstr != undefined && retstr != "") window.location = "listStyle.jsp?type="+type;
          }
      }
  </script>
</head>

<body>
<%
  String[][] titlebars = {
          { "样式文件", "" }
  };

  String str1 = "创建样式";
  String str2 = "";
  if (siteID > 0)
  {
    str2 = "系统管理";
  }
  String[][] operations = {
          {str1, "javascript:CreateStyle("+type+");"},
          {str2, "index.jsp"}
  };
%>
<%@ include file="../inc/titlebar.jsp" %>
<br>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="80%" align=center>
  <tr height=24>
    <td align=center><a href="listStyle.jsp?type=1"><b><font color=red>文章列表</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=6"><b><font color=red>栏目列表</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=3"><b><font color=red>相关文章</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=4"><b><font color=red>热点文章</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=2"><b><font color=red>导航条</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=8"><b><font color=red>中英文路径</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=7"><b><font color=red>新文章</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=5"><b><font color=red>被读文章</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=9"><b><font color=red>标题样式</font></b></a></td>
    <td align=center><a href="listStyle.jsp?type=10"><b><font color=red>上下篇</font></b></a></td>
  </tr>
</table>
<br>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="80%" align=center>
  <tr bgcolor="#eeeeee" class=tine>
    <td width="5%"  align=center>编号</td>
    <td width="30%" align=center><b>中文名称</b></td>
    <td width="13%" align=center>样式类型</td>
    <td width="13%" align=center>编辑</td>
    <td width="15%" align=center>修改日期</td>
    <td width="8%" align=center>修改</td>
    <td width="8%" align=center>删除</td>
    <td width="8%" align=center>预览</td>
  </tr>
  <%
    for (int i=0; i<list.size(); i++)
    {
      ViewFile file = (ViewFile)list.get(i);
      String bgcolor = (i%2==0)?"#ffffff":"#eeeeee";
      String viewtypestr = "";
      if (type == 1)
        viewtypestr = "文章列表";
      else if (type == 2)
        viewtypestr = "导航条";
      else if (type == 3)
        viewtypestr = "相关文章";
      else if (type == 4)
        viewtypestr = "热点文章";
      else if (type == 5)
        viewtypestr = "已阅读标题";
      else if (type == 6)
        viewtypestr = "栏目列表";
      else if (type == 7)
        viewtypestr = "新文章样式";
      else if (type == 8)
        viewtypestr = "路径样式";
      else if (type == 9)
        viewtypestr = "页面标题样式";
      else if (type == 10)
        viewtypestr = "上下篇";
  %>
  <tr bgcolor="<%=bgcolor%>" class=itm onmouseover="this.style.background='#CECEFF';" onmouseout="this.style.background='<%=bgcolor%>'" height=25>
    <td align=center><font color=red><%=file.getID()%></font></td>
    <td>&nbsp;&nbsp;<%=StringUtil.gb2iso4View(file.getChineseName())%></td>
    <td align=center><%=viewtypestr%></td>
    <td align=center><%=file.getEditor()%></td>
    <td align=center><%=file.getLastUpdated().toString().substring(0,10)%></td>
    <td align=center><a href="javascript:EditStyle(<%=type%>,<%=file.getID()%>);"><img src="../images/button/edit.gif" border=0></a></td>
    <td align=center><a href="javascript:DeleteStyle(<%=file.getID()%>);"><img src="../images/button/del.gif" border=0></a></td>
    <td align=center><a href="javascript:PreviewStyle(<%=type%>,<%=file.getID()%>);"><img src="../images/button/view.gif" border=0></a></td>
  </tr>
  <%}%>
</table>
</body>
</html>