        function loginUser()
        {
            var getloginuser = document.loginForm.user_id.value;
            if (getloginuser == "")
            {
                alert("�������û���");
                document.loginForm.user_id.focus();
                return false;
            }
            var getloginpass = document.loginForm.user_pwd.value;
            if (getloginpass == "")
            {
                alert("����������");
                document.loginForm.user_pwd.focus();
                return false;
            }
        }

