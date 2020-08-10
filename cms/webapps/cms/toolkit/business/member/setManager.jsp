<%@ page import="java.util.*,
                 com.bizwink.cms.server.*,
                 com.bizwink.cms.security.*,
                 com.booyee.bbs.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk"
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
    if( authToken == null ) {
         response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
         return;
    }

    int doflag = ParamUtil.getIntParameter(request, "doflag", 0);

    IBBSManager bbsMgr = BBSPeer.getInstance();
    BBS bbs = new BBS();
    List list = new ArrayList();
    list = bbsMgr.getAllColumn();

    String bbsname = "";
    String bbsdesc = "";
    String manager = "";
    int id = 0;

    if(doflag == 1){
      id = ParamUtil.getIntParameter(request, "id", 0);
      bbsname = ParamUtil.getParameter(request, "bbsname");
      bbsdesc = ParamUtil.getParameter(request, "bbsdesc");
      manager = ParamUtil.getParameter(request, "manager");

      bbs.setBBSName(bbsname);
      bbs.setBBSDesc(bbsdesc);
      bbs.setManager(manager);
      bbs.setID(id);
      bbsMgr.updateAForum(bbs);

      response.sendRedirect("setManager.jsp");
    }
%>
<html>
<head>
<title>��̳����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>

<body>
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=95% align="center">
<tr bgcolor="#eeeeee" class=tine>
<td align=center width="180">��̳��</td>
<td align=center width="604">��̳����</td>
<td align=center width="97">����</td>
</tr>
<%
  for(int i=0;i<list.size();i++){
    bbs = (BBS)list.get(i);
    id = bbs.getID();
    bbsname = bbs.getBBSName();
    bbsdesc = bbs.getBBSDesc();
    manager = bbs.getManager();
%>
<tr bgcolor="#eeeeee" class=tine>
<td align=center width="180"><a href="setManager.jsp?startflag=1&id=<%=id%>"><%=bbsname%></a></td>
<td align=center width="604"><%=bbsdesc==null?" ":new String(bbsdesc.getBytes("iso8859_1"),"GBK")%></td>
<td align=center width="97"><%=manager%></td>
</tr>
<%}%>
</table>
<%
  int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
  id = ParamUtil.getIntParameter(request, "id", 0);
  if(startflag == 1){
    bbs = bbsMgr.getAFORUM(id);
    bbsname = bbs.getBBSName();
    bbsdesc = bbs.getBBSDesc();
    manager = bbs.getManager();
%>
<form method="POST" action="setManager.jsp">
<input type="hidden" name="doflag" value="1">
<input type="hidden" name="id" value="<%=id%>">
<table align="left" width="95%">
  <tr>
    <td>
      ��̳����&nbsp; <input type="text" name="bbsname" value="<%=bbsname%>" size="51">
    </td>
  </tr>
  <tr>
    <td>
      ��̳������<input type="text" name="bbsdesc" value="<%=bbsdesc==null?"":new String(bbsdesc.getBytes("iso8859_1"),"GBK")%>" size="106">
    </td>
  </tr>
  <tr>
    <td>
      ����&nbsp;&nbsp;&nbsp; <input type="text" name="manager" value="<%=manager%>" size="50">&nbsp;��Ӷ��������Ӣ�ĵ�','�ָ�
    </td>
  </tr>
  <tr>
    <td>
      <p align="center"><input type="submit" value="�ύ" name="B1"></p>
    </td>
  </tr>
</table>
</form>
<%}%>
</body>

</html>

