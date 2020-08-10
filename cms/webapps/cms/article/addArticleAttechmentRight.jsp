<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>

<%
    //��Ϊ������ӱ�Ҫ��ע��
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteid = authToken.getSiteID();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int articleID = ParamUtil.getIntParameter(request, "article", 0);
    String msg = ParamUtil.getParameter(request, "msg");

    IColumnManager columnManager = ColumnPeer.getInstance();
    Column column = columnManager.getColumn(columnID);
    String CName = StringUtil.gb2iso4View(column.getCName());
%>

<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.form.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
    <script type="text/javascript" src="../js/json_parse.js"></script>
    <script language="JavaScript">
        $(document).ready(function(){     //��ʼ��ztree����
            htmlobj=$.ajax({
                url:"getAttechments.jsp",
                type:'post',
                dataType:'json',
                data:{
                    colid:<%=columnID%>,
                    article:<%=articleID%>
                },
                async:false,
                cache:false,
                success:function(data){
                    var json_data = "";
                    if(typeof(data.errcode)=="undefined"){                 //���������и����������޸����µ����
                        var s_json = top.opener.document.createForm.attechments.value;
                        if (s_json==null || s_json=="") {
                            //��һ�ν����ҳ�棬�����ݿ��е�ֵ����opener�������ֶ�
                            var val_in_db = JSON.stringify(data);
                            top.opener.document.createForm.attechments.value = val_in_db.substring(1,val_in_db.length-1);
                            json_data ="{\"rows\":[" +  top.opener.document.createForm.attechments.value + "]}";
                        }else
                            json_data ="{\"rows\":[" +  top.opener.document.createForm.attechments.value + "]}";
                        if (s_json!=null) {
                            var mydata = jQuery.parseJSON(json_data);
                            for(var rr=0;rr<mydata.rows.length;rr++){
                                CreateRow(mydata.rows[rr].cname,mydata.rows[rr].summary,mydata.rows[rr].createdate);
                            }
                        }
                    } else {                                                 //���ڴ������£����߱༭���µ�һ�����Ӹ���
                        var s_json = top.opener.document.createForm.attechments.value;
                        json_data ="{\"rows\":[" +  top.opener.document.createForm.attechments.value + "]}";
                        if (s_json!=null) {
                            var mydata = jQuery.parseJSON(json_data);
                            for(var rr=0;rr<mydata.rows.length;rr++){
                                CreateRow(mydata.rows[rr].cname,mydata.rows[rr].summary,mydata.rows[rr].createdate);
                            }
                        }
                    }
                }
            });
        });

        function uploadAttechment(){
            var myData = {
                "column":<%=columnID%>,
                "article":<%=articleID%>
            };

            var ajaxFormOption = {
                type: "post",                                                     //�ύ��ʽ
                dataType: "json",                                                //��������
                data: myData,                                                      //�Զ������ݲ�������������
                url: "../upload/uploadAttechment.jsp?doUpload=true",       //����url
                success: function (data) {                                         //�ύ�ɹ��Ļص�����
                    var s_data = top.opener.document.createForm.attechments.value;
                    if (s_data==null || s_data=="")
                        top.opener.document.createForm.attechments.value = JSON.stringify(data);
                    else
                        top.opener.document.createForm.attechments.value=top.opener.document.createForm.attechments.value + "," + JSON.stringify(data);
                    if (data.cname!=null && data.cname!="" && data.filename!=null)
                        CreateRow(data.cname,data.summary,data.createdate);
                }
            };

            //����Ҫsubmit��ť���������κ�Ԫ�ص�click�¼�
            $("#form1").ajaxSubmit(ajaxFormOption);
        }

        function CreateRow(cname,summary,createdate) {
            var $table = $('#table1');
            var rows = $("#table1 tr").length;
            var tr="<tr><td><input type='checkbox' name='a'" + rows + "></td><td>" + cname + "</td><td>" + summary +
                    "</td><td>" + createdate + "</td><td>�޸�</td><td><a href='#' onclick='javascript:DeleteRow(" + rows + ");'>ɾ��</td></tr>";
            $table.append(tr);
        }

        function DeleteRow(row) {
            var s_json = top.opener.document.createForm.attechments.value;
            var json_data ="{\"rows\":[" +  top.opener.document.createForm.attechments.value + "]}";
            var mydata = jQuery.parseJSON(json_data);
            var result_data = "";
            for(var rr=0;rr<mydata.rows.length;rr++){
                if ((rr+1) != (row-1)) {
                    result_data = result_data + JSON.stringify(mydata.rows[rr]) + ",";
                }
            }
            if (result_data.length>0) result_data = result_data.substring(0,result_data.length-1);
            top.opener.document.createForm.attechments.value = result_data;
            alert(result_data);
            $("#table1 tr").eq(row).remove();
        }


    </script>
</head>
<BODY BGCOLOR="#ffffff" LINK="#000099" ALINK="#cc0000" VLINK="#000099" TOMARGIN=8>
<%
    if (msg!=null) out.println("<span class=cur>" + msg + "</span>");
%>
<table  id="table1" border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
    <tr>
        <td colspan=6>��ǰ������Ŀ-->><font color=red><%=CName%></font></td>
    </tr>
    <tr class=itm bgcolor="#dddddd">
        <td align=center width="5%">ѡ��</td>
        <td align=center width="20%">����</td>
        <td align=center width="40%">����</td>
        <td align=center width="15%">�ϴ�ʱ��</td>
        <td align=center width="10%">�޸�</td>
        <td align=center width="10%">ɾ��</td>
    </tr>
</table>
<p align=center>
<form enctype="multipart/form-data" id="form1">
    <table border="0" cellspace="0">
        <tr>
            <td>�������ƣ�</td>
            <td><input type="text" name="cname" value="" size="100"></td>
        </tr>
        <tr>
            <td>�������ܣ�</td>
            <td><input type="text" name="brief" value="" size="100"></td>
        </tr>
        <tr>
            <td>��    ����</td>
            <td><input type="file" name="attfile" value=""></td>
        </tr>
        <tr>
            <td><input type=button value="  �ϴ�  " onclick="uploadAttechment();"></td>
            <td>    <input type=button value="  ����  " onclick="top.close();">            </td>
        </tr>
    </table>
</form>
</p>
</BODY>
</html>