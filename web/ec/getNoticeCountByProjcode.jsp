<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.po.*" %>
<%@ page import="com.bizwink.service.INoticeService" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.vo.voBulletinNotice" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String projcode = ParamUtil.getParameter(request,"projcode");
    String buymethod_type = ParamUtil.getParameter(request,"buymethod");
    List<voBulletinNotice> bulletinNotices = null;

    ApplicationContext appContext = SpringInit.getApplicationContext();
    if (appContext!=null) {
        //获取采购项目对应的招标公告的列表
        INoticeService noticeService= (INoticeService)appContext.getBean("noticeService");
        //一个采购项目可能对应有多个公告
        if (buymethod_type.equals("1"))
        bulletinNotices = noticeService.getBulletinNoticeByproject(projcode);
        else if (buymethod_type.equals("3") || buymethod_type.equals("6"))
            ;
        else if (buymethod_type.equals("4"))
            ;
    }


%>
