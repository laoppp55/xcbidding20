<%@ page import="java.util.*,
                 java.text.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*"
         contentType="text/html;charset=gbk"
%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="com.bizwink.po.Companyinfo" %>
<%@ page import="com.bizwink.cms.security.*" %>
<%@ page import="com.bizwink.po.Department" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = 20;
    int searchflag = ParamUtil.getIntParameter(request, "searchflag", 0);
    int updateflag = ParamUtil.getIntParameter(request, "updateflag", 0);
    int status = ParamUtil.getIntParameter(request,"status",0);
    int siteid = authToken.getSiteID();
    int orgid = authToken.getOrgid();
    int company_orgid = authToken.getCompanyid();
    int dept_orgid = authToken.getDeptid();
    int companyid = 0;
    int deptid = 0;
    int org_level = 0;
    int rootOrgid = 0;
    int orgtype = 0;           //��֯�ܹ��ڵ����ͣ�1��ʾ��˾��0��ʾ����
    int projcode=ParamUtil.getIntParameter(request, "projcode",100);

    IOrderManager orderMgr = orderPeer.getInstance();
    IUserManager userManager = UserPeer.getInstance();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    Organization organization =null;
    Organization rootOrganization = null;
    List<Companyinfo> companyinfos = null;
    List<Department> departments = null;
    OrganizationService organizationService = null;
    if (appContext!=null) {
        organizationService = (OrganizationService)appContext.getBean("organizationService");
        rootOrganization = organizationService.getRootOrganization(BigDecimal.valueOf(siteid));
        if (rootOrganization != null) {
            rootOrgid = rootOrganization.getID().intValue();
            organization = organizationService.getAOrganization(BigDecimal.valueOf(orgid));
            if (organization != null) {
                org_level = organization.getLLEVEL().intValue();
                orgtype = organization.getCOTYPE().intValue();
                companyinfos = organizationService.getMainCompaniesByOrgid(BigDecimal.valueOf(siteid), BigDecimal.valueOf(orgid));
                if (companyinfos != null)
                    if (companyinfos.size() > 0) companyid = companyinfos.get(0).getID().intValue();
                departments = organizationService.getADepartmentByOrgid(BigDecimal.valueOf(siteid), organization.getID());
                if (departments != null)
                    if (departments.size() > 0) deptid = departments.get(0).getID().intValue();
            }
        }
    }

    if (updateflag == 1) {
        String[] ordergo = request.getParameterValues("ordergo");
        long updateid = 0;
        int oldstatus = -1;
        for (int i = 0; i < ordergo.length; i++) {
            updateid = Long.parseLong(ordergo[i]);
            //oldstatus = orderMgr.getStatus(updateid);
            Order sorder = orderMgr.getAOrder(updateid);
            //int userid = sorder.getUserid();
            //int usescores = sorder.getUserscores();
            oldstatus = orderMgr.getStatus(updateid);
            orderMgr.updateStatus(updateid, 2, authToken.getUserID());
            //orderMgr.freeScores(userid,usescores);
        }
        response.sendRedirect("index.jsp");
    }

    if (updateflag == 2) {
        String[] ordergo = request.getParameterValues("ordergo");
        long updateid = 0;
        int oldstatus = -1;
        for (int i = 0; i < ordergo.length; i++) {
            updateid = Long.parseLong(ordergo[i]);
            oldstatus = orderMgr.getStatus(updateid);
            orderMgr.updateStatus(updateid, 6, authToken.getUserID());
        }
        response.sendRedirect("index.jsp");
    }

    Order order = new Order();
    List currentlist = new ArrayList();
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;
    long orderid = 0;
    String startday = null;
    String endday = null;
    String porductname = "";
    String username = "";
    int sendway = 0;
    int orderflag = 0;
    String pphone = "";
    int user_id = 0;
    int source_id = 0;
    String jumpstr = "";
    int total_dynum = 0;

    if (searchflag == 1) {
        //porductname = ParamUtil.getParameter(request, "detailedname");
        //sendway = ParamUtil.getIntParameter(request, "sendway", -1);
        //orderflag = ParamUtil.getIntParameter(request, "orderflag", -1);
        orderid = ParamUtil.getLongParameter(request, "orderid", 0);
        username = ParamUtil.getParameter(request, "username");
        pphone = ParamUtil.getParameter(request, "phone");
        status = ParamUtil.getIntParameter(request, "status",0);
        startday = ParamUtil.getParameter(request, "searchtime1");
        endday = ParamUtil.getParameter(request, "searchtime2");
        //company_orgid = ParamUtil.getIntParameter(request, "_sel_n1",0);
        //dept_orgid = ParamUtil.getIntParameter(request, "_sel_n2",0);
        //user_id = ParamUtil.getIntParameter(request, "_sel_n3",0);
        //source_id = ParamUtil.getIntParameter(request, "_sel_n4",0);
        projcode = projcode=ParamUtil.getIntParameter(request, "projcode",100);

        String where_clause = "";

        //���ö����Ų�ѯ����
        if (orderid != 0) {
            where_clause = where_clause + "orderid=" + orderid;
            jumpstr = jumpstr + "&orderid=" + orderid;
        }

        //���ÿͻ����ֲ�ѯ����
        if (where_clause!="" && where_clause!=null) {
            if (username!="" && username!=null) {
                where_clause = where_clause +" and name='" + username + "'";
                jumpstr = jumpstr + "&username=" + username;
            }
        } else {
            if (username!=null && username!="") {
                where_clause = where_clause + "name='" + username + "'";
                jumpstr = jumpstr + "&username=" + username;
            }
        }

        //�����û�����ϵ�绰Ϊ��ѯ����
        if (where_clause!="" && where_clause!=null) {
            if (pphone!="" && pphone!=null) {
                where_clause = where_clause +" and phone='" + pphone + "'";
                jumpstr = jumpstr + "&phone=" + pphone;
            }
        } else {
            if (pphone!="" && pphone!=null) {
                where_clause = where_clause + "phone='" + pphone + "'";
                jumpstr = jumpstr + "&phone=" + pphone;
            }
        }

        //����״̬��ѯ����
        if (where_clause != "" && where_clause!=null) {
            if (status == 0) {
                // where_clause = where_clause +" and (status=1 or status=2 or status=3)";
            } else {

                where_clause = where_clause + " and status=" + status;
           }
            jumpstr = jumpstr + "&status=" + status;
        } else {
            if (status == 0) {
                //where_clause = where_clause + "(status=1 or status=2 or status=3)";
            }else {
                where_clause = where_clause + "status=" + status;
            }
            jumpstr = jumpstr + "&status=" + status;
        }

        if ((endday != "") && (endday != null)) {
            //endday = endday + " 23:59:59";
            jumpstr = jumpstr + "&searchtime2=" + endday;
        }
        if ((startday != "") && (startday != null)) {
           // startday = startday + " 00:00:00";
            jumpstr = jumpstr + "&searchtime1=" + startday;
        }
        //���ñ�����Ŀ��ѯ����
        if (where_clause!="" && where_clause!=null) {
            if (projcode!=100) {
                where_clause = where_clause + " and projcode='" + projcode + "'";
            }
                jumpstr = jumpstr + "&projcode=" + projcode;

        } else {
            if (projcode!=100) {
                where_clause = where_clause + "projcode='" + projcode + "'";
            }
                jumpstr = jumpstr + "&projcode=" + projcode;

        }

      /*  companyinfos = organizationService.getMainCompaniesByOrgid(BigDecimal.valueOf(siteid),BigDecimal.valueOf(company_orgid));
        if (companyinfos!=null && companyinfos.size()>0) {
            companyid = companyinfos.get(0).getID().intValue();
            jumpstr = jumpstr + "&_sel_n1=" + company_orgid;
        }

        departments = organizationService.getADepartmentByOrgid(BigDecimal.valueOf(siteid),BigDecimal.valueOf(dept_orgid));
        if (departments!=null && departments.size()>0) {
            deptid = departments.get(0).getID().intValue();
            jumpstr = jumpstr + "&_sel_n2=" + dept_orgid;
        }

        jumpstr = jumpstr + "&_sel_n3=" + user_id;
        jumpstr = jumpstr + "&_sel_n4=" + source_id;*/




        jumpstr = jumpstr + "&searchflag=1";
        System.out.println(jumpstr);

        //startindex, range, siteid,status,whereClause,startday,endday,com_orgid,dept_orgid,uid,source
        currentlist = orderMgr.searchOrderList(startrow, range,siteid,status,where_clause,startday,endday,orgtype,companyid,deptid,user_id,source_id);
        rows = orderMgr.searchOrderNum(siteid,status,where_clause,startday,endday,orgtype,companyid,deptid,user_id,source_id);
       // total_dynum = orderMgr.searchSubscribeOrderNum(siteid,status,where_clause,startday,endday,orgtype,companyid,deptid,user_id,source_id);
        if (rows < range) {
            totalpages = 1;
            currentpage = 1;
        } else {
            if (rows % range == 0)
                totalpages = rows / range;
            else
                totalpages = rows / range + 1;

            currentpage = startrow / range + 1;
        }
    } else {
        if (SecurityCheck.hasPermission(authToken, 54)){
            currentlist = orderMgr.getOrderList(startrow, range, siteid, status);
            rows = orderMgr.getTotalOrderNumByStatus(siteid, status);
            total_dynum = orderMgr.getTotalSubscribeNum(siteid, status);
        } else {
            if (organization!=null) {
                if (organization.getID().intValue()==rootOrgid) {
                    currentlist = orderMgr.getOrderList(startrow, range,siteid,status);
                    rows = orderMgr.getTotalOrderNumByStatus(siteid,status);
                    total_dynum = orderMgr.getTotalSubscribeNum(siteid, status);
                } else {
                    List<User> users = null;
                    if (orgtype == 1) {
                        if (companyinfos!=null) users = userManager.getUsersByCompanyid(siteid, companyinfos.get(0).getID().intValue());
                    }else {
                        if (departments!=null) users = userManager.getUsersByDeptid(siteid, departments.get(0).getID().intValue());
                    }
                    if (users!=null) {
                        currentlist = orderMgr.getOrderListByUsers(startrow, range,siteid,status,users);
                        rows = orderMgr.getOrderNumByStatusAndUsers(siteid,status,users);
                        //total_dynum = orderMgr.getSubscribeNumByStatusAndUsers(siteid,status,users);
                    }
                }
            }
        }

        if (rows < range) {
            totalpages = 1;
            currentpage = 1;
        } else {
            if (rows % range == 0)
                totalpages = rows / range;
            else
                totalpages = rows / range + 1;
            currentpage = startrow / range + 1;
        }
    }

    System.out.println("projcode="+projcode);
