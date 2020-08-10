<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.bizwink.cms.entity.Upload" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    response.setHeader("Cache-Control", "no-store");// 禁止浏览器缓存
    response.setHeader("Pragrma", "no-cache");// 禁止浏览器缓存
    response.setDateHeader("Expires", 0);// 禁止浏览器缓存
    response.setContentType("text/html");
    // PrintWriter out = response.getWriter();
    Upload upload = null;
    upload = (Upload)request.getSession().getAttribute("upload");
    if(null == upload)
        return;
    long currentTime = System.currentTimeMillis();
    //计算已用时，以S为单位
    long time = (currentTime - upload.getStartTime()) / 1000 + 1;
    //计算速度,以kb为单位
    long speed = (long)(double)upload.getUploadSize() / 1024 / time;
    //计算百分比
    int percent =  (int)((double)upload.getUploadSize() / (double)upload.getTotalSize() * 100);
    //已经完成
    int mb = (int)upload.getUploadSize() / 1024 / 1024;
    //总共有多少
    int totalMb = (int)upload.getTotalSize() / 1024 / 1024;
    //剩余时间
    int shenYu =  (int)((upload.getTotalSize() - upload.getUploadSize()) / 1024 / speed);
    String str = time+"-"+speed+"-"+percent+"-"+mb+"-"+totalMb+"-"+shenYu;
    System.out.println(str);
    out.print(str);
    out.flush();
    out.close();
%>