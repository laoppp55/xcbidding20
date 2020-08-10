<%@page contentType="text/html;charset=utf-8" %>
<%@page import="com.yeepay.PaymentForOnlineService,com.yeepay.Configuration"%>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.service.IBudgetProjectService" %>
<%@ page import="com.bizwink.service.IPurchaseProjectService" %>
<%
	int errcode = 0;
	Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
	if (authToken==null) {
		response.sendRedirect("/users/login.jsp");   //错误码为-1表示用户需要登录系统才能进行后续操作
		return;
	}
	String username = authToken.getUserid();
	String bulletinNotice_uuid = ParamUtil.getParameter(request,"uuid");
	ApplicationContext appContext = SpringInit.getApplicationContext();
	PurchasingAgency purchasingAgency = null;
	BulletinNoticeWithBLOBs bulletinNotice = null;
	BudgetProject budgetProject = null;
	PurchaseProject purchaseProject = null;
	BidderInfo bidderInfo = null;
	String compname = null;
	String compcode = null;
	String lawPersonName = null;
	String lawPersonTel = null;
	String projName = null;
	String projCode = null;
    String buyerName = null;
    String buyerPhone = null;
    String agentName = null;
    String agentPhone = null;
	if (appContext!=null) {
		//获取登录用户的信息
		IUserService usersService = (IUserService)appContext.getBean("usersService");
		Users user = usersService.getUserinfoByUserid(username);

		//获取用户所在单位的法人信息
		purchasingAgency = usersService.getEnterpriseInfoByCompcode(user.getCOMPANYCODE());
		compname = purchasingAgency.getOrganName();
		compcode = purchasingAgency.getLegalCode();
		lawPersonName = purchasingAgency.getPersonName();
		lawPersonTel = purchasingAgency.getPersonTel();

		INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
		bulletinNotice = noticeService.getBulletinNoticeByUUID(bulletinNotice_uuid);
        projName = bulletinNotice.getPurchaseprojname();
        projCode = bulletinNotice.getPurchaseprojcode();
		agentName = bulletinNotice.getAgentName();
		agentPhone = bulletinNotice.getAgentContactPhone();

		IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
		purchaseProject = purchaseProjectService.getProjectInfoByProjCode(bulletinNotice.getPurchaseprojcode());
		IBudgetProjectService budgetProjectService = (IBudgetProjectService)appContext.getBean("budgetProjectService");
		budgetProject = budgetProjectService.getBudgetProjByPrjcode(purchaseProject.getBudgetProjectId());
		buyerName = budgetProject.getBuyername();
		buyerPhone = budgetProject.getPhone();
	}
%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>招标公告--潜在投标人拟投项目信息</title>
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
	</script>
</head>

<body style="background-image: url('');height: 600px;">
<div class="top_box">
	<div class="logo_box">
		<a href="/ggzyjy/" style="color: white">北京市西城区公共资源交易中心</a>
		<div class="reg_in" id="userInfos"><a href="/users/login.jsp">登录</a>|<a href="/users/userreg1.jsp">注册</a></div>
	</div>
</div>

