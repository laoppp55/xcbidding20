<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.service.*" %>
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

    bhApplyGuarantee bhApplyGuarantee = null;
    String tenderProjType = null;
    if (appContext!=null) {
        IFinanceService financeService = (IFinanceService)appContext.getBean("financeService");
        bhApplyGuarantee = financeService.queryGuaranteeLetter(projsectioncode);
    }

    if (bhApplyGuarantee.getTender_type().trim().equals("1"))
        tenderProjType = "工程类";
    else if (bhApplyGuarantee.getTender_type().trim().equals("2"))
        tenderProjType = "货物类";
    else if (bhApplyGuarantee.getTender_type().trim().equals("3"))
        tenderProjType = "服务类";
    else
        tenderProjType = "其他";
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心--申请保函管理</title>
    <!--link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css" />
    <!--link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css"-->
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
            var hbuuid = acform.hbuuid.value;
            var delayDays = acform.delayDays.value;
            var GLCode = acform.GLCode.value;

            if (delayDays == "" || delayDays == null) {
                $.msgbox({
                    height:120,
                    width:300,
                    content:{type:'alert', content:'申请保函延期的天数不能为空'},
                    animation:0,        //禁止拖拽
                    drag:false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }

            var messages = "&hbuuid=" + hbuuid + "GLCode=" + GLCode + "&delayDays=" + delayDays;

            var signinfo = hex_md5(messages);

            htmlobj=$.ajax({
                url:"/ApplyGuaranteeLetterDelay.do",
                type:"POST",
                data: {
                    GLCode:encodeURI(GLCode),
                    hbuuid:encodeURI(hbuuid),
                    delayDays:encodeURI(delayDays),
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
<body style="background-image: url('');height: 600px;">
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
                    <input type="text" name="glName" value="<%=bhApplyGuarantee.getGl_name()%>" size="130"><span class="red">*</span>
                    <input type="hidden" name="hbuuid" value="<%=bhApplyGuarantee.getUuid()%>">
                    <input type="hidden" name="start" value="<%=startrow%>">
                    <input type="hidden" name="rows" value="<%=rows%>">
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    保函名称：
                </td>
                <td align="left">
                    <input type="text" name="glName" value="<%=(bhApplyGuarantee.getGl_name()==null)?"":bhApplyGuarantee.getGl_name()%>" readonly><span class="red">*</span>
                </td>
                <td align="right">
                    保函业务码：
                </td>
                <td align="left">
                    <input type="text" name="GLCode" value="<%=(bhApplyGuarantee.getGuarantee_no()==null)?"":bhApplyGuarantee.getGuarantee_no()%>" readonly><span class="red">*</span>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    延期时间（单位天）：
                </td>
                <td align="left">
                    <input type="text" name="delayDays" value="">
                </td>
                <td align="right">
                    保函受理日期：
                </td>
                <td align="left">
                    <input type="text" name="createtime" value="<%=sdf.format(bhApplyGuarantee.getCreatetime())%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    项目名称：
                </td>
                <td align="left">
                    <input type="text" name="projectname" value="<%=(bhApplyGuarantee.getProject_name()==null)?"":bhApplyGuarantee.getProject_name()%>" readonly>
                </td>
                <td align="right">
                    项目编码：
                </td>
                <td align="left">
                    <input type="text" name="projectcode" value="<%=(bhApplyGuarantee.getProject_code()==null)?"":bhApplyGuarantee.getProject_code()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    标包名称：
                </td>
                <td align="left">
                    <input type="text" name="sectionName" value="<%=(bhApplyGuarantee.getSection_name()==null)?"":bhApplyGuarantee.getSection_name()%>" readonly>
                </td>
                <td align="right">
                    标包编码：
                </td>
                <td align="left">
                    <input type="text" name="sectionCode" value="<%=(bhApplyGuarantee.getSection_code()==null)?"":bhApplyGuarantee.getSection_code()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    采购人名称：
                </td>
                <td align="left">
                    <input type="text" name="buyername" value="<%=(bhApplyGuarantee.getTenderer()==null)?"":bhApplyGuarantee.getTenderer()%>" readonly>
                </td>
                <td align="right">
                    采购人地址：
                </td>
                <td align="left">
                    <input type="text" name="buyeraddr" value="<%=(bhApplyGuarantee.getTenderer_address()==null)?"":bhApplyGuarantee.getTenderer_address()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="right">
                    招标代理机构：
                </td>
                <td align="left">
                    <input type="text" name="agentname" value="<%=(bhApplyGuarantee.getAgency()==null)?"":bhApplyGuarantee.getAgency()%>" readonly>
                </td>
                <td align="right">
                    保证金金额：
                </td>
                <td align="left">
                    <input type="text" name="margin" value="<%=(bhApplyGuarantee.getTender_bond()==null)?"":bhApplyGuarantee.getTender_bond()%>" readonly>
                </td>
            </tr>
            <tr height="10"><td></td></tr>
            <tr>
                <td align="center" colspan="4" >
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
