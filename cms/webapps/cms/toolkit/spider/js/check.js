function checkCommonTable(ctrlname, OnlyOne)
{
    if (OnlyOne == 1)
    {
        if (ctrlname.value != "")
        {
            if (!isFloat(ctrlname.value))
            {
                alert("����д��ȷ������\n Please fill in the exact quantity ");
//				ctrlname.focus();
                return false;
            }
            else if (ctrlname.value <= 0)
            {
                alert("�������������\nThe minimum is 1");
//				ctrlname.focus();
                return false;
            }
            return true;
        }
        else
        {
            alert("����д����\nPlease enter the quantity");
//			ctrlname.focus();
            return false;
        }
    }
    else
    {
        //		alert("do more");
        var bAllEmpty = true;
        for (tmp = 0; tmp < ctrlname.length; tmp++)
        {
            if (ctrlname[tmp].value != "")
            {
                bAllEmpty = false;
                if (!isFloat(ctrlname[tmp].value))
                {
                    alert("����д��ȷ������\nPlease fill in the exact quantity ");
//					ctrlname[tmp].focus();
                    return false;
                }
                else if (ctrlname[tmp].value <= 0)
                {
                    alert("�������������\nThe minimum is 1");
//					ctrlname[tmp].focus();
                    return false;
                }
            }
        }
        if (bAllEmpty == true)
        {
            alert("����д����\nPlease enter the quantity");
//			ctrlname[0].focus();
            return false;
        }
    }
    return true;
}

/*This function removes all spaces from a string
Example Trim(' Me And You ') returns 'MeAndYou'
*/
//function Trim(Untrimmed)
//	{
//	var Trimmed = ''
//	for (var i = 0; i < Untrimmed.length; i++)
//	{
//		if (Untrimmed.charCodeAt(i)!=32)
//		{
//			Trimmed += Untrimmed[i]
//		}
//	}
//
//	return Trimmed
//}

function validpassword(pass1, pass2)
{
    var allValid = true;

    if (trim(pass1) == "")
    {
        alert("�����������룡");
        return false;
    }

    if (trim(pass2) == "")
    {
        alert("��ȷ�����룡");
        return false;
    }

    if (pass1.indexOf(" ") != -1) {
        alert("�����а����ո������������룡");
        return false;
    }

    if (pass2.indexOf(" ") != -1) {
        alert("ȷ�������а����ո�������ȷ�����룡");
        return false;
    }

    if (pass1.length < 4)
    {
        alert("���볤������4���ַ���");
        return false;
    }

    if (pass1.length != pass2.length)
    {
        alert("������������볤�Ȳ�һ�£�");
        return false;
    }
    for (i = 0; i < pass1.length; i++)
    {
        if (pass1.charAt(i) != pass2.charAt(i))
        {
            alert("������������벻һ��!");
            allValid = false;
            break;
        }
    }
    return allValid;
}

function InputValid(d_input, d_notnull, d_type, d_limited, d_low, d_up, d_str)
{
    if (d_input.length > 1)
    {
        var obj = trim(d_input.value);
        var m;
        m = d_input.length;
        m = m.toString();

        for (var i = 0; i < m; i++)
        {
            if (!InputValid_A(obj[i], d_notnull, d_type, d_limited, d_low, d_up, d_str))
            {
                return (false);
            }
        }
    }
    else
    {
        if (!InputValid_A(d_input, d_notnull, d_type, d_limited, d_low, d_up, d_str))
            return false;
    }
    return true;
}


