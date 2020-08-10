<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/27
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="org.gavaghan.geodesy.GlobalCoordinates" %>
<%@ page import="org.gavaghan.geodesy.Ellipsoid" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.bizwink.service.SignInfoService" %>
<%@ page import="com.bizwink.po.SignInfo" %>
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

    int uid = authToken.getUid();
    String username=authToken.getUsername();
    double target_latitude = ParamUtil.getDoubleParameter(request,"lat",0);
    double target_longitude = ParamUtil.getDoubleParameter(request,"lon",0);
    String signInfos = ParamUtil.getParameter(request,"infos");
    signInfos=SecurityUtil.Decrypto(signInfos);
    System.out.println(signInfos);

    Double latitude = null;
    Double longitude = null;
    String projname = null;
    String trainprojcode = null;
    String coursename = null;
    String coursecode = null;
    Timestamp now = null;
    String[] infos = signInfos.split("&");
    for(int ii=0;ii<infos.length;ii++) {
        int posi = infos[ii].indexOf("=");
        if (posi>-1) {
            String key = infos[ii].substring(0,posi);
            String value = infos[ii].substring(posi+1);
            if (key.equals("latitude")) latitude = Double.parseDouble(value);
            if (key.equals("longitude")) longitude = Double.parseDouble(value);
            if (key.equals("projname")) projname = value;
            if (key.equals("trainprojcode")) trainprojcode = value;
            if (key.equals("course")) coursecode = value;
            if (key.equals("coursename")) coursename = value;
        }
    }

    GlobalCoordinates source = new GlobalCoordinates(latitude, longitude);
    GlobalCoordinates target = new GlobalCoordinates(target_latitude, target_longitude);
    System.out.println("source==" + source);
    System.out.println("target==" + target);

    //double meter1 = CaculateDistance.getDistanceMeter(source, target, Ellipsoid.Sphere);
    double meter2 = CaculateDistance.getDistanceMeter(source, target, Ellipsoid.WGS84);
    int distance = 5000;   //签到的地点与培训地之间允许的距离

    System.out.println("mylatitude==" + target_latitude);
    System.out.println("mylongitude==" + target_longitude);
    System.out.println("latitude==" + latitude);
    System.out.println("longitude==" + longitude);
    System.out.println("projname==" + projname);
    System.out.println("trainprojcode==" + trainprojcode);
    System.out.println("coursecode==" + coursecode);
    System.out.println("coursename==" + coursename);
    System.out.println("meter2==" + meter2);

    //判断数据库中是否已经有签到信息，上下午各签到一次
    //以中午时间为时间判断点，现在的时间在中午12点之后，判断下午是否做过签到，现在时间点在中午12点之前，判断上午是否签到
    now = new Timestamp(System.currentTimeMillis());
    Calendar noon_cal = Calendar.getInstance();
    noon_cal.setTimeInMillis(now.getTime());
    noon_cal.set(Calendar.HOUR,12);
    noon_cal.set(Calendar.MINUTE,0);
    noon_cal.set(Calendar.SECOND,0);

    //签到开始时间
    Calendar startsigntime_cal = Calendar.getInstance();
    startsigntime_cal.setTimeInMillis(now.getTime());
    startsigntime_cal.set(Calendar.HOUR,7);
    startsigntime_cal.set(Calendar.MINUTE,0);
    startsigntime_cal.set(Calendar.SECOND,0);

    //签到结束时间
    Calendar endsigntime_cal = Calendar.getInstance();
    endsigntime_cal.setTimeInMillis(now.getTime());
    endsigntime_cal.set(Calendar.HOUR,18);
    endsigntime_cal.set(Calendar.MINUTE,0);
    endsigntime_cal.set(Calendar.SECOND,0);

    Timestamp startsigntime = new Timestamp(startsigntime_cal.getTimeInMillis());
    Timestamp endsigntime = new Timestamp(endsigntime_cal.getTimeInMillis());
    Timestamp noon = new Timestamp(noon_cal.getTimeInMillis());
    int retcode = 0;
    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext != null) {
        boolean existSigninfoFlag = false;
        SignInfoService signInfoService = (SignInfoService)appContext.getBean("signInfoService");
        if (now.before(noon) && now.after(startsigntime)) {
            //判断下午是否签到
            existSigninfoFlag = signInfoService.CheckSigninfo(BigDecimal.valueOf(uid),trainprojcode,startsigntime.toString(),endsigntime.toString(),noon.toString(),now.toString(),0);
        } else if(now.after(noon) && now.before(endsigntime)){
            //判断上午是否签到
            existSigninfoFlag = signInfoService.CheckSigninfo(BigDecimal.valueOf(uid),trainprojcode,startsigntime.toString(),endsigntime.toString(),noon.toString(),now.toString(),1);
        } else {
            response.sendRedirect("/users/SignAlertInfo.jsp?signtime=" + now.toString() + "&projname=" + projname + "&errcode=-3");
        }

        //如果签到信息标识为假表示学员未签到，保存签到信息
        System.out.println("existSigninfoFlag==" + existSigninfoFlag);
        if (existSigninfoFlag == false && meter2<distance) {
            SignInfo signInfo = new SignInfo();
            signInfo.setUSERID(BigDecimal.valueOf(uid));
            signInfo.setUSERNAME(username);
            signInfo.setPROJCODE(trainprojcode);
            signInfo.setPROJNAME(projname);
            signInfo.setCOURSECODE(coursecode);
            signInfo.setCOURSENAME(coursename);
            signInfo.setSIGNTIME(now);
            signInfo.setCREATEDATE(now);
            retcode = signInfoService.SaveSigninfo(signInfo);
        }
    }

    if (retcode > 0)
        response.sendRedirect("/users/signSuccess.jsp?signtime=" + now.toString() + "&projname=" + projname);
    else {
        int errcode = 0;
        if (meter2>distance) errcode = -2; //不在签到范围内，不能进行签到
        response.sendRedirect("/users/SignAlertInfo.jsp?signtime=" + now.toString() + "&projname=" + projname+"&errcode=" + errcode);
    }
%>