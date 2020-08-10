<%@ page import="com.bizwink.cms.util.*,
                 com.bizwink.cms.register.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.xml.XMLProperties" contentType="text/html;charset=GBK"%>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect("../login.jsp?url=member/editGroup.jsp");
        return;
    }
    if (authToken.getUserID().compareToIgnoreCase("admin") != 0) {
        request.setAttribute("message", "��ϵͳ����Ա��Ȩ��");
        response.sendRedirect("../index.jsp");
        return;
    }

    IRegisterManager regMgr = RegisterPeer.getInstance();
    IColumnManager columnManager = ColumnPeer.getInstance();

    boolean error = false;
    String errormsg = "";
    String extname;
    int pic;
    int tcflag;
    int wapflag;
    int pubflag;
    int bindflag;
    int tagSite = 0;
    int listShow = 0;
    int beRefered;
    int copyColumn;
    int beCopyColumn;
    int pushArticle;
    int moveArticle;

    boolean doUpdate = ParamUtil.getBooleanParameter(request, "doUpdate");
    int siteID = ParamUtil.getIntParameter(request, "siteid", 0);

    if (doUpdate) {
        extname = ParamUtil.getParameter(request, "extname");
        pic = ParamUtil.getIntParameter(request, "pic", 0);
        tcflag = ParamUtil.getIntParameter(request, "tcflag", 0);
        wapflag = ParamUtil.getIntParameter(request, "wapflag", 0);
        pubflag = ParamUtil.getIntParameter(request, "pubflag", 0);
        bindflag = ParamUtil.getIntParameter(request, "bindflag", 0);
        tagSite = ParamUtil.getIntParameter(request, "tagSite", 0);
        listShow = ParamUtil.getIntParameter(request, "listShow", 0);
        beRefered = ParamUtil.getIntParameter(request, "beRefered", 0);
        copyColumn = ParamUtil.getIntParameter(request, "copyColumn", 0);
        beCopyColumn = ParamUtil.getIntParameter(request, "beCopyColumn", 0);
        pushArticle = ParamUtil.getIntParameter(request, "pushArticle", 0);
        moveArticle = ParamUtil.getIntParameter(request, "moveArticle", 0);

        StringBuffer configInfo = new StringBuffer();
        configInfo.append("<Config>");
        configInfo.append("<GlobalTag>" + tagSite + "</GlobalTag>");
        configInfo.append("<PublishListShow>" + listShow + "</PublishListShow>");
        configInfo.append("</Config>");

        try {
            Register register = new Register();
            register.setSiteID(siteID);
            register.setImagesDir(pic);
            register.setTCFlag(tcflag);
            register.setWapFlag(wapflag);
            register.setPubFlag(pubflag);
            register.setBindFlag(bindflag);
            register.setExtName(extname);
            register.setBeRefered(beRefered);
            register.setCopyColumn(copyColumn);
            register.setBeCopyColumn(beCopyColumn);
            register.setPushArticle(pushArticle);
            register.setMoveArticle(moveArticle);
            register.setConfigInfo(configInfo.toString());

            regMgr.update(register);
            errormsg = "վ���޸ĳɹ���";
        }
        catch (Exception e) {
            e.printStackTrace();
            errormsg = "վ���޸�ʧ�ܣ�";
            error = true;
        }
    }

    if (doUpdate) {
        out.println("<script language=javascript>");
        if (error) out.println("alert('" + errormsg + "');");
        out.println("opener.history.go(0);");
        out.println("window.close();");
        out.println("</script>");
        return;
    }

    //������վ����Ϣ
    Register register = regMgr.getSite(siteID);
    extname = columnManager.getIndexExtName(siteID);
    String configInfo = register.getConfigInfo();
    if (configInfo != null && configInfo.length() > 0) {
        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + configInfo);
        tagSite = Integer.parseInt(properties.getProperty("GlobalTag"));
        listShow = Integer.parseInt(properties.getProperty("PublishListShow"));       
    }
    copyColumn = register.getCopyColumn();
    beCopyColumn = register.getBeCopyColumn();
    pushArticle = register.getPushArticle();
    moveArticle = register.getMoveArticle();
%>

<html>
<head>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href=../style/global.css>
    <title>վ���޸�</title>
</head>

