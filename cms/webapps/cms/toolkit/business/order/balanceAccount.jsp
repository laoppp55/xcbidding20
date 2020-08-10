<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.business.Order.*"
         contentType="text/html;charset=gbk"
%>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.po.Companyinfo" %>
<%@ page import="com.bizwink.po.Department" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ include file="../../../include/auth.jsp"%>
<%
    int status = 0;
    int startflag = ParamUtil.getIntParameter(request,"startflag",-1);
    int siteid = authToken.getSiteID();
    int orgid = authToken.getOrgid();
    int company_orgid = authToken.getCompanyid();
    int dept_orgid = authToken.getDeptid();
    int companyid = 0;
    int deptid = 0;
    int org_level = 0;
    int rootOrgid = 0;
    int orgtype = 0;           //��֯�ܹ��ڵ����ͣ�1��ʾ��˾��0��ʾ����
    int source_id = 0;
    String startday = null;
    String endday = null;

    IOrderManager orderMgr = orderPeer.getInstance();
    IUserManager userManager = UserPeer.getInstance();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    Organization organization =null;
    Organization rootOrganization = null;
    List<Companyinfo> companyinfos = null;
    List<Department> departments = null;
    OrganizationService organizationService = null;
    if (appContext!=null) {
        organizationService = (OrganizationService)appContext.getBean("organizationService");
        rootOrganization = organizationService.getRootOrganization();
        rootOrgid = rootOrganization.getID().intValue();
        organization = organizationService.getAOrganization(BigDecimal.valueOf(orgid));
        if (organization!=null) {
            org_level = organization.getLLEVEL().intValue();
            orgtype = organization.getCOTYPE().intValue();
            companyinfos = organizationService.getMainCompaniesByOrgid(BigDecimal.valueOf(siteid),BigDecimal.valueOf(orgid));
            if (companyinfos!=null)
                if (companyinfos.size()>0) companyid = companyinfos.get(0).getID().intValue();
            departments = organizationService.getADepartmentByOrgid(BigDecimal.valueOf(siteid),organization.getID());
            if (departments!=null)
                if (departments.size()>0) deptid = departments.get(0).getID().intValue();
        }
    }

    if (startflag == 1) {
        status = ParamUtil.getIntParameter(request, "status",8);
        startday = ParamUtil.getParameter(request, "searchtime1");
        endday = ParamUtil.getParameter(request, "searchtime2");
        company_orgid = ParamUtil.getIntParameter(request, "_sel_n1",0);
        dept_orgid = ParamUtil.getIntParameter(request, "_sel_n2",0);
        source_id = ParamUtil.getIntParameter(request, "_sel_n4",0);

        String where_clause = "";
        //����״̬��ѯ����
        if (where_clause != "" && where_clause!=null) {
            if (status == 0)
                where_clause = where_clause +" and (status=7 or status=8 or status=9)";
            else
                where_clause = where_clause +" and status=" + status;
        } else {
            if (status == 0)
                where_clause = where_clause + "(status=7 or status=8 or status=9)";
            else
                where_clause = where_clause +"status=" + status;
        }

        if ((endday != "") && (endday != null)) {
            endday = endday + " 23:59:59";
        }
        if ((startday != "") && (startday != null)) {
            startday = startday + " 00:00:00";
        }

        companyinfos = organizationService.getMainCompaniesByOrgid(BigDecimal.valueOf(siteid),BigDecimal.valueOf(company_orgid));
        if (companyinfos!=null && companyinfos.size()>0) {
            companyid = companyinfos.get(0).getID().intValue();
        }

        departments = organizationService.getADepartmentByOrgid(BigDecimal.valueOf(siteid),BigDecimal.valueOf(dept_orgid));
        if (departments!=null && departments.size()>0) {
            deptid = departments.get(0).getID().intValue();
        }

        List<Order> list = orderMgr.getOrderListToExcel(where_clause);
        if(list.size()>0) {
            String path = application.getRealPath("/");
            String downloadurl = "";
            int flag = ParamUtil.getIntParameter(request, "flag", -1);
            if (flag == 0) { //��������
                downloadurl = ExportOrderToExcel.ExportOrders(list, path);
            } else if (flag == 1) {  //�������˵�
                downloadurl = ExportOrderToExcel.ExportOrdersbyquery(list, path);
            } else {
                System.out.println("flagδȡ��ֵ");
            }
            if (downloadurl != null) {
                out.println("<script lanugage=\"javascript\">window.location.href=\"/webbuilder" + downloadurl + "\";</script>");
            }
        }else{
            out.println("<script lanugage=\"javascript\">alert('������');</script>");
        }

    }
