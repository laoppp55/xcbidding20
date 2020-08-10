<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.po.PurchasingAgency" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken==null) response.sendRedirect("/users/login.jsp");
    String userid = authToken.getUserid();
    Users user = null;
    int errcode = 0;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    PurchasingAgency suppinfo = null;
    BigDecimal sex = null;
    int sex_val = -1;
    if (appContext!=null) {
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        user = usersService.getUserinfoByUserid(userid);
        if (user==null) {
            response.sendRedirect("/users/error.jsp");
        } else
            sex = user.getSEX();
        if (sex!=null) sex_val = sex.intValue();
        suppinfo = usersService.getEnterpriseInfo(user.getCOMPANY());
    } else {
        response.sendRedirect("/users/error.jsp");
    }
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
    <!--link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css"-->
    <link href="/ggzyjy/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/ggzyjy/js/style.js" type="text/javascript" ></script>
    <script src="/ggzyjy/js/jquery.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
    <script>
        function uploadfile(idflag) {
            var iWidth = 800;                                                 //弹出窗口的宽度;
            var iHeight = 200;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/tools/uploadFile.jsp?idflag=" + idflag, "EC_UploadFileWin", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
        }

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
            <!--li><a href="/users/personinfo.jsp?action=2">授信申请管理</a></li>
            <li><a href="/users/personinfo.jsp?action=3">保证金管理</a></li-->
            <li><a href="/users/companyinfo.jsp">公司信息管理</a></li>
            <li><a href="/users/updatereg.jsp"><span style="color: red">修改个人注册信息</span></a></li>
            <li><a href="/users/changePwd.jsp">修改密码</a></li>
        </ul>
    </div>
    <div class="personal_right_box">
        <div class="personal_right">
            <div class="p_r_title">个人注册信息修改</div>
        </div>
        <form name="regform" method="post" action="/updatePersonReg.do" onsubmit="return submitUpdatePersonInfo(regform);">
            <input type="hidden" name="doUpdate" value="true">
            <input type="hidden" name="doflag" value="1">
            <input type="hidden" name="checkval" value="">

            <table width="875" border="0" cellspacing="3" cellpadding="0" class="regtable">
                <tbody>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"><span class="hint_red">*</span> 身份证号码：</td>
                    <td><input type="text" name="idcard" class="input_txt" size="30" autocomplete="off" value="<%=(user.getIDCARD()!=null)?user.getIDCARD():""%>" onblur="javascript:setMessage('emailmsg')"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red"><div id="idcardmsg"></div></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"><span class="hint_red">*</span> 手机号码：</td>
                    <td><input type="text" name="mphone" class="input_txt" size="30" autocomplete="off" value="<%=(user.getMPHONE()!=null)?user.getMPHONE():""%>" onblur="javascript:setMessage('emailmsg')"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red"><div id="mphonemsg"></div></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"><span class="hint_red">*</span> 座机号码：</td>
                    <td><input type="text" name="phone" class="input_txt" size="30" autocomplete="off" value="<%=(user.getPHONE()!=null)?user.getPHONE():""%>" onblur="javascript:setMessage('emailmsg')"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red"><div id="phonemsg"></div></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"><span class="hint_red">*</span> E-mail：</td>
                    <td><input type="text" name="email" class="input_txt" size="30" autocomplete="off" value="<%=(user.getEMAIL()!=null)?user.getEMAIL():""%>" onblur="javascript:setMessage('emailmsg')"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red"><div id="emailmsg"></div></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"> 工作单位：</td>
                    <td><input type="text" name="unit" class="input_txt" size="60" autocomplete="off" value="<%=(user.getCOMPANY()!=null)?user.getCOMPANY():""%>"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red">&nbsp;</td>
                </tr>
                <tr>
                    <td align="right" valign="middle">职务：</td>
                    <td><input type="text" name="title" class="input_txt" size="25" autocomplete="off" value="<%=(user.getDUTY()!=null)?user.getDUTY():""%>"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td height="20" align="left" valign="bottom" class="w_red">&nbsp;</td>
                </tr>
                <tr>
                    <td align="right" valign="middle">性别：</td>
                    <td><input name="sex" type="radio" value="0" <%=(sex_val==0)?"checked":""%>>
                        男          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="sex" type="radio" value="1" <%=(sex_val==1)?"checked":""%>>
                        女 </td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td align="left" valign="bottom" height="20"> </td>
                </tr>
                <tr>
                    <td align="right" valign="middle">身份证照片（正面）：</td>
                    <td>
                        <input type="hidden" name="idcardpic_frontfile" id="f_file" value="<%=user.getIDCARD_FRONT_PIC()%>">
                        <input type="button"  name="idcardpicf" value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('f');">
                        <span id="f_id"><%=(user.getIDCARD_FRONT_PIC()==null)?"":user.getIDCARD_FRONT_PIC()%></span>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td align="left" valign="bottom" height="20"> </td>
                </tr>
                <tr>
                    <td align="right" valign="middle">身份证照片（反面）：</td>
                    <td>
                        <input type="hidden" name="idcardpic_backfile" id="b_file" value="<%=user.getIDCARD_BACK_PIC()%>">
                        <input type="button"  name="idcardpicb"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('b');">
                        <span id="b_id"><%=(user.getIDCARD_BACK_PIC()==null)?"":user.getIDCARD_BACK_PIC()%></span>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td align="left" valign="bottom" height="20"> </td>
                </tr>
                <tr>
                    <td align="right" valign="middle">籍贯：</td>
                    <td><input type="text"  name="native" class="input_txt" size="15" autocomplete="off" value="<%=(user.getNATION()!=null)?user.getNATION():""%>"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td align="left" valign="bottom" height="20"> </td>
                </tr>
                <tr>
                    <td align="right" valign="middle">验证码：</td>
                    <td align="left" valign="middle"><span style="float:left; display:block"><input type="text" name="yzcode" autocomplete="off" class="input_txt" size="15" autocomplete="off"></span>
                        <span style="float:left; display:block; margin-left:10px;"><img src="/users/image.jsp" height="40px" id="yzImageID" name="yzcodeimage" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">看不清，换一张</a></span></td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td align="left" valign="bottom" height="20"> </td>
                </tr>
                <tr>
                    <td align="right" valign="middle"></td>
                    <td><input name="" type="submit" class="regist_btn" value="修改"></td>
                </tr>
                <tr>
                    <td align="right" valign="middle" height="80"></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
        </form>
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
                    $("#userInfos").html("欢迎你：<font color='red'>" + data.username + "</font>  (<a href=\"javascript:showAuditInfo();\"><span style='color: #F7FF78'>" + auditResult + "</span></a>)" + "<span><a href='#' onclick=\"javascript:logoff();\">退出</a></span>" + "<span><a href=\"/users/personinfo.jsp\">个人中心</a></span>");
                }
            },
            "json"
        );
    })
</script>
</html>
