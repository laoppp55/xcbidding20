var ColorHex=new Array('00','33','66','99','CC','FF')
var SpColorHex=new Array('FF0000','00FF00','0000FF','FFFF00','00FFFF','FF00FF')
var current=null

function intocolor()
{
    var colorTable=''
    for (i=0;i<2;i++)
    {
        for (j=0;j<6;j++)
        {
            colorTable=colorTable+'<tr height=12>'
            colorTable=colorTable+'<td width=11 style="background-color:#000000">'

            if (i==0){
                colorTable=colorTable+'<td width=11 style="background-color:#'+ColorHex[j]+ColorHex[j]+ColorHex[j]+'">'}
            else{
                colorTable=colorTable+'<td width=11 style="background-color:#'+SpColorHex[j]+'">'}


            colorTable=colorTable+'<td width=11 style="background-color:#000000">'
            for (k=0;k<3;k++)
            {
                for (l=0;l<6;l++)
                {
                    colorTable=colorTable+'<td width=11 style="background-color:#'+ColorHex[k+i*3]+ColorHex[l]+ColorHex[j]+'">'
                }
            }
        }
    }
    colorTable='<table width=253 border="0" cellspacing="0" cellpadding="0" style="border:1px #000000 solid;border-bottom:none;border-collapse: collapse" bordercolor="000000">'
            +'<tr height=30><td colspan=21 bgcolor=#cccccc>'
            +'<table cellpadding="0" cellspacing="1" border="0" style="border-collapse: collapse">'
            +'<tr><td width="3"><td><input type="text" name="DisColor" id="DisColor" size="6" disabled style="border:solid 1px #000000;background-color:#ffff00"></td>'
            +'<td width="3"><td><input type="text" name="HexColor" id="HexColor" size="7" style="border:inset 1px;font-family:Arial;" value="#000000"></td><td onclick="doclose()">�ر���ɫ</td></tr></table></td></table>'
            +'<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="000000" onmouseover="doOver()" onmouseout="doOut()" onclick="doclick()" style="cursor:hand;">'
            +colorTable+'</table>';
    colorpanel.innerHTML=colorTable
}


//����ɫֵ��ĸ��д
function doOver() {
    if ((event.srcElement.tagName=="TD") && (current!=event.srcElement)) {
        if (current!=null){current.style.backgroundColor = current._background}
        event.srcElement._background = event.srcElement.style.backgroundColor
        document.getElementById('DisColor').style.backgroundColor = event.srcElement.style.backgroundColor
        document.getElementById('HexColor').value = event.srcElement.style.backgroundColor.toUpperCase();
        event.srcElement.style.backgroundColor = "white"
        current = event.srcElement
    }
}


//����ɫֵ��ĸ��д
function doOut() {

    if (current!=null) current.style.backgroundColor = current._background.toUpperCase();
}


function doclick()
{
    if (event.srcElement.tagName == "TD")
    {
        var clr = event.srcElement._background;
        clr = clr.toUpperCase(); //����ɫֵ��д
        if (targetElement)
        {
            //��Ŀ���޼�������ɫֵ
            targetElement.value = clr;
        }
        DisplayClrDlg(false);
        return clr;
    }
}


function doclose()
{

    DisplayClrDlg(false);

}

//Ӧ����ɫ�Ի������ע�����㣺
//��ɫ�Ի��� id : colorpanel ���ܱ�
//������ɫ�Ի�����ʾ���ı��򣨻������������� alt ���ԣ���ֵΪ clrDlg�����ܺ��Դ�Сд��

//�����Ҫ��һ��html���������ɫѡ����,ֻ��Ҫ�������¸Ľ�����

var targetElement = null; //������ɫ�Ի��򷵻�ֵ��Ԫ��

//���������ʱ��ȷ����ʾ����������ɫ�Ի���
//�����ɫ�Ի���������������ʱ���öԻ�������
//�����ɫ�Ի���ɫ��ʱ���� doclick ���������ضԻ���
function OnDocumentClick()
{
    var srcElement = event.srcElement;
    if (srcElement.alt == "clrDlg"||srcElement.alt=="color1"||srcElement.alt=="color2")
    {
        //��ʾ��ɫ�Ի���
        targetElement = event.srcElement;
        DisplayClrDlg(true);
    }




    else
    {
        //�Ƿ�������ɫ�Ի����ϵ����
        while (srcElement && srcElement.id!="colorpanel")
        {
            srcElement = srcElement.parentElement;
        }
        if (!srcElement)
        {
            //��������ɫ�Ի����ϵ����
            DisplayClrDlg(false);
        }
    }

}

//��ʾ��ɫ�Ի���
//display ������ʾ��������
//�Զ�ȷ����ʾλ��
function DisplayClrDlg(display)
{
    var clrPanel = document.getElementById("colorpanel");
    if (display)
    {
        var left = document.body.scrollLeft + event.clientX;
        var top = document.body.scrollTop + event.clientY;
        if (event.clientX+clrPanel.style.pixelWidth > document.body.clientWidth)
        {
            //�Ի�����ʾ������ҷ�ʱ��������ڵ���������ʾ�������
            left -= clrPanel.style.pixelWidth;
        }
        if (event.clientY+clrPanel.style.pixelHeight > document.body.clientHeight)
        {
            //�Ի�����ʾ������·�ʱ��������ڵ���������ʾ������Ϸ�
            top -= clrPanel.style.pixelHeight;
        }

        clrPanel.style.pixelLeft = left;
        clrPanel.style.pixelTop = top;
        clrPanel.style.display = "block";
    }
    else
    {
        clrPanel.style.display = "none";
    }
}
