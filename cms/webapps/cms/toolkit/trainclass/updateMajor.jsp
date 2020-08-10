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
    IOrderManager orderMgr = orderPeer.getInstance();
    Training training;
    String major="";
    String majorcode="";
    int nouse=0;


    if (startflag == 1) {
        major = ParamUtil.getParameter(request, "major");
        majorcode = ParamUtil.getParameter(request, "majorcode");
        nouse=ParamUtil.getIntParameter(request, "nouse", 0);

        try {
            training = new Training();
            training.setMajorcode(majorcode);
            training.setMajor(major);
            training.setNouse(nouse);

            orderMgr.updateMajor(training,id);
            response.sendRedirect("Trainmajor.jsp?success=2&projcode="+projcode);
            return;
        } catch (OrderException e) {
            e.printStackTrace();
        }
    }else{
        training = orderMgr.getMajorById(id);
        major = training.getMajor();
        majorcode = training.getMajorcode();
        nouse = training.getNouse();
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>修改项目信息</title>
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
            if((addSurveyForm.major.value == null)||(addSurveyForm.major.value == "")){
                alert("请输入项目名称");
                return false;
            }
            /*if((addSurveyForm.brief.value == null)||(addSurveyForm.brief.value == "")){
                alert("请输入项目描述");
                return false;
            }*/
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
                    <form method="POST" action="updateMajor.jsp" name="addSurveyForm" onsubmit="javascript:return checkSurvey();">
                        <input type="hidden" name="startflag" value="1">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="projcode" value="<%=projcode%>">

                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/>
                                        </td>
                                        <td width="150" class="black12c">修改专业</td>
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
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">专业名称：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="major" size="80" value="<%=major%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">专业编码：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="majorcode" size="80" value="<%=majorcode%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="1" bgcolor="#898898"></td>
                                        <td width="1" height="1" bgcolor="#898898"></td>
                                        <td height="1" bgcolor="#898898"></td>
                                    </tr>
                                    <tr>
                                        <td height="100" align="center" bgcolor="#F6F5F0" class="black12c">项目描述：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<select name="nouse">
                                                        <option value="0" <%=nouse==0?"selected":""%>>未用</option>
                                                        <option value="1" <%=nouse==1?"selected":""%>>启用</option>
                                                  </select>
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