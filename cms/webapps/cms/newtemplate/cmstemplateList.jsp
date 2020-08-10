<%@page import="java.sql.*,
    		java.util.*,
    		java.io.*,
    		com.bizwink.cms.modelManager.*,
    		com.bizwink.cms.news.*,
    		com.bizwink.cms.security.*,
    		com.bizwink.cms.util.*"
    		contentType="text/html;charset=gbk"
%>

<%
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String editor = authToken.getUserID();

    int columnID  = ParamUtil.getIntParameter(request, "column", 0);

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String CName = StringUtil.gb2iso4View(column.getCName());

    //����ģ���б�
    String dir = "";

    IModelManager modelMgr = ModelPeer.getInstance();
    String content = modelMgr.getCmsTemplates();
%>
<html>
<head>
<title>ѡ��ģ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../style/global.css"> 
<script language="JavaScript"> 
<!-- 
if (window.Event)  
document.captureEvents(Event.MOUSEUP);  

function nocontextmenu()  
{ 
event.cancelBubble = true 
event.returnValue = false; 

return false; 
} 

function norightclick(e)  
{ 
if (window.Event)  
{ 
if (e.which == 2 || e.which == 3) 
return false; 
} 
else 
if (event.button == 2 || event.button == 3) 
{ 
event.cancelBubble = true 
event.returnValue = false; 
return false; 
} 

} 

document.oncontextmenu = nocontextmenu; // for IE5+ 
document.onmousedown = norightclick; // for all others 
//--> 
</script> 
</head>

<body bgcolor="#FFFFFF">
<div align="center">
  <center>
  <br>
  <table border="0" width="95%">
    <tr>
      <td width="25%" bgcolor="#C0C0C0">
      <%=StringUtil.gb2iso(content)%>
      </td>
      <td width="2%">&nbsp; </td>
      <td width="73%" valign=top>
      <form method="POST" action="--WEBBOT-SELF--">
        <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
          <tr height=25>
            <td width="30%" bgcolor="#DEDFDE" align="center">ģ������</td>
            <td width="30%" bgcolor="#DEDFDE" align="center">ģ�����</td>
            <td width="20%" bgcolor="#DEDFDE" align="center">Ԥ��</td>
            <td width="20%" bgcolor="#DEDFDE" align="center">ѡ��</td>
          </tr>
          <tr>
            <td bgcolor="#EFC300" align="center" height="16">��</td>
            <td bgcolor="#EFC300" align="center" height="16">��</td>
            <td bgcolor="#EFC300" align="center" height="16"><img border="0" src="../images/preview.gif" width="15" height="15"></td>
            <td bgcolor="#EFC300" align="center" height="16"><input type="radio" value="1" name="Item"></td>
          </tr>
       </table>
       <p align=center>
       <input type="submit" value=" ȷ �� " name="Select">&nbsp;&nbsp;&nbsp;
       <input type="button" value=" �� �� " name="GoBack" onclick="window.close()">
       </p>
      </form>
      </td>
    </tr>
  </table>
  </center>
</div>

</body>
</html>
