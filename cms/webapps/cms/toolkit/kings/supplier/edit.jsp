<%@page import="com.bizwink.cms.kings.supplier.ISupplierSuManager,
                com.bizwink.cms.kings.supplier.SupplierSu,
                com.bizwink.cms.kings.supplier.SupplierSuPeer,
                com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.util.SessionUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<script language="JavaScript" src="../images/setday.js"></script>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    int id = ParamUtil.getIntParameter(request, "id", 0);
    String suppliername = ParamUtil.getParameter(request, "suppliername");
    String supplierattribname = ParamUtil.getParameter(request, "supplierattribname");
    int invoiceno = ParamUtil.getIntParameter(request, "invoiceno", 0);
    String owner = ParamUtil.getParameter(request, "owner");
    int rocid = ParamUtil.getIntParameter(request, "rocid", 0);
    int phone1 = ParamUtil.getIntParameter(request, "phone1", 0);
    int phone2 = ParamUtil.getIntParameter(request, "phone2", 0);
    int fax = ParamUtil.getIntParameter(request, "fax", 0);
    String contactname1 = ParamUtil.getParameter(request, "contactname1");
    String contactname2 = ParamUtil.getParameter(request, "contactname2");
    String companyaddress = ParamUtil.getParameter(request, "companyaddress");
    String deliveryaddress = ParamUtil.getParameter(request, "deliveryaddress");
    String invoiceaddress = ParamUtil.getParameter(request, "invoiceaddress");
    //String lastpurchasedate = ParamUtil.getParameter(request, "lastpurchasedate");
    int paydays = ParamUtil.getIntParameter(request, "paydays", 0);
    int prepaid = ParamUtil.getIntParameter(request, "prepaid", 0);
    int siteid = authToken.getSiteID();
    // System.out.println("-++++-"+suppliername);
    SupplierSu ss = new SupplierSu();
    ISupplierSuManager supplierSuMgr = SupplierSuPeer.getInstance();

    if (startflag == 1) {
        //long nowtime = System.currentTimeMillis();
        String lastpurchasedate1 = ParamUtil.getParameter(request, "lastpurchasedate");
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        Timestamp lastpurchasedate = new Timestamp(sf.parse(lastpurchasedate1).getTime());
        ss.setSuppliername(suppliername);
        ss.setSupplierattribname(supplierattribname);
        ss.setInvoiceno(invoiceno);
        ss.setOwner(owner);
        ss.setRocid(rocid);
        ss.setPhone1(phone1);
        ss.setPhone2(phone2);
        ss.setFax(fax);
        ss.setContactname1(contactname1);
        ss.setContactname2(contactname2);
        ss.setCompanyaddress(companyaddress);
        ss.setDeliveryaddress(deliveryaddress);
        ss.setInvoiceaddress(invoiceaddress);
        ss.setLastpurchasedate(lastpurchasedate);
        ss.setPaydays(paydays);
        ss.setPrepaid(prepaid);
        ss.setSiteid(siteid);
        supplierSuMgr.updateSupplierSu(ss, id);
        response.sendRedirect("supplier.jsp");
    }
    ss = supplierSuMgr.getByIdsupplier(id);
%>
<HTML>
<HEAD><TITLE>�޸Ĺ�Ӧ����Ϣ</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function check()
        {
            if (form1.suppliername.value == "")
            {
                alert("�����빩Ӧ�����ƣ�");
                return false;
            }

            /*  if(form1.postcode.value!="")
             {
             var digits = "0123456789";
             var i = 0;
             var sLength = form1.postcode.value.length;
             while ((i < sLength))
             {
             var c = form1.postcode.value.charAt(i);
             if (digits.indexOf(c) == -1)
             {
             alert("�ʱ��������");
             return false;
             }
             i++;
             }
             }*/

            if (form1.fax.value != "")
            {
                var digits = "0123456789-()";
                var i = 0;
                var sLength = form1.fax.value.length;
                while ((i < sLength))
                {
                    var c = form1.fax.value.charAt(i);
                    if (digits.indexOf(c) == -1)
                    {
                        alert("�����������");
                        return false;
                    }
                    i++;
                }
            }
            if (form1.phone1.value != "")
            {
                var digits = "0123456789-()";
                var i = 0;
                var sLength = form1.telephone.value.length;
                while ((i < sLength))
                {
                    var c = form1.telephone.value.charAt(i);
                    if (digits.indexOf(c) == -1)
                    {
                        alert("�绰�������");
                        return false;
                    }
                    i++;
                }
            }
            if (form1.phone2.value != "")
            {
                var digits = "0123456789-()";
                var i = 0;
                var sLength = form1.mobilephone.value.length;
                while ((i < sLength))
                {
                    var c = form1.mobilephone.value.charAt(i);
                    if (digits.indexOf(c) == -1)
                    {
                        alert("�ֻ��������");
                        return false;
                    }
                    i++;
                }
            }

            if (form1.email.value != "")
            {
                if (form1.email.value.length > 100)
                {
                    window.alert("email��ַ���Ȳ��ܳ���100λ!");
                    return false;
                }

                var regu = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$"
                var re = new RegExp(regu);
                if (form1.email.value.search(re) != -1) {
                    return true;
                } else {
                    window.alert("��������Ч�Ϸ��ĵ����ʼ� ��")
                    return false;
                }
            }
            return true;
        }

        function goto()
        {
            form1.action = "supplier.jsp";
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
                    <P align=center>�޸Ĺ�Ӧ����Ϣ</P></TD>
            </TR>
            <TR height=32>
                <TD align=right width=30% height=32>��Ӧ�����ƣ�</TD>
                <TD align=left width=70% height=32>&nbsp;<INPUT size=50 name=suppliername
                                                                value="<%=ss.getSuppliername()==null?"":ss.getSuppliername()%>">
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>��Ӧ�̼�ƣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=supplierattribname
                                            value="<%=ss.getSupplierattribname()==null?"":ss.getSupplierattribname()%>">
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>ͳһ��ţ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=invoiceno value="<%=ss.getInvoiceno()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>�����ˣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=owner value="<%=ss.getOwner()==null?"":ss.getOwner()%>">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>���֤���룺</TD>
                <TD align=left>&nbsp;<INPUT name=rocid value="<%=ss.getRocid()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>����绰1��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=phone1 value="<%=ss.getPhone1()%>">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>����绰2��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=phone2 value="<%=ss.getPhone2()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>������룺</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=fax value="<%=ss.getFax()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>������1��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=contactname1
                                            value="<%=ss.getContactname1()==null?"":ss.getContactname1()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>������2��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=contactname2
                                            value="<%=ss.getContactname2()==null?"":ss.getContactname2()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��˾��ַ��</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=companyaddress
                                            value="<%=ss.getCompanyaddress()==null?"":ss.getCompanyaddress()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>������ַ��</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=deliveryaddress
                                            value="<%=ss.getDeliveryaddress()==null?"":ss.getDeliveryaddress()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��Ʊ��ַ��</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=invoiceaddress
                                            value="<%=ss.getInvoiceaddress()==null?"":ss.getInvoiceaddress()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>����������ڣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=lastpurchasedate onfocus="setday(this)"
                                            value="<%=ss.getLastpurchasedate().toString().substring(0,10)%>">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>����������</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=paudays value="<%=ss.getPaydays()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>�ݸ��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=prepaid value="<%=ss.getPrepaid()%>"></TD>
            </TR>
            <TR height=32>
                <TD colSpan=2><FONT
                        color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע������*����Ϊ������</FONT></TD>
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
