<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.bjhqfw.shetuan.SheTuan" %>
<%@ page import="com.bizwink.cms.bjhqfw.jiben.IJiBenManager" %>
<%@ page import="com.bizwink.cms.bjhqfw.jiben.JiBenPeer" %>
<%@ page import="com.bizwink.cms.bjhqfw.jiben.JiBen" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
      if (authToken == null)
      {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
      }
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    IJiBenManager jMgr = JiBenPeer.getInstance();
    SheTuan mon = new SheTuan();
    List list = jMgr.getAllJiBen("select * from tbl_jiben order by id desc", start, range);
    int totalnum = jMgr.getAllJiBenNum("select count(id) from tbl_jiben");
    int totalpages = 0;
    int currentpage = 0;
    if (totalnum < range) {
        totalpages = 1;
        currentpage = 1;
    } else {
        if (totalnum % range == 0)
            totalpages = totalnum / range;
        else
            totalpages = totalnum / range + 1;

        currentpage = start / range + 1;
    }
%>
<html>
<head>
<title>�����һ�����Ϣ����</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta http-equiv="Pragma" content="no-cache">
<style type="text/css">
TABLE {FONT-SIZE: 12px;word-break:break-all}
BODY {FONT-SIZE: 12px;margin-top: 0px;margin-bottom: 0px; line-height:20px;}
.TITLE {FONT-SIZE:16px; text-align:center; color:#FF0000; font-weight:bold; line-height:30px;}
.FONT01 {FONT-SIZE: 12px; color:#FFFFFF; line-height:20px;}
.FONT02 {FONT-SIZE: 12px; color:#D04407; font-weight:bold; line-height:20px;}
.FONT03 {FONT-SIZE: 14px; color:#000000; line-height:25px;}
A:link {text-decoration:none;line-height:20px;}
A:visited {text-decoration:none;line-height:20px;}
A:active {text-decoration:none;line-height:20px; font-weight:bold;}
A:hover {text-decoration:none;line-height:20px;}
.pad {padding-left:4px; padding-right:4px; padding-top:2px; padding-bottom:2px; line-height:20px;}
.form{border-bottom:#000000 1px solid; background-color:#FFFFFF; border-left:#000000 1px solid; border-right:#000000 1px solid; border-top:#000000 1px solid; font-size: 9pt; font-family:"����";}
.botton{border-bottom:#000000 1px solid; background-color:#F1F1F1; border-left:#FFFFFF 1px solid; border-right:#333333 1px solid; border-top:#FFFFFF 1px solid; font-size: 9pt; font-family:"����"; height:20px; color: #000000; padding-bottom: 1px; padding-left: 1px; padding-right: 1px; padding-top: 1px; border-style: ridge}
</style>
    <script language="javascript">

     function DelJiBen(id){
      var val;
      val = confirm("��ȷ��Ҫɾ����");
      if(val == 1){
        window.location = "delete.jsp?id="+id;
      }
    }

  </script>
</head>
<body>
<input type="hidden" name="updateflag" value="1">
<center>
<table width="90%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
<tr>
      <td>
        <table width="100%" border="0" cellpadding="0">
          <tr bgcolor="#F4F4F4" align="center">
            <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">�����һ�����Ϣ����</td>
          </tr>
          <tr bgcolor="#d4d4d4" align="right">
            <td>
              <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                <tr  bgcolor="#FFFFFF" class="css_001">
                  <td width="5%" align="center">���</td>
                    <td align="center" width="33%">����������</td>
                    <td align="center" width="15%">����������</td>
                    <td align="center" width="33%">������λ��</td>
                    <td align="center" width="7%">�޸�</td>
                    <td align="center" width="7%">ɾ��</td>
                </tr>
                  <%
                        for(int i = 0; i < list.size(); i++){
                            JiBen jb = (JiBen)list.get(i);
                  %>
                <tr  bgcolor="#FFFFFF" class="css_001">
                  <td width="5%" align="center"><%=i+1%></td>
                    <td align="center" width="33%"><%=jb.getMeetname()== null || jb.getMeetname().equalsIgnoreCase("null")?"--":jb.getMeetname()%></td>
                    <td align="center" width="15%"><%=jb.getMeetmax()==null || jb.getMeetmax().equalsIgnoreCase("null")?"--":jb.getMeetmax()%></td>
                    <td align="center" width="33%"><%=jb.getMeetroot() == null || jb.getMeetroot().equalsIgnoreCase("null")?"--":jb.getMeetroot()%></td>
                    <td align="center" width="7%"><a href ="edit.jsp?id=<%=jb.getId()%>">�޸�</a></td>
                    <td align="center" width="7%"><a href="#" onclick="javascript:return DelJiBen(<%=jb.getId()%>);">ɾ��</a></td>
                </tr>
                  <%}%>
               </table>
            </td>
          </tr>
            <tr>
                <td align="right">
                 <a href="../index.jsp"> �� �� </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <a href="create.jsp">��ӻ��������Ϣ</a>
                </td>
            </tr>
        </table>
                <p align=center>
                <TABLE>
                    <TBODY>
                    <TR>
                        <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp; ��<%=totalnum%>��&nbsp;&nbsp; ��ǰ��<%=currentpage%>ҳ&nbsp;
                            <%
                                if ((start - range) >= 0) {
                            %>
                            <a href="index.jsp?start=0">��һҳ</a>
                            <%}%>
                            <%if ((start - range) >= 0) {%>
                            <a href="index.jsp?start=<%=start-range%>">��һҳ</a>
                            <%}%>
                            <%if ((start + range) < totalnum) {%>
                            <A href="index.jsp?start=<%=start+range%>">��һҳ</A>
                            <%}%>
                            <%if (currentpage != totalpages) {%>
                            <A href="index.jsp?start=<%=(totalpages-1)*range%>">���һҳ</A>
                            <%}%>
                        </TD>
                        <TD>&nbsp;</TD>
                    </TR>
                    </TBODY>
                </TABLE>
      </td>
</tr>
</table>

</center>
</body>
</html>