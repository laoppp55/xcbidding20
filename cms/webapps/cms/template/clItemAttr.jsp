<%@ page import="java.sql.*,
    java.text.*,
    com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%
    String itemText = ParamUtil.getParameter(request,"item");
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>main.jsp</title>
<link rel=stylesheet type="text/css" href="../style/global.css">
<SCRIPT LANGUAGE=JavaScript FOR=Ok EVENT=onclick>
   attrVal = "<%=itemText%>";

   //�Ƿ���ʾ����Ŀ�б�  0--��ʾ    1--����ʾ
   for (i=0; i<2; i++) {
    if (subCList[i].checked) {
      val = subCList[i].value
    }
   }
   if (val == 0)
   	attrVal = attrVal + "-subCList=yes";

   attrVal = attrVal + "-" + "artNum=" + artNum.value;

   window.returnValue =attrVal;
   window.close();
</SCRIPT>

<SCRIPT LANGUAGE=JavaScript FOR=Cancel EVENT=onclick>
   attrVal = "<%=itemText%>";
   window.returnValue =attrVal;
   window.close();
</SCRIPT>

</head>

<BODY bgcolor="#FFFFFF">
<div align="center">
  <table width="592" border="1" height="255" bgcolor="#CCCCCC">
    <tr>
      <td width="32%" height="29">��Ŀ���ƣ�</td>
      <td width="68%" height="29"><%=itemText%></td>
    </tr>
    <tr>
      <td width="32%" height="50">����Ŀ�б�</td>
      <td width="68%" height="50">
        <input type="radio" name="subCList" value="0">
        ��ʾ
        <input type="radio" name="subCList" value="1" checked>
        ����ʾ </td>
    </tr>
    <tr>
      <td width="32%" height="21">��ʾ����������</td>
      <td width="68%" height="21">
        <select name="artNum" style="width:40" title="���ִ�С">
          <option value="0" selected>0
          <option value="1">1
          <option value="2">2
          <option value="3">3
          <option value="4">4
          <option value="5">5
          <option value="6">6
          <option value="7">7
          <option value="8">8
          <option value="9">9
          <option value="10">10
          <option value="11">11
          <option value="12">12
          <option value="13">13
          <option value="14">14
          <option value="15">15
          <option value="16">16
          <option value="17">17
          <option value="18">18
          <option value="19">19
          <option value="20">20
          <option value="21">21
          <option value="22">22
          <option value="23">23
          <option value="24">24
          <option value="25">25
          <option value="26">26
          <option value="27">27
          <option value="28">28
          <option value="29">29
          <option value="30">30
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="2" height="21">
        <div align="center">
          <input type="button" name="Ok" value="ȷ��">
          <!--input type="button" ONCLICK="javascript:window.close();return &quot;<%=itemText%>&quot;" value="ȡ��"-->
          <input type="button" name="Cancel" value="ȡ��">
        </div>
      </td>
    </tr>
  </table>

</div>
</BODY>
</html>