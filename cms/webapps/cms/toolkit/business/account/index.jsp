<%@page import="java.io.*,
                java.util.*,
                java.sql.*,
                java.text.*,
                com.bizwink.cms.news.*,
                com.bizwink.cms.server.*,
                com.bizwink.cms.tree.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.business.Other.*,
                com.bizwink.cms.business.Order.*,
                com.bizwink.cms.server.FileProps"
        contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int startrow            = ParamUtil.getIntParameter(request, "startrow", 0);
    int range               = ParamUtil.getIntParameter(request, "range", 100);
    int startflag           = ParamUtil.getIntParameter(request,"startflag",0);
    int flag                = ParamUtil.getIntParameter(request,"flag",2);
    int kind                = ParamUtil.getIntParameter(request,"kind",-1);
    String what             = ParamUtil.getParameter(request,"what");
    if(what==null) what = "";
    String username = "";
    String jumpstr = "";

    IOtherManager otherMgr = otherPeer.getInstance();
    Other other = new Other();

    List list = new ArrayList();
    List currentlist = new ArrayList();
    list = otherMgr.getAccountList(what,kind,flag,startrow,0);
    currentlist = otherMgr.getAccountList(what,kind,flag,startrow,range);

    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;
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

    DecimalFormat df = new DecimalFormat();
    df.applyPattern("0.00");
%>
<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <meta http-equiv="Pragma" content="no-cache">
    <script language="javascript">
        function golist(r){
            usersform.action = "index.jsp?startrow="+r;
            usersform.submit();
        }

        function jumppage(r,str){
            usersform.action = "index.jsp?startrow="+r+str;
            usersform.submit();
        }
    </script>
</head>
<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
    <%
        String[][] titlebars = {
                { "��ҳ", "" },
                { "�������", "" }
        };

        String[][] operations = {};
    %>
    <%@ include file="../inc/titlebar.jsp" %>

    <form action="index.jsp" method="post" name="usersform">
        <input type="hidden" name="startflag" value="1">
        <input type="hidden" name="flag" value="<%=flag%>">
        <center>
            <table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
                <tr>
                    <td>
                        <table width="100%" border="0" cellpadding="2" cellspacing="1">
                            <tr bgcolor="#d4d4d4" align="center" valign="middle">
                                <td  class="txt">��ѯ��ʽ &nbsp;&nbsp;
                                    <select name="kind" >
                                        <option value="1" <%if(kind==1){%>selected<%}%>>������</option>
                                    </select>&nbsp;&nbsp;Ϊ&nbsp;&nbsp;
                                    <input type="text" name="what" size="15">

                                </td>
                                <td >
                                    <input type="submit" value="��ѯ">
                                </td>

                            </tr>
                            <tr bgcolor="#F4F4F4" align="center" >
                                <td class="moduleTitle" colspan="2">
                                    <%if((startflag==1)){%>
                                    (
                                    ��ѯ
                                    <%if(kind==1){%>
                                    &nbsp;&nbsp;������:"<%=what%>"
                                    <%}%>
                                    )
                                    <%}%>
                                    <br>
                                    <font color="#48758C">�û�������Ŀ�б�</font>
                                </td>
                            </tr>
                            <tr bgcolor="#d4d4d4" align="right">
                                <td colspan="2">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1">
                                        <tr  bgcolor="#FFFFFF">
                                            <td align="center" class="txt">������</td>
                                            <td align="center" class="txt">�û�����</td>
                                            <td align="center" class="txt">
                                                �û���������
                                            </td>
                                            <td align="center" class="txt">
                                                �û�֧������
                                            </td>
                                            <td></td>
                                        </tr>

                                        <%
                                            IOrderManager orderMgr = orderPeer.getInstance();
                                            for(int i=0;i<currentlist.size();i++){
                                                other = (Other)currentlist.get(i);
                                                username = other.getUserName();
                                                boolean payflag = otherMgr.checkPayMoney(other.getNumber());
                                                float paymoney = otherMgr.getPayMoney(other.getNumber());
                                        %>
                                        <tr  bgcolor="#FFFFFF">
                                            <td align="center" class="txt">
                                                <%if(!payflag){%><a href="receive.jsp?orderid=<%=other.getNumber()%>&editflag=1" target=_blank>
                                                <%=other.getNumber()%>
                                            </a><%}%>
                                            </td>
                                            <td align="center" class="txt">
                                                <%=StringUtil.gb2iso4View(username)%>
                                            </td>
                                            <td align="center" class="txt">
                                                <%=other.getTotalFee()%>
                                            </td>
                                            <td align="center" class="txt">
                                                <%=paymoney%>
                                            </td>
                                            <td align="center" class="txt">
                                                <%if(!payflag){%><a href="receive.jsp?orderid=<%=other.getNumber()%>" target=_blank>�տ�</a><%}%>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>

                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table>
                <tr valign="bottom">
                    <td>
                        ��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <%
                            if(startflag != 1){
                                if((startrow-range)>=0){
                        %>
                        [<a href="index.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
                        <%}
                            if((startrow+range)<rows){
                        %>
                        [<a href="index.jsp?startrow=<%=startrow+range%>">��һҳ</a>]
                        <%}

                            if(totalpages>1){%>
                        &nbsp;&nbsp;��<input type="text" name="jump" value=<%=currentpage%> size="3">ҳ&nbsp;
                        <a href="#" onclick="golist((document.all('jump').value-1) * <%=range%>);">GO</a>
                        <%}

                        }else{
                            if((startrow-range)>=0){%>
                        [<a href="index.jsp?startrow=<%=startrow-range%>&what=<%=what%>&startflag=1&kind=<%=kind%>">��һҳ</a>]
                        <%}
                            if((startrow+range)<rows){%>

                        [<a href="index.jsp?startrow=<%=startrow+range%>&what=<%=what%>&startflag=1&kind=<%=kind%>">��һҳ</a>]
                        <%}
                            if(totalpages>1){
                                jumpstr = "&startflag=1&what="+what+"&kind="+kind;
                        %>
                        &nbsp;&nbsp;��<input type="text" name="jump" value=<%=currentpage%> size="3">ҳ&nbsp;
                        <a href="#" onclick="jumppage((document.all('jump').value-1) * <%=range%>,'<%=jumpstr%>');">GO</a>
                        <%}
                        }%>
                    </td>
                </tr>
            </table>
        </center>
    </form>
</center>
</body>
</html>