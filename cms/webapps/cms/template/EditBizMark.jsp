<%@ page import="java.net.*,
     com.bizwink.cms.util.*,
     com.bizwink.cms.security.*,
     com.bizwink.cms.markManager.*"
     contentType="text/html;charset=gbk"%>
<%
     Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
     if (authToken == null)
     {
         response.sendRedirect( "../login.jsp?url=member/removeGroup.jsp" );
         return;
      }
      int columnid = ParamUtil.getIntParameter(request,"columnid",0);
      int markid = ParamUtil.getIntParameter(request,"mark",0);
      String Markvalue = "";
      String cname="";
      if(markid>0){
        IMarkManager markMgr = markPeer.getInstance();
        mark mymark = markMgr.getAMark(markid);
        Markvalue = mymark.getContent()==null?"":StringUtil.gb2iso4View(mymark.getContent());
        cname = mymark.getChineseName()==null?"":StringUtil.gb2iso4View(mymark.getChineseName());
      }else{
        //URLDecoder decoder = null;
        Markvalue = ParamUtil.getParameter(request, "selText");
        Markvalue = StringUtil.iso2gb(Markvalue);
        //Markvalue = decoder.decode(Markvalue);
      }

      System.out.println(cname);
%>
<html>
<head>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Cache-Control content=no-cache>
<script type="" language="javascript">
function finish(){
  var objXml = new ActiveXObject("Microsoft.XMLHTTP");
  objXml.open("POST", "do_addmark.jsp?markid=<%=markid%>&columnid=<%=columnid%>&type=6&content="+addMark.content.value+"&chinesename="+addMark.chinesename.value, false);
  objXml.Send();
  var content = objXml.responseText;
  if(content.indexOf('[OVER]')!=-1){
    window.close();
  }
  if(content.indexOf('[MARKID]')==-1){
    return;
  }
  var markname = 'HTML��Ƭ';
  content = content.substring(content.indexOf('[MARKID]')+8,content.indexOf('[/MARKID]'));
  var retstr = "<INPUT name='[TAG][MARKID]"+content+"[/MARKID][/TAG]' type=button value='["+markname+"]' disabled style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>";
  window.returnValue = retstr;
  window.close();
}
</script>
</head>
<body>
  <form name=addMark method="post" action="editbizmark.jsp">
  �������:<input type="text" name="chinesename" value="<%=cname%>" />
  <textarea rows=20 cols=80 name=content wrap=virtual   size=40><%=Markvalue%>
  </textarea></p>
  <input type=button onclick="finish()" name=save value=�ύ>
  <input type=button name=cancel value=�رմ��� onclick="javascript:window.close()">
  </form>
  </body>
</html>
