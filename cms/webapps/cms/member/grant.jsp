<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
                 contentType="text/html;charset=gbk"
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if( authToken == null )
    {
        response.sendRedirect( "../login.jsp?url=member/createMember.jsp" );
	return;
    }
    if (!SecurityCheck.hasPermission(authToken, 54))
    {
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
        return;
    }

    com.bizwink.cms.security.IRightsManager rightsManager = RightsPeer.getInstance();
    boolean error = false;
    boolean doGrant = ParamUtil.getBooleanParameter(request,"doGrant");
    String userid = ParamUtil.getParameter(request,"userid");    //����Ȩ�˵�userid�����ǵ�¼�ߵ�userid
    String colCname = ParamUtil.getParameter(request,"colChname");
    int columnid = ParamUtil.getIntParameter(request,"column",-1);
    int errcode = 0;
    int siteid = authToken.getSiteID();

    if (doGrant == true && !error && userid != null && columnid != -1) {

      List rlist = ParamUtil.getParameterValues(request,"rightList");
      if (columnid != 0)
        errcode = rightsManager.grantToColumns(userid,columnid,rlist);          //��ĳ����Ŀ������Ȩ
      else
        errcode = rightsManager.grantToUser(userid,rlist);                      //��ĳ���û�������Ȩ
    }

    //get the rights definations from tbl_rights;
    List rightsList = new ArrayList();
    if (columnid != 0 && columnid != -1)
      rightsList = rightsManager.getCrRights();                                 //��ȡ��������Ŀ��ص�Ȩ��
    else
      rightsList = rightsManager.getUrRights();                                 //��ȡ���û���ص�����Ȩ��

    List grantedRights = new ArrayList();
    if (userid != null && columnid != -1) {
      if(columnid != 0 )
        grantedRights = rightsManager.getUserColumnRight(userid,columnid);      //�������Ŀ��Ȩ����ȡ�Ѿ��ڸ�����Ŀ��Ȩ��
      else
        grantedRights = rightsManager.getGrantedUserRights(userid,siteid);      //������û���Ȩ����ȡ�Ѿ��ڸ����û���Ȩ��
    }

    int rightid = 0;
    String rightname = null;
    int i = 0;
%>

<html>
<head>
<title>�û���Ȩ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script LANGUAGE="JavaScript" SRC="../js/check.js">
</script>

<SCRIPT LANGUAGE=javascript>
var rights_sel = "";

function selectList(srcList,desList)
{
	seleflg = false;

	for(i = srcList.length - 1; i >= 0; i--)
	{

		if(srcList.options[i].selected == true){

			var oOption = document.createElement("OPTION");
			oOption.value = srcList.options[i].value;
			oOption.text = srcList.options[i].text;
			desList.add(oOption);
			srcList.options[i] = null;
			seleflag = true;
		}else{
			continue;
		}
	}

	if( !seleflag ){
		alert ("��û��ѡ��Ȩ�ޣ���ѡ��");
		return false;
	}
}


function checkFrm(frm)
{
    if( frm.rightList.length == 0 )
    {
        alert("��ûѡ�κ�Ȩ�ޣ������ߵı�ѡ�б���ѡ��Ȩ�ޣ�");
        return false;
    } else {
      var el = form1.rightList;

      for(var i = el.options.length-1; i >=0; i--) {
        el.options[i].selected = true;
      }
    }
}

</SCRIPT>
</head>

<body bgcolor="#FFFFFF">
<form name="form1" method="post" action="grant.jsp">
  <%
     if ((userid !=null) && (colCname != null)) {
         out.print("<p>�����û�" + userid + "��" + colCname + "��Ŀ��Ȩ�����£�</p>");
         out.print("<input type=hidden name=userid value=" + userid + ">");
         out.print("<input type=hidden name=column value=" + columnid + ">");
     } else if(userid != null && columnid==0){
         out.print("<p>�����û�" + userid +" ��Ȩ�����£�</p>");
         out.print("<input type=hidden name=userid value=" + userid + ">");
         out.print("<input type=hidden name=column value=" + columnid + ">");
     } else {
         out.print("<p>��ѡ����Ҫ��Ȩ����Ŀ���û���</p>");
     }
  %>
  <input type=hidden name=doGrant value=true>
  <table width="46%" height="370" border="0">
    <tr hight="95%">
      <td width="90%" valign="top" height="366">
        <div align="center">
          <center>
            <table width="55%" border="1" bgcolor="#CCCCCC" height="389">
              <tr>
            <td width="44%" height="225" align="right" valign="top"  hight="5%">
              <div align="center">��ѡȨ��:<br>
                <br>
                <select name="leftList" size="20" multiple  style="width: 135; height: 251">
                  <%
                  for(i = 0; i < rightsList.size(); i++)
                  {
                      rightid = ((Rights)(rightsList.get(i))).getRightID();
                      rightname =  StringUtil.gb2iso4View(((Rights)(rightsList.get(i))).getRightCName());
                  %>
                  <option value="<%=rightid%>">&nbsp;<%=rightname%></option>
                  <%}%>
                </select>
              </div></td>
            <td colspan="2" valign="middle" height="225"> <input type="button" name="add" value="����" onclick="return selectList(this.form.leftList,this.form.rightList)">
              <br> <br> <input type="button" name="delete" value="����" onclick="return selectList(this.form.rightList,this.form.leftList)"></td>
            <td width="45%" valign="top" height="225">
              <div align="center">����Ȩ��:<br>
                <br>
                <select name="rightList" size="20" multiple  style="width: 135; height: 251">
                  <%
                  for(i = 0; i < grantedRights.size(); i++)
                  {
                      rightid = ((Rights)(grantedRights.get(i))).getRightID();
                      rightname =  StringUtil.gb2iso4View(((Rights)(grantedRights.get(i))).getRightCName());
                  %>
                  <option value="<%=rightid%>">&nbsp;<%=rightname%></option>
                  <%}%>
                </select>
              </div></td>
          </tr>
          <tr >
                <td height="66" colspan="4" hight="24">
                  <div align="center">
                <input type="submit" name="SubBtn" value="��Ȩ" onclick="javascript:return checkFrm(this.form)">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" name="CancelBtn" value="����" onclick="javascript:parent.window.close()">
              </div></td>
          </tr>
        </table></center>
        </div>
      </td>
    </tr>
  </table>

</form>

</body>
</html>
