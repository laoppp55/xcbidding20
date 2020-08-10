<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.webapps.comment.IWebCommentManager" %>
<%@ page import="com.bizwink.webapps.comment.webCommentPeer" %>
<%@ page import="com.bizwink.webapps.comment.webComment" %>
<%@ page import="com.bizwink.cms.news.IArticleManager" %>
<%@ page import="com.bizwink.cms.news.ArticlePeer" %>
<%@ page import="com.bizwink.cms.news.Article" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
      if (authToken == null)
      {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
      }
      int siteid = authToken.getSiteID();
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 100);


    IWebCommentManager cMgr = webCommentPeer.getInstance();
    IArticleManager aMgr = ArticlePeer.getInstance();

    List list = new ArrayList();
    int rows = 0;
    String sqlstr = "select * from tbl_comment where siteid = "+siteid+" order by createdate desc";
        list = cMgr.getAllcommentInfo(sqlstr,startrow,range);

   rows = cMgr.getAllCommentNum("select count(id) from tbl_comment where siteid = "+siteid);
    int totalpages = 0;
    int currentpage = 0;
    if(rows < range){
        totalpages = 1;
        currentpage = 1;
    }else{
        if(rows%range == 0)
          totalpages = rows/range;
        else
          totalpages = rows/range + 1;
        currentpage = startrow/range + 1;
    }
%>
<html>
<head>
<title>��������</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
<style type="text/css">
TABLE {FONT-SIZE: 12px;word-break:break-all}
BODY {FONT-SIZE: 12px;margin-top: 0px;margin-bottom: 0px; line-height:20px;}
.TITLE {FONT-SIZE:16px; text-align:center; color:#FF0000; font-weight:bold; line-height:30px;}
.FONT01 {FONT-SIZE: 12px; color:#FFFFFF; line-height:20px;}
.FONT02 {FONT-SIZE: 12px; color:#D04407; font-weight:bold; line-height:20px;}
.FONT03 {FONT-SIZE: 14px; color:#000000; line-height:25px;}
A:link {text-decoration:none;line-height:20px;}
A:visited {text-decoration:none;line-height:20px;}
A:active {text-decoration:none;line-height:20px; font-weight:bold;}
A:hover {text-decoration:none;line-height:20px;}
.pad {padding-left:4px; padding-right:4px; padding-top:2px; padding-bottom:2px; line-height:20px;}
.form{border-bottom:#000000 1px solid; background-color:#FFFFFF; border-left:#000000 1px solid; border-right:#000000 1px solid; border-top:#000000 1px solid; font-size: 9pt; font-family:"����";}
.botton{border-bottom:#000000 1px solid; background-color:#F1F1F1; border-left:#FFFFFF 1px solid; border-right:#333333 1px solid; border-top:#FFFFFF 1px solid; font-size: 9pt; font-family:"����"; height:20px; color: #000000; padding-bottom: 1px; padding-left: 1px; padding-right: 1px; padding-top: 1px; border-style: ridge}
</style>
    <script language="javascript">
    function golist(r){
      window.location = "index.jsp?startrow="+r;
    }




     function del(id){
      var val;
      val = confirm("��ȷ��Ҫɾ����");
      if(val == 1){
        window.location = "delete.jsp?startflag=1"+"&id="+id;
      }
    }

    function upflag(id,flag){
        var flags;
        if(flag == 0){
            flags = 1;
        }
        if(flag == 1){
            flags = 0;
        }
        var val;
        val = confirm("��ȷ��������ʾ��ʽ��");
        if(val == 1){
             window.location = "flag.jsp?startflag=1"+"&flag="+flags+"&id="+id;
        }
    }

    function edit(id){
      window.location = "outlinecard.jsp?id="+id;
  }
   function add(id){
       window.open("add.jsp?id="+id,"","height=500,width=800");
   }
    function tj(id){
       window.open("tj.jsp?id="+id,"","height=500,width=800");
   }
  </script>
</head>
<body>
<input type="hidden" name="updateflag" value="1">
<center>
    <form action="index.jsp" method="post" name="form">
<table width="90%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">��������</td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                <tr  bgcolor="#FFFFFF" class="css_001">
                  <td width="20%" align="center">���±���</td>
                    <td align="center" width="10%">����������</td>
                    <td align="center" width="10%">��ϵ��ʽ</td>
                    <td align="center" width="10%">ip��ַ</td>
                    <td align="center" width="30%">��������</td>
                    <td align="center" width="10%">����ʱ��</td>
                    <td align="center" width="10%">ɾ��</td>
                </tr>
                  <%
                      for(int i = 0; i < list.size();i++){
                          webComment comment = (webComment)list.get(i);
                          Article article = aMgr.getArticle(comment.getAbout());
                          String maintitle = "";
                          if(article != null){
                              maintitle = StringUtil.gb2iso4View(article.getMainTitle());
                          }

                  %>
                <tr  bgcolor="#FFFFFF" class="css_001">
                  <td width="20%" align="center"><%=maintitle%></td>
                    <td align="center" width="10%"><%=comment.getName()==null?"":StringUtil.gb2iso4View(comment.getName())%></td>
                    <td align="center" width="10%"><%=comment.getLink()==null?"":StringUtil.gb2iso4View(comment.getLink())%></td>
                    <td align="center" width="10%"><%=comment.getIP()==null?"":StringUtil.gb2iso4View(comment.getIP())%></td>
                    <td align="center" width="30%"><%=comment.getContent()==null?"":StringUtil.gb2iso4View(comment.getContent())%></td>
                    <td align="center" width="10%"><%=comment.getCreateDate().toString().substring(0,10)%></td>
                    <td align="center" width="10%"><a href="javascript:del(<%=comment.getId()%>)">ɾ��</a></td>
                </tr>
                  <%}%>
               </table>
            </td>
          </tr>
        </table>
      </td>
</tr>
</table>
<table width="70%" class="css_002">
<tr valign="bottom" width=100%>
<td>
 ��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
</td>
<td>
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td class="css_002">
<%
    if((startrow-range)>=0){
%>
[<a href="index.jsp?startrow=<%=startrow-range%>" class="css_002">��һҳ</a>]
<%}
  if((startrow+range)<rows){
%>
[<a href="index.jsp?startrow=<%=startrow+range%>" class="css_002">��һҳ</a>]
<%}

  if(totalpages>1){%>
  &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
  <a href="#" class="css_002" onclick="golist((document.all('jump').value-1) * <%=range%>);">GO</a>
  <%}%>
</td>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</table>
        </form>
    <table width="50%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
</table>
</center>
</body>
</html>