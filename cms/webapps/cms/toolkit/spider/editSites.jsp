<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.collectionmgr.*" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int basicId = ParamUtil.getIntParameter(request, "basicId", -1);
    int pagenum = ParamUtil.getIntParameter(request, "pageid", -1);

    IBasic_AttributesManager baMgr = Basic_AttributesPeer.getInstance();
    Basic_Attributes ba = baMgr.getBasic_Attributes(basicId);
    int keywordflag = ba.getKeywordflag();

    GlobalConfig gc = null;
    List getcolumnsList = baMgr.getColumnNames(basicId);
    int loginflag = ba.getLoginflag();
    int proxyflag = ba.getProxyflag();
    int proxyloginflag = 0;
    int columnid = ba.getClassId();
    String proxyloginuser = "";
    String proxyloginpass = "";
    String proxyurl = "";
    String proxyport = "";
    if (proxyflag == 1) {
        gc = baMgr.getProxyConfigOfSite(basicId);
        proxyurl = gc.getProxyName();
        proxyport = gc.getProxyPort();
        proxyloginflag = gc.getProxyloginflag();
        proxyloginuser = gc.getProxyloginuser();
        proxyloginpass = gc.getProxyloginpass();
    }

    String tkeyword = "";
    String bkeyword = "";
    int tbrelation = 2;
    Basic_Attributes keyword;
    if (keywordflag == 1) {
        keyword = baMgr.getKeywordsOfSite(basicId);
        if (keyword != null) {
            tkeyword = keyword.getTKeyword();
            bkeyword = keyword.getBKeyword();
            tbrelation = keyword.getTbRelation();
        }
    } else {
        gc = baMgr.getGlobalKeyword();
        if (gc != null) {
            tkeyword = gc.getTkeyword();
            bkeyword = gc.getBkeyword();
            tbrelation = gc.getTbrelation();
        }
    }
    tkeyword = tkeyword == null ? "" : tkeyword;
    bkeyword = bkeyword == null ? "" : bkeyword;
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
    function check() {
        if (editForm.siteName.value == "") {
            alert("������վ�����ƣ�");
            editForm.siteName.focus();
            return false;
        }
        if (editForm.textfieldStarturl.value == "") {
            alert("��������ʼURL��");
            editForm.textfieldStarturl.focus();
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

        if (eval("document.editForm.loginflag1.checked")) {
            if (editForm.posturl.value == "") {
                alert("�������¼URL��");
                editForm.posturl.focus();
                return false;
            }
        }
        if (eval("document.editForm.proxy1.checked")) {
            if (editForm.proxyurl.value == "") {
                alert("����������������ַ��");
                editForm.proxyurl.focus();
                return false;
            }
            if (editForm.proxyport.value == "") {
                alert("���������������˿ڣ�");
                editForm.proxyport.focus();
                return false;
            }
        }
        return true;
    }

    function openwin() {
        window.open('selectColumnTree.jsp', 'win', 'top=150,left=150,width=600,height=400 scrolling=yes');
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
        }
    }
    function usedisplay(flag) {
        if (flag == 0) {
            useLayer.style.display = "none";
        } else if (flag == 1) {
            <%
                if(keywordflag == 0){
            %>
            editForm.TRules.value = "";
            editForm.BRules.value = "";
            editForm.tbrelation[0].checked = true;
            <%}%>
            useLayer.style.display = "";
        }
    }
</script>

<body>
<form id="editForm" name="editForm" method="post" action="doEditSites.jsp" onSubmit="return check();">
<tbody>
<table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
    <tr>
        <td class="title" colspan="6">�޸�վ������</td>
    </tr>
    <input name="basicId" id="basicId" type="hidden" value="<%=basicId%>">
    <input name="pageid" id="pageid" type="hidden" value="<%=pagenum%>">
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td width="15%">վ������<span class="STYLE1">*</span></td>
        <td colspan="5">
            <input type="text" name="siteName"
                   value="<%=(ba.getSiteName()==null?"":ba.getSiteName())%>"/>
        </td>
    </tr>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td width="86">��ʼURL<span class="STYLE1">*</span></TD>
        <td colspan="5"><label>
            <input name="textfieldStarturl" type="text" id="textfieldStarturl" size="100"
                   value="<%=ba.getStartUrl()==null?"":ba.getStartUrl()%>"/>
        </label></TD>
    </tr>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td>ƥ�����Ŀ<span class="STYLE1">*</span></td>
        <input type="hidden" name="columnid" id="columnid" value="<%=columnid%>">
        <td colspan=5>
            <a href="javascript:openwin();">
                ѡ����Ŀ</a>
            <span id="columns">
            <%
                for (int i = 0; i < getcolumnsList.size(); i++) {
                    Basic_Attributes bas = (Basic_Attributes) getcolumnsList.get(i);
                    String cname = bas.getCname();
//                    cname = new String(cname.getBytes("ISO8859-1"), "GBK");
            %>
                <input type="checkbox" name="selectcolumns" value="<%=bas.getClassId()%>" checked><%=cname%>
            <%
                }
            %>
            </span>
        </td>
    </tr>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td>ʹ��ȫ�ֹؼ���</td>
        <td colspan=5>
            <input type="radio" name="use" value="0"
                   onClick="usedisplay(0);" <%if(ba.getKeywordflag()==0)out.print("checked");%>>ʹ��&nbsp;&nbsp;
            <input type="radio" name="use" value="1" 
                             onClick="usedisplay(1);" <%if(ba.getKeywordflag()==1)out.print("checked");%>>��ʹ��
        </td>
    </tr>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td>վ���¼����</td>
        <td colspan=5><input type="radio" name="loginflag" id="loginflag0" value="0" onClick="display(0);"
        <%if(loginflag==0)out.print("checked");%>>����Ҫ��¼&nbsp;&nbsp;
            <input type="radio" name="loginflag" id="loginflag1" value="1" onClick="display(1);"
            <%if(loginflag==1)out.print("checked");%>>��Ҫ��¼
        </td>
    </tr>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td>��������</td>
        <td colspan=5><input type="radio" name="proxy" id="proxy0" value="0" checked onClick="display(3);"
        <%if(proxyflag==0)out.print("checked");%>>�̳�ϵͳ����&nbsp;&nbsp;
            <input type="radio" name="proxy" id="proxy1" value="1" onClick="display(2);"
            <%if(proxyflag==1)out.print("checked");%>>�Զ�������&nbsp;&nbsp;
            <input type="radio" name="proxy" id="proxy2" value="2"
                   onClick="display(3);" <%if(proxyflag==2)out.print("checked");%>>��ʹ�ô���
        </td>
    </tr>
