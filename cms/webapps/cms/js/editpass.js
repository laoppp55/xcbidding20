        function editpass(userid)
        {
            var getpasswd = document.passForm.passwd.value;
            if (getpasswd == "")
            {
                alert("�����������");
                document.passForm.passwd.focus();
                return false;
            }
            else
            {
                var objXml = new ActiveXObject("Microsoft.XMLHTTP");
                objXml.open("POST", "checkpass.jsp?userid=" + userid + "&getpass=" + getpasswd, false);
                objXml.Send();
                var valuepass = objXml.responseText;
                valuepass = Trim(valuepass);
                if (valuepass.indexOf("false") != -1)
                {
                    alert("���������");
                    document.passForm.passwd.value = "";
                    document.passForm.passwd.focus();
                    return false;
                }
            }

            var getnewpasswd = document.passForm.newpasswd.value;
            if (getnewpasswd == "")
            {
                alert("������������");
                document.passForm.newpasswd.focus();
                return false;
            }
            var getppasswd = document.passForm.ppasswd.value;
            if (getppasswd == "")
            {
                alert("������ȷ��������");
                document.passForm.ppasswd.focus();
                return false;
            }

            if (getnewpasswd != getppasswd || getnewpasswd.length != getppasswd.length)
            {
                alert("�������벻һ��,����������");
                document.passForm.newpasswd.value = "";
                document.passForm.ppasswd.value = "";
                document.passForm.newpasswd.focus();
                return false;
            }


        }
        function LTrim(str)
        {
            var whitespace = new String("");
            var s = new String(str);
            if (whitespace.indexOf(s.charAt(0)) != -1)
            {
                var j = 0, i = s.length;
                while (j < i && whitespace.indexOf(s.charAt(j)) != -1)
                {
                    j++;
                }
                s = s.substring(j, i);
            }
            return s;
        }
        function RTrim(str)
        {
            var whitespace = new String("");
            var s = new String(str);
            if (whitespace.indexOf(s.charAt(s.length - 1)) != -1)
            {
                var i = s.length - 1;
                while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
                {
                    i--;
                }
                s = s.substring(0, i + 1);
            }
            return s;
        }
        function Trim(str)
        {
            return RTrim(LTrim(str));
        }