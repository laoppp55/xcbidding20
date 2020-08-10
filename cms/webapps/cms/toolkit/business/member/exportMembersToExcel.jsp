<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.cms.business.Users.*" %>
<%@ page import="com.bizwink.po.Department" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    int status = 0;
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);
    int siteid = authToken.getSiteID();
    IBUserManager buserMgr = buserPeer.getInstance();

    String startday = null;
    String endday = null;
    if (startflag == 1) {
        status = ParamUtil.getIntParameter(request, "status",0);
        startday = ParamUtil.getParameter(request, "searchtime1");
        endday = ParamUtil.getParameter(request, "searchtime2");


        String where_clause = "";
        //设置状态查询条件
       /* if (where_clause != "" && where_clause!=null) {
            if (status == 0)
                where_clause = where_clause +" and (o.status=1 or o.status=2 or o.status=3)";
            else
                where_clause = where_clause +" and o.status=" + status;
        } else {
            if (status == 0)
                where_clause = where_clause + "(o.status=1 or o.status=2 or o.status=3)";
            else
                where_clause = where_clause +"o.status=" + status;
        }*/



        List<BUser> list = buserMgr.getBUserListToExcel(siteid,startday,endday,where_clause);

        if(list.size()>0) {
            String path = application.getRealPath("/");
            String downloadurl = "";
            int flag = ParamUtil.getIntParameter(request, "flag", -1);
            if (flag == 0) { //导出订单
                downloadurl = ExportBUserToExcel.ExportUsers(list, path);
            } /*else if (flag == 1) {  //导出符合方正系统要求的订单
                downloadurl = ExportOrderToExcel.ExportOrdersForFangzheng(list, path);
            } */else {
                System.out.println("flag未取到值");
            }
            if (downloadurl != null) {
                //新建一个SmartUpload对象
                SmartUpload su = new SmartUpload();
                //初始化
                su.initialize(pageContext);
                // 设定contentDisposition为null以禁止浏览器自动打开文件
                su.setContentDisposition(null);
                su.downloadFile(path + downloadurl);
            }
        }else{
            out.println("<script lanugage=\"javascript\">alert('无数据');</script>");
        }
    }
%>
<!doctype html>
<html>
<head>
    <title>将用户导出EXCEL文件</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <!--link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script-->


    <link href="../../../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../../../js/jquery-1.12.4.js" type="text/javascript"></script>
    <script language="javascript" src="../../../js/jquery-ui.js" type="text/javascript"></script>
    <!--script language="JavaScript" src="../include/setday.js"></script-->
    <script language="JavaScript">
        function sub(v){
            var searchtime1 = document.getElementById("searchtime1").value;
            var searchtime2 = document.getElementById("searchtime2").value;
            if(searchtime1 == null || searchtime1 == ""){
                alert("请选择开始时间");
                return false;
            }
            if(searchtime2 == null || searchtime2 == ""){
                alert("请选择截止时间");
                return false;
            }
            document.addForm.flag.value=v;
            document.addForm.submit();
            //return true;
        }
        function closewin() {
            window.close();
        }
    </script>

