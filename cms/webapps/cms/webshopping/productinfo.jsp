<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@ page import="com.bizwink.cms.business.Order.Fee" %>
<%@ page import="com.bizwink.cms.business.Product.IProductManager" %>
<%@ page import="com.bizwink.cms.business.Product.Product" %>
<%@ page import="com.bizwink.cms.business.Product.productPeer" %>
<%@ page contentType="text/html;charset=GBK" %>
<%

    List list = (List) session.getAttribute("en_list");
    if ((list == null) || (list.size() < 1)) {
        response.sendRedirect("shopping.shtml");
        return;
    }
    IOrderManager orderMgr = orderPeer.getInstance();
    double result = 0;
    float totalprice = 0;
    int info = ParamUtil.getIntParameter(request, "info", -1);
    String sendway = (String) session.getAttribute("sendway");

    int type = 0;
    if (sendway != null) {
        type = Integer.parseInt(sendway);
    }
    Fee fee = new Fee();
    fee = orderMgr.getAFeeInfo(type);
    float sendfee = 0;
    if(fee != null){
        sendfee = fee.getFee();
    }

    NumberFormat nformat = NumberFormat.getCurrencyInstance(Locale.CHINA);
    String prename = "";
    String buystr = "";
    String bgcolor = "";
    String pid = "";
    String buynumstr = "";
    int productid = 0;
    int buynum = 0;
    int t_buynum = 0;
    String typestr = "";
    int totalnum= 0;
    String productname = "";
    float weight = 0;
    float price = 0;
    float saleprice = 0;
    int stocknum = 0;
    float totalweight = 0;
    float t_totalprice = 0;
    float tsaleprice = 0;
    float allprice = 0;
    float t_allprice = 0;
    float allweight = 0;
    float t_saleprice = 0;
    String producttype = "";
    int columnid = 0;

    IProductManager productMgr = productPeer.getInstance();
    Product product = new Product();

    String trstr = "";

    for (int i = 0; i < list.size(); i++) {
        totalnum = i+1;
        buystr = (String) list.get(i);

        if ((buystr != null) && (!buystr.equals("")) && (!buystr.equals("null"))) {
            buystr = buystr.trim();
            pid = buystr.substring(0, buystr.indexOf("_"));
            buynumstr = buystr.substring(buystr.indexOf("_") + 1, buystr.lastIndexOf("_"));
            typestr = buystr.substring(buystr.lastIndexOf("_") + 1, buystr.length());
            productid = Integer.parseInt(pid);
            buynum = Integer.parseInt(buynumstr);
            t_buynum += buynum;

            product = productMgr.getAProduct(productid);
            columnid = product.getColumnID();
            productname = product.getMainTitle();
            price = product.getMarketPrice();
            saleprice = product.getSalePrice();
            stocknum = product.getStockNum();
            totalweight = buynum * weight;
            totalprice = buynum * price;
            tsaleprice = buynum * saleprice;
            t_totalprice += totalprice;
            allprice = allprice + totalprice;
            //t_allprice += allprice;
            t_saleprice += tsaleprice;
            allweight = allweight + totalweight;

                producttype = productname;
        }
        weight = weight / 1000;
        totalweight = totalweight / 1000;


        trstr = trstr + "      <tr>\n" +
                "        <td height=\"39\" valign=\"middle\" style=\"border-bottom:#BCBCBC 1px dotted;\n" +
                "   color:#61749F; padding-left:20px;\">" + (i + 1) + "</td>\n" +
                "        <td height=\"39\" valign=\"middle\" style=\"border-bottom:#BCBCBC 1px dotted;\n" +
                "   color:#61749F; padding-left:20px;\">" + producttype + "</td>\n" +
                "        <td align=\"center\" valign=\"middle\" style=\"color:#FD7E01;border-bottom:#BCBCBC 1px dotted;\"><span class=\"STYLE5\">" + nformat.format(price) + "</span></td>\n" +
                "        <td align=\"center\"  valign=\"middle\" style=\"color:#333333;border-bottom:#BCBCBC 1px dotted;\"><span style=\"color:#FD7E01\">" + nformat.format(saleprice) + "</span></td>\n" +
                "        <td align=\"center\" style=\"color:#333333;border-bottom:#BCBCBC 1px dotted;\">" + buynum + "</td>\n" +
                "        <td align=\"center\" style=\"color:#333333;border-bottom:#BCBCBC 1px dotted;\"><span style=\"color:#FD7E01;\">" + nformat.format(tsaleprice) + "</span></td>\n" +
                "      </tr>\n";
    }


    //���㸽�ӷ����ܺ�
    DecimalFormat df = new DecimalFormat("0.00");

    //����ת��������
    double tol2 = allprice;
    double commissioncharge = 0;//commissioncharge = tol2*shouxin/100.0;

    tol2 = tol2 + commissioncharge;
    tol2 = Double.parseDouble(df.format(tol2));
    //double result = ((int)(tol2*10))/10.0;
    result = t_saleprice + sendfee;

    //session.setAttribute("en_allprice", String.valueOf(result));
    session.setAttribute("en_allprice", String.valueOf(result));

    String outstr = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size:12px\">\n" +
            "      <!--DWLayoutTable-->\n" +
            "      <tr>\n" +
            "    <td width=\"100\" height=\"27\" valign=\"top\" class=\"style1\">��Ʒ�嵥</td>\n" +
            "    <td  height=\"27\">&nbsp;</td>\n" +
            "    <td colspan=\"4\" align=\"right\" valign=\"top\"><a href=\"shopping.shtml\">�ص����ﳵ��ɾ���������Ʒ</a></td>\n" +
            "    <td>&nbsp;</td>\n" +
            "  </tr>\n" +
            "      <tr>\n" +
            "        <td width=\"60\" height=\"41\" align=\"center\" valign=\"middle\" style=\"background:#F1F1F1; color:#3F3F3F; \"><div align=\"center\">���</div></td>\n" +
            "        <td width=\"295\" height=\"41\" valign=\"middle\" style=\"background:#F1F1F1; color:#3F3F3F; padding-left:20px;\">��Ʒ��</td>\n" +
            "        <td width=\"82\" align=\"center\" valign=\"middle\" style=\"background:#F1F1F1; color:#3F3F3F; \">�г����ۼ�</td>\n" +
            "        <td width=\"78\" align=\"center\" valign=\"middle\" style=\"background:#F1F1F1; color:#3F3F3F;\">��Ա��</td>\n" +
            "        <td align=\"center\"  valign=\"middle\" style=\"background:#F1F1F1; color:#3F3F3F;;\">����</td>\n" +
            "        <td align=\"center\"  valign=\"middle\" style=\"background:#F1F1F1; color:#3F3F3F;;\">ʵ�ʸ���</td>\n" +
            "      </tr>\n" + trstr +
            "      <tr>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;color:#61749F;\">*</td>\n" +
            "   <td height=\"40\" align=\"left\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;color:#61749F;\"><span class=\"STYLE5\">�� <span class=\"STYLE5\">��Ʒ�ܼ�</span></span></td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   color:#61749F;\"><span class=\"STYLE5\"><span class=\"STYLE5\">" + nformat.format(t_totalprice) + "</span></span> </td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   color:#61749F;\"><span class=\"STYLE5\"><span class=\"STYLE5\">" + nformat.format(t_saleprice) + "</span></span></td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   color:#61749F;\"><span class=\"STYLE5\"><span class=\"STYLE5\">" + t_buynum + "</span></span></td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" class=\"STYLE5\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><span class=\"STYLE5\">" + nformat.format(t_saleprice) + "</span></td>\n" +
            "      </tr>\n" +
            "      <tr>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   color:#61749F;\"><span class=\"STYLE5\">*</span></td>\n" +
            "        <td height=\"40\" align=\"left\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   color:#61749F;\">�� <span class=\"STYLE5\"><span class=\"STYLE5\">�� ���ͷ�</span></span></td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \">&nbsp;</td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
            "        <td height=\"40\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><span class=\"STYLE5\">" + nformat.format(sendfee) + "</span></td>\n" +
            "      </tr>\n" +
            "      <tr>\n" +
            "        <td height=\"38\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><span class=\"STYLE5\">*</span></td>\n" +
            "        <td height=\"38\" align=\"left\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \">�� <span class=\"STYLE5\">�����ܶ�</span></td>\n" +
            "        <td height=\"38\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
            "        <td height=\"38\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
            "        <td height=\"38\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
            "        <td height=\"38\" align=\"center\" valign=\"middle\" bgcolor=\"#F6F6F6\" style=\"border-bottom:#AFAFAF 1px solid;\n" +
            "   \"><span class=\"STYLE5\" id=\"Results\">" + nformat.format(Double.parseDouble((df.format(result)))) + "</span></td>\n" +
            "      </tr>\n" +
            "        <tr>\n" +
            "    <td height=\"42\">&nbsp;</td>\n" +
            "    <td width=\"300\" colspan=\"4\" align=\"right\" valign=\"top\">��˶�������Ϣ������ύ����</td>\n" +
            "    <td align=\"center\" valign=\"top\"><input type=\"button\" id=\"newtj\" value=\"�ύ����\" onClick='javascript:getval();'/></td>\n" +
            "    <td>&nbsp;</td>\n" +
            "  </tr>\n" +
            "      \n" +
            "      <!--DWLayoutTable-->\n" +
            "    </table>";
    out.print(outstr);
%>