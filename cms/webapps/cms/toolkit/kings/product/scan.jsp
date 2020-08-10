<%@page import="com.bizwink.cms.kings.product.IProductSuManager,
                com.bizwink.cms.kings.product.ProductSu,
                com.bizwink.cms.kings.product.ProductSuPeer,
                com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="java.sql.Timestamp" %>
<%
    int id = ParamUtil.getIntParameter(request, "id", 0);
    ProductSu productsu = new ProductSu();
    IProductSuManager productsuMgr = ProductSuPeer.getInstance();
    productsu = productsuMgr.getByIdproduct(id);

    String supplierid = Integer.toString(productsu.getSupplierID());
    String productname = productsu.getProductName();
    String safestock = Integer.toString(productsu.getSafeStock());
    Timestamp lastpurchasedate = productsu.getLastPurchaseDate();
    Timestamp lastdeliverydate = productsu.getLastDeliveryDate();
    String quantity = Integer.toString(productsu.getQuantity());
    String maxpicture = productsu.getMaxPicture();
    String minpicture = productsu.getMinPicture();
    String specificpicture = productsu.getSpecificPicture();
    String picture = productsu.getPicture();
    String titlepicture = productsu.getTitlePicture();
    String borntitlepicture = productsu.getBornTitlePicture();
%>
<HTML>
<HEAD><TITLE>liu lan</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<CENTER>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=497
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR>
            <TD width=493 bgColor=#33ccff colSpan=2 height=32>
                <P align=center>��Ʒ��Ϣ</P></TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>��Ʒ��ţ�</TD>
            <TD align=left width=378 height=32>&nbsp;<%=id%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>�����̱�ţ�</TD>
            <TD align=left width=378 height=32>&nbsp;<%=supplierid == null ? "--" : supplierid%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>��Ʒ���ƣ�</TD>
            <TD align=left width=378 height=32>&nbsp;<%=productname == null ? "--" : productname%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>��ȫ������</TD>
            <TD align=left width=378 height=32>&nbsp;<%=safestock == null ? "--" : safestock%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>����������ڣ�</TD>
            <TD align=left width=378 height=32>&nbsp;<%=lastpurchasedate.toString().substring(0, 10)%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>����������ڣ�</TD>
            <TD align=left width=378 height=32>&nbsp;<%=lastdeliverydate.toString().substring(0,10)%>
        </TR>
        <TR>
            <TD align=right width=113 height=32>�������</TD>
            <TD align=left width=378 height=32>&nbsp;<%=quantity == null ? "--" : quantity%>
            </TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>��ͼƬ��</TD>
            <TD align=left width=378 height=32>&nbsp;<% if (maxpicture != null) { %>
                <img src="<%="../../../"+"productpic" + "\\" +maxpicture%>" height="25" width="50"><% } else { %>
                --<% } %></TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>СͼƬ��</TD>
            <TD align=left width=378 height=32>&nbsp;<% if (minpicture != null) { %>
                <img src="<%="../../../"+"productpic" + "\\" +minpicture%>" height="25" width="50"><% } else { %>
                --<% } %></TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>��Чͼ��</TD>
            <TD align=left width=378 height=32>&nbsp;<% if (specificpicture != null) { %>
                <img src="<%="../../../"+"productpic" + "\\" +specificpicture%>" height="25" width="50"><% } else { %>
                --<% } %></TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>ԭͼ��</TD>
            <TD align=left width=378 height=32>&nbsp;<% if (picture != null) { %>
                <img src="<%="../../../"+"productpic" + "\\" +picture%>" height="25" width="50"><% } else { %>
                --<% } %></TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>����ͼ��</TD>
            <TD align=left width=378 height=32>&nbsp;<% if (titlepicture != null) { %>
                <img src="<%="../../../"+"productpic" + "\\" +titlepicture%>" height="25" width="50"><% } else { %>
                --<% } %></TD>
        </TR>
        <TR>
            <TD align=right width=113 height=32>ԭ����ͼ��</TD>
            <TD align=left width=378 height=32>&nbsp;<% if (borntitlepicture != null) { %>
                <img src="<%="../../../"+"productpic" + "\\" +borntitlepicture%>" height="25" width="50"><% } else { %>
                --<% } %></TD>
        </TR>
        </TBODY>
    </TABLE>
</CENTER>
<BR><BR>
<CENTER><INPUT onclick=javascript:history.go(-1); type=button value=" �� �� ">
</CENTER>
</BODY>
</HTML>
