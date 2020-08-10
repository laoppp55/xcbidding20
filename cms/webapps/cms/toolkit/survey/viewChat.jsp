<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>
<%@ page import="org.jfree.chart.*" %>
<%@ page import="org.jfree.chart.plot.*" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="org.jfree.chart.labels.StandardPieSectionLabelGenerator" %>
<%@ page import="org.jfree.chart.labels.StandardPieToolTipGenerator" %>
<%@ page import="org.jfree.chart.urls.StandardPieURLGenerator" %>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection" %>
<%@ page import="java.io.*" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.survey.define.Define" %>
<%@ page import="com.bizwink.webapps.survey.define.IDefineManager" %>
<%@ page import="com.bizwink.webapps.survey.result.IResultManager" %>
<%@ page import="com.bizwink.webapps.survey.result.ResultPeer" %>
<%@ page import="com.bizwink.webapps.survey.define.DefinePeer" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page contentType="text/html;charset=GBK" %>

<%
  int sid = ParamUtil.getIntParameter(request, "sid", -1);

  IDefineManager defineMgr = DefinePeer.getInstance();
  IResultManager resultMgr = ResultPeer.getInstance();
  List questionlist = new ArrayList();
  String surveyname = "";
  Define define = new Define();

  try {
    questionlist = resultMgr.getEachQuestionChatData(sid);
    define = defineMgr.getADefineSurvey(sid);
    surveyname = define.getSurveyname();
    surveyname = surveyname == null ? "&nbsp;" : StringUtil.iso2gb(surveyname);
  } catch (Exception e) {
    e.printStackTrace();
  }

  DefaultPieDataset data = new DefaultPieDataset();
  for (int i = 0; i < questionlist.size(); i++) {
    define = (Define) questionlist.get(i);
    data.setValue("����" + (i + 1), define.getCount());
  }
  PiePlot3D plot = new PiePlot3D(data);//3D��ͼ
  plot.setURLGenerator(new StandardPieURLGenerator("viewBarChat.jsp?sid=" + sid, "qname"));//�趨����
  plot.setForegroundAlpha(0.5f);
  plot.setLabelGenerator(new StandardPieSectionLabelGenerator(StandardPieSectionLabelGenerator.DEFAULT_SECTION_LABEL_FORMAT));
  plot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator("{0}: ({1}��, {2})"));
  JFreeChart chart = new JFreeChart("", JFreeChart.DEFAULT_TITLE_FONT, plot, true);
  chart.setBackgroundPaint(java.awt.Color.white);//��ѡ������ͼƬ����ɫ
  chart.setTitle("�μ� " + surveyname + " ������Աͳ�Ʊ�");//��ѡ������ͼƬ����
  plot.setToolTipGenerator(new StandardPieToolTipGenerator());
  StandardEntityCollection sec = new StandardEntityCollection();
  ChartRenderingInfo info = new ChartRenderingInfo(sec);
  PrintWriter w = new PrintWriter(out);//���MAP��Ϣ
  //500��ͼƬ���ȣ�300��ͼƬ�߶�
  String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, info, session);
  ChartUtilities.writeImageMap(w, "map0", info, false);
  String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
  <title>������ͼ��</title>
  <style type="text/css">
    <!--
    body {
      margin-top: 0px;
      margin-bottom: 0px;
    }

    -->
  </style>
  <link href="images/css.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<center>
<table width="900" border="0" cellpadding="0" cellspacing="0" class="bian">
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
  <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50" height="40" align="center"><img src="images/qian_02.jpg" width="30" height="30"/></td>
        <td width="700" class="black12c">��������ش���ͳ��ͼ</td>
        <td></td>
      </tr>

    </table>
  </td>
</tr>
<%
  if ((questionlist != null) && (questionlist.size() > 0)) {
%>
<tr>
  <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="1" bgcolor="#898898"></td>
      </tr>
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="30" bgcolor="#F6F5F0">
                <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="200" align="center" class="black12c">������</td>
                    <td width="1" bgcolor="#898898"></td>
                    <td width="696" align="center" class="black12c">��������</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td height="1" bgcolor="#898898"></td>
            </tr>
            <tr>
              <td>
                <%
                  List list = defineMgr.getAllDefineQuestionsBySID(sid);
                  for (int i = 0; i < list.size(); i++) {
                    define = (Define) list.get(i);
                    int qid = define.getQid();
                    String qname = define.getQname();
                %>
                <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="200" align="center" class="black12">����<%=i + 1%>��</td>
                    <td width="1" bgcolor="#898898"></td>
                    <td width="696" height="28" align="center" class="black12"><%=StringUtil.iso2gb(qname)%>
                    </td>
                  </tr>
                  <tr>
                    <td height="1" bgcolor="#898898"></td>
                    <td width="1" height="1" bgcolor="#898898"></td>
                    <td height="1" bgcolor="#898898"></td>
                  </tr>
                </table>
                <%}%>
              </td>
            </tr>
            <tr>
              <td height="30"></td>
            </tr>
            <tr>
              <td align="center"><img src="<%= graphURL %>" width=500 height=300 border=0 usemap="#map0"></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td height="1" bgcolor="#898898"></td>
      </tr>
    </table>
  </td>
</tr>
<tr>
  <td height="50" bgcolor="#F6F5F0">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="150"></td>
        <td width="180" class="red12"><a href="viewChat.jsp?sid=<%=sid%>">����ˢ���Ի�����µ�ͳ�ƽ����</a></td>
        <td></td>
        <td width="50" class="black12" align=center><a href="viewResult.jsp?sid=<%=sid%>">������ʾ</a></td>
        <td></td>
        <td width="100" class="black12" align=center><a href="#" onclick="javascript:window.location='viewSurvey.jsp?sid=<%=sid%>';">���ص���Ԥ��ҳ</a></td>
        <td></td>
        <td width="100" class="black12"><a href="#" onclick="javascript:window.location='index.jsp';">���ع�����ҳ</a></td>
        <td width="150"></td>
      </tr>
    </table>
  </td>
</tr>
<%
  } else {
    out.println("<script type=\"text/javascript\">");
    out.println("alert(\"���鶨�岻�����������������鿴��������\");");
    out.println("window.close();");
    out.println("</script>");
  }
%>

</table>
</td>
</tr>
</table>
</center>
</body>
</html>



