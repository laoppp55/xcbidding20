<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="net.sourceforge.stripes.action.ActionBean" %>
<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
/*    int rownum = ParamUtil.getIntParameter(request, "rownum",0);
    String act = ParamUtil.getParameter(request, "act");
    if (act!=null) {
        if (act.equals("doCreate")) {
            String cname = ParamUtil.getParameter(request,"cname");
            String summary = ParamUtil.getParameter(request,"summary");
            AttachType attachType = null;
            List lists = new ArrayList();
            String clchname = null;
            String clenname = null;
            String cltype = null;
            for(int i=1; i<rownum+1; i++) {
                attachType = new AttachType();
                clchname = ParamUtil.getParameter(request, "chname" + i);
                clenname = ParamUtil.getParameter(request, "enname" + i);
                cltype = ParamUtil.getParameter(request, "classtype" + i);
                attachType.setChname(clchname);
                attachType.setEnname(clenname);
                attachType.setCtype(cltype);
                lists.add(attachType);
                System.out.println("clchname=" + clchname + "==" + clenname + "===" + cltype);
            }

            out.println("<script language=javascript>\n");
            out.println("opener.location.href = \"attachTypeManager.jsp\";\n");
            out.println("window.close();\n");
            out.println("</script>\n");
        }
    }
  */
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <title>�������¸�������</title>
    <script language=javascript>
        var rownum = 0;
        function check(frm)
        {
            if (frm.cname.value == "")
            {
                alert("���¸������ඨ���������Ʋ���Ϊ�գ�");
                return false;
                cname.focus();
            }

            attr.rownum.value=rownum;
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

        function getSelectedText(name){
            var obj=document.getElementById(name);
            for(i=0;i<obj.length;i++){
                if(obj[i].selected==true){
                    return obj[i].innerText; //ͨ��option�����innerText���Ի�ȡ��ѡ���ı���ע��Ҫ����Firefox��ʹ��innerHTML����
                }
            }
        }

        function addrow() {
            var errcode = 0;
            var cname = attr.chiname.value;
            if (cname==null || cname=="") {
                alert("���ඨ���������Ʋ���Ϊ��");
                errcode = 1;
            }

            var ename = attr.engname.value;
            if (ename==null || ename=="") {
                alert("���ඨ��Ӣ�������Ʋ���Ϊ��");
                errcode = 2;
            }

            if (errcode == 0) {
                var newTr = attachtypeid.insertRow();
                var newTd0 = newTr.insertCell();
                var newTd1 = newTr.insertCell();
                var newTd2 = newTr.insertCell();
                var newTd3 = newTr.insertCell();

                //alert('<input type="text" ' + 'name="chname' + rownum + '" value="' + cname + '">');
                rownum = rownum + 1;
                newTd0.innerHTML = '<input type="text" ' + 'name="chname' + rownum + '" value="' + cname + '">';
                newTd1.innerHTML = '<input type="text" ' + 'name="enname' + rownum + '" value="' + ename + '">';
                newTd2.innerHTML = '<input type="text" ' + 'name="classtype' + rownum + '" value="' + getSelectedText('clatype') + '" readonly="true">';
                newTd3.innerHTML = '<input type="button" ' + 'name="del' + rownum + '" value="ɾ��" onclick="javacript:delrow(' + rownum + ')">';
            }
        }

        function delrow(linenum) {
            var _table=document.getElementById("attachtypeid");

            //linenum֮���������ǰ��һ��
            var buf="";
            for(var i=linenum;i<_table.rows.length;i++){
                if (i<_table.rows.length-1) {
                    var nextlinenum = i+1;
                    buf = eval("attr.chname" + nextlinenum + ".value");
                    _table.rows [i].cells[0].innerHTML='<input type="text" ' + 'name="chname' + i + '" value="' + buf + '">';
                    buf = eval("attr.enname" + nextlinenum + ".value");
                    _table.rows [i].cells[1].innerHTML='<input type="text" ' + 'name="enname' + i + '" value="' + buf + '">';
                    buf = eval("attr.classtype" + nextlinenum + ".value");
                    _table.rows [i].cells[2].innerHTML='<input type="text" ' + 'name="classtype' + i + '" value="' + buf + '" readonly="true">';
                    _table.rows [i].cells[3].innerHTML='<input type="button" ' + 'name="del' + i + '" value="ɾ��" onclick="javacript:delrow(' + i + ')">';
                }
            }

            alert("ɾ�����е����һ��");
            _table.deleteRow(_table.rows.length-1);
            rownum = rownum-1;
        }
    </script>
</head>

<body>
<stripes:form name="attr" beanclass="com.bizwink.webaction.AttachTypeActionBean" focus="" onsubmit="javascript:return check(this);">
<!--form name="attr" method="POST" action="com.bizwink.webaction.AttachTypeActionBean" onsubmit="javascript:return check(this);"-->
    <table border="0" width="900" align="center">
        <tr height=80>
            <td width="100%">
                <input type=hidden name=act value=doCreate>
                <input type=hidden name="rownum" value="">
                <table border=0 cellspacing=2 cellpadding=2 width="100%">
                    <tr>
                        <td width="100%">
                            ���¸����������ƣ�<input name="cname" size="70" class=tine value=""><br />
                            ���¸�������������<textarea cols="50" rows="5" name="summary" id="summaryID"></textarea>
                        </td>
                    <tr>
                </table>

                <table border=0 cellspacing=2 cellpadding=2 width="100%">
                    <tr>
                        <td>
                            �����������ƣ�<input name="chiname" size="25" class=tine value="">
                            ����Ӣ�����ƣ�<input name="engname" size="25" class=tine value="">
                            ������ʽ��
                            <select size="1" name="clatype" class=tine style="width:102">
                                <option value="1">��ҳ</option>
                                <option value="2">�ļ��ϴ�</option>
                                <option value="3">ͼƬ</option>
                                <option value="4">��Ƶ</option>
                            </select>
                        </td>
                        <td><input type="button" value="����" name="add" class=tine onclick="javascript:addrow();"></td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td width="100%">
                <table border=1 id="attachtypeid" borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
                    <tr>
                        <td width="25%" align="center"><B>��������</B></td>
                        <td width="25%" align="center"><B>Ӣ������</B></td>
                        <td width="25%" align="center"><B>������ʽ</B></td>
                        <td width="25%" align="center"><B>����</B></td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr height=40>
            <td align=left>
                <input type="checkbox" name="attrscope" id="attrscopeid" value="0">���ñ���Ŀ��������Ʒ��Ŀ
                <input type="submit" value="   ����   " name="save" class=tine >&nbsp;&nbsp;
                <input type="button" value="   �ر�   " name="close" class=tine onclick="window.close();">
            </td>
        </tr>
        <tr><td><font color="red"><b>ע�⣺���������桱��ť����Ҫֱ�ӹرգ�</b></font></td></tr>
    </table>
</stripes:form>
</body>
</html>