<%@ page import="java.util.*,
                 java.text.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.server.FileProps" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    int startrow = ParamUtil.getIntParameter(request, "startrow", 0);
    int range = ParamUtil.getIntParameter(request, "range", 100);
    int searchflag = ParamUtil.getIntParameter(request, "searchflag", 0);
    int updateflag = ParamUtil.getIntParameter(request, "updateflag", 0);
    int userid = 0;

    int siteid = authToken.getSiteID();

    String jumpstr = "";

    IOrderManager orderMgr = orderPeer.getInstance();


    Order order = new Order();
    List list = new ArrayList();
    List currentlist = new ArrayList();
    int currentrows = 0;
    int totalrows = 0;
    int row = 0;
    int rows = 0;
    int totalpages = 0;
    int currentpage = 0;

    if (searchflag == 0) {
        String sql = "select o.* from tbl_orders o where o.siteid = " + siteid + " and o.status=3 and nouse = 1 order by o.createdate desc";
        list = orderMgr.getOrderList(startrow, 0, 3, sql);
        currentlist = orderMgr.getOrderList(startrow, range, 3, sql);
        row = currentlist.size();
        rows = list.size();
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

    int orderid = 0;
    String searchtime1 = "";
    String searchtime2 = "";
    String porductname = "";
    String username = "";
    int sendway = 0;
    int orderflag = 0;
    int status = 3;

    if (searchflag == 1) {
        orderid = ParamUtil.getIntParameter(request, "orderid", 0);
        searchtime1 = ParamUtil.getParameter(request, "searchtime1");
        searchtime2 = ParamUtil.getParameter(request, "searchtime2");
        porductname = ParamUtil.getParameter(request, "detailedname");
        username = ParamUtil.getParameter(request, "username");
        status = 3;
        sendway = ParamUtil.getIntParameter(request, "sendway", -1);
        orderflag = ParamUtil.getIntParameter(request, "orderflag", -1);
    }

    if (searchflag != 0) {
        jumpstr = "&searchflag=1";

        String sqlstr = "";
        if ((searchtime2 != "") && (searchtime2 != null)) searchtime2 = searchtime2 + " 23:59:59";
        if ((searchtime1 != "") && (searchtime1 != null)) searchtime1 = searchtime1 + " 00:00:00";


        sqlstr = "select o.* from tbl_orders o where o.siteid=" + siteid + " and o.status=3 and 1 = 1";

        if (orderid != 0) {
            if (sqlstr.endsWith("1 = 1")) {
                sqlstr = sqlstr + " and o.orderid=" + orderid;
            } else {
                sqlstr = sqlstr + " or o.orderid=" + orderid;
            }
            jumpstr = jumpstr + "&orderid=" + orderid;
        }

        FileProps fp = new FileProps("com/bizwink/cms/server/config.properties");
        String dbstr = fp.getProperty("main.db.type");
        jumpstr = "&searchflag=1";
        if ((searchtime1 != "") && (searchtime1 != null)) {
            if (dbstr.equals("oracle")) {
                if (sqlstr.endsWith("1 = 1")) {
                    sqlstr = sqlstr + " and o.createdate >= TO_DATE('" + searchtime1 + "', 'YYYY-MM-DD HH24:MI:SS')";
                } else {
                    sqlstr = sqlstr + " and o.createdate >= TO_DATE('" + searchtime1 + "', 'YYYY-MM-DD HH24:MI:SS')";
                }
            } else {
                if (sqlstr.endsWith("1 = 1")) {
                    sqlstr = sqlstr + " and o.createdate >= '" + searchtime1 + "'";
                } else {
                    sqlstr = sqlstr + " and o.createdate >= '" + searchtime1 + "'";
                }
            }

            jumpstr = jumpstr + "&searchtime1=" + searchtime1.substring(0, 10);
        }

        if ((searchtime2 != "") && (searchtime2 != null)) {
            if (dbstr.equals("oracle")) {
                if (sqlstr.endsWith("1 = 1")) {
                    sqlstr = sqlstr + " and o.createdate <= TO_DATE('" + searchtime2 + "', 'YYYY-MM-DD HH24:MI:SS')";
                } else {
                    sqlstr = sqlstr + " and o.createdate <= TO_DATE('" + searchtime2 + "', 'YYYY-MM-DD HH24:MI:SS')";
                }
            } else {
                if (sqlstr.endsWith("1 = 1")) {
                    sqlstr = sqlstr + " and o.createdate <= '" + searchtime2 + "'";
                } else {
                    sqlstr = sqlstr + " and o.createdate <= '" + searchtime2 + "'";
                }
            }
            jumpstr = jumpstr + "&searchtime2=" + searchtime2.substring(0, 10);
        }


        if (sendway != -1) {
            sqlstr = sqlstr + " and o.sendway = " + sendway;
            jumpstr = jumpstr + "&sendway=" + sendway;
        }
        if (orderflag != -1) {
            sqlstr = sqlstr + " and o.orderflag = " + orderflag;
            jumpstr = jumpstr + "&orderflag=" + orderflag;
        }
        if ((username != "") && (username != null)) {
            sqlstr = sqlstr + " and u.username like '@" + username + "@'";
            jumpstr = jumpstr + "&username=" + username;
        }


        sqlstr = sqlstr + " and orderid in (select distinct orderid from tbl_orders_detail";

        if ((porductname != "") && (porductname != null)) {
            sqlstr = sqlstr + " where detailedname like '@" + porductname + "@')";
            jumpstr = jumpstr + "&detailedname=" + porductname;
        } else {
            sqlstr = sqlstr + ")";
        }

        sqlstr = sqlstr + " order by o.createdate desc";
        sqlstr = sqlstr.replaceAll("@", "%");
        list = orderMgr.getOrderList(startrow, 0, status, sqlstr);
        currentlist = orderMgr.getOrderList(startrow, range, status, sqlstr);
        row = currentlist.size();
        rows = list.size();
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
%>
<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <script language="JavaScript" src="../include/setday.js"></script>
    <meta http-equiv="Pragma" content="no-cache">
    <script language="javascript">
        function golist(r) {
            window.location = "nouse.jsp?startrow=" + r;

        }

        function cancelorder(id, userid) {
            var val;
            val = confirm("��ȷ��Ҫ������ݶ�����");
            if (val) {
                window.location = "cancelorder.jsp?orderid=" + id + "&userid=" + userid + "&flag=1";
            }
        }

        function gotosearch() {
            searchForm.action = "putback.jsp";
            searchForm.submit();
        }

        function jumppage(r, str) {
            window.location = "nouse.jsp?startrow=" + r + str;

        }
        function CheckAll(form) {
            for (var i = 0; i < form.elements.length; i++) {
                var e = form.elements[i];
                if (e.name != 'chkAll')
                    e.checked = form.chkAll.checked;
            }
        }

        function check(form) {
            var flag = false;
            for (var i = 0; i < form.elements.length; i++) {
                if (form.elements[i].checked) {
                    flag = true;
                }
            }
            if (!flag) {
                alert("��ѡ���յ�����Ķ�����");
                return false;
            } else {
                var val;
                val = confirm("��ѡ�ж�����ӵ����ջ���ҳ��");
                if (val)
                    return true;
                else
                    return false;
            }
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
            {"������", "index.jsp"}, {"", ""},
            {"�ѷ���", "receive.jsp"}, {"", ""},
            {"�����", "end.jsp"}, {"", ""},
            {"�˻�����", "putback.jsp"}, {"", ""},
            {"���ն���", "refuse.jsp"}, {"", ""},
            {"�ͻ�ȡ��", "qorders.jsp"}, {"", ""},
    };
%>
<%@ include file="../inc/titlebar.jsp" %>

<form action="nouse.jsp" method="post" name="chuku">
<input type="hidden" name="updateflag" value="1">
<center>
<table border="0" cellspacing="0" cellpadding="4" bgcolor="#FFFFFF">
    <tr>
        <td>
            <table width="100%" border="0" cellpadding="0">
                <tr bgcolor="#F4F4F4" align="center">
                    <td class="moduleTitle"><font color="#48758C">�˻������б�</font></td>
                </tr>
                <tr bgcolor="#d4d4d4" align="right">
                    <td>
                        <table width="100%" border="0" cellpadding="2" cellspacing="1">
                            <tr bgcolor="#FFFFFF">
                                <td align="center">������</td>
                                <!--<td align="center">��������</td>-->
                                <!--<td align="center">�û��� </td>-->
                                <td align="center">�ռ�������</td>
                                <td align="center">���ʽ</td>
                                <!--<td align="center">����</td>-->
                                <td align="center">ȡ����ʽ</td>
                                <td align="center">�ܷ���(���ʷ�)</td>
                                <td align="center">ʹ�û���</td>
                                <td align="center">��������</td>
                                <td align="center">��ע</td>
                                <td>&nbsp;</td>
                            </tr>
                            <%
                                DecimalFormat df = new DecimalFormat();
                                df.applyPattern("0.00");
                                DecimalFormat df2 = new DecimalFormat();
                                df2.applyPattern("0");
                                String phone = "";
                                for (int i = 0; i < currentlist.size(); i++) {
                                    order = (Order) currentlist.get(i);
                                    String createdate = String.valueOf(order.getCreateDate());
                                    createdate = createdate == null ? "" : createdate.substring(0, 16);
                                    userid = order.getUserid();
                                    if ((order.getPhone() != null) && (!"".equals(order.getPhone()))) {
                                        phone = order.getPhone();
                                        phone = StringUtil.gb2iso4View(phone);
                                    } else {
                                        phone = orderMgr.getPhone(order.getOrderid());
                                        phone = StringUtil.gb2iso4View(phone);
                                    }
                                    Fee fee = new Fee();
                                    fee = orderMgr.getAFeeInfo(order.getSendWay());
                                    SendWay payway = orderMgr.getASendWayInfo(order.getPayWay());
                            %>
                            <tr bgcolor="#FFFFFF">
                                <td align="center">
                                    <a href="chuku1.jsp?orderid=<%=order.getOrderid()%>"
                                       target=_blank><%=order.getOrderid()%>
                                    </a>
                                </td>
                                <!--<td align="center">-->
                                <%--<%if(order.getOrderFlag() == 0){%>��ͨ����<%}else{%><font color="red">���궩��</font><%}%>--%>
                                <!--</td>-->
                                <!--<td align="center">-->
                                <%--<a href="userorders.jsp?searchflag=1&userid=<%=userid%>" target=_blank>--%>
                                <%--<%=order.getUserName()==null?"--":StringUtil.gb2iso4View(order.getUserName())%>--%>
                                <!--</a>-->
                                <!--</td>-->
                                <td align="center"><%=order.getName() == null ? "" : StringUtil.gb2iso4View(order.getName())%>
                                </td>
                                <td align="center"><%if (payway == null) {%>
                                    ��������<%} else {%><%=payway.getCname() == null ? "--" : StringUtil.gb2iso4View(payway.getCname())%><%}%>
                                </td>
                                <td align="center"><%if (fee == null) {%>
                                    ͬ���ͻ�<%} else {%><%=fee.getCname() == null ? "--" : StringUtil.gb2iso4View(fee.getCname())%>
                                    <%}%>
                                </td>
                                <td align="center"><%=df.format(order.getPayfee())%>
                                </td>
                                <td align="center"><%=order.getUserscores()%>
                                </td>
                                <td align="center"><%=createdate%>
                                </td>
                                <td align="center"><%=order.getNotes() == null ? "" : StringUtil.gb2iso4View(order.getNotes())%>
                                </td>
                                <td align="center"><a href="tostatus.jsp?orderid=<%=order.getOrderid()%>" target=_blank>����״̬</a>
                                </td>
                            </tr>
                            <%}%>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
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
            [<a href="nouse.jsp?startrow=<%=startrow-range%>">��һҳ</a>]
            <%
                }
                if ((startrow + range) < rows) {
            %>
            [<a href="nouse.jsp?startrow=<%=startrow+range%>">��һҳ</a>]
            <%
                }

                if (totalpages > 1) {
            %>
            &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
            <a href="#" onclick="golist((document.all('jump').value-1) * <%=range%>);">GO</a>
            <%
                }

            } else if (searchflag != 0) {
                if ((startrow - range) >= 0) {
            %>
            [<a href="nouse.jsp?startrow=<%=startrow-range%><%=jumpstr%>">��һҳ</a>]
            <%}%>
            <%
                if ((startrow + range) < rows) {
            %>
            [<a href="nouse.jsp?startrow=<%=startrow+range%><%=jumpstr%>">��һҳ</a>]
            <%
                }
                if (totalpages > 1) {
            %>
            &nbsp;&nbsp;��<input type="text" name="jump" value="<%=currentpage%>" size="3">ҳ&nbsp;
            <a href="#" onclick="jumppage((document.all('jump').value-1) * <%=range%>,'<%=jumpstr%>');">GO</a>
            <%
                    }
                }
            %>
        </td>
    </tr>
