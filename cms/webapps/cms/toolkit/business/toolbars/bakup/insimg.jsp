<%@ page import="java.sql.*,
                 java.io.*,
             com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
         com.jspsmart.upload.*,
                 com.bizwink.cms.publish.*,
         com.bizwink.cms.util.*" contentType="text/html;charset=gbk"%>
<%  ////////////////////////////////
    // Retreive parameters
   Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
   if( authToken == null ) {
     response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
     return;
   }

   int columnID  = ParamUtil.getIntParameter(request, "column", 0);
%>

<HTML>
<HEAD>
<TITLE>����ͼƬ</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../style/global.css">

<STYLE TYPE="text/css">
 BODY   {margin-left:10; font-family:Verdana; font-size:12; background:menu}
 BUTTON {width:5em}
 TABLE  {font-family:Verdana; font-size:12}
 P      {text-align:center}
</STYLE>

<SCRIPT LANGUAGE="JavaScript" >
<!--
function upload() {
  if ((uploadpic.filenames.value !="") &&(uploadpic.filenames.value !=null) && (uploadpic.alttext.value != "")) {
  	 window.returnValue =uploadpic.filenames.value+"-"+uploadpic.alttext.value+"-"+uploadpic.aju.value+"-"+uploadpic.bw.value+"-"+uploadpic.hp.value+"-"+uploadpic.vp.value+"-"+uploadpic.picw.value+"-"+uploadpic.pich.value;
         uploadpic.action = '../upload/uploadpic.jsp?column='+ '<%=columnID%>';
  	 uploadpic.submit();
  	 window.close();
  }else {
  	alert("��ѡ��Ҫ�����ͼƬ������û��ѡ����滻���ı�");
  	uploadpic.filenames.focus();
  }
}
// -->
</SCRIPT>

</HEAD>

<BODY onload="uploadpic.filenames.focus()">
<p>&nbsp;</p>
<Form  method="post" name=uploadpic enctype=multipart/form-data target="temp">
  <TABLE CELLSPACING=10 align=center width="442" border="1">
    <TR>
      <TD height="34">��ѡ������ͼƬ
      <TD height="34">
        <input type=file id="filenames"  size=18 name="filenames" >
    </TR>
    <TR>
      <TD colspan=2 align=center>
        <div align="left"> �滻���֣�
          <input type="text" name="alttext" size="40">
        </div>
      </TD>
    </TR>
    <TR>
      <TD align=center>
        <div align="left">
          <p>���뷽ʽ��
            <select name="aju" size="1">
              <option value="novalue">������</option>
              <option value="left" selected>��</option>
              <option value="right">��</option>
              <option value="center">�м�</option>
              <option value="absMiddle">������</option>
              <option value="textTop">�ı��Ϸ�</option>
              <option value="basicline">����</option>
              <option value="absBottom">���·�</option>
              <option value="bottom">��</option>
              <option value="middle">��</option>
              <option value="top">��</option>
            </select>
          </p>
          <p> �߿��ȣ�
            <input type="text" name="bw" size="15" value=0>
          </p>
          </div>
      </TD>
      <TD align=center>
        <p>ˮƽ�����
          <input type="text" name="hp" size="15" value=0>
        </p>
        <p>��ֱ�����
          <input type="text" name="vp" size="15" value=0>
        </p>
      </TD>
    </TR>
    <TR>
      <TD colspan=2 align=center>
         <p>ͼƬ��ȣ�
          <input type="text" name="picw" size="15" value=0>
          ͼƬ�߶ȣ�
          <input type="text" name="pich" size="15" value=0>
        </p>
      </TD>
    </TR>
    <TR>
      <TD colspan=2 align=center>
        <input type="button" ID=Ok name=ok onclick="javascript:upload()" value="ȷ��">
        <input type="button" ONCLICK="javascript:window.close();" value="ȡ��">
      </TD>
    </TR>
  </TABLE>
</FORM>

</BODY>
</HTML>