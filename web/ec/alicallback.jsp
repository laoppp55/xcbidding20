<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-9-23
  Time: 下午7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    Timestamp now = new Timestamp(System.currentTimeMillis());
    Calendar s_cal = Calendar.getInstance();
    s_cal.set(Calendar.YEAR,2020);
    s_cal.set(Calendar.MONTH,3);
    s_cal.set(Calendar.DAY_OF_MONTH,27);
    Timestamp startdate = new Timestamp(s_cal.getTimeInMillis());

    Calendar e_cal = Calendar.getInstance();
    e_cal.set(Calendar.YEAR,2020);
    e_cal.set(Calendar.MONTH,4);
    e_cal.set(Calendar.DAY_OF_MONTH,27);
    Timestamp enddate = new Timestamp(e_cal.getTimeInMillis());
    boolean submit_flag = false;
    if (now.before(enddate) && now.after(startdate)) submit_flag = true;

%>
<html>
<head>
    <title></title>
</head>
<body>

</body>
</html>