<div style="width: 1300px;padding-left: 150px;">
	<form name="regform" method="post" action="/createBidApplication.do" onsubmit="return checkBidApplicationInfo(this);">
		<input type="hidden" name="checkval" value="">
		<input type="hidden" name="uuid" value="<%=bulletinNotice_uuid%>">
		<div class="title_box_2">拟投项目基本信息</div>
		<table width="100%" border="0" class="reg_table e">
			<tr>
				<td width="25%" align="right"><span class="redstar">*</span>项目名称:</td>
				<td width="25%"><input type="text" name="projName" id="projNameID" value="<%=projName%>" readonly class="input_but_5"></td>
				<td width="25%" align="right"><span class="redstar">*</span>项目编码:</td>
				<td><input type="text" name="projCode" id="projCodeID" value="<%=projCode%>" readonly class="input_but_5"></td>
			</tr>
			<tr>
				<td align="right"><span class="redstar">*</span>采购人名称:</td>
				<td> <input type="text" name="buyerName" id="buyerNameID" class="input_but_5" value="<%=buyerName%>" readonly></td>
				<td align="right"><span class="redstar">*</span>采购人联系电话:</td>
				<td><input type="text" name="buyerPhone" id="buyerPhoneID" value="<%=buyerPhone%>" class="input_but_5" readonly></td>
			</tr>
			<tr>
				<td align="right"><span class="redstar">*</span>代理机构名称:</td>
				<td> <input type="text" name="agentName" id="agentNameID" class="input_but_5" value="<%=agentName%>" readonly></td>
				<td align="right"><span class="redstar">*</span>代理机构联系电话:</td>
				<td><input type="text" name="agentPhone" id="agentPhoneID" value="<%=agentPhone%>" class="input_but_5" readonly></td>
			</tr>
		</table>
		<div class="title_box_2">潜在投标人基本信息</div>
		<table width="100%" border="0" class="reg_table e">
			<tr>
				<td width="25%" align="right"><span class="redstar">*</span>企业名称:</td>
				<td width="25%"><input type="text" name="suppliername" id="suppName" value="<%=compname%>" readonly class="input_but_5"></td>
				<td width="25%" align="right"><span class="redstar">*</span>企业统一信用代码:</td>
				<td><input type="text" name="supplierCode" id="suppCode" value="<%=compcode%>" readonly class="input_but_5"></td>
			</tr>
			<tr>
				<td align="right"><span class="redstar">*</span>法人代表姓名:</td>
				<td> <input type="text" name="lawPersonName" id="lawPersonName" value="<%=lawPersonName%>" class="input_but_5" readonly></td>
				<td align="right">法人代表联系电话:</td>
				<td><input type="text" name="lawPersonTel" id="lawPersonTel" value="<%=lawPersonTel%>" class="input_but_5"></td>
			</tr>
		</table>
		<div class="title_box_2">被授权人信息</div>
		<table width="100%" border="0" class="reg_table e">
			<tbody>
			<tr>
				<td width="25%" align="right"><span class="redstar">*</span>被授权人姓名:</td>
				<td width="25%"><input name="contactorname" id="contactor" type="text" class="input_but_5"></td>
				<td width="25%" align="right"><span class="redstar">*</span>被授权人手机:</td>
				<td><input name="contactormphone" id="contactNumber" type="text" class="input_but_5"></td>
			</tr>
			<tr>
				<td align="right"><span class="redstar">*</span>被授权人座机:</td>
				<td><input name="contactorphone" id="contactorphone" type="text" class="input_but_5"></td>
				<td align="right"><span class="redstar">*</span>被授权人电子邮箱</td>
				<td><input type="text" name="email" id="email" class="input_but_5"></td>
			</tr>
			<tr>
				<td align="right"><span class="redstar">*</span>被授权人身份证号:</td>
				<td><input name="idcard" id="idcardno" type="text" class="input_but_5"></td>
				<td align="right"></td>
				<td></td>
			</tr>
			</tbody>
		</table>
		<div class="title_box_2">潜在投标人相关附件（仅限jpg、png格式）：</div>
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
				<td align="right"><span class="redstar">*</span>授权委托书:</td>
				<td>
					<input type="hidden" name="authletterpic" id="authletter_file" value="">
					<input type="button"  name="authletter_button"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('authletter');">
					<span id="authletter_id"></span>
				</td>
			</tr>
			<tr>
				<td align="right" valign="middle"><span class="redstar">*</span>身份证照片（正面）：</td>
				<td colspan="3">
					<input type="hidden" name="idcardpic_frontfile" id="f_file" value="">
					<input type="button"  name="idcardpicf" value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('f');">
					<span id="f_id"></span>
				</td>
			</tr>
			<tr>
				<td align="right" valign="middle">身份证照片（反面）：</td>
				<td colspan="3">
					<input type="hidden" name="idcardpic_backfile" id="b_file" value="">
					<input type="button"  name="idcardpicb"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('b');">
					<span id="b_id"></span>
				</td>
			</tr>
			<tr>
				<td align="right">其它:</td>
				<td>
					<input type="hidden" name="otherpic" id="other_file" value="">
					<input type="button"  name="other_button"  value="上传文件" class="input_txt" autocomplete="off" onclick="javascript:uploadfile('other');">
					<span id="other_id"></span>
				</td>
			</tr>
			<tr>
				<td align="right"><span class="redstar">*</span>所有附件格式要求:</td>
				<td><span class="download"><a href="#">下载</a></span><span>所有上传附件均应为加盖公司公章的彩色影印件，法人委托书必须有法人代表及被授权人签字</span></td>
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
		<div class="box_center"><input type="submit" class="input_but_10" value="提交"></div>
	</form>
</div>
</body>
<script language="javascript">
    $(document).ready(function(){
        $.post("/users/showLoginInfo.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color='red'>" + data.username + "</font>  <span><a href='#' onclick=\"javascript:logoff();\">退出</a></span>" + "<span><a href=\"/users/personinfo.jsp\">个人中心</a></span>");
                }
            },
            "json"
        )
    })
</script>
</html>

