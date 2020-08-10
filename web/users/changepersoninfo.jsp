<%-- Created by IntelliJ IDEA. --%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) response.sendRedirect("/users/login.jsp");
    String userid = authToken.getUserid();
    int siteid = authToken.getSiteid();
    Users user = null;
    int errcode = 0;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(userid);

        if (user==null) response.sendRedirect("/users/error.jsp");

        boolean doUpdate = ParamUtil.getBooleanParameter(request,"doUpdate");

        if (doUpdate) {
            String realname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "realname"));
            String email = filter.excludeHTMLCode(ParamUtil.getParameter(request, "email"));
            String mphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "mphone"));
            String fax = filter.excludeHTMLCode(ParamUtil.getParameter(request, "fax"));
            String address = filter.excludeHTMLCode(ParamUtil.getParameter(request, "address"));
            String companyname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "companyname"));
            String works = filter.excludeHTMLCode(ParamUtil.getParameter(request, "works"));
            String yzcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "yzcode"));
            String yzcodeForSession = (String)session.getAttribute("randnum");

            if (yzcode.equalsIgnoreCase(yzcodeForSession)) {
                user.setSITEID(BigDecimal.valueOf(siteid));
                user.setUSERID(userid);
                user.setEMAIL(email);
                user.setMPHONE(mphone);
                user.setPHONE(fax);
                user.setADDRESS(address);
                user.setCOMPANY(companyname);
                user.setAREA(works);
                user.setNICKNAME(realname);
                user.setCREATEDATE(new Timestamp(System.currentTimeMillis()));
                user.setORGID(BigDecimal.valueOf(0));
                user.setCOMPANYID(BigDecimal.valueOf(0));
                user.setDEPTID(BigDecimal.valueOf(0));
                user.setDEPARTMENT("0");
                errcode = usersService.updateUserinfoByUseridSelective(user);
            }
        }
    } else {
        response.sendRedirect("/users/m/error.jsp");
    }
%>
<html>
<head>
    <title>北京城建集团党校（培训中心）--修改注册信息</title>
    <link href="/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/css/css_in.css" rel="stylesheet" type="text/css" />
    <link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/js/users.js" type="text/javascript"></script>
    <script language="javascript">
        var falg = false;
        var sucess = "";
        var errcode = <%=errcode%>;
        $(document).ready(function(){
            if (errcode == -2) {
                $("#emailmsg").html("电子邮件地址已经被使用");
                $("#emailmsg").css({color:"red"});
            } else if (errcode == -3) {
                $("#mphonemsg").html("手机号码被使用");
                $("#mphonemsg").css({color:"red"});
            } else if (errcode == -5) {
                $("#usermsg").html("运行环境初始化错误，请联系客服人员");
                $("#usermsg").css({color:"red"});
            } else if (errcode > 0) {
                alert("修改注册信息成功，点击确认按钮关闭注册信息修改页面");
                window.location.href="/users/m/changepersoninfo.jsp";
            }

            $.post("/users/showLoginInfo.jsp",{
                        username:encodeURI(name)
                    },
                    function(data) {
                        if (data.username!=null) {
                            $("#userInfos").html("欢迎你：<font color=\"red\">" + data.username + "</font>&nbsp;&nbsp;<a href='#' onclick=\"javascript:logoff('m');\">退出</a>");
                        }
                    },
                    "json"
            )
        })

        function ismail(mail) {
            falg = (new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(mail));

            if (falg) {
                sucess = "sucess";
            }
        }

        function change_yzcodeimage() {
            $("#yzImageID").attr("src","/users/image.jsp?temp=" + Math.random());
        }

        function setMessage(ftype) {
            var email = regform.email.value;
            var mphone = regform.mphone.value;

            if (ftype=="emailmsg") {
                //检查电子邮件地址是否存在
                $.post("checkemail.jsp",
                        {
                            email:encodeURI(email)
                        },
                        function(data) {
                            if (data.indexOf("true") > -1) {
                                $("#emailmsg").html("电子邮件地址已经被注册过");
                                $("#emailmsg").css({color:"red"});
                                regform.doflag.value=0;
                            } else {
                                $("#emailmsg").html("电子邮件地址可以使用");
                                $("#emailmsg").css({color:"green"});
                                regform.doflag.value=1;
                            }
                        }
                )
            } else if (ftype=="mphonemsg") {
                //检查移动电话号码是否存在
                $.post("checkcellphone.jsp",
                        {
                            mphone:encodeURI(mphone)
                        },
                        function(data) {
                            if (data.indexOf("true") > -1) {
                                $("#mphonemsg").html("手机号码已经被注册过");
                                $("#mphonemsg").css({color:"red"});
                                regform.doflag.value=0;
                            } else {
                                $("#mphonemsg").html("手机号码可以使用");
                                $("#mphonemsg").css({color:"green"});
                                regform.doflag.value=1;
                            }
                        }
                )
            }
        }

        function tijiao(form) {
            var email = form.email.value;
            var mphone = form.mphone.value;
            var companyname = form.companyname.value;
            var contactor = form.realname.value;
            var yzcode = form.yzcode.value;
            var doflag = form.doflag.value;

            //if (companyname=="") {
            //    alert("工作单位不能为空");
            //    return false;
            //}

            if (email == "") {
                alert("邮箱不能为空");
                return false;
            } else {
                //检查电子邮件地址是否存在
                var existflag = 0;
                htmlobj=$.ajax({
                    url:"checkemail.jsp",
                    type:'post',
                    dataType:'text',
                    data:{
                        email:encodeURI(email)
                    },
                    async:false,
                    cache:false,
                    success:function(data){
                        if (data.indexOf("true") > -1) {
                            existflag = 1;
                        }
                    }
                });
                if (existflag == 1) {
                    alert("电子邮件地址已经被注册过，请更换电子邮件地址！");
                    return false;
                }
            }

            ismail(email);

            if (sucess == "") {
                alert("请填写正确的EMAIL地址");
                return false;
            }

            if (mphone == "") {
                alert("手机号码字段不能为空，请填写手机号码");
                return false;
            }

            if (mphone != "") {
                //var filter = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;     //验证电话号码是否正确
                var filter = /^1[3|4|5|8][0-9]\d{4,8}$/;                                   //验证手机号码是否正确
                flag = filter.test(mphone);
                if (!flag) {
                    alert("电话输入有误，请重新输入！");
                    return false;
                } else {
                    //检查移动电话号码是否存在
                    var existflag = 0;
                    htmlobj=$.ajax({
                        url:"checkcellphone.jsp",
                        type:'post',
                        dataType:'text',
                        data:{
                            mphone:encodeURI(mphone)
                        },
                        async:false,
                        cache:false,
                        success:function(data){
                            if (data.indexOf("true") > -1) {
                                existflag = 1;
                            }
                        }
                    });
                    if (existflag == 1) {
                        alert("手机号码已经被注册过，请更换手机号码！");
                        return false;
                    }
                }
            } else {
                alert("手机号码不能为空，请输入手机号码！");
                return false;
            }

            //var fromway = "";
            //$("input:checkbox[name='fromway']:checked").each(function() {
            //    fromway = fromway + $(this).val() + " ";
            //});

            if (yzcode == "" || yzcode.length != 4) {
                alert("验证码不正确");
                return false;
            }

            /*var agreement = "";
             $("input:checkbox[name='agreement']:checked").each(function() {
             agreement = $(this).val();
             });

             if (agreement=="") {
             alert("请阅读协议，并勾选我已看过并同意条款才能通过");
             return false;
             }*/

            return true;
        }
    </script>
