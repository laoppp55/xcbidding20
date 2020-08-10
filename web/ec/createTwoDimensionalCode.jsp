<%@ page import="com.google.zxing.EncodeHintType" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.MultiFormatWriter" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.bizwink.util.SecurityUtil" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URLDecoder" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="image/png" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/m/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr, "utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    String checkcode = ParamUtil.getParameter(request, "check");
    String code_url = ParamUtil.getParameter(request,"codeurl");

    if (code_url== null) code_url = "";

    String weixin_checkcode_src = "createTwoDimensionalCode.jsp?codeurl=" + code_url;
    String checkcode_src = URLDecoder.decode(SecurityUtil.Decrypto(checkcode), "utf-8");

    System.out.println("checkcode_src==" + checkcode_src);
    System.out.println("checkcode_src==" + weixin_checkcode_src);

    out.clear();
    //设置页面不缓存
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    //JSONObject json = new JSONObject();
    //json.put(
    //        "zxing",
    //        "https://github.com/zxing/zxing/tree/zxing-3.0.0/javase/src/main/java/com/google/zxing");
    //json.put("author", "shihy");
    //String content = json.toJSONString();// 内容

    if (checkcode_src.equalsIgnoreCase(weixin_checkcode_src)) {
        int width = 300; // 图像宽度
        int height = 300; // 图像高度
        String format = "png";// 图像类型
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        BitMatrix bitMatrix = new MultiFormatWriter().encode(code_url, BarcodeFormat.QR_CODE, width, height, hints);// 生成矩阵
        // 输出图象到页面
        ServletOutputStream stream = null;
        stream = response.getOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, format, stream);
    } else {
        String realPath = this.getServletConfig().getServletContext().getRealPath("/");
        File filePic = new File(realPath + "images" + File.separator + "pic5fbo0p3j.jpg");
        if(filePic.exists()){
            FileInputStream is = new FileInputStream(filePic);
            int i = is.available(); // 得到文件大小
            byte data[] = new byte[i];
            is.read(data); // 读数据
            is.close();
            response.setContentType("image/*"); // 设置返回的文件类型
            OutputStream toClient = response.getOutputStream(); // 得到向客户端输出二进制数据的对象
            toClient.write(data); // 输出数据
            toClient.close();
        }
    }
%>