</table>
<div id="useLayer" style="display:<%if(ba.getKeywordflag()==1)out.print("");else{out.print("none");}%>;">
    <table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

            <td width="15%">����ؼ���</td>
            <td colspan="5"><label><input name="TRules" type="text" size="100"
                                          value="<%=tkeyword%>">
            </label>'|'���ϵ��'+'���ϵ
            </td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

            <td>���Ĺؼ���</td>
            <td colspan="5"><label><input name="BRules" type="text" size="100"
                                          value="<%=bkeyword%>">
            </label>'|'���ϵ��'+'���ϵ
            </td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>

            <td height="20">���ĺͱ���Ĺ�ϵ</td>
            <td colspan="5"><label>
                <input type="radio" name="tbrelation" value="2" <%if(tbrelation==2)out.print("checked");else{out.print("");}%>>
                ��&nbsp;&nbsp;
                <input type="radio" name="tbrelation" value="1" <%if(tbrelation==1)out.print("checked");else{out.print("");}%>>
                ��</label></td>
        </tr>
    </table>
</div>
<div id="loginLayer" style="display:<%if(loginflag==1)out.print("");else{out.print("none");}%>;">
    <table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td width="15%">��¼��URL<span class="STYLE1">*</span></td>
            <td><input type="text" name="posturl" id="posturl" size="100"
                       value="<%=ba.getPosturl()==null?"":ba.getPosturl()%>"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>���ݵĲ���</td>
            <td><input type="text" name="postdata" id="postdata" size="100"
                       value="<%=ba.getPostdata()==null?"":ba.getPostdata()%>"></td>
        </tr>
    </table>
</div>
<div id="proxyLayer" style="display:<%if(proxyflag==1)out.print("");else{out.print("none");}%>;">
    <table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td width="15%">�����������ַ<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyurl" id="proxyurl" size="100"
                       value="<%=proxyurl==null?"":proxyurl%>"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�˿�<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyport" id="proxyport" size="4"
                       value="<%=proxyport==null?"":proxyport%>"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�����¼����</td>
            <td colspan=5><input type="radio" name="proxyloginflag" id="proxyloginflag0" value="0"
                                 onClick="display(4);"  <%if(proxyloginflag==0)out.print("checked");%>>����Ҫ��¼&nbsp;&nbsp;
                <input type="radio" name="proxyloginflag" id="proxyloginflag1" value="1"
                       onClick="display(5);"  <%if(proxyloginflag==1)out.print("checked");%>>��Ҫ��¼
            </td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�����¼�û���<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyloginuser" id="proxyloginuser" size="50"
                       value="<%=proxyloginuser==null?"":proxyloginuser%>"></td>
        </tr>
        <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
            onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
            <td>�����¼����<span class="STYLE1">*</span></td>
            <td><input type="text" name="proxyloginpass" id="proxyloginpass" size="50"
                       value="<%=proxyloginpass==null?"":proxyloginpass%>"></td>
        </tr>
    </table>
</div>
<table class=tableBorder cellSpacing=1 cellPadding=3 width="95%" align=center border=0>
    <TR onmouseover='this.style.backgroundColor="#E0EAF5"'
        onmouseout='this.style.backgroundColor=""' bgColor=#f0f4fa>
        <td colspan="6" align="center">
            <label>
                <input type="submit" name="Submit" value=" �ύ ">
            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label>
                <input type="reset" name="Submit2" value=" ���� ">
            </label></td>
    </tr>
    <tr>
        <td colspan=6 class=title5 align="right"><a href="index.jsp?basicId=<%=basicId%>&currentPage=<%=pagenum%>">������ﷵ��</a>
        </td>
    </tr>
</table>
</tbody>
</form>
</body>
</html>