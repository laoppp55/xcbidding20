<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.service.EcService" %>
<%@ page import="com.bizwink.service.TrainInfoService" %>
<%@ page import="com.bizwink.service.ArticleService" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.po.Orders" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.vo.ArticleAndExtendAttrs" %>
<%@ page import="com.bizwink.po.ArticleExtendattr" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.bizwink.service.ArticleClassService" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.po.ArticleClass" %>
<%@ page import="java.math.BigDecimal" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        if (referer_usr!=null) {
            response.sendRedirect("/users/login_m.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        } else {
            response.sendRedirect("/users/login_m.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
            return;
        }
    }

    String allTrainInfo=null;
    int uid = 0;
    List<ArticleAndExtendAttrs> CurrentProjList = new ArrayList<ArticleAndExtendAttrs>();
    uid = authToken.getUid();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    EcService ecService = null;
    ArticleService articleService = null;
    ArticleClassService articleClassService = null;
    List<Orders> ordersList = null;
    String trainStartTime_str = null;
    String trainEndTime_str = null;
    Timestamp trainStartTime = null;
    Timestamp trainEndTime = null;
    Timestamp now = null;
    if (appContext!=null) {
        articleClassService = (ArticleClassService) appContext.getBean("articleClassService");
        articleService = (ArticleService) appContext.getBean("articleService");
        ecService = (EcService) appContext.getBean("ecService");
        ordersList = ecService.getOrdersByUID(uid);
        for(int ii=0;ii<ordersList.size();ii++) {
            Orders order = ordersList.get(ii);
            int articleid = order.getProjartid();
            ArticleAndExtendAttrs articleAndExtendAttrs = articleService.getArticleAndEXtendAttrs(articleid);
            List<ArticleExtendattr> articleExtendattrs = articleAndExtendAttrs.getArticleExtendattrs();
            for(int jj=0;jj<articleExtendattrs.size();jj++) {
                String ename = articleExtendattrs.get(jj).getEname();
                if (ename.equals("_pxbt")){
                    trainStartTime_str = articleExtendattrs.get(jj).getStringvalue();
                    trainStartTime=Timestamp.valueOf(trainStartTime_str);
                }
                if (ename.equals("_pxet")){
                    trainEndTime_str = articleExtendattrs.get(jj).getStringvalue();
                    trainEndTime=Timestamp.valueOf(trainEndTime_str);
                }
            }
            now = new Timestamp(System.currentTimeMillis());
            if (now.before(trainEndTime) && now.after(trainStartTime)) {
                CurrentProjList.add(articleAndExtendAttrs);
            }
        }
    }

    if (CurrentProjList.size() == 0) {
        response.sendRedirect("/users/SignAlertInfo.jsp?signtime=" + now.toString() +"&errcode=-1");
    }
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <title>调用扫一扫</title>
    <script src='http://res.wx.qq.com/open/js/jweixin-1.4.0.js'></script>
    <script src="/js/jquery-1.11.1.min.js"></script>
    <script src="/js/jquery.form.js" type="text/javascript"></script>
    <script>
        function getWxConfig(){
            //获取学员选择课程的信息
            var allTrainInfo = $('input:radio[name="course"]:checked').val();
            var latitude = "";
            var longitude = "";
            htmlobj=$.ajax({
                url:"sign.jsp",
                type:'post',
                dataType:'json',
                data:{
                    email:'petersong@163.com'
                },
                async:false,
                cache:false,
                success:function(data){
                    //alert(data.jsapiticket);
                    //alert(data.noncestr);
                    //alert(data.timestamp);
                    //alert(data.url);
                    //alert(data.signature);
                    wx.config({
                        debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                        appId: 'wx9ec0c0c2b1427624 ', // 必填，企业号的唯一标识，此处填写企业号corpid
                        timestamp:data.timestamp , // 必填，生成签名的时间戳
                        nonceStr: data.noncestr, // 必填，生成签名的随机串
                        signature: data.signature,// 必填，签名，见附录1
                        jsApiList: [
                            'scanQRCode',
                            'openLocation',
                            'getLocation'
                        ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                    });
                    wx.getLocation({
                        type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
                        success: function (res) {
                            latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                            longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                            var speed = res.speed; // 速度，以米/每秒计
                            var accuracy = res.accuracy; // 位置精度
                        }
                    });
                    wx.ready(function() {
                        wx.scanQRCode({
                            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                            scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                            success: function (res) {
                                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                                alert(result + "=" + latitude + "=" + longitude);
                                //window.location.href="http://dx.coosite.com/users/saveSignInfo.jsp?article" + articleid + "&projtype="+ projtypecode + "&major=" + majorcode + "&course=" + coursecode + "&coursename=" + coursename + "&lat=" + latitude + "&lon=" + longitude;
                                window.location.href="http://www.pxzx-bucg.cn/users/saveSignInfo.jsp?infos=" + allTrainInfo + "&lat=" + latitude + "&lon=" + longitude;

                                //sessionStorage.setItem('saomiao_result',result);
                                //其它网页调用二维码扫描结果：
                                //var result=sessionStorage.getItem('saomiao_result');
                            }
                        });
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //弹出jqXHR对象的信息
                    alert(jqXHR.responseText);
                    alert(jqXHR.status);
                    alert(jqXHR.readyState);
                    alert(jqXHR.statusText);
                    //弹出其他两个参数的信息
                    alert(textStatus);
                    alert(errorThrown);
                }
            });
        }
    </script>
</head>
<body>
<div>
    <%
        for(int ii=0; ii<CurrentProjList.size();ii++) {
            ArticleAndExtendAttrs articleAndExtendAttrs = CurrentProjList.get(ii);
            List<ArticleClass> articleClassList = null;
            if (articleClassService!=null) {
                articleClassList = articleClassService.getTrainCources(BigDecimal.valueOf(articleAndExtendAttrs.getId()));
            }

            //剔除课程重复
            List<ArticleClass> listWithoutDupCourse = new ArrayList<ArticleClass>();
            if (articleClassList!=null) {
                for (int jj = 0; jj < articleClassList.size(); jj++) {
                    ArticleClass articleClass = articleClassList.get(jj);
                    boolean dupflag = false;
                    for (int kk = 0; kk < listWithoutDupCourse.size(); kk++) {
                        ArticleClass articleClass1 = listWithoutDupCourse.get(kk);
                        if (articleClass1.getCLASSCODE().equals(articleClass.getCLASSCODE())) {
                            dupflag = true;
                            break;
                        }
                    }
                    if (dupflag == false) listWithoutDupCourse.add(articleClass);
                }
            }

            List<ArticleExtendattr> articleExtendattrs = articleAndExtendAttrs.getArticleExtendattrs();
            String pxAddress = null;
            double longitude = 0d;
            double latitude = 0d;
            for(int jj=0;jj<articleExtendattrs.size();jj++) {
                String ename = articleExtendattrs.get(jj).getEname();
                if (ename.equals("_pxdd")) {
                    pxAddress = articleExtendattrs.get(jj).getStringvalue();
                }
            }
            String jw[] = CaculateDistance.getCoordinate(pxAddress);
            if (jw[0]!=null) longitude = Double.parseDouble(jw[0]);
            if (jw[1]!=null) latitude = Double.parseDouble(jw[1]);
            String trainProjName = articleAndExtendAttrs.getMaintitle();
            String trainProjCode = articleAndExtendAttrs.getBILLNO();

            //用户选择签到的课程
            out.println("<table><tr><td>" + articleAndExtendAttrs.getMaintitle() + "</td></tr>");
            for (int jj = 0; jj < listWithoutDupCourse.size(); jj++) {
                ArticleClass articleClass = listWithoutDupCourse.get(jj);
                allTrainInfo = "latitude=" + latitude + "&longitude=" + longitude + "&projname=" + trainProjName + "&trainprojcode=" + trainProjCode + "&article=" + articleClass.getARTICLEID().intValue() + "&course=" + articleClass.getCLASSCODE() + "&coursename=" + articleClass.getCLASSNAME();
                allTrainInfo = URLEncoder.encode(SecurityUtil.Encrypto(allTrainInfo),"utf-8");
                //out.println("<tr><td><input type='radio' name='course' id='courseid' value='" + articleClass.getARTICLEID().intValue() + "-" + articleClass.getPROJCODE()+"-" + articleClass.getMAJORCODE() + "-" + articleClass.getCLASSCODE() + "-" + articleClass.getCLASSNAME() + "' />" + articleClass.getCLASSNAME() + "</td></tr>");
                out.println("<tr><td><input type='radio' name='course' id='courseid' value='" + allTrainInfo + "' />" + articleClass.getCLASSNAME() + "</td></tr>");
            }
            out.println("</table>");
        }%>
</div>
<div><a href="javascript:getWxConfig();">点我调用扫一扫</a></div>
</body>
</html>