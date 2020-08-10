<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.po.BudgetProject" %>
<%@ page import="com.bizwink.po.PurchaseProject" %>
<%@ page import="com.bizwink.service.IPurchaseProjectService" %>
<%@ page import="com.bizwink.service.IBudgetProjectService" %>
<%@ page import="com.bizwink.service.IChangeNoticeService" %>
<%@ page import="com.bizwink.po.ChangeNoticeWithBLOBs" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.cms.server.MyConstants" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    ApplicationContext appContext = SpringInit.getApplicationContext();
    String uuid = ParamUtil.getParameter(request,"uuid");
    PurchaseProject purchaseProject = null;
    BudgetProject budgetProject = null;
    ChangeNoticeWithBLOBs changeNotice = null;
    if (appContext!=null) {
        IChangeNoticeService changeNoticeService = (IChangeNoticeService)appContext.getBean("changeNoticeService");
        changeNotice = changeNoticeService.getChangeNoticeByUUID(uuid);

        IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        purchaseProject = purchaseProjectService.getProjectInfoByProjCode(changeNotice.getPurchaseprojcode());

        IBudgetProjectService budgetProjectService = (IBudgetProjectService)appContext.getBean("budgetProjectService");
        if (purchaseProject!=null)
            System.out.println("budget====" + purchaseProject.getBudgetProjectId());
        else
            System.out.println("采购项目为空");
        budgetProject = budgetProjectService.getBudgetProjByPrjcode(purchaseProject.getBudgetProjectId());

        //保存用户已经阅读过公告的信息
        if (authToken!=null) {
            changeNoticeService.saveReadNoticeFlag(changeNotice.getBulletintitle(),changeNotice.getUuid(),authToken.getUserid());
        }
    }

    String BulletinType = changeNotice.getBulletinType();
    String NoticeName = "";
    if (BulletinType!=null) {
        if (BulletinType.equals("1"))
            NoticeName = "采购公告";
        else if (BulletinType.equals("2"))
            NoticeName = "采购结果公告";
    }
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>变更公告--<%=changeNotice.getBulletintitle()%></title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/list_more.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

    <script src="/ggzyjy/js/style.js" type="text/javascript" ></script>
    <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

    <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>

    <style>
        p{line-height: 36px;font-family: '微软雅黑', Tahoma, Arial, sans-serif}
    </style>
</head>
<body>
<%@include file="/ggzyjy/inc/head_ggxx.shtml" %>
<div class="date_box">
    <%@include file="/ggzyjy/inc/writeCurrentDate.shtml" %>
</div>
<div class="main clearfix">
    <div class="banner_box">
        <div class="baner_box_left">全国公共资源交易平台（北京市·西城区）西城区公共资源交易<br>
            信息网<br>公平 公正 公开 诚信</div>
    </div>
    <div class="menu_box_1">
        <div class="home_box"><a href="/ggzyjy/">首页</a></div>
        <div class="menu_list">
            <ul>
                <li class="fl_4"><a href="/ggzyjy/news/">要闻动态</a></li>
                <li class="fl_3 current">公告信息</li>
                <li class="fl_2"><a href="/ggzyjy/manual/">服务指南</a></li>
                <li class="fl_1"><a href="/ggzyjy/jrkb/">今日开标</a></li>
            </ul>
        </div>
    </div>
    <div class="menu_c_box"><a href="/ggzyjy/ggxx/zbgg/">招标（资审）公告</a>|<a class="current">变更公告</a>|<a href="/ggzyjy/ggxx/winzb/">中标公告</a>|<a href="/ggzyjy/ggxx/other/">其它公告</a></div>
    <div class="path_search_box">
        <div class="path_box">您的位置：<a href="/ggzyjy/">首页</a>&gt;<a href="/ggzyjy/ggxx/">公告信息</a>&gt;招标（资审）公告</div>
        <!--div class="search_box"><input type="text" class="sear"></div-->
    </div>

    <!-- 中间内容-->
    <!--<div class="back_Div" >-->
    <div  style="width: 1105px;margin:0 auto">
        <div style="text-align: center;margin:28px 0 28px 0;"> <span style="font-size: 20px;font-weight: bold"><%=changeNotice.getBulletintitle()%></span></div>
        <div align="left" style="padding-left:30px;">
            <p align="center"></p>
            <p><strong>一、项目基本情况</strong></p>
            <p>原公告的采购项目编号：<%=changeNotice.getPurchaseprojcode()%>　　　　　　</p>
            <p>原公告的采购项目名称：<%=(changeNotice.getOriNoticeProjName()==null)?purchaseProject.getPurchaseprojname():changeNotice.getOriNoticeProjName()%>　　　　　　</p>
            <p>首次公告日期：<%=(changeNotice.getFirstNoticeDate()!=null)?sdf.format(changeNotice.getFirstNoticeDate()):""%>　　　　地址：<%=(changeNotice.getOriNoticeURL()==null)?"":changeNotice.getOriNoticeURL()%>　　　　　　　</p>
            <p><strong>二、更正信息</strong></p>
            <p>更正事项：<%=NoticeName%></p>
            <p>更正内容：</p>
            <p><%=changeNotice.getNewContent()%></p>
            <p></p>
            <p>更正日期：<%=sdf.format(changeNotice.getChangeDate())%>　</p>
            <p><strong>三、其他补充事宜</strong></p>
            <p></p>
            <p><strong>四、凡对本次公告内容提出询问，请按以下方式联系。</strong></p>
            <p>1.采购人信息</p>
            <p>名 称：<%=(changeNotice.getBuyerName()==null)?budgetProject.getBuyername():changeNotice.getBuyerName()%>　　　　　</p>
            <p>地址：<%=changeNotice.getBuyerAddress()%>　　　　　　　　</p>
            <p>联系方式：<%=changeNotice.getBuyerContact()%>,<%=changeNotice.getBuyerContactPhone()%>　　　　　　</p>
            <p>2.采购代理机构信息</p>
            <p>名 称：<%=(changeNotice.getAgentName()==null)?purchaseProject.getAgencyname():changeNotice.getAgentName()%>　　　　　　　　　　　　</p>
            <p>地　址：<%=(changeNotice.getAgentAddress()==null)?changeNotice.getAgentAddress():""%>　　　　　　　　　　　　</p>
            <p>联系方式：<%=(changeNotice.getAgentContact()==null)?purchaseProject.getAgencycontact():changeNotice.getAgentContact()%>，<%=(changeNotice.getAgentContactPhone()==null)?purchaseProject.getAgencyphone():changeNotice.getAgentContactPhone()%>　　　　　　　　　　　　</p>
            <p>3.项目联系方式</p>
            <p>项目联系人：<%=changeNotice.getProjContactor()%></p>
            <p>电　话：　　<%=changeNotice.getProjContactorPhone()%></p>

            <p>变更公告附件：<a href="<%=MyConstants.getDownloadAddress()%>/oa/common/attachment/publicDownloadFile?id=<%=changeNotice.getChangeText()%>" style="color: red">变更公告</a></p>
        </div>
        <div class="anniu">
            【 <A href="javascript:window.print()"  style="width:500px;color: #0a53ad" >打印</A> 】
            【 <A href="javascript:window.opener=null;window.open('','_self');window.close();" style="color: #0a53ad">关闭窗口</A> 】
        </div>
    </div>
</div>
<!--尾部内容-->
<!--</div>-->
</body>
</html>
