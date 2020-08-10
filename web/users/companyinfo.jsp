<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.po.PurchasingAgency" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.service.IAttechemntsService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
  if (authToken==null) response.sendRedirect("/users/login.jsp");
  String userid = authToken.getUserid();
  BigDecimal siteid = BigDecimal.valueOf(1);
  Users user = null;
  PurchasingAgency companyinfo = null;
  int errcode = 0;
  ApplicationContext appContext = SpringInit.getApplicationContext();
  IAttechemntsService attechemntsService = null;
  String licenseFile = null;
  String promiseFile = null;
  if (appContext!=null) {
    IUserService usersService = (IUserService)appContext.getBean("usersService");
    user = usersService.getUserinfoByUserid(userid);
    companyinfo = usersService.getEnterpriseInfoByCompcode(user.getCOMPANYCODE());

    attechemntsService = (IAttechemntsService)appContext.getBean("attechemntsService");
    licenseFile = attechemntsService.getAttechmentFilenameByUUID(companyinfo.getBusinessAttachmentIds()).getFilename();
    if (attechemntsService.getAttechmentFilenameByUUID(companyinfo.getCertificateAttachmentIds())!=null)
      promiseFile = attechemntsService.getAttechmentFilenameByUUID(companyinfo.getCertificateAttachmentIds()).getFilename();
  } else {
    response.sendRedirect("/users/error.jsp");
    return;
  }

  String compType = null;
  String orgType = null;
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  if (companyinfo == null)
    response.sendRedirect("/users/error.jsp");
  else {
    compType = (companyinfo.getPersonType()==null)?"":companyinfo.getPersonType();
    orgType = (companyinfo.getPersonOorganType()==null)?"":companyinfo.getPersonOorganType();
  }
