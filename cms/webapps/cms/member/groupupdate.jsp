<%@ page import="java.util.*,
		 java.net.URLEncoder,
                 com.bizwink.cms.security.*,
                 org.apache.regexp.*,
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
    if (!SecurityCheck.hasPermission(authToken, "member"))
    {
        response.sendRedirect("../error.jsp?message=�޹����û����Ȩ��");
        return;
    }

    boolean error = false;
    boolean doCreate = false;
    String options1 = "";
    String options2 = "";

    int columnid    = ParamUtil.getIntParameter(request,"columnid",0);
    String groupid  = ParamUtil.getParameter(request,"groupid");

    if (columnid != 0 && groupid != null)
    {
       	IGroupManager groupMgr = GroupPeer.getInstance();
    	List groupList;
	int groupCount = 0;
	String Col_ID = "";

	//�õ���ѡȨ��
	groupList  = groupMgr.getGroupsRight_New(groupid,columnid);
	groupCount = groupList.size();

	for (int i=0; i<groupCount; i++)
	{
	    Group groupColumn = (Group)groupList.get(i);
	    Col_ID = groupColumn.getRightID();
    	    String RetVal = groupMgr.getRightID(Col_ID);
	    options1 = options1 + "<option value=" + Col_ID + ">&nbsp;" + RetVal + "</option>";
     	}

	//�õ���ѡȨ��
	groupList = groupMgr.getGroupsRight_Remain(groupid,columnid);
	groupCount = groupList.size();

	for (int j=0; j<groupCount; j++)
	{
	    Group groupColumn = (Group)groupList.get(j);
	    Col_ID = groupColumn.getRightID();
    	    String RetVal = groupMgr.getRightID(Col_ID);
	    options2 = options2 + "<option value=" + Col_ID + ">&nbsp;" + RetVal + "</option>";
     	}
    }
%>

<html>
<head>
<title>�û�����Ȩ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script LANGUAGE="JavaScript" SRC="../js/check.js">
</script>

<SCRIPT LANGUAGE=javascript>
function submit_end() {
  <% if( !error && doCreate ) {%>
    parent.window.opener.location.href="index.jsp?msg=�û�����Ȩ�ɹ�";
    parent.window.close();
  <%}%>
}

function selectList(srcList,desList)
{
	seleflg = false;
	for(var i = srcList.length - 1; i >= 0; i--)
	{
		if(srcList.options[i].selected == true)
		{
			var oOption = document.createElement("OPTION");
			oOption.value = srcList.options[i].value;
			oOption.text = srcList.options[i].text;

			desList.add(oOption);
			srcList.options[i] = null;
			seleflag = true;
		}
		else
		{
			continue;
		}
	}

	if( !seleflag )
	{
		alert ("��û��ѡ��Ȩ�ޣ���ѡ��");
		return false;
	}
}

function closeWnd()
{
	parent.window.close();
}

var rights_sel = ""

function checkFrm(frm)
{
    var right = "";
    for(var j = 0; j<frm.rightList.length; j++)
    {
        right = right + ":" + frm.rightList.options[j].value;
    }
    rights_sel = "|" + "<%=columnid%>" + right;

    //for( i = 0; i<frm.rightList.length; i++)
    //{
    //	rights_sel = rights_sel + "|" + frm.rightList.options[i].value;
    //}
    //frm.rightids.value = rights_sel;
    //if( frm.groupid.value == "null" || frm.groupid.value == "" ||  frm.groupid.value == null ){
    //    alert("�����һҳ�棬�����û����ʶ��!");
    //    return false;
    //}

    if( frm.rightList.length == 0 )
    {
        alert("��ûѡ�κ�Ȩ�ޣ������ߵı�ѡ�б���ѡ��Ȩ�ޣ�");
        return false;
    }
    else
    {
    	opener.newuser.rightids.value = opener.newuser.rightids.value + rights_sel;
    	window.close();
	return true;
    }
}

</SCRIPT>
</head>

<body bgcolor="#FFFFFF">
<form name="form1" method="post" action="">
  <table width="46%" height="388" border="0">
    <tr hight="95%">
      <td width="90%" valign="top"> <table width="55%" border="1" bgcolor="#CCCCCC" height="308">
          <tr>
            <td width="44%" height="264" align="right" valign="top"  hight="5%">
              <div align="center"><font size="2">��ѡȨ��:<br>
                </font>
                <br>
                <select name="leftList" size="20" multiple  style="width: 135; height: 240"><%=options2%></select>
              </div></td>
            <td colspan="2" valign="middle" height="264"> <input type="button" name="add" value="����" onclick="return selectList(this.form.leftList,this.form.rightList)">
              <br> <br> <input type="button" name="delete" value="����" onclick="return selectList(this.form.rightList,this.form.leftList)"></td>
            <td width="45%" valign="top" height="264"><div align="center"><font size="2">����Ȩ��:<br>
                </font>
                <br>
                <select name="rightList" size="20" multiple  style="width: 135; height: 241"><%=options1%></select>
              </div></td>
          </tr>
          <tr >
            <td height="32" colspan="4" hight="24">
              <div align="center">
                <input type="button" name="SubBtn" value="ȷ��" onclick="javascript:return checkFrm(this.form)">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" name="CancelBtn" value="ȡ��" onclick="javascript:window.close()">
              </div></td>
          </tr>
        </table></td>
    </tr>
  </table>

</form>

</body>
</html>
