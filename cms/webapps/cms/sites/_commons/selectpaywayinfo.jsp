<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@ page import="com.bizwink.cms.business.Order.Fee" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.business.Order.SendWay" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>
<%@ page import="com.bizwink.cms.xml.XMLProperties" %>
<%@page contentType="text/html;charset=GBK"%>
<%
    int payway = ParamUtil.getIntParameter(request,"payway",-1);
    session.setAttribute("payway",String.valueOf(payway));
     int siteid = ParamUtil.getIntParameter(request, "siteid", 0);     //get siteid
    int markID = ParamUtil.getIntParameter(request, "markid", 0);
    IOrderManager oMgr = orderPeer.getInstance();
    SendWay paywayinfo = new SendWay();
    paywayinfo = oMgr.getASendWayInfo(payway);
    IMarkManager markMgr = markPeer.getInstance();
    String listStyle = "";
        String submit = "";//ȷ�ϰ�ť
        String submitimage = "";//ȷ�ϰ�ťͼƬ
        if (markID > 0) {
            String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(markID));
            str = StringUtil.replace(str, "[", "<");
            str = StringUtil.replace(str, "]", ">");
            str = StringUtil.replace(str, "{^", "[");
            str = StringUtil.replace(str, "^}", "]");

            XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
            listStyle = properties.getProperty(properties.getName().concat(".PAYWAYDISPLAY"));//��ʽ
            submit = properties.getProperty(properties.getName().concat(".PAYWAYDISPLAYSUBMIT"));
            submitimage = properties.getProperty(properties.getName().concat(".PAYWAYDISPLAYIMAGE"));
        }
        if (listStyle != null) {
            listStyle = listStyle.substring(0, listStyle.length() - 1);
        }
    String trstr = paywayinfo.getCname()==null?"": StringUtil.gb2iso4View(paywayinfo.getCname());
    String submits = "";
        if (submit.equals("submit")) {
            submits = "                    <input type='button' name='button1' value='�޸�' onclick='javascript:getPayWay(" + markID + "," + siteid + ");'>&nbsp;\n";
        } else if (submit.equals("images")) {
            submits = "<a href=\"#\" onclick='getPayWay("+ markID + "," + siteid + ");'><img src=\"/_sys_images/buttons/" + submitimage + "\" border=0></a>";
        } else {
            submits = "<a href=\"#\" onclick='getPayWay("+ markID + "," + siteid + ");'>�޸�</a>";
        }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%paywayname%%" + ">", trstr);
    listStyle  = StringUtil.replace(listStyle, "<" + "%%editsubmit%%" + ">", submits);
   //String outstr = "֧����ʽ:" +trstr+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick='javascript:getPayWay("+markID+","+siteid+");'/>�޸�</a>";
    out.print(listStyle);
%>