<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.po.PurchasingAgency" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }
    String username = authToken.getUserid();
    Users user = null;
    PurchasingAgency purchasingAgency = null;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(username);
        purchasingAgency = usersService.getEnterpriseInfoByCompcode(user.getCOMPANYCODE());
    }

    if (purchasingAgency==null) {
        response.sendRedirect("/users/error.jsp");
    }

    int actionid = ParamUtil.getIntParameter(request,"action",0);

%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
    <!--link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css"-->
    <link href="/ggzyjy/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/ggzyjy/js/style.js" type="text/javascript" ></script>
    <script src="/ggzyjy/js/jquery.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
    <script language="javascript">
        //申请保函
        function applyGL(start,rows) {
            var sectionCodeAndName = $("input[name='projsectioncode']:checked").val();
            var posi = sectionCodeAndName.indexOf("-");
            var sectionName = "";
            var sectionCode = "";
            if (posi>-1) {
                sectionCode = sectionCodeAndName.substring(0,posi);
                sectionName = sectionCodeAndName.substring(posi+1);
            }

            //根据标包编码检查是否已经申请过了保函或者保证金子账号
            htmlobj=$.ajax({
                url:"/queryGuaranteeLetter.do",
                type:"POST",
                data: {
                    section_code:encodeURI(sectionCode)
                },
                dataType:'json',
                async:false,
                success:function(data){
                    var gl_exist_flag = 0;          //数值为0表示保函不存在

                    if (data!=null) {
                        if (data.accept_no!=null && data.accept_no!="" && data.accept_no!='') {
                            $.msgbox({
                                height:120,
                                width:300,
                                content:{type:'alert', content:'标包' + sectionName + '已经申请过保函，保函申请接收编号为：' + data.accept_no},
                                animation:0,        //禁止拖拽
                                drag:false          //禁止动画
                                //autoClose: 10       //自动关闭
                            });
                            gl_exist_flag = 1;
                        }
                    }

                    if (gl_exist_flag == 0) {
                        var iWidth=1000;                                                 //弹出窗口的宽度;
                        var iHeight=800;                                                //弹出窗口的高度;
                        var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
                        var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
                        window.open("/ec/applyGuaranteeLetter.jsp?projsectioncode=" + sectionCode + "&start=" + start + "&rows=" + rows, "CreateGuaranteeLetter", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
                    }
                }
            });
        }

        //查询保函申请结果
        function queryGL(start,rows) {
            var sectionCodeAndName = $("input[name='projsectioncode']:checked").val();
            var posi = sectionCodeAndName.indexOf("-");
            var sectionName = "";
            var sectionCode = "";
            if (posi>-1) {
                sectionCode = sectionCodeAndName.substring(0,posi);
                sectionName = sectionCodeAndName.substring(posi+1);
            }

            //根据标包编码检查是否已经申请过了保函或者保证金子账号
            var iWidth=1000;                                                 //弹出窗口的宽度;
            var iHeight=800;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/ec/queryGuaranteeLetter.jsp?projsectioncode=" + sectionCode + "&start=" + start + "&rows=" + rows, "CreateGuaranteeLetter", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
        }

        //申请保函延期
        function applyGLdelay(start,rows) {
            var sectionCodeAndName = $("input[name='projsectioncode']:checked").val();
            var posi = sectionCodeAndName.indexOf("-");
            var sectionName = "";
            var sectionCode = "";
            if (posi>-1) {
                sectionCode = sectionCodeAndName.substring(0,posi);
                sectionName = sectionCodeAndName.substring(posi+1);
            }
            //根据标包编码检查是否已经申请过了保函或者保证金子账号
            var iWidth=1000;                                                 //弹出窗口的宽度;
            var iHeight=800;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/ec/applyGuaranteeLetterDelay.jsp?projsectioncode=" + sectionCode + "&start=" + start + "&rows=" + rows, "CreateGuaranteeLetter", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
        }

        //查询延期申请结果
        function queryGLdelay(start,rows) {
            var sectionCodeAndName = $("input[name='projsectioncode']:checked").val();
            var posi = sectionCodeAndName.indexOf("-");
            var sectionName = "";
            var sectionCode = "";
            if (posi>-1) {
                sectionCode = sectionCodeAndName.substring(0,posi);
                sectionName = sectionCodeAndName.substring(posi+1);
            }
        }

        //保函解密
        function decriptGL(start,rows) {
            alert("decriptGL");
        }

        //修改保函申请
        function modifyGLApply(start,rows) {
            alert("modifyGLApply");
        }

        //删除保函申请
        function deleteGLApply(start,rows) {
            alert("deleteGLApply");
        }

        function queryPurchaseProjectsOfNeedMargin(start,rows) {
            htmlobj=$.ajax({
                url:"/ProjOfNeedMargin.do",
                data: {},
                dataType:'json',
                async:false,
                success:function(data){
                    //$("#projectsid").find("tr:not(:first)").remove();
                    $("#projectsid").find("tr").remove();
                    var htmlstr = "<tr bgcolor='white'><td colspan=\"11\" align=\"left\">" +
                        "<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:applyGL(" + start + "," + rows + ");\" value=\"申请保函\" />&nbsp;&nbsp;" +
                        "<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:queryGL(" + start + "," + rows + ");\" value=\"查询保函申请结果\" />&nbsp;&nbsp;" +
                        //"<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:decriptGL(" + start + "," + rows + ");\" value=\"保函解密\" />&nbsp;&nbsp;" +
                        //"<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:applyGLdelay(" + start + "," + rows + ");\" value=\"申请保函延期\" />&nbsp;&nbsp;" +
                        //"<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:queryGLdelay(" + start + "," + rows + ");\" value=\"查询延期申请结果\" />&nbsp;&nbsp;" +
                        "<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:modifyGLApply(" + start + "," + rows + ");\" value=\"修改保函申请\" />&nbsp;&nbsp;" +
                        "<input type=\"button\" name=\"applyGuarantee\" onclick=\"javascript:deleteGLApply(" + start + "," + rows + ");\" value=\"删除保函申请\" />&nbsp;&nbsp;" +
                        "</td></tr>" +
                        "          <tr>\n" +
                        "                <td width=\"5%\" height=\"25\" align=\"center\" valign=\"middle\">&nbsp;</td>\n" +
                        "                <td width=\"10%\" height=\"25\" align=\"center\" valign=\"middle\">采购项目名称</td>\n" +
                        //"                <td width=\"15%\" align=\"center\" valign=\"middle\" >采购项目编号</td>\n" +
                        "                <td width=\"10%\" align=\"center\" valign=\"middle\" >标包名称</td>\n" +
                        //"                <td width=\"10%\" align=\"center\" valign=\"middle\" >标包编号</td>\n" +
                        //"                <td width=\"10%\" align=\"center\" valign=\"middle\" >采购人</td>\n" +
                        "                <td width=\"7%\" align=\"center\" valign=\"middle\" >保证金数额</td>\n" +
                        "                <td width=\"15%\" align=\"center\" valign=\"middle\" >保函申请名称</td>\n" +
                        "                <td width=\"8%\" align=\"center\" valign=\"middle\" >申请编号</td>\n" +
                        "                <td width=\"8%\" align=\"center\" valign=\"middle\" >申请状态</td>\n" +
                        "                <td width=\"8%\" align=\"center\" valign=\"middle\" >受理编号</td>\n" +
                        "                <td width=\"9%\" align=\"center\" valign=\"middle\" >创建时间</td>\n" +
                        "            </tr>\n";
                    for(var ii=0; ii<data.length;ii++) {
                        var apply_no = "";
                        if (data[ii].apply_no!=null && data[ii].apply_no!="" && data[ii].apply_no!='') apply_no = data[ii].apply_no;
                        var status_val = "";
                        if (data[ii].status!=null && data[ii].status!="" && data[ii].status!='') {
                            if (data[ii].status == -1)
                                status_val = "保存未提交";
                            else if (data[ii].status == 0)
                                status_val = "提交审核中";
                            else if (data[ii].status == 1)
                                status_val = "通过审核";
                            else if (data[ii].status == 1)
                                status_val = "审核未通过";
                        }
                        var accept_no = "";
                        if (data[ii].accept_no!=null && data[ii].accept_no!="" && data[ii].accept_no!='') accept_no = data[ii].accept_no;
                        var gl_name = "";
                        if (data[ii].gl_name!=null && data[ii].gl_name!="" && data[ii].gl_name!='') gl_name = data[ii].gl_name;

                        htmlstr = htmlstr + "<tr>\n" +
                            "                <td width=\"5%\" height=\"25\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" +
                            "                <input type=\"radio\" name=\"projsectioncode\" value=\"" + data[ii].projectSectionCode + "-"+ data[ii].projectSectionName + "\"/>" +
                            "                </td>\n" +
                            "                <td width=\"10%\" height=\"25\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + data[ii].projectName + "</td>\n" +
                            //"                <td width=\"15%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].projectCode+"</td>\n" +
                            "                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].projectSectionName+"</td>\n" +
                            //"                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].projectSectionCode+"</td>\n" +
                            //"                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].buyer+"</td>\n" +
                            "                <td width=\"8%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+ data[ii].margin + "</td>\n" +
                            "                <td width=\"15%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+ gl_name + "</td>\n" +
                            "                <td width=\"7%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + apply_no + "</td>\n" +
                            "                <td width=\"8%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + status_val + "</td>\n" +
                            "                <td width=\"8%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + accept_no + "</td>\n" +
                            "                <td width=\"9%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + data[ii].createdate + "</td>\n" +
                            "            </tr>\n"
                    }
                    $("#projectsid").append(htmlstr);
                }
            });
        }

        function createApplyCredit() {
            var iWidth=window.screen.availWidth-400;                                                 //弹出窗口的宽度;
            var iHeight=600;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/ec/applyCredit.jsp", "CreateApplyCredit", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
        }

        function updateApplyCredit(uuid,start,rows) {
            var iWidth=window.screen.availWidth-400;                                                 //弹出窗口的宽度;
            var iHeight=600;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/ec/updateApplyCredit.jsp?uuid=" + uuid + "&start=" + start + "&rows=" + rows, "updateApplyCredit", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
        }

        function queryApplyCredit(uuid,start,rows) {
            var iWidth=window.screen.availWidth-400;                                                 //弹出窗口的宽度;
            var iHeight=600;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/ec/queryApplyCredit.jsp?uuid=" + uuid + "&start=" + start + "&rows=" + rows, "queryApplyCredit", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
        }

        function deleteApplyCredit(uuid) {
            htmlobj=$.ajax({
                url:"/deleteApplyCredit.do",
                data: {
                    uuid:uuid
                },
                dataType:'json',
                async:false,
                success:function(data){
                    alert(data);
                    getApplyCredits();
                }
            });
        }

        function submitApplyCredit(uuid) {
            htmlobj=$.ajax({
                url:"/submitApplyCredit.do",
                data: {
                    uuid:uuid
                },
                dataType:'json',
                async:false,
                success:function(data){
                    alert(data);
                    getApplyCredits();
                }
            });
        }

        function getApplyCredits(){
            htmlobj=$.ajax({
                url:"/ApplyCreditList.do",
                data: {},
                dataType:'json',
                async:false,
                success:function(data){
                    //$("#projectsid").find("tr:not(:first)").remove();
                    $("#projectsid").find("tr").remove();
                    //var htmlstr = "<tr bgcolor='white'><td colspan=\"2\"><%=purchasingAgency.getOrganName()%></td><td><%=purchasingAgency.getLegalCode()%></td><td colspan=\"7\" align=\"right\"><a href=\"javascript:createApplyCredit("+start + "," + rows + ");\">新建申请</a></td></tr>" +
                    var htmlstr = "<tr>\n" +
                        "                <td width=\"10%\" height=\"25\" align=\"center\" valign=\"middle\">授信申请名称</td>\n" +
                        "                <td width=\"30%\" align=\"center\" valign=\"middle\">授信申请编号</td>\n" +
                        "                <td width=\"10%\" align=\"center\" valign=\"middle\">申请时间</td>\n" +
                        "                <td width=\"10%\" align=\"center\" valign=\"middle\">申请状态</td>\n" +
                        "                <td width=\"10%\" align=\"center\" valign=\"middle\">受理编号</td>\n" +
                        "                <td width=\"10%\" align=\"center\" valign=\"middle\">申请人</td>\n" +
                        "                <td width=\"5%\" align=\"center\" valign=\"middle\">查询</td>\n" +
                        "                <td width=\"5%\" align=\"center\" valign=\"middle\">修改</td>\n" +
                        "                <td width=\"5%\" align=\"center\" valign=\"middle\">删除</td>\n" +
                        "                <td width=\"5%\" align=\"center\" valign=\"middle\">提交</td>\n" +
                        "            </tr>\n";
                    for(var ii=0; ii<data.length;ii++) {
                        var status_val = "";
                        var update_button = "";
                        var delete_button = "";
                        var submit_button = "";
                        if (data[ii].status==-2) {
                            status_val = "未提交";
                            update_button = "<input type=\"button\" name=\"doUpdate\" value=\"修改\" onclick=\"javascript:updateApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            delete_button = "<input type=\"button\" name=\"doDelete\" value=\"删除\" onclick=\"javascript:deleteApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            submit_button = "<input type=\"button\" name=\"doSubmit\" value=\"提交\" onclick=\"javascript:submitApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                        }else if (data[ii].status==-1) {
                            status_val = "未授信";
                            update_button = "<input type='button' name='doUpdate' value='修改' disabled>";
                            delete_button = "<input type='button' name='doDelete' value='删除' disabled>";
                            submit_button = "<input type='button' name='doSubmit' value='提交' disabled>";
                        }else if (data[ii].status==0) {
                            status_val = "审核中";
                            update_button = "<input type=\"button\" name=\"doUpdate\" value=\"修改\" onclick=\"javascript:updateApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            delete_button = "<input type=\"button\" name=\"doDelete\" value=\"删除\" onclick=\"javascript:deleteApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            submit_button = "<input type=\"button\" name=\"doSubmit\" value=\"提交\" onclick=\"javascript:submitApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                        }else if (data[ii].status==1) {
                            status_val = "审核通过";
                            update_button = "<input type=\"button\" name=\"doUpdate\" value=\"修改\" onclick=\"javascript:updateApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            delete_button = "<input type=\"button\" name=\"doDelete\" value=\"删除\" onclick=\"javascript:deleteApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            submit_button = "<input type=\"button\" name=\"doSubmit\" value=\"提交\" onclick=\"javascript:submitApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                        }else if (data[ii].status==2) {
                            status_val = "审核不通过";
                            update_button = "<input type=\"button\" name=\"doUpdate\" value=\"修改\" onclick=\"javascript:updateApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            delete_button = "<input type=\"button\" name=\"doDelete\" value=\"删除\" onclick=\"javascript:deleteApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                            submit_button = "<input type=\"button\" name=\"doSubmit\" value=\"提交\" onclick=\"javascript:submitApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\">";
                        }

                        htmlstr = htmlstr + "<tr>\n" +
                            "                <td width=\"10%\" height=\"25\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + data[ii].applyname + "</td>\n" +
                            "                <td width=\"30%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].applyno+"</td>\n" +
                            "                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].createtime+"</td>\n" +
                            "                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+status_val+"</td>\n" +
                            "                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].acceptno+"</td>\n" +
                            "                <td width=\"10%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">"+data[ii].creator+"</td>\n" +
                            "                <td width=\"5%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\"><input type=\"button\" name=\"doQuery\" value=\"查询\" onclick=\"javascript:queryApplyCredit('" + data[ii].uuid + "'," + start + "," + rows + ")\"></td>\n" +
                            "                <td width=\"5%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + update_button + "</td>\n" +
                            "                <td width=\"5%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + delete_button + "</td>\n" +
                            "                <td width=\"5%\" align=\"center\" valign=\"middle\" bgcolor=\"#f6f4f5\">" + submit_button + "</td>\n" +
                            "            </tr>\n"
                    }
                    $("#projectsid").append(htmlstr);
                }
            });
        }
    </script>
</head>

<body style="background-image: url('');height: 600px;">
<div class="top_box">
    <div class="logo_box">
        <a href="/ggzyjy/" style="color: white">北京市西城区公共资源交易中心</a>
        <div class="reg_in" id="userInfos"><a href="/users/login.jsp">登录</a>|<a href="/users/userreg1.jsp">注册</a></div>
    </div>
</div>
<!--以上页面头-->
<div class="main clearfix div_top div_bottom">
    <div class="personal_left">
        <div class="title">个人中心</div>
        <ul>
            <li><a href="/ec/myBidinfos.jsp">投标项目管理</a></li>
            <li><a href="/users/personinfo.jsp?action=2"><%=(actionid==2)?"<span style=\"color: red\">":""%>授信申请管理<%=(actionid==2)?"</span>":""%></a></li>
            <li><a href="/users/personinfo.jsp?action=3"><%=(actionid==3)?"<span style=\"color: red\">":""%>保证金管理<%=(actionid==3)?"</span>":""%></a></li>
            <li><a href="/users/companyinfo.jsp">公司信息管理</a></li>
            <li><a href="/users/updatereg.jsp">修改个人注册信息</a></li>
            <li><a href="/users/changePwd.jsp">修改密码</a></li>
        </ul>
    </div>
    <div class="personal_right_box">
        <div id="div1" style="margin-top: 20px;text-align: left"><%=purchasingAgency.getOrganName()+":" + purchasingAgency.getLegalCode()%></div>
        <div style="margin-top: 20px;float: right"><a href="javascript:createApplyCredit();">新建申请</a></div>
        <div id="div2" style="margin-top: 5px;">
            <table id="projectsid" width="1000" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-top:25px;">
            </table>
        </div>
    </div>
</div>
<!--以下页面尾-->
</body>
<script language="javascript">
    $(document).ready(function(){
        //检测用户是否通过采购中心的审核
        var auditResult = "";
        htmlobj = $.ajax({
            url: "/users/showAuditResult.jsp?thetime=<%=System.currentTimeMillis()%>",
            type: 'post',
            dataType: 'json',
            data: {},
            async: false,
            cache: false,
            success: function (data) {
                if (data.auditstatus!=null) {
                    auditResult = data.auditstatus;
                }
            }
        });

        $.post("/users/showLoginInfo.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color='red'>" + data.username + "(<a href=\"javascript:showAuditInfo();\"><span style='color: #F7FF78'>" + auditResult + "</span></a>)" + "</font>  <span><a href='#' onclick=\"javascript:logoff();\">退出</a></span>" + "<span><a href=\"/users/personinfo.jsp\">个人中心</a></span>");
                }
            },
            "json"
        );

        var action = <%=actionid%>;
        if (action == 2)
            getApplyCredits(0,20);
        else if (action == 3)
            queryPurchaseProjectsOfNeedMargin(0,20);
        else
            window.document.location = "/ec/myBidinfos.jsp"
    })

    function showAuditInfo() {
        htmlobj = $.ajax({
            url: "/users/showAuditResult.jsp?thetime=<%=System.currentTimeMillis()%>",
            type: 'post',
            dataType: 'json',
            data: {},
            async: false,
            cache: false,
            success: function (data) {
                if (data!=null) {
                    $.msgbox({
                        height: 300,
                        width: 400,
                        content: {type: 'alert', content: "采购中心审核信息："+data.reason},
                        animation: 0,        //禁止拖拽
                        drag: false          //禁止动画
                        //autoClose: 10       //自动关闭
                    });
                }
            }
        });
    }
</script>
</html>
