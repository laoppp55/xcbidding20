<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.jspsmart.upload.*," %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.bizwink.cms.sjswsbs.IWsbsManager" %>
<%@ page import="com.bizwink.cms.sjswsbs.WsbsPeer" %>
<%--<%@ taglib uri="/FCKeditor" prefix="FCK" %>--%>
<%
    /*OlympicMembers ure = (OlympicMembers)session.getAttribute("AuthWeb");
    if (ure == null) {
        response.sendRedirect(response.encodeRedirectURL("/olympicfamily/index.jsp"));
        return;
    }*/

    IWsbsManager wsbsMgr = WsbsPeer.getInstance();
    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
    String rq = sf.format(System.currentTimeMillis());    
    String baseDir = request.getRealPath("/");
    String dir = wsbsMgr.getConfig() + java.io.File.separator + rq + java.io.File.separator;
    //String imgurl = "/webbuilder"+wsbsMgr.getConfig() + rq + "/";
    String imgurl = wsbsMgr.getConfig().substring(wsbsMgr.getConfig().indexOf("/upload"),wsbsMgr.getConfig().length())+"/"+rq+"/";
/*    System.out.println("dir = " + dir);
    System.out.println("imgurl = " + imgurl);   */
    boolean error = false;
    String filename = "";

    //System.out.println("baseDir=" + baseDir);

    int doUpload = ParamUtil.getIntParameter(request,"doUpload",0);
    String tupian = "";
    if (doUpload == 1) {
        SmartUpload mySmartUpload = new SmartUpload();
        mySmartUpload.initialize(this.getServletConfig(),request,response);
        com.jspsmart.upload.File  tmpFile = null;
        try {
            mySmartUpload.upload();
            Files uploadFiles = mySmartUpload.getFiles();
            for (int i = 0; i < mySmartUpload.getFiles().getCount(); i++) {
                File tempFile = mySmartUpload.getFiles().getFile(i);
                if (!tempFile.isMissing()) {
                    filename = tempFile.getFileName();
                    String ext = tempFile.getFileExt();

                    String newfilename = String.valueOf(System.currentTimeMillis()) + "_" + i + "." + ext;
                    tupian += "-----" + newfilename;

                    java.io.File dirFile = new java.io.File( dir );
                    if ( !dirFile.exists()) {
                        dirFile.mkdirs();
                    }

                    tempFile.saveAs(dir + newfilename);

                    //mySmartUpload.save(uploadPath);
                }
            }
            mySmartUpload.stop();
            
            /*mySmartUpload.upload();
            tmpFile = mySmartUpload.getFiles().getFile(0);
            filename = tmpFile.getFileName();
            //�����ļ�
            java.io.File dirFile = new java.io.File( dir );
            if ( !dirFile.exists()) {
                dirFile.mkdirs();
            }
            String picname = System.currentTimeMillis() + ".jpg";
            tmpFile.saveAs(dir + picname);
            //mySmartUpload.save(dir);*/

            //�ɹ��ϴ�ͼƬ�������ϴ�ͼƬ������

            out.println("<script language=\"Javascript\">");
            //out.println("alert(\"" + dir + picname + "\");");
            out.println("window.returnValue = \"" + imgurl + "|||||" + tupian + "\";");
            //session.setAttribute("returnfalg", imgurl + "|||||" + tupian);
            //out.println("window.opener.ReturnValue=\"<?=$this->fileurl;?>\";");            
            //out.println("alert(window.parent.parent.InnerDialogLoaded())");
            out.println("top.close();");
            out.println("</script>");
        }catch ( Exception e ) {
            System.out.println(e.getMessage());
            error = true;
        } finally {
            mySmartUpload.stop();
        }
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>��ˢ���ļ��ϴ�ϵͳ</title>
    <script language=Javascript src="../../js/jquery-1.6.1.min.js"></script>
<script language="Javascript">
        function cal() {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = "";
                top.close();
            } else {
                top.close();
            }
        }
    </script>
</head>
<body>
<style>
    .fu_list {
        width:600px;
        background:#ebebeb;
        font-size:12px;
    }
    .fu_list td {
        padding:5px;
        line-height:20px;
        background-color:#fff;
    }
    .fu_list table {
        width:100%;
        border:1px solid #ebebeb;
    }
    .fu_list thead td {
        background-color:#f4f4f4;
    }
    .fu_list b {
        font-size:14px;
    }
    /*file������ʽ*/
    a.files {
        width:90px;
        height:30px;
        overflow:hidden;
        display:block;
        border:1px solid #BEBEBE;
        background:url(images/fu_btn.gif) left top no-repeat;
        text-decoration:none;
    }
    a.files:hover {
        background-color:#FFFFEE;
        background-position:0 -30px;
    }
    /*file��Ϊ͸��������������������*/
    a.files input {
        margin-left:-350px;
        font-size:30px;
        cursor:pointer;
        filter:alpha(opacity=0);
        opacity:0;
    }
    /*ȡ�����ʱ�����߿�*/
    a.files, a.files input {
        outline:none;/*ff*/
        hide-focus:expression(this.hideFocus=true);/*ie*/
    }