%>
<html>
<head>
    <title>��������</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <script language="JavaScript" src="../include/setday.js"></script>
    <script language="JavaScript" src="../../../js/jquery-1.11.1.min.js"></script>
    <meta http-equiv="Pragma" content="no-cache">
    <script language="javascript">
        function golist(r) {
            window.location = "index.jsp?startrow=" + r;
        }

        function gotosearch() {
            searchForm.action = "index.jsp";
            searchForm.submit();
        }

        function jumppage(r, str) {
            window.location = "index.jsp?startrow=" + r + str;

        }

        function CheckAll(form) {
            for (var i = 0; i < form.elements.length; i++) {
                var e = form.elements[i];
                if (e.name != 'chkAll')
                    e.checked = form.chkAll.checked;
            }
        }

        function check(form, tflag) {
            var flag = false;
            for (var i = 0; i < form.elements.length; i++) {
                if (form.elements[i].checked) {
                    flag = true;
                }
            }
            if (!flag) {
                alert("��ѡ�񶨵���");
                return false;
            } else {
                var val;
                if (tflag == 1) {
                    val = confirm("��ѡ�ж���״̬��Ϊ������");
                    if (val) {
                        form.action = "index.jsp?updateflag=1";
                        form.submit();
                    }
                } else if (tflag == 2) {
                    val = confirm("��ѡ�ж���״̬��Ϊȱ����");
                    if (val) {
                        form.action = "index.jsp?updateflag=2";
                        form.submit();
                    }
                }
            }
        }

        //function delOrder(orderid) {
        //    var val;
        //    val = confirm("ȷ��Ҫɾ��������");
        //    if (val) {
        //        window.location = "deleteOrder.jsp?orderid=" + orderid;
        //    }
        //}

        function searchPayinfo(orderid,payway,startrow) {
            var iWidth=800;                                                 //�������ڵĿ��;
            var iHeight=400;                                                //�������ڵĸ߶�;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open("searchInfoFromPaycenter.jsp?orderid=" + orderid + "&payway=" + payway + "&start=" + startrow, "", "width=" + iWidth +",height=" + iHeight +",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
        }

        function dispOrderDetail(orderid) {
            var iWidth=1000;                                                 //�������ڵĿ��;
            var iHeight=600;                                                //�������ڵĸ߶�;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open("orderDetail.jsp?orderid=" + orderid, "", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
        }

        function exportOrders(){
            var iWidth=1200;                                                 //�������ڵĿ��;
            var iHeight=400;                                                //�������ڵĸ߶�;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open('exportOrderToExcel.jsp', '', 'height=' + iHeight + ', width=' + iWidth + ', top=' + iTop + ', left=' + iLeft + ', toolbar=yes, menubar=no, scrollbars=yes, resizable=no, location=no, status=yes');
        }

        function balanceAccount(){
            var iWidth=1200;                                                 //�������ڵĿ��;
            var iHeight=400;                                                //�������ڵĸ߶�;
            var iTop = (window.screen.availHeight-30-iHeight)/2;        //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth-10-iWidth)/2;         //��ô��ڵ�ˮƽλ��;
            window.open('balanceAccount.jsp', '', 'height=' + iHeight + ', width=' + iWidth + ', top=' + iTop + ', left=' + iLeft + ', toolbar=yes, menubar=no, scrollbars=yes, resizable=no, location=no, status=yes');
        }
    </script>
