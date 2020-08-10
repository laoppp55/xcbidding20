<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.security.*,
                 org.jdom.*,
                 com.bizwink.cms.util.*,
                 org.jdom.input.*,
                 java.io.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.extendZhuce.ExtendZhuce" %>
<%@ page import="com.bizwink.cms.extendZhuce.IExtendZhuceManager" %>
<%@ page import="com.bizwink.cms.extendZhuce.ExtendZhucePeer" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int id = ParamUtil.getIntParameter(request, "id", 0);
    int siteid = authToken.getSiteID();
    String errormsg = "";
    boolean error = false;
    int columnID = ParamUtil.getIntParameter(request, "ID", 0);
    int from = ParamUtil.getIntParameter(request, "from", 0);   //from=1������ҳ
    String act = ParamUtil.getParameter(request, "act");
    IColumnManager columnMgr = ColumnPeer.getInstance();


    //����
    if (act != null && act.equals("doCreate")) {
        int width = 0;
        int height = 0;
        String cname = ParamUtil.getParameter(request, "cname");
        String ename = ParamUtil.getParameter(request, "ename");
        String type = ParamUtil.getParameter(request, "type");
        if (type.equals("�ļ��ϴ�")) {
            width = ParamUtil.getIntParameter(request, "width", 0);
            height = ParamUtil.getIntParameter(request, "height", 0);
        }

        if (cname == null || cname.trim().length() == 0 || ename == null || ename.trim().length() == 0) {
            error = true;
            errormsg = "<p align=center><font color=red><b>������չ���Գ���</b></font></p>";
        }


        if (!error) {
            ExtendZhuce exz = new ExtendZhuce();
            IExtendZhuceManager extendzhuceMgr = ExtendZhucePeer.getInstance();
            exz.setSiteid(siteid);
            exz.setCname(cname);
            exz.setEname(ename);
            exz.setType(type);
            id = extendzhuceMgr.insertExtendZhuce(exz);
        }
        //response.sendRedirect("editattr.jsp?act=doNothing&from="+from+"&ID="+columnID);
        out.println("<script language=javascript>var kuozhan='" + type + "," + cname + "," + ename + "," + id + "';var isMSIE = (navigator.appName == \"Microsoft Internet Explorer\");\n" +
                "            if (isMSIE) {\n" +
                "                window.returnValue = kuozhan;\n" +
                "                window.close();\n" +
                "            } else {\n" +
                "                window.parent.opener.top.InsertHTML('content',kuozhan);\n" +
                "                top.close();\n" +
                "            }window.close();</script>");
    }
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <title>��չ����</title>
    <script language=javascript>
        function check(frm)
        {
            if (frm.cname.value == "")
            {
                alert("��չ�����������Ʋ���Ϊ�գ�");
                return false;
                cname.focus();
            }
            if (frm.ename.value == "")
            {
                alert("��չ����Ӣ�����Ʋ���Ϊ�գ�");
                return false;
                ename.focus();
            }
            if (!checkEname(frm.ename.value))
            {
                alert("��������ȷ��Ӣ�����ƣ�");
                return false;
                ename.focus();
            }
            return true;
        }

        function checkEname(ename)
        {
            var retstr = false;
            var regstr = /[^a-zA-Z0-9_]/gi;
            if (regstr.exec(ename) == null)
            {
                retstr = true;
            }
            return retstr;
        }

        function control()
        {
            if (document.all("type").value == "�ļ��ϴ�")
                picattr.style.display = "";
            else
                picattr.style.display = "none";
        }
    </script>
</head>
<base target="_self"/>
<body>
<form name="attr" method="POST" action="editzhuce.jsp?from=<%=from%>&ID=<%=columnID%>"
      onsubmit="javascript:return check(this);">
    <input type=hidden name=act value=doCreate>
    <input type=hidden name=id value=<%=id%>
    <table border="0" width="580" align="center">
        <tr>
            <td><%=errormsg%>
            </td>
        </tr>
        <tr height=80>
            <td width="100%">
                        <table border=0 cellspacing=2 cellpadding=2 width="100%">
        <tr>
            <td width="60%">
                �������ƣ�<input name="cname" size="15" class=tine>
                Ӣ�����ƣ�<input name="ename" size="15" class=tine></td>
            <td width="40%">
                <div style="display:none" id=picattr>
                    <b>��</b>��<input name="width" size="4" class=tine>
                    <b>��</b>��<input name="height" size="4" class=tine></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                �ؼ����ͣ�<select size="1" name="type" class=tine style="width:102" onchange="control();">
                <option value="�����ı�">�����ı�</option>
                <option value="�����ı�">�����ı�</option>
                <option value="�ļ��ϴ�">�ļ��ϴ�</option>
                <option value="��ѡ��ť">��ѡ��ť</option>
                <option value="��ѡ��ť">��ѡ��ť</option>
            </select></td>
        </tr>
    </table>
    </td>
    </tr>

    <tr height=40>
        <td align=left>
            <input type="checkbox" name="attrscope" id="attrscopeid" value="0">���ñ���Ŀ��������Ʒ��Ŀ
            <input type="submit" value="   ����   " name="submit" class=tine>&nbsp;&nbsp;
            <input type="button" value="   �ر�   " name="close" class=tine onclick="window.close();">
        </td>
    </tr>
    <tr>
        <td><font color="red"><b>ע�⣺���������桱��ť����Ҫֱ�ӹرգ�</b></font></td>
    </tr>
    </table>
</form>
</body>
</html>