<%@page contentType="text/html;charset=gbk"%>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%
    String memberid = ParamUtil.getParameter(request,"memberid");
    String pass0 = ParamUtil.getParameter(request,"pass0");
    String pass1 = ParamUtil.getParameter(request,"pass1");
    String UserName = ParamUtil.getParameter(request,"Rname");
    String lianxi = ParamUtil.getParameter(request,"lianxi");
    String con = ParamUtil.getParameter(request,"con");
    String city = ParamUtil.getParameter(request,"city");
    String post = ParamUtil.getParameter(request,"post");
    String phone = ParamUtil.getParameter(request,"phone");
    String yphone = ParamUtil.getParameter(request,"yphone");
    String chuanzhen = ParamUtil.getParameter(request,"chuanzhen");
    String birth = ParamUtil.getParameter(request,"birth");
    int doupdate = ParamUtil.getIntParameter(request,"doUpdate",0);

    Uregister ure = new Uregister();
    String sitename = request.getServerName();
    IUregisterManager regMgr = UregisterPeer.getInstance();
    int Siteid = regMgr.getSiteid(sitename);
    ure = regMgr.getUserInfo(memberid,Siteid);

    if (doupdate == 1) {
        ure.setMemberid(memberid);
        ure.setPassword(pass1);
        ure.setName(UserName);
        ure.setLinkman(lianxi);
        ure.setCountru(con);
        ure.setCity(city);
        ure.setPostalcode(post);
        ure.setPhoen(phone);
        ure.setMobilephone(yphone);
        ure.setFax(chuanzhen);
        ure.setBirthday(birth);

        int code = regMgr.Update_userinfo(ure,Siteid);
        if(code ==0){
            response.sendRedirect("su.jsp");
        }else{
            out.println("<script  lanugage=\"javascript\">alert(\"�޸�ʧ�ܣ��������޸ģ�\");window.location=\"make.jsp\";</script>");
        }
    }
%>
<html>
<head>
    <title></title>
    <script type="text/JavaScript">
        function update_do(){
            var pass0 = document.all.pass0.value;
            var pass1 = document.all.pass1.value;
            var pass2 = document.all.pass1.value;
            if(pass0==""){
                alert("������ԭ���룡");
                return false;
            }else{
                var objXmlc;
                var ref = window.location.href;
                if (window.ActiveXObject){
                    objXmlc = new ActiveXObject("Microsoft.XMLHTTP");
                }
                else if (window.XMLHttpRequest){
                    objXmlc = new XMLHttpRequest();
                }
                objXmlc.open("POST", "checkpassword.jsp?uid=<%= memberid%>&pass="+pass0 + "&siteid=<%=Siteid%>", false);
                objXmlc.send(null);
                var res = objXmlc.responseText;
                alert(res);
                var re = res.split('-');
                var retstrs = re[0];
                alert(retstrs);
                if(retstrs==1){
                    document.getElementById("tishi").innerHTML = "������д��ȷ��";
                }if(retstrs==0){
                document.getElementById("tishi").innerHTML = "������д����";
                return false;
            }
            }
            if(pass1==""){
                alert("�����������룡");
                return false;
            }
            if(pass1!=pass2){
                alert("��������������벻һ�£�");
                return false;
            }
            document.all.form1.action = "updatereg.jsp";
            document.all.form1.submit();
        }
    </script>
</head>

<body>
<form name="form1" id="form1" method="POST">
    <input type="hidden" name="memberid" value="<%= memberid%>">
    <input type="hidden" name="doUpdate" value="1">
    <table width="600" border="1" align="center">
        <tr>
            <td width="90">�û�����</td>
            <td width="164"><%= memberid%></td>
            <td></td>
        </tr>
        <tr>
            <td>��ʵ����</td>
            <td><input type="text" id="Rname" name="Rname" value="<%=ure.getName()!=null?ure.getName():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>������</td>
            <td><input type="password" id="pass0" name="pass0"></td>
            <td>
                <div id="tishi"></div>
            </td>
        </tr>
        <tr>
            <td>������</td>
            <td><input type="password" id="pass" name="pass"></td>
            <td></td>
        </tr>
        <tr>
            <td>ȷ��������</td>
            <td><input type="password" id="pass1" name="pass1"></td>
            <td></td>
        </tr>
        <tr>
            <td>��ϵ��</td>
            <td><input type="text" id="lianxi" name="lianxi" value="<%=ure.getLinkman()!=null?ure.getLinkman():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>����</td>
            <td><input type="text" id="con" name="con" value="<%=ure.getCountru()!=null?ure.getCountru():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>���ڳ���</td>
            <td><input type="text" id="city" name="city" value="<%=ure.getCity()!=null?ure.getCity():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>�ʱ�</td>
            <td><input type="text" id="post" name="post" value="<%=ure.getPostalcode()!=null?ure.getPostalcode():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>�绰����</td>
            <td><input type="text" id="phone" name="phone" value="<%=ure.getPhoen()!=null?ure.getPhoen():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>�ƶ��绰</td>
            <td><input type="yphone" name="yphone" value="<%=ure.getMobilephone()!=null?ure.getMobilephone():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>����</td>
            <td><input type="text" id="chuanzhen" name="chuanzhen" value="<%=ure.getFax()!=null?ure.getFax():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td>��������</td>
            <td><input type="text" id="birth" name="birth" value="<%=ure.getBirthday()!=null?ure.getBirthday():""%>"></td>
            <td></td>
        </tr>
        <tr>
            <td><input type="button" value="�ύ" onclick="javascript:update_do()"></td>
            <td>&nbsp;</td>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td></td>
        </tr>
    </table>
</form>
</body>
</html>
