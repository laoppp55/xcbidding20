<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.cms.business.Users.*" %>
<%@ page import="com.bizwink.po.Department" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    int status = 0;
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);
    int siteid = authToken.getSiteID();
    IBUserManager buserMgr = buserPeer.getInstance();

    String startday = null;
    String endday = null;
    if (startflag == 1) {
        status = ParamUtil.getIntParameter(request, "status",0);
        startday = ParamUtil.getParameter(request, "searchtime1");
        endday = ParamUtil.getParameter(request, "searchtime2");


        String where_clause = "";
        //����״̬��ѯ����
       /* if (where_clause != "" && where_clause!=null) {
            if (status == 0)
                where_clause = where_clause +" and (o.status=1 or o.status=2 or o.status=3)";
            else
                where_clause = where_clause +" and o.status=" + status;
        } else {
            if (status == 0)
                where_clause = where_clause + "(o.status=1 or o.status=2 or o.status=3)";
            else
                where_clause = where_clause +"o.status=" + status;
        }*/



        List<BUser> list = buserMgr.getBUserListToExcel(siteid,startday,endday,where_clause);

        if(list.size()>0) {
            String path = application.getRealPath("/");
            String downloadurl = "";
            int flag = ParamUtil.getIntParameter(request, "flag", -1);
            if (flag == 0) { //��������
                downloadurl = ExportBUserToExcel.ExportUsers(list, path);
            } /*else if (flag == 1) {  //�������Ϸ���ϵͳҪ��Ķ���
                downloadurl = ExportOrderToExcel.ExportOrdersForFangzheng(list, path);
            } */else {
                System.out.println("flagδȡ��ֵ");
            }
            if (downloadurl != null) {
                //�½�һ��SmartUpload����
                SmartUpload su = new SmartUpload();
                //��ʼ��
                su.initialize(pageContext);
                // �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ�
                su.setContentDisposition(null);
                su.downloadFile(path + downloadurl);
            }
        }else{
            out.println("<script lanugage=\"javascript\">alert('������');</script>");
        }
    }
%>
<!doctype html>
<html>
<head>
    <title>���û�����EXCEL�ļ�</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <!--link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script-->


    <link href="../../../css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../../../js/jquery-1.12.4.js" type="text/javascript"></script>
    <script language="javascript" src="../../../js/jquery-ui.js" type="text/javascript"></script>
    <!--script language="JavaScript" src="../include/setday.js"></script-->
    <script language="JavaScript">
        function sub(v){
            var searchtime1 = document.getElementById("searchtime1").value;
            var searchtime2 = document.getElementById("searchtime2").value;
            if(searchtime1 == null || searchtime1 == ""){
                alert("��ѡ��ʼʱ��");
                return false;
            }
            if(searchtime2 == null || searchtime2 == ""){
                alert("��ѡ���ֹʱ��");
                return false;
            }
            document.addForm.flag.value=v;
            document.addForm.submit();
            //return true;
        }
        function closewin() {
            window.close();
        }
    </script>

