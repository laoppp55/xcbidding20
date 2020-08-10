<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 17-3-25
  Time: 下午9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int errcode = 0;
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统</title>
    <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/basis.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

    <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

    <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
    <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
</head>

<body>
<!--div class="full_box">
  <div class="top_box">
    < %@include file="/inc/top.shtml" %>
  </div>
  <div class="logo_box clearfix">
    < %@include file="/inc/search.shtml" %>
  </div>
  <div class="menu_box">
    < %@include file="/inc/menu.shtml" %>
  </div>
</div-->
<div class="full_box">
    <div class="top_box">
        <!--#include virtual="/inc/head.shtml"-->
    </div>
    <div class="menu_box">
        <!--#include virtual="/inc/menu.shtml"-->
    </div>
</div>






























<!--以上页面头-->
<div class="main div_top clearfix">
    <div class="ibox">
        <form name="regform" method="post" action="/userreg.do" onsubmit="return checkvalid(this);">
            <input type="hidden" name="checkval" value="">
            <div class="ibox-title" style="text-align: center;">
                <span class="h4">供应商注册</span>
            </div>
            <div class="ibox-content">
                <div class="btn-box">
                    <h3>用户信息</h3>
                </div>
                <div class="tableList">
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">用户名称：</span>
                            <input type="text" id="userid" name="username" autocomplete=“helloworld<%=System.currentTimeMillis()%>” class="form-control">
                            <span class="red">*</span>
                        </div>
                        <!--div id="usermsg">gggggg</div-->
                        <div class="item-right">
                            <span class="label-box">密码：</span>
                            <input type="password" id="passwd" name="pwdname" autocomplete="new-password" class="form-control">
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">确认密码：</span>
                            <input type="password" id="repasswd" name="rpwdname" autocomplete="new-password" class="form-control">
                            <span class="red">*</span>
                        </div>
                    </div>
                </div>

                <div class="btn-box">
                    <h3>供应商基本信息</h3>
                </div>
                <div class="tableList">
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">企业名称：</span>
                            <input type="text" name="suppliername" id="suppName" class="form-control">
                            <span class="red">*</span>
                        </div>
                        <div class="item-left">
                            <span class="label-box">企业统一信用代码：</span>
                            <input type="text" name="supplierCode" id="suppCode" class="form-control">
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-right">
                            <span class="label-box">法人代表姓名：</span>
                            <input type="text" name="lawPersonName" id="lawPersonName" class="form-control">
                            <span class="red">*</span>
                        </div>
                        <div class="item-right">
                            <span class="label-box">法人代表联系电话：</span>
                            <input type="text" name="lawPersonTel" id="lawPersonTel" value="" class="form-control">
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-right">
                            <span class="label-box">法人代表身份证号：</span>
                            <input type="text" name="Idcard" id="personIdcard" value="" class="form-control">
                        </div>
                        <div class="item-left">
                            <span class="label-box">企业角色：</span>
                            <select name="" id="suppRole" class="form-control">
                                <option value="06">供应商</option>
                                <option value="99">其他</option>
                            </select>
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-right">
                            <span class="label-box">企业类别：</span>
                            <select name="supplierType" id="suppType" class="form-control">
                            </select>
                            <span class="red">*</span>
                        </div>
                        <div class="item-left">
                            <span class="label-box">企业机构类型：</span>
                            <select name="suppOrgType" id="suppOrgType" class="form-control">
                            </select>
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">成立日期：</span>
                            <!--input type="text" id="registerDate" class="form-control" onClick="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"-->
                            <input type="text" name="regDate" id="registerDate" class="form-control" readonly>
                            <span class="red">*</span>
                        </div>
                        <div class="item-left">
                            <span class="label-box">营业期限：</span>
                            <select name="longtimeflag" id="longtimeflag" class="form-control" onchange="inpEndDateFlag();">
                                <option value="1">有限期</option>
                                <option value="2">无限期</option>
                            </select>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box noRequired">营业开始日期：</span>
                            <input type="text" name="sdate" id="beginDate" class="form-control" readonly>
                            <span class="red">*</span>
                        </div>
                        <div class="item-right">
                            <span class="label-box">营业截止日期：</span>
                            <input type="text" name="edate" id="endDate" class="form-control" readonly>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-right">
                            <span class="label-box">注册地址：</span>
                            <input type="text" name="regaddress" id="address" class="form-control">
                        </div>
                        <div class="item-right">
                            <span class="label-box">注册资本（万元）：</span>
                            <input type="text" name="regCapital" id="registeredCapital" class="form-control">
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">基本账户开户银行：</span>
                            <input type="text" name="bankname" id="bank" class="form-control">
                        </div>
                        <div class="item-right">
                            <span class="label-box">基本账户名称：</span>
                            <input type="text" name="BaseAccountName" id="AccountName" class="form-control">
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">基本账户账号：</span>
                            <input type="text" name="baseAccount" id="baseAccountID" class="form-control">
                        </div>
                        <div class="item-right">
                            <span class="label-box noRequired">企业网址：</span>
                            <input type="text" name="weburl" id="website" class="form-control noRequired">
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left" style="flex:1;">
                            <span class="label-box">经营范围：</span>
                            <textarea name="businessBrief" id="businessRange" style="height:100px;flex:1;" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">登记机关：</span>
                            <input type="text" name="regAuthName" id="registrationAuthority" class="form-control">
                            <span class="red">*</span>
                        </div>
                        <div class="item-right">
                            <span class="label-box">登记日期：</span>
                            <input type="text" name="checkInDate" id="registrationDate" class="form-control" readonly>
                            <span class="red">*</span>
                        </div>
                    </div>
                </div>
                <div class="btn-box">
                    <h3>地址信息</h3>
                </div>
                <div class="tableList">
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">省份：</span>
                            <input type="text" name="provname" id="province" class="form-control" readonly value="北京">
                            <span class="red">*</span>
                        </div>
                        <div class="item-right">
                            <span class="label-box">市：</span>
                            <input type="text" name="cityname" id="city" class="form-control" readonly value="北京市">
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">区：</span>
                            <select name="areaname" id="area" class="form-control">
                                <option value="110101">东城区</option>
                                <option value="110102" selected="selected">西城区</option>
                                <option value="110105">朝阳区</option>
                                <option value="110106">丰台区</option>
                                <option value="110107">石景山区</option>
                                <option value="110108">海淀区</option>
                                <option value="110109">门头沟区</option>
                                <option value="110111">房山区</option>
                                <option value="110112">通州区</option>
                                <option value="110113">顺义区</option>
                                <option value="110114">昌平区</option>
                                <option value="110115">大兴区</option>
                                <option value="110116">怀柔区</option>
                                <option value="110117">平谷区</option>
                                <option value="110118">密云区</option>
                                <option value="110119">延庆区</option>
                            </select>
                            <span class="red">*</span>
                        </div>
                        <div class="item-right">
                            <span class="label-box noRequired">邮政编码：</span>
                            <input type="text" name="zipcode" id="postalCode" class="form-control noRequired">
                        </div>
                    </div>
                    <div class="listItem" style="justify-content: flex-start;">
                        <span class="label-box">经营地址：</span>
                        <input type="text" name="operationAddress" id="managementAddress" class="form-control" style="flex:1;">
                    </div>
                </div>
                <div class="btn-box">
                    <h3>联系人信息</h3>
                </div>
                <div class="tableList">
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">企业联系人：</span>
                            <input type="text" name="contactorname" id="contactor" class="form-control">
                            <span class="red">*</span>
                        </div>
                        <div class="item-left">
                            <span class="label-box">联系人手机：</span>
                            <input type="text" name="contactormphone" id="contactNumber" class="form-control">
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-right">
                            <span class="label-box">联系人单位座机：</span>
                            <input type="text" name="contactorphone" id="contactorphone" class="form-control">
                            <span class="red">*</span>
                        </div>
                        <div class="item-left">
                            <span class="label-box">电子邮箱：</span>
                            <input type="text" name="email" id="email" class="form-control">
                            <span class="red">*</span>
                        </div>
                    </div>
                    <div class="listItem">
                        <div class="item-right">
                            <span class="label-box noRequired">传真：</span>
                            <input type="text" name="faxnum" id="fax" class="form-control noRequired">
                        </div>
                    </div>
                </div>
                <div class="btn-box">
                    <h3>附件信息（仅限jpg、png格式）</h3>
                </div>
                <div class="tableList">
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">企业营业执照：</span>
                            <button type="button" class="btn btn-default" onclick="uploadFile('businessLicense')">上传</button>
                            <div id = "businessLicense" style="padding-left: 12px;"></div>
                            <input type="hidden" name="uploadfilename" value="">
                            <span class="red">*</span>
                        </div>
                    </div>
                </div>
                <div class="btn-box">

                </div>
                <div class="tableList">
                    <div class="listItem">
                        <div class="item-left">
                            <span class="label-box">验证码：</span>
                            <input type="text" placeholder="输入图形验证码" class="form-control" name="yzcode" id="VerCode" style="width:150px;"/>
                            <span><img src="/users/image.jsp" height="40px" id="yzImageID" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">换一张</a></span>
                        </div>
                    </div>
                </div>
                <p style="font-size:16px;color:red;margin-bottom:10px;">*注：注册成功后，用户名为代理机构名称，初始密码为代理机构统一信用代码后六位</p>
                <div class="box-bottom">
                    <input type="submit" name="doReg" value="注 册"></input>
                </div>
            </div>
        </form>
    </div>
