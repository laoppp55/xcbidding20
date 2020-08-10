<%@ page import="java.sql.*,
    com.bizwink.cms.news.*,
    com.bizwink.cms.security.*,
	com.bizwink.cms.util.* " contentType="text/html;charset=gbk"%>
<%
    // error variables for parameters
    Auth authToken = SessionUtil.getUserAuthorization( request,  response, session);
    if( authToken == null ) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

	boolean errorCName                 = false;
	boolean errorEName                 = false;
        boolean errorColumnAlreadyExists   = false;
	boolean errors                     = false;
	boolean success                    = false;

	boolean doUpdate    = ParamUtil.getBooleanParameter(request,"doUpdate");
        int siteid = authToken.getSiteID();
	int     ID          = ParamUtil.getIntParameter(request, "ID", 0);
        int     parentID    = ParamUtil.getIntParameter(request, "parentID", 0);
	String  CName       = ParamUtil.getParameter(request, "CName");
        String  EName       = ParamUtil.getParameter(request, "EName");
        String  oldEName    = ParamUtil.getParameter(request, "oldEnName");
        String  extfilename = ParamUtil.getParameter(request, "extfilename");
        int     activeID    = ParamUtil.getIntParameter(request, "activeID", 1);
        int     orderid     = ParamUtil.getIntParameter(request, "orderid", 1);
        boolean daulName    = false;
        String  msg         = "";


	if( doUpdate ) {
	    if( CName == null ) {
		    errorCName = true;
	    }
        if( EName == null ) {
		    errorEName = true;
	    }
	    errors = errorCName || errorEName;
	}

	IColumnManager columnManager = null;
	columnManager = ColumnPeer.getInstance();
        Column column = columnManager.getColumn(ID);

	if( !errors && doUpdate ) {
            //����޸���Ӣ��·�����ƣ��ж���ͬ��Ŀ¼���Ƿ����ظ���Ӣ��Ŀ¼����
            if (EName.compareTo(oldEName) != 0) {
                daulName = columnManager.duplicateEnName(column.getParentID(),EName);
            }
            if (!daulName) {
	        try {
	            column.setID( ID );
                    column.setSiteID(siteid);
                    column.setParentID(parentID);
	            column.setCName( CName );
                    column.setEName( EName );
                    column.setExtname(extfilename);
                    column.setActiveID( activeID );
                    column.setLastUpdated(new Timestamp(System.currentTimeMillis()));
                    String editor = authToken.getUserID();
                    column.setOrderID(orderid);
                    column.setEditor( editor );
                    columnManager.update(column);
                    msg = "�޸���Ŀ�ɹ�";
                    success = true;
                }
	        catch( ColumnException uaee ) {
                    msg = "��Ŀ�����޸ĳ��ִ���";
                    errors = true;
	        }
            } else {
                    msg = "��ͬ����Ŀ�����ظ���Ӣ��·��������ѡ�����������";
                    errors = true;
            }
	}

        parentID=column.getParentID();
	CName = StringUtil.gb2iso4View(column.getCName());
	EName = column.getEName();
        extfilename = column.getExtname();
        if (extfilename == null) extfilename = "";
	activeID = column.getActiveID();
        orderid = column.getOrderID();


	// if a column was successfully created, say so and return (to stop the
	// jsp from executing
	if( success ) {
	    response.sendRedirect(
		    response.encodeRedirectURL("index.jsp?msg=" + msg)
	    );
	    return;
	}

	String parentName = "��վ��ҳ";
	if (parentID > 0) {
	    columnManager = ColumnPeer.getInstance();
	    Column parentColumn = columnManager.getColumn(parentID);
	    if (parentColumn != null) {
		parentName = StringUtil.gb2iso4View(parentColumn.getCName());
	    }
	}
%>
<html>
<head>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../style/global.css">
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<%	////////////////////
	String[][] titlebars = {
	        { "��Ŀ����", "index.jsp" },
	        { "�޸���Ŀ", "" }
	};
	String[][] operations = null;
%>
<%@ include file="../inc/titlebar.jsp" %>
<%	// print error messages
	if( errors ) {
%>
<p class=cur>
	<%	if( !success ) { %>
		��Ŀ "<%= EName %>" �Ѿ����ڡ�����һ����ĿĿ¼����
	<%	} else { %>
		������ϢΪ��"<%=msg%>"
	<%	} %>
<%	} %>
<center>
<form action=editcolumn.jsp method=post name=updateForm>
<input type=hidden name=oldEnName value="<%=EName%>">
<input type=hidden name=doUpdate value=true>
<input type=hidden name=ID value="<%=ID%>">
<input type=hidden name=parentID value="<%=parentID%>">
<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width=100%>
<tr><td align=left class=line colspan=2>��Ŀ��Ϣ</td></tr>
<tr><td align=right class=line>����Ŀ����</td>
<td class=tine><%= parentName %></td></tr>
<tr><td align=right><font class=line <%= (errorCName)?(" color=\"#ff0000\""):"" %>>��Ŀ���ƣ�</font></td>
<td><input class=tine name=CName size=30 value="<%= (CName!=null)?CName:"" %>">*</td></tr>
<tr><td align=right><font class=line <%= (errorEName)?(" color=\"#ff0000\""):"" %>>��ĿĿ¼��</font></td>
<td><input class=tine name=EName size=30 value="<%= (EName!=null)?EName:"" %>">*</td>
</tr>
<tr><td align=right class=line>��Ŀ����</td>
<td><input class=tine name=orderid size=30 value="<%= orderid %>">*
</td></tr>
<tr>
<td class=line align=right>
ҳ���ļ���չ����
</td>
<td class=tine>
<select name=extfilename size=1 class=tine>
     <option value="html" <%= (extfilename.compareTo("html")==0)?"selected":"" %>>html</option>
     <option value="htm" <%= (extfilename.compareTo("htm")==0)?"selected":"" %>>htm</option>
     <option value="jsp" <%= (extfilename.compareTo("jsp")==0)?"selected":"" %>>jsp</option>
     <option value="asp" <%= (extfilename.compareTo("asp")==0)?"selected":"" %>>asp</option>
     <option value="shtm" <%= (extfilename.compareTo("shtm")==0)?"selected":"" %>>shtm</option>
     <option value="shtml" <%= (extfilename.compareTo("shtml")==0)?"selected":"" %>>shtml</option>
     <option value="php" <%= (extfilename.compareTo("php")==0)?"selected":"" %>>php</option>
</select>
</td>
</tr>
<tr><td class=line align=right>�Ƿ���Ч��</td>
<td class=tine>
<input type=radio <%= (activeID==1)? "checked":""  %> name="activeID"  value="1">��
<input type=radio <%= (activeID==0)? "checked":"" %> name="activeID" value="0">��
</td></tr></table>
<br><input type=image src=../images/button_modi.gif onclick="document.all.updateForm.submit()">
&nbsp;<input type=image src=../images/button_cancel.gif onclick="location.href='index.jsp?right=ColumnManage';return false;">
</form>
</center>
</BODY></html>