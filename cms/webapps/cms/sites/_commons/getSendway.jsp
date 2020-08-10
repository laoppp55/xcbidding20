<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.business.Order.IOrderManager" %>
<%@ page import="com.bizwink.cms.business.Order.orderPeer" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.business.Order.Fee" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>
<%@ page import="com.bizwink.cms.xml.XMLProperties" %>
<%@page contentType="text/html;charset=GBK" %>
<%

    int siteid = ParamUtil.getIntParameter(request, "siteid", 0);     //get siteid
    int markID = ParamUtil.getIntParameter(request, "markid", 0);
    //�Ѿ�ѡ����ͻ���ʽ
    String sendwaystr = (String) session.getAttribute("sendway");
    //�Ѿ�ѡ����ͻ�ʱ��
    String sendtime = (String)session.getAttribute("sendtime");
    //���վ���ͻ���ʽ
    IOrderManager oMgr = orderPeer.getInstance();
    List list = new ArrayList();
    list = oMgr.getAllFeeInfo(siteid);
    //��ñ����Ϣ
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
        listStyle = properties.getProperty(properties.getName().concat(".SENDWAY"));//��ʽ
        submit = properties.getProperty(properties.getName().concat(".SENDWAYSUBMIT"));
        submitimage = properties.getProperty(properties.getName().concat(".SENDWAYIMAGE"));
    }
    if (listStyle != null) {
        listStyle = listStyle.substring(0, listStyle.length() - 1);
    }

    if (list.size() > 0) {

        for (int i = 0; i < list.size(); i++) {

            String checkstr = " >";
            Fee fee = (Fee) list.get(i);
            String name = fee.getCname() == null ? "" : StringUtil.gb2iso4View(fee.getCname());
            String notes = fee.getNotes() == null ? "" : "(" + StringUtil.gb2iso4View(fee.getNotes()) + ")";
            String feestr = "";
            if (fee.getFee() == 0) {
                feestr = "";
            } else {
                feestr = String.valueOf(fee.getFee());
            }
            if (sendwaystr != null) {
                if(sendwaystr.equals(String.valueOf(fee.getId())))
                {
                     checkstr = " checked>";
                }
            } else {
                if (i == 0) {
                    checkstr = " checked>";
                    session.setAttribute("sendway", String.valueOf(fee.getId()));
                }
            }
            String ids = String.valueOf(fee.getId());
            String values = "<input type=radio name=sendway value=" + fee.getId() + checkstr + name + ":" + feestr + notes + "<br>";
            listStyle = StringUtil.replace(listStyle, "<" + "%%" + ids + "%%" + ">", values);
            //outstr = outstr + "<tr><td align=left><input type=radio name=sendway value=" + fee.getId() + checkstr + name + ":" + feestr + notes + "</td></tr>";
        }
        String submits = "";
        if (submit.equals("submit")) {
            submits = "                    <input type='button' name='button1' value='ȷ��' onclick='javascript:submitSendway(" + markID + "," + siteid + ");'>&nbsp;\n";
        } else if (submit.equals("images")) {
            submits = "<a href=\"#\" onclick='submitSendway("+ markID + "," + siteid + ");'><img src=\"/_sys_images/buttons/" + submitimage + "\" border=0></a>";
        } else {
            submits = "<a href=\"#\" onclick='submitSendway("+ markID + "," + siteid + ");'>ȷ��</a>";
        }
        //�ͻ�ʱ��
        String linktime = "";
        if(sendtime == null || sendtime.equals("") || sendtime.equalsIgnoreCase("null"))
        {
            linktime = "<input type=\"radio\" name=\"linktime\" value=\"0\" checked>�����ա�˫��������վ����ͻ�<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"1\">ֻ�������ͻ�(˫���ա����ղ�����)<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"2\">ֻ˫���ա������ͻ�(�����ղ�����)";
        }else{
            if(sendtime.equals("0")){
                  linktime = "<input type=\"radio\" name=\"linktime\" value=\"0\" checked>�����ա�˫��������վ����ͻ�<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"1\">ֻ�������ͻ�(˫���ա����ղ�����)<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"2\">ֻ˫���ա������ͻ�(�����ղ�����)";
            }else if(sendtime.equals("1")){
                 linktime = "<input type=\"radio\" name=\"linktime\" value=\"0\">�����ա�˫��������վ����ͻ�<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"1\" checked>ֻ�������ͻ�(˫���ա����ղ�����)<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"2\">ֻ˫���ա������ͻ�(�����ղ�����)";
            }else{
                 linktime = "<input type=\"radio\" name=\"linktime\" value=\"0\">�����ա�˫��������վ����ͻ�<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"1\">ֻ�������ͻ�(˫���ա����ղ�����)<br>" +
                    "<input type=\"radio\" name=\"linktime\" value=\"2\" checked>ֻ˫���ա������ͻ�(�����ղ�����)";
            }
        }

        listStyle  = StringUtil.replace(listStyle, "<" + "%%linktime%%" + ">", linktime);
        listStyle  = StringUtil.replace(listStyle, "<" + "%%submitbutton%%" + ">", submits);
        //outstr = outstr + "<tr><td align='center' valign='top'><input type=button name=button value=�ύ onClick='javascript:selectSendway();'></td></tr></table>";
        out.write(listStyle);
    } else {
        String outstr = "<table width='80%' border='0' cellpadding='0' cellspacing='0'>\n" +
                "<tr><td align=left>�ͻ���ʽ</td></tr><tr><td align=left><input type=radio name=sendway value=0 checked>ͬ���ͻ�(���)</td></tr>" +
                "<tr><td align='center' valign='top'><input type=button name=button value=�ύ onClick='javascript:selectSendway();'></td></tr></table>";
        out.write(outstr);
    }
%>