<body bgcolor=#cccccc>
<div align="center">
    <form method="POST" action="editSite.jsp" name="RegForm">
        <input type=hidden name="doUpdate" value="true">
        <input type=hidden name="siteid" value="<%=siteID%>">
        <table border="1" width="95%" cellpadding="0" cellspacing="0" borderColorDark=#ffffec borderColorLight=#5e5e00
               align=center>
            <tr>
                <td colspan=2 width="100%" bgcolor="#006699" align="center" height="16"><font color="#FFFFFF"><b>����ѡ�������ȷ��д</b></font>
                </td>
            </tr>
            <tr height="32">
                <td width="35%" align="right">ͼ��洢��ʽ��</td>
                <td width="65%">
                    <input type="radio" value="0" name="pic" <%if(register.getImagesDir()==0){%>checked<%}%>>��Ŀ¼images��
                    <input type="radio" value="1" name="pic" <%if(register.getImagesDir()==1){%>checked<%}%>>����Ŀimages��
                </td>
            </tr>
            <tr height="32">
                <td align="right">֧�ַ��壺</td>
                <td>
                    <input type="radio" value="0" name="tcflag" <%if(register.getTCFlag()==0){%>checked<%}%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" name="tcflag" <%if(register.getTCFlag()==1){%>checked<%}%>>��
                </td>
            </tr>
            <tr height="32">
                <td align="right">֧��WAP��</td>
                <td>
                    <input type="radio" value="0" name="wapflag" <%if(register.getWapFlag()==0){%>checked<%}%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" name="wapflag" <%if(register.getWapFlag()==1){%>checked<%}%>>��
                </td>
            </tr>
            <tr height="32">
                <td align="right">���·�����ʽ��</td>
                <td><input type="radio" value="0" name="pubflag" <%if(register.getPubFlag()==0){%>checked<%}%>>�ֶ�&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" name="pubflag" <%if(register.getPubFlag()==1){%>checked<%}%>>�Զ�
                </td>
            </tr>
            <tr height="32">
                <td align="right">�����б���ʾ����</td>
                <td><input type="radio" value="0" name="listShow" <%if(listShow==0){%>checked<%}%>>������ǰ
                    <input type="radio" value="1" name="listShow" <%if(listShow==1){%>checked<%}%>>ģ����ǰ
                </td>
            </tr>
            <tr height="32">
                <td align="right">�����Ƿ�����վ�����ã�</td>
                <td><input type="radio" value="0" name="beRefered" <%if(register.getBeRefered()==0){%>checked<%}%>>��ֹ����
                    <input type="radio" value="1" name="beRefered" <%if(register.getBeRefered()==1){%>checked<%}%>>֧������
                </td>
            </tr>
            <tr height="32">
                <td align="right">֧��վ���������ã�</td>
                <td><input type="radio" value="0" name="tagSite" <%if(tagSite==0){%>checked<%}%>>��֧��&nbsp;&nbsp;
                    <input type="radio" value="1" name="tagSite" <%if(tagSite==1){%>checked<%}%>>֧��
                </td>
            </tr>
            <tr height="32">
                <td align="right">��Ŀ�Ƿ�����վ�㸴�ƣ�</td>
                <td><input type="radio" value="0" name="beCopyColumn" <%if(beCopyColumn==0){%>checked<%}%>>��ֹ����
                    <input type="radio" value="1" name="beCopyColumn" <%if(beCopyColumn==1){%>checked<%}%>>֧�ָ���
                </td>
            </tr>
            <tr height="32">
                <td align="right">֧��վ����Ŀ���ƣ�</td>
                <td><input type="radio" value="0" name="copyColumn" <%if(copyColumn==0){%>checked<%}%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" name="copyColumn" <%if(copyColumn==1){%>checked<%}%>>��
                </td>
            </tr>
            <tr height="32">
                <td align="right">֧��վ���������ͣ�</td>
                <td><input type="radio" value="0" name="pushArticle" <%if(pushArticle==0){%>checked<%}%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" name="pushArticle" <%if(pushArticle==1){%>checked<%}%>>��
                </td>
            </tr>
            <tr height="32">
                <td align="right">֧��վ�������ƶ���</td>
                <td><input type="radio" value="0" name="moveArticle" <%if(moveArticle==0){%>checked<%}%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" name="moveArticle" <%if(moveArticle==1){%>checked<%}%>>��
                </td>
            </tr>
            <tr height="32">
                <td align="right">վ��״̬��</td>
                <td><input type="radio" value="1" name="bindflag" <%if(register.getBindFlag()==1){%>checked<%}%>>����&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="0" name="bindflag" <%if(register.getBindFlag()==0){%>checked<%}%>>��ͣ
                </td>
            </tr>
            <tr height="32">
                <td align="right">
                    ��ҳ��չ����
                </td>
                <td>&nbsp;<select name=extname size=1 class=tine>
                    <option value="html"  <%=(extname.compareTo("html") == 0) ? "selected" : ""%>>html</option>
                    <option value="htm"   <%=(extname.compareTo("htm") == 0) ? "selected" : ""%>>htm</option>
                    <option value="jsp"   <%=(extname.compareTo("jsp") == 0) ? "selected" : ""%>>jsp</option>
                    <option value="asp"   <%=(extname.compareTo("asp") == 0) ? "selected" : ""%>>asp</option>
                    <option value="shtm"  <%=(extname.compareTo("shtm") == 0) ? "selected" : ""%>>shtm</option>
                    <option value="shtml" <%=(extname.compareTo("shtml") == 0) ? "selected" : ""%>>shtml</option>
                    <option value="php"   <%=(extname.compareTo("php") == 0) ? "selected" : ""%>>php</option>
                    <option value="wml"   <%=(extname.compareTo("wml") == 0) ? "selected" : ""%>>wml</option>
                </select>
                </td>
            </tr>
        </table>
        <p><input type="submit" value=" ���� ">&nbsp;&nbsp;&nbsp;
            <input type="button" value=" ȡ�� " onclick="window.close();"></p>
    </form>
</div>

</body>
</html>
