<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.MultiFormatWriter" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.EncodeHintType" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.File" %>
<%--

  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-10-13
  Time: 上午9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="image/png" %>
<%
    System.out.println("hello hello");
    int width = 300; // 图像宽度
    int height = 300; // 图像高度
    String format = "PNG";// 图像类型
    Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
    hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
    BitMatrix bitMatrix = new MultiFormatWriter().encode("fffffffff", BarcodeFormat.QR_CODE, width, height, hints);// 生成矩阵
    File file=new File("/usr/local/www/code.png");
    MatrixToImageWriter.writeToFile(bitMatrix, format, file);
    MatrixToImageWriter.writeToStream(bitMatrix, format, response.getOutputStream());
%>
