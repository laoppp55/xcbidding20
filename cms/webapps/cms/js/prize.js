function applicateprize(id)
{
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "/checkprize.jsp?id="+id, false);
    objXml.Send();
    var valueid = objXml.responseText;
    if (valueid.indexOf("1") != -1)
    {
        alert("��Ļ��ֲ��㣬����ʧ�ܣ�");
    }
    if(valueid.indexOf("2") != -1)
    {
        alert("��л���Ĳ���!");
    }
    if(valueid.indexOf("3") != -1)
    {
        alert("����û�е�¼!");
    }
    if(valueid.indexOf("4") != -1)
    {
        alert("�Բ��𣬸ó齱����ϣ�");
    }
}

function convertprize(id)
{
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "/toprize.jsp?id="+id, false);
    objXml.Send();
    var valueid = objXml.responseText;
    if (valueid.indexOf("1") != -1)
    {
        alert("��Ļ��ֲ��㣬����Ʒʧ�ܣ�");
    }
    if(valueid.indexOf("2") != -1)
    {
        alert("��л���Ĳ���!");
    }
    if(valueid.indexOf("3") != -1)
    {
        alert("����û�е�¼!");
    }
    if(valueid.indexOf("4") != -1)
    {
        alert("�Բ��𣬸ý�Ʒ�Ѷһ���ϣ�");
    }
}