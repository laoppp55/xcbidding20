        function checkallvalue()
        {
            for (var i = 0; i < document.delForm.elements.length; i++)
            {
                var e = document.delForm.elements[i];
                if (e.name != 'allbox' && e.type == 'checkbox' && e.name != 'option')
                {
                    e.checked = document.delForm.allbox.checked;
                }
            }
        }

        function delmessage()
        {
            var total = 0;
            var max = document.delForm.cb.length;
            var isback = true;
            if (max == undefined)
            {
                if (document.delForm.cb.checked) {
                    lenvalue = document.delForm.cb.value;
                    total += 1;
                }
            }
            else
            {
                for (var idx = 0; idx < max; idx++)
                {
                    if (eval("document.delForm.cb[" + idx + "].checked"))
                    {
                        total += 1;
                    }
                }
            }
            if (total == 0)
            {
                alert("��ѡ��ɾ������Ϣ!");
            }
            else
            {
                var val;
                val = confirm("ȷ��Ҫɾ����");
                if (val == 1) {
                    delForm.action = "/message/delmessage.jsp";
            		delForm.submit();
                }
            }

        }

        function finduser()
        {
            var getname = document.finduserForm.findusername.value;
            if(getname=="")
            {
                alert("���������ĺ���");
                document.finduserForm.findusername.focus();
                return false;
            }
        }

        function changUser(user,id)
        {
             document.getElementById("setuserinput").innerHTML = user;
             document.sendForm.reciveperson.value = id;
        }
        function checkSend()
        {
            document.sendForm.contents.value = FCKeditorAPI.GetInstance('content').GetXHTML(true);
            var getcontent = document.sendForm.contents.value;
            if(document.getElementById("setuserinput").innerHTML=="")
            {
                alert("��ѡ��ظ���");
                return false;
            }
            if(getcontent.length==0)
            {
                alert("��������Ϣ����");
                return false;
            }
        }