function InputValid_A(d_input, d_notnull, d_type, d_limited, d_low, d_up, d_str)
{
    // not null
    if (d_notnull == 1 && trim(d_input.value).length == 0)
    {
        alert(" ��������" + d_str);
        d_input.focus();
        return (false);
    }

// "int"
    if (d_type == "int")
    {
        if (!isInt(trim(d_input.value)))
        {
            alert(d_str + " ֻ��������");
            d_input.focus();
            return (false);
        }
        if (d_limited == 1 && !(d_low <= trim(d_input.value) && trim(d_input.value) <= d_up))
        {
            alert(d_str + "��ֵ������" + d_low + " �� " + d_up + "֮��.");
            d_input.focus();
            return (false);
        }
        return true;
    }

// ">0"
    if (d_type == "select") {
        if ((trim(d_input.value)) == 0) {
            alert(" ѡ��" + d_str + "!");
            d_input.focus();
            return (false);
        }
        return true;
    }


// "float"
    if (d_type == "float")
    {
        if (!isFloat(trim(d_input.value)))
        {
            alert(d_str + " ֻ���������ּ�С����");
            d_input.focus();
            return (false);
        }
        if (d_limited == 1 && !( d_low <= trim(d_input.value) && trim(d_input.value) <= d_up))
        {
            alert(d_str + "��ֵ������" + d_low + " �� " + d_up + "֮��");
            d_input.focus();
            return (false);
        }
        return true;
    }

// "string"
    if (d_type == "string")
    {
        if (d_limited == 1 && !(d_low <= trim(d_input.value).length && trim(d_input.value).length <= d_up))
        {
            alert(d_str + " �ĳ��ȱ����� " + d_low + " ��" + d_up + " ֮�䡣");
            d_input.focus();
            return (false);
        }
        return (true);
    }

// "date"
    if (d_type == "date")
    {
        if ((!isDate(trim(d_input.value))) || (trim(d_input.value).length != 10))
        {
            alert("����" + d_str + "���������µ�������ʽ��2000-08-08");
            d_input.focus();
            return (false);
        }
        return (true);
    }

// "email"
    if (d_type == "email")
    {
        if (d_notnull == 0 && trim(d_input.value).length == 0) return (true);
        if (!isEmail(trim(d_input.value)))
        {
            alert("���� " + d_str + "��������ȷ��Email��ַ��");
            d_input.focus();
            return (false);
        }
        return (true);
    }

// "fax"
    if (d_type == "fax")
    {
        //is int
        if (!isFax(trim(d_input.value)))
        {
            alert(d_str + " ֻ���������ֺ�'- '");
            d_input.focus();
            return (false);
        }
		//limit
        if (d_limited == 1 && !(d_low <= trim(d_input.value).length && trim(d_input.value).length <= d_up))
        {
            alert(d_str + "�ĳ���ֻ���� " + d_low + " �� " + d_up + " ֮��.");
            d_input.focus();
            return (false);
        }
        return true;
    }

     // auto
    if (d_type == "auto")
    {
        //limit
        if (trim(d_input.value) == 0)
        {
            alert("������ " + d_str);
            return (false);
        }
        return true;
    }


// "zip"
    if (d_type == "zip")
    {
        if (!isInt(trim(d_input.value)))
        {
            alert(d_str + " ֻ��������");
            d_input.focus();
            return (false);
        }
        if (d_limited == 1) {
            if ((d_low == d_up) && (trim(d_input.value).length != d_low)) {
                alert(d_str + "�ĳ���ֻ���� " + d_low + " λ.");
                d_input.focus();
                return (false);
            }
            else {
                if ((d_low < trim(d_input.value).length && trim(d_input.value).length < d_up))
                {
                    alert(d_str + "�ĳ���ֻ���� " + d_up + " λ����.");
                    d_input.focus();
                    return (false);
                }
            }
        }
        return true;
    }

    return (true);
}


function isInt(d_int)
{
    var checkOK = "0123456789-,";
    var checkStr = d_int;
    var allValid = true;
    var decPoints = 0;
    var allNum = "";
    for (i = 0; i < checkStr.length; i++)
    {
        ch = checkStr.charAt(i);
        for (j = 0; j < checkOK.length; j++)
            if (ch == checkOK.charAt(j))
                break;
        if (j == checkOK.length)
        {
            allValid = false;
            break;
        }
        if (ch != ",")
            allNum += ch;
    }
    return (allValid)
}

function isFloat(d_float)
{
    var checkOK = "0123456789-,.";
    var checkStr = d_float;
    var allValid = true;
    var decPoints = 0;
    var allNum = "";
    for (i = 0; i < checkStr.length; i++)
    {
        ch = checkStr.charAt(i);
        for (j = 0; j < checkOK.length; j++)
            if (ch == checkOK.charAt(j))
                break;
        if (j == checkOK.length)
        {
            allValid = false;
            break;
        }
        if ((ch == '-') && (i != 0))
        {
            allValid = false;
            break;
        }
        if (ch != ",")
            allNum += ch;
        if (ch == ".")
            decPoints += 1;
    }
    if (decPoints > 1)
    {
        allValid = false;
    }
    return (allValid)
}

