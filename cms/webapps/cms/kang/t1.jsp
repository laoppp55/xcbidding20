<%@ page contentType="text/html; charset=GBK" %>
<html>
<head>
    <title>
        Ajax������
    </title>
    <script type="text/javascript">
        //xmlHttpRequest����
        var xmlHttp;
        var key;

        //��������ɫ
        var bar_color='gray';
        var span_id='block';
        var clear="&nbsp;&nbsp;&nbsp;"

        //����xmlHttpRequest����
        function createXMLHttpRequest(){
            if (window.ActiveXObject){
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            else if(window.XMLHttpRequest){
                xmlHttp = new XMLHttpRequest();
            }
        }

        //ִ�з���
        function go(){
            createXMLHttpRequest();
            checkDiv();
            var url = "/webbuilder/probar?task=create";
            //���ذ�ť
            var button = document.getElementById("go");
            button.disabled = true;

            xmlHttp.open("GET",url,true);
            xmlHttp.onreadystatechange = goCallback;
            xmlHttp.send(null);
        }

        //�ص�����
        function goCallback(){
            alert("go Callback here");
            if (xmlHttp.readyState == 4){
                alert("go Callback here 4==" + xmlHttp.status);
                if (xmlHttp.status == 200){
                    alert("go Callback here 4 200");
                    //���ø���ʱ��
                    setTimeout("pollServer()",2000);
                }
            }
        }

        //ˢ�£����·���
        function pollServer(){
            alert("hello word");
            createXMLHttpRequest();
            var url = "/webbuilder/probar?task=poll&key=" + key;
            xmlHttp.open("GET",url,true);
            xmlHttp.onreadystatechange = pollCallback;
            xmlHttp.send(null);
        }

        //�ص�����
        function pollCallback(){
            if (xmlHttp.readyState == 4){
                if (xmlHttp.status == 200){
                    //��ɰٷֱ�
                    var percent_complete = xmlHttp.responseXML.getElementsByTagName("percent")[0].firstChild.data;
                    alert(percent_complete);
                    alert("processResult=" + xmlHttp.status);
                    var index = processResult(percent_complete);
                    alert("pollCallback=" + xmlHttp.status);

                    for (var i = 1; i <= index;i++){
                        var elem = document.getElementById("block" + i);
                        elem.innerHTML = clear;

                        elem.style.backgroundColor = bar_color;
                        var next_cell = i + 1;
                        if (next_cell > index && next_cell <= 9){
                            document.getElementById("block" + next_cell).innerHTML = percent_complete + "%";
                        }
                    }

                    if (index < 9){
                        setTimeout("pollServer()",2000);
                    }else{
                        document.getElementById("complete").innerHTML = "Complete!";
                        document.getElementById("go").disabled = false;
                    }
                }
            }
        }

        //�������
        function processResult(){
            var ind;
            if (percent_complete.length == 1){
                ind = 1;
            }else if (percent_complete.length == 2){
                ind = percent_complete.substring(0,1);
            }else{
                ind = 9;
            }

            return ind;
        }

        //�����ʾ����Ϣ
        function checkDiv(){
            var progress_bar = document.getElementById("progressBar");
            if (progress_bar.style.visibility == "visible"){
                //���������
                clearBar();
                document.getElementById("complete").innerHTML = "";
            }else{
                progress_bar.style.visibility = "visible";
            }
        }

        //���������
        function clearBar(){
            for (var i = 1; i < 10; i++){
                var elem = document.getElementById("block" + i);
                elem.innerHTML = clear;
                elem.style.backgroundColor = "white";
            }
        }
    </script>
</head>
<body bgcolor="#ffffff">
<h1>
    Ajax������ʾ��
</h1>
���н�����:
<input type="button" value="����" id="go" onclick="go()"/>
<p>
</p>
<table align="center">
    <tbody>
    <tr>
        <td><div id="progressBar" style="padding:2px; border:solid black 2px; visibility:hidden">
            <span id="block1">&nbsp;&nbsp;&nbsp;</span>
            <span id="block2">&nbsp;&nbsp;&nbsp;</span>
            <span id="block3">&nbsp;&nbsp;&nbsp;</span>
            <span id="block4">&nbsp;&nbsp;&nbsp;</span>
            <span id="block5">&nbsp;&nbsp;&nbsp;</span>
            <span id="block6">&nbsp;&nbsp;&nbsp;</span>
            <span id="block7">&nbsp;&nbsp;&nbsp;</span>
            <span id="block8">&nbsp;&nbsp;&nbsp;</span>
            <span id="block9">&nbsp;&nbsp;&nbsp;</span>
        </div></td>
    </tr>
    <tr><td align="center" id="complete"></td> </tr>
    </tbody>
</table>
</body>
</html>
 