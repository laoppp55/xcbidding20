<%@ page import="com.jspsmart.upload.*" %>
<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page contentType="text/html;charset=gbk"%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    //�����weblogic����ͬ��Ҫ���ϴ˾�
    String userid = authToken.getUserID();
    String sitename = authToken.getSitename();
    String appPath = application.getRealPath("/");
    response.reset();
    String disName = request.getParameter("file");
    SmartUpload su = new SmartUpload();
    su.initialize(pageContext);
    // �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ���
    //��֤������Ӻ��������ļ��������趨�������ص��ļ���չ��Ϊ
    //docʱ����������Զ���word��������չ��Ϊpdfʱ��
    //���������acrobat�򿪡�
    exportWriter writer = new exportWriter();
    su.setContentDisposition(null);
    // �����ļ�
    String fileName = writer.toUtf8String(disName);
    fileName = appPath + java.io.File.separator +  "sites" + java.io.File.separator + sitename + java.io.File.separator + "downanwser" + java.io.File.separator + userid + java.io.File.separator + fileName;
    try{
        su.downloadFile(fileName);
    } catch(java.io.FileNotFoundException e) {
        e.printStackTrace();
%>
<script Language="javascript">
    alert('��������δ�ҵ�Ҫ���ص��ļ���');
</script>
<%}
%>
