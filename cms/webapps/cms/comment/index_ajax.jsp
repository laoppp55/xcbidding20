<html>
<head>

</head>
<script type="text/javascript">
    function sendComment() {
        var contents = form.content.value;
        if (contents == null || contents == "") {
            alert("���������۵����ݣ�");
            form.content.focus();
            return;
        }
        var id = form.aritcleid.value;
        var name = form.name.value;
        var link = form.link.value;
        var objXml = new ActiveXObject("Microsoft.XMLHTTP");
        objXml.open("POST", "sendComment.jsp?id=" + id + "&startflag=1&content="+contents+"&id="+id+"&name="+name+"&link="+link, false);
        objXml.Send();

        var retstr = objXml.responseText;
        if (retstr != null && retstr.length > 0 && retstr.indexOf("false")==-1) {
            alert("���۳ɹ���");
            document.getElementById("comment").innerHTML = retstr;
            form.reset();
        }
        if(retstr.indexOf("false")!=-1){
            alert("����ʧ�ܣ�");
        }
    }
    function pages(pages){
        var objXml = new ActiveXObject("Microsoft.XMLHTTP");
        objXml.open("POST", "sendComment.jsp?startrow="+pages+"&errcode=0", false);
        objXml.Send();
        var retstr = objXml.responseText;
        if (retstr != null && retstr.length > 0 && retstr.indexOf("false")==-1) {
            document.getElementById("comment").innerHTML = retstr;
        }
    }
</script>
<body>
<center>
    <div id="comment"></div>
    <script type="text/javascript">pages(0);</script>
    <table cellpadding="0" cellspacing="0" border="0">
        <form name="form">
            <input type="hidden" name="aritcleid" value="0">
            <input type="hidden" name="startflag" value="1">
            <tr>
                <td valign="top">
                    ������
                </td>
                <td valign="top">
                    <input type="text" id="name" name="name" value="">
                </td>
            </tr>
            <tr>
                <td valign="top">
                    ��ϵ��ʽ��
                </td>
                <td valign="top">
                    <input type="text" id="link" name="link" value="">
                </td>
            </tr>
            <tr>
                <td valign="top">
                    ���ݣ�
                </td>
                <td valign="top">
                    <textarea rows="10" cols="50" id="content" name="content"></textarea>
                </td>
            </tr>

            <tr>
                <td valign="top" colspan="2">
                    <input type="button" name="sub" value="�ύ" onclick="javascript:sendComment();">
                </td>
            </tr>
        </form>
    </table>
</center>
</body>
</html>