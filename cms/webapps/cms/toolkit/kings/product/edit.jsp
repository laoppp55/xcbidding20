<%@page import="com.bizwink.cms.kings.jspsmart.upload.File,
                com.bizwink.cms.kings.jspsmart.upload.Files,
                com.bizwink.cms.kings.jspsmart.upload.SmartUpload,
                com.bizwink.cms.kings.product.IProductSuManager,
                com.bizwink.cms.kings.product.ProductSu,
                com.bizwink.cms.kings.product.ProductSuPeer" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.kings.supplier.ISupplierSuManager" %>
<%@ page import="com.bizwink.cms.kings.supplier.SupplierSu" %>
<%@ page import="com.bizwink.cms.kings.supplier.SupplierSuPeer" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<script language="JavaScript" src="../images/setday.js"></script>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    ISupplierSuManager ssMgr = SupplierSuPeer.getInstance();
    List list = new ArrayList();
    list = ssMgr.getAllSupplier(siteid);

    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    int id = ParamUtil.getIntParameter(request, "id", 0);
    String productname = ParamUtil.getParameter(request, "productname");
    int supplierid = ParamUtil.getIntParameter(request, "supplierid", 0);
    int safestock = ParamUtil.getIntParameter(request, "safestock", 0);
    String lastpurchasedate1 = ParamUtil.getParameter(request, "lastpurchasedate");
    String lastdeliverydate1 = ParamUtil.getParameter(request, "lastdeliverydate");
    int quantity = ParamUtil.getIntParameter(request, "quantity", 0);
    String maxpicture = ParamUtil.getParameter(request, "maxpicture");
    String minpicture = ParamUtil.getParameter(request, "minpicture");
    String specificpicture = ParamUtil.getParameter(request, "specificpicture");
    String picture = ParamUtil.getParameter(request, "picture");
    String titlepicture = ParamUtil.getParameter(request, "titlepicture");
    String borntitlepicture = ParamUtil.getParameter(request, "borntitlepicture");
    //int siteid = authToken.getSiteID();

    ProductSu ps = new ProductSu();
    IProductSuManager productSuMgr = ProductSuPeer.getInstance();
    boolean error = true;
    String filename = "";

    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    if (doCreate) {
        com.bizwink.cms.kings.jspsmart.upload.File tmpFile = null;
        try {
            //ʵ��������bean
            SmartUpload mySmartUpload = new SmartUpload();
            //��ʼ��
            mySmartUpload.initialize(pageContext);
            //�������ص����ֵ
            mySmartUpload.setMaxFileSize(50 * 1024 * 1024);
            try {
                //�����ļ�
                mySmartUpload.upload();
            } catch (Exception e) {
                response.sendRedirect("edit.jsp");
            }
            id = Integer.parseInt(mySmartUpload.getRequest().getParameter("id"));
            startflag = Integer.parseInt(mySmartUpload.getRequest().getParameter("startflag"));
            productname = mySmartUpload.getRequest().getParameter("productname");
            supplierid = Integer.parseInt(mySmartUpload.getRequest().getParameter("supplierid"));
            safestock = Integer.parseInt(mySmartUpload.getRequest().getParameter("safestock"));
            lastpurchasedate1 = mySmartUpload.getRequest().getParameter("lastpurchasedate");
            lastdeliverydate1 = mySmartUpload.getRequest().getParameter("lastdeliverydate");
            quantity = Integer.parseInt(mySmartUpload.getRequest().getParameter("quantity"));
            Files uploadFiles = mySmartUpload.getFiles();
            for (int i = 0; i < mySmartUpload.getFiles().getCount(); i++) {
                File tempFile = mySmartUpload.getFiles().getFile(i);
                if (!tempFile.isMissing()) {
                    filename = tempFile.getFileName();
                    //System.out.println("tmf = " + tempFile.isMissing());
                    String ext = tempFile.getFileExt();
                    //System.out.println("picture = " + ps.getPicture());
                    String newfilename = String.valueOf(System.currentTimeMillis()) + "_" + i + "." + ext;
                    if (i == 0) {
                        maxpicture = newfilename;
                    }
                    if (i == 1) {
                        minpicture = newfilename;
                    }
                    if (i == 2) {
                        specificpicture = newfilename;
                    }
                    if (i == 3) {
                        picture = newfilename;
                    }
                    if (i == 4) {
                        titlepicture = newfilename;
                    }
                    if (i == 5) {
                        borntitlepicture = newfilename;
                    }
                    String uploadPath = application.getRealPath("/") + java.io.File.separator + "productpic" + java.io.File.separator;
                    java.io.File file = new java.io.File(uploadPath);
                    if (!file.exists()) {
                        file.mkdirs();
                    }

                    boolean flag = tempFile.saveAs(uploadPath + newfilename);
                }

            }
            mySmartUpload.stop();
        } catch (Exception
                e) {
            System.out.println(e.toString());

            error = true;
        }

        if (startflag == 1) {
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            Timestamp lastpurchasedate = new Timestamp(sf.parse(lastpurchasedate1).getTime());
            Timestamp lastdeliverydate = new Timestamp(sf.parse(lastdeliverydate1).getTime());
            ps.setProductName(productname);
            ps.setSafeStock(safestock);
            ps.setLastPurchaseDate(lastpurchasedate);
            ps.setLastDeliveryDate(lastdeliverydate);
            ps.setQuantity(quantity);
            ps.setMaxPicture(maxpicture);
            ps.setMinPicture(minpicture);
            ps.setSpecificPicture(specificpicture);
            ps.setPicture(picture);
            ps.setTitlePicture(titlepicture);
            ps.setBornTitlePicture(borntitlepicture);
            ps.setSiteid(siteid);
            ps.setSupplierID(supplierid);
            productSuMgr.updateProductSu(ps, id);
            response.sendRedirect("product.jsp");
        }
    }
    ps = productSuMgr.getByIdproduct(id);
