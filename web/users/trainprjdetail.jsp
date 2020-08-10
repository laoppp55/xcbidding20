<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.service.impl.UsersService" %>
<%@ page import="com.bizwink.vo.OrderAndOrderdetail" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.EcService" %>
<%@ page import="com.bizwink.po.Orders" %>
<%@ page import="com.bizwink.service.ArticleService" %>
<%@ page import="com.bizwink.vo.ArticleAndExtendAttrs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.po.ArticleExtendattr" %>
<%@ page import="com.bizwink.service.ColumnService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    System.out.println("ggggggggggggggggggggggggg");

    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        if (referer_usr!=null) {
            response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        } else {
            response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        }
    }
    int userid = authToken.getUid();
    long orderid = ParamUtil.getLongParameter(request,"orderid",0);
    String username = authToken.getUserid();
    Users user = null;
    Orders order = null;
    ArticleAndExtendAttrs articleAndExtendAttr = null;
    ColumnService columnService = null;
    EcService ecService = null;
    ArticleService articleService = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        ecService = (EcService)appContext.getBean("ecService");
        order = ecService.getOrder(orderid);
        articleService = (ArticleService)appContext.getBean("articleService");
        articleAndExtendAttr = articleService.getArticleAndEXtendAttrs(order.getProjartid());
        UsersService usersService = (UsersService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(username);
    }

    //获取培训项目开始培训时间和结束培训时间
    String pxbt = null,pxet=null;
    if(articleAndExtendAttr!=null) {
        List<ArticleExtendattr> extendattrs = articleAndExtendAttr.getArticleExtendattrs();
        for (int jj=0; jj<extendattrs.size();jj++) {
            ArticleExtendattr extendattr = extendattrs.get(jj);
            if (extendattr.getEname().equals("_pxbt")) pxbt = extendattr.getStringvalue();
            if (extendattr.getEname().equals("_pxet")) pxet = extendattr.getStringvalue();
        }
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京城建集团党校--培训项目详细信息</title>
    <link href="/css/basis.css" rel="stylesheet" type="text/css">
    <link href="/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery.min.js" type="text/javascript"></script>
    <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
</head>

<body>
<!--以上页面头-->
<div class="main clearfix div_top div_bottom">
    <div class="personal_right_box">
        <div class="personal_right">
            <div class="p_r_title">培训项目详细信息</div>
        </div>
        <table width="875" border="0" cellspacing="1" cellpadding="0" bgcolor="#e2e2e2" align="left" >
            <tr>
                <td width="200" align="center" valign="middle" bgcolor="#f6f4f5">培训项目编号</td>
                <td valign="middle" bgcolor="#ffffff" style="padding-left:10px;"><%=(order.getProjcode()!=null)?order.getProjcode():""%></td>
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">培训项目名称</td>
                <td valign="middle" bgcolor="#ffffff" style="padding-left:10px;"><%=(order.getProjname()!=null)?order.getProjname():""%></td>
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">培训金额</td>
                <td valign="middle" bgcolor="#ffffff" style="padding-left:10px;"><%=order.getTOTALFEE()%></td>
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">开始时间</td>
                <td valign="middle" bgcolor="#ffffff" style="padding-left:10px;"><%=pxbt%></td>
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">结束时间</td>
                <td valign="middle" bgcolor="#ffffff" style="padding-left:10px;"><%=pxet%></td>
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">项目状态</td>
                <% if (order.getSTATUS() == 1) {%>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><font color="red">报名中</font></td>
                <%} else if (order.getSTATUS() == 2) {%>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><font color="red">培训中</font></td>
                <%} else if (order.getSTATUS() == 3) {%>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><font color="red">等待考试</font></td>
                <%} else if (order.getSTATUS() == 4) {%>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><font color="red">培训结束</font></td>
                <%} else if (order.getSTATUS() == 5) {%>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><font color="red">异常终止</font></td>
                <%} else {%>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><font color="red">未知状态</font></td>
                <%}%>
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">是否支付</td>
                <td align="center" valign="middle" bgcolor="#FFFFFF"><%=(order.getSTATUS()!=8)?"<font color=\"red\">未支付</font>":"<font color=\"green\">已支付</font>"%></td>

                <!--td valign="middle" bgcolor="#ffffff" style="padding-left:10px;">已支付</td-->
            </tr>
            <tr>
                <td align="center" valign="middle" bgcolor="#f6f4f5">操作</td>
                <td valign="middle" bgcolor="#ffffff" style="padding-left:10px;"><a href="#" class="blue_16">修改</a>   <a href="#" class="blue_16">删除</a></td>
            </tr>
        </table>
    </div>
</div>
<!--以下页面尾-->
</body>
</html>
