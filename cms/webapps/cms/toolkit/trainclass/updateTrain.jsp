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
    int proid = ParamUtil.getIntParameter(request, "proid", 0);
    IOrderManager orderMgr = orderPeer.getInstance();
    Training training;
    String projname="";
    String projcode="";
    String brief="";


    if (startflag == 1) {
        projname = ParamUtil.getParameter(request, "projname");
        projcode = ParamUtil.getParameter(request, "projcode");
        brief  = ParamUtil.getParameter(request, "brief");
        try {
            training = new Training();
            training.setProjname(projname);
            training.setProjcode(projcode);
            training.setBrief(brief);
            training.setSiteid(authToken.getSiteID());
            orderMgr.updateProject(training,proid);
            response.sendRedirect("index.jsp?success=2");
            return;
        } catch (OrderException e) {
            e.printStackTrace();
        }
    }else{
        training = orderMgr.getTrainProjectById(proid);
        projname = training.getProjname();
        projcode = training.getProjcode();
        brief = training.getBrief();
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
                    <form method="POST" action="updateTrain.jsp" name="addSurveyForm" onsubmit="javascript:return checkSurvey();">
                        <input type="hidden" name="startflag" value="1">
                        <input type="hidden" name="proid" value="<%=proid%>">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/>
                                        </td>
                                        <td width="150" class="black12c">修改项目</td>
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
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">项目名称：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="projname" size="80" value="<%=projname%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" align="center" bgcolor="#F6F5F0" class="black12c">项目编码：</td>
                                        <td width="1" bgcolor="#898898"></td>
                                        <td>
                                            &nbsp;&nbsp;<input type="text" name="projcode" size="80" value="<%=projcode%>">
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
                                            &nbsp;&nbsp;<textarea rows="6" name="brief" cols="80"><%=brief%></textarea>
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