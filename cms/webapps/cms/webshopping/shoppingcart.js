function insertcart(articleid) {
    var hostName = window.location.hostname;
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "doshopping.jsp?num=1&pid=" + articleid + "&sitename=" + hostName, false);
    objXml.Send();

    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        alert(retstr);
    }
}
function checkAddress() {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "checkAddress.jsp", false);
    objXml.Send();

    var retstr = objXml.responseText;
    if (retstr.length > 0 && retstr.indexOf("false") < 0) {
        //д���û��ջ�����Ϣ
        document.getElementById("alladdress").innerHTML = retstr;
        selectadd1();
    }
    if (retstr.length > 0 && retstr.indexOf("false") > 0) {
        //û���򴴽�
        var add_address = "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='dot'>"
                + "<tr>"
                + "<td width='40' rowspan='7' valign='top'><!--DWLayoutEmptyCell-->&nbsp;</td>"
                + "<td height='44' colspan='6' valign='middle' class='style1'>�ջ�����Ϣ</td>"
                + "</tr>"
                + "<tr>"
                + "<td width='72' height='38' align='right' valign='top'>�ջ��ˣ�</td>"
                + "<td colspan='5' valign='top' align='left'><input name='connname' type='text' size='14' /></td>"
                + "</tr>"
                + "<tr>"
                + "<td height='38' align='right' valign='top'>ʡ�ݣ�</td>"
                + "<td width='115' valign='top' align='left'><label><input name=provice type=text>"
                + "</label></td>"
                + "<td width='92' valign='top' align='left'>����</td>"
                + "<td width='116' valign='top' align='left'><input name=city type=text></td>"
                + "<td width='70' valign='top' align='left'>������</td>"
                + "<td width='138' valign='top' align='left'><input name=zone type=text>"
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td height='38' align='right' valign='top'>��ϸ��ַ��</td>"
                + "<td colspan='5' valign='top' align='left'><input name='address' type='text' size='40' /></td>"
                + "</tr>"
                + "<tr>"
                + "<td height='38' align='right' valign='top'>�������룺</td>"
                + "<td valign='top'><input name='zip' type='text' size='14' /></td>"
                + "<td colspan='4' valign='top'>����ȷ��д�ʱ࣬��ȷ�����Ķ���˳���ʹ�</td>"
                + "</tr>"
                + "<tr>"
                + "<td height='38' align='right' valign='top'>�ƶ��绰��</td>"
                + "<td valign='top'><input name='mobile' type='text' size='14' /></td>"
                + "<td align='center' valign='top'>�̶��绰��</td>"
                + "<td valign='top'><input name='phone' type='text' size='14' /></td>"
                + "<td colspan='2' valign='top'><!--DWLayoutEmptyCell-->&nbsp;</td>"
                + "</tr>"
                + "<tr>"
                + "<td height='52' colspan='6' align='center' valign='top'><input type=button name=button value=\"�ύ\" onClick='javascript:conninfo1(0);'></td>"
                + "</tr>"
                + "</table>";
        document.getElementById("connaddr").innerHTML = add_address;
    }
}
function add1() {
    var add_address = "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='dot'>"
            + "<tr>"
            + "<td width='40' rowspan='7' valign='top'><!--DWLayoutEmptyCell-->&nbsp;</td>"
            + "<td height='44' colspan='6' valign='middle' class='style1'>�ջ�����Ϣ</td>"
            + "</tr>"
            + "<tr>"
            + "<td width='72' height='38' align='right' valign='top'>�ջ��ˣ�</td>"
            + "<td colspan='5' valign='top' align='left'><input name='connname' type='text' size='14' /></td>"
            + "</tr>"
            + "<tr>"
            + "<td height='38' align='right' valign='top'>ʡ�ݣ�</td>"
            + "<td width='115' valign='top' align='left'><label><input name=provice type=text>"
            + "</label></td>"
            + "<td width='92' valign='top' align='left'>����</td>"
            + "<td width='116' valign='top' align='left'><input name=city type=text></td>"
            + "<td width='70' valign='top' align='left'>������</td>"
            + "<td width='138' valign='top' align='left'><input name=zone type=text>"
            + "</td>"
            + "</tr>"
            + "<tr>"
            + "<td height='38' align='right' valign='top'>��ϸ��ַ��</td>"
            + "<td colspan='5' valign='top' align='left'><input name='address' type='text' size='40' /></td>"
            + "</tr>"
            + "<tr>"
            + "<td height='38' align='right' valign='top'>�������룺</td>"
            + "<td valign='top'><input name='zip' type='text' size='14' /></td>"
            + "<td colspan='4' valign='top'>����ȷ��д�ʱ࣬��ȷ�����Ķ���˳���ʹ�</td>"
            + "</tr>"
            + "<tr>"
            + "<td height='38' align='right' valign='top'>�ƶ��绰��</td>"
            + "<td valign='top'><input name='mobile' type='text' size='14' /></td>"
            + "<td align='center' valign='top'>�̶��绰��</td>"
            + "<td valign='top'><input name='phone' type='text' size='14' /></td>"
            + "<td colspan='2' valign='top'><!--DWLayoutEmptyCell-->&nbsp;</td>"
            + "</tr>"
            + "<tr>"
            + "<td height='52' colspan='6' align='center' valign='top'><input type=button name=button value=\"�ύ\" onClick='javascript:conninfo1(0);'></td>"
            + "</tr>"
            + "</table>";
    document.getElementById("connaddr").innerHTML = add_address;
    document.getElementById("sendway").innerHTML = "";
    document.getElementById("payway").innerHTML = "";
    document.getElementById("productinfo").innerHTML = "";
}
function conninfo1(type) {
    if (confirmform.connname.value == null || confirmform.connname.value == "") {
        alert("�������ջ�������");
        confirmform.connname.focus();
        return false;
    }
    if (confirmform.address.value == null || confirmform.address.value == "") {
        alert("��������ϸ��ַ");
        confirmform.address.focus();
        return false;
    }
    if (confirmform.zip.value == null || confirmform.zip.value == "") {
        alert("��������ȷ����������");
        confirmform.zip.focus();
        return false;
    }
    if (confirmform.mobile.value == null || confirmform.mobile.value == "") {
        alert("�������ֻ�����");
        confirmform.mobile.focus();
        return false;
    }
    if (confirmform.phone.value == null || confirmform.phone.value == "") {
        alert("������绰����");
        confirmform.phone.focus();
        return false;
    }
    var connname = confirmform.connname.value;
    var prov = confirmform.provice.value;
    var city = confirmform.city.value;
    var zone = confirmform.zone.value;
    var zip = confirmform.zip.value;
    var mobile = confirmform.mobile.value;
    var phone = confirmform.phone.value;
    var address = confirmform.address.value;

    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "sendinfo1.jsp?id=" + type + "&connname=" + connname + "&prov=" + prov + "&city=" + city + "&zone=" + zone + "&zip=" + zip + "&mobile=" + mobile + "&phone=" + phone + "&address=" + address, false);
    objXml.Send();

    var retstr = objXml.responseText;
    if (retstr.length > 0) {
        document.getElementById("alladdress").innerHTML = retstr;
        document.getElementById("connaddr").innerHTML = "";
        selectadd1();
    }
    else {
        alert("���ʧ�ܣ�");
    }
}
function edit(id) {
    if (id == 0) {
        alert("��ַΪ�գ��������ܽ����޸Ĳ�����")
        return false;
    } else {
        var objXml = new ActiveXObject("Microsoft.XMLHTTP");
        objXml.open("POST", "editadd.jsp?id=" + id, false);
        objXml.Send();

        var retstr = objXml.responseText;
        if (retstr != null && retstr.length > 0) {
            document.getElementById("connaddr").innerHTML = retstr;
            document.getElementById("sendway").innerHTML = "";
            document.getElementById("payway").innerHTML = "";
            document.getElementById("productinfo").innerHTML = "";
        }
    }
}
function del(id) {
    if (id == 0) {
        alert("��ַΪ�գ��������ܽ���ɾ��������")
        return false;
    } else {
        var val;
        val = confirm("��ȷ��Ҫɾ����");
        if (val == 1) {
            var objXml = new ActiveXObject("Microsoft.XMLHTTP");
            objXml.open("POST", "delete.jsp?id=" + id + "&startflag=1", false);
            objXml.Send();

            var retstr = objXml.responseText;
            if (retstr != null && retstr.length > 0 && retstr.indexOf("true") < 0 && retstr.indexOf("false") < 0) {
                alert("ɾ���ɹ���");
                document.getElementById("alladdress").innerHTML = retstr;
            }
            if (retstr != null && retstr.length > 0 && retstr.indexOf("true") > 0) {
                alert("ɾ���ɹ���");
                document.getElementById("alladdress").innerHTML = "            <table width='90%' border='0' cellpadding='0' cellspacing='0'>\n" +
                                                                  "                <!--DWLayoutTable-->\n" +
                                                                  "                <tr>\n" +
                                                                  "                  <td height='41' valign='middle' style='background:#F1F1F1; color:#3F3F3F; padding-left:20px;'><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
                                                                  "                  <td height='41' valign='middle' style='background:#F1F1F1; color:#3F3F3F; padding-left:20px;'>����</td>\n" +
                                                                  "                  <td height='41' valign='middle' style='background:#F1F1F1; color:#3F3F3F; padding-left:20px;'>ʡ��</td>\n" +
                                                                  "                  <td width='56' align='center' valign='middle' style='background:#F1F1F1; color:#3F3F3F; '>����</td>\n" +
                                                                  "                  <td width='170' align='center' valign='middle' style='background:#F1F1F1; color:#3F3F3F;'>��ַ</td>\n" +
                                                                  "                  <td width='63' align='center'  valign='middle' style='background:#F1F1F1; color:#3F3F3F;;'>�ʱ�</td>\n" +
                                                                  "                  <td width='66' align='center'  valign='middle' style='background:#F1F1F1; color:#3F3F3F;;'>�绰</td>\n" +
                                                                  "                  <td width='109' align='center'  valign='middle' style='background:#F1F1F1; color:#3F3F3F;;'><!--DWLayoutEmptyCell-->&nbsp;</td>\n" +
                                                                  "                </tr>" +
                                                                  "<tr><td height='37' colspan='8' align='center' valign='middle' style='border-bottom:#AFAFAF 1px solid;color:#61749F; padding-left:20px;'><span style='color:#333333;border-bottom:#AFAFAF 1px solid;'>��û���ṩ�ջ���ַ������д������ϸ�ջ���Ϣ�������һ��������</span></td></tr><!--DWLayoutTable--></table>";
                document.getElementById("connaddr").innerHTML = "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='dot'>"
                        + "<tr>"
                        + "<td width='40' rowspan='7' valign='top'><!--DWLayoutEmptyCell-->&nbsp;</td>"
                        + "<td height='44' colspan='6' valign='middle' class='style1'>�ջ�����Ϣ</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td width='72' height='38' align='right' valign='top'>�ջ��ˣ�</td>"
                        + "<td colspan='5' valign='top' align='left'><input name='connname' type='text' size='14' /></td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td height='38' align='right' valign='top'>ʡ�ݣ�</td>"
                        + "<td width='115' valign='top' align='left'><label><input name=provice type=text>"
                        + "</label></td>"
                        + "<td width='92' valign='top' align='left'>����</td>"
                        + "<td width='116' valign='top' align='left'><input name=city type=text></td>"
                        + "<td width='70' valign='top' align='left'>������</td>"
                        + "<td width='138' valign='top' align='left'><input name=zone type=text>"
                        + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td height='38' align='right' valign='top'>��ϸ��ַ��</td>"
                        + "<td colspan='5' valign='top' align='left'><input name='address' type='text' size='40' /></td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td height='38' align='right' valign='top'>�������룺</td>"
                        + "<td valign='top'><input name='zip' type='text' size='14' /></td>"
                        + "<td colspan='4' valign='top'>����ȷ��д�ʱ࣬��ȷ�����Ķ���˳���ʹ�</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td height='38' align='right' valign='top'>�ƶ��绰��</td>"
                        + "<td valign='top'><input name='mobile' type='text' size='14' /></td>"
                        + "<td align='center' valign='top'>�̶��绰��</td>"
                        + "<td valign='top'><input name='phone' type='text' size='14' /></td>"
                        + "<td colspan='2' valign='top'><!--DWLayoutEmptyCell-->&nbsp;</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td height='52' colspan='6' align='center' valign='top'><input type=button name=button value=\"�ύ\" onClick='javascript:conninfo1(0);'></td>"
                        + "</tr>"
                        + "</table>";
                document.getElementById("sendway").innerHTML = "";
                document.getElementById("payway").innerHTML = "";
                document.getElementById("productinfo").innerHTML = "";
            }
            if (retstr != null && retstr.length > 0 && retstr.indexOf("false") > 0) {
                alert("ɾ��ʧ�ܣ�");
            }
        }
    }
}
function selectadd(id) {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "selectadd.jsp?id=" + id, false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        document.getElementById("sendway").innerHTML = retstr;
        document.getElementById("connaddr").innerHTML = "";
        document.getElementById("payway").innerHTML = "";
        document.getElementById("productinfo").innerHTML = "";
    }
}
function selectadd1() {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "selectadd1.jsp", false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        document.getElementById("sendway").innerHTML = retstr;
        document.getElementById("connaddr").innerHTML = "";
        document.getElementById("payway").innerHTML = "";
        document.getElementById("productinfo").innerHTML = "";
    }
}
function selectSendway() {
    var sendway = 0;
    var len = confirmform.sendway.length;
    if (len == undefined) {
        if (confirmform.sendway.checked) {
            sendway = confirmform.sendway.value;
        }
    }
    else {
        for (var i = 0; i < len; i++) {
            if (confirmform.sendway[i].checked) {
                sendway = confirmform.sendway[i].value;
                break;
            }
        }
    }
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "selectsendway.jsp?sendway=" + sendway, false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        document.getElementById("sendway").innerHTML = retstr;
        var objXml1 = new ActiveXObject("Microsoft.XMLHTTP");
        objXml1.open("POST", "getpayway.jsp", false);
        objXml1.send();
        var paywaystr = objXml1.responseText;
        if (paywaystr.length > 0) {
            document.getElementById("payway").innerHTML = paywaystr;
            document.getElementById("productinfo").innerHTML = "";
        }
    }

}
function editSendway(sendway) {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "editsendway.jsp?sendway=" + sendway, false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        document.getElementById("sendway").innerHTML = retstr;
        document.getElementById("payway").innerHTML = "";
        document.getElementById("productinfo").innerHTML = "";
    }
}
function selectPayway() {
    var payway = 0;
    var len = confirmform.payway.length;
    if (len == undefined) {
        if (confirmform.payway.checked) {
            payway = confirmform.payway.value;
        }
    }
    else {
        for (var i = 0; i < len; i++) {
            if (confirmform.payway[i].checked) {
                payway = confirmform.payway[i].value;
                break;
            }
        }
    }
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "selectpayway.jsp?payway=" + payway, false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        document.getElementById("payway").innerHTML = retstr;
    }
    var objXml1 = new ActiveXObject("Microsoft.XMLHTTP");
    objXml1.open("POST", "productinfo.jsp", false);
    objXml1.send();
    var retstr1 = objXml1.responseText;
    if (retstr1 != null && retstr1.length > 0) {
        document.getElementById("productinfo").innerHTML = retstr1;
    }
}
function editPayway(payway) {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "getpayway.jsp?payway=" + payway, false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0) {
        document.getElementById("payway").innerHTML = retstr;
        document.getElementById("productinfo").innerHTML = "";
    }
}
function getval() {
    var b = document.getElementById("newtj");
    b.disabled = true;
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "createOrder.jsp?startflag=1", false);
    objXml.send();
    var retstr = objXml.responseText;
    if (retstr.length > 0 && retstr.indexOf("false") == -1) {
        retstr = retstr.substring((retstr.indexOf("<orderid>") + 9), retstr.indexOf("</orderid>"));
        window.location = "order.shtml?orderid=" + retstr;
    }
    else {
        alert("�ύ����ʧ��");
        window.location = "/";
    }
}
function isNumber(num) {
    strRef = "1234567890";
    for (i = 0; i < num.length; i++)
    {
        tempChar = num.substring(i, i + 1);
        if (strRef.indexOf(tempChar, 0) == -1) {
            return false;
        }
    }
    return true;
}

