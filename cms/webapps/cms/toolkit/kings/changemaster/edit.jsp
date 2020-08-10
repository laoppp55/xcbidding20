<%@page import="com.bizwink.cms.kings.changemaster.ChangeMaster,
                com.bizwink.cms.kings.changemaster.ChangeMasterPeer,
                com.bizwink.cms.kings.changemaster.IChangeMasterManager,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.util.SessionUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.bizwink.cms.kings.changedetail.*" %>
<script language="JavaScript" src="../images/setday.js"></script>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int siteid = authToken.getSiteID();
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    int id = ParamUtil.getIntParameter(request, "id", 0);
    String changeid = ParamUtil.getParameter(request, "changeid");
    // String changedate = ParamUtil.getParameter(request, "changedate");
    int changekind = ParamUtil.getIntParameter(request, "changekind", 0);
    String description = ParamUtil.getParameter(request, "description");
    ChangeMaster cm = new ChangeMaster();
    IChangeMasterManager chaMgr = ChangeMasterPeer.getInstance();

    IChangeDetailManager cdMgr = ChangeDetailPeer.getInstance();
    ChangeDetail cd = new ChangeDetail();
    List list1 = new ArrayList();
    List listcd = new ArrayList();
    list1 = cdMgr.getByIdChangeDetails(changeid);    

    if (startflag == 1) {
        String changedate1 = ParamUtil.getParameter(request, "changedate");
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Timestamp changedate = new Timestamp(sf.parse(changedate1).getTime());
        cm.setChangeID(changeid);
        cm.setSiteid(siteid);
        cm.setChangeDate(changedate);
        cm.setChangeKind(changekind);
        cm.setDescription(description);
        if(list1!=null){
            for(int i=0;i<list1.size();i++){
                cd = new ChangeDetail();
                int pdid = ParamUtil.getIntParameter(request,"pdid" + i,0);
                int productid = ParamUtil.getIntParameter(request,"a0" + i,0);
                int changequantity = ParamUtil.getIntParameter(request,"a1" + i,0);
                int changeamount = ParamUtil.getIntParameter(request,"a2" + i,0);
                cd.setId(pdid);
                cd.setProductID(String.valueOf(productid));
                cd.setChangeQuantity(changequantity);
                cd.setChangeAmount(changeamount);
                listcd.add(cd);
            }
        }         
        chaMgr.updateChangeMasterhe(cm, id,listcd);
        response.sendRedirect("changemaster.jsp");
    }
    cm = chaMgr.getByIdChangeMaster(id);
%>

<HTML>
<HEAD><TITLE>����䶯��Ϣ¼��</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function check()
        {
            if (form1.changeid.value == "")
            {
                alert("������䶯�����ţ�");
                return false;
            }
            if (form1.changedate.value == "") {
                alert("������䶯����");
                return false;
            }

            return true;
        }

        function msg() {
            for (var i = 0; i < form1.changekind1.length; i++)
            {
                if (form1.changekind1[i].selected)
                    form1.changekind.value = form1.changekind1[i].value;
            }
        }

        function chenk(type){
            //window.open("../product/index.jsp","","");
            str = window.showModalDialog('../product/index.jsp?id='+<%=1%>,'example05','dialogWidth:1000px;dialogHeight:600px.dialogLeft:200px;dialogTop:150px;center:yes;help:yes;resizable:yes;status:yes')
            if(str!=undefined){
                var types = 'a0';
                types += type;
                //form1.types.value = str;
                document.getElementById(types).value = str;
            }
        }           

        function goto()
        {
            form1.action = "changemaster.jsp";
            form1.submit();
        }
    </SCRIPT>

    <META content="MSHTML 6.00.2800.1479" name=GENERATOR>
</HEAD>
<BODY bgColor=#ffffff>
<FORM name=form1 action=edit.jsp method=post>
    <INPUT type=hidden value=1 name=startflag>
    <input type=hidden name="id" value="<%=id%>">
    <CENTER>
        <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80%
               borderColorLight=#008000 border=1>
            <TBODY>
            <TR>
                <TD bgColor=#33ccff colSpan=2 height=32>
                    <P align=center>�޸Ĵ���䶯��ϸ��Ϣ</P></TD>
            </TR>
            <TR height=32>
                <TD align=right>�䶯�����ţ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=changeid value="<%=cm.getChangeID()%>">
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>�䶯���ڣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=changedate
                                            value="<%=cm.getChangeDate().toString().substring(0,10)%>"
                                            onfocus="setday(this)">
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>�䶯���</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=changekind value="<%=cm.getChangeKind()%>">
                    <select name="changekind1" onchange="msg()">
                        <option value="1" selected>����</option>
                        <option value="2">����</option>
                        <option value="3">�˻�</option>
                    </select>
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>˵����</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=description value="<%=cm.getDescription()%>">
            </TR>
            <TR height=32>
                <TD colSpan=2><FONT
                        color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע������*����Ϊ������</FONT></TD>
            </TR>
        <TR>
            <TD align=center height=32 colspan="2">
                <table cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=100% borderColorLight=#008000 border=1>
                    <tr><td bgColor=#33ccff height="32" colspan="3" align="center">���䶯��ϸ</td></tr>
                    <tr><TD align=center width=40% height=32>��Ʒ����</TD>
                    <TD align=center width=20% height=32>����</TD>
                    <TD align=center width=20% height=32>���</TD>
                    </tr><%
                        if(list1 != null){
                            for(int i=0;i<list1.size();i++){
                                cd = (ChangeDetail)list1.get(i);
                                String productid = cd.getProductID();
                                String changequantity = Integer.toString(cd.getChangeQuantity());
                                String changeamount = Integer.toString(cd.getChangeAmount());
                    %><input type="hidden" name="pdid<%=i%>" value="<%=cd.getId()%>">
                    <tr><TD align=center width=40% height=32>&nbsp;<input size="30" name="a0<%=i%>" id="a0<%=i%>" onclick="chenk(<%=i%>);" value="<%=productid == null ? "" : productid%>" readonly></TD>
                    <TD align=center width=20% height=32>&nbsp;<input size="16" name="a1<%=i%>" value="<%=changequantity == null ? "" : changequantity%>" ></TD>
                    <TD align=center width=20% height=32>&nbsp;<input size="16" name="a2<%=i%>" value="<%=changeamount == null ? "" : changeamount%>" ></TD>                  
                    </tr>
                    <%}}%>
                </table>
            </TD>
        </TR>             
            </TBODY>
        </TABLE>
        <P align=center><INPUT onclick="javascript:return check();" type=submit value=" ȷ �� " name=Ok>&nbsp;&nbsp;
            <INPUT onclick=javascript:goto(); type=button value=�����б� name=golist>
        </P>
    </CENTER>
</FORM>
</BODY>
</HTML>
