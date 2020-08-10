<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.lang.Math" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.business.Product.IProductManager" %>
<%@ page import="com.bizwink.cms.business.Product.Product" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Product.productPeer" %>
<%@ page import="com.bizwink.webapps.feedback.IFeedbackManager" %>
<%@ page import="com.bizwink.webapps.feedback.FeedbackPeer" %>
<%@ page import="com.bizwink.webapps.register.Uregister" %>
<%@ page import="com.bizwink.webapps.register.IUregisterManager" %>
<%@ page import="com.bizwink.webapps.register.UregisterPeer" %>
<%

    List list = new ArrayList();
    list = (List) session.getAttribute("en_list");
    if (list == null) {
        List glist = new ArrayList();
        list = glist;
        session.setAttribute("en_list", glist);
    }
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    //ͨ��session����û�id
    Uregister username = (Uregister) session.getAttribute("UserLogin");
    int userid = username.getId();

    IOrderManager orderMgr = orderPeer.getInstance();
    String sendwaystr = (String) session.getAttribute("sendway");
    int sendway = 0;
    if (sendwaystr != null) {
        sendway = Integer.parseInt(sendwaystr);
    }
    float totalprice = 0;

    String paystr = (String) session.getAttribute("payway");
    int payway = -1;
    if (paystr != null) {
        payway = Integer.parseInt(paystr);
    }
    String cidstr = (String) session.getAttribute("info");
    int cid = -1;
    if (cidstr != null) {
        cid = Integer.parseInt(cidstr);
    }
    int errcode = -1;
    String outstr = "false";
    String userscores = (String) session.getAttribute("scores");//����û�����ʹ�õĻ���
    //��û��ֶһ�����
    IUregisterManager regMgr = UregisterPeer.getInstance();
    String sitename = request.getServerName();  //site name
    int rules = regMgr.getScoresForMoney(sitename);     //get scores rule
    int uscores = 0;
    if (userscores != null) {
        uscores = Integer.parseInt(userscores);
    }
    int scoresvalue = 0;
    if (rules != 0) scoresvalue = uscores / rules;
    else
        scoresvalue = uscores/10;//���ֵֿ�ֵ
     //����ͻ�ʱ��
    String sendtime = (String)session.getAttribute("sendtime");
    //����ȯ��Ϣ
    String cards = (String)session.getAttribute("card");
    int cardmoney = 0;
    int cardids = 0;
    Card card = orderMgr.getACardInfo(cards);
    if(card != null)
    {
        cardmoney = card.getDenomination();
        cardids = card.getId();
    }
    
    if (cid > 0 && payway > 0 && sendwaystr != null) {
        //����˷�
        int type = sendway;
        Fee fee = new Fee();
        fee = orderMgr.getAFeeInfo(type);
        float sendfee = 0;
        if (fee != null) {
            sendfee = fee.getFee();
        }
        //����ջ�����Ϣ
        AddressInfo addressinfo = new AddressInfo();
        addressinfo = orderMgr.getAAddresInfo(cid);
        String address = addressinfo.getAddress() == null ? "" : StringUtil.gb2iso4View(addressinfo.getAddress());
        String zip = addressinfo.getZip();
        String phone = addressinfo.getPhone() + "," + addressinfo.getMobile();
        String city = addressinfo.getCity() == null ? "" : StringUtil.gb2iso4View(addressinfo.getCity());
        String province = addressinfo.getProvinces() == null ? "" : StringUtil.gb2iso4View(addressinfo.getProvinces());
        String zone = addressinfo.getZone() == null ? "" : StringUtil.gb2iso4View(addressinfo.getZone());
        String name = addressinfo.getName() == null ? "" : StringUtil.gb2iso4View(addressinfo.getName());
        //���ɶ�����
        long oredertime = System.currentTimeMillis();
        String str = String.valueOf(oredertime);
        str = str.substring(6, 13);
        if (str.length() < 7) {
            for (int i = 0; i < (7 - str.length()); i++) {
                str = "1" + str;
            }
        }

        String random = String.valueOf(Math.random());
        random = random.substring(random.indexOf(".") + 1, random.indexOf(".") + 4);
        str = str + random;
        if (str != null) {
            if (str.length() < 10) {
                for (int i = 0; i < (10 - str.length()); i++) {
                    str = "1" + str;
                }
            }
        }
        long orderid = Long.parseLong(str);
        str = String.valueOf(orderid);
        if (str.length() < 10) {
            for (int i = 0; i < (10 - str.length()); i++) {
                str = "1" + str;
            }
        }
        orderid = Long.parseLong(str);


        String buystr = "";
        String pid = "";
        String buynumstr = "";
        int productid = 0;
        int buynum = 0;
        float price = 0;
        String pname = "";

        IProductManager productMgr = productPeer.getInstance();
        Product product = new Product();
        String hostname = "";
        int totalscores = 0;
        for (int i = 0; i < list.size(); i++) {
            buystr = (String) list.get(i);

            if ((buystr != null) && (!buystr.equals("")) && (!buystr.equals("null"))) {
                buystr = buystr.trim();
                //��ƷID
                pid = buystr.substring(0, buystr.indexOf("_"));
                productid = Integer.parseInt(pid);
                //��������
                buynumstr = buystr.substring(buystr.indexOf("_") + 1, buystr.lastIndexOf("_"));
                buynum = Integer.parseInt(buynumstr);
                hostname = buystr.substring(buystr.lastIndexOf("_") + 1, buystr.length());

                product = productMgr.getAProduct(productid);
                price = product.getSalePrice();
                totalprice = totalprice + buynum * price - cardmoney;
                totalscores = totalscores + buynum * product.getScores();
            }
        }
        totalprice = totalprice -  scoresvalue;
        //���վ��id
        IFeedbackManager feedbackMgr = FeedbackPeer.getInstance();
        int siteid = 0;
        siteid = feedbackMgr.getSiteID(hostname);
        if ((startflag == 1) && (list.size() > 0)) {
            //����������������En_orders��
            Order order = new Order();
            order.setOrderid(orderid);
            order.setUserid(userid);
            order.setName(name);
            order.setAddress(address);
            order.setPostcode(zip);
            order.setPhone(phone);
            order.setTotalfee(totalprice);   //��Ʒ�ܽ��
            order.setDeliveryfee(sendfee);    //�˷�
            order.setPayfee(totalprice + sendfee);  //�û�Ӧ���ܶ�
            order.setCreateDate(new Timestamp(System.currentTimeMillis()));
            order.setCity(city);
            order.setProvince(province);
            order.setSendWay(sendway);     //�ͻ���ʽ
            order.setPayWay(payway);        //֧����ʽ
            order.setLinktime(sendtime);    //�ͻ�ʱ��
            order.setZone(zone);
            order.setSiteid(siteid);
            order.setUserscores(uscores);
            order.setOrderscores(totalscores);
            order.setUsecard(cardmoney);

            List order_detail = new ArrayList();
            for (int j = 0; j < list.size(); j++) {
                buystr = (String) list.get(j);

                if ((buystr != null) && (!buystr.equals("")) && (!buystr.equals("null"))) {
                    buystr = buystr.trim();
                    //��ƷID
                    pid = buystr.substring(0, buystr.indexOf("_"));
                    productid = Integer.parseInt(pid);
                    //��Ʒ����
                    product = productMgr.getAProduct(productid);
                    pname = product.getMainTitle() == null ? "" : StringUtil.gb2iso4View(product.getMainTitle());
                    //��������
                    buynumstr = buystr.substring(buystr.indexOf("_") + 1, buystr.lastIndexOf("_"));
                    buynum = Integer.parseInt(buynumstr);
                    //��Ʒ�۸�
                    price = product.getSalePrice();
                    //������En_orders_deail��
                    //ʹ�ù���ȯ��Ϣ

                    Order orders = new Order();
                    orders.setOrderid(orderid);
                    orders.setProductid(productid);
                    orders.setSupplierid(product.getSiteID());
                    orders.setSuppliername(product.getSuppliername());
                    orders.setOrderNum(buynum);
                    orders.setSaleprice(price);
                    orders.setProductname(pname);
                    orders.setCardid(0);    //����ȯid
                    order_detail.add(orders);

                    //��鵱ǰ��Ʒ�Ƿ��и�����Ʒ������и�����Ʒ����������Ʒ���붩����ϸ��Ϣ��

                    //���Ŀ��,�����Ҫ�޸Ŀ��,���ڴ˴����÷���.
                    //��չ���ȯsession
                    session.setAttribute(String.valueOf(productid), null);

                }


            }
            //���session�б���ķ�Ʊ��Ϣ
    Invoice invoice = (Invoice) session.getAttribute("invoiceinfo");
            //���÷�Ʊ��Ϣ
            invoice.setUserid(userid);
            invoice.setSiteid(siteid);
            invoice.setOrderid(orderid);
            errcode = orderMgr.createOrderInfo(order, order_detail,invoice);
            if(errcode == 0)
            {
                  //�����û�ʹ�û���
                  if(uscores > 0){
                        IUregisterManager uregMgr = UregisterPeer.getInstance();
                      uregMgr.updateUserScores(uscores,userid);
                  }
                //���¹���ȯ��Ϣ
                orderMgr.updateCardIscheck(cardids,1);
                //����֧����Ҫ�Ķ�����
                session.setAttribute("orderids",String.valueOf(orderid));
            }
        }

        //�����ɺ����session
        List buylist = new ArrayList();
        session.setAttribute("en_list", buylist);
        session.removeAttribute("en_sell_list");
        session.setAttribute("en_totalprice", "0.00");
        session.removeAttribute("sendway");
        session.removeAttribute("payway");
        session.removeAttribute("info");
        session.removeAttribute("scores");
        session.removeAttribute("sendtime");
        session.removeAttribute("invoiceinfo");
        session.removeAttribute("card");

        if (errcode == 0) {
            outstr = "<orderid>" + String.valueOf(orderid) + "</orderid>";
        }
    }
    out.write(outstr);

%>