function updateCart(pid, num) {
    if (!isNumber(num) || num == "0") {
        alert("������һ������0������");
        return false;
    } else {
        var objXml = new ActiveXObject("Microsoft.XMLHTTP");
        objXml.open("POST", "update_shoppingcart.jsp?pid=" + pid + "&num=" + num, false);
        objXml.Send();

        var retstr = objXml.responseText;
        if (retstr != null && retstr.length > 0 && retstr.indexOf("true") > -1) {
            shoppingcart();
        }
    }
}
function shoppingcart() {
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST", "viewshopping.jsp", false);
    objXml.Send();

    var retstr = objXml.responseText;
    if (retstr != null && retstr.length > 0 && retstr.indexOf("false") < 0) {
        document.getElementById("shopping").innerHTML = retstr;
    }
    if (retstr != null && retstr.length > 0 && retstr.indexOf("false") > -1) {
        document.getElementById("shopping").innerHTML = "����û�й����κ���Ʒ";
    }
}
function delete_shoppingcart(id) {
    var val;
    val = confirm("��ȷ��Ҫɾ����");
    if (val == 1) {
        var objXml = new ActiveXObject("Microsoft.XMLHTTP");
        objXml.open("POST", "delete_shoppingcart.jsp?pid=" + id, false);
        objXml.Send();

        var retstr = objXml.responseText;
        if (retstr != null && retstr.length > 0 && retstr.indexOf("true") > -1) {
            alert("ɾ����Ʒ�ɹ���");
            shoppingcart();
        }
        if (retstr != null && retstr.length > 0 && retstr.indexOf("false") > -1) {
            alert("ɾ����Ʒʧ�ܣ�");
        }
    }
}
function gobuy() {
    window.location = "js.shtml";
}