<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.bizwink.security.Auth" %>
<%@ page import="com.bizwink.util.SessionUtil" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%
    request.setCharacterEncoding("utf-8");
    //Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    //if (authToken==null) {
    //    response.sendRedirect("/users/login.jsp");   //错误码为-1表示用户需要登录系统才能进行后续操作
    //    return;
    //}

    String idflag = ParamUtil.getParameter(request,"idflag");
%>
<!DOCTYPE HTML>
<html>
<head>
    <!--base href="http://xccg.coosite.com:89/"-->
    <title>文件上传</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <script src="/ggzyjy/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="/ggzyjy/js/users.js" type="text/javascript"></script>
    <script type="text/javascript">
        var idflag = "<%=idflag%>";
        var over = false;
        var retFilename = "";
        var inter;
        function upload(){
            over = false;
            var filename = getFilename();          //获取本地的上传文件名称
            if (!checkFileExt(filename)) {
                alert("上传文件不是系统允许上传的文件");
            } else {
                $("#state").html("")
                $("#progress").css("width", "0")
                $("input[type=submit]").attr("disabled", true);
                $("#progress").css("width", "0%");
                $("#state").html("正在上传... 总大小：0MB，已上传：0MB，0%，已用时：0秒，剩余时间：0秒，速度：0KB/S");
                inter = setInterval(req, 1000);
            }
        }

        function req(){
            //如果上传已经完成
            if(over){
                clearInterval(inter);
                $("#closeid").removeAttr("disabled");
                //var filename = getFilename();
                $("#" + idflag + "_id", window.opener.document).html(retFilename);
                $("#" + idflag + "_file", window.opener.document).val(retFilename);
                return;
            }
            var url = "/tools/uploadAjax.jsp";
            $.get(url,function(date){
                var state = date.split("-");
                $("#state").html("正在上传... 总大小："+state[4]+"MB，已上传："+state[3]+"MB，"+state[2]+"%，已用时："+state[0]+"秒，剩余时间："+state[5]+"秒，速度："+state[1]+"KB/S");
                $("#progress").animate({width:state[2]+"%"},500);
                var url = "/tools/getUploadFilenameOnServer.jsp";
                htmlobj = $.ajax({
                    url: url,
                    type: 'post',
                    dataType: 'json',
                    data: {},
                    async: false,
                    cache: false,
                    success: function (data) {
                        if (data.result!=null) retFilename = data.result;
                    }
                });
                if (retFilename!=null && retFilename!="null" && retFilename!="") {
                    if (state[3] == state[4]) {
                        over = true;
                        $("input[type=submit]").attr("disabled", false);
                        $("#state").html("上传已完成，总大小：" + state[4] + "MB，已上传：" + state[3] + "MB，" + state[2] + "%，已用时：" + state[0] + "秒，剩余时间：" + state[5] + "秒，速度：" + state[1] + "KB/S");
                    }
                }
            });
        }

        function getFilename() {
            var fp = $("#fUpload");
            var items = fp[0].files;
            var fileName = items[0].name;              //获取文件名
            var lg = fp[0].files.length;               //获取文件的大小
            return fileName;
        }
    </script>
</head>

<body>
<form action="/servlet/Upload" method="post" enctype="multipart/form-data" target="upload_iframe" onsubmit="upload()">
    <p><input type="file" name="file" id="fUpload"></p>
    <!--p><input type="button" name="OK" value="test" onclick="getFilename();"></p-->
    <div id="bid" style="float: left;"><input type="submit" value="上传文件"></div><div style="padding-left:100px;"><input type="button" id="closeid" value="关闭" onclick="javascript:window.close();" disabled></div>

</form>
<iframe name="upload_iframe" width="0" height="0" frameborder="0"></iframe>
<div id="state"></div>
<div id="progress" style="background: #728820; height: 10px; width: 0"></div>
</body>
</html>