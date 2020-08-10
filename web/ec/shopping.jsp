<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.bizwink.mysql.service.MArticleService" %>
<%@ page import="com.bizwink.mysql.vo.ArticleAndExtendAttrs" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.bizwink.mysql.service.MUsersService" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.mysql.po.*" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    String referer_usr = request.getHeader("referer");
    if (authToken==null) {
        response.sendRedirect("/users/m/login.jsp?errcode=-1&r=" + URLEncoder.encode(referer_usr,"utf-8"));   //错误码为-1表示用户需要登录系统才能进行后续操作
        return;
    }

    int userid = authToken.getUid();
    String username = authToken.getUserid();
    String realname = authToken.getUsername();
    int siteid = authToken.getSiteid();
    Users user = null;
    int articleid = ParamUtil.getIntParameter(request, "prodid", 0);
    float yprice = 0.00f;                   //年订阅价格
    float gzhyprice = 0.00f;                //公众号扫码订报的年度价格
    float vipy = 0.00f;                     //年订阅优惠价
    float byprice = 0.00f;                  //半年订阅价格
    float vipby = 0.00f;                    //半年订阅优惠价
    float qprice = 0.00f;                   //季度订阅价格
    float vipq = 0.00f;                     //季度订阅优惠价
    float mprice = 0.00f;                   //月度订阅价格
    float vipm = 0.00f;                     //月度订阅优惠价
    float gprice = 0.00f;                   //订阅单价
    float vipgprice = 0.00f;                //订阅单价优惠价
    int subscribetype = 1;                  //订阅类型，1整订 2破头订阅 3破尾订阅 4破头破尾订阅
    int tqdays = 0;                         //提前预定天数
    int vipmonths = 0;                      //优惠月数
    int across_year_flag = 0;               //年订是否允许跨年
    int across_half_year_flag = 0;          //是否可跨越自然半年订阅，1自然半年，既1月1号开始或者7月1号开始，2可跨越自然半年，任何一个月的1号向后6个月即为半年
    int across_q_flag = 0;                  //是否可以跨越自然季度订阅，1自然季度，既1月1号，4月1号，7月1号，10月1号开始的季度，2可跨越自然季度，既任何一个月的1号开始向后3个月为一个季度
    String vip_dy_startdate = null;         //优惠订阅开始时间
    String vip_dy_enddate = null;           //优惠订阅结束时间

    ApplicationContext appContext = SpringInit.getApplicationContext();
    ArticleAndExtendAttrs articleAndExtendAttrs = null;
    if (appContext!=null) {
        boolean doCreate = ParamUtil.getBooleanParameter(request,"doCreate");
        MArticleService mArticleService = (MArticleService)appContext.getBean("MArticleService");
        if (!doCreate) {
            articleAndExtendAttrs = mArticleService.getArticleAndEXtendAttrs(articleid);
            if (articleAndExtendAttrs == null) {
                response.sendRedirect("/users/m/error.jsp");
                return;
            }else {
                List<ArticleExtendattr> articleExtendattrs = articleAndExtendAttrs.getArticleExtendattrs();
                for(int ii=0; ii<articleExtendattrs.size(); ii++) {
                    ArticleExtendattr extendattr = articleExtendattrs.get(ii);
                    String ename = extendattr.getEname();
                    if (ename.equalsIgnoreCase("_yprice")) {
                        yprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_saomayprice")) {
                        gzhyprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_vipyprice")) {
                        vipy = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_hyprice")) {
                        byprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_viphyprice")) {
                        vipby = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_mprice")) {
                        mprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_vipmprice")) {
                        vipm = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_jdprice")) {
                        qprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_vipqdprice")) {
                        vipq = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_gprice")) {
                        gprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_vipgprice")) {
                        vipgprice = extendattr.getFloatvalue().floatValue();
                    }
                    if (ename.equalsIgnoreCase("_subscribetype")) {
                        subscribetype = extendattr.getNumericvalue();
                    }
                    if (ename.trim().equalsIgnoreCase("_presubscribeday")) {
                        tqdays = Integer.parseInt(extendattr.getStringvalue());
                    }
                    if (ename.equalsIgnoreCase("_vipmonth")) {
                        vipmonths = extendattr.getNumericvalue();
                    }
                    if (ename.equalsIgnoreCase("_acrossyear")) {
                        across_year_flag = extendattr.getNumericvalue();
                    }
                    if (ename.equalsIgnoreCase("_acrosshalfyear")) {
                        across_half_year_flag = extendattr.getNumericvalue();
                    }
                    if (ename.equalsIgnoreCase("_acrossq")) {
                        across_q_flag = extendattr.getNumericvalue();
                    }
                    if (ename.equalsIgnoreCase("_vipstartdate")) {
                        vip_dy_startdate = extendattr.getStringvalue();
                    }
                    if (ename.equalsIgnoreCase("_vipendtime")) {
                        vip_dy_enddate = extendattr.getStringvalue();
                    }
                }
            }
        } else {
            //创建订单
            int bznum = ParamUtil.getIntParameter(request, "numbercopy", 0);
            String beginDate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "begindate"));
            String bzname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "bzname"));
            yprice = ParamUtil.getFloatParameter(request,"yprice",0);
            gzhyprice = ParamUtil.getFloatParameter(request,"gzhyprice",0);
            vipy = ParamUtil.getFloatParameter(request,"vipy",0);
            byprice = ParamUtil.getFloatParameter(request,"byprice",0);
            vipby = ParamUtil.getFloatParameter(request,"vipby",0);
            qprice = ParamUtil.getFloatParameter(request,"qprice",0);
            vipq = ParamUtil.getFloatParameter(request,"vipq",0);
            mprice = ParamUtil.getFloatParameter(request,"mprice",0);
            vipm = ParamUtil.getFloatParameter(request,"vipm",0);
            tqdays= ParamUtil.getIntParameter(request, "tqdays", 0);                                         //提前预定天数
            vipmonths= ParamUtil.getIntParameter(request, "vipmonths", 0);                                  //优惠月数
            gprice = ParamUtil.getFloatParameter(request, "gprice", 0);
            vipgprice = ParamUtil.getFloatParameter(request, "vipgprice", 0);
            across_year_flag= ParamUtil.getIntParameter(request,"acrossyearflag",0);                     //年订是否允许跨年年订
            across_half_year_flag= ParamUtil.getIntParameter(request,"acrosshalfyearflag",0);           //半年订是否允许跨自然半年
            across_q_flag= ParamUtil.getIntParameter(request,"acrossqflag",0);                           //季度订是否允许跨自然季度
            int subscribe = ParamUtil.getIntParameter(request,"subscribe",0);                            //1年订，2半年订 3季度定 4月订
            subscribetype= ParamUtil.getIntParameter(request,"subscribetype",0);                         //1整订，2破头订，3破尾订，4破头破尾订
            int dyqnum = ParamUtil.getIntParameter(request,"dyqnum",0);                                  //按季度订阅，用户输入订阅的季度数
            int dymnum = ParamUtil.getIntParameter(request,"dymnum",0);                                  //按月度订阅，用户输入的订阅月度数
            vip_dy_startdate = ParamUtil.getParameter(request,"vipdystartdate");
            vip_dy_enddate = ParamUtil.getParameter(request,"vipdyenddate");
            SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
            Date bdate = format.parse(beginDate);
            Calendar b_calender = Calendar.getInstance();
            b_calender.setTime(bdate);
            Date edate = null;
            Calendar e_calender = Calendar.getInstance();

            //计算结束预定的时间
            if (subscribe==1)  {                 //年订
                e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                e_calender.add(Calendar.YEAR ,1);
                e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
            } else if (subscribe==2) {          //半年订
                e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                e_calender.add(Calendar.MONTH, 6);
                e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
            } else if (subscribe==3) {          //季订
                e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                e_calender.add(Calendar.MONTH ,3*dyqnum);
                e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
            } else if (subscribe==4) {          //月订
                e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                e_calender.add(Calendar.MONTH ,1*dymnum);
                e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
            }

            System.out.println(b_calender.get(Calendar.YEAR) + "===" + (b_calender.get(Calendar.MONTH) + 1) + "==" + b_calender.get(Calendar.DAY_OF_MONTH));
            System.out.println(e_calender.get(Calendar.YEAR) + "===" + (e_calender.get(Calendar.MONTH) + 1) + "==" + e_calender.get(Calendar.DAY_OF_MONTH));


            MUsersService mUsersService = (MUsersService)appContext.getBean("MUsersService");
            user = mUsersService.getUserinfoByUserid(username);
            if (user==null) {
                response.sendRedirect("/users/m/error.jsp");
                return;
            }

            //生成定单号;
            Timestamp oredertime = new Timestamp(System.currentTimeMillis());
            String str = String.valueOf(oredertime);
            String ostr = "8";
            ostr = ostr + str.substring(2, 4) + str.substring(5, 7) + str.substring(8, 10);
            String random = String.valueOf(Math.random());
            random = random.substring(random.indexOf(".") + 1, random.indexOf(".") + 7);
            ostr = ostr + random;
            long orderid = Long.parseLong(ostr);

            //发票信息
            int invoicetype = ParamUtil.getIntParameter(request,"invoicetype",0);
            int gmftype = ParamUtil.getIntParameter(request,"gmftype",0);
            String gmfname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "gmfname"));
            String gmftaxnum = filter.excludeHTMLCode(ParamUtil.getParameter(request, "gmftaxnum"));
            String gmfaddress = filter.excludeHTMLCode(ParamUtil.getParameter(request, "gmfaddress"));
            String gmfphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "gmfphone"));
            String gmfbankname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "gmfbankname"));
            String gmfaccount = filter.excludeHTMLCode(ParamUtil.getParameter(request, "gmfaccount"));
            String gmfpemail = filter.excludeHTMLCode(ParamUtil.getParameter(request, "fpemail"));
            String content = filter.excludeHTMLCode(ParamUtil.getParameter(request, "content"));

            //订阅优惠开始时间日历
            Date vipdystartdate = format.parse(vip_dy_startdate);
            Calendar vip_dy_start_cal = Calendar.getInstance();
            vip_dy_start_cal.setTime(vipdystartdate);
            vip_dy_start_cal.add(Calendar.DAY_OF_MONTH, -1);       //在数据库设置的是优惠开始时间，使用日历的after函数需要将开始时间提前一天

            //订阅优惠结束时间日历
            Date vipdyenddate = format.parse(vip_dy_enddate);
            Calendar vip_dy_end_cal = Calendar.getInstance();
            vip_dy_end_cal.setTime(vipdyenddate);
            vip_dy_end_cal.add(Calendar.DAY_OF_MONTH, 1);      //在数据库设置的优惠结束时间是优惠的最后一天，使用日历的befer函数需要将结束时间后置一天

            //用户执行订阅操作日历
            Calendar now  = Calendar.getInstance();
            now.setTime(new Timestamp(System.currentTimeMillis()));

            OrderDetail orderDetail = new OrderDetail();
            //计算订报消费费用
            float fee = 0.00f;
            String unit = null;
            int subscribenum = 0;
            if (subscribe==1) {
                //公众号扫码订报
                //if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)){
                //    System.out.println("计算年度优惠价");
                //    fee = gzhyprice*bznum;
                //}
                //网站订报
                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)){
                    System.out.println("计算年度优惠价");
                    fee = vipy*bznum;
                }else
                    fee = yprice*bznum;
                unit = "年";
                subscribenum = 1;
            } else if (subscribe==2) {
                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                    System.out.println("计算半年度优惠价");
                    fee = vipby*bznum;
                } else
                    fee = byprice*bznum;
                unit = "半年";
                subscribenum = 1;
            } else if (subscribe==3){
                //将订阅的季度数换算成订阅的月份数
                /*int total_dymnum = dyqnum*3;
                if (total_dymnum>=12) {             //订阅季度数换算成订阅月数，如果超过12个月，按照月度优惠价乘订阅的总月数计算订阅费用
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        System.out.println("计算季度优惠价");
                        fee = (vipy/12)*dyqnum*3*bznum;
                    } else
                        fee = (yprice/12)*dyqnum*3*bznum;
                } else {
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        System.out.println("计算季度优惠价");
                        fee = dyqnum * vipq * bznum;
                    } else
                        fee = dyqnum * qprice * bznum;
                }*/

                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                    System.out.println("计算季度优惠价");
                    fee = dyqnum * vipq * bznum;
                } else
                    fee = dyqnum * qprice * bznum;
                unit = "季度";
                subscribenum = dyqnum;
            } else if (subscribe==4) {
                if (dymnum>=12) {                      //订阅月数如果超过12个月，优惠期内按照整年月度优惠价乘订阅的总月数计算订阅费用
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        System.out.println("大于12个月按年度优惠价计算月度优惠价");
                        fee = (vipy/12)*dymnum*bznum;
                    }else
                        fee = (yprice/12)*dymnum*bznum;
                } else if (dymnum>=6 && dymnum<12){   //订阅月数如果超过6个月,不满12个月，优惠期内按照半年月度优惠价乘订阅的总月数计算订阅费用
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        System.out.println("大于6个月按半年度优惠价计算月度优惠价");
                        fee = dymnum*(vipby/6)*bznum;
                    }else
                        fee = dymnum*(byprice/6)*bznum;
                } else if (dymnum>=3 && dymnum<6){    //订阅月数如果超过3个月，不满6个月，优惠期内按照季度月度优惠价乘订阅的总月数计算订阅费用
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        System.out.println("大于3个月按季度优惠价计算月度优惠价");
                        fee = dymnum*(vipq/3)*bznum;
                    } else
                        fee = dymnum*(qprice/3)*bznum;
                } else {                              //订阅月数如果不超过3个月，优惠期内按照月度优惠价乘订阅的总月数计算订阅费用
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        System.out.println("小于3个月按月度优惠价计算月度优惠价");
                        fee = dymnum*vipm*bznum;
                    } else
                        fee = dymnum*mprice*bznum;
                }
                unit = "月";
                subscribenum = dymnum;
            }

            Timestamp createdate = new Timestamp(System.currentTimeMillis());
            Orders order = new Orders();
            order.setORDERID(orderid);
            order.setUSERID(userid);
            order.setSITEID(siteid);
            order.setNAME(username);
            order.setNotes(realname);
            order.setPHONE(user.getMphone());
            order.setADDRESS(user.getAddress());
            order.setCREATEDATE(createdate);
            order.setInitorderid(0);
            order.setPAYFEE((double)fee);
            order.setTOTALFEE((double)fee);
            order.setSTATUS(7);                             //7表示用户位付款，8表示已经付款，9表示超过24小时位付款，取消付款资格
            order.setNOUSE(1);
            order.setFlag((short)1);                      //flag等于1表示是网站订单，flag等于0表示微信公众号扫码订报订单
            order.setPayflag((short)0);
            order.setPayway(0);                           //0微信 1支付宝 2银行支付 3货到付款
            order.setNeed_invoice(invoicetype);
            order.setVALID(0);

            orderDetail.setORDERID(orderid);
            orderDetail.setPRODUCTID(articleid);
            orderDetail.setProductname(bzname);
            orderDetail.setSupplierid(0);
            orderDetail.setCardid(0);
            orderDetail.setORDERNUM(bznum);
            if (subscribe == 1) {
                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal))
                    orderDetail.setSALEPRICE((double)vipy);
                else
                    orderDetail.setSALEPRICE((double) yprice);
            } else if (subscribe == 2) {
                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal))
                    orderDetail.setSALEPRICE((double)vipby);
                else
                    orderDetail.setSALEPRICE((double) byprice);
            } else if (subscribe == 3) {
                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal))
                    orderDetail.setSALEPRICE((double)vipq);
                else
                    orderDetail.setSALEPRICE((double) qprice);
            } else if (subscribe == 4) {
                if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                    if(dymnum<3) {
                        orderDetail.setSALEPRICE((double)vipm);
                    } else if (dymnum>=3 && dymnum<6) {
                        orderDetail.setSALEPRICE(vipq/3.0);
                        System.out.println("季度优惠平均月价：" + orderDetail.getSALEPRICE());
                    } else if (dymnum>=6 && dymnum<12) {
                        orderDetail.setSALEPRICE(vipby/6.0);
                        System.out.println("半年度优惠平均月价：" + orderDetail.getSALEPRICE());
                    } else if (dymnum>=12) {
                        orderDetail.setSALEPRICE(vipy/12.0);
                        System.out.println("年度优惠平均月价：" + orderDetail.getSALEPRICE());
                    }
                } else
                    orderDetail.setSALEPRICE((double)mprice);
            }
            orderDetail.setUnit(unit);
            orderDetail.setSubscribenum(subscribenum);
            orderDetail.setSubscribe(subscribe);
            orderDetail.setUserinstarttime(bdate);
            orderDetail.setUserinendtime(edate);
            orderDetail.setServicestarttime(b_calender.getTime());
            orderDetail.setServiceendtime(e_calender.getTime());
            orderDetail.setCREATEDATE(createdate);

            //送货地址信息
            String name = filter.excludeHTMLCode(ParamUtil.getParameter(request,"name"));
            String telephone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "telephone"));
            String phone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "phone"));
            String address = filter.excludeHTMLCode(ParamUtil.getParameter(request, "address"));
            String postcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "postcode"));
            String beizhu = filter.excludeHTMLCode(ParamUtil.getParameter(request, "notes"));

            Addressinfofororder addressinfo = new Addressinfofororder();
            addressinfo.setName(name);
            addressinfo.setUserid(authToken.getUid());
            addressinfo.setORDERID(orderid);
            addressinfo.setAddress(address);
            addressinfo.setPhone(telephone);
            addressinfo.setMobile(phone);
            addressinfo.setZip(postcode);
            addressinfo.setNotes(beizhu);
            addressinfo.setCreatedate(createdate);


            Invoiceinfofororder invoiceinfo = new Invoiceinfofororder();
            Invoicecontentfororder invoicecontent = new Invoicecontentfororder();
            if (invoicetype != 0) {
                invoiceinfo.setPhone(gmfphone);
                invoiceinfo.setOrderid(orderid);
                invoiceinfo.setUserid(user.getId());
                invoiceinfo.setCompanyname(gmfname);
                invoiceinfo.setRegisteraddress(gmfaddress);
                invoiceinfo.setIdentification(gmftaxnum);
                invoiceinfo.setBankaccount(gmfaccount);
                invoiceinfo.setBankname(gmfbankname);
                invoiceinfo.setInvoicetype(invoicetype);
                invoiceinfo.setTitle(gmftype);
                invoiceinfo.setEmail(gmfpemail);
                invoiceinfo.setCreatedate(createdate);

                invoicecontent.setContent(content);
                invoicecontent.setOrderid(orderid);
                invoicecontent.setNum(bznum);
                invoicecontent.setUnit(unit);
                invoicecontent.setNum(subscribenum);
                if (subscribe == 1) {
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal))
                        invoicecontent.setDanprice(vipy);
                    else
                        invoicecontent.setDanprice(yprice);
                } else if (subscribe == 2) {
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal))
                        invoicecontent.setDanprice(vipby);
                    else
                        invoicecontent.setDanprice(byprice);
                } else if (subscribe == 3) {
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal))
                        invoicecontent.setDanprice(vipq);
                    else
                        invoicecontent.setDanprice(qprice);
                } else if (subscribe == 4) {
                    if(now.after(vip_dy_start_cal) && now.before(vip_dy_end_cal)) {
                        if(dymnum<3) {
                            invoicecontent.setDanprice(vipm);
                        } else if (dymnum>=3 && dymnum<6) {
                            invoicecontent.setDanprice(vipq/3.0f);
                            System.out.println("季度优惠平均月价：" + orderDetail.getSALEPRICE());
                        } else if (dymnum>=6 && dymnum<12) {
                            invoicecontent.setDanprice(vipby/6.0f);
                            System.out.println("半年度优惠平均月价：" + orderDetail.getSALEPRICE());
                        } else if (dymnum>=12) {
                            invoicecontent.setDanprice(vipy/12.0f);
                            System.out.println("年度优惠平均月价：" + orderDetail.getSALEPRICE());
                        }
                    } else
                        invoicecontent.setDanprice(mprice);
                }
                invoicecontent.setCreatedate(createdate);
            }

            System.out.println("发票信息设置完毕");


            MEcService mEcService = (MEcService)appContext.getBean("MEcService");
            int retcode = mEcService.saveOrder(order,orderDetail,invoiceinfo,invoicecontent,addressinfo);

            String md5_source = "/ec/m/orders.jsp?orderid=" + orderid;
            Timestamp thetime = new Timestamp(System.currentTimeMillis());
            String checkcode =Encrypt.md5(md5_source.getBytes());
            response.sendRedirect("/ec/m/orders.jsp?orderid=" + orderid + "&checkcode=" + checkcode + "&thetime=" + thetime.getTime());
            return;
        }
    } else {
        response.sendRedirect("/users/m/error.jsp");
        return;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>京报发行网--订阅报纸</title>
    <link href="/css/base.css" rel="stylesheet" type="text/css" />
    <link href="/css/css_in.css" rel="stylesheet" type="text/css" />
    <link href="/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="/css/jquery.msgbox.css" rel="stylesheet" type="text/css" />
    <style>
        table tr td{padding:12px 8px;}
        body{ font-size:16px; line-height:30px;}
    </style>
    <script language="javascript" type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="/js/users.js"></script>
    <script language="javascript" type="text/javascript" src="/js/jquery-ui.min.js"></script>
    <script src="/js/jquery.dragndrop.min.js" type="text/javascript"></script>
    <script src="/js/jquery.msgbox.min.js" type="text/javascript"></script>
</head>

<body>
<div class="topbox"><%@include file="/inc/top.shtml" %></div>
<div class="main"><%@include file="/inc/menu.shtml" %></div>
<form name="regform" action="shopping.jsp" method="post" onsubmit="return checks(this);">
    <input type="hidden" name="doCreate" value="true">
    <input type="hidden" name="prodid" value="<%=articleid%>">
    <input type="hidden" name="yprice" value="<%=yprice%>">
    <input type="hidden" name="gzhprice" value="<%=gzhyprice%>">
    <input type="hidden" name="byprice" value="<%=byprice%>">
    <input type="hidden" name="qprice" value="<%=qprice%>">
    <input type="hidden" name="mprice" value="<%=mprice%>">
    <input type="hidden" name="vipy" value="<%=vipy%>">
    <input type="hidden" name="vipby" value="<%=vipby%>">
    <input type="hidden" name="vipq" value="<%=vipq%>">
    <input type="hidden" name="vipm" value="<%=vipm%>">
    <input type="hidden" name="bzname" value="<%=articleAndExtendAttrs.getMaintitle()%>">
    <input type="hidden" name="gprice" value="<%=gprice%>">
    <input type="hidden" name="vipgprice" value="<%=vipgprice%>">
    <input type="hidden" name="subscribetype" value="<%=subscribetype%>">
    <input type="hidden" name="tqdays" value="<%=tqdays%>">
    <input type="hidden" name="vipmonths" value="<%=vipmonths%>">
    <input type="hidden" name="vipdystartdate" value="<%=vip_dy_startdate%>">
    <input type="hidden" name="vipdyenddate" value="<%=vip_dy_enddate%>">
    <input type="hidden" name="acrossyearflag" value="<%=across_year_flag%>">
    <input type="hidden" name="acrosshalfyearflag" value="<%=across_half_year_flag%>">
    <input type="hidden" name="acrossqflag" value="<%=across_q_flag%>">
    <table width="1200" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2" style="margin-bottom:0px;">
        <tr>
            <td height="30" colspan="4" align="left" bgcolor="#f6f4f4"> <strong>订报说明</strong></td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#FFFFFF">
                <%@include file="/inc/brief.shtml" %>
                <!--1、报纸投递地址：五环内、回龙观、上地、天通苑、亦庄、各郊区（县）县城。<br />
                2、“年订”指定期为整12个月。例如开始日期为2012年1月1日，截止日期为2012年12月31日；开始日期为2012年1月10日，截止日期为2013年1月9日。<br />
                3、付款成功后，配送人员将与您确认时间，上门送赠品及收订凭证。<br />
                4、咨询电话：58393333（周一至周五，9:00至11:30, 13:00至16:00,节假日除外）。<br />
                5、退订报时，需退回赠品，且退回的赠品不影响再次发放。-->
            </td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#f6f4f4"><strong>订阅方式</strong></td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#ffffff">
                <input type="radio" name="subscribe" id="radio" value="1" checked />             <!--年订-->
                <label for="radio">年订&nbsp;&nbsp;&nbsp;&nbsp;定价：<%=yprice%>元 &nbsp;&nbsp;优惠价：<%=vipy%>元</label><Br/>
                <input type="radio" name="subscribe" id="radio" value="2" />                       <!--半年订-->
                <label for="radio">半年订 定价：<%=byprice%>元 &nbsp;&nbsp;优惠价：<%=vipby%>元</label><Br/>
                <input type="radio" name="subscribe" id="radio" value="3" />                   <!--季订-->
                <label for="radio">季订&nbsp;&nbsp;&nbsp;&nbsp;定价：<%=qprice%>元 &nbsp;&nbsp;优惠价：<%=vipq%>元，请输入订阅季数：<input type="text" class="input_shcar" name="dyqnum" id="qid" value="1" size="3" /></label><Br/>
                <input type="radio" name="subscribe" id="radio" value="4" />                   <!--月订-->
                <label for="radio">月订&nbsp;&nbsp;&nbsp;&nbsp;定价：<%=mprice%>元 &nbsp;&nbsp;优惠价：<%=vipm%>元，请输入订阅月数：<input type="text" class="input_shcar" name="dymnum" id="qid" value="1" size="3" /></label>
            </td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#f6f4f4"><strong>您订阅的是《<%=articleAndExtendAttrs.getMaintitle()==null?"":articleAndExtendAttrs.getMaintitle()%>》</strong></td>
        </tr>
        <tr>
            <td colspan="1" align="right" bgcolor="#ffffff">购买数量：</td>
            <td colspan="3" bgcolor="#ffffff"><input type="text" name="numbercopy" id="numid" class="input_shcar" value="1"/></td>
        </tr>
        <% if (subscribetype==1) {%>
        <tr>
            <td width="202" align="right" bgcolor="#FFFFFF">开始日期：</td>
            <td bgcolor="#FFFFFF" colspan="3">
                <input type="text" name="begindate" id="begindateid" class="input_shcar" onchange="tiaozhengriqi();" value="" readonly="readonly"/>
                <span class="hint_red">*</span></td>
            </td>
            <!--td width="202" align="right" bgcolor="#FFFFFF">结束日期：</td>
            <td bgcolor="#FFFFFF">
                <input type="text" name="enddate" id="enddateid" class="input_shcar" value="" readonly="readonly"/>
            </td-->
        </tr>
        <%}else {%>
        <tr>
            <td width="202" align="right" bgcolor="#FFFFFF">开始日期：</td>
            <td bgcolor="#FFFFFF">
                <input type="text"  name="begindate" id="begindateid" class="input_shcar" onchange="tiaozhengriqi();" value="" readonly="readonly"/>
            </td>
            <td width="202" align="right" bgcolor="#FFFFFF">结束日期：</td>
            <td bgcolor="#FFFFFF">
                <input type="text" name="enddate" id="enddateid" class="input_shcar" value="" readonly="readonly"/>
            </td>
        </tr>
        <%}%>

        <tr>
            <td colspan="4" bgcolor="#f6f4f4"><strong>配送地址及信息</strong></td>
        </tr>
        <tr>
            <td width="202" align="right" bgcolor="#FFFFFF">收报人姓名（单位）：</td>
            <td width="406" bgcolor="#FFFFFF">
                <input name="name" type="text" value="" class="input_shcar" size="35"/>
                <span class="hint_red">*</span>
            </td>
            <td width="168" align="right" bgcolor="#FFFFFF">手机：</td>
            <td width="419" bgcolor="#FFFFFF">
                <input name="phone" type="text" class="input_shcar" value=""/>
                <span class="hint_red">*</span>（手机和固话任填一项）
            </td>
        </tr>
        <tr>
            <td width="202" align="right" bgcolor="#FFFFFF">地址：</td>
            <td width="406" bgcolor="#FFFFFF">
                <input name="address" type="text" class="input_shcar" value="" size="45"/>
                <span class="hint_red">*</span>
            </td>
            <td width="168" align="right" bgcolor="#FFFFFF">固话：</td>
            <td width="419" bgcolor="#FFFFFF">
                <input name="telephone" type="text" class="input_shcar" value="" />
                <span class="hint_red">*</span>（手机和固话任填一项）</td>
        </tr>
        <tr>
            <td width="202" align="right" bgcolor="#FFFFFF">邮编：</td>
            <td width="406" bgcolor="#FFFFFF">
                <input name="postcode" type="text" class="input_shcar" value="" />
                <span class="hint_red">*</span>    </td>
            <td width="168" align="right" bgcolor="#FFFFFF" colspan="2">&nbsp;</td>
            <!--td width="419" bgcolor="#FFFFFF">&nbsp;
                <input name="email" type="text" class="input_shcar" value="" size="30"/>
                <span class="hint_red">*</span></td-->
        </tr>
        <tr>
            <td width="202" align="right" bgcolor="#FFFFFF">备注：</td>
            <td width="1000" bgcolor="#FFFFFF" colspan="3">
                <input name="notes" type="text" class="input_shcar" value="" size="80" maxlength="80"/>（最多80个汉字）
            </td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#f6f4f4"><strong>发票信息</strong></td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#ffffff">
                <input type="radio" name="invoicetype"  value="0" checked onclick="javascript:hideOrShowInvoiceinfo();"/>
                <label for="radio2">不要发票</label>
                <input type="radio" name="invoicetype"  value="2" onclick="javascript:hideOrShowInvoiceinfo();"/>
                <label for="radio2">电子普通发票</label>
                <input type="radio" name="invoicetype"  value="1" onclick="javascript:hideOrShowInvoiceinfo();"/>
                <label for="radio2">电子专项发票</label>
            </td>
        </tr>
    </table>
    <table width="1200" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#e2e2e2"  style="margin-bottom:0px;">
        <tr id="invoice_row1" style="display: none;">
            <td colspan="4" bgcolor="#ffffff">
                <input type="radio" name="gmftype"  value="1" />
                <label for="radio2">公司</label>
                <input type="radio" name="gmftype"  value="0" />
                <label for="radio2">个人</label>
            </td>
        </tr>
        <tr id="invoice_row2" style="display: none;">
            <td width="202" align="right" bgcolor="#FFFFFF">公司名称：</td>
            <td width="406" bgcolor="#FFFFFF">
                <input name="gmfname" type="text" class="input_shcar" value="" size="30"/>
                <span class="hint_red">*</span></td>
            <td width="168" align="right" bgcolor="#FFFFFF">税号：</td>
            <td width="419" bgcolor="#FFFFFF">
                <input name="gmftaxnum" type="text" value="" class="input_shcar"  size="27"/>
                <span class="hint_red">*</span></td>
            </td>
        </tr>
        <tr id="invoice_row4" style="display: none;">
            <td width="202" align="right" bgcolor="#FFFFFF">开户银行：</td>
            <td width="406" bgcolor="#FFFFFF">
                <input name="gmfbankname" type="text" class="input_shcar" size="30" value=""/>
                <span class="hint_red">*</span></td>
            </td>
            <td width="168" align="right" bgcolor="#FFFFFF">账号：</td>
            <td width="419" bgcolor="#FFFFFF">
                <input name="gmfaccount" type="text" class="input_shcar" size="27" value=""/>
                <span class="hint_red">*</span></td>
            </td>
        </tr>
        <tr id="invoice_row3" style="display: none;">
            <td width="202" align="right" bgcolor="#FFFFFF">地址：</td>
            <td width="406" bgcolor="#FFFFFF">
                <input name="gmfaddress" type="text" class="input_shcar" size="50" value=""/>
            <td width="168" align="right" bgcolor="#FFFFFF">联系电话：</td>
            <td width="419" bgcolor="#FFFFFF">
                <input name="gmfphone" type="text" class="input_shcar" value=""  size="27"/>
            </td>
        </tr>
        <tr id="invoice_row5" style="display: none;">
            <td width="202" align="right" bgcolor="#FFFFFF">发票内容：</td>
            <td width="406" bgcolor="#FFFFFF"><input name="content" type="text" class="input_shcar" size="30" value="商品明细" readonly/></td>
            <td width="168" align="right" bgcolor="#FFFFFF">邮箱：</td>
            <td width="419" bgcolor="#FFFFFF">
                <input name="fpemail" type="text" class="input_shcar" value="" size="27"/>
                <span class="hint_red">*</span>（接收电子发票）
            </td>
        </tr>

        <tr>
            <td colspan="4" bgcolor="#f6f4f4"><strong>赠品套餐选择</strong></td>
        </tr>
        <tr>
            <td colspan="4" bgcolor="#ffffff">无套餐</td>
        </tr>
        <tr>
            <td height="100" colspan="4" align="center" bgcolor="#ffffff">
                <!--input type="image" class="submit_btn" name="button" id="button" value="提交订单" /-->
                <input type="submit" class="submit_btn" value="提交订单" />
            </td>
        </tr>
    </table>
</form>
<div class="footbox"><%@include file="/inc/tail.shtml" %></div>
</body>
<script language="javascript">
    $(document).ready(function(){
        $.datepicker.regional['zh-CN'] = {
            clearText: '清除',
            clearStatus: '清除已选日期',
            closeText: '关闭',
            closeStatus: '不改变当前选择',
            prevText: '上月',
            prevStatus: '显示上月',
            prevBigText: 'Prev',
            prevBigStatus: '显示上一年',
            nextText: '下月',
            nextStatus: '显示下月',
            nextBigText: 'Next',
            nextBigStatus: '显示下一年',
            currentText: '今天',
            currentStatus: '显示本月',
            monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
            monthNamesShort: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
            monthStatus: '选择月份',
            yearStatus: '选择年份',
            weekHeader: '周',
            weekStatus: '年内周次',
            dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
            dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
            dayNamesMin: ['日','一','二','三','四','五','六'],
            dayStatus: '设置 DD 为一周起始',
            dateStatus: '选择 m月 d日, DD',
            dateFormat: 'yy-mm-dd',
            firstDay: 1,
            initStatus: '请选择日期',
            isRTL: false};
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);

        $("#begindateid").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true
        });

        $.post("/users/showLoginInfo.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color=\"red\">" + data.username + "</font>&nbsp;&nbsp;<a href='#' onclick=\"javascript:logoff('m');\">退出</a>" + "<a href=\"/users/m/personinfo.jsp\">个人中心</a>");
                    //$("#userInfos").css({color:"red"});
                }
            },
            "json"
        )
    })

    // 对Date的扩展，将 Date 转化为指定格式的String
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    //计算天数差的函数，通用
    function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2002-12-18格式
        var  aDate,  oDate1,  oDate2,  iDays
        aDate  =  sDate1.split("-")
        oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])    //转换为12-18-2002格式
        aDate  =  sDate2.split("-")
        oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])
        iDays  =  parseInt((oDate1  -  oDate2)  /  1000  /  60  /  60  /24)    //把相差的毫秒数转换为天数
        return  iDays
    }

    function tiaozhengriqi() {
        var qidingriqi = regform.begindate.value;
        var subscribe = $("input[name='subscribe']:checked").val();
        var dyqnum = regform.dyqnum.value;
        var dymnum = regform.dymnum.value;

        //用户输入的起订七日
        var date=new Date(qidingriqi.replace("-", "/").replace("-", "/"));
        //当前日期
        var current_date = new Date();
        var str_Date = date.Format("yyyy-MM-dd");
        var str_Current_date = current_date.Format("yyyy-MM-dd");
        var difDays = DateDiff(str_Date,str_Current_date);

        if (difDays<0) {
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'选择日期必须大于当前日期'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            //regform.begindate.value = current_date.Format("yyyy-MM-dd");
            regform.begindate.value = "";
            return true;
        }

        $.post("/users/getSubscribeDate.jsp?theTime=<%=System.currentTimeMillis()%>",{
                indate:encodeURI(str_Date),
                tqdays:<%=tqdays%>
            },
            function(data) {
                //alert("订报日期确认规则为您的下单日期加提前预定期7天，如果计算日期是某月1号，则该日期为正式预定日期，如果计算日期不是某月1号，自动延期到下月1号为起订日期");
                $.msgbox({
                    height:200,
                    width:400,
                    content:{type:'alert', content:'订报日期确认规则为您的下单日期加提前预定期7天，如果计算日期是某月1号，则该日期为正式预定日期，如果计算日期不是某月1号，自动延期到下月1号为起订日期'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });

                if (data.result!=="error")
                    regform.begindate.value = data.result;
                else
                    $.msgbox({
                        height:150,
                        width:250,
                        content:{type:'alert', content:'日期选择错误，请重新选择日期'},
                        animation:0,       //禁止拖拽
                        drag:false         //禁止动画
                        //autoClose: 10     //自动关闭
                    });
            },
            "json"
        );

        /*var dy_date = new Date();
        if (parseInt(difDays) < parseInt(7)) {
            //用户输入的起订日期加上提前预定的天数
            dy_date.setDate(current_date.getDate() + 7);
            var tempDate = dy_date.Format("yyyy-MM-dd");
            var posi = tempDate.lastIndexOf("-");
            var day =  parseInt(tempDate.substring(posi+1));
            if (day!==1) {
                dy_date.setMonth(dy_date.getMonth() + 1);
                dy_date.setDate(1);
            }
            regform.begindate.value = dy_date.Format("yyyy-MM-dd");
        } else {
            dy_date = date;
            var tempDate = dy_date.Format("yyyy-MM-dd");
            var posi = tempDate.lastIndexOf("-");
            var day =  parseInt(tempDate.substring(posi+1));
            alert(tempDate);
            alert(day);
            if (day!==1) {
                dy_date.setMonth(dy_date.getMonth() + 1);
                dy_date.setDate(1);
                if (day==31) {
                    dy_date.setMonth(dy_date.getMonth() - 1);
                }
            }
            regform.begindate.value = dy_date.Format("yyyy-MM-dd");
        }*/
    }

    function hideOrShowInvoiceinfo() {
        var invoicetype = $("input[name='invoicetype']:checked").val();
        if (invoicetype == 0) {
            $("#invoice_row1").attr("style","display:none;");
            $("#invoice_row2").attr("style","display:none;");
            $("#invoice_row3").attr("style","display:none;");
            $("#invoice_row4").attr("style","display:none;");
            $("#invoice_row5").attr("style","display:none;");
        } else {
            $("#invoice_row1").attr("style","display:block;");
            $("#invoice_row2").attr("style","display:block;");
            $("#invoice_row3").attr("style","display:block;");
            $("#invoice_row4").attr("style","display:block;");
            $("#invoice_row5").attr("style","display:block;");
        }
    }

    function isNotANumber(inputData) {
        if (parseFloat(inputData).toString() == "NaN") {
            return false;
        } else {
            return true;
        }
    }

    function checkRate(input) {
        //判断字符串是否为数字//判断正整数/[1−9]+[0−9]∗]∗/
        var re = /^[0-9]+.?[0-9]*/;
        if (!re.test(nubmer)) {
            alert("请输入数字");
        }
    }

    function checks(form) {
        var bznum = form.numbercopy.value;
        if (parseFloat(bznum).toString() == "NaN") {
            //alert("报纸订阅分数必须是整数，不能包含字母");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'报纸订阅分数必须是整数，不能包含字母'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        var startdate = form.begindate.value;
        if (startdate==null || startdate=="") {
            //alert("开始日期不能为空，请选择开始日期");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'开始日期不能为空<br/>请选择开始日期'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        var name = form.name.value;
        if (name==null || name=="") {
            //alert("收报人姓名（单位）内容不能为空，请填写收报人（单位）名称");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'收报人姓名（单位）内容不能为空，请填写收报人（单位）名称'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        var mphone = form.phone.value;
        var telephone = form.telephone.value;
        if (mphone==null || mphone=="") {
            //alert("收报人手机不能为空，请填写收报人的联系手机号码");
            if (telephone == null || telephone =="") {
                $.msgbox({
                    height:200,
                    width:300,
                    content:{type:'alert', content:'收报人手机和固定电话不能同时为空，请填写收报人的联系手机号码或者固定电话号码'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            } else {
                //判断固定电话号码合法性
                re = /^0\d{2,3}-?\d{7,8}$/;
                if (!re.test(telephone)) {
                    $.msgbox({
                        height:120,
                        width:250,
                        content:{type:'alert', content:'固定电话号码格式不正确！'},
                        animation:0,       //禁止拖拽
                        drag:false         //禁止动画
                        //autoClose: 10     //自动关闭
                    });
                    return false;
                }
            }
        } else {
            //判断手机号码的合法性
            var regPartton=/1[3-8]+\d{9}/;
            if(!regPartton.test(mphone)){
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'手机号码格式不正确！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }
        }

        var address = form.address.value;
        if (address==null || address=="") {
            //alert("收报人地址不能为空，请填写收报人通讯地址");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'收报人地址不能为空，请填写收报人通讯地址'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        var postcode = form.postcode.value;
        if (postcode==null || postcode=="") {
            //alert("收报人或者单位邮政编码不能为空，请填写收报人邮政编码");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'收报人或者单位邮政编码不能为空，请填写收报人邮政编码'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        } else {
            //判断邮政编码的合法性
            var re= /^[1-9][0-9]{5}$/;
            if (!re.test(postcode)) {
                $.msgbox({
                    height:120,
                    width:250,
                    content:{type:'alert', content:'邮政编码格式不正确！'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }
        }

        var invoicetype = $("input[name='invoicetype']:checked").val();
        if (invoicetype != 0) {
            var gmftype = $("input[name='gmftype']:checked").val();
            if (gmftype!=0 && gmftype!=1) {
                //alert("请选择为公司开票还是为个人开票");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'请选择为公司开票还是为个人开票'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            var gmfname = form.gmfname.value
            if (gmfname==null || gmfname=="") {
                //alert("请填写开票公司名称或者个人，该字段内容不能为空");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'请填写开票公司名称或者个人，该字段内容不能为空'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            var gmftaxnum = form.gmftaxnum.value
            if (gmftaxnum==null || gmftaxnum=="") {
                //alert("请填写开票公司的税号，税号不能为空");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'请填写开票公司的税号，税号不能为空'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            var gmfbankname = form.gmfbankname.value
            if (gmfbankname==null || gmfbankname=="") {
                //alert("请填写开票公司开户行名称，开户行名称不能为空");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'请填写开票公司开户行名称，开户行名称不能为空'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            var gmfbankaccount = form.gmfaccount.value
            if (gmfbankaccount==null || gmfbankaccount=="") {
                //alert("请填写开票公司开户行账号，开户行账号不能为空");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'请填写开票公司开户行账号，开户行账号不能为空'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            var content = form.content.value
            if (content==null || content=="") {
                //alert("请填写开票内容，开票内容不能为空");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'请填写开票内容，开票内容不能为空'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }

            var email = form.fpemail.value;
            if (email==null || email=="") {
                //alert("发票电子邮件不能为空，请填写发票电子邮件地址");
                $.msgbox({
                    height:150,
                    width:250,
                    content:{type:'alert', content:'发票电子邮件不能为空，请填写发票电子邮件地址'},
                    animation:0,       //禁止拖拽
                    drag:false         //禁止动画
                    //autoClose: 10     //自动关闭
                });
                return false;
            }
        }

        return true;
    }
</script>
</html>
