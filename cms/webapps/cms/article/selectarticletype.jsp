<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.po.ArticleType" %>
<%@ page import="com.bizwink.service.ArticletypeService" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if( authToken == null )
    {
        response.sendRedirect( "../login.jsp?url=member/createMember.jsp" );
        return;
    }

    ApplicationContext appContext = SpringInit.getApplicationContext();
    int columnID = ParamUtil.getIntParameter(request,"column",0);
    int articleID = ParamUtil.getIntParameter(request,"articleid",0);

    List<ArticleType> articleTypes = null;
    if (appContext != null) {
        ArticletypeService articletypeService = (ArticletypeService)appContext.getBean("ArticletypeService");
        articleTypes = articletypeService.getArticleTypes(BigDecimal.valueOf(columnID));
    }

%>

<!--html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>选择文章分类</title>
</head>
<frameset cols=160,*>
<frameset cols=* rows=0,*>
<frame src=articletypetree.jsp?column=<%=columnID%>&articleid=<%=articleID%> name=cmsleft>
<frame src=menu.html name=menu>
</frameset>
<frame src="doArticletype.jsp?column=<%=columnID%>&articleid=<%=articleID%>" name=cmsright>
</frameset>
</html-->