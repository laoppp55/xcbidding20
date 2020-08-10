<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.*" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=系统超时，请重新登陆!"));
        return;
    }
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    String projcode = ParamUtil.getParameter(request,"projcode");
    String majorcode=ParamUtil.getParameter(request,"majorcode");

    if (startflag == 1) {
        String classname = ParamUtil.getParameter(request,"classname");
        String classcode = ParamUtil.getParameter(request,"classcode");
        String price  = ParamUtil.getParameter(request, "price");
        try {
            IOrderManager orderMgr = orderPeer.getInstance();
            Training training = new Training();
            training.setMajorcode(majorcode);
            training.setProjcode(projcode);
            training.setClassname(classname);
            training.setClasscode(classcode);
            training.setPrice(Integer.valueOf(price));
            training.setSiteid(authToken.getSiteID());
            orderMgr.addTrainClass(training);
            response.sendRedirect("Trainmajorclass.jsp?success=1&projcode="+projcode+"&majorcode="+majorcode);
            return;
        } catch (OrderException e) {
            e.printStackTrace();
        }
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>添加新课程</title>
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
            if((addSurveyForm.classname.value == null)||(addSurveyForm.classname.value == "")){
                alert("请输入课程名称");
                return false;
            }
            if((addSurveyForm.classcode.value == null)||(addSurveyForm.classcode.value == "")){
                alert("请输入课程编码");
                return false;
            }
            if((addSurveyForm.price.value == null)||(addSurveyForm.price.value == "")){
                alert("请输入课程编码");
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
                    <form method="POST" action="addclass.jsp" name="addSurveyForm" onsubmit="javascript:return checkSurvey();">
                        <input type="hidden" name="startflag" value="1">
                        <input type="hidden" name="projcode" value="<%=projcode%>">
                        <input type="hidden" name="majorcode" value="<%=majorcode%>">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/>
                                        </td>
                                        <td width="150" class="black12c">添加新课程</td>
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
                                            &nbsp;&nbsp;<input type="text" name="classname" size="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">课程编码：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="classcode" size="40">
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
                                            &nbsp;&nbsp;<input type="text" name="price" size="40">
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