%>
<HTML>
<HEAD><TITLE>�޸���Ʒ��Ϣ</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
        function check()
        {
            if (form1.productname.value == "")
            {
                alert("��������Ʒ���ƣ�");
                return false;
            }
            return true;
        }
        function f(theimg) {
            var val = theimg.value;
            var ext = val.substring(val.lastIndexOf(".")).toLowerCase();
            var validate = false;

            if (ext == ".gif" || ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".bmp") {
                d.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = theimg.value;
                d.style.width = d.offsetWidth;
                d.style.height = d.offsetHeight;
                d.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").sizingMethod = 'scale';
                validate = true;
            }
            else if (ext == ".swf")
            {
                validate = true;
            }
            else
            {
                if (!validate)
                {
                    alert("ֻ���ϴ�ͼ��FLASH�ļ���");
                }
            }
        }
        function msg1() {
            for (var i = 0; i < form1.supplierids.length; i++)
            {
                if (form1.supplierids[i].selected)
                //alert(form1.supplierids[i].value);
                    form1.supplierid.value = form1.supplierids[i].innerText;
            }
        }

        function goto()
        {
            form1.action = "product.jsp";
            form1.submit();
        }
    </SCRIPT>

    <META content="MSHTML 6.00.2800.1479" name=GENERATOR>
