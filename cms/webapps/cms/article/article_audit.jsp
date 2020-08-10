<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.audit.Audit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.extendAttr.IExtendAttrManager" %>
<%@ page import="com.bizwink.cms.extendAttr.ExtendAttrPeer" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int articleID = ParamUtil.getIntParameter(request,"articleid",0);
    String status = request.getParameter("status");
     //�����������session��
    if(status != null){
            List testlist =  (List)session.getAttribute("audit_article");
            if(testlist == null ){
                   testlist =  new ArrayList();
            }
            String sign = ParamUtil.getParameter(request,"sign");
            String comments = ParamUtil.getParameter(request,"comments");

           String day = ParamUtil.getParameter(request,"day");
           SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
           Timestamp days = new Timestamp(df.parse(day).getTime());

            Audit audit = new Audit();
            audit.setSign(sign);
            audit.setComments(comments);
            audit.setCreateDate(days);
            testlist.add(audit);
            session.setAttribute("audit_article",testlist);
    }
    List oauditlist = (List)session.getAttribute("audit_article");
    List auditlist = new ArrayList();
    IExtendAttrManager Mgr = ExtendAttrPeer.getInstance();
    auditlist = Mgr.getArticleAudit(articleID);
    //ɾ��session�е�������
   int dflag = ParamUtil.getIntParameter(request,"dflag",-1);
    if(dflag == 1 ) {
        String sign = ParamUtil.getParameter(request,"sign");
        String comments = ParamUtil.getParameter(request,"comments");
        if( oauditlist != null) {
           for(int i = 0 ; i < oauditlist.size(); i++){
               Audit audit = (Audit)oauditlist.get(i);
               if( sign.equals(audit.getSign()) && comments.equals(audit.getComments()) ){
                   oauditlist.remove(i);
                   break;
               }
           }
        }
    }else if( dflag == 0){
        int id = ParamUtil.getIntParameter(request,"id",0);
        if(id != 0){
            int code =  Mgr.deleteaudit(id);
            if( code == 0 ){
                response.sendRedirect(response.encodeRedirectURL("article_audit.jsp?articleid=" + articleID));
            }
        }
    }

%>
<html>
<head>
    <title>�������</title>
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script language="JavaScript" src="setday.js"></script>
    <script language="JavaScript">
         function cal() {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = "";
                top.close();
            } else {
                top.close();
            }
        }
        function check(){
           if(document.form.sign.value == ""){
               alert("�����������");
               document.form.sign.focus();
               return false;
           }
           if(document.form.comments.value == ""){
               alert("������������");
               document.form.comments.focus();
               return false;
           }
           if(document.form.day.value == ""){
               alert("��ѡ�����ʱ��");
               document.form.day.focus();
               return false;
           }
           return true;
        }
    </script>
</head>
<body bgcolor="#cccccc">
    <form action="" name="form" onsubmit="return check();" >
        <input type="hidden" name="status" value="save">
        <input type="hidden" name="articleid" value="<%=articleID%>">
        <table align="center" >
            <tr>
                 <td>����ˣ�<input type="text" name="sign"></td>
                 <td>��������<input type="text" name="comments"></td>
                 <td>���ʱ�䣺<input onfocus="setday(this)"  name="day"></td>
            </tr>

              <tr>
                <td align="right" colspan="2">
                    <input  type="submit" value="�ύ" >
                    <input type="button" value="����"  onClick="cal();">
                </td>
            </tr>
        </table>
        
    </form>


<table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0">
                <tr bgcolor="#F4F4F4" align="center">
                    <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">����������</td>
                </tr>
                <tr bgcolor="#d4d4d4" align="right">
                    <td>
                        <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                            <tr  bgcolor="#FFFFFF" class="css_001">
                                <td width="20%" align="center" bgcolor="#FFFFFF">�����</td>
                                <td align="center" width="50%">������</td>
                                <td align="center" width="20%">���ʱ��</td>
                                <td align="center" width="10%">ɾ��</td>
                            </tr>
                            <%
                                 if( oauditlist != null ){
                                    for(int i = 0; i < oauditlist.size();i++){
                                        Audit audit2 = (Audit)oauditlist.get(i);
                            %>
                            <tr  bgcolor="#FFFFFF" class="css_001">
                                <td width="20%" align="center" bgcolor="#FFFFFF"><%=audit2.getSign()==null?"":audit2.getSign()%></td>
                                <td align="center" width="50%"><%=audit2.getComments()==null?"":audit2.getComments()%></td>
                                <td align="center" width="20%"><%=audit2.getCreateDate()==null?"":audit2.getCreateDate().toString().substring(0,10)%></td>
                                <td align="center" width="10%"><a href="?dflag=1&articleid=<%=articleID%>&sign=<%=audit2.getSign()%>&comments=<%=audit2.getComments()%>">ɾ��</a></td>
                            </tr>
                            <%}}%>

                        </table>

                    </td>
                </tr>

            </table>
    </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0">
                <tr bgcolor="#F4F4F4" align="center">
                    <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">������</td>
                </tr>
                <tr bgcolor="#d4d4d4" align="right">
                    <td>
                        <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                            <tr  bgcolor="#FFFFFF" class="css_001">
                                <td width="20%" align="center" bgcolor="#FFFFFF">�����</td>
                                <td align="center" width="50%">������</td>
                                <td align="center" width="20%">���ʱ��</td>
                                <td align="center" width="10%">ɾ��</td>
                            </tr>
                            <%
                                    for(int i = 0; i < auditlist.size();i++){
                                        Audit audit3 = (Audit)auditlist.get(i);
                            %>
                            <tr  bgcolor="#FFFFFF" class="css_001">
                                <td width="20%" align="center" bgcolor="#FFFFFF"><%=audit3.getSign()==null?"":audit3.getSign()%></td>
                                <td align="center" width="50%"><%=audit3.getComments()==null?"":audit3.getComments()%></td>
                                <td align="center" width="20%"><%=audit3.getCreateDate()==null?"":audit3.getCreateDate().toString().substring(0,10)%></td>
                                <td align="center" width="10%"><a href="?dflag=0&articleid=<%=articleID%>&id=<%=audit3.getID()%>">ɾ��</a></td>
                            </tr>
                            <%}%>

                        </table>

                    </td>
                </tr>

            </table>
    </td>
    </tr>
</table>

</body>
</html>