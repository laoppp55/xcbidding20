<%@ page import="com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
%>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
%>
<html>
<head>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="css/manager.css" type=text/css rel=stylesheet>
    <META content="MSHTML 6.00.6000.16525" name=GENERATOR>
    <style type="text/css">
        <!--
        .STYLE1 {
            color: #FF0000
        }

        -->
    </style>
</head>

<script type="text/javascript">
    function checkNull() {
        if (doAddSites.siteName.value == "") {
            alert("������վ�����ƣ�");
            doAddSites.siteName.focus();
            return false;
        }
        if (doAddSites.textfieldStarturl.value == "") {
            alert("��������ʼURL��");
            doAddSites.textfieldStarturl.focus();
            return false;
        }

        if (document.getElementById("columns").innerHTML == "") {
            alert("��ѡ��ƥ�����Ŀ��");
            return false;
        } else {
            var getColumns = document.getElementById("columns").innerHTML;
            if (getColumns.indexOf("CHECKED") == -1) {
                alert("����ѡ��һ��ƥ�����Ŀ��");
                return false;
            }
        }

        if (eval("document.doAddSites.loginflag1.checked")) {
            if (doAddSites.posturl.value == "") {
                alert("�������¼URL��");
                doAddSites.posturl.focus();
                return false;
            }
        }
        if (eval("document.doAddSites.proxy1.checked")) {
            if (doAddSites.proxyurl.value == "") {
                alert("����������������ַ��");
                doAddSites.proxyurl.focus();
                return false;
            }
            if (doAddSites.proxyport.value == "") {
                alert("���������������˿ڣ�");
                doAddSites.proxyport.focus();
                return false;
            }
            if (eval("document.doAddSites.proxyloginflag1.checked")) {
                if (doAddSites.proxyloginuser.value == "") {
                    alert("����������������¼�û�����");
                    doAddSites.proxyloginuser.focus();
                    return false;
                }
                if (doAddSites.proxyloginpass.value == "") {
                    alert("����������������¼���룡");
                    doAddSites.proxyloginpass.focus();
                    return false;
                }
            }
        }
        return true;
    }
    function openwin() {
        window.open('selectColumnTree.jsp', 'win', 'top=150,left=150,width=500,height=400 scrolling=yes');
    }
    function display(flag) {
        if (flag == 1) {
            loginLayer.style.display = "";
        } else if (flag == 0) {
            loginLayer.style.display = "none";
        } else if (flag == 2) {
            proxyLayer.style.display = "";
        } else if (flag == 3) {
            proxyLayer.style.display = "none";
        } else if (flag == 4) {
            doAddSites.proxyloginuser.disabled = 1;
            doAddSites.proxyloginpass.disabled = 1;
        } else if (flag == 5) {
            doAddSites.proxyloginuser.disabled = 0;
            doAddSites.proxyloginpass.disabled = 0;
        }
    }
    function usedisplay(flag){
        if(flag==0){
           useLayer.style.display = "none";
        }else if(flag==1){
            useLayer.style.display = "";
        }
    }
</script>
<body>
<form id="doAddSites" name="doAddSites" method="post" action="doAddSites.jsp" onSubmit="return checkNull();">
<tbody>
<table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
<tr>
    <td colspan=6 class=title>���վ��</td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

    <td width="15%">վ������<span class="STYLE1">*</span></td>
    <td colspan="5"><input type="text" name="siteName"></td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

    <td width="86">��ʼURL<span class="STYLE1">*</span></TD>
    <td colspan="5"><label>
        <input name="textfieldStarturl" type="text" id="textfieldStarturl" size="100">
    </label></TD>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
    <td>ƥ�����Ŀ<span class="STYLE1">*</span></td>
    <input type="hidden" name="columnid" id="columnid">
    <td colspan=5><!--input type="text" name="classid" id="classid" readonly-->
        <a href="javascript:openwin();">ѡ����Ŀ</a>
        <span id="columns"></span>
    </td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
    <td>ʹ��ȫ�ֹؼ���</td>
    <td colspan=5><input type="radio" name="use" id="use0" value="0" checked onClick="usedisplay(0);">ʹ��&nbsp;&nbsp;
        <input type="radio" name="use" id="use1" value="1" onClick="usedisplay(1);">��ʹ��
    </td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
    <td>վ���¼����</td>
    <td colspan=5><input type="radio" name="loginflag" id="loginflag0" value="0" checked onClick="display(0);">����Ҫ��¼&nbsp;&nbsp;
        <input type="radio" name="loginflag" id="loginflag1" value="1" onClick="display(1);">��Ҫ��¼
    </td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
    <td>��������</td>
    <td colspan=5><input type="radio" name="proxy" id="proxy0" value="0" checked onClick="display(3);">�̳�ϵͳ����&nbsp;&nbsp;
        <input type="radio" name="proxy" id="proxy1" value="1" onClick="display(2);">�Զ�������&nbsp;&nbsp;
        <input type="radio" name="proxy" id="proxy2" value="2" onClick="display(3);">��ʹ�ô���
    </td>
</tr>
</table>
<div id="useLayer" style='display:none;'>
    <table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

    <td>����ؼ���</td>
    <td colspan="5"><label><input name="TRules" type="text" size="100">
    </label>'|'���ϵ��'+'���ϵ
    </td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

    <td>���Ĺؼ���</td>
    <td colspan="5"><label><input name="BRules" type="text" size="100">
    </label>'|'���ϵ��'+'���ϵ
    </td>
</tr>
<TR onmouseover='this.style.backgroundColor="#E0EAF5"'
    onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

    <td height="20">���ĺͱ���Ĺ�ϵ</td>
    <td colspan="5"><label>
        <input type="radio" name="tbrelation" value="2" checked>
        ��&nbsp;&nbsp;
        <input type="radio" name="tbrelation" value="1">
        ��</label></td>
</tr>
    </table>
</div>
<div id="loginLayer" style='display:none;'>
    <table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td width="15%">��¼��URL<span class="STYLE1">*</span></td>
            <td><input type="text" name="posturl" id="posturl" size="100"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>���ݵĲ���</td>
            <td><input type="text" name="postdata" id="postdata" size="100"></td>
        </tr>
    </table>
</div>
<div id="proxyLayer" style='display:none;'>
    <table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td width="15%">�����������ַ<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyurl" id="proxyurl" size="100"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�˿�<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyport" id="proxyport" size="4"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�����¼����</td>
            <td colspan=5><input type="radio" name="proxyloginflag" id="proxyloginflag0" value="0"
                                 onClick="display(4);" checked>����Ҫ��¼&nbsp;&nbsp;
                <input type="radio" name="proxyloginflag" id="proxyloginflag1" value="1"
                       onClick="display(5);">��Ҫ��¼
            </td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�����¼�û���<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyloginuser" id="proxyloginuser" size="50"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�����¼����<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyloginpass" id="proxyloginpass" size="50"></td>
        </tr>
    </table>
</div>
<table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td colspan=6 align="center">
            <input type="submit" name="Submit" value=" �ύ ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="reset" name="Submit2" value=" ���� ">
        </td>
    </tr>
    <tr>
        <td class=title5 colspan=6 align="right"><a href="index.jsp">������ﷵ��</a></td>
    </tr>
</table>
</tbody>
</form>
<script type="text/javascript">
    doAddSites.proxyloginuser.disabled = 1;
    doAddSites.proxyloginpass.disabled = 1;
</script>
</body>
</html>