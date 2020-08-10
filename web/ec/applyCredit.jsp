<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.po.PurchasingAgency" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    int startrow = ParamUtil.getIntParameter(request,"start",0);
    int rows = ParamUtil.getIntParameter(request,"rows",20);

    String username = authToken.getUsername();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    PurchasingAgency purchasingAgency = null;
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        Users us= usersService.getUserinfoByUserid(username);
        purchasingAgency = usersService.getEnterpriseInfoByCompcode(us.getCOMPANYCODE());
    }

    if (purchasingAgency==null) {
        response.sendRedirect("/error.jsp");
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心--申请授信额度</title>
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
        function tijiao(action) {
            var creditName = acform.creditName.value;
            var compuuid = acform.compuuid.value;
            var companyName = acform.companyName.value;
            var companyCode = acform.companyCode.value;
            var baseAccount = acform.baseAccount.value;
            var bankOfBaseAccount = acform.bankOfBaseAccount.value;
            var email = acform.email.value;
            var lawPersonName = acform.lawPersonName.value;
            var idCard = acform.idCard.value;
            var businessLicenseUrl = acform.businessLicenseUrl.value;
            var enterprisePerformances = acform.enterprisePerformances.value;

            if (creditName == "" || creditName == null) {
                $.msgbox({
                    height:120,
                    width:300,
                    content:{type:'alert', content:'申请授信名称不能为空'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return;
            }

            if (companyName == "" || companyName == null) {
                $.msgbox({
                    height:120,
                    width:300,
                    content:{type:'alert', content:'公司名称不能为空'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return;
            }

            if (companyCode == "" || companyCode == null) {
                $.msgbox({
                    height:120,
                    width:300,
                    content:{type:'alert', content:'公司统一社会信用代码不能为空'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return;
            }

            htmlobj=$.ajax({
                url:"/ApplyCredit.do",
                type:"POST",
                data: {
                    creditName:encodeURI(creditName),
                    compuuid:encodeURI(compuuid),
                    companyName:encodeURI(companyName),
                    companyCode:encodeURI(companyCode),
                    baseAccount:encodeURI(baseAccount),
                    bankOfBaseAccount:encodeURI(bankOfBaseAccount),
                    email:encodeURI(email),
                    lawPersonName:encodeURI(lawPersonName),
                    idCard:encodeURI(idCard),
                    businessLicenseUrl:encodeURI(businessLicenseUrl),
                    enterprisePerformances:encodeURI(enterprisePerformances),
                    action:action
                },
                dataType:'json',
                async:false,
                success:function(data){
                    alert(data.errcode + data.errmsg);
                    window.opener.getApplyCredits(<%=startrow%>,<%=rows%>);
                    window.close();
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
                    申请授信名称：
                </td>
                <td align="left" colspan="3">
                    <input type="text" name="creditName" value="" size="130"><span class="red">*</span>
                    <input type="hidden" name="compuuid" value="<%=purchasingAgency.getUuid()%>">
                    <input type="hidden" name="start" value="<%=purchasingAgency.getUuid()%>">
                    <input type="hidden" name="rows" value="<%=purchasingAgency.getUuid()%>">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    企业名称：
                </td>
                <td align="left">
                    <input type="text" name="companyName" value="<%=(purchasingAgency.getOrganName()==null)?"":purchasingAgency.getOrganName()%>"><span class="red">*</span>
                </td>
                <td align="right">
                    企业统一社会信用代码：
                </td>
                <td align="left">
                    <input type="text" name="companyCode" value="<%=(purchasingAgency.getLegalCode()==null)?"":purchasingAgency.getLegalCode()%>"><span class="red">*</span>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    基本户账户：
                </td>
                <td align="left">
                    <input type="text" name="baseAccount" value="<%=(purchasingAgency.getBankAccount()==null)?"":purchasingAgency.getBankAccount()%>">
                </td>
                <td align="right">
                    基本户开户行：
                </td>
                <td align="left">
                    <input type="text" name="bankOfBaseAccount" value="<%=(purchasingAgency.getBank()==null)?"":purchasingAgency.getBank()%>">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    法人代表名称：
                </td>
                <td align="left">
                    <input type="text" name="lawPersonName" value="<%=(purchasingAgency.getPersonName()==null)?"":purchasingAgency.getPersonName()%>">
                </td>
                <td align="right">
                    法人代表身份证号：
                </td>
                <td align="left">
                    <input type="text" name="idCard" value="<%=(purchasingAgency.getPersonIdcard()==null)?"":purchasingAgency.getPersonIdcard()%>">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    企业邮箱：
                </td>
                <td align="left">
                    <input type="text" name="email" value="<%=(purchasingAgency.getLegalemail()==null)?"":purchasingAgency.getLegalemail()%>">
                </td>
                <td align="right">
                    营业执照下载地址：
                </td>
                <td align="left">
                    <input type="text" name="businessLicenseUrl" value="">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    企业业绩：
                </td>
                <td align="left">
                    <input type="text" name="enterprisePerformances" value="">
                </td>
                <td align="right">
                </td>
                <td align="left">
                </td>
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