</table>
</center>
</form>

<center>
    <table width="90%" border="0" cellpadding="0">
        <tr>
            <td background="images/dot-line.gif"></td>
        </tr>
        <tr bgcolor="#d4d4d4" align="right">
            <td bgcolor="#DCE4E7">
                <form name="searchForm" method="post" action="nouse.jsp">
                    <input type="hidden" name="searchflag" value="1">
                    <input type="hidden" name="range" value=<%=range%>>
                    <table width="100%" border="0" cellpadding="2">
                        <tr>
                            <td class="txt"><font color="#59697B"><strong>��ѯ����</strong></font></td>
                        </tr>
                    </table>
                    <table width="100%" border="0" cellpadding="3" cellspacing="1">
                        <tr bgcolor="#FFFFFF">
                            <td width="20%" valign="bottom" class="txt">�����ţ�</td>
                            <td width="30%" valign="top" class="txt">
                                <input type="text" name="orderid" size="15">
                                <font color="#FF0000">&nbsp; </font></td>
                            <td class="txt">&nbsp;</td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td valign="bottom" class="txt">����</td>
                            <td colspan="2" bgcolor="#FFFFFF" class="txt"> ��(��ʼ����)
                                <input type="text" size="10" name="searchtime1" onfocus="setday(this)" readonly>
                                ��(��������)
                                <input type="text" size="10" name="searchtime2" onfocus="setday(this)" readonly>
                            </td>
                        </tr>
                        <!--<tr bgcolor="#FFFFFF">-->
                        <!--<td valign="bottom" class="txt">��Ʒ����(δ���)��</td>-->
                        <!--<td colspan="2" class="txt">-->
                        <!--<input type="text" name="porductname" size="40">-->
                        <!--</td>-->
                        <!--</tr>-->
                        <tr bgcolor="#FFFFFF">
                            <td valign="bottom" class="txt">�û�����</td>
                            <td colspan="2" class="txt">
                                <input type="text" name="username" size="20">
                            </td>
                        </tr>
                        <!--<tr bgcolor="#FFFFFF">-->
                        <!--<td valign="bottom" class="txt">�������ͣ�</td>-->
                        <!--<td colspan="2" class="txt">-->
                        <!--<select name="orderflag">-->
                        <!--<option value="-1">��ѡ��</option>-->
                        <!--<option value="0">��ͨ����</option>-->
                        <!--<option value="1">���궩��</option>-->
                        <!--</select>-->
                        <!--</td>-->
                        <!--</tr>-->
                        <!--<tr bgcolor="#FFFFFF">-->
                        <!--<td valign="bottom" class="txt">ȡ����ʽ(δ���)��</td>-->
                        <!--<td colspan="2" class="txt">-->
                        <!--<select name="sendway">-->
                        <!--<option value="-1">��ѡ��</option>-->
                        <!--<option value="0">��ͨ�ʼ�</option>-->
                        <!--<option value="1">EMS</option>-->
                        <!--<option value="2">�û���ȡ</option>-->
                        <!--</select>-->
                        <!--</td>-->
                        <!--</tr>-->
                        <tr bgcolor="#FFFFFF">
                            <td valign="bottom" class="txt"></td>
                            <td colspan="2" class="txt">
                                <input type="hidden" name="status" value="5">
                            </td>
                        </tr>
                        <tr>
                            <td colspan=3 align="center" valign="center"><input type=button value="��ѯ"
                                                                                onclick="javascript:gotosearch();"></td>
                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>
</center>
</center>
</body>
</html>