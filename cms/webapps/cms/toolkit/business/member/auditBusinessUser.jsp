<%@ page import="java.util.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"%>
<%@ include file="../../../include/auth.jsp"%>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);

    if (!SecurityCheck.hasPermission(authToken, 54)){
        response.sendRedirect("../error.jsp?message=�޹����û���Ȩ��");
        return;
    }

    int siteid = authToken.getSiteID();
    String sitename = authToken.getSitename();
    int uid = ParamUtil.getIntParameter(request,"uid",0);    //����Ȩ�˵�userid�����ǵ�¼�ߵ�userid
    int startrow = ParamUtil.getIntParameter(request,"startrow",0);
    IUserManager       userMgr  = UserPeer.getInstance();
    //�õ�ԭʼ����
    User user = userMgr.getUserByUID(uid,siteid);
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>���ҵ��Ա�û���Ϣ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/table.css"/>
    <link rel="stylesheet" type="text/css" href="../../../css/uploadify.css">
    <script type="text/javascript" src="../js/check.js"></script>
    <script type="text/javascript" src="../../../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../../../js/jquery.uploadify.js"></script>
    <script type="text/javascript" src="../../../js/jquery.form.js"></script>
    <SCRIPT LANGUAGE=javascript>
        function doSubmit() {
            var filename = $("#fileToUpload").val();
            if (filename == "") {
                alert("��ѡ���ϴ���ͼƬ�ļ���");
                return false;
            }

            if (filename.toLowerCase().indexOf(".jpeg") == -1 && filename.toLowerCase().indexOf(".jpg")==-1 && filename.toLowerCase().indexOf(".png")==-1) {
                alert("�ϴ��ļ�������jpg��ʽ������png��ʽ��ͼƬ�ļ���");
                return false;
            }

            var bar = $('.bar');
            var percent = $('.percent');
            var status = $('#status');

            $("#auditFormID").ajaxSubmit({
                url: 'saveUploadImg.jsp?doCreate=true',          //����post�ύ����ҳ��
                type: "post",                                        //���ñ���post�����ύ
                dataType: "json",                                   //���÷���ֵ����Ϊ�ı�
                cache:false,
                async:false,
                success: function (data) {
                    alert(data.error.errcode + "==" + data.url);
                    alert(data.error.modelname);
                    alert(data.error.errmsg);
                    //$("#myimgid").attr('src',data.url);
                    //$("#fileToUpload")[0].value = "";
                },
                xhr:function(){
                    var xhr = $.ajaxSettings.xhr();
                    if(onprogress && xhr.upload) {
                        xhr.upload.addEventListener("progress" , onprogress, false);
                        return xhr;
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    /*����jqXHR�������Ϣ*/
                    alert(jqXHR.responseText);
                    alert(jqXHR.status);
                    alert(jqXHR.readyState);
                    alert(jqXHR.statusText);
                    /*��������������������Ϣ*/
                    alert(textStatus);
                    alert(errorThrown);
                }
            });

            return false;
        }

        //��鸽���ϴ����
        //ͨ���¼��������
        //�������������ʽ���0.05-0.1��ִ��һ��
        // console.log(evt.loaded);  //�Ѿ��ϴ���С���
        //evt.total; �����ܴ�С
        function onprogress(evt){
            var loaded = evt.loaded;
            var tot = evt.total;
            var per = Math.floor(100*loaded/tot);  //�Ѿ��ϴ��İٷֱ�
            var son =  document.getElementById('progressBar');
            son.innerHTML = per+"%";
            son.style.width=per+"%";
        }

        $(document).ready(function(){
            $('#fileToUpload').uploadify( {
                'swf' : '/webbuilder/css/images/uploadify.swf',                        //�ϴ���ť��ͼƬ��Ĭ�������flash�ļ�
                'uploader' : 'saveUploadImg.jsp?uid=<%=uid%>&doCreate=true',                                      //�ϴ�������ķ�����
                'cancelImg' : '/webbuilder/css/images/uploadify-cancel.png',         //ȡ��ͼƬ
                'method':'post',
                'folder' : '/UploadFile',                                         //�ϴ����������ļ���·��
                'queueID' : 'fileQueue',                                          //�ϴ���ʾ���������Ǹ�div
                'fileTypeDesc'   : 'jpg;png',
                'fileTypeExts'   : '*.jpg;*.png', //���ƿ��ϴ��ļ�����չ�������ñ���ʱ��ͬʱ����fileDesc
                'height'  : 20,
                'width'   : 100,
                'buttonText' : '��ѡ���ļ�',
                //'onUploadComplete': function(file){
                //    alert('The file'+file.name+'finished processing!')
                //},                                                                   //ÿ���ļ��ϴ��ɹ���ĺ���
                progressData : 'percentage',
                'auto' : false,
                'multi' : true,
                'onSelect':function(file){
                    alert("�ļ�"+file.name+"��ѡ���ˣ�");
                },
                onUploadSuccess : function(file,data,response) {                    //�ϴ����ʱ������ÿ���ļ�����һ�Σ�
                    alert( 'id: ' + file.id
                        + ' - ����: ' + file.index
                        + ' - �ļ���: ' + file.name
                        + ' - �ļ���С: ' + file.size
                        + ' - ����: ' + file.type
                        + ' - ��������: ' + file.creationdate
                        + ' - �޸�����: ' + file.modificationdate
                        + ' - �ļ�״̬: ' + file.filestatus
                        + ' - ����������Ϣ: ' + data
                        + ' - �Ƿ��ϴ��ɹ�: ' + response);
                },
                //'onQueueComplete' : function(queueData) {
                //	alert(queueData.filesQueued + 'files were successfully!')
                //},                                                                      //�������е������ļ��ϴ��ɹ��󣬵������ж��ٸ��ļ��ϴ��ɹ�
                //'onDisable' : function() {
                //    alert('uploadify is disable');
                //},//�ڵ���disable����ʱ�򴥷�
                //'onCancel':function(){alert('��ȡ�����ļ��ϴ�')}
                //'onUploadStart' : function(file) {//�ڵ����ϴ�ǰ����
                //alert('The file ' + file.name + ' is being uploaded.')}
                'onError' : function(errorType,errObj) {
                    alert('The error was: ' + errObj.info)
                }
            });
        });

        function audituserinfo() {
            htmlobj=$.ajax({
                url: 'updateUserType.jsp?doUpdate=true',          //����post�ύ����ҳ��
                data:{
                    uid:<%=uid%>
                },
                type: "post",                                        //���ñ���post�����ύ
                dataType: "json",                                   //���÷���ֵ����Ϊ�ı�
                cache:false,
                async:false,
                success: function (data) {
                    if (data.msg=="SUCESS" && data.errcode==0) {
                        alert("<%=(user.getNickName()!=null)?user.getNickName():""%>" + "���ͨ��������");
                        opener.window.location = "index3.jsp?startrow=<%=startrow%>";
                        window.close();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    alert(jqXHR.status);
                    alert(jqXHR.readyState);
                    alert(jqXHR.statusText);
                    alert(textStatus);
                    alert(errorThrown);
                }
            });
        }

        function window_close() {
            parent.window.close();
        }
    </SCRIPT>
</head>
<body>
<div align="center">
    <form name="auditform" id="auditFormID" enctype="multipart/form-data">
        <div align="left">
            <table width="100%" class="table">
                <tr>
                    <td width="30%" align="right"><font size="2">�����ʼ���</font></td>
                    <td><font size="2"><%=(user.getEmail()!=null)?user.getEmail():""%></font></td>
                </tr>
                <tr>
                    <td width="30%" align="right"><font size="2">�û�������</font></td>
                    <td><font size="2"><%=(user.getNickName()!=null)?StringUtil.gb2iso4View(user.getNickName()):""%></font></td>
                </tr>
                <tr>
                    <td width="30%" align="right"><font size="2">�û��绰��</font></td>
                    <td><font size="2"><%=(user.getPhone()!=null)?user.getPhone():""%></font></td>
                </tr>
                <tr>
                    <td width="30%" align="right"><font size="2">�û��ֻ���</font></td>
                    <td><font size="2"><%=(user.getMobilePhone()!=null)?user.getMobilePhone():""%></font></td>
                </tr>
                <tr>
                    <td width="30%" align="right"><font size="2">ѡ��ͷ��</font></td>
                    <td>
                        <div class="progress" id="progressHide">
                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBar">
                                <span class="sr-only"></span>
                            </div>
                        </div>
                        <div id="fileQueue"></div>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <input type="file" name="myheadimg" id="fileToUpload" multiple="true" value="��ѡ��JPG����PNGͼƬ"/>
                                        <%if (user.getMyimage() != null) {%>
                                        <img src="/webbuilder/sites/<%=sitename%><%=user.getMyimage()%>">
                                        <%}%>
                                    </td>
                                    <td>
                                        <a href="javascript:$('#fileToUpload').uploadify('upload', '*')">��ʼ�ϴ�</a>
                                    </td>
                                    <td>
                                        <a href="javascript:$('#fileToUpload').uploadify('cancel', '*')">ȡ���ϴ�</a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="32">
                        <div align="center">
                            <a href="javascript:audituserinfo();">���</a>
                            <a href="javascript:window_close();">����</a>
                            <!--input type="button" name="adduser" value="�޸�" onclick="javascript:saveAndUploadTask();">&nbsp;&nbsp;
                            <input type="button" name="cancel" value="ȡ��" onclick="javascript:window_close();"-->
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
</body>
</html>
