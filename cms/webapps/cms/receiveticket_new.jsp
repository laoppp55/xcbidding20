<%@ page contentType="text/html; charset=GB2312"%>
<%@ page import="java.util.*,java.net.*,cn.org.bjca.uams.rest.spi.BjcaRestSdk"%>
<%@ page import="com.bizwink.cms.security.*" %>
<%
   /* request.setCharacterEncoding("utf-8");
    response.setContentType("text/html");
    //Ʊ��
    String tokenId = request.getParameter("tokenId");
    System.out.println("tokenId="+tokenId);
    //��֤������URL
    String amUrl = request.getParameter("amUrl");
    System.out.println("amUrl="+amUrl);
    //�����
   // String random = request.getParameter("random");
   // System.out.println("random="+random);
    //��ʼ��������֤������URL
    //Map map1 = BjcaRestSdk.getInstance().setServerUrl(amUrl);
    //��ʼ��������֤������URL
    // Map map = BjcaRestSdk.getInstance().setServerUrl(amUrl);
    // Map map = BjcaRestSdk.getInstance().setServerUrl("http://60.24.77.102:9088/am");
    Map map = BjcaRestSdk.getInstance().setServerUrl("http://172.25.7.143:80/am");*/
    request.setCharacterEncoding("utf-8");
    response.setContentType("text/html");
    String tokenId = request.getParameter("tokenId");
	System.out.println(tokenId);
//        String random = request.getParameter("random");
    String amUrl = request.getParameter("amUrl");
	amUrl="http://172.26.49.143/am";
    System.out.println(amUrl);
    Map map = BjcaRestSdk.getInstance().setServerUrl(amUrl);
    //���������
    Map map2 = BjcaRestSdk.getInstance().generateRandom(tokenId);
    System.out.println(map2);

    //��ȡ�����
    String random = (String) map2.get("random");
    //״̬��
    String status = map.get("status").toString();
    System.out.println("status1="+status);

//�жϳ�ʼ��״̬��0--�ɹ� 301--������ URL ����Ϊ�գ� 305--������ URL δ֪���󣬼������� URL
    if("0".equals(status)){
        //�û���������
        //String attributeName = "useridcode";
        //����û�����ֵ
        //Map map2 = BjcaRestSdk.getInstance().getUserAttribute(tokenId, attributeName, random);
        //��ȡ�û����ԣ��û�������Ϣ����չ��Ϣ
        //��ѯ�û���Ϣ
        Map map4 = BjcaRestSdk.getInstance().getAllUserAttributes(tokenId, random);
		System.out.println(map4);

        //״̬��
        status = map4.get("status").toString();
        System.out.println("status="+status);
        if("[0]".equals(status)){
            //��ȡ�û�Ψһ��ʶ
            String userIdCode = ((List<String>) map4.get("useridcode")).get(0);
            System.out.println(userIdCode);
            //String userid=null;
            IUserManager uMgr = UserPeer.getInstance();
            //String userid = uMgr.getUserByIdCode(userIdCode).getUserID();
			String userid=userIdCode;
			//System.out.println("userid="+userid);
            //String userid = (String)map2.get("cn");
          /*  System.out.println("userid="+userid);
            String departId =  (String)map2.get("orgNumber");
            System.out.println("departId="+departId);
            String departName = (String)map2.get("orgName");
            System.out.println("departName="+departName);*/
            //if (departName!=null && userid !=null && departId!=null) {
            if(userid !=null){
                request.getSession().setAttribute("userid",userid);
               // request.getSession().setAttribute("departid",departId);

		/*
		�˴���Ӧ��ϵͳ�����û�Ψһ��ʶuserid�����Լ������ݿ��н��в�ѯ���û��Ƿ������ϵͳ�У�
		����������ô��û���½�ɹ�����֮��������ҳ��

		userid��ͨ�����ɵ�����ͬ�������뵽Ӧ��ϵͳ���ݿ��е�
		*/
                //��ͨ����֤����Ҫ��ת�ĵ�ַд������ı���ticketurl��
                String ticketurl = "";
                IAuthManager authMgr = AuthPeer.getInstance();
                try
                {
                    Auth authToken = authMgr.getSjsAuth(userid, "123456");
                    if (authToken != null) {
                        //���²�������
                     /*   Department dept = new Department();
                        dept.setCname(departName);
                        dept.setEname(departId);

                        uMgr.update_departbyUK(dept);
                        uMgr.update_membersDepart(departId,userid);*/

                        int siteid = authToken.getSiteID();
                        session.setAttribute("CmsAdmin", authToken);
                        session.setMaxInactiveInterval(60*60*1000);
                        int modelnum = authMgr.getTemplateNum(siteid);
                        String username ="null"; //departName;
                        if (modelnum == 0 && !username.equals("admin"))  {                    //ת��ģ��ѡ��ҳ��
%>
<script type="text/javascript">
    var ret = confirm("ѡ���Ѿ����ڵ�ģ�壿");
    if (ret)
        window.location="register/webindex.jsp";
    else
    <%response.sendRedirect("index1.jsp");%>// window.location="index1.jsp";
</script>
<%
                            //response.sendRedirect("register/webindex.jsp");
                        } else                                                                  //ת���¼�ɹ�ҳ��
                            ticketurl = "index1.jsp";
                    } else {
                        ticketurl = "sso_errors.jsp";
                    }
                }
                catch (Exception e)
                {
                    ticketurl = "sso_errors.jsp";
                }
                //response.sendRedirect(ticketurl);
                request.getRequestDispatcher(ticketurl).forward(request,response);//ת��ҵ��ϵͳ
            }else{
                response.sendRedirect("sso_errors.jsp");//��������ʱ�Ĵ���ҳ�棬�����޸Ĵ���ҳ��
            }


        }else{
            //101--�������ʧЧ! 301--δ֪���� 102--��֤ Token ʧ�ܣ� 103--��ȡ�û���Ϣʧ�ܣ�
            //304--ϵͳ�ڲ����� 306--����������� 307--�������Ӵ��� 308--�û���֤ʧ�ܣ�
            //309--�û�״̬�쳣�� 310--�����ַ������
            response.sendRedirect("sso_errors.jsp");
        }
    }else{
        response.sendRedirect("sso_errors.jsp");
    }
%>