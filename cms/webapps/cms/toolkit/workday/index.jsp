<%@ page import="java.sql.*,
                 java.util.*,
                 java.text.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.calendar.*" contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.toolkit.workday.WorkDay" %>
<%@ page import="com.bizwink.cms.toolkit.workday.IWorkdayManager" %>
<%@ page import="com.bizwink.cms.toolkit.workday.WorkdayPeer" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp?url=member/removeMember.jsp");
        return;
    }

    int siteid = authToken.getSiteID();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String d = ParamUtil.getParameter(request, "d", true);
    String ip = ParamUtil.getParameter(request, "ip", true);
    String formName = ParamUtil.getParameter(request, "form", true);

    java.util.Date dateSelected = new java.util.Date();
    SmartDate smartDate = new SmartDateImpl();

    String WEEK[] = {"��", "һ", "��", "��", "��", "��", "��"};

    java.util.Date dateDebut = new java.util.Date();

    try {
        if (d != null && !d.equals("")) {
            dateSelected = formatter.parse(d);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    dateDebut = smartDate.addMonth(dateSelected, -1);

    IWorkdayManager wMgr = WorkdayPeer.getInstance();
    int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
    if (startflag == 1) {
        List list = new ArrayList();
        String dates = ParamUtil.getParameter(request, "d");
        if (dates != null) {
            dates = dates.substring(0, dates.lastIndexOf("-"));
        }
        int allday = ParamUtil.getIntParameter(request, "alldays", 0);
        for (int i = 1; i <= allday; i++) {
            int daysflag = ParamUtil.getIntParameter(request, "days" + i, 0);
            WorkDay workday = new WorkDay();
            workday.setDayofmonth(i);
            workday.setSiteid(siteid);
            workday.setWorkdaysflag(daysflag);
            list.add(workday);
        }
        wMgr.createWorkdayInfo(dates, list);
    }
    String currentMonth = formatter.format(dateSelected);
    currentMonth = currentMonth.substring(0, currentMonth.lastIndexOf("-"));
    List currentList = wMgr.getWorkDaysInfoForMonth(currentMonth,siteid);
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel=stylesheet HREF="../../style/global.css">
    <script language=JavaScript1.2 src="../../js/public.js"></script>
    <script language=JavaScript1.2 src="../../js/functions.js"></script>
</head>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
    <form name="form" action="index.jsp?d=<%=formatter.format(dateSelected)%>" method="post">
        <input type="hidden" name="startflag" value="1">
        <tr align="center">
            <td height="50">
                �����չ���<font color="red">ע����ɫΪ�����գ���ɫΪ�ǹ�����</font> ��
            </td>
        </tr>
        <tr align="center">
            <td bgcolor="#FFAD0C">
                <a href="index.jsp?d=<%=formatter.format(dateDebut)%>&form=<%=formName%>&ip=<%=ip%>"><img
                        src="../../images/previous_arrow.gif" width="15" height="18" align="absmiddle" border=0
                        alt="�ϸ���"></a>
                <%=smartDate.getYear(dateSelected)%>��<%=smartDate.getMonth(dateSelected)%>��
                <% dateDebut = smartDate.addMonth(dateSelected, 1); %>
                <a href="index.jsp?d=<%=formatter.format(dateDebut)%>&form=<%=formName%>&ip=<%=ip%>"><img
                        src="../../images/next_arrow.gif" width="15" height="18" align="absmiddle" border=0
                        alt="�¸���"></a>
            </td>
        </tr>
        <tr align="center" bgcolor="#000000">
            <td height="5"></td>
        </tr>
        <tr align="center">
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#E6E6E6">
                    <tr align="center">
                        <%
                            for (int i = 0; i < WEEK.length; i++) {
                        %>
                        <TD><%=WEEK[i]%>
                        </TD>
                        <%
                            }
                        %>
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="center">
            <td bgcolor="#E6E6E6">
                <table width="100%" border="0" cellspacing="1" cellpadding="0">
                    <tr align="center" bgcolor="#FFFFFF">
                        <%
                            Calendar tmpCal = Calendar.getInstance();
                            tmpCal.setTime(dateSelected);
                            tmpCal.set(Calendar.DAY_OF_MONTH, 1); //set to be the first day of the selected month
                            dateDebut = tmpCal.getTime(); // dateDebut is the first day of the month
                            int jourDebut = tmpCal.get(Calendar.DAY_OF_WEEK); //the weekday of dateDebut
                            int dateDiff = tmpCal.getActualMaximum(Calendar.DAY_OF_MONTH); //num of days in the selected month
                            java.util.Date dateFin = smartDate.addDay(smartDate.addMonth(dateDebut, 1), -1L);//the last date of the month
                            java.util.Date tmpDate = smartDate.addMonth(dateSelected, -1);
                            tmpCal.set(Calendar.MONTH, smartDate.getMonth(tmpDate) - 1); //last date of last month
                            int maxDaysLastMonth = tmpCal.getActualMaximum(Calendar.DAY_OF_MONTH);
                            tmpCal.set(Calendar.DAY_OF_MONTH, maxDaysLastMonth);
                            int jourOffset = 0;
                            int num;
                            if (jourDebut <= jourOffset) {
                                jourDebut += 7;
                            }
                            jourDebut -= jourOffset;
                            for (int i = 1; i < jourDebut; i++) //print those empty TDs of the first week before the first day of the month
                            {

                        %>
                        <TD>&nbsp;</TD>
                        <%
                            }
                            for (int i = 0; i < dateDiff; i++) {
                                int i_day = smartDate.getDay(dateDebut);
                                num = smartDate.getWeekDay(dateDebut); //���ڼ�
                                //�������ݵķǹ����ձ�־
                                boolean oldflag = false;
                                if (currentList.size() > 0) {
                                    WorkDay workday = (WorkDay) currentList.get(i);
                                    if (workday != null && workday.getWorkdaysflag() == 1) {
                                        oldflag = true;
                                    }
                                }

                                boolean NoWorkDayFlag = false;   //Ĭ�Ϸǹ����ձ�־
                                String colors = "green";//��ɫ��־ ��ɫΪ������ ��ɫΪ�ǹ�����

                                if (oldflag) {
                                    NoWorkDayFlag = true;
                                    colors = "red";
                                } else {
                                    if (num == 1 || num == 7)//��������������Ϊ�ǹ�����
                                    {
                                        NoWorkDayFlag = true;
                                        colors = "red";
                                    }
                                }
                        %>
                        <TD align=center height="40">
                            <%
                                //if it's selected: highlight
                                if (smartDate.getDay(dateDebut) == smartDate.getDay(dateSelected) && smartDate.getMonth(dateDebut) == smartDate.getMonth(dateSelected) && smartDate.getYear(dateDebut) == smartDate.getYear(dateSelected)) {
                            %>
                            <b>
                                <%
                                    }

                                    if (formName != null && ip != null) {
                                %>
                                <table cellpadding="0" cellspacing="0" bgcolor="0" width="100%">
                                    <tr bgcolor="#FFFFFF">
                                        <td height="10" align="center">
                                            <font color="<%=colors%>"><%=i_day%>
                                            </font>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#FFFFFF">
                                        <td height="30">
                                            <input type="radio" name="days<%=i_day%>" value="0"<%if(!NoWorkDayFlag){%>
                                                   checked <%}%>>������<br>
                                            <input type="radio" name="days<%=i_day%>" value="1"<%if(NoWorkDayFlag){%>
                                                   checked <%}%>>�ǹ�����
                                        </td>
                                    </tr>
                                </table>

                                <%
                                } else {
                                %>
                                <table cellpadding="0" cellspacing="0" bgcolor="0" width="100%">
                                    <tr bgcolor="#FFFFFF">
                                        <td height="10" align="center">
                                            <font color="<%=colors%>"><%=i_day%>
                                            </font>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#FFFFFF">
                                        <td height="30">
                                            <input type="radio" name="days<%=i_day%>" value="0"<%if(!NoWorkDayFlag){%>
                                                   checked <%}%>>������<br>
                                            <input type="radio" name="days<%=i_day%>" value="1"<%if(NoWorkDayFlag){%>
                                                   checked <%}%>>�ǹ�����
                                        </td>
                                    </tr>
                                </table>
                                <%
                                    }
                                    if (smartDate.getDay(dateDebut) == smartDate.getDay(dateSelected) && smartDate.getMonth(dateDebut) == smartDate.getMonth(dateSelected) && smartDate.getYear(dateDebut) == smartDate.getYear(dateSelected)) {
                                %>
                            </b>
                            <%
                                }
                            %>
                        </TD>
                        <%
                            if (num == Calendar.SATURDAY) {
                                num = 0;
                        %>
                    </TR>
                    <TR>
                        <%
                                } else {
                                    num++;
                                }
                                dateDebut = smartDate.addDay(dateDebut, 1L);
                            }
                            num = smartDate.getWeekDay(dateDebut);
                            if (num > Calendar.SUNDAY) {
                                for (int i = num; i <= Calendar.SATURDAY; i++) {
                        %>
                        <TD>&nbsp;</TD>
                        <%
                                }
                            }
                        %>
                    </tr>
                </table>
            </td>
        </tr>
        <input type="hidden" name="alldays" value="<%=dateDiff%>">
        <tr align="center" bgcolor="#000000">
            <td height="5"></td>
        </tr>
        <tr align="center">
            <td height="30"><input type="submit" name="sub" value="�ύ"></td>
        </tr>
    </form>
</table>
</body>
</html>