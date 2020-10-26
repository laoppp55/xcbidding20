<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.service.IBudgetProjectService" %>
<%@ page import="com.bizwink.service.IPurchaseProjectService" %>
<%@ page import="com.bizwink.po.BudgetProject" %>
<%@ page import="com.bizwink.po.PurchaseProject" %>
<%@ page import="com.bizwink.service.IWinResultsNoticeService" %>
<%@ page import="com.bizwink.po.WinResultsNotice" %>
<%@ page import="com.bizwink.po.WinResultsNoticeWithBLOBs" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
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
    WinResultsNoticeWithBLOBs winResultsNotice = null;
    if (appContext!=null) {
        IWinResultsNoticeService winResultsNoticeService = (IWinResultsNoticeService)appContext.getBean("winResultsNoticeService");
        winResultsNotice = winResultsNoticeService.getWinResultsNoticeByUUID(uuid);

        IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        purchaseProject = purchaseProjectService.getProjectInfoByProjCode(winResultsNotice.getPurchaseprojcode());

        IBudgetProjectService budgetProjectService = (IBudgetProjectService)appContext.getBean("budgetProjectService");
        if (purchaseProject==null) response.sendRedirect("/users/error.jsp?errcode=300");
        budgetProject = budgetProjectService.getBudgetProjByPrjcode(purchaseProject.getBudgetProjectId());

        //保存用户已经阅读过公告的信息
        if (authToken!=null) {
            winResultsNoticeService.saveReadNoticeFlag(winResultsNotice.getWinningAnnName(),winResultsNotice.getUuid(),authToken.getUserid());
        }
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
    String priceFormCode = winResultsNotice.getPriceFormCode();
    String bidingAnnoDate = sdf.format(winResultsNotice.getBidingAnnoDate());
    String calibrationAnnDate = sdf.format(winResultsNotice.getCalibrationAnnDate());
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>招标公告--<%=winResultsNotice.getWinningAnnName()%></title>
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
    <div class="menu_c_box"><a href="/ggzyjy/ggxx/zbgg/">招标（资审）公告</a>|<a href="/ggzyjy/ggxx/bggg/">变更公告</a>|<a class="current">中标公告</a>|<a href="/ggzyjy/ggxx/other/">其它公告</a></div>
    <div class="path_search_box">
        <div class="path_box">您的位置：<a href="/ggzyjy/">首页</a>&gt;<a href="/ggzyjy/ggxx/">公告信息</a>&gt;招标（资审）公告</div>
        <!--div class="search_box"><input type="text" class="sear"></div-->
    </div>
    <div  style="width: 1105px;margin:0 auto">
        <div style="text-align: center;margin:28px 0 28px 0;"> <span style="font-size: 20px;font-weight: bold"><%=winResultsNotice.getWinningAnnName()%></span></div>
        <div align="left" style="padding-left:30px;">
            <p align="center"></p>
            <p><p><strong>一、项目编号：<%=purchaseProject.getPurchaseprojcode()%></strong></p>
            <p><strong>二、项目名称：<%=purchaseProject.getPurchaseprojname()%></strong></p>
            <p><strong>三、中标（成交）信息</strong></p>
            <!--价款形式代码 1-金额  2-费率/比率/优惠率/合格率等 3-单价 4-其它形式 -->
            <% if (priceFormCode.equals("1")) {%>
            <p>总中标金额：<fmt:formatNumber type="currency" pattern="￥.000000#"><%=winResultsNotice.getWinBidingPrice().floatValue()%></fmt:formatNumber> 元（人民币）</p>
            <%} else if (priceFormCode.equals("2")){%>
            <p>总中标金额：<fmt:formatNumber type="currency" pattern="￥.000000#"><%=winResultsNotice.getWinBidingPrice().floatValue()%></fmt:formatNumber> 元（人民币）</p>
            <%} else if (priceFormCode.equals("3")) {%>
            <p>总中标金额：<fmt:formatNumber type="currency" pattern="￥.000000#"><%=winResultsNotice.getWinBidingPrice().floatValue()%></fmt:formatNumber> 元（人民币）</p>
            <%} else {%>
            <p>总中标金额：<fmt:formatNumber type="currency" pattern="￥.000000#"><%=winResultsNotice.getWinBidingPrice().floatValue()%></fmt:formatNumber> 元（人民币）</p>
            <%}%>
            <p>中标供应商名称、联系地址及中标金额：</p>
            <p>
            <p>&nbsp;<%=winResultsNotice.getMainSectionName()%>:</p>
            <p>中标人：<%=winResultsNotice.getSuppliersName()%></p>
            <p>中标单位地址:&nbsp;<%=winResultsNotice.getSuppliersAddress()%></p>
            <p>中标金额：小写：&yen;<%=winResultsNotice.getWinBidingPrice()%>元</p>
            <!--p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;大写：肆拾伍万元整</p-->
            </p>
            <p><strong>四、主要标的信息</strong></p>
            <p></p>
            <p>
            <p>项目名称：<%=winResultsNotice.getPurchaseprojname()%></p>
            <p>项目编号：<%=purchaseProject.getPurchaseprojcode()%></p>
            <p>招标单位：<%=winResultsNotice.getBuyerName()%></p>
            <p>地 &nbsp;&nbsp;&nbsp;址：<%=winResultsNotice.getBuyerAddress()%></p>
            <p>联 系 人： <%=winResultsNotice.getBuyerContactor()%></p>
            <p>联系电话： <%=winResultsNotice.getBuyerContact()%></p>
            <p>招标代理人：<%=winResultsNotice.getAgentName()%></p>
            <p>地 &nbsp;&nbsp;&nbsp;址： <%=winResultsNotice.getAgentAddress()%></p>
            <p>联 系 人： <%=winResultsNotice.getAgentContactor()%></p>
            <p>联系电话： <%=winResultsNotice.getAgentContact()%>&nbsp;</p>
            <p>批准文号：<%=(winResultsNotice.getReplyCode()==null)?"":winResultsNotice.getReplyCode()%></p>
            <p>&nbsp;</p>
            <p><%=winResultsNotice.getPurchaseprojname()%>于<%=bidingAnnoDate%>发布招标公告，<%=calibrationAnnDate%>开标，并于<%=calibrationAnnDate%>已按照招标文件规定的评标办法完成了评标工作。</p>
            <p>中标标的名称、规格型号、数量、单价、服务要求：</p>
            <p>详见招标文件</p>
            <p><span>服务时间：<%=(winResultsNotice.getServiceTime()==null)?"":winResultsNotice.getServiceTime()%></span></p>
            </p>
            <p><strong>五、评审专家（单一来源采购人员）名单：</strong></p>
            <p><%=winResultsNotice.getMemberList()%></p>
            <p><strong>六、代理服务收费标准及金额：</strong></p>
            <p></p>
            <p><b>本项目代理费总金额：<%=winResultsNotice.getAgencyServiceFee()%>元（人民币）</b></p>
            <p>本项目代理费收费标准：</p>
            <p>按原国家计委《招标代理服务收费管理暂行办法》[2002]1980号的规定执行</p>
            <p><strong>七、公告期限</strong></p>
            <p>自本公告发布之日起1个工作日。</p>
            <p><strong>八、其它补充事宜</strong></p>
            <p>
            <p></p>
            </p>
            <p></p>
            <p><strong>九、凡对本次公告内容提出询问，请按以下方式联系。</strong></p>
            <p>1.采购人信息</p>
            <p>名 称：<%=winResultsNotice.getBuyerName()%>　　　　　</p>
            <p>地址：<%=winResultsNotice.getBuyerAddress()%>　　　　　　　　</p>
            <p>联系方式：<%=winResultsNotice.getBuyerContactor()%> <%=winResultsNotice.getBuyerContact()%>　　　　　　</p>        　　　
            <p>2.采购代理机构信息</p>
            <p>名 称：<%=winResultsNotice.getAgentName()%>　　　　　　　　　　　　</p>
            <p>地　址：<%=winResultsNotice.getAgentAddress()%>　　　　　　　　　　　　</p>
            <p>联系方式：<%=winResultsNotice.getAgentContactor()%> <%=winResultsNotice.getAgentContact()%>　　　　　　　　　　　　</p>
            <p>3.项目联系方式</p>
            <p>项目联系人：<%=winResultsNotice.getBuyerContactor()%></p>
            <p>电　话：　　<%=winResultsNotice.getBuyerContact()%></p>　
            <p></p>
            <p>&nbsp;</p>
            <p></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      </p>
            <p>
                <a href="<%=winResultsNotice.getBidNoticeLinkAddress()%>">源公告地址</a>
            </p>
            <p>

            </p>
            <p>

            </p>
            <p>
            </p>
        </div>
    </div>
    <div class="anniu">
        【 <A href="javascript:window.print()" style="width:500px;color: #0a53ad" >打印</A> 】
        【 <A href="javascript:window.opener=null;window.open('','_self');window.close();" style="color: #0a53ad">关闭窗口</A> 】
    </div>
</div>
</body>
</html>
