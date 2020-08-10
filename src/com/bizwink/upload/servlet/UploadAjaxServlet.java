package com.bizwink.upload.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bizwink.cms.entity.Upload;

@SuppressWarnings("serial")
public class UploadAjaxServlet extends HttpServlet {

    public UploadAjaxServlet() {
        super();
    }

    public void destroy() {
        super.destroy(); // Just puts "destroy" string in log
        // Put your code here
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-store");// 禁止浏览器缓存
        response.setHeader("Pragrma", "no-cache");// 禁止浏览器缓存
        response.setDateHeader("Expires", 0);// 禁止浏览器缓存
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
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
        String filename = upload.getRet_filename();
        String str = time+"-"+speed+"-"+percent+"-"+mb+"-"+totalMb+"-"+shenYu + "-" + filename;
        out.print(str);
        out.flush();
        out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out
                .println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
        out.println("<HTML>");
        out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
        out.println("  <BODY>");
        out.print("    This is ");
        out.print(this.getClass());
        out.println(", using the POST method");
        out.println("  </BODY>");
        out.println("</HTML>");
        out.flush();
        out.close();
    }

    public void init() throws ServletException {
        // Put your code here
    }
}