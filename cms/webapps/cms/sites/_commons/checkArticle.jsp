<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    //�ж�����Ȩ��
    int userflag = ParamUtil.getIntParameter(request,"userflag",0);//�Ƿ�ֻ�е�½�û������
    int userlevel = ParamUtil.getIntParameter(request,"userlevel",0);//�û������־
    if(userflag == 1){
        //ֻ�е�¼�û��ɿ� �ж��û��Ƿ��¼
        Uregister ug = (Uregister)session.getAttribute("UserLogin");
        //�û�û�е�¼
        if(ug == null){
            out.print("nologin");
            return;
        }else if (ug.getErrmsg().equals("ok")){
           if(userlevel >= 0){
               if(ug.getUsertype() != userlevel){
                   out.write("nolevel-" + ug.getErrmsg());
                   return;
               }
           }
        } else if (ug.getErrmsg().equals("�û����������")) {
            out.print("�û������");
            return;
        } else if (ug.getErrmsg().equals("�û���ϵͳ����Ա��������ʱֹͣ��¼������")) {
            out.print("�û���ϵͳ����Ա��������ʱֹͣ��¼");
            return;
        } else if (ug.getErrmsg().equals("�û������û������ڣ�����")) {
            out.print("�û������û�������");
            return;
        }
        out.write("true");
    }
%>