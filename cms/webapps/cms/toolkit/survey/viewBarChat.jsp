<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.jfree.chart.*" %>
<%@ page import="org.jfree.chart.plot.*" %>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page import="java.awt.*" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>
<%@ page import="org.jfree.chart.axis.CategoryAxis" %>
<%@ page import="org.jfree.chart.renderer.category.BarRenderer3D" %>
<%@ page import="org.jfree.chart.axis.ValueAxis" %>
<%@ page import="org.jfree.chart.labels.StandardCategoryItemLabelGenerator" %>
<%@ page import="org.jfree.chart.axis.AxisLocation" %>
<%@ page import="com.bizwink.webapps.survey.define.Define" %>
<%@ page import="com.bizwink.webapps.survey.result.IResultManager" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.survey.result.ResultPeer" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page contentType="text/html;charset=GBK" %>

<%
  int sid = ParamUtil.getIntParameter(request, "sid", -1);
  String qname = ParamUtil.getParameter(request, "qname");
  String questionindex = qname.substring(qname.indexOf("����") + 2);

  IResultManager resultMgr = ResultPeer.getInstance();
  List questionlist = new ArrayList();
  List answerlist = new ArrayList();
  String questionname = "";
  String answername = "";
  int qid = 0;
  Define define = new Define();

  try {
    questionlist = resultMgr.getEachQuestionChatData(sid);
    define = (Define) questionlist.get(Integer.parseInt(questionindex) - 1);
    qid = define.getQid();
    questionname = define.getQname();
    questionname = questionname == null ? "&nbsp;" : StringUtil.iso2gb(questionname);

    answerlist = resultMgr.getEachQuestionAnswersChatData(qid);
  } catch (Exception e) {
    e.printStackTrace();
  }

  DefaultCategoryDataset dataset = new DefaultCategoryDataset();
  for (int i = 0; i < answerlist.size(); i++) {
    define = (Define) answerlist.get(i);
    answername = define.getQanswer();
    answername = answername == null ? "&nbsp;" : StringUtil.iso2gb(answername);
    dataset.addValue(define.getCount(), questionname, answername);
  }

  JFreeChart chart = ChartFactory.createBarChart3D("���� " + questionname + " ����ش���ͳ��ͼ", "��", "�ش�����", dataset,
          PlotOrientation.VERTICAL, true, false, false);
  chart.setBackgroundPaint(Color.WHITE);
  CategoryPlot plot = chart.getCategoryPlot();
  CategoryAxis domainAxis = plot.getDomainAxis();

  plot.setDomainAxis(domainAxis);
  ValueAxis rangeAxis = plot.getRangeAxis();
//������ߵ�һ�� Item ��ͼƬ���˵ľ���
  rangeAxis.setUpperMargin(0.15);
//������͵�һ�� Item ��ͼƬ�׶˵ľ���
  rangeAxis.setLowerMargin(0.15);
  plot.setRangeAxis(rangeAxis);
  BarRenderer3D renderer = new BarRenderer3D();
  renderer.setBaseOutlinePaint(Color.BLACK);
//���� Wall ����ɫ<BR>
  renderer.setWallPaint(Color.gray);
//����ÿ��ˮ�������������ɫ
  renderer.setSeriesPaint(0, new Color(255, 0, 0));
  renderer.setSeriesPaint(1, new Color(0, 100, 255));
  renderer.setSeriesPaint(2, Color.GREEN);
//����ÿ��������������ƽ������֮�����
  renderer.setItemMargin(0.1);
//��ʾÿ��������ֵ�����޸ĸ���ֵ����������<BR>
  renderer.setItemLabelGenerator(new StandardCategoryItemLabelGenerator());
  renderer.setItemLabelFont(new Font("����", Font.PLAIN, 9));
  renderer.setItemLabelsVisible(true);
  plot.setRenderer(renderer);
//��������͸����<BR>
  plot.setForegroundAlpha(0.6f);
//���õ�������������ʾλ��<BR>
  plot.setDomainAxisLocation(AxisLocation.TOP_OR_RIGHT);
  plot.setRangeAxisLocation(AxisLocation.BOTTOM_OR_RIGHT);
  String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, null, session);
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
  <link href="../images/css.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<center>
<table width="900" border="0" cellpadding="0" cellspacing="0" class="bian">
  <%
    if ((questionlist != null) && (questionlist.size() > 0)) {
  %>
  <tr>
    <td height="360" valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="50" height="40" align="center"><img src="../images/qian_02.jpg" width="30" height="30"/></td>
                <td width="700" class="black12c">����ش���ͳ��ͼ</td>
                <td>&nbsp;</td>
              </tr>

            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="1" bgcolor="#898898"></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><img src="<%= graphURL %>" width=500 height=300 border=0 usemap="#map0"></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
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
                <td width="200"></td>
                <td width="180" class="red12"><a href="viewChat.jsp?sid=<%=sid%>">����ˢ���Ի�����µ�ͳ�ƽ����</a></td>
                <td></td>
                <td width="50" class="black12" align=center><a href="viewResult.jsp?sid=<%=sid%>">������ʾ</a></td>
                <td></td>
                <td width="50" class="black12" align=center><a href="#"
                                                               onclick="javascript:window.location='viewChat.jsp?sid=<%=sid%>';">����</a>
                </td>
                <td></td>
                <td width="100" class="black12"><a href="#" onclick="javascript:window.location='index.jsp';">���ع�����ҳ</a>
                </td>
                <td width="200"></td>
              </tr>
            </table>
          </td>
        </tr>

      </table>
    </td>
  </tr>
  <%}%>
</table>
</center>
</body>
</html>