</div>
<!--以下页面尾-->
<!--div>
  < %@include file="/inc/tail.shtml" %>
</div-->
</body>
<script>
    var falg = false;
    var sucess = "";
    var errcode = <%=errcode%>;

    $(document).ready(function(){
        if (errcode == -1) {
            $("#usermsg").html("用户名、电子邮件地址已经存在或为空");
            $("#usermsg").css({color:"red"});
        } else if (errcode == -2) {
            $("#emailmsg").html("口令或者验证码输入错误");
            $("#emailmsg").css({color:"red"});
        } else if (errcode == -3) {
            $("#mphonemsg").html("数据出现错误，可能数据被篡改");
            $("#mphonemsg").css({color:"red"});
        } else if (errcode == -4) {
            $("#usermsg").html("口令为空或者验证码为空");
            $("#usermsg").css({color:"red"});
        } else if (errcode == -4) {
            $("#agreementmsg").html("未阅读协议或者是验证码输入错误");
            $("#agreementmsg").css({color:"red"});
        } else if (errcode == -5) {
            $("#usermsg").html("换取系统运行环境参数出现错误");
            $("#usermsg").css({color:"red"});
        } else if (errcode > 0) {
            alert("用户注册成功");
            window.location.href="/users/login.jsp";
            return;
        } else {
            //法人机构类别
            htmlobj=$.ajax({
                url:"/getNameValeCode.do",
                type:'post',
                dataType:'json',
                data:{
                    classcode:377
                },
                async:false,
                cache:false,
                success:function(data){
                    //$("#suppOrgType")
                    for(var ii=0;ii<data.length;ii++) {
                        $("#suppOrgType").append("<option value='" + data[ii].codesymbol + "'>" + data[ii].codename + "</option>");
                    }
                }
            });

            //法人主体类别
            htmlobj=$.ajax({
                url:"/getNameValeCode.do",
                type:'post',
                dataType:'json',
                data:{
                    classcode:378
                },
                async:false,
                cache:false,
                success:function(data){
                    //$("#suppOrgType")
                    for(var ii=0;ii<data.length;ii++) {
                        $("#suppType").append("<option value='" + data[ii].codesymbol + "'>" + data[ii].codename + "</option>");
                    }
                }
            });
        }

        $.datepicker.regional['zh-CN'] = {
            clearText: '清除',
            clearStatus: '清除已选日期',
            closeText: '关闭',
            closeStatus: '不改变当前选择',
            prevText: '上月',
            prevStatus: '显示上月',
            prevBigText: 'Prev',
            prevBigStatus: '显示上一年',
            nextText: '下月',
            nextStatus: '显示下月',
            nextBigText: 'Next',
            nextBigStatus: '显示下一年',
            currentText: '今天',
            currentStatus: '显示本月',
            monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
            monthNamesShort: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
            monthStatus: '选择月份',
            yearStatus: '选择年份',
            weekHeader: '周',
            weekStatus: '年内周次',
            dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
            dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
            dayNamesMin: ['日','一','二','三','四','五','六'],
            dayStatus: '设置 DD 为一周起始',
            dateStatus: '选择 m月 d日, DD',
            dateFormat: 'yy-mm-dd',
            firstDay: 1,
            initStatus: '请选择日期',
            isRTL: false};
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);

        //成立日期
        $("#registerDate").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true,
            yearRange:"1990:2050"
        });

        //登记日期
        $("#registrationDate").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true,
            yearRange:"1990:2050"
        });

        $("#beginDate").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true,
            yearRange:"1990:2050"
        });

        $("#endDate").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true
        });
    });
</script>
</html>