</head>
<body bgcolor="#FFFFFF">
<center><br>
    <form action="exportMembersToExcel.jsp" method="post" name="addForm">
        <input type="hidden" name="startflag" value="1">
        <input type="hidden" name="flag" value="-1">
        <table width="100%" border="0" cellpadding="0">
            <tr bgcolor="#F4F4F4" align="center">
                <td class="moduleTitle"><font color="#48758C">导出指定状态的用户</font></td>
            </tr>

            <tr bgcolor="#d4d4d4" align="right">
                <td>
                    <table width="100%" border="0" cellpadding="2" cellspacing="1">
                        <tr bgcolor="#FFFFFF">
                            <td width="10%">创建日期</td>
                            <td width="40%" valign="top"> 从
                                <input type="text" size="20" name="searchtime1" id="begindateid" readonly>
                                到
                                <input type="text" size="20" name="searchtime2" id="enddateid" readonly>
                            </td>
                            <td width="15%" align="center" class="txt">

                                <%--<div id=l1>
                                    <select name="projcode" id="projcode">
                                        <option value=100 <%=(projcode==100)?"selected":""%>>请选择项目</option>
                                        <option value=101 <%=(projcode==101)?"selected":""%>>一级注册建造师</option>
                                        <option value=102 <%=(projcode==102)?"selected":""%>>二级注册建造师</option>
                                        <option value=103 <%=(projcode==103)?"selected":""%>>一级注册造价师</option>
                                        <option value=104 <%=(projcode==104)?"selected":""%>>二级注册造价师</option>
                                        <option value=105 <%=(projcode==105)?"selected":""%>>现场管理人员</option>
                                        <option value=106 <%=(projcode==106)?"selected":""%>>现场操作人员</option>
                                        <option value=106 <%=(projcode==107)?"selected":""%>>安全三类人员</option>
                                        <option value=106 <%=(projcode==108)?"selected":""%>>其他</option>
                                    </select>
                                </div>--%>
                            </td>

                            <%--<td width="15%" align="center" class="txt">
                                <%if (SecurityCheck.hasPermission(authToken,54)) {%>
                                <div id=l4>
                                    <select name="_sel_n4" id="_sel_id4" style="width: 80px;"> <!--onchange="javascript:setSecondOptions(this);"-->
                                        <option value=0 <%=(source_id==0)?"selected":""%>>订单来源</option>
                                        <option value=1 <%=(source_id==1)?"selected":""%>>全部</option>
                                        <option value=2 <%=(source_id==2)?"selected":""%>>网站</option>
                                        <option value=3 <%=(source_id==3)?"selected":""%>>公众号</option>
                                    </select>
                                </div>
                                <%} else if(organization!=null) {
                                    if (organization.getID().intValue() == rootOrgid) {%>
                                <div id=l4>
                                    <select name="_sel_n4" id="_sel_id4" style="width: 80px;"> <!--onchange="javascript:setSecondOptions(this);"-->
                                        <option value=0 <%=(source_id==0)?"selected":""%>>订单来源</option>
                                        <option value=1 <%=(source_id==1)?"selected":""%>>全部</option>
                                        <option value=2 <%=(source_id==2)?"selected":""%>>网站</option>
                                        <option value=3 <%=(source_id==3)?"selected":""%>>公众号</option>
                                    </select>
                                </div>
                                <%}}%>
                            </td>--%>
                            <td align="center">
                               <%-- <select name="status">
                                    <option value="0" <%=(status==0)?"selected":""%>>培训状态</option>
                                    <option value=1 <%=(status==1)?"selected":""%>>待培训</option>
                                    <option value=2 <%=(status==2)?"selected":""%>>培训中</option>
                                    <option value=3 <%=(status==3)?"selected":""%>>已完成</option>

                                    <!--option value="_" selected>所有订单</option>
                                    <option value="0">新订单</option>
                                    <option value="1">处理中</option>
                                    <option value="2">发货</option>
                                    <option value="3">退货</option>
                                    <option value="4">完成</option>
                                    <option value="5">拒收</option>
                                    <option value="6">缺货</option>
                                    <option value="7">等待客户付款</option>
                                    <option value="8">已付款</option-->
                                </select>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
        </table>
        <p align="center">
            <input type="button" name="tt" value="导出用户" onclick="return sub(0);">
            <%--   <input type="button" name="Ok" value="导出方正格式订单" onclick="return sub(1);">&nbsp;&nbsp;--%>
            <input type="button" name="close" value="关闭" onclick="javascript:closewin();">
        </p>
    </form>
    <p>&nbsp; </p>
</center>
<script language="javascript">
    $(document).ready(function(){
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

        $("#begindateid").datepicker({
            dateFormat: 'yy-mm-dd',
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

        $("#enddateid").datepicker({
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
</body>
</html>