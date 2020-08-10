
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@ page import="com.bizwink.cms.business.Order.Fee" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>
<%@ page import="com.bizwink.cms.xml.XMLProperties" %>
<%@page contentType="text/html;charset=GBK"%>
<%
    int sendway = ParamUtil.getIntParameter(request,"sendway",-1);
    int sendtime= ParamUtil.getIntParameter(request,"sendtime",-1);
     int siteid = ParamUtil.getIntParameter(request, "siteid", 0);     //get siteid
    int markID = ParamUtil.getIntParameter(request, "markid", 0);
    session.setAttribute("sendway",String.valueOf(sendway));
    session.setAttribute("sendtime",String.valueOf(sendtime));
    IOrderManager oMgr = orderPeer.getInstance();
    Fee fee = new Fee();
    fee= oMgr.getAFeeInfo(sendway);
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
            listStyle = properties.getProperty(properties.getName().concat(".SENDWAYDISPLAY"));//��ʽ
            submit = properties.getProperty(properties.getName().concat(".SENDWAYDISPLAYSUBMIT"));
            submitimage = properties.getProperty(properties.getName().concat(".SENDWAYDISPLAYIMAGE"));
        }
        if (listStyle != null) {
            listStyle = listStyle.substring(0, listStyle.length() - 1);
        }
    String trstr = fee.getCname()==null?"": StringUtil.gb2iso4View(fee.getCname());
    String submits = "";
        if (submit.equals("submit")) {
            submits = "                    <input type='button' name='button1' value='�޸�' onclick='javascript:getSendWay(" + markID + "," + siteid + ");'>&nbsp;\n";
        } else if (submit.equals("images")) {
            submits = "<a href=\"#\" onclick='getSendWay("+ markID + "," + siteid + ");'><img src=\"/_sys_images/buttons/" + submitimage + "\" border=0></a>";
        } else {
            submits = "<a href=\"#\" onclick='getSendWay("+ markID + "," + siteid + ");'>�޸�</a>";
        }
    String linktime = "";
    if(sendtime == 0){
        linktime = "�����ա�˫��������վ����ͻ�";
    }
    else if(sendtime == 1){
        linktime = "ֻ�������ͻ�(˫���ա����ղ�����)";
    }
    else{
         linktime = "ֻ˫���ա������ͻ�(�����ղ�����)";
    }
    listStyle  = StringUtil.replace(listStyle, "<" + "%%sendwayname%%" + ">", trstr);
    listStyle  = StringUtil.replace(listStyle, "<" + "%%linktime%%" + ">", linktime);
    listStyle  = StringUtil.replace(listStyle, "<" + "%%editsubmit%%" + ">", submits);
    //String outstr = "�ͻ���ʽ:" +trstr+"&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick='javascript:getSendWay("+markID+","+siteid+");'/>�޸�</a>";
    out.print(listStyle);
%>