<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.markManager.*,
                 org.dom4j.*,
                 com.bizwink.cms.xml.XMLProperties,
                 com.bizwink.cms.viewFileManager.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=GBK" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteID = authToken.getSiteID();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");

    IMarkManager markMgr = markPeer.getInstance();
    String cname = "��Ƶ����";
    String notes = "";
    int innerFlag = 0;

    if (doCreate) {
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        String content = ParamUtil.getParameter(request, "content");

        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(content);
        mark.setMarkType(50);
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(innerFlag);

        int orgmarkID = markID;
        if (markID > 0)
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        if (viewer.toLowerCase().indexOf("gecko") == -1)
            out.println("<script>window.returnValue=\"[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]\";window.close();</script>");
        else {
            if (orgmarkID > 0){
                out.println("<script>top.close();</script>");
            }else{
                String returnvalue = "[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]";
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + cname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
        }
        return;
    }

    int width = 0;
    int height = 0;
    String mediatype = "";
    String mediaposi = "";
    if (markID > 0) {
        String str = markMgr.getAMarkContent(markID);
        if (str != null && str != "") {
            str = StringUtil.gb2iso4View(str);
            str = StringUtil.replace(str, "[", "<");
            str = StringUtil.replace(str, "]", ">");
            str = StringUtil.replace(str, "&", "&amp;");
            Element root = null;
            Document doc = DocumentHelper.parseText("<?xml version=\"1.0\"?>" + str);
            System.out.println(str);
            if (doc != null) {
                root = doc.getRootElement();
                if (root!=null) {
                    Element pm = root.element("PLAYMEDIA");
                    Element w = pm.element("WIDTH");
                    if (w!=null) width = Integer.parseInt(w.getStringValue());
                    Element h = pm.element("HEIGHT");
                    if (h!=null) height = Integer.parseInt(h.getStringValue());
                    Element mt = pm.element("MEDIATYPE");
                    if (mt!=null) mediatype = mt.getStringValue();
                    Element mp = pm.element("MEDIAPOSI");
                    if (mp!=null) mediaposi = mp.getStringValue();
                    Element column = pm.element("COLUMNID");
                    if (column!=null) columnID = Integer.parseInt(column.getStringValue());
                    Element cn = pm.element("CHINESENAME");
                    if (cn!=null) cname=cn.getStringValue();
                    Element note = pm.element("NOTES");
                    if (note!=null) notes = note.getStringValue();
                    Element inflag = pm.element("INNERHTMLFLAG");
                    innerFlag = Integer.parseInt(inflag.getStringValue());
                }
            }
        }
    }

%>

<html>
<head>
    <title>��Ƶ���ű��</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <meta http-equiv="Pragma" content="no-cache">
    <link rel=stylesheet type="text/css" href="../style/global.css">
    <script language="javascript" src="../js/video.js"></script>
</head>

<body>
<form action="playermedia.jsp" method="Post" name=markForm>
    <input type=hidden name=content>
    <input type=hidden name=doCreate value=true>
    <input type=hidden name=column value="<%=columnID%>">
    <input type=hidden name=mark value="<%=markID%>">

    <br>
    <table border=0 width="100%">
        <tr align="left">
           <td align="left">��Ļ��ȣ�<input id="wid" name="width" value="<%=(width==0)?"":width%>" maxlength="20" size="15"></td>
           <td align="left">��Ļ�߶ȣ�<input id="hid" name="height" value="<%=(height==0)?"":height%>" maxlength="20" size="15"></td>
        </tr>
        <tr align="left">
            <td align="left">ѡ��ý���ļ����ͣ�</td>
            <td align="left">
                <select name="mediatype">
                    <option value="0">��ѡ��</option>
                    <option value="1" <%=(mediatype.equalsIgnoreCase("1"))?"selected":""%>>FLV</option>
                    <option value="2" <%=(mediatype.equalsIgnoreCase("2"))?"selected":""%>>MP4</option>
                    <option value="3" <%=(mediatype.equalsIgnoreCase("3"))?"selected":""%>>WMV</option>
                </select>
            </td>
        </tr>
        <tr align="left">
            <td align="left">��Ƶ�ļ����λ�ã�</td>
            <td align="left">
                <select name="mediaposi">
                    <option value="0">��ѡ��</option>
                    <option value="1" <%=(mediaposi.equalsIgnoreCase("1"))?"selected":""%>>��Ƶ�ļ�</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan=2>
                <table border=0 cellpadding=2 cellspacing=2 width="100%">
                    <tr>
                        <td>
                            �Ƿ�Ҫ���ɰ����ļ���
                            <input type=radio name=innerFlag value=0 <%if(innerFlag==0){%> checked<%}%>>��
                            <input type=radio name=innerFlag value=1 <%if(innerFlag==1){%> checked<%}%>>��
                        </td>
                    </tr>
                    <tr>
                        <td>����������ƣ�<input name=chineseName size=20 value=<%=cname%> class=tine></td>
                    </tr>
                    <tr>
                        <td>���������<br><textarea rows="5" id="notes" cols="30" class=tine><%=notes%>
                        </textarea></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="100%" align=center colspan=2>
                <input type="button" value="  ȷ��  " onclick="f1('<%=columnID%>');" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type=button value="  ȡ��  " class=tine onclick="top.close();">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
