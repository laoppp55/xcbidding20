function addfriend()
        {
            var getname = document.finduserForm.findusername.value;
            if (getname == "")
            {
                alert("������Ҫ����ĺ���");
                document.finduserForm.findusername.focus();
                return false;
            }
            else
            {
                var objXml = new ActiveXObject("Microsoft.XMLHTTP");
                objXml.open("POST", "friendway.jsp?name="+getname,false);
                objXml.Send();
                var valuefriend = objXml.responseText;
                if (valuefriend.indexOf("1") != -1)
                {
                    alert("���ܼ��Լ�Ϊ����");
                    document.finduserForm.findusername.value = "";
                    document.finduserForm.findusername.focus();
                    return false;
                }
                if(valuefriend.indexOf("2") != -1)
                {
                    alert("�����Ѿ������б���");
                    document.finduserForm.findusername.value = "";
                    document.finduserForm.findusername.focus();
                    return false;
                }
                if(valuefriend.indexOf("3") != -1)
                {
                    alert("���û�������");
                    document.finduserForm.findusername.value = "";
                    document.finduserForm.findusername.focus();
                    return false;
                }
                if(valuefriend.indexOf("4") != -1)
                {
                    return true;
                }
            }
        }