</head>
<body>
<div class="topbox"><%@include file="/inc/top.shtml" %></div>
<div class="main"><%@include file="/inc/menu.shtml" %></div>
<div class="con_box">
    <div class="personal_left">
        <div class="title">个人中心</div>
        <ul>
            <li><a href="/users/personinfo.jsp"> 我的订单</a></li>
            <li><font color="red">修改注册信息</font></li>
            <li><a href="/users/changePwd.jsp">修改密码</a></li>
            <!--li><a href="/users/m/invoices.jsp">发票信息</a></li>
            <li><a href="/users/m/addresses.jsp">送货地址信息</a></li-->
        </ul>
    </div>
    <div class="personal_right_box">
        <div class="personal_right">
            <div class="p_r_title">修改注册信息</div>
            <div class="cont">
                <form name="regform" method="post" action="changepersoninfo.jsp" onsubmit="return tijiao(regform)">
                    <input type="hidden" name="doUpdate" value="true">
                    <input type="hidden" name="doflag" value="1">
                    <table width="80%" border="0" align="center" cellpadding="0" cellspacing="1">
                        <tr>
                            <td width="21%" height="60">&nbsp;</td>
                            <td width="79%"><div id="usermsg"><span class="red"></span></div></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">真实姓名：</td>
                            <td><input name="realname" type="text" class="input_txt" size="30" value="<%=(user.getNICKNAME()!=null)?user.getNICKNAME():""%>"/></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle"></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">单位名称：</td>
                            <td><input name="companyname" type="text" class="input_txt" size="50" value="<%=(user.getCOMPANY()!=null)?user.getCOMPANY():""%>"/></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">E-mail：</td>
                            <td><input  name="email" type="text" class="input_txt" size="30" value="<%=(user.getEMAIL()!=null)?user.getEMAIL():""%>" onblur="javascript:setMessage('emailmsg')" /></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle" class="w_red"><div id="emailmsg"></div></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">工作领域：</td>
                            <td><input name="works" type="text" class="input_txt" size="30" value="<%=(user.getAREA()!=null)?user.getAREA():""%>" /></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle"> 通讯地址：</td>
                            <td><input name="address" type="text" class="input_txt" size="60" value="<%=(user.getADDRESS()!=null)?user.getADDRESS():""%>"/></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">手机：</td>
                            <td><input name="mphone" type="text" class="input_txt" size="30" value="<%=(user.getMPHONE()!=null)?user.getMPHONE():""%>" onblur="javascript:setMessage('mphonemsg')"/></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle"><div id="mphonemsg"></div></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">座机：</td>
                            <td><input name="phone" type="text" class="input_txt" size="30" value="<%=(user.getPHONE()!=null)?user.getPHONE():""%>"/></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">验证码：</td>
                            <td align="left" valign="middle"><input type="text" name="yzcode" class="input_txt" size="15"/></td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle"></td>
                            <td align="left" valign="bottom" height="20"><img src="/users/image.jsp" id="yzImageID" name="yzcodeimage" align="absmiddle"/> <a href="javascript:change_yzcodeimage();">看不清，换一张</a></td>
                        </tr>
                        <tr>
                            <td height="40">&nbsp;</td>
                            <td align="left" valign="middle">&nbsp;</td>
                        </tr>
                        <tr>
                            <td height="30">&nbsp;</td>
                            <td align="left" valign="middle"><input name="button" type="submit" class="regist_btn" id="button" value="保存修改" /></td>
                        </tr>
                        <tr>
                            <td height="60">&nbsp;</td>
                            <td align="left" valign="middle">&nbsp;</td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<div class="footbox"><%@include file="/inc/tail.shtml" %></div>
</body>
</html>
