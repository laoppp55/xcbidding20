<%@page import="java.io.*,
                java.util.*,
                java.sql.*,
                java.text.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.server.*,
                com.bizwink.bbs.bbs.*,
				com.bizwink.webapps.register.*" contentType="text/html;charset=gbk"
%>
<%
  String username       = ParamUtil.getParameter(request, "username");
  String password       = ParamUtil.getParameter(request, "password");
	int startflag         = ParamUtil.getIntParameter(request, "startflag", 0);

	IUregisterManager registerMgr = UregisterPeer.getInstance();
	Uregister register = new Uregister();
	IBBSManager bbsMgr = BBSPeer.getInstance();
  int loginflag = 0;
  if(startflag == 1) {
    boolean existflag = false;

    Uregister ureg = registerMgr.login(username,password,0);
    if(ureg.getMemberid()!= null){
	    register = registerMgr.getAUser(username);
	    int id = register.getID();

      //�û��ĵ�¼�ɹ�����
      int loginnum = registerMgr.getUserLoginNum(username) + 1;
      registerMgr.updateUserLoginNum(id, loginnum);

      //�û��������������û����ߵ�¼ʱ��
      Timestamp nowtime = new Timestamp(System.currentTimeMillis());
      String ipaddress = request.getRemoteAddr();
			BBS bbs = new BBS();
      bbs.setUserName(username);
      bbs.setLoginTime(nowtime);
      bbs.setIPAddress(ipaddress);

      //ɾ�����û������߱��еļ�¼
      bbsMgr.deleteOnline(bbs);

      //�û���¼�ɹ������µ��û���¼ʱ������û����߱�
      bbsMgr.insertOnline(bbs);

			register = registerMgr.getAUser(username);
			String grade = register.getGrade();
      session.setAttribute("userid",username);
      session.setAttribute("password",password);
			session.setAttribute("UserClass",grade);
      loginflag = 1;
		}
	}
	response.sendRedirect("/bbs/index.jsp?loginflag="+loginflag);
%></html>    