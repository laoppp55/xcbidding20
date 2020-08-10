<%@ page import="com.google.zxing.EncodeHintType" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.MultiFormatWriter" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.security.Auth" %>
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
    if (authToken==null) response.sendRedirect("/users/login.jsp");
    String userid = authToken.getUserid();

    //设置页面不缓存
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    String code_url="http://www.pxzx-bucg.cn/users/saveSignInfo.jsp";
    //String code_url="http://dx.coosite.com/users/saveSignInfo.jsp";

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
%>