</style>
<form id="uploadForm" name="Form" action="uploadpic.jsp?doUpload=1" method="post" enctype="multipart/form-data">
    <table border="0" cellspacing="1" class="fu_list">
        <thead>
        <tr>
            <td colspan="2"><b>�ϴ��ļ�</b></td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td align="right" width="15%" style="line-height:35px;">����ļ���</td>
            <td><a href="javascript:void(0);" class="files" id="idFile"></a> <img id="idProcess" style="display:none;" src="images/loading.gif" /></td>
        </tr>
        <tr>
            <td colspan="2"><table border="0" cellspacing="0">
                <thead>
                <tr>
                    <td>�ļ�·��</td>
                    <td width="100"></td>
                </tr>
                </thead>
                <tbody id="idFileList">
                </tbody>
            </table></td>
        </tr>
        <tr>
            <td colspan="2" style="color:gray">��ܰ��ʾ������ͬʱ�ϴ� <b id="idLimit"></b> ���ļ��ҵ����ļ���С���Ϊ1M��ֻ�����ϴ� <b id="idExt"></b> �ļ��� </td>
        </tr>
        <tr>
            <td colspan="2" align="center" id="idMsg"><input type="submit" value="��ʼ�ϴ�" id="idBtnupload" disabled="disabled" />
                &nbsp;&nbsp;&nbsp;
                <input type="button" value="ȫ��ȡ��" id="idBtndel" disabled="disabled" />
                &nbsp;&nbsp;&nbsp;
                <input type="button" value="  �ر�  " class=tine onClick="cal();">
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript">

var isIE = (document.all) ? true : false;

var $ = function (id) {
    return "string" == typeof id ? document.getElementById(id) : id;
};

var Class = {
    create: function() {
        return function() {
            this.initialize.apply(this, arguments);
        }
    }
}

var Extend = function(destination, source) {
    for (var property in source) {
        destination[property] = source[property];
    }
}

var Bind = function(object, fun) {
    return function() {
        return fun.apply(object, arguments);
    }
}

var Each = function(list, fun){
    for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }
};

//�ļ��ϴ���
var FileUpload = Class.create();
FileUpload.prototype = {
    //�������ļ��ؼ���ſռ�
    initialize: function(form, folder, options) {

        this.Form = $(form);//��
        this.Folder = $(folder);//�ļ��ؼ���ſռ�
        this.Files = [];//�ļ�����

        this.SetOptions(options);

        this.FileName = this.options.FileName;
        this._FrameName = this.options.FrameName;
        this.Limit = this.options.Limit;
        this.Distinct = !!this.options.Distinct;
        this.ExtIn = this.options.ExtIn;
        this.ExtOut = this.options.ExtOut;

        this.onIniFile = this.options.onIniFile;
        this.onEmpty = this.options.onEmpty;
        this.onNotExtIn = this.options.onNotExtIn;
        this.onExtOut = this.options.onExtOut;
        this.onLimite = this.options.onLimite;
        this.onSame = this.options.onSame;
        this.onFail = this.options.onFail;
        this.onIni = this.options.onIni;

        if(!this._FrameName){
            //Ϊÿ��ʵ��������ͬ��iframe
            this._FrameName = "uploadFrame_" + Math.floor(Math.random() * 1000);
            //ie�����޸�iframe��name
            var oFrame = isIE ? document.createElement("<iframe name=\"" + this._FrameName + "\">") : document.createElement("iframe");
            //Ϊff����name
            oFrame.name = this._FrameName;
            oFrame.style.display = "none";
            //��ie�ĵ�δ��������appendChild�ᱨ��
            document.body.insertBefore(oFrame, document.body.childNodes[0]);
        }

        //����form���ԣ��ؼ���targetҪָ��iframe
        this.Form.target = this._FrameName;
        this.Form.method = "post";
        //ע��ie��formû��enctype���ԣ�Ҫ��encoding
        this.Form.encoding = "multipart/form-data";

        //����һ��
        this.Ini();
    },
    //����Ĭ������
    SetOptions: function(options) {
        this.options = {//Ĭ��ֵ
            FileName:	"filename",//�ļ��ϴ��ؼ���name����Ϻ�̨ʹ��
            FrameName:	"cmsright",//iframe��name��Ҫ�Զ���iframe�Ļ���������name
            onIniFile:	function(){},//�����ļ�ʱִ��(���в�����file����)
            onEmpty:	function(){},//�ļ���ֵʱִ��
            Limit:		10,//�ļ������ƣ�0Ϊ������
            onLimite:	function(){},//�����ļ�������ʱִ��
            Distinct:	true,//�Ƿ�������ͬ�ļ�
            onSame:		function(){},//����ͬ�ļ�ʱִ��
            ExtIn:		["gif","jpg","jpeg","png","png","swf"],//�����׺��
            onNotExtIn:	function(){},//���������׺��ʱִ��
            ExtOut:		[],//��ֹ��׺������������ExtIn��ExtOut��Ч
            onExtOut:	function(){},//�ǽ�ֹ��׺��ʱִ��
            onFail:		function(){},//�ļ���ͨ�����ʱִ��(���в�����file����)
            onIni:		function(){}//����ʱִ��
        };
        Extend(this.options, options || {});
    },
    //����ռ�
    Ini: function() {
        //�����ļ�����
        this.Files = [];
        //�����ļ��ռ䣬����ֵ��file�����ļ�����
        Each(this.Folder.getElementsByTagName("input"), Bind(this, function(o){
            if(o.type == "file"){ o.value && this.Files.push(o); this.onIniFile(o); }
        }))
        //����һ���µ�file
        var file = document.createElement("input");
        file.name = this.FileName; file.type = "file"; file.onchange = Bind(this, function(){ this.Check(file); this.Ini(); });
        this.Folder.appendChild(file);
        //ִ�и��ӳ���
        this.onIni();
    },
    //���file����
    Check: function(file) {
        //������
        var bCheck = true;
        //��ֵ���ļ������ơ���׺������ͬ�ļ����
        if(!file.value){
            bCheck = false; this.onEmpty();
        } else if(this.Limit && this.Files.length >= this.Limit){
            bCheck = false; this.onLimite();
        } else if(!!this.ExtIn.length && !RegExp("\.(" + this.ExtIn.join("|") + ")$", "i").test(file.value)){
            //����Ƿ������׺��
            bCheck = false; this.onNotExtIn();
        } else if(!!this.ExtOut.length && RegExp("\.(" + this.ExtOut.join("|") + ")$", "i").test(file.value)) {
            //����Ƿ��ֹ��׺��
            bCheck = false; this.onExtOut();
        } else if(!!this.Distinct) {
            Each(this.Files, function(o){ if(o.value == file.value){ bCheck = false; } })
            if(!bCheck){ this.onSame(); }
        }
        //û��ͨ�����
        !bCheck && this.onFail(file);
    },
    //ɾ��ָ��file
    Delete: function(file) {
        //�Ƴ�ָ��file
        this.Folder.removeChild(file); this.Ini();
    },
    //ɾ��ȫ��file
    Clear: function() {
        //����ļ��ռ�
        Each(this.Files, Bind(this, function(o){ this.Folder.removeChild(o); })); this.Ini();
    }
}

