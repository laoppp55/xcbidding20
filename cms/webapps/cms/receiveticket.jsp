<%@ page contentType="text/html; charset=GB2312"%>
<%@ page import="com.bjca.sso.processor.*,com.bjca.sso.bean.*"%>
<%@ page import="com.bizwink.cms.security.*" %>
<%
	//������֤��
	String BJCA_SERVER_CERT = request.getParameter("BJCA_SERVER_CERT");
	//Ʊ��
	String BJCA_TICKET = request.getParameter("BJCA_TICKET");
    System.out.println("BJCA_TICKET=" + BJCA_TICKET);

    //��ȡdepartName
    int posi = BJCA_TICKET.indexOf("<departName>");
    String username = BJCA_TICKET.substring(posi + "<departName>".length());
    posi = username.indexOf("</departName>");
    username = username.substring(0,posi);
    System.out.println("cname="+username);

    //��ȡuserid
    posi = BJCA_TICKET.indexOf("<UserID>");
    String userid = BJCA_TICKET.substring(posi + "<UserID>".length());
    posi = userid.indexOf("</UserID>");
    userid = userid.substring(0,posi);

    //��ȡ����ID
    posi = BJCA_TICKET.indexOf("<DepartCode>");
    String departid = BJCA_TICKET.substring(posi + "<DepartCode>".length());
    posi = departid.indexOf("</DepartCode>");
    departid = departid.substring(0,posi);
    System.out.println("ename="+departid);

	//Ʊ������
	String BJCA_TICKET_TYPE = request.getParameter("BJCA_TICKET_TYPE");
	
	//out.println("Ʊ�ݣ�"+BJCA_TICKET);
	
	TicketManager ticketmag = new TicketManager();
	//��֤ǩ���ͽ���
	UserTicket userticket = ticketmag.getTicket(BJCA_TICKET, BJCA_TICKET_TYPE, BJCA_SERVER_CERT);
	//����Ʊ����Ϣ

	if (username!=null && userid !=null && departid!=null) {
	//if(userticket != null) {
		//ȡ�쵼����
		//String username = userticket.getUserName();
		//ȡ�û�Ψһ��ʶ
		//String userid = userticket.getUserUniqueID();
		
		//ȡ����Ψһ��ʶ
		//String departid = userticket.getUserDepartCode();

		/**ȡ��ɫ��Ϣ
		Hashtable roles = userticket.getUserRoles();
		String s_role = "";
		if(roles != null && roles.size() > 0) {
			int index = 1;
			Enumeration e = roles.keys();
			Enumeration e2 = roles.elements();
			for(;e.hasMoreElements();){
				String rolecode = (String)e.nextElement();
				String rolename = (String)e2.nextElement();
				if(rolename.indexOf("?") != -1) {
					rolename = new String(rolename.getBytes("GBK"),"ISO-8859-1");
				}
				if(index == 1){
					s_role = rolecode;
				}else{
					s_role = s_role + "," + rolecode;
				}
				index++;
			}
		}
		*/
		
		//request.getSession().setAttribute("roles",s_role);
		request.getSession().setAttribute("userid",userid);
		request.getSession().setAttribute("departid",departid);

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
                Department dept = new Department();
                dept.setCname(username);
                dept.setEname(departid);
                IUserManager uMgr = UserPeer.getInstance();
                uMgr.update_departbyUK(dept);
                uMgr.update_membersDepart(departid,userid);

                int siteid = authToken.getSiteID();
                session.setAttribute("CmsAdmin", authToken);
                session.setMaxInactiveInterval(60*60*1000);
                int modelnum = authMgr.getTemplateNum(siteid);
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
%>