%>
<!doctype html>
<html>
<head>
    <title>����������EXCEL�ļ�</title>
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
    <form action="exportOrderToExcel.jsp" method="post" name="addForm">
        <input type="hidden" name="startflag" value="1">
        <input type="hidden" name="flag" value="-1">
        <table width="100%" border="0" cellpadding="0">
            <tr bgcolor="#F4F4F4" align="center">
                <td class="moduleTitle"><font color="#48758C">����ָ��״̬�Ķ���</font></td>
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
                                <script language="javascript">
                                    options2 = "<option value=0>��ѡ��</option>\n" +
                                        "<option value=3 <%=(dept_orgid==3)?"selected":""%>>��ׯվ</option>\n" +
                                        "<option value=4 <%=(dept_orgid==4)?"selected":""%>>������</option>\n" +
                                        "<option value=5 <%=(dept_orgid==5)?"selected":""%>>������</option>\n" +
                                        "<option value=6 <%=(dept_orgid==6)?"selected":""%>>����</option>\n" +
                                        "<option value=7 <%=(dept_orgid==7)?"selected":""%>>����</option>\n" +
                                        "<option value=8 <%=(dept_orgid==8)?"selected":""%>>��Դ</option>";
                                    options9 = "<option value=0>��ѡ��</option>\n" +
                                        "<option value=10 <%=(dept_orgid==10)?"selected":""%>>������</option>\n" +
                                        "<option value=11 <%=(dept_orgid==11)?"selected":""%>>������</option>\n" +
                                        "<option value=12 <%=(dept_orgid==12)?"selected":""%>>������</option>\n" +
                                        "<option value=13 <%=(dept_orgid==13)?"selected":""%>>�ض���</option>";
                                    options14 = "<option value=0>��ѡ��</option>\n" +
                                        "<option value=15 <%=(dept_orgid==15)?"selected":""%>>���˴�</option>\n" +
                                        "<option value=16 <%=(dept_orgid==16)?"selected":""%>>��ƽ��</option>\n" +
                                        "<option value=17 <%=(dept_orgid==17)?"selected":""%>>����</option>\n" +
                                        "<option value=18 <%=(dept_orgid==18)?"selected":""%>>����</option>";
                                    options19 = "<option value=0>��ѡ��</option>\n" +
                                        "<option value=20 <%=(dept_orgid==20)?"selected":""%>>ѧԺ·</option>\n" +
                                        "<option value=21 <%=(dept_orgid==21)?"selected":""%>>�йش�</option>\n" +
                                        "<option value=22 <%=(dept_orgid==22)?"selected":""%>>�ļ���</option>\n" +
                                        "<option value=23 <%=(dept_orgid==23)?"selected":""%>>�����</option>";
                                    options24 = "<option value=0>��ѡ��</option>\n" +
                                        "<option value=25 <%=(dept_orgid==25)?"selected":""%>>����</option>\n" +
                                        "<option value=26 <%=(dept_orgid==26)?"selected":""%>>����</option>\n" +
                                        "<option value=27 <%=(dept_orgid==27)?"selected":""%>>��̨</option>\n" +
                                        "<option value=28 <%=(dept_orgid==28)?"selected":""%>>����</option>";

                                    //ѡ��ֹ�˾��ͬʱ���÷�վ����ѡ����
                                    function setFirstOptions(sel) {
                                        $("#_sel_id2 option").remove();
                                        if (sel.value>0) {
                                            var the_options = eval("options" + sel.value);
                                            var option_array = new Array();
                                            option_array = the_options.split("\n");
                                            for (var ii = 0; ii < option_array.length; ii++) {
                                                $("#_sel_id2").append(option_array[ii]);
                                            }
                                        } else {
                                            $("#_sel_id2 option").remove();
                                            $("#_sel_id2").append("<option value=0>��ѡ���վ</option>");
                                            $("#_sel_id3 option").remove();
                                            $("#_sel_id3").append("<option value=0>��ѡ���ͱ�Ա</option>");
                                        }
                                    }

                                    $(document).ready(function() {
                                        var orgid = <%=orgid%>;
                                        var orglevel = <%=org_level%>;
                                        var rightid = <%=SecurityCheck.hasPermission(authToken,54)%>
                                        if (orgid == 0 && rightid) {
                                            $("#_sel_id1 option").remove();
                                            $("#_sel_id1").append("<option value=0 <%=(company_orgid==0)?"selected":""%>>��ѡ��ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=2 <%=(company_orgid==2)?"selected":""%>>һ�ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=9 <%=(company_orgid==9)?"selected":""%>>���ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=14 <%=(company_orgid==14)?"selected":""%>>���ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=19 <%=(company_orgid==19)?"selected":""%>>�ķֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=24 <%=(company_orgid==24)?"selected":""%>>��ֹ�˾</option>");
                                        } else if (orgid==1) {
                                            $("#_sel_id1 option").remove();
                                            $("#_sel_id1").append("<option value=0 <%=(company_orgid==0)?"selected":""%>>��ѡ��ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=2 <%=(company_orgid==2)?"selected":""%>>һ�ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=9 <%=(company_orgid==9)?"selected":""%>>���ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=14 <%=(company_orgid==14)?"selected":""%>>���ֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=19 <%=(company_orgid==19)?"selected":""%>>�ķֹ�˾</option>");
                                            $("#_sel_id1").append("<option value=24 <%=(company_orgid==24)?"selected":""%>>��ֹ�˾</option>");
                                        } else {
                                            htmlobj=$.ajax({
                                                url:"../../../organization/getUpOrganizationsByID.jsp?thetime=<%=System.currentTimeMillis()%>",
                                                data:{
                                                    org:<%=(organization!=null)?organization.getPARENT():0%>
                                                },
                                                dataType:'json',
                                                async:false,
                                                success:function(data){
                                                    //���ñ��ڵ��������ڵ��ѡ��
                                                    for(var ii=1; ii<=orglevel-1; ii++) {
                                                        $(eval("\"#_sel_id" + ii + " option\"")).remove();
                                                        $(eval("\"#_sel_id" + ii + "\"")).append("<option value=" + data[ii-1].ID + ">" + data[ii-1].NAME + "</option>");
                                                    }

                                                    //���ñ��ڵ��ѡ����
                                                    $(eval("\"#_sel_id" + orglevel + " option\"")).remove();
                                                    $(eval("\"#_sel_id" + orglevel + "\"")).append("<option value=<%=(organization!=null)?organization.getID():"0"%>><%=(organization!=null)?organization.getNAME():""%></option>");

                                                    //���ñ��ڵ���һ���ڵ��ѡ����
                                                    var down_node_num = 0;
                                                    $.ajax({
                                                        url:"../../../organization/getOrganizationsByParentID.jsp?thetime=<%=System.currentTimeMillis()%>",
                                                        data:{
                                                            org:orgid
                                                        },
                                                        dataType:'json',
                                                        async:false,
                                                        success:function(data){
                                                            down_node_num = data.length;
                                                            $(eval("\"#_sel_id" + (orglevel+1) + " option\"")).remove();
                                                            $(eval("\"#_sel_id" + (orglevel+1) + "\"")).append("<option value=0>��ѡ��</option>");
                                                            for(var ii=0; ii<data.length; ii++) {

                                                                $(eval("\"#_sel_id" + (orglevel+1) + "\"")).append("<option value=" + data[ii].ID + ">" + data[ii].NAME + "</option>");
                                                            }
                                                            //alert(data[0].ID + "=" + data[0].NAME);
                                                        }
                                                    });
                                                }
                                            });
                                        }
                                    });
                                </script>
                                <div id=l1>
                                    <select name="_sel_n1" id="_sel_id1" onchange="javascript:setFirstOptions(this);">
                                        <option value=0>��ѡ��ֹ�˾</option>
                                    </select>
                                </div>
                            </td>
                            <td width="15%" align="center" class="txt">
                                <div id=l2>
                                    <select name="_sel_n2" id="_sel_id2" style="width: 100px;" onchange="javascript:setSecondOptions(this);">
                                        <option value=0>��ѡ���վ</option>
                                    </select>
                                </div>
                            </td>
                            <td width="15%" align="center" class="txt">
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
                            </td>
                            <td align="center">
                                <select name="status">
                                    <option value="0" <%=(status==0)?"selected":""%>>���ж���</option>
                                    <option value=8 <%=(status==8)?"selected":""%>>�Ѹ���</option>
                                    <option value=7 <%=(status==7)?"selected":""%>>�ȴ�����</option>
                                    <option value=9 <%=(status==9)?"selected":""%>>��ʱȡ��</option>

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
                                </select>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
        </table>
        <p align="center">
            <input type="button" name="t" value="�������˵�" onclick="return sub(1);">
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