%>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>北京市西城区公共资源交易系统--用户个人中心--公司信息管理</title>
  <link href="/ggzyjy/css/base.css" rel="stylesheet" type="text/css">
  <link href="/ggzyjy/css/program_style.css" rel="stylesheet" type="text/css">
  <link href="/ggzyjy/css/index.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />
  <link href="/ggzyjy/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />

  <script src="/ggzyjy/js/jquery-1.11.1.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery-ui.js" language="javascript" type="text/javascript"></script>
  <script src="/ggzyjy/js/md5-min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.dragndrop.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/jquery.msgbox.min.js" type="text/javascript"></script>
  <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
  <script language="javascript">
      function basicinfo() {
          $("#compinfoid").css('display','block');
          $("#licenseid").css("display","none");
      }

      function licenses() {
          $("#compinfoid").css('display','none');
          $("#licenseid").css("display","block");
      }

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
  <div class="companyinfo_left">
    <div class="title">个人中心</div>
    <ul>
      <li><a href="/ec/myBidinfos.jsp">投标项目管理</a></li>
      <!--li><a href="/users/personinfo.jsp?action=2">授信申请管理</a></li>
      <li><a href="/users/personinfo.jsp?action=3">保证金管理</a></li-->
      <li><a href="/users/companyinfo.jsp"><span style="color: red">公司信息管理</span></a></li>
      <li><a href="/users/updatereg.jsp">修改个人注册信息</a></li>
      <li><a href="/users/changePwd.jsp">修改密码</a></li>
    </ul>
  </div>
  <div class="companyinfo_right_box">
    <div id="basicinfo" style="float:left;margin: 20px;"><input type="button" value="公司基本信息" class="input_but_10" onclick="javascript:basicinfo();"></div>
    <div id="fileid" style="padding-right: auto;margin: 20px;"><input type="button" value="公司证照信息" class="input_but_10" onclick="javascript:licenses();"></div>
    <div title="公司基本信息" id="compinfoid" style="padding:10px">
      <form name="regform" method="post" action="/updateCompanyinfo.do" onsubmit="return checkvalid(this,'update');">
        <input type="hidden" name="uuid" value="<%=companyinfo.getUuid()%>">
        <input type="hidden" name="userid" value="<%=userid%>">
        <input type="hidden" name="checkval" value="">
        <div class="title_box_2">基本信息</div>
        <table width="100%" border="0" class="reg_table e">
          <tbody>
          <tr>
            <td width="25%" align="right"><span class="redstar">*</span>企业名称:</td>
            <td width="25%"><input type="text" name="suppliername" id="suppName" value="<%=companyinfo.getOrganName()%>" class="input_but_5"></td>
            <td width="25%" align="right"><span class="redstar">*</span>企业统一信用代码:</td>
            <td><input type="text" name="supplierCode" id="suppCode" value="<%=companyinfo.getLegalCode()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>法人代表姓名:</td>
            <td> <input type="text" name="lawPersonName" id="lawPersonName" value="<%=companyinfo.getPersonName()%>" class="input_but_5"></td>
            <td align="right"><span class="redstar">*</span>法人代表联系电话:</td>
            <td><input type="text" name="lawPersonTel" id="lawPersonTel" value="<%=(companyinfo.getPersonTel()==null)?"":companyinfo.getPersonTel()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right">法人代表身份证号:</td>
            <td><input type="text" name="Idcard" id="personIdcard" value="<%=(companyinfo.getPersonIdcard()==null)?"":companyinfo.getPersonIdcard()%>" class="input_but_5"></td>
            <td align="right"><span class="redstar">*</span>企业角色:</td>
            <td>
              <select name="suppRole" id="suppRole" class="reg_sel">
                <option value="06" <%=(companyinfo.getPersonRole()==null || companyinfo.getPersonRole()=="06")?"selectd":""%>>供应商</option>
                <option value="05" <%=(companyinfo.getPersonRole()=="05")?"selected":""%>>代理机构</option>
                <option value="99" <%=(companyinfo.getPersonRole()=="99")?"selected":""%>>其他</option>
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
              <input type="text" name="regDate" id="registerDate" value="<%=(companyinfo.getCreateDate()==null)?"":sdf.format(companyinfo.getCreateDate())%>" class="input_but_5" readonly>
            </td>
            <td align="right"><span class="redstar">*</span>营业期限:</td>
            <td>
              <select name="longtimeflag" id="longtimeflag" class="reg_sel" onchange="inpEndDateFlag();">
                <option value="1" <%=(companyinfo.getOperatingpeoid()==null)?"selected":""%>>有限期</option>
                <option value="2" <%=(companyinfo.getOperatingpeoid()=="99")?"selected":""%>>无限期</option>
              </select>
            </td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>营业开始日期:</td>
            <td><input type="text" name="sdate" id="beginDate" class="input_but_5" value="<%=(companyinfo.getRegistrationTime()==null)?"":sdf.format(companyinfo.getRegistrationTime())%>" readonly></td>
            <td align="right"><span class="redstar">*</span>营业截止日期:</td>
            <td><input type="text" name="edate" id="endDate" class="input_but_5" value="<%=(companyinfo.getExpiryDate()==null)?"":sdf.format(companyinfo.getExpiryDate())%>" readonly></td>
          </tr>
          <tr>
            <td align="right">注册地址:<br></td>
            <td><input name="regaddress" id="address" type="text" value="<%=(companyinfo.getAddress()==null)?"":companyinfo.getAddress()%>" class="input_but_5"></td>
            <td align="right"><span class="redstar">*</span>注册资本（万元）:<br></td>
            <td><input name="regCapital" id="registeredCapital" type="text" value="<%=(companyinfo.getRegisteredCapital()==null)?"":companyinfo.getRegisteredCapital()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>基本账户开户银行:</td>
            <td><input name="bankname" id="bank" type="text" value="<%=(companyinfo.getBank()==null)?"":companyinfo.getBank()%>" class="input_but_5"></td>
            <td align="right"><span class="redstar">*</span>基本账户名称:</td>
            <td><input name="BaseAccountName" id="AccountName" type="text" value="<%=(companyinfo.getBankAccountName()==null)?"":companyinfo.getBankAccountName()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>基本账户账号:</td>
            <td><input name="baseAccount" id="baseAccountID" value="<%=(companyinfo.getBankAccount()==null)?"":companyinfo.getBankAccount()%>" type="text" class="input_but_5"></td>
            <td align="right"><!--span class="redstar">*</span-->企业网址:</td>
            <td><input name="weburl" id="website" type="text" value="<%=(companyinfo.getWeburl()==null)?"":companyinfo.getWeburl()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td colspan="1" align="right"><span class="redstar">*</span>经营范围:</td>
            <td colspan="3">
              <textarea name="businessBrief" id="businessRange" class="input_but_8"><%=(companyinfo.getBusinesScope()==null)?"":companyinfo.getBusinesScope()%></textarea> </td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>登记机关:</td>
            <td><input name="regAuthName" id="registrationAuthority" type="text" value="<%=(companyinfo.getRegistrationAuthority())%>" class="input_but_5"></td>
            <td align="right"><span class="redstar">*</span>登记日期:</td>
            <td><input name="checkInDate" id="registrationDate" type="text" value="<%=sdf.format(companyinfo.getRegistrationDate())%>" class="input_but_5"  readonly></td>
          </tr>
          </tbody>
        </table>
        <div class="title_box_2">地址信息</div>
        <table width="100%" border="0" class="reg_table e">
          <tbody>
          <tr>
            <td width="25%" align="right"><span class="redstar">*</span>省份:</td>
            <td width="25%"><input type="text" name="provname" id="province" class="input_but_5" readonly value="<%=companyinfo.getProvince()%>"></td>
            <td width="25%" align="right"><span class="redstar">*</span>市:</td>
            <td><input type="text" name="cityname" id="city" class="input_but_5" readonly value="<%=companyinfo.getCity()%>"></td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>区:</td>
            <td>
              <select name="areaname" id="area" class="reg_sel">
                <option value="110101" <%=(companyinfo.getRegionCode()=="110101")?"selected":""%>>东城区</option>
                <option value="110102" <%=(companyinfo.getRegionCode()=="110102")?"selected":""%>>西城区</option>
                <option value="110105" <%=(companyinfo.getRegionCode()=="110105")?"selected":""%>>朝阳区</option>
                <option value="110106" <%=(companyinfo.getRegionCode()=="110106")?"selected":""%>>丰台区</option>
                <option value="110107" <%=(companyinfo.getRegionCode()=="110107")?"selected":""%>>石景山区</option>
                <option value="110108" <%=(companyinfo.getRegionCode()=="110108")?"selected":""%>>海淀区</option>
                <option value="110109" <%=(companyinfo.getRegionCode()=="110109")?"selected":""%>>门头沟区</option>
                <option value="110111" <%=(companyinfo.getRegionCode()=="110111")?"selected":""%>>房山区</option>
                <option value="110112" <%=(companyinfo.getRegionCode()=="110112")?"selected":""%>>通州区</option>
                <option value="110113" <%=(companyinfo.getRegionCode()=="110113")?"selected":""%>>顺义区</option>
                <option value="110114" <%=(companyinfo.getRegionCode()=="110114")?"selected":""%>>昌平区</option>
                <option value="110115" <%=(companyinfo.getRegionCode()=="110115")?"selected":""%>>大兴区</option>
                <option value="110116" <%=(companyinfo.getRegionCode()=="110116")?"selected":""%>>怀柔区</option>
                <option value="110117" <%=(companyinfo.getRegionCode()=="110117")?"selected":""%>>平谷区</option>
                <option value="110118" <%=(companyinfo.getRegionCode()=="110118")?"selected":""%>>密云区</option>
                <option value="110119" <%=(companyinfo.getRegionCode()=="110119")?"selected":""%>>延庆区</option>
              </select>
            </td>
            <td align="right"><!--span class="redstar">*</span-->邮政编码:</td>
            <td><input type="text" name="zipcode" id="postalCode" value="<%=(companyinfo.getPostalCode()==null)?"":companyinfo.getPostalCode()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>经营地址:</td>
            <td colspan="3">
              <input name="operationAddress" id="managementAddress" type="text" value="<%=(companyinfo.getBusinessAddress()==null)?"":companyinfo.getBusinessAddress()%>" class="input_but_9"></td>
          </tr>
          </tbody>
        </table>
        <div class="title_box_2">联系人信息</div>
        <table width="100%" border="0" class="reg_table e">
          <tbody>
          <tr>
            <td width="25%" align="right"><span class="redstar">*</span>企业联系人:</td>
            <td width="25%"><input name="contactorname" id="contactor" type="text" value="<%=(companyinfo.getContacts()==null)?"":companyinfo.getContacts()%>" class="input_but_5"></td>
            <td width="25%" align="right"><span class="redstar">*</span>联系人手机:</td>
            <td><input name="contactormphone" id="contactNumber" value="<%=(companyinfo.getContactNumber()==null)?"":companyinfo.getContactNumber()%>" type="text" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>联系人单位座机:</td>
            <td><input name="contactorphone" id="contactorphone" value="<%=(companyinfo.getContactunitLandline()==null)?"":companyinfo.getContactunitLandline()%>" type="text" class="input_but_5"></td>
            <td align="right"><span class="redstar">*</span>电子邮箱</td>
            <td><input type="text" name="email" id="email" value="<%=(companyinfo.getLegalemail()==null)?"":companyinfo.getLegalemail()%>" class="input_but_5"></td>
          </tr>
          <tr>
            <td align="right"><!--span class="redstar">*</span-->传真:</td>
            <td><input name="faxnum" id="fax" type="text" value="<%=(companyinfo.getFax()==null)?"":companyinfo.getFax()%>" class="input_but_5"></td>
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
              <input type="hidden" name="licensepic" id="license_file" value="<%=licenseFile%>">
              <input type="button" name="license_button"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('license');">
              <span id="license_id"><%=licenseFile%></span>
            </td>
          </tr>
          <tr>
            <td align="right"><span class="redstar">*</span>风险承诺书:</td>
            <td>
              <input type="hidden" name="promisefile" id="promise_file" value="<%=promiseFile%>">
              <input type="button"  name="promise_button"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('promise');">
              <span id="promise_id"><%=promiseFile%></span>
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
        <div class="title_box_2"><!--验证码--></div>
        <div class="box_center"><input type="submit" class="input_but_10" value="修改"></div>
      </form>
    </div>
    <div title="公司证照文件" id="licenseid" style="padding:10px;display: none;">
      <div title="证照维护功能" style="text-align: right">增加</div>
      <div title="证照文件列表">
        <table id="projectsid" width="1000" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-top:25px;">
          <tr>
            <td>证照名称</td>
            <td>证照编号</td>
            <td>资质等级</td>
            <td>资质名称</td>
            <td>资质类别</td>
            <td>发证单位</td>
            <td>证照有效期</td>
            <td>修改</td>
            <td>删除</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
  <!--以下页面尾-->
</body>
<script language="javascript">
    $(document).ready(function(){
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
                var orgtype = "<%=orgType%>";
                for(var ii=0;ii<data.length;ii++) {
                    if (orgtype==data[ii].codesymbol)
                        $("#suppOrgType").append("<option value='" + data[ii].codesymbol + "' selected>" + data[ii].codename + "</option>");
                    else
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
                var companyType = "<%=compType%>";
                for(var ii=0;ii<data.length;ii++) {
                    if (companyType == data[ii].codesymbol)
                        $("#suppType").append("<option value='" + data[ii].codesymbol + "' selected>" + data[ii].codename + "</option>");
                    else
                        $("#suppType").append("<option value='" + data[ii].codesymbol + "'>" + data[ii].codename + "</option>");
                }
            }
        });

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
    })


</script>
</html>
