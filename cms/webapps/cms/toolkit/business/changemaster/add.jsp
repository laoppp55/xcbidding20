<%@page import="com.bizwink.cms.kings.changemaster.ChangeMaster,
                com.bizwink.cms.kings.changemaster.ChangeMasterPeer,
                com.bizwink.cms.kings.changemaster.IChangeMasterManager,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.util.SessionUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.cms.kings.changedetail.ChangeDetail" %>
<%@ page import="java.util.*" %>
<script language="JavaScript" src="../images/setday.js"></script>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    List listcd =  new ArrayList();
    int siteid = authToken.getSiteID();
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    int id = ParamUtil.getIntParameter(request, "id", 0);
    String changeid = ParamUtil.getParameter(request, "changeid");
    int changekind = ParamUtil.getIntParameter(request, "changekind", 0);
    String description = ParamUtil.getParameter(request, "description");
    String changeamount1 = ParamUtil.getParameter(request, "changeamount");
    String changequantity1 = ParamUtil.getParameter(request, "changequantity");
    String productid1 = ParamUtil.getParameter(request, "productid");
    if (startflag == 1) {
        String changedate1 = ParamUtil.getParameter(request, "changedate");
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Timestamp changedate = new Timestamp(sf.parse(changedate1).getTime());
        //Timestamp a = new Timestamp(System.currentTimeMillis() );   System.out.println("aaa = " + a);
        //Timestamp b = new Timestamp(System.nanoTime());               System.out.println("bbb = " + b);
        ChangeMaster cm = new ChangeMaster();
        ChangeDetail cd = new ChangeDetail();
        IChangeMasterManager chaMgr = ChangeMasterPeer.getInstance();

        cm.setId(id);
        cm.setChangeID(changeid);
        cm.setSiteid(siteid);
        cm.setChangeDate(changedate);
        cm.setChangeKind(changekind);
        cm.setDescription(description);

        String[] productid = productid1.split(",");
        String[] changequantity = changequantity1.split(",");
        String[] changeamount = changeamount1.split(",");
        //System.out.println("purchasequantity = "+purchasequantity.length);
        for(int i = 0; i < productid.length; i++){

            cd = new ChangeDetail();
            if(productid[i] != null && productid[i] != ""){
                cd.setProductID(productid[i]);
            }
            if(changequantity[i] != null && changequantity[i] != ""){
                cd.setChangeQuantity(Integer.parseInt(changequantity[i]));
            }
            if(changeamount[i] != null && changeamount[i] != ""){
                cd.setChangeAmount(Integer.parseInt(changeamount[i]));
            }
            listcd.add(cd);
        }        

        chaMgr.insertChangeMasterhe(cm,listcd);
        response.sendRedirect("changemaster.jsp");
    }
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
        var tableobj=document.getElementById("table1");
        var rows = tableobj.rows.length-2;
        var productid ="";
        var changequantity ="";
        var changeamount ="";
        
        for(i=0;i<=rows;i++){
            var   obj=   document.getElementById("a0"+i);
            var   obj1=   document.getElementById("a1"+i);
            var   obj2=   document.getElementById("a2"+i);

                if(obj.value != "" && obj.value != null){
                    productid += obj.value +",";
                }else{
                    productid += 0 + ",";
                }
                if(obj1.value != "" && obj1.value != null){
                    changequantity += obj1.value +",";
                }else{
                    changequantity += 0 + ",";
                }
                if(obj2.value != "" && obj2.value != null){
                    changeamount += obj2.value +",";
                }else{
                    changeamount += 0 + ",";
                }
            }
                document.form1.productid.value = productid;
                document.form1.changequantity.value = changequantity;
                document.form1.changeamount.value = changeamount;            

            return true;
        }

		function butt(){
            var tableobj=document.getElementById("table1");
            var rowobj=tableobj.insertRow(tableobj.rows.length);

            var cell1=rowobj.insertCell(rowobj.cells.length);
            var cell2=rowobj.insertCell(rowobj.cells.length);
            var cell3=rowobj.insertCell(rowobj.cells.length);
            //var cell4=rowobj.insertCell(rowobj.cells.length);
            var p = tableobj.rows.length -2;
            var name = "a0" + p;
            var name1 = "a1" + p;
            var name2 = "a2" + p;
            var name3 = "a3" + p;
            //alert(name);
            //cell1.innerHTML=document.getElementById("name").value;
            cell1.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT size=34 name='"+name+"' id='"+name+"' onclick=\"chenk('"+ p +"');\" readonly>";
            cell2.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT size=27 name='"+name1+"' id='"+name1+"'>";
            cell3.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT size=14 name='"+name2+"' id='"+name2+"'>";
            //cell4.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT size=14 name='"+name3+"' id='"+name3+"'>";
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

		function   initTblCell(cell){

		var   lastCell   =   document.getElementById("table1").rows[0].cells[cell.cellIndex];

		cell.innerHTML   =   lastCell.innerHTML;

		//alert(cell.innerHTML);

		if   (cell.children   !=   null   &&   cell.children.length   >   0)   {

		for(childIndex   =   0;   childIndex   <   cell.children.length;   childIndex++)   {

		var   child   =   cell.children[childIndex];

		switch(child.type)   {

		case   "text":

		child.value   =   "";

		break;

		case   "checkbox":

		child.value   =   "";

		child.checked   =   false;

		break;

		}

		}

		}

		cell.className   =   lastCell.className;

		cell.align   =   lastCell.align;

		cell.height   =   lastCell.height;

		}

        function   buttonFun(){
        var tableobj=document.getElementById("table1");
        var rows = tableobj.rows.length-2;
        var productid ="";
        var changequantity ="";
        var changeamount ="";

        for(i=0;i<=rows;i++){
            var   obj=   document.getElementById("a0"+i);
            var   obj1=   document.getElementById("a1"+i);
            var   obj2=   document.getElementById("a2"+i);

                if(obj.value != "" && obj.value != null){
                    productid += obj.value +",";
                }else{
                    productid += 0 + ",";
                }
                if(obj1.value != "" && obj1.value != null){
                    changequantity += obj1.value +",";
                }else{
                    changequantity += 0 + ",";
                }
                if(obj2.value != "" && obj2.value != null){
                    changeamount += obj2.value +",";
                }else{
                    changeamount += 0 + ",";
                }
            }
                document.form1.productid.value = productid;
                document.form1.changequantity.value = changequantity;
                document.form1.changeamount.value = changeamount;   
        }

        function   dellRow(){

        var   obj=   document.getElementById("table1");

        var   objRow=obj.rows.length-1;

        //alert(objRow);

        if(objRow   !=   0){

        obj.deleteRow(objRow);

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
<FORM name=form1 action=add.jsp method=post>
    <INPUT type=hidden value=1 name=startflag>
    <INPUT type=hidden value=1 name=productid>
    <INPUT type=hidden value=1 name=changeamount>
    <INPUT type=hidden value=1 name=changequantity>
    <INPUT type=hidden name=id>
    <CENTER>
        <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80%
               borderColorLight=#008000 border=1>
            <TBODY>
            <TR>
                <TD bgColor=#33ccff colSpan=2 height=32>
                    <P align=center>��Ӵ���䶯��ϸ��Ϣ</P></TD>
            </TR>
            <TR height=32>
                <TD align=right>�䶯�����ţ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=changeid>
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>�䶯���ڣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=changedate onfocus="setday(this)">
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>�䶯���</TD>
                <TD align=left>&nbsp;
                    <select name="changekind">
                        <option value="1" selected>����</option>
                        <option value="2">����</option>
                        <option value="3">�˻�</option>
                    </select>
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>˵����</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=description>
            </TR>
            <TR height=32>
                <TD colSpan=2><FONT
                        color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע������*����Ϊ������</FONT></TD>
            </TR>
            <TR>
                <TD bgColor=#33ccff colSpan=2 height=32>
                    <P align=center>���䶯��ϸ&nbsp;&nbsp;&nbsp;<input type=button value=" �� �� " onclick="butt();">
                        <input type=button value=" �� �� " onclick="dellRow();">
                       <%-- <input type=button value=" �� �� " onclick="buttonFun();">--%>
                    </P></TD>
            </TR>
            <TR height=32>
                <TD colspan="2"><TABLE id="table1" cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=100% borderColorLight=#008000 border=1>
                        <TR height=32 >
                            <TD align=center>��Ʒ����</TD>
                            <TD align=center>����</TD>
                            <TD align=center>���</TD>
                        </TR>
                        <TR height=32>
                            <TD align=center>&nbsp;<INPUT size=34 name=a00 id="a00" onclick="chenk(0);" readonly></TD>
                            <TD align=center>&nbsp;<INPUT size=27 name=a10 id="a10"></TD>
                            <TD align=center>&nbsp;<INPUT size=14 name=a20 id="a20"></TD>
                        </TR>
                        <TR height=32>
                            <TD align=center>&nbsp;<INPUT size=34 name=a01 id="a01" onclick="chenk(1);" readonly></TD>
                            <TD align=center>&nbsp;<INPUT size=27 name=a11 id="a11"></TD>
                            <TD align=center>&nbsp;<INPUT size=14 name=a21 id="a21"></TD>
                        </TR>
                        <TR height=32>
                            <TD align=center>&nbsp;<INPUT size=34 name=a02 id="a02" onclick="chenk(2);" readonly></TD>
                            <TD align=center>&nbsp;<INPUT size=27 name=a12 id="a12"></TD>
                            <TD align=center>&nbsp;<INPUT size=14 name=a22 id="a22"></TD>
                        </TR>
                        <TR height=32>
                            <TD align=center>&nbsp;<INPUT size=34 name=a03 id="a03" onclick="chenk(3);" readonly></TD>
                            <TD align=center>&nbsp;<INPUT size=27 name=a13 id="a13"></TD>
                            <TD align=center>&nbsp;<INPUT size=14 name=a23 id="a23"></TD>
                        </TR>
                </TABLE></TD>
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
