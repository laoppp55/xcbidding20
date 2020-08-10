<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    int id = ParamUtil.getIntParameter(request, "id", 0);
    String projcode = ParamUtil.getParameter(request,"projcode");
    String majorcode = ParamUtil.getParameter(request,"majorcode");
    IOrderManager orderMgr = orderPeer.getInstance();
    Training training;
    String classname="";
    String classcode="";
    String price="";


    if (startflag == 1) {
        classname = ParamUtil.getParameter(request, "classname");
        classcode = ParamUtil.getParameter(request, "classcode");
        price  = ParamUtil.getParameter(request, "price");
        try {
            training = new Training();
            training.setClassname(classname);
            training.setClasscode(classcode);
            training.setMajorcode(majorcode);
            training.setProjcode(projcode);
            training.setPrice(Integer.valueOf(price));
            training.setSiteid(authToken.getSiteID());
            orderMgr.updateTrainClass(training,id);
            response.sendRedirect("Trainmajorclass.jsp?success=2&projcode="+projcode+"&majorcode="+majorcode);
            return;
        } catch (OrderException e) {
            e.printStackTrace();
        }
    }else{
        training = orderMgr.getTrainClassById(id);
        classname = training.getClassname();
        classcode = training.getClasscode();
        price =String.valueOf(training.getPrice());
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>修改课程信息</title>
    <style type="text/css">
        <!--
        body {
            margin-top: 0px;
            margin-bottom: 0px;
        }

        -->
    </style>
    <link href="images/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        function checkSurvey(){
            if((addSurveyForm.projname.value == null)||(addSurveyForm.projname.value == "")){
                alert("请输入项目名称");
                return false;
            }
            if((addSurveyForm.brief.value == null)||(addSurveyForm.brief.value == "")){
                alert("请输入项目描述");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
<center>
    <table width="900" border="0" cellpadding="0" cellspacing="0" class="bian">
        <tr>
            <td height="360" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <form method="POST" action="updateTrainclass.jsp" name="addSurveyForm" onsubmit="javascript:return checkSurvey();">
                        <input type="hidden" name="startflag" value="1">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="projcode" value="<%=projcode%>">
                        <input type="hidden" name="majorcode" value="<%=majorcode%>">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/>
                                        </td>
                                        <td width="150" class="black12c">修改课程信息</td>
                                        <td width="697"></td>
                                    </tr>

                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="200" height="1" bgcolor="#898898"></td>
                                        <td width="1" height="1" bgcolor="#898898"></td>
                                        <td height="1" bgcolor="#898898"></td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">课程名称：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="classname" size="80" value="<%=classname%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">课程编码：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="classcode" size="80" value="<%=classcode%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="1" bgcolor="#898898"></td>
                                        <td width="1" height="1" bgcolor="#898898"></td>
                                        <td height="1" bgcolor="#898898"></td>
                                    </tr>
                                    <tr>
                                        <td height="100" align="center" bgcolor="#F6F5F0" class="black12c">课程价格：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="price" size="40" value="<%=price%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="1" bgcolor="#898898"></td>
                                        <td width="1" height="1" bgcolor="#898898"></td>
                                        <td height="1" bgcolor="#898898"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="50">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="300"></td>
                                        <td width="52"><input type="submit" value="提  交" name="survey_submit"></td>
                                        <td width="70"></td>
                                        <td width="52"><input type="reset" value="重  写" name="survey_reset"></td>
                                        <td width="71"></td>
                                        <td width="52"><input type="button" value="返  回" name="survey_back" onclick="window.location = 'index.jsp'"></td>
                                        <td width="300"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </form>
                </table>
            </td>
        </tr>
    </table>
</center>
</body>
</html>