</head>
<body bgcolor="#FFFFFF">
<center><br>
    <form action="exportMembersToExcel.jsp" method="post" name="addForm">
        <input type="hidden" name="startflag" value="1">
        <input type="hidden" name="flag" value="-1">
        <table width="100%" border="0" cellpadding="0">
            <tr bgcolor="#F4F4F4" align="center">
                <td class="moduleTitle"><font color="#48758C">����ָ��״̬���û�</font></td>
            </tr>

            <tr bgcolor="#d4d4d4" align="right">
                <td>
                    <table width="100%" border="0" cellpadding="2" cellspacing="1">
                        <tr bgcolor="#FFFFFF">
                            <td width="10%">��������</td>
                            <td width="40%" valign="top"> ��
                                <input type="text" size="20" name="searchtime1" id="begindateid" readonly>
                                ��
                                <input type="text" size="20" name="searchtime2" id="enddateid" readonly>
                            </td>
                            <td width="15%" align="center" class="txt">

                                <%--<div id=l1>
                                    <select name="projcode" id="projcode">
                                        <option value=100 <%=(projcode==100)?"selected":""%>>��ѡ����Ŀ</option>
                                        <option value=101 <%=(projcode==101)?"selected":""%>>һ��ע�Ὠ��ʦ</option>
                                        <option value=102 <%=(projcode==102)?"selected":""%>>����ע�Ὠ��ʦ</option>
                                        <option value=103 <%=(projcode==103)?"selected":""%>>һ��ע�����ʦ</option>
                                        <option value=104 <%=(projcode==104)?"selected":""%>>����ע�����ʦ</option>
                                        <option value=105 <%=(projcode==105)?"selected":""%>>�ֳ�������Ա</option>
                                        <option value=106 <%=(projcode==106)?"selected":""%>>�ֳ�������Ա</option>
                                        <option value=106 <%=(projcode==107)?"selected":""%>>��ȫ������Ա</option>
                                        <option value=106 <%=(projcode==108)?"selected":""%>>����</option>
                                    </select>
                                </div>--%>
                            </td>

                            <%--<td width="15%" align="center" class="txt">
                                <%if (SecurityCheck.hasPermission(authToken,54)) {%>
                                <div id=l4>
                                    <select name="_sel_n4" id="_sel_id4" style="width: 80px;"> <!--onchange="javascript:setSecondOptions(this);"-->
                                        <option value=0 <%=(source_id==0)?"selected":""%>>������Դ</option>
                                        <option value=1 <%=(source_id==1)?"selected":""%>>ȫ��</option>
                                        <option value=2 <%=(source_id==2)?"selected":""%>>��վ</option>
                                        <option value=3 <%=(source_id==3)?"selected":""%>>���ں�</option>
                                    </select>
                                </div>
                                <%} else if(organization!=null) {
                                    if (organization.getID().intValue() == rootOrgid) {%>
                                <div id=l4>
                                    <select name="_sel_n4" id="_sel_id4" style="width: 80px;"> <!--onchange="javascript:setSecondOptions(this);"-->
                                        <option value=0 <%=(source_id==0)?"selected":""%>>������Դ</option>
                                        <option value=1 <%=(source_id==1)?"selected":""%>>ȫ��</option>
                                        <option value=2 <%=(source_id==2)?"selected":""%>>��վ</option>
                                        <option value=3 <%=(source_id==3)?"selected":""%>>���ں�</option>
                                    </select>
                                </div>
                                <%}}%>
                            </td>--%>
                            <td align="center">
                               <%-- <select name="status">
                                    <option value="0" <%=(status==0)?"selected":""%>>��ѵ״̬</option>
                                    <option value=1 <%=(status==1)?"selected":""%>>����ѵ</option>
                                    <option value=2 <%=(status==2)?"selected":""%>>��ѵ��</option>
                                    <option value=3 <%=(status==3)?"selected":""%>>�����</option>

                                    <!--option value="_" selected>���ж���</option>
                                    <option value="0">�¶���</option>
                                    <option value="1">������</option>
                                    <option value="2">����</option>
                                    <option value="3">�˻�</option>
                                    <option value="4">���</option>
                                    <option value="5">����</option>
                                    <option value="6">ȱ��</option>
                                    <option value="7">�ȴ��ͻ�����</option>
                                    <option value="8">�Ѹ���</option-->
                                </select>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
        </table>
        <p align="center">
            <input type="button" name="tt" value="�����û�" onclick="return sub(0);">
            <%--   <input type="button" name="Ok" value="����������ʽ����" onclick="return sub(1);">&nbsp;&nbsp;--%>
            <input type="button" name="close" value="�ر�" onclick="javascript:closewin();">
        </p>
    </form>
    <p>&nbsp; </p>
</center>
<script language="javascript">
    $(document).ready(function(){
        $.datepicker.regional['zh-CN'] = {
            clearText: '���',
            clearStatus: '�����ѡ����',
            closeText: '�ر�',
            closeStatus: '���ı䵱ǰѡ��',
            prevText: '����',
            prevStatus: '��ʾ����',
            prevBigText: 'Prev',
            prevBigStatus: '��ʾ��һ��',
            nextText: '����',
            nextStatus: '��ʾ����',
            nextBigText: 'Next',
            nextBigStatus: '��ʾ��һ��',
            currentText: '����',
            currentStatus: '��ʾ����',
            monthNames: ['һ��','����','����','����','����','����', '����','����','����','ʮ��','ʮһ��','ʮ����'],
            monthNamesShort: ['һ��','����','����','����','����','����', '����','����','����','ʮ��','ʮһ��','ʮ����'],
            monthStatus: 'ѡ���·�',
            yearStatus: 'ѡ�����',
            weekHeader: '��',
            weekStatus: '�����ܴ�',
            dayNames: ['������','����һ','���ڶ�','������','������','������','������'],
            dayNamesShort: ['����','��һ','�ܶ�','����','����','����','����'],
            dayNamesMin: ['��','һ','��','��','��','��','��'],
            dayStatus: '���� DD Ϊһ����ʼ',
            dateStatus: 'ѡ�� m�� d��, DD',
            dateFormat: 'yy-mm-dd',
            firstDay: 1,
            initStatus: '��ѡ������',
            isRTL: false};
        $.datepicker.setDefaults($.datepicker.regional['zh-CN']);

        $("#begindateid").datepicker({
            dateFormat: 'yy-mm-dd',
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true
        });

        $("#enddateid").datepicker({
            showOtherMonths: true,
            selectOtherMonths: true,
            showButtonPanel: true,
            showOn: "both",
            buttonImageOnly: true,
            // buttonImage: "/css/images/icon_calendar.gif",
            buttonText: "",
            changeMonth: true,
            changeYear: true
        });
    })
</script>
</body>
</html>