<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@page contentType="text/html;charset=gbk"%>
<%
    Uregister ug = (Uregister)session.getAttribute("UserLogin");
    if (ug.getMemberid() != null) {
        System.out.println("�û���½�ɹ�");
        out.write("��ӭ<b>"+ ug.getMemberid() + "</b>��¼����վ<br>�˳�����<a href=/_commons/logout.jsp><font color=red>�˳�</font></a>");
        if(ug.getUsertype() == 2)
            out.write("<br>�鿴����<a href=/internal/index.shtml><font color=red>�鿴</font></a>");
    } else {
        System.out.println("�û���½ʧ��");
        out.write("nologin");
    }
%>