function isDate(d_date)
{
    var checkStr = d_date;

    for (i = 0; i < checkStr.length; i++)
    {
        ch = checkStr.charAt(i);
        if ((i == 4) || (i == 7))
        {
            if (ch != '-')
            {
                return (false);
            }
        }
        else
        {
            if (ch < '0' || ch > '9')
            {
                return (false);
            }
            if ((i == 5 && ch > '1') || (i == 8 && ch > '3')) {
                return (false);
            }
        }
    }
    return (true);
}

function isEmail(d_email)
{
    var checkStr = d_email;
    var emailtag = false;
    var emaildot = 0
    var emailat = 0

    if (checkStr.length < 7) return (false);

    for (i = 0; i < checkStr.length; i++)
    {
        ch = checkStr.charAt(i);

        if (ch == '@') emailat++;
        if (ch == '.') emaildot++;
    }

    if (( emailat == 1 ) && ( emaildot >= 1 ))
    {
        emailtag = true;
    }
    return (emailtag);
}

function isFax(d_int)
{
    var checkOK = "0123456789 -()";
    var checkStr = d_int;
    var allValid = true;
    var decPoints = 0;
    var allNum = "";

    for (i = 0; i < checkStr.length; i++)
    {
        ch = checkStr.charAt(i);
        for (j = 0; j < checkOK.length; j++)
            if (ch == checkOK.charAt(j))
                break;
        if (j == checkOK.length)
        {
            allValid = false;
            break;
        }
        if (ch != ",")
            allNum += ch;
    }
    return (allValid)
}

function trim(str)
{
    var i;

    i = 0;
    while (i < str.length && str.charAt(i) == ' ') i++;
    str = str.substr(i);
    i = str.length - 1;
    while (i >= 0 && str.charAt(i) == ' ') i--;
    str = str.substr(0, i + 1);

    return str
}
function Do_po_Change(form) {
    var num, n, i, m, num2;
    num = GetObjID('Class1ID');
    num2 = GetObjID('Sort');
    m = document.Table.elements[num].selectedIndex - 1;
    n = document.Table.elements[num2].length;
    for (i = n - 1; i >= 0; i--)
        document.Table.elements[num2].options[i] = null;

    if (m >= 0) {
        for (i = 0; i < po_detail_show[m].length; i++) {
            NewOptionName = new Option(po_detail_show[m][i], po_detail_value[m][i]);
            document.Table.elements[num2].options[i] = NewOptionName;
        }
        document.Table.elements[num2].options[i - 1].selected = true;
    }
}

function GetObjID(ObjName)
{
    for (var ObjID = 0; ObjID < window.Table.elements.length; ObjID++)
        if (window.Table.elements[ObjID].name == ObjName)
        {
            return(ObjID);
            break;
        }
    return(-1);
}

function relationlayer(l1, l2, flag) {
    if (flag == 1) {
        l1_text = l1.options[l1.selectedIndex].value
        var f2 = l2.options[l2.selectedIndex].value
        var f2_s = f2.split("_")
        l2_text = f2_s[0]
        if (l2_text != l1_text) {

            thecount = l2.options.length
            for (var i = 0; i < thecount; i++) {

                f2 = l2.options[i].value
                f2_s = f2.split("_")
                l2_text = f2_s[0]

                if (l2_text == l1_text) {

                    l2.options[i].selected = true
                    break;
                }
            }
        }
    }
    else {

        var f2 = l2.options[l2.selectedIndex].value
        var f2_s = f2.split("_")
        l2_text = f2_s[0]
        thecount = l1.options.length
        for (var i = 0; i < thecount; i++) {
            l1_text = l1.options[i].value

            if (l2_text == l1_text) {
                l1.options[i].selected = true
                break;
            }
        }
    }
}

function layer(l1, l2) {
    l1_text = l1.options[l1.selectedIndex].value
    var f2 = l2.options[l2.selectedIndex].value
    var f2_s = f2.split("&")
    l2_text = f2_s[1]
    if (l2_text != l1_text) {
        thecount = l2.options.length
        for (var i = 0; i < thecount; i++) {
            f2 = l2.options[i].value
            f2_s = f2.split("&")
            l2_text = f2_s[1]

            if (l2_text == l1_text) {
                l2.options[i].selected = true
                break;
            }
        }
    }
}



