<%@ page import="com.bizwink.user.User" %>
<%@ page import="com.bizwink.user.IUserManager" %>
<%@ page import="com.bizwink.user.UserPeer" %>
<%@ page contentType="text/html; charset=GBK" %> <script type="text/javascript">var a=s.indexOf()</script>
<%
User ureg = (User) session.getAttribute("user");
 if(ureg!=null){
 out.write("��½�ɹ�-"+ ureg.getUsername()+","+ureg.getUsergrade());
 return ;
 
 }

IUserManager userMgr = UserPeer.getInstance();
User cuser = null;
  if((request.getParameter("name")!=null&&request.getParameter("pass")!=null))
   {
   cuser =userMgr.getLogin(request.getParameter("name"),request.getParameter("pass"));
}
String fflag ="";
 
if(cuser!=null){
	if(cuser.getUserflag()==0){
        out.print("����û�б�����뵽���������м��������û���!");
		return;
    }else{
		if(cuser.getUserstate()==1){
			
            out.print("�Բ���,���Ѿ�������,��ʱ���ܵ�¼���뾡�������Ա��ϵ!");
			return;
        }else{
			User user = new User();
			if(cuser.getUsername().equals(request.getParameter("name"))){
				user = userMgr.getUserinfo("1-"+request.getParameter("name"));
			}else if(cuser.getUseremail().equals(request.getParameter("name"))){
				user = userMgr.getUserinfo("2-"+request.getParameter("name"));
			}
				session.setAttribute("user",user);
				out.write("��½�ɹ�-"+user.getUsername()+","+user.getUsergrade());
               
			
		}
	}
}else{
out.write("�û������������");

    
}
%>