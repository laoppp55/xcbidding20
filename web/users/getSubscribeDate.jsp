<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.bizwink.util.JSON" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-29
  Time: 下午10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!	int betweenDays(Date sdate,Date edate){
    Calendar e_cal = Calendar.getInstance();
    e_cal.setTime(edate);

    Calendar s_cal = Calendar.getInstance();
    s_cal.setTime(sdate);
    int betweenDays = (int)((e_cal.getTimeInMillis() - s_cal.getTimeInMillis()) / (1000 * 60 * 60 *24));//先算出两时间的毫秒数之差大于一天的天数

    e_cal.add(Calendar.DAY_OF_MONTH, -betweenDays);//使endCalendar减去这些天数，将问题转换为两时间的毫秒数之差不足一天的情况
    e_cal.add(Calendar.DAY_OF_MONTH, -1);//再使endCalendar减去1天
    if(s_cal.get(Calendar.DAY_OF_MONTH)==e_cal.get(Calendar.DAY_OF_MONTH))//比较两日期的DAY_OF_MONTH是否相等
        betweenDays = betweenDays + 1;	//相等说明确实跨天了

    return betweenDays;
}
%>
<%
    String inDate = ParamUtil.getParameter(request, "indate");                   //从日历上选择的日期
    int tqdays = ParamUtil.getIntParameter(request,"tqdays",5);                  //提前订阅天数，默认是5天
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    System.out.println("tqdays===" + tqdays);

    //用户输入的订报日期
    Date userInDate = dateFormat.parse(inDate);
    Calendar in_cal = Calendar.getInstance();
    in_cal.setTimeInMillis(userInDate.getTime());

    //用户正在进行订报操作的日期
    Date c_date = new Date(System.currentTimeMillis());
    Calendar c_cal = Calendar.getInstance();
    c_cal.setTimeInMillis(c_date.getTime());

    //用户正在进行订报操作的日期加上系统设置的提前订阅天数为实际可以送报的日期
    //tqdays保存的是系统设置的提前订阅天数
    Calendar delivary_cal = Calendar.getInstance();
    delivary_cal.setTime(c_cal.getTime());
    delivary_cal.add(Calendar.DAY_OF_MONTH,tqdays);

    //下个月一号的日期
    Calendar nextMonthFistDay = Calendar.getInstance();
    nextMonthFistDay.setTime(c_cal.getTime());
    nextMonthFistDay.add(Calendar.MONTH, 1);
    nextMonthFistDay.set(Calendar.DAY_OF_MONTH,1);

    //当前日期加提前预定天数的日期在用户输入的预定日期之后，判断当前日期加上提前预定天数之后的日期是否在当前日期下个月1号之前，如果是取下月1号
    //如果当前日期加系统设置的提前预定天数之后的日期在下个月1号之后，取下下个月1号作为预定日期
    String result = "";
    String s_month = "";
    System.out.println(delivary_cal.after(in_cal) + "==" + delivary_cal.before(nextMonthFistDay));
    if (delivary_cal.after(in_cal)) {
        if (delivary_cal.before(nextMonthFistDay)) {
            if (delivary_cal.get(Calendar.DAY_OF_MONTH) > 1) {
                if ((nextMonthFistDay.get(Calendar.MONTH)+1)<10)
                    s_month = "0" + (nextMonthFistDay.get(Calendar.MONTH)+1);
                else
                    s_month = String.valueOf(nextMonthFistDay.get(Calendar.MONTH)+1);
                result = nextMonthFistDay.get(Calendar.YEAR) + "-" + s_month + "-01";
            } else {
                if (delivary_cal.get(Calendar.MONTH)+1<10)
                    s_month = "0" + (delivary_cal.get(Calendar.MONTH)+1);
                else
                    s_month = String.valueOf(delivary_cal.get(Calendar.MONTH)+1);
                result = delivary_cal.get(Calendar.YEAR) + "-" + s_month + "-01";
            }
        } else {
            delivary_cal.add(Calendar.MONTH, 1);
            if ((delivary_cal.get(Calendar.MONTH)+1)<10)
                s_month = "0" + (delivary_cal.get(Calendar.MONTH)+1);
            else
                s_month = String.valueOf(delivary_cal.get(Calendar.MONTH) + 1);
            result = delivary_cal.get(Calendar.YEAR) + "-" + s_month + "-01";
        }
    } else {   //用户输入的订阅日期在当前日期加系统设置的提前预定日期之后，判断用户输入的订阅日期是否是1号，是就取该日期，否取下个月1号
        if(in_cal.get(Calendar.DAY_OF_MONTH) > 1) {
            in_cal.add(Calendar.MONTH,1);               //用户输入日期增加1个月
            if (in_cal.get(Calendar.MONTH)+1<10)
                s_month = "0" + (in_cal.get(Calendar.MONTH)+1);
            else
                s_month = String.valueOf(in_cal.get(Calendar.MONTH)+1);
            result = in_cal.get(Calendar.YEAR) + "-" + s_month + "-01";
        } else {
            if (in_cal.get(Calendar.MONTH)+1<10)
                s_month = "0" + (in_cal.get(Calendar.MONTH)+1);
            else
                s_month = String.valueOf(in_cal.get(Calendar.MONTH)+1);
            result = in_cal.get(Calendar.YEAR) + "-" + s_month + "-01";
        }
    }

    String jsonData = null;
    if (result != null && result!="")
        jsonData =  "{\"result\":\"" + result + "\"}";
    else
        jsonData = "{\"result\":\"error\"}";

    JSON.setPrintWriter(response, jsonData, "utf-8");
%>

