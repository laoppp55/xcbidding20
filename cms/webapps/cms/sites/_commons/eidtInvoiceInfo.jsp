<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@ page import="com.bizwink.cms.business.Order.Invoice" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>
<%@ page import="com.bizwink.cms.xml.XMLProperties" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    int markID = ParamUtil.getIntParameter(request, "markid", 0);
    Uregister ug = (Uregister) session.getAttribute("UserLogin");
    int userid = 0;
    if (ug != null) {
        userid = ug.getId();
    }
    IOrderManager oMgr = orderPeer.getInstance();
    //���session�б���ķ�Ʊ��Ϣ
    Invoice invoice = (Invoice) session.getAttribute("invoiceinfo");
    //��ñ����Ϣ
    IMarkManager markMgr = markPeer.getInstance();
    String listStyle = "";
    String submit = "";//ȷ�ϰ�ť
    String submitimage = "";//ȷ�ϰ�ťͼƬ
    int siteid = 0;
    if (markID > 0) {
        String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(markID));
        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        str = StringUtil.replace(str, "{^", "[");
        str = StringUtil.replace(str, "^}", "]");

        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
        listStyle = properties.getProperty(properties.getName().concat(".INVOICEINFO"));//��ʽ

        String siteids = properties.getProperty(properties.getName().concat(".SITEID"));
        if (siteids != null && !siteids.equalsIgnoreCase("null") && !siteids.equals("")) {
            siteid = Integer.parseInt(siteids);
        }
        submit = properties.getProperty(properties.getName().concat(".INVOICESUBMIT"));
        submitimage = properties.getProperty(properties.getName().concat(".INVOICEIMAGE"));
    }
    if (listStyle != null) {
        listStyle = listStyle.substring(0, listStyle.length() - 1);
    }
    //��Ʊ����
    String inoicetype = "";
    if(invoice.getInvoicetype() == 0){
        inoicetype = "<input type=\"radio\" name=\"invoicetype\" value=\"0\" checked>��ͨ��Ʊ&nbsp;&nbsp;<input type=\"radio\" name=\"invoicetype\" value=\"1\">��ֵ˰��Ʊ";
    }
    else{
        inoicetype = "<input type=\"radio\" name=\"invoicetype\" value=\"0\">��ͨ��Ʊ&nbsp;&nbsp;<input type=\"radio\" name=\"invoicetype\" value=\"1\" checked>��ֵ˰��Ʊ";
    }

    listStyle  = StringUtil.replace(listStyle, "<" + "%%invoicetype%%" + ">", inoicetype);
    //��Ʊ̧ͷ
    String title = "";
    if(invoice.getTitle() == 0)
    {
        title = "<input type=\"radio\" name=\"title\" value=\"0\" checked>����&nbsp;&nbsp;<input type=\"radio\" name=\"title\" value=\"1\">��λ";
    }
    else{
        title = "<input type=\"radio\" name=\"title\" value=\"0\">����&nbsp;&nbsp;<input type=\"radio\" name=\"title\" value=\"1\" checked>��λ";
    }

    listStyle  = StringUtil.replace(listStyle, "<" + "%%title%%" + ">", title);
    //��λ����
    String companyname = "";
    if(invoice.getCompanyname() != null && !invoice.getCompanyname().equals("") && !invoice.getCompanyname().equalsIgnoreCase("null")){
        companyname = "<input type=\"text\" name=\"companyname\" value=\""+invoice.getCompanyname()+"\" size=\"20\">";
    }else{
        companyname = "<input type=\"text\" name=\"companyname\" value=\"\" size=\"20\">";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%companyname%%" + ">", companyname);
    //��Ʊ����
    String content = "";
    List invoiceContentList = oMgr.getInvoiceContentList(siteid);
    for(int i = 0;i < invoiceContentList.size(); i++){
        Invoice invoiceContent = (Invoice)invoiceContentList.get(i);
        String contents = invoiceContent.getContentinfo()==null?"":StringUtil.gb2iso4View(invoiceContent.getContentinfo());
        if(invoice.getContent() == 0 && i == 0){
            content += "<input type=\"radio\" name=\"content\" value=\""+invoiceContent.getId()+"\" checked>"+contents;
        }else{
            if(invoice.getContent() == invoiceContent.getId()){
                 content += "<input type=\"radio\" name=\"content\" value=\""+invoiceContent.getId()+"\" checked>"+contents;
            }else{
                 content += "<input type=\"radio\" name=\"content\" value=\""+invoiceContent.getId()+"\">"+contents;
            }
        }
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%content%%" + ">", content);
    //��˰��ʶ���
    String identification = "";
    if(invoice.getIdentification()==null || invoice.getIdentification().equals("") || invoice.getIdentification().equalsIgnoreCase("null")){
        identification = "<input type=\"text\" name=\"identification\" size=\"20\">";
    }
    else{
        identification = "<input type=\"text\" name=\"identification\" size=\"20\" value=\""+invoice.getIdentification()+"\">";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%identification%%" + ">", identification);
    //ע���ַ
    String registeraddress = "";
    if(invoice.getRegisteraddress() ==null || invoice.getRegisteraddress().equals("") || invoice.getRegisteraddress().equalsIgnoreCase("null")){
        registeraddress = "<input type=\"text\" name=\"registeraddress\" size=\"20\">";
    }
    else{
        registeraddress = "<input type=\"text\" name=\"registeraddress\" size=\"20\" value=\""+invoice.getRegisteraddress()+"\">";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%registeraddress%%" + ">", registeraddress);
    //ע��绰
    String phone = "";
    if(invoice.getPhone() ==null || invoice.getPhone().equals("") || invoice.getPhone().equalsIgnoreCase("null")){
        phone = "<input type=\"text\" name=\"phone\" size=\"20\">";
    }
    else{
        phone = "<input type=\"text\" name=\"phone\" size=\"20\" value=\""+invoice.getPhone() +"\">";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%phone%%" + ">", phone);
    //��������
    String bankname = "";
    if(invoice.getBankname() ==null || invoice.getBankname().equals("") || invoice.getBankname().equalsIgnoreCase("null")){
        bankname = "<input type=\"text\" name=\"bankname\" size=\"20\">";
    }
    else{
        bankname = "<input type=\"text\" name=\"bankname\" size=\"20\" value=\""+invoice.getBankname() +"\">";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%bankname%%" + ">", bankname);
    //�����ʺ�
    String bankaccount = "";
    if(invoice.getBankaccount() ==null || invoice.getBankaccount().equals("") || invoice.getBankaccount().equalsIgnoreCase("null")){
        bankaccount = "<input type=\"text\" name=\"bankaccount\" size=\"20\">";
    }
    else{
        bankaccount = "<input type=\"text\" name=\"bankaccount\" size=\"20\" value=\""+invoice.getBankaccount() +"\">";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%bankaccount%%" + ">", bankaccount);
    String submits = "";
        if (submit.equals("submit")) {
            submits = "<input type='button' name='button1' value='�޸�' onclick='javascript:submitinvoice(" + markID + ");'>&nbsp;\n";
        } else if (submit.equals("images")) {
            submits = "<a href=\"#\" onclick='submitinvoice("+ markID + ");'><img src=\"/_sys_images/buttons/" + submitimage + "\" border=0></a>";
        } else {
            submits = "<a href=\"#\" onclick='submitinvoice("+ markID + ");'>�޸�</a>";
        }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%submitbutton%%" + ">", submits);
    out.write(listStyle);
%>