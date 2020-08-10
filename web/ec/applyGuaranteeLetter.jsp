<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.IPurchaseProjectService" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.service.IBudgetProjectService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String username = authToken.getUsername();
    int startrow = ParamUtil.getIntParameter(request,"start",0);
    int rows = ParamUtil.getIntParameter(request,"rows",20);

    //获取申请保函的标包编号
    String projsectioncode = ParamUtil.getParameter(request,"projsectioncode");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    ApplicationContext appContext = SpringInit.getApplicationContext();
    BudgetProject budgetProject = null;
    PurchaseProject purchaseProject = null;
    Section section = null;
    BulletinNoticeWithBLOBs bulletinNotice = null;
    PurchasingAgency purchasingAgency = null;
    if (appContext!=null) {
        IBudgetProjectService budgetProjectService = (IBudgetProjectService)appContext.getBean("budgetProjectService");
        IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        Users us= usersService.getUserinfoByUserid(username);
        purchasingAgency = usersService.getEnterpriseInfoByCompcode(us.getCOMPANYCODE());
        section = purchaseProjectService.getSectionBySecotionCode(projsectioncode);
        if (section==null) response.sendRedirect("/error.jsp?errcode=" + "-200");
        purchaseProject = purchaseProjectService.getProjectInfoByProjCode(section.getPurchaseprojcode());
        budgetProject = budgetProjectService.getBudgetProjByPrjcode(purchaseProject.getBudgetProjectId());
        if (purchaseProject==null) response.sendRedirect("/error.jsp?errcode=" + "-100");
        //找到标包所在的公告
        bulletinNotice = noticeService.getBulletinNoticeBySection(section.getPurchasesectioncode());
        //没有分包发公告，一定是按项目发公告,一个采购项目可能对应发布多个公告
        if (bulletinNotice == null) bulletinNotice = noticeService.getBulletinNoticeByproject(purchaseProject.getPurchaseprojcode()).get(0);
    }

    System.out.println(budgetProject.getTenderprojtype());

    String tenderProjType = null;
    if (budgetProject.getTenderprojtype().trim().equals("1"))
        tenderProjType = "工程类";
    else if (budgetProject.getTenderprojtype().trim().equals("2"))
        tenderProjType = "货物类";
    else if (budgetProject.getTenderprojtype().trim().equals("3"))
        tenderProjType = "服务类";
    else
        tenderProjType = "其他";
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心--申请保函管理</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/ggzyjy/js/jquery.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
    <script>
        function isEmpty(obj) {
            if (typeof obj == "undefined" || obj == null || obj == "" || obj=='') {
                return true;
            } else {
                return false;
            }
        }

        function tijiao(action) {
            var GLName = acform.glName.value;
            var compuuid = acform.compuuid.value;
            var companyName = acform.companyName.value;
            var companyCode = acform.companyCode.value;
            var projectname = acform.projectname.value;
            var projectcode = acform.projectcode.value;
            var regioncode = acform.regioncode.value;
            var tenderprojtype = acform.tenderprojtype.value;
            var sectionName = acform.sectionName.value;
            var sectionCode = acform.sectionCode.value;
            var buyername = acform.buyername.value;
            var buyeraddr = acform.buyeraddr.value;
            var agentname = acform.agentname.value;
            var margin = acform.margin.value;
            var startdate = acform.startdate.value;
            var enddate = acform.enddate.value;
            var contactorname = acform.contactorname.value;
            var idCardno = acform.idCardno.value;
            var contactormphone = acform.contactormphone.value;
            var business_license_url = acform.business_license_url.value;
            var tender_file_urls = acform.tender_file_urls.value;

            if (GLName == "" || GLName == null) {
                $.msgbox({
                    height:120,
                    width:300,
                    content:{type:'alert', content:'申请保函名称不能为空'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            if (isEmpty(idCardno)==false) {
                if(checkIDCARD(idCardno)==false) {
                    $.msgbox({
                        height: 120,
                        width: 300,
                        content: {type: 'alert', content: '联系人身份证号格式错误，请收入正确的身份证号'},
                        animation: 0,        //禁止拖拽
                        drag: false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                    return false;
                }
            } else {
                idCardno = "";
            }

            if (isEmpty(contactormphone)==false) {
                if (checkMPhone(contactormphone)==false) {
                    $.msgbox({
                        height: 120,
                        width: 300,
                        content: {type: 'alert', content: '联系人手机号收入格式错误，请输入正确的手机号'},
                        animation: 0,        //禁止拖拽
                        drag: false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                    return false;
                }
            }else {
                contactormphone = "";
            }

            if (contactorname==null || contactorname=="") contactorname="";
            if (business_license_url==null || business_license_url=="") business_license_url="";
            if (tender_file_urls==null || tender_file_urls=="") tender_file_urls="";

            var messages = "GLName=" + GLName + "&compuuid=" + compuuid + "&enterprise_name=" + companyName  + "&enterprise_code=" + companyCode +
                "&project_name=" + projectname + "&project_code=" + projectcode + "&project_area=" + regioncode + "&section_name=" + sectionName +
                "&section_code=" + sectionCode + "&tenderer=" + buyername + "&agency=" + agentname + "&tenderer_address=" + buyeraddr + "&tender_type=" + tenderprojtype +
                "&tender_bond=" + margin + "&tender_start_time=" + startdate + "&tender_expire=" + enddate + "&agent_name=" + contactorname +
                "&agent_id_no=" + idCardno + "&agent_phone=" + contactormphone + "&business_license_url=" + business_license_url + "&tender_file_urls=" + tender_file_urls;

            var signinfo = hex_md5(messages);

            htmlobj=$.ajax({
                url:"/ApplyGuaranteeLetter.do",
                type:"POST",
                data: {
                    GLName:encodeURI(GLName),
                    compuuid:encodeURI(compuuid),
                    enterprise_name:encodeURI(companyName),
                    enterprise_code:encodeURI(companyCode),
                    project_name:encodeURI(projectname),
                    project_code:encodeURI(projectcode),
                    project_area:encodeURI(regioncode),
                    section_name:encodeURI(sectionName),
                    section_code:encodeURI(sectionCode),
                    tenderer:encodeURI(buyername),
                    agency:encodeURI(agentname),
                    tenderer_address:encodeURI(buyeraddr),
                    tender_type:encodeURI(tenderprojtype),
                    tender_bond:encodeURI(margin),
                    tender_start_time:encodeURI(startdate),
                    tender_expire:encodeURI(enddate),
                    agent_name:encodeURI(contactorname),
                    agent_id_no:encodeURI(idCardno),
                    agent_phone:encodeURI(contactormphone),
                    business_license_url:encodeURI(business_license_url),
                    tender_file_urls:encodeURI(tender_file_urls),
                    sign:signinfo,
                    action:action
                },
                dataType:'json',
                async:false,
                success:function(data){
                    alert(data);
                }
            });
        }
    </script>
</head>
<body>
<div class="full_box">
    <div class="top_box">
        <!--#include virtual="/inc/head.shtml"-->
    </div>
    <div class="menu_box">
        <!--#include virtual="/inc/menu.shtml"-->
    </div>
</div>
<!--以上页面头-->
<div class="main clearfix div_top div_bottom">
    <form name="acform">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="1"  style="margin-top:25px;">
            <tr>
                <td align="right">
                    保函名称：
                </td>
                <td align="left" colspan="3">
                    <input type="text" name="glName" value="" size="130"><span class="red">*</span>
                    <input type="hidden" name="compuuid" value="<%=purchasingAgency.getUuid()%>">
                    <input type="hidden" name="start" value="<%=startrow%>">
                    <input type="hidden" name="rows" value="<%=rows%>">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    企业名称：
                </td>
                <td align="left">
                    <input type="text" name="companyName" value="<%=(purchasingAgency.getOrganName()==null)?"":purchasingAgency.getOrganName()%>" readonly><span class="red">*</span>
                </td>
                <td align="right">
                    企业统一社会信用代码：
                </td>
                <td align="left">
                    <input type="text" name="companyCode" value="<%=(purchasingAgency.getLegalCode()==null)?"":purchasingAgency.getLegalCode()%>" readonly><span class="red">*</span>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    项目名称：
                </td>
                <td align="left">
                    <input type="text" name="projectname" value="<%=(purchaseProject.getPurchasername()==null)?"":purchaseProject.getPurchasername()%>" readonly>
                </td>
                <td align="right">
                    项目编码：
                </td>
                <td align="left">
                    <input type="text" name="projectcode" value="<%=(purchaseProject.getPurchaseprojcode()==null)?"":purchaseProject.getPurchaseprojcode()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    项目所在区域：
                </td>
                <td align="left">
                    <input type="text" name="regioncode" value="<%=(budgetProject.getRegioncode()==null)?"":budgetProject.getRegioncode()%>" readonly>
                </td>
                <td align="right">
                    招标类型：
                </td>
                <td align="left">
                    <input type="text" name="biddingtype" value="<%=(tenderProjType==null)?"":tenderProjType%>" readonly>
                    <input type="hidden" name="tenderprojtype" value="<%=(budgetProject.getTenderprojtype()==null)?"":budgetProject.getTenderprojtype()%>">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    标包名称：
                </td>
                <td align="left">
                    <input type="text" name="sectionName" value="<%=(section.getSectionname()==null)?"":section.getSectionname()%>" readonly>
                </td>
                <td align="right">
                    标包编码：
                </td>
                <td align="left">
                    <input type="text" name="sectionCode" value="<%=(section.getPurchasesectioncode()==null)?"":section.getPurchasesectioncode()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    采购人名称：
                </td>
                <td align="left">
                    <input type="text" name="buyername" value="<%=(bulletinNotice.getBuyerName()==null)?"":bulletinNotice.getBuyerName()%>" readonly>
                </td>
                <td align="right">
                    采购人地址：
                </td>
                <td align="left">
                    <input type="text" name="buyeraddr" value="<%=(bulletinNotice.getBuyerAddress()==null)?"":bulletinNotice.getBuyerAddress()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    招标代理机构：
                </td>
                <td align="left">
                    <input type="text" name="agentname" value="<%=(bulletinNotice.getAgentName()==null)?"":bulletinNotice.getAgentName()%>" readonly>
                </td>
                <td align="right">
                    保证金金额：
                </td>
                <td align="left">
                    <input type="text" name="margin" value="<%=(section.getMargin().floatValue()==0.0)?"":String.valueOf(section.getMargin().floatValue())%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    投标生效日期：
                </td>
                <td align="left">
                    <input type="text" name="startdate" value="<%=(bulletinNotice.getTenderStartTime()==null)?"":sdf.format(bulletinNotice.getTenderStartTime())%>" readonly>
                </td>
                <td align="right">
                    投标截止日期：
                </td>
                <td align="left">
                    <input type="text" name="enddate" value="<%=(bulletinNotice.getTenderEndTime()==null)?"":sdf.format(bulletinNotice.getTenderEndTime())%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    经办人姓名：
                </td>
                <td align="left">
                    <input type="text" name="contactorname" value="">
                </td>
                <td align="right">
                    经办人证件号：
                </td>
                <td align="left">
                    <input type="text" name="idCardno" value="">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    经办人手机号：
                </td>
                <td align="left">
                    <input type="text" name="contactormphone" value="">
                </td>
                <td align="right">
                    营业执照下载路径：
                </td>
                <td align="left">
                    <input type="text" name="business_license_url" value="">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    招标文件下载路径
                </td>
                <td align="left"><input type="text" name="tender_file_urls" value=""></td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="center" colspan="4" >
                    <input type="button" name="save" value="保存" onclick="tijiao('dosave');" style="line-height: 20px;font-size: 14px;padding: 5px 15px">&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" name="dosubmit" value="提交"  onclick="tijiao('dosubmit');" style="line-height: 20px;font-size: 14px;padding: 5px 15px">&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" name="back" value="返回" onclick="javascript:window.close();"  style="line-height: 20px;font-size: 14px;padding: 5px 15px">
                </td>
            </tr>
        </table>
    </form>
</div>
<!--以下页面尾-->
</body>
</html>