</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>
<center>
        <%
        String[][] titlebars = {
                {"��ҳ", ""},
                {"��������", ""}
        };


        String[][] operations = {
                //{"������", "index.jsp"}, {"", ""},
                //{"ȱ��", "lack.jsp"}, {"", ""},
                //{"�ѷ���", "receive.jsp"}, {"", ""},
                //{"�����", "end.jsp"}, {"", ""},
                //{"�˻�����", "putback.jsp"}, {"", ""},
                //{"���ն���", "refuse.jsp"}, {"", ""},
                //{"�ͻ�ȡ��", "qorders.jsp"}, {"", ""},
        };
    %>
    <%@ include file="../inc/titlebar.jsp" %>
    <table width="100%" border="0" cellpadding="0">
        <tr>
            <td background="images/dot-line.gif"></td>
        </tr>
        <tr bgcolor="#d4d4d4" align="right">
            <td bgcolor="#DCE4E7">
                <form name="searchForm" method="post" action="index.jsp">
                    <input type="hidden" name="searchflag" value="1">
                    <input type="hidden" name="range" value=<%=range%>>
                    <table width="100%" border="0" cellpadding="3" cellspacing="1">
                        <tr>
                            <td colspan="12" class="txt"><font color="#59697B"><strong>��ѯ����</strong></font></td>
                            <td colspan="2" align="right" class="txt">
                                <input type=button value="��ѯ" onclick="javascript:gotosearch();">
                                <input type=button value="����" onclick="javascript:exportOrders();">
                                <!--input type=button value="����" onclick="javascript:balanceAccount();"-->
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td width="5%" align="right" class="txt">�����ţ�</td>
                            <td width="10%" align="left" class="txt">
                                <input type="text" name="orderid" size="15" value="<%=(orderid==0)?"":orderid%>">
                            </td>
                            <td width="6%" align="right" class="txt">������</td>
                            <td width="5%" align="left" class="txt">
                                <input type="text" name="username" size="5" value="<%=(username==null)?"":username%>">
                            </td>
                            <td width="4%" align="right" class="txt">�绰��</td>
                            <td width="8%" align="left" class="txt">
                                <input type="text" name="phone" size="11" value="<%=(pphone==null)?"":pphone%>">
                            </td>
                            <td width="6%" align="right" class="txt">��ѵ״̬��</td>
                            <td width="6%" align="left" class="txt">
                                <select name="status">
                                    <option value=2 <%=(status==2)?"selected":""%>>��ѵ��</option>
                                    <option value=1 <%=(status==1)?"selected":""%>>����ѵ</option>
                                    <option value=3 <%=(status==3)?"selected":""%>>�����</option>
                                    <option value="0" <%=(status==0)?"selected":""%>>����״̬</option>
                                    <!--option value=1>������</option>
                                    <option value=2>����</option>
                                    <option value=3>�˻�</option>
                                    <option value=4>���</option>
                                    <option value=5>����</option>
                                    <option value=6>ȱ��</option-->
                                </select>
                            </td>
                            <!--td width="6%" align="right" class="txt">֧������</td-->
                            <td width="6%" align="right" class="txt">��������</td>
                            <td width="15%" align="left" bgcolor="#FFFFFF" class="txt">
                                <input type="text" size="10" name="searchtime1" value="<%=(startday==null)?"":startday%>" onfocus="setday(this)" readonly>
                                ��
                                <input type="text" size="10" name="searchtime2" value="<%=(endday==null)?"":endday%>" onfocus="setday(this)" readonly>
                            </td>
                            <td>

                                <div id=l1>
                                    <select name="projcode" id="projcode">
                                        <option value=100 <%=(projcode==100)?"selected":""%>>��ѡ����Ŀ</option>
                                        <option value=101 <%=(projcode==101)?"selected":""%>>һ��ע�Ὠ��ʦ</option>
                                        <option value=102 <%=(projcode==102)?"selected":""%>>����ע�Ὠ��ʦ</option>
                                        <option value=103 <%=(projcode==103)?"selected":""%>>һ��ע�����ʦ</option>
                                        <option value=104 <%=(projcode==104)?"selected":""%>>����ע�����ʦ</option>
                                        <option value=105 <%=(projcode==105)?"selected":""%>>�ֳ�������Ա</option>
                                        <option value=106 <%=(projcode==106)?"selected":""%>>�ֳ�������Ա</option>
                                        <option value=106 <%=(projcode==107)?"selected":""%>>��ȫ������Ա</option>
                                        <option value=106 <%=(projcode==108)?"selected":""%>>����</option>
                                    </select>
                                </div>
                            </td>

                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>
    <form action="index.jsp" method="post" name="chuku">
        <input type="hidden" name="updateflag" value="1">
        <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%" border="0" cellpadding="0">
                        <tr bgcolor="#F4F4F4" align="center">
                            <td class="moduleTitle"><font color="#48758C">�����ж����б�</font></td>
                        </tr>
                        <tr bgcolor="#d4d4d4" align="right">
                            <td>
                                <table width="100%" border="0" cellpadding="2" cellspacing="1">
                                    <tr bgcolor="#FFFFFF">
                                        <td align="center" width="5%">�û�ID</td>
                                        <td align="center" width="7%">������</td>
                                        <td align="center" width="7%">����</td>
                                        <td align="center" width="9%">��ַ</td>
                                        <td align="center" width="7%">�ʱ�</td>
                                        <td align="center" width="5%">�绰</td>
                                        <td align="center" width="5%">���ʽ</td>
                                        <td align="center" width="5%">��ѵ״̬</td>
                                        <td align="center" width="7%">�ܷ���</td>
                                        <td align="center" width="5%">������Ŀ</td>
                                        <!--td align="center" width="5%">��ֽ����</td-->
                                        <td align="center" width="7%">������ʽ</td>
                                        <!--td align="center" width="7%">������</td-->
                                        <td align="center" width="9%">��������</td>
                                        <td align="center" width="10%">������֧����ѯ</td>
                                    </tr>
                                    <%
                                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                        DecimalFormat df = new DecimalFormat();
                                        df.applyPattern("0.00");
                                        DecimalFormat df2 = new DecimalFormat();
                                        df2.applyPattern("0");
                                        String phone = "";
                                        String address = null;
                                        String zip = null;
                                        String subscribeType = null;

                                        for (int i = 0; i < currentlist.size(); i++) {
                                            order = (Order) currentlist.get(i);
                                            //List<Order> orderDetails = orderMgr.getDetail(order.getOrderid());
                                            AddressInfo addressInfo = orderMgr.getAAddresInfoForOrder(order.getOrderid());
                                            if (addressInfo!=null) {
                                                address = addressInfo.getAddress();
                                                zip = addressInfo.getZip();
                                            }
                                            String createdate = String.valueOf(order.getCreateDate());
                                            //createdate =createdate==null?"":String.valueOf(createdate).substring(0, 16);
                                            int payway = order.getPayWay();
                                            if ((order.getPhone() != null) && (!"".equals(order.getPhone()))) {
                                                phone = order.getPhone();
                                                phone = StringUtil.gb2iso4View(phone);
                                            } else {
                                                phone = orderMgr.getPhone(order.getOrderid());
                                                phone = StringUtil.gb2iso4View(phone);
                                            }

                                            String province = order.getProvince()==null?"--":StringUtil.gb2iso4View(order.getProvince());
                                            String city = order.getCity()==null?"--":StringUtil.gb2iso4View(order.getCity());
                                            Fee fee = new Fee();
                                            fee = orderMgr.getAFeeInfo(order.getSendWay());


                                            String projname = order.getProjname();

                                    %>
                                    <tr bgcolor="#FFFFFF">
                                        <td align="center">
                                            <%=order.getName()%>
                                        </td>
                                        <td align="center">
                                            <a href="#" onclick="dispOrderDetail(<%=order.getOrderid()%>);"><%=order.getOrderid()%>
                                            </a>
                                        </td>
                                        <td align="center"><%=order.getName() == null ? "" : StringUtil.gb2iso4View(order.getName())%>
                                        </td>
                                        <!--td align="center"><!%=province%>&nbsp;&nbsp;<!%=city%></td-->
                                        <td align="center"><%=address == null ? "" : StringUtil.gb2iso4View(address)%>
                                        </td>
                                        <td align="center"><%=zip == null ? "" : StringUtil.gb2iso4View(zip)%>
                                        </td>
                                        <td align="center"><%=phone%>
                                        </td>
                                        <td align="center"><%if(order.getPayWay() == 0){%>΢��֧��<%}else{%><%=order.getPayWay()==1?"֧����":((order.getPayWay()==2)?"����֧��":"��������")%><%}%>
                                        </td>
                                        <td align="center">
                                            <%if (order.getNouse() == 0) {%>
                                            <a href="tostatus.jsp?orderid=<%=order.getOrderid()%>" target=_blank><font color="red">�ͻ�ȡ��</font></a>
                                            <%} else {
                                                if (order.getStatus() == 2) {%>
                                            <a href="tostatus.jsp?orderid=<%=order.getOrderid()%>" target=_blank><font color="green">��ѵ��</font></a>
                                            <%} else if (order.getStatus() == 1){
                                                Calendar now_cal = Calendar.getInstance();
                                                now_cal.setTime(new Date(System.currentTimeMillis()));
                                                Calendar order_create_cal = Calendar.getInstance();
                                                order_create_cal.setTime(order.getCreateDate());
                                                order_create_cal.add(Calendar.DAY_OF_MONTH,1);      //��������ʱ������1��
                                               /* if (now_cal.after(order_create_cal)) {
                                                    orderMgr.updateStatus(order.getOrderid(),9,username);
                                                    status7and9_brief = "�û���ʱδ����";
                                                } else
                                                    status7and9_brief = "�ȴ��û�����";*/
                                            %>
                                            <a href="tostatus.jsp?orderid=<%=order.getOrderid()%>" target=_blank><font color="red">����ѵ</font></a>
                                            <%}  else if (order.getStatus() == 4) {%>
                                            <a href="tostatus.jsp?orderid=<%=order.getOrderid()%>" target=_blank><font color="#FF0000">�û���ʱδ����</font></a>
                                            <%} else if (order.getStatus() == 3){%>
                                            <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="blue">�����</font></a>
                                            <%} else {%>
                                            δ֪
                                            <%}}%>

                                            <!--%if (order.getStatus() == 1) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">������</font></a>
                                            < %} else if (order.getStatus() == 2) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">����</font></a>
                                            < %} else if (order.getStatus() == 3) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">�˻�</font></a>
                                            < %} else if (order.getStatus() == 4) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">���</font></a>
                                            < %} else if (order.getStatus() == 5) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">����</font></a>
                                            < %} else if (order.getStatus() == 6) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">ȱ��</font></a>
                                            < %} else if (order.getStatus() == 7) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="#FF0000">�ȴ��ͻ�����</font></a>
                                            < %} else if (order.getStatus() == 9) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="#FF0000">�û���ʱδ����</font></a>
                                            <  %} else if (order.getStatus() == 8) {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="green">�Ѹ���</font></a>
                                            < %} else {%>
                                                <a href="tostatus.jsp?orderid=< %=order.getOrderid()%>" target=_blank><font color="red">�¶���</font></a>
                                            < %}
                                        }%-->
                                        </td>
                                        <td align="center"><%=df.format(order.getPayfee())%></td>
                                        <td align="center"><%=(projname!=null)?projname:""%></td>
                                      <%--  <td align="center"><%=dynum%></td>--%>
                                        <td align="center"><%=(subscribeType!=null)?subscribeType:""%></td>
                                       <%-- <td align="center"><%=(serviceStartDate!=null)?serviceStartDate:""%></td>--%>
                                        <td align="center"><%=order.getCreateDate().toString().substring(0,19)%></td>
                                        <!--td align="center"><a href="tostatus.jsp?orderid=<%=order.getOrderid()%>" target=_blank>����״̬</a></td-->
                                        <td align="center"><a href="#" onclick="javascript:searchPayinfo(<%=order.getOrderid()%>,<%=payway%>,<%=startrow%>)">������֧����ѯ</a></td>
                                        <!--%if (order.getStatus() == 0) {%>
                                        <!--td align="center"><a href="#" onclick="delOrder(<!%=order.getOrderid()%>)">ɾ��</a></td>
                                        <td align="center">&nbsp;</td>
                                        <!%} else {%>
                                        <td align="center">&nbsp;</td>
                                        <!%}%-->
                                    </tr>
                                    <%}%>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>����������<%=rows%>    <%--���ı�ֽ���ܷ�����<%=total_dynum%>--%></td>
            </tr>
        </table>
        <%--<input type="submit" value="����" onclick="javascript:return check(this.form);">--%>
        <!--input type="button" value="����" onclick="javascript:return check(this.form,1);" name="up1">
        <input type="button" value="ȱ��" onclick="javascript:return check(this.form,2);" name="up2"-->
        <table>
            <tr valign="bottom">
                <td>
                    ��<%=totalpages%>ҳ&nbsp; ��<%=currentpage%>ҳ
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <%
                        if (searchflag == 0) {
                            if ((startrow - range) >= 0) {
                    %>
                    [<a href="index.jsp?startrow=0">��һҳ</a>][<a href="index.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
                    <%
                        }
                        if ((startrow + range) < rows) {
                    %>
                    [<a href="index.jsp?startrow=<%=startrow+range%>">��һҳ</a>][<a href="index.jsp?startrow=<%=(totalpages-1)*range%>">���ҳ</a>]
                    <%
                        }

                        if (totalpages > 1) {
                    %>
                    &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
                    <a href="#" onclick="golist((document.all('jump').value-1) * <%=range%>);">GO
                    </a>
                    <%
                        }

                    } else if (searchflag == 1) {
                        if ((startrow - range) >= 0) {
                    %>
                    [<a href="index.jsp?startrow=<%=range%><%=jumpstr%>">��һҳ</a>][<a href="index.jsp?startrow=<%=startrow-range%><%=jumpstr%>">��һҳ</a>]
                    <%}%>
                    <%
                        if ((startrow + range) < rows) {
                    %>
                    [<a href="index.jsp?startrow=<%=startrow+range%><%=jumpstr%>">��һҳ</a>][<a href="index.jsp?startrow=<%=(totalpages-1)*range%><%=jumpstr%>">���ҳ</a>]
                    <%
                        }
                        if (totalpages > 1) {
                    %>
                    &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
                    <a href="#" onclick="jumppage((document.all('jump').value-1)*<%=range%>,'<%=jumpstr%>');">GO
                    </a>
                    <%
                            }
                        }
                    %>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>