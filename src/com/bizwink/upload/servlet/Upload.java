package com.bizwink.upload.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bizwink.cms.server.InitServer;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.bizwink.lister.UploadLister;

@SuppressWarnings("serial")
public class Upload extends HttpServlet {

    public Upload() {
        super();
    }

    public void destroy() {
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
        out.println("<HTML>");
        out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
        out.println("  <BODY>");
        out.print("    This is ");
        out.print(this.getClass());
        out.println(", using the GET method");
        out.println("  </BODY>");
        out.println("</HTML>");
        out.flush();
        out.close();
    }

    @SuppressWarnings({ "deprecation", "unchecked" })
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();

        com.bizwink.cms.entity.Upload upload = new com.bizwink.cms.entity.Upload();

        UploadLister lister = new UploadLister(upload);

        ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());

        //只是上传监听器
        servletFileUpload.setProgressListener(lister);
        request.getSession().setAttribute("upload", upload);

        List list = null;
        try {
            list = servletFileUpload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        for(Iterator iter = list.iterator(); iter.hasNext();){
            //得到文件对象
            FileItem fileItem = (FileItem)iter.next();
            //是表单才进行处理
            if(fileItem.isFormField()){
                break;
            }

            //同意linux和windows的路径分隔符
            String name = fileItem.getName().replaceAll("/", "\\");
            //得到文件名
            int index = name.lastIndexOf("\\");
            String fileName = "";
            if(index == -1){
                fileName = name;
            }else{
                fileName = name.substring(index + 1);
            }

            //文件名加UUID保障文件名唯一
            String uuid = UUID.randomUUID().toString();
            uuid = uuid.replace("-", "");
            fileName = uuid + "_" + fileName;

            //将服务器端生成的文件名保存到Session中，jsp从Session中获取服务器端的文件名，并将文件名设置到前端页面
            request.getSession().setAttribute("servr_filename", fileName);

            //获取收入流
            InputStream fileInputStream = fileItem.getInputStream();

            //获取上传文件保存的根路径
            InitServer initServer = InitServer.getInstance();
            String path = initServer.getProperties().getProperty("main.uploaddir");
            //String path = request.getRealPath("/upload");
            //也可不用自己写实现方法直接使用,fileItem.write(uploadFile);
            File uploadFile = new File(path,fileName);
            //首先要确认路径是否存在
            uploadFile.getParentFile().mkdirs();
            //检查文件是否已经存在
            if(!uploadFile.exists()){
                //建立文件
                uploadFile.createNewFile();
            }
            FileOutputStream out2 = new FileOutputStream(uploadFile);
            //开始copy文件

            @SuppressWarnings("unused")
            int len = 0;//每次读取的字节数
            byte[] bytes = new byte[1024];
            while((len = fileInputStream.read(bytes, 0, bytes.length)) != -1){
                out2.write(bytes);
            }
            out2.flush();
            out2.close();
            fileInputStream.close();
        }
        out.flush();
        out.close();
    }

    public void init() throws ServletException {
    }
}
