<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.webapps.leaveword.IWordManager" %>
<%@ page import="com.bizwink.webapps.leaveword.LeaveWordPeer" %>
<%@ page import="com.bizwink.webapps.leaveword.Word" %>
<%@ page contentType="text/html;charset=gbk" pageEncoding="gbk" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
      if (authToken == null)
      {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
      }

     Word word = new Word();
    int id = ParamUtil.getIntParameter(request,"id",0);
    int markid = ParamUtil.getIntParameter(request,"markid",0);
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);
    IWordManager wordMgr = LeaveWordPeer.getInstance();
    word = wordMgr.getAWord(id);
    if(startflag == 1){
        String  retcontent = ParamUtil.getParameter(request, "retcontent");
        wordMgr.updateRetcontent(id,retcontent);
        response.sendRedirect("index1.jsp?markid="+markid);

    } %>
<html>
<head>
    <title>
        �ظ��û�����
    </title>
    <style type="text/css">
    TABLE {FONT-SIZE: 12px;word-break:break-all}
    A:link {text-decoration:none;line-height:20px;}
    A:visited {text-decoration:none;line-height:20px;}
    A:active {text-decoration:none;line-height:20px; font-weight:bold;}
    A:hover {text-decoration:none;line-height:20px;}
        .btn{
     background-color:transparent;  /* ����ɫ͸�� */
     font-size:12px;
    }
    </style>
</head>
</html>
<body>
<form action="retcontent.jsp" method="post" name="form">
<table width="90%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF">
<tr>
      <td width="10%" align="center" valign="top" >
          �������ݣ�
          </td>
    
    <td align="left">
          <%=word.getContent()%>
        </td>
    </tr>
    	<tr>
			    <Td height="20"></Td>
			</tr>

<% if (word.getRetcontent() == null || word.getRetcontent().trim().equals("")){
     %>

  <tr>
      <td width="10%" align="center" valign="top" >
          �ظ����ݣ�
          </td>
      <td>
          <textarea rows="5" cols="100" name="retcontent"></textarea>
      </td>
  </tr>
    	<tr>
			    <Td height="20"></Td>
			</tr>
    <tr>
        <td></td>
        <td>
        <input type="submit" value="ȷ�ϻظ�" name="sub" class="btn">
            <input type="hidden" name="startflag" value="1">
            <input type="hidden" name="id" value="<%=id%>">
            <input type="hidden" name="markid" value="<%=markid%>">
            <a href="index1.jsp?markid=<%=markid%>">�����û��������</a>

        </td>
    </tr>

<%}else{%>
      <tr>
      <td width="10%" align="center" valign="top" >
          �ظ����ݣ�
          </td>
    
      <td align="left" >
          <%=word.getRetcontent()%>
      </td>
  </tr>
    	<tr>
			    <Td height="20"></Td>
			</tr>
      <tr>
      <td width="10%" align="center" valign="top" >
          �޸Ļظ���
          </td>
      <td>
          <textarea rows="5" cols="100" name="retcontent"></textarea>
      </td>
  </tr>
    <tr>
        <td></td>
        <td>
        <input type="submit" value="ȷ���޸�" name="sub" class="btn">
            <input type="hidden" name="startflag" value="1">
            <input type="hidden" name="id" value="<%=id%>">
            <input type="hidden" name="markid" value="<%=markid%>">
          <a href="index1.jsp?markid=<%=markid%>">�����û��������</a>
        </td>
    </tr>
    <%}%>
</table>   </form>
    <%
 //   response.sendRedirect("index.jsp");
    %>
</body>
</html>