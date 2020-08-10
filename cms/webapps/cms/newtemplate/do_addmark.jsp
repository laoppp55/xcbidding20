<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.markManager.*"
                contentType="text/html;charset=gbk"
%>

<%
  Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
  if (authToken == null)
  {
    response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
    return;
  }
  int siteID = authToken.getSiteID();
  int markid = ParamUtil.getIntParameter(request,"markid",0);
  int type = ParamUtil.getIntParameter(request,"type",-1);
  int columnid = ParamUtil.getIntParameter(request,"columnid",0);
  String content = ParamUtil.getParameter(request,"content");
  String chinesename = ParamUtil.getParameter(request,"chinesename");
  IMarkManager markMgr = markPeer.getInstance();
  mark mymark = new mark();
  if(markid==0&&type>=0){
    mymark.setChinesename(chinesename);
    mymark.setSiteID(siteID);
    mymark.setColumnID(columnid);
    mymark.setMarkType(type);
    mymark.setContent(content);
    markid = markMgr.Create(mymark);
    out.print("[TAG][HTMLMARK][MARKID]"+String.valueOf(markid)+"[/MARKID][/HTMLMARK][/TAG]");
  }else{
    mymark.setID(markid);
    mymark.setChinesename(chinesename);
    mymark.setSiteID(siteID);
    mymark.setColumnID(columnid);
    mymark.setMarkType(type);
    mymark.setContent(content);
    markMgr.Update(mymark);
    out.print("[OVER]"+String.valueOf(markid)+"[/OVER]");
  }
%>