var fu = new FileUpload("uploadForm", "idFile", {
    onIniFile: function(file){ file.value ? file.style.display = "none" : this.Folder.removeChild(file); },
    onEmpty: function(){ alert("��ѡ��һ���ļ�"); },
    onLimite: function(){ alert("��������ϴ�����"); },
    onSame: function(){ alert("�Ѿ�����ͬ�ļ�"); },
    onNotExtIn:	function(){ alert("ֻ�����ϴ�" + this.ExtIn.join("��") + "�ļ�"); },
    onFail: function(file){ this.Folder.removeChild(file); },
    onIni: function(){
        //��ʾ�ļ��б�
        var arrRows = [];
        if(this.Files.length){
            var oThis = this;
            Each(this.Files, function(o){
                var a = document.createElement("a"); a.innerHTML = "ȡ��"; a.href = "javascript:void(0);";
                a.onclick = function(){ oThis.Delete(o); return false; };
                arrRows.push([o.value, a]);
            });
        } else { arrRows.push(["<font color='gray'>û������ļ�</font>", "&nbsp;"]); }
        AddList(arrRows);
        //���ð�ť
        $("idBtnupload").disabled = $("idBtndel").disabled = this.Files.length <= 0;
    }
});

$("idBtnupload").onclick = function(){
    //��ʾ�ļ��б�
    var arrRows = [];
    Each(fu.Files, function(o){ arrRows.push([o.value, "&nbsp;"]); });
    AddList(arrRows);

    fu.Folder.style.display = "none";
    $("idProcess").style.display = "";
    $("idMsg").innerHTML = "��������ļ������Ժ򡭡�<br />�п�����Ϊ�������⣬���ֳ���ʱ������Ӧ��������<a href='?'><font color='red'>ȡ��</font></a>�������ϴ��ļ�";
        
    fu.Form.submit();
}

//��������ļ��б�ĺ���
function AddList(rows){
    //��������������б�
    var FileList = $("idFileList"), oFragment = document.createDocumentFragment();
    //���ĵ���Ƭ�����б�
    Each(rows, function(cells){
        var row = document.createElement("tr");
        Each(cells, function(o){
            var cell = document.createElement("td");
            if(typeof o == "string"){ cell.innerHTML = o; }else{ cell.appendChild(o); }
            row.appendChild(cell);
        });
        oFragment.appendChild(row);
    })
    //ie��table��֧��innerHTML�����������table
    while(FileList.hasChildNodes()){ FileList.removeChild(FileList.firstChild); }
    FileList.appendChild(oFragment);
}


$("idLimit").innerHTML = fu.Limit;

$("idExt").innerHTML = fu.ExtIn.join("��");

$("idBtndel").onclick = function(){ fu.Clear(); }

//�ں�̨ͨ��window.parent��������ҳ��ĺ���
function Finish(msg){
    msg=msg.replace(/<br[^>]*>/ig,   "\n").replace(/&nbsp;/ig,   "   ");
    alert(msg); location.href = location.href; }

</script>
</body>
</html>
