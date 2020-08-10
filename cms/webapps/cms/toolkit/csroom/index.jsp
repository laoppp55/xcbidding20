<%@page contentType="text/html;charset=GBK" %>
<%@page import="
                java.util.*,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.SessionUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.toolkit.csinfo.CsInfo" %>
<%@ page import="com.bizwink.cms.toolkit.csinfo.ICsInfoManager" %>
<%@ page import="com.bizwink.cms.toolkit.csinfo.CsInfoPeer" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteID = authToken.getSiteID();
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    if(startrow<0){
        startrow = 0;
    }

    ICsInfoManager csInfoMgr = CsInfoPeer.getInstance();
    List list = new ArrayList();
    List currentlist = new ArrayList();

    list = csInfoMgr.getcsroomList(siteID);
    currentlist = csInfoMgr.getCurrentcsroomList(siteID, startrow, range);

    int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

    row = currentlist.size();
    rows = list.size();

    if(rows < range){
        totalpages = 1;
        currentpage = 1;
    }else{
        if(rows%range == 0)
            totalpages = rows/range;
        else
            totalpages = rows/range + 1;

        currentpage = startrow/range + 1;
    }
%>
<HTML><HEAD><TITLE>������Ϣ����</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="images/common.css" type=text/css rel=stylesheet>
    <LINK href="images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function Del(id)
        {
            var bln = confirm("���Ҫɾ����");
            if (bln)
            {
                window.location = "delete.jsp?id="+id;
            }
        }

        function searchcheck(){
            if((form1.searchstr.value ==null)||(form1.searchstr.value == "")){
                alert("������Ҫ��ѯ�����ݣ�");
                return false;
            }
            form1.submit();
            return true;
        }
    </SCRIPT>
</HEAD>
<BODY>
<P align=right><FONT color=#0000ff><A
        href="addcsinfo.jsp">��ӷ�����Ϣ</A></FONT> <BR>
<FORM name=form1 action=search.jsp method=post>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR height=35>
            <TD align=middle width="5%">���</TD>
            <TD align=middle width="8%">��������</TD>
            <TD align=middle width="25%">������</TD>
            <TD align=middle width="10%">��������</TD>
            <TD align=middle width="9%">����۸�</TD>
            <TD align=middle width="10%">���</TD>
            <TD align=middle width="5%">���</TD>
            <TD align=middle width="5%">�޸�</TD>
            <TD align=middle width="5%">ɾ��</TD></TR>
        <%
            int id = 0;
            String ROOM_NAME = "";
            String CATLOG_CODE = "";
            int ROOM_TYPE ;
            Float price;
            int ROOM_SIZE;
            for(int i=0;i<row;i++){
                CsInfo csinfo = (CsInfo)currentlist.get(i);
                id = csinfo.getId();
                ROOM_NAME = csinfo.getROOM_NAME();
                CATLOG_CODE = csinfo.getCATLOG_CODE();
                ROOM_TYPE = csinfo.getROOM_TYPE();
                price = csinfo.getINIT_PRICE();
                ROOM_SIZE = csinfo.getROOM_SIZE();
        %>
        <TR height=35>
            <TD align=middle width="5%"><%=(currentpage-1)*range+i+1%></TD>
            <TD align=middle width="8%"><%=ROOM_NAME==null?"--":ROOM_NAME%> </TD>
            <TD align=middle width="25%"><%=CATLOG_CODE==null?"--":CATLOG_CODE%> </TD>
            <TD align=middle width="10%"><%=ROOM_TYPE%> </TD>
            <TD align=middle width="9%"><%=price%> </TD>
            <TD align=middle width="10%"><%=ROOM_SIZE%> </TD>
            <TD align=middle width="5%"><A
                    href="view.jsp?id=<%=id%>"><IMG
                    src="images/preview.gif" border=0></A></TD>
            <TD align=middle width="5%"><A
                    href="edit.jsp?id=<%=id%>"><IMG
                    src="images/dx.gif" border=0></A></TD>
            <TD align=middle width="5%">
                <A href="#" onclick="javascript:return Del(<%=id%>);">
                    <IMG src="images/del.gif" border=0></A></TD></TR>
        <%}%>
        </TBODY></TABLE>
<BR>
<p align=center>
<TABLE>
    <TBODY>
    <TR>
        <TD>�ܹ�<%=totalpages%>ҳ&nbsp;&nbsp; ��<%=rows%>��&nbsp;&nbsp; ��ǰ��<%=currentpage%>ҳ&nbsp;
            <%
                if(startrow>0){
            %>
            <a href="list.jsp?startrow=0">��һҳ</a>
            <%}%>
            <%if((startrow-range)>=0){%>
            <a href="list.jsp?startrow=<%=startrow-range%>">��һҳ</a>
            <%}%>
            <%if((startrow+range)<list.size()){%>
            <A href="list.jsp?startrow=<%=startrow+range%>">��һҳ</A>
            <%}%>
            <%if(currentpage != totalpages){%>
            <A href="list.jsp?startrow=<%=(totalpages-1)*range%>">���һҳ</A>
            <%}%>
        </TD>
        <TD>&nbsp;</TD>
    </TR></TBODY></TABLE>
</FORM></p><BR><BR>
<p align=right>
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
       borderColorLight=#008000 border=1>
    <TBODY>
    <TR height=35>
        <TD>&nbsp;&nbsp;������<select name="seltype">
            <option value="1">�û���</option>
            <option value="2">������λ</option>
        </select>
            <input type="text" size=40 name="searchstr">&nbsp;&nbsp;<input type="button" value=" �� ѯ " onclick="javascript:return searchcheck();"></TD>
    </tr>
    </tbody>
</table>
</p>
</BODY></HTML>
