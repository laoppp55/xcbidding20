<%@page import="com.jspsmart.upload.*" contentType="text/html;charset=gb2312"%>
<%@ page import="java.sql.Timestamp"%>
<%
  //��ȡ��ǰ·���µ��ļ�
   String path = request.getRealPath(".");
    Timestamp today = new Timestamp(System.currentTimeMillis());
  String todaytime = String.valueOf(today);
  todaytime = todaytime.substring(0, todaytime.indexOf(" "));
  todaytime = todaytime.replaceAll("-",""); 
  //������������
  String name = todaytime + "phone.txt";
  String url = path+"/"+name;
   //�½�һ��SmartUpload����
   SmartUpload su = new SmartUpload();
   //��ʼ��
   su.initialize(pageContext);
   // �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ�
   su.setContentDisposition(null);
   su.downloadFile(url);
