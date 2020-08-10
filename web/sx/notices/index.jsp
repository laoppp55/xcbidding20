<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.po.Users" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.IUserService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>北京市西城区公共资源交易系统--用户个人中心</title>
    <link href="/css/basis.css" rel="stylesheet" type="text/css">
    <link href="/css/program_style.css" rel="stylesheet" type="text/css">
    <link href="/css/index.css" rel="stylesheet" type="text/css" />
    <link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery.min.js" type="text/javascript"></script>
    <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
    <script src="/js/users.js" type="text/javascript"></script>
    <script language="javascript">
        function deleteOrder(orderid,checkcode,thetime) {
            htmlobj=$.ajax({
                url:"/ec/deleteOrder.jsp",
                data: {
                    orderid:orderid,
                    checkcode:checkcode,
                    thetime:thetime
                },
                dataType:'json',
                async:false,
                success:function(data){
                    if (data.result == 'true') {
                        $("#row" + orderid).remove();
                        alert("成功删除订单："+orderid);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    /*弹出jqXHR对象的信息*/
                    alert(jqXHR.responseText);
                    alert(jqXHR.status);
                    alert(jqXHR.readyState);
                    alert(jqXHR.statusText);
                    /*弹出其他两个参数的信息*/
                    alert(textStatus);
                    alert(errorThrown);
                }
            });
        }

        function queryPay(orderid) {
            htmlobj=$.ajax({
                url:"/ec/queryPayinfo.jsp",
                data: {
                    orderid:orderid
                },
                dataType:'json',
                async:false,
                success:function(data){
                    if (data.支付方式 == '微信支付') {
                        alert('你已经使用微信支付方式完成了支付，不需要在进行支付，支付信息如下\r\n' +
                            '支付方式：微信支付\r\n' +
                            '商品名称：' + data.商品名称 + '\r\n' +
                            '订单号：' + data.订单号 + '\r\n' +
                            '支付交易流水号：' + data.支付交易流水号 + '\r\n' +
                            '支付金额：' + data.支付金额 + '\r\n' +
                            '交易币种：' + data.交易币种 + '\r\n' +
                            '支付状态：' + data.支付状态 + '\r\n' +
                            '支付完成时间：' + data.支付完成时间);
                    } else if (data.支付方式 == '银行支付') {
                        alert('你已经使用银行支付方式完成了支付，不需要在进行支付，支付信息如下' + '\r\n' +
                            '支付方式：银行支付' + '\r\n' +
                            '商品名称：' + data.商品名称 + '\r\n' +
                            '订单号：' + data.订单号 + '\r\n' +
                            '支付交易流水号：' + data.支付交易流水号 + '\r\n' +
                            '支付金额：' + data.支付金额 + '\r\n' +
                            '交易币种：' + data.交易币种 + '\r\n' +
                            '支付状态：' + data.支付状态 + '\r\n' +
                            '支付完成时间：' + data.支付完成时间);
                    }
                }
            });
        }

        function showProjDetail(orderid) {
            var iWidth=window.screen.availWidth-400;                                                 //弹出窗口的宽度;
            var iHeight=600;                                                //弹出窗口的高度;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
            window.open("/users/trainprjdetail.jsp?orderid=" + orderid, "", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + "toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
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
    <div class="personal_left">
        <div class="title">公告</div>
        <ul>
            <li><a href="/users/updatereg.jsp">采购公告</a></li>
            <li><a href="/users/updatereg.jsp">变更公告</a></li>
            <li><a href="/users/updatereg.jsp">中标结果公告</a></li>
            <li><a href="/users/updatereg.jsp">废标公告</a></li>
            <li><a href="/users/changePwd.jsp">合同公告</a></li>
            <li><a href="/users/changePwd.jsp">单一来源公告</a></li>
        </ul>
    </div>
    <div class="personal_right_box">
        <table width="875" border="0" align="left" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-top:25px;">
            <tbody>
            <tr>
                <td width="10%" height="25" align="center" valign="middle" bgcolor="#f6f4f5">采购项目编号</td>
                <td width="30%" align="center" valign="middle" bgcolor="#f6f4f5">采购项目名称</td>
                <td width="10%" align="center" valign="middle" bgcolor="#f6f4f5">预算金额</td>
                <td width="10%" align="center" valign="middle" bgcolor="#f6f4f5">采购单位</td>
                <td width="10%" align="center" valign="middle" bgcolor="#f6f4f5">代理机构</td>
                <td width="10%" align="center" valign="middle" bgcolor="#f6f4f5">采购方式</td>
                <td width="10%" align="center" valign="middle" bgcolor="#f6f4f5">创建时间</td>
                <td width="10%" align="center" valign="middle" bgcolor="#f6f4f5">项目状态</td>
            </tr>
            </tbody>
        </table>
        <!--div class="page">
            <span>第1页</span>
            <span>共172页</span>
            <a href="/xwxx/qyyw/index.shtml">上一页</a>
            <span class="cur">1</span>
            <a href="/xwxx/qyyw/index1.shtml">2</a>
            <a href="/xwxx/qyyw/index2.shtml">3</a>
            <a href="/xwxx/qyyw/index3.shtml">4</a>
            <a href="/xwxx/qyyw/index4.shtml">5</a>
            <a href="/xwxx/qyyw/index1.shtml">下一页</a>
            <span class="txtl">转到第</span>
            <span class="select-pager"><form name="form"><select name="turnPage" size="1" onchange="window.location=this.form.turnPage.value;"><option value="/xwxx/qyyw/index.shtml" selected="">1</option><option value="/xwxx/qyyw/index1.shtml">2</option><option value="/xwxx/qyyw/index2.shtml">3</option><option value="/xwxx/qyyw/index3.shtml">4</option><option value="/xwxx/qyyw/index4.shtml">5</option><option value="/xwxx/qyyw/index5.shtml">6</option><option value="/xwxx/qyyw/index6.shtml">7</option><option value="/xwxx/qyyw/index7.shtml">8</option><option value="/xwxx/qyyw/index8.shtml">9</option><option value="/xwxx/qyyw/index9.shtml">10</option><option value="/xwxx/qyyw/index10.shtml">11</option><option value="/xwxx/qyyw/index11.shtml">12</option><option value="/xwxx/qyyw/index12.shtml">13</option><option value="/xwxx/qyyw/index13.shtml">14</option></select></form></span>
            <span class="txtr">页</span>
        </div-->

    </div>
</div>
<!--以下页面尾-->
</body>
</html>