</HEAD>
<BODY bgColor=#ffffff>
<FORM name=form1 action=edit.jsp?doCreate=true method=post enctype="multipart/form-data">
    <INPUT type=hidden value=1 name=startflag>
    <input type=hidden name="id" value="<%=id%>">

    <CENTER>
        <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80%
               borderColorLight=#008000 border=1 enctype="multipart/form-data">
            <TBODY>
            <TR>
                <TD bgColor=#33ccff colSpan=2 height=32>
                    <P align=center>�޸���Ʒ��Ϣ</P></TD>
            </TR>
            <TR height=32>
                <TD align=right width=30% height=32>��Ʒ���ƣ�</TD>
                <TD align=left width=70% height=32>&nbsp;<INPUT size=50 name=productname
                                                                value="<%=ps.getProductName()%>">
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right width=30% height=32>�����̱�ţ�</TD>
                <TD align=left width=70% height=32>&nbsp;<INPUT size=40 name=supplierid
                                                                value="<%=ps.getSupplierID()%>" readonly>
                    <SELECT NAME="supplierids" onchange="msg1()">

                        <%
                            for (int i = 0; i < list.size(); i++) {
                                SupplierSu ss = (SupplierSu) list.get(i);
                        %>

                        <OPTION VALUE=<%=i%>><%=ss.getSupplierid()%>
                        </OPTION>

                        <% } %></SELECT>
                    <FONT color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>��ȫ������</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=safestock value="<%=ps.getSafeStock()%>">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>����������ڣ�</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=lastpurchasedate
                                            value="<%=ps.getLastPurchaseDate().toString().substring(0,10)%>"
                                            onfocus="setday(this)"></TD>
            </TR>
            <TR height=32>
                <TD align=right>����������ڣ�</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=lastdeliverydate
                                            value="<%=ps.getLastDeliveryDate().toString().substring(0,10)%>"
                                            onfocus="setday(this)">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>�������</TD>
                <TD align=left>&nbsp;<INPUT size="50" name=quantity value="<%=ps.getQuantity()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��ͼƬ��</TD>
                <TD align=left>&nbsp;<% if (ps.getMaxPicture() != null) { %>
                    <img src="<%="../../../"+"productpic" + "\\" +ps.getMaxPicture()%>" height="25"
                         width="50"><% } else { %>
                    --<% } %>&nbsp;<INPUT type="file" size=45 name=maxpicture value="" onpropertychange="f(this)">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>СͼƬ��</TD>
                <TD align=left>&nbsp;<% if (ps.getMinPicture() != null) { %>
                    <img src="<%="../../../"+"productpic" + "\\" +ps.getMinPicture()%>" height="25"
                         width="50"><% } else { %>
                    --<% } %>&nbsp;<INPUT type="file" size=45 name=minpicture value="" onpropertychange="f(this)"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��Чͼ��</TD>
                <TD align=left>&nbsp;<% if (ps.getSpecificPicture() != null) { %>
                    <img src="<%="../../../"+"productpic" + "\\" +ps.getSpecificPicture()%>" height="25"
                         width="50"><% } else { %>
                    --<% } %>&nbsp;<INPUT type="file" size=45 name=specificpicture value="" onpropertychange="f(this)">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>ԭͼ��</TD>
                <TD align=left>&nbsp;<% if (ps.getPicture() != null) { %>
                    <img src="<%="../../../"+"productpic" + "\\" +ps.getPicture()%>" height="25"
                         width="50"><% } else { %>
                    --<% } %>&nbsp;<INPUT type="file" size=45 name=picture value="" onpropertychange="f(this)"></TD>
            </TR>
            <TR height=32>
                <TD align=right>����ͼ��</TD>
                <TD align=left>&nbsp;<% if (ps.getTitlePicture() != null) { %>
                    <img src="<%="../../../"+"productpic" + "\\" +ps.getTitlePicture()%>" height="25"
                         width="50"><% } else { %>
                    --<% } %>&nbsp;<INPUT type="file" size=45 name=titlepicture value="" onpropertychange="f(this)">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>ԭ����ͼ��</TD>
                <TD align=left>&nbsp;<% if (ps.getBornTitlePicture() != null) { %>
                    <img src="<%="../../../"+"productpic" + "\\" +ps.getBornTitlePicture()%>" height="25"
                         width="50"><% } else { %>
                    --<% } %>&nbsp;<INPUT type="file" size=45 name=borntitelpicture value="" onpropertychange="f(this)">
                </TD>
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
