<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.service.UsersService" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.util.filter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.util.JSON" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="com.bizwink.po.Organization" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/26
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("/webbuilder/index.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int siteid = authToken.getSiteID();
    int nodeid = ParamUtil.getIntParameter(request,"id",0);
    String pagesstr = filter.excludeHTMLCode(request.getParameter("currpage"));
    int pages = 1;  //当前页
    if (pagesstr == null) {
        pages = 1;
    } else {
        pages = Integer.parseInt(pagesstr);
    }
    int range = 20;

    List<Users> users = new ArrayList<Users>();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        UsersService usersService = (UsersService)appContext.getBean("usersService");
        OrganizationService organizationService = (OrganizationService)appContext.getBean("organizationService");
        Organization organization = organizationService.getAOrganization(BigDecimal.valueOf(nodeid));
        if (organization.getPARENT().intValue()==0)
            users = usersService.getUsersByCustomer(BigDecimal.valueOf(siteid),BigDecimal.valueOf((pages-1)*range+1),BigDecimal.valueOf(pages*range));
        else {
            List<Organization> organizations = organizationService.getSubOrgtreeByParant(BigDecimal.valueOf(siteid),BigDecimal.valueOf(nodeid));
            List<Integer> orgids = new ArrayList<Integer>();
            for(int ii=0;ii<organizations.size();ii++) {
                orgids.add(organizations.get(ii).getID().intValue());
            }
            users = usersService.getUsersByParentOrgID(BigDecimal.valueOf(siteid),orgids,BigDecimal.valueOf((pages-1)*range+1),BigDecimal.valueOf(pages*range));
        }
    }

    //Gson gson = new Gson();
    Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    String jsondata = gson.toJson(users);
    JSON.setPrintWriter(response,jsondata,"utf-8");
%>
<!--!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/cms_css.css"/>
<title>用户管理</title>
</head>

<body>
<table width="100%" border="0" cellspacing="10" cellpadding="0">
<tr>
<td>
<div class="location">
<div class="location_1">系统管理 > 用户管理</div>
<div class="button_top">
<ul>
<li><input name="" type="button" value="新建" class="button_bg_1"/></li>
<li><input name="" type="button" value="批量上传图片" class="button_bg_2"/></li>
<li><input name="" type="button" value="上传文件" class="button_bg_3"/></li>
<li><input name="" type="button" value="退稿" class="button_bg_1"/></li>
<li><input name="" type="button" value="在审" class="button_bg_1"/></li>
<li><input name="" type="button" value="未用" class="button_bg_1"/></li>
<li><input name="" type="button" value="归档" class="button_bg_1"/></li>
<li><input name="" type="button" value="引用" class="button_bg_1"/></li>
<li><input name="" type="button" value="文件夹管理器" class="button_bg_2"/></li>
</ul>
</div>
</div>
</td>
</tr>
<tr>
<td align="left" valign="top">
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#CCCCCC" class="tab_list">
<tr>
<td width="67" align="center" valign="middle" bgcolor="#f4f4f4">选择</td>
<td width="73" align="center" valign="middle" bgcolor="#f4f4f4">状态</td>
<td width="87" align="center" valign="middle" bgcolor="#f4f4f4">RSS</td>
<td width="378" align="center" valign="middle" bgcolor="#f4f4f4">标题</td>
<td width="200" align="center" valign="middle" bgcolor="#f4f4f4">发布时间</td>
<td width="252" align="center" valign="middle" bgcolor="#f4f4f4">修改时间</td>
<td width="68" align="center" valign="middle" bgcolor="#f4f4f4">主权重</td>
<td width="63" align="center" valign="middle" bgcolor="#f4f4f4">次权重</td>
<td width="107" align="center" valign="middle" bgcolor="#f4f4f4">编辑</td>
<td width="85" align="center" valign="middle" bgcolor="#f4f4f4">预览</td>
<td width="84" align="center" bgcolor="#f4f4f4">修改</td>
<td width="85" align="center" valign="middle" bgcolor="#f4f4f4">删除</td>
<td width="84" align="center" valign="middle" bgcolor="#f4f4f4">推送</td>
<td width="84" align="center" valign="middle" bgcolor="#f4f4f4">发布</td>
</tr>
<tr bgcolor="#FFFFFF">
<td align="center" valign="middle"><input type="checkbox" name="checkbox" id="checkbox" /></td>
<td align="center" valign="middle"><img src="../images/state.png" width="23" height="23" /></td>
<td>&nbsp;</td>
<td><a href="#">坚持走绿色发展之路 共筑生态文明之基路 共筑生态文明之基路 共筑生态文明之基</a></td>
<td align="center">2013-08-09 14:25:00</td>
<td align="center" >2013-08-09 14:25:00</td>
<td align="center" valign="middle" >0</td>
<td align="center" valign="middle">0</td>
<td align="center" valign="middle">admin</td>
<td align="center" valign="middle"><a href="#"><img src="../images/view.png" width="23" height="23" /></a></td>
<td align="center" valign="middle"><img src="../images/lock.png" width="22" height="23" /></td>
<td align="center" valign="middle"><a href="#"><img src="../images/del.png" width="23" height="23" /></a></td>
<td align="center" valign="middle"><a href="#"><img src="../images/give.png" width="24" height="23" /></a></td>
<td align="center" valign="middle"><a href="#"><img src="../images/public.png" width="23" height="23" /></a></td>
</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="10%" height="60" align="center" valign="middle"><input type="checkbox" name="checkbox3" id="checkbox3" />
全部选中</td>
<td width="20%"><input type="submit" name="button" id="button" value="更新RSS" class="button_bg_3" /> <input type="submit" name="button" id="button" value="批量删除" class="button_bg_3" /></td>
<td width="70%">当前栏目的文章总数：18&nbsp;&nbsp;&nbsp;&nbsp;总1页&nbsp;&nbsp;&nbsp;第一页 到第<input type="text" name="textfield" id="textfield"  class="txt_1"/> <input type="submit" name="button2" id="button2" value="GO" class="btn_go" /></td>

</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="23%" height="50">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标题：<input type="text" name="textfield2" id="textfield2" class="sear_txt_1"/>&nbsp;<input type="submit" name="button3" id="button3" value="搜索" class="sear_btn"/> <a href="#" class="sear_gj">高级搜索</a></td>
</tr>
</table>

</td>
</tr>
</table>

</body>
</html-->
