function checkcard()
{
    var gettouser = document.sendcardForm.touser.value;
    if(gettouser=="")
    {
        alert("����д����������");
        document.sendcardForm.touser.focus();
        return false;
    }
    var gettoemail = document.sendcardForm.toemail.value;
    if(gettoemail=="")
    {
        alert("����д�������ʼ���ַ");
        document.sendcardForm.toemail.focus();
        return false;
    }
    else
    {
        var regm = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!gettoemail.match(regm))
        {
            alert("email��ַ��ʽ������зǷ��ַ�!");
            document.sendcardForm.toemail.value = "";
            document.sendcardForm.toemail.focus();
            return false;
        }
    }
    var gettitle = document.sendcardForm.title.value;
    if(gettitle=="")
    {
        alert("����д�ʼ�����");
        document.sendcardForm.title.focus();
        return false;
    }
    var getfromuser = document.sendcardForm.fromuser.value;
    if(getfromuser=="")
    {
        alert("����д����������");
        document.sendcardForm.fromuser.focus();
        return false;
    }
    var getfromemail = document.sendcardForm.fromemail.value;
    if(getfromemail=="")
    {
        alert("����д�������ʼ���ַ");
        document.sendcardForm.fromemail.focus();
        return false;
    }
    else
    {
        var regm = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!getfromemail.match(regm))
        {
            alert("email��ַ��ʽ������зǷ��ַ�!");
            document.sendcardForm.fromemail.value = "";
            document.sendcardForm.fromemail.focus();
            return false;
        }
    }
}