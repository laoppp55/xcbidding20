<%@ page import="com.bizwink.util.ParamUtil" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 17-3-25
  Time: 下午9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String compname = ParamUtil.getParameter(request,"compname");
  String compcode = ParamUtil.getParameter(request,"compcode");
  String pwd = ParamUtil.getParameter(request,"pwd");
  int errcode = 0;
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>北京市西城区公共资源交易中心-企业法人注册</title>
  <link href="/ggzyjy/css/log.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />

  <script src="/ggzyjy/js/jquery-1.10.2.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>

  <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
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
  </script>
</head>

<body>
<div class="title_box_1">
  <ul>
    <li class="txt_white">1、填写基本信息</li>
    <li>2、注册成功,并完善信息</li>
  </ul>
</div>
<div class="main_1800">
  <form name="regform" method="post" action="/userreg.do" onsubmit="return checkvalid(this,'registe');">
    <input type="hidden" id="userid" name="username" value="<%=compname%>">
    <input type="hidden" id="passwd" name="pwdname" value="<%=pwd%>">
    <input type="hidden" name="checkval" value="">
    <div class="title_box_2">基本信息</div>
    <table width="100%" border="0" class="reg_table e">
      <tbody>
      <tr>
        <td width="25%" align="right"><span class="redstar">*</span>企业名称:</td>
        <td width="25%"><input type="text" name="suppliername" id="suppName" value="<%=compname%>" readonly class="input_but_5"></td>
        <td width="25%" align="right"><span class="redstar">*</span>企业统一信用代码:</td>
        <td><input type="text" name="supplierCode" id="suppCode" value="<%=compcode%>" readonly class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>法人代表姓名:</td>
        <td> <input type="text" name="lawPersonName" id="lawPersonName" class="input_but_5"></td>
        <td align="right"><span class="redstar">*</span>法人代表联系电话:</td>
        <td><input type="text" name="lawPersonTel" id="lawPersonTel" value="" class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right">法人代表身份证号:</td>
        <td><input type="text" name="Idcard" id="personIdcard" value="" class="input_but_5"></td>
        <td align="right"><span class="redstar">*</span>企业角色:</td>
        <td>
          <select name="suppRole" id="suppRole" class="reg_sel">
            <option value="06">供应商</option>
            <option value="05">代理机构</option>
            <option value="99">其他</option>
          </select>
        </td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>企业类别:</td>
        <td>
          <select name="supplierType" id="suppType" class="reg_sel">
          </select>
        </td>
        <td align="right"><span class="redstar">*</span>企业机构类型:</td>
        <td>
          <select name="suppOrgType" id="suppOrgType" class="reg_sel">
          </select>
        </td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>成立日期:</td>
        <td>
          <input type="text" name="regDate" id="registerDate" class="input_but_5" readonly>
        </td>
        <td align="right"><span class="redstar">*</span>营业期限:</td>
        <td>
          <select name="longtimeflag" id="longtimeflag" class="reg_sel" onchange="inpEndDateFlag();">
            <option value="1">有限期</option>
            <option value="2">无限期</option>
          </select>
        </td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>营业开始日期:</td>
        <td><input type="text" name="sdate" id="beginDate" class="input_but_5" readonly></td>
        <td align="right"><span class="redstar">*</span>营业截止日期:</td>
        <td><input type="text" name="edate" id="endDate" class="input_but_5" readonly></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>注册地址:<br></td>
        <td><input name="regaddress" id="address" type="text" class="input_but_5"></td>
        <td align="right"><span class="redstar">*</span>注册资本（万元）:<br></td>
        <td><input name="regCapital" id="registeredCapital" type="text" class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>基本账户开户银行:</td>
        <td><input name="bankname" id="bank" type="text" class="input_but_5"></td>
        <td align="right"><span class="redstar">*</span>基本账户名称:</td>
        <td><input name="BaseAccountName" id="AccountName" type="text" class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>基本账户账号:</td>
        <td><input name="baseAccount" id="baseAccountID" type="text" class="input_but_5"></td>
        <td align="right"><!--span class="redstar">*</span-->企业网址:</td>
        <td><input name="weburl" id="website" type="text" class="input_but_5"></td>
      </tr>
      <tr>
        <td colspan="1" align="right"><span class="redstar">*</span>经营范围:</td>
        <td colspan="3">
          <textarea name="businessBrief" id="businessRange" class="input_but_8" id="textarea"></textarea> </td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>登记机关:</td>
        <td><input name="regAuthName" id="registrationAuthority" type="text" class="input_but_5"></td>
        <td align="right"><span class="redstar">*</span>登记日期:</td>
        <td><input name="checkInDate" id="registrationDate" type="text" class="input_but_5"  readonly></td>
      </tr>
      </tbody>
    </table>
    <div class="title_box_2">地址信息</div>
    <table width="100%" border="0" class="reg_table e">
      <tbody>
      <tr>
        <td width="25%" align="right"><span class="redstar">*</span>省份:</td>
        <td width="25%"><input type="text" name="provname" id="province" class="input_but_5" readonly value="北京"></td>
        <td width="25%" align="right"><span class="redstar">*</span>市:</td>
        <td><input type="text" name="cityname" id="city" class="input_but_5" readonly value="北京市"></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>区:</td>
        <td>
          <select name="areaname" id="area" class="reg_sel">
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
        </td>
        <td align="right"><!--span class="redstar">*</span-->邮政编码:</td>
        <td><input type="text" name="zipcode" id="postalCode" class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>经营地址:</td>
        <td colspan="3">
          <input name="operationAddress" id="managementAddress" type="text" class="input_but_9"></td>
      </tr>
      </tbody>
    </table>
    <div class="title_box_2">联系人信息</div>
    <table width="100%" border="0" class="reg_table e">
      <tbody>
      <tr>
        <td width="25%" align="right"><span class="redstar">*</span>企业联系人:</td>
        <td width="25%"><input name="contactorname" id="contactor" type="text" class="input_but_5"></td>
        <td width="25%" align="right"><span class="redstar">*</span>联系人手机:</td>
        <td><input name="contactormphone" id="contactNumber" type="text" class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>联系人单位座机:</td>
        <td><input name="contactorphone" id="contactorphone" type="text" class="input_but_5"></td>
        <td align="right"><span class="redstar">*</span>电子邮箱</td>
        <td><input type="text" name="email" id="email" class="input_but_5"></td>
      </tr>
      <tr>
        <td align="right"><!--span class="redstar">*</span-->传真:</td>
        <td><input name="faxnum" id="fax" type="text" class="input_but_5"></td>
        <td align="right"></td>
        <td></td>
      </tr>
      </tbody>
    </table>
    <div class="title_box_2">附件信息（仅限jpg、png格式）</div>
    <table width="100%" border="0" class="reg_table e">
      <tbody>
      <tr>
        <td width="280" align="right"><span class="redstar">*</span>企业营业执照:</td>
        <td>
          <input type="hidden" name="licensepic" id="license_file" value="">
          <input type="button" name="license_button"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('license');">
          <span id="license_id"></span>
        </td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>风险承诺书:</td>
        <td>
          <input type="hidden" name="promisepic" id="promise_file" value="">
          <input type="button"  name="promise_button"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('promise');">
          <span id="promise_id"></span>
        </td>
      </tr>
      <tr>
        <td align="right"><span class="redstar">*</span>风险承诺书横版:</td>
        <td><span class="download"><a href="#">下载</a></span><span>风险承诺书要手工填写，加盖公司公章，上传彩色影音件</span></td>
      </tr>
      </tbody>
    </table>
    <div class="title_box_2"><!--验证码--></div>
    <table width="100%" border="0" class="reg_table e">
      <tbody>
      <tr>
        <td width="280" align="right"><span class="redstar">*</span>验证码:</td>
        <td><input type="text" placeholder="输入图形验证码" class="input_but_6" name="yzcode" id="VerCode" style="width:150px;"/>
          <span><img src="/users/image.jsp" height="40px" id="yzImageID" align="absmiddle"/></span><span><a href="javascript:change_yzcodeimage();">换一张</a></span>
        </td>
      </tr>
      </tbody>
    </table>
    <div class="box_center"><input type="submit" class="input_but_10" value="注册"></div>
  </form>
</div>
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
                        if (data[ii].codename == "法人")
                            $("#suppType").append("<option value='" + data[ii].codesymbol + "' selected>" + data[ii].codename + "</option>");
                        else
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
