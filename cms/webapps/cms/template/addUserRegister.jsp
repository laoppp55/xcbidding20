<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.xml.*,
                com.bizwink.cms.viewFileManager.*"
        contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.markManager.mark" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    //     �޸ı༭����ȡֵ
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    int gaoji=-1;
    IMarkManager markMgr = markPeer.getInstance();
    mark vmark=null;
    String viewtable="";
    String viewtable1="";
    String viewtable2="";
    String viewtable3="";
    String viewtable4="";
    String viewtable5="";

    String viewtd1="";
    String viewtd2="";
    String viewtd3="";

    String viewput1="";
    String viewput2="";
    String gjform="";
    String viewimg1="";
    if(markID>0)
    {

        vmark=markMgr.getAMark(markID);
        String gjstr="";
        String content = vmark.getContent();
        String stylecontent=vmark.getContent();
        if(stylecontent.indexOf("[GAOJI]")!=-1)
        {
            gjstr=stylecontent.substring(stylecontent.indexOf("[GAOJI]")+"[GAOJI]".length(),stylecontent.indexOf("[/GAOJI]"));
            try{
                gaoji=Integer.parseInt(gjstr);
            }catch(Exception e){
                gaoji=-1;
            }

        }

        if(gaoji!=-1)
        {
            if(stylecontent.indexOf("[CONTENT]")>-1)
            {
                gjform=stylecontent.substring(stylecontent.indexOf("[CONTENT]")+"[CONTENT]".length(),stylecontent.indexOf("[/CONTENT]"));
                gjform=gjform.substring(gjform.indexOf("class=\"biz_table\">")+"class=\"biz_table\">".length());

                System.out.println("gjform="+gjform);
            }
        }
        if(stylecontent.indexOf("[STYLES]")!=-1)
        {
            if(stylecontent.indexOf("class=\"biz_table\"")!=-1)
            {

                viewtable=stylecontent.substring(stylecontent.indexOf("<table"),stylecontent.indexOf("class=\"biz_table\""));
                if(viewtable.indexOf("cellpadding=")!=-1)
                {
                    // System.out.println("viewtable1="+viewtable1+" "+viewtable1.indexOf("cellpadding=")+"  "+viewtable1.lastIndexOf(" "));
                    viewtable1=viewtable.substring(viewtable.indexOf("cellpadding="),viewtable.lastIndexOf(" "));
                    if(viewtable1.indexOf("cellspacing=")!=-1)
                    {

                        viewtable2=viewtable1.substring(viewtable1.indexOf("cellspacing=")+12,viewtable1.lastIndexOf(" "));
                        if(viewtable2.indexOf(" ")!=-1)
                        {
                            viewtable2=viewtable2.replaceAll(" ","");
                        }
                    }
                    //��� cellpadding��ֵ
                    if(viewtable1.indexOf("cellpadding=")!=-1){
                        viewtable1=viewtable1.substring(viewtable1.indexOf("cellpadding=")+12,viewtable1.indexOf(" "));
                    }

                }
                if(viewtable.indexOf("cellspacing=")!=-1)
                {
                    // System.out.println("viewtable1="+viewtable1+" "+viewtable1.indexOf("cellpadding=")+"  "+viewtable1.lastIndexOf(" "));
                    viewtable=viewtable.substring(viewtable.indexOf("cellspacing="),viewtable.lastIndexOf(" "));
                    if(viewtable.indexOf("cellspacing=")!=-1)
                    {

                        viewtable2=viewtable.substring(viewtable.indexOf("cellspacing=")+12,viewtable.lastIndexOf(" "));
                        if(viewtable2.indexOf(" ")!=-1)
                        {
                            viewtable2=viewtable2.replaceAll(" ","");
                        }
                    }
                    //��� cellpadding��ֵ


                }





            }
            //ȡ��ʽ��[styles]���������
            if(stylecontent.indexOf("<!--")!=-1)
            {
                stylecontent=stylecontent.substring(stylecontent.indexOf("<!--")+4,stylecontent.indexOf("-->"));
                //   System.out.println("stylecontent="+stylecontent);
            }
            //��ȡ.biz_table�����������
            if(stylecontent.indexOf("biz_table{")!=-1)
            {
                viewtable3=stylecontent.substring(stylecontent.indexOf("biz_table{")+11,stylecontent.indexOf("}"));
                //   System.out.println("viewtable3="+viewtable3);
                if(viewtable3.indexOf(" ")!=-1)
                {
                    viewtable4=viewtable3.substring(viewtable3.indexOf(" ")+1,viewtable3.lastIndexOf(";"));
                    if(viewtable4.indexOf(" ")!=-1)
                    {
                        viewtable5=viewtable4.substring(viewtable4.indexOf(" ")+1,viewtable4.length());
                        //       System.out.println("viewtable5="+viewtable5+"bb");
                    }
                    if(viewtable4.indexOf(" ")!=-1)
                    {
                        viewtable4=viewtable4.substring(0,viewtable4.indexOf(" "));
                        //        System.out.println("viewtable4="+viewtable4);
                    }
                }
                if(viewtable3.indexOf("border:")!=-1)
                {
                    viewtable3=viewtable3.substring(viewtable3.indexOf("border:")+7,viewtable3.indexOf(" "));
                    //      System.out.println("viewtable3="+viewtable3);
                }
            }
            // ��ȡ.biz_table td�����������
            if(stylecontent.indexOf("biz_table td{")!=-1)
            {
                viewtd1=stylecontent.substring(stylecontent.indexOf("biz_table td{")+14,stylecontent.indexOf(".biz_table input"));
                //     System.out.println("viewtd1="+viewtd1);
                if(viewtd1.indexOf("font-family:")!=-1)
                {
                    viewtd3=viewtd1.substring(viewtd1.indexOf("font-family:")+12,viewtd1.indexOf(" ; text-align"));
                    //        System.out.println("viewtd3="+viewtd3);
                }
                if(viewtd1.indexOf("color:")!=-1)
                {
                    viewtd2=viewtd1.substring(viewtd1.indexOf("color:")+6,viewtd1.indexOf("font-family:")-2);
                    //       System.out.println("viewtd2="+viewtd2);
                }
                if(viewtd1.indexOf("font-size:")!=-1)
                {
                    viewtd1=viewtd1.substring(viewtd1.indexOf("font-size:")+10,viewtd1.indexOf(" ")-3);
                    //     System.out.println("viewtd1="+viewtd1);
                }
            }
            //ȡ.biz_table input�����������
            if(stylecontent.indexOf("biz_table input{")!=-1)
            {
                viewput1=stylecontent.substring(stylecontent.indexOf("biz_table input{")+17,stylecontent.indexOf("biz_table img"));
                //        System.out.println("viewput1="+viewput1);
                if(viewput1.lastIndexOf("size:")!=-1)
                {
                    viewput2=viewput1.substring(viewput1.lastIndexOf("size:")+5,viewput1.lastIndexOf("px;"));
                    //            System.out.println("viewput2="+viewput2);
                }
                if(viewput1.indexOf("font-size:")!=-1)
                {
                    viewput1=viewput1.substring(viewput1.indexOf("font-size:")+10,viewput1.lastIndexOf("px;  size:"));
                    //          System.out.println("viewput1="+viewput1);
                }

            }
            //biz_table imgȡ���������ʽ
            if(stylecontent.indexOf("biz_table img{")!=-1)
            {
                viewimg1=stylecontent.substring(stylecontent.indexOf("biz_table img{")+15,stylecontent.lastIndexOf("}"));
                if(viewimg1.indexOf("border:")!=-1)
                {
                    viewimg1=viewimg1.substring(viewimg1.indexOf("border:")+7,viewimg1.lastIndexOf(";"));
                    //          System.out.println("viewimg1="+viewimg1);
                }
            }
        }
    }


    int siteID = authToken.getSiteID();
    String sitename = authToken.getSitename();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);

    int listType = 0;
    int innerFlag = 0;
    String notes = "";
    String cname = "�û�ע����";
    String gjcontent=ParamUtil.getParameter(request,"gjcontent");
    int type = ParamUtil.getIntParameter(request, "type", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");


    if (doCreate) {
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        listType = ParamUtil.getIntParameter(request, "listType", 0);
        gaoji=ParamUtil.getIntParameter(request,"gaoji",-1);

        String tianchong=ParamUtil.getParameter(request,"tianchong");
        String jianju=ParamUtil.getParameter(request,"jianju");
        String biankuang=ParamUtil.getParameter(request,"biankuang");
        String biankuangstyle=ParamUtil.getParameter(request,"biankuangstyle");
        String ziti=ParamUtil.getParameter(request,"ziti");
        String zitidaxiao=ParamUtil.getParameter(request,"zitidaxiao");
        String ziticol=ParamUtil.getParameter(request,"ziticol");
        String inputsize=ParamUtil.getParameter(request,"inputsize");
        String inputzisize=ParamUtil.getParameter(request,"inputzisize");
        String biankuangcol=ParamUtil.getParameter(request,"biankuangcol");
        String imgbiankuang=ParamUtil.getParameter(request,"imgbiankuang");
        String style="";
        if(tianchong!=null)
        {
            style=style+"cellpadding="+tianchong+"   ";
        }
        if(jianju!=null)
        {
            style=style+"cellspacing="+jianju+"   ";
        }
        if(biankuang==null)
        {
            biankuang="1";
        }
        if(biankuangstyle==null)
        {
            biankuangstyle="dashed";
        }
        if(biankuangstyle==null)
        {
            biankuangcol="#CCCCCC";
        }
        if(zitidaxiao==null)
        {
            zitidaxiao="12";
        }
        if(ziticol==null)
        {
            ziticol="#000000";
        }
        if(ziti==null)
        {
            ziti="����";
        }
        if(inputsize==null)
        {
            inputsize="18";
        }
        if(inputzisize==null)
        {
            inputzisize="12";
        }
        if(imgbiankuang==null)
        {
            imgbiankuang="0";
        }
        String head="<style type=\"text/css\">\r\n" +
                "<!--";
        head=head+".biz_table{ border:"+biankuang+" "+biankuangstyle+" "+biankuangcol +";\r\n" +
                " } \r\n" +
                "";
        head=head+".biz_table td{ font-size:"+zitidaxiao+"px; color:"+ziticol+"; font-family:"+ziti+" ; text-align:left;\r\n" +
                "}\r\n";
        head=head+".biz_table input{ font-size:"+inputsize+"px;  size:"+inputzisize+"px;\r\n" +
                "\r\n" +
                "}\r\n";
        head=head+"biz_table img{ border:"+imgbiankuang+";\r\n" +
                "}\r\n";
        head=head+"-->\r\n" +
                "</style>";



        String content = "[TAG][HTMLCODE][MARKTYPE]" + type +"[/MARKTYPE][STYLES]"+head+"[/STYLES][GAOJI]"+gaoji+"[/GAOJI][CONTENT]<table "+style+"   class=\"biz_table\">" +
                "<form name=\"Regform\" id=\"form\" method=\"POST\" >\r\n" +
                "    <input type=\"hidden\" name=\"startflag\" value=\"1\">\r\n" +
                "    <input type=\"hidden\" name=\"doCreate\" value=\"1\">\r\n" +
                "    <table width=\"100%\" border=\"0\" "+style+"   class=\"biz_table\" >\r\n" +
                "        <tr>\r\n" +
                "            <td >��&nbsp;��&nbsp;��:</td>\r\n" +
                "            <td >&nbsp;&nbsp;\r\n" +
                "                <input id=\"username\" name=\"username\" type=\"text\" value=\"�������û���\" onFocus=\"if (value =='�������û���'){value =''}\" onBlur=\"check_register_user()\"/></td>\r\n" +
                "            <td ><div id=\"u_mag\"></div></td>\r\n" +
                "        </tr>\r\n" +
                "        <tr>\r\n" +
                "            <td >��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>\r\n" +
                "            <td >&nbsp;&nbsp;\r\n" +
                "                <input id=\"email\" name=\"email\" type=\"text\" onBlur=\"check_email()\"/></td>\r\n" +
                "            <td ><div id=\"e_mag\"></div></td>\r\n" +
                "        </tr>\r\n" +
                "        <tr>\r\n" +
                "            <td>��&nbsp;&nbsp;&nbsp;&nbsp;��:</td>\r\n" +
                "            <td>&nbsp;&nbsp;\r\n" +
                "                <input name=\"passWord1\" id=\"passWord1\" type=\"password\" onBlur=\"javascript:checkPassword1()\"/></td>\r\n" +
                "            <td><div id=\"p_mag1\"></div></td>\r\n" +
                "        </tr>\r\n" +
                "        <tr>\r\n" +
                "            <td>ȷ������:</td>\r\n" +
                "            <td>&nbsp;&nbsp;\r\n" +
                "                <input name=\"passWord2\" id=\"passWord2\" type=\"password\" onBlur=\"javascript:checkPassword2()\"/></td>\r\n" +
                "            <td><div id=\"p_mag2\"></div></td>\r\n" +
                "        </tr>\r\n" +
                "<tr><td>��ʵ����</td><td>&nbsp;&nbsp;<input type='text' name=realname></td></tr>"+
                "<tr><td>��ַ</td><td>&nbsp;&nbsp;<input type='text' name=address></td></tr>"+
                "<tr><td>��������</td><td>&nbsp;&nbsp;<input type='text' name=zip></td></tr>"+
                "<tr><td>�̶��绰</td><td>&nbsp;&nbsp;<input type='text' name=phone></td></tr>"+
                "<tr><td>�ƶ��绰</td><td>&nbsp;&nbsp;<input type='text' name=mphone></td></tr>"+
                "        <tr>\r\n" +
                "            <td>��&nbsp;֤&nbsp;��:</td>\r\n" +
                "            <td>&nbsp;&nbsp;\r\n" +
                "                <input id=\"txtVerify\" name=\"txtVerify\" type=\"text\" />&nbsp;<img  id=\"safecode\" name=\"cod\" src=\"/_commons/drawImage.jsp\" border=1>&nbsp;&nbsp;<a href=\"#\" onclick=\"javascript:shuaxin()\">�������?����һ��</a></td>\r\n" +
                "            <td><div id=\"v_mag\"></div></td>\r\n" +
                "        </tr>\r\n" +
                "        <tr>\r\n" +
                "            <td><input type=\"button\" value=\"ע��\"  onclick=\"javascript:check_register()\"/></td>\r\n" +
                "            <td></td>\r\n" +
                "            <td></td>\r\n" +
                "        </tr>\r\n" +
                "    </table>\r\n" +
                "</form>" +
                "[/CONTENT][/HTMLCODE][/TAG]";
        //�߼��Զ����
        if(gjcontent!=null&&gaoji!=-1)
        {
            content = "[TAG][HTMLCODE][MARKTYPE]" + type +"[/MARKTYPE][STYLES]"+head+"[/STYLES][GAOJI]"+gaoji+"[/GAOJI][CONTENT]<table "+style+"   class=\"biz_table\">" +
                    gjcontent+
                    "[/CONTENT][/HTMLCODE][/TAG]";
        }
        boolean saveas = ParamUtil.getBooleanParameter(request, "saveas");
        String relatedCID = "(0)";

        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(content);
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(innerFlag);
        mark.setFormatFileNum(listType);
        mark.setRelatedColumnID(relatedCID);
        mark.setMarkType(18);
        int orgmarkID = markID;
        if (orgmarkID > 0 )
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        String markname = "��������";

        if (viewer.toLowerCase().indexOf("gecko") == -1)
            out.println("<script>window.returnValue=\"[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]\";top.close();</script>");
        else {
            if (orgmarkID > 0 && !saveas) {
                out.println("<script>top.close();</script>");
            } else {
                String returnvalue = "[TAG][MARKID]" + markID + "_" + columnID + "[/MARKID][/TAG]";
                out.println("<script>var returnvalue = \"<INPUT name='" + returnvalue + "' type=button value='[" + markname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>\";" +
                        "window.parent.opener.InsertHTML('content',returnvalue);top.close();</script>");
            }
        }
        return;
    }
    System.out.println("gaoji="+gaoji);
%>

<html>
<head>
<base target="_self" >
<title>�����û����۱�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../style/global.css">
<meta http-equiv="Pragma" content="no-cache">
<script type="text/javascript">
    function cal() {
        var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
        if (isMSIE) {
            window.returnValue = "";
            top.close();
        } else {
            top.close();
        }
    }

    function doit()
    {
        var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
        if (isMSIE) {
            markform.action = "addUserRegister.jsp";
            markform.method = "post";
            markform.target = "_self"
            markform.submit();
        }
    }
</script>


<script>
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

function openlogin()
{
<%if(gaoji==-1){%>
    showModalDialog("gaojilogin.jsp?id=1",window,"font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
<%}else{%>
    showModalDialog("gaojilogin.jsp?id=1&markid=<%=markID%>",window,"font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
<%}%>
}

</script>
</head>

<body bgcolor="#CCCCCC">
<table width="100%" border="0" align="center">
    <form name="markform">
        <input type=hidden name=doCreate value=true>
        <input type=hidden name=saveas value=false>
        <input type=hidden name=column value="<%=columnID%>">

        <input type=hidden name=type value=18>
        <input type="hidden" name="mark" value="<%=markID%>">
        <input type="hidden" name="gaoji" value="<%=gaoji%>">
        <input type="hidden" name="gjcontent" id="gjcontent">
        <tr height="30">
            <td>��ѡ���񱳾�ɫ��</td>
        </tr>
        <tr height=24>
            <td>���ֵ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="text" size="8" name="tianchong" <%if(viewtable1!=null){%>value=<%=viewtable1%><%}%>>
                px
                &nbsp;&nbsp;���ֵ&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                <input type="text" size="8" name="jianju" <%if(viewtable2!=null){%>value=<%=viewtable2%><%}%>>
                px
                &nbsp; �߿�ֵ&nbsp;
                <input type="text" size="8" name="biankuang" <%if(viewtable3!=null){%>value=<%=viewtable3%><%}%>>
                px
                &nbsp;&nbsp;�߿���ʽ
                <label>
                    <select name="biankuangstyle">
                        <option value="dashed" <%if(viewtable4!=null){ if(viewtable4.equals("dashed")){%>selected<%}}%> >����</option>
                        <option value="dotted" <%if(viewtable4!=null){if(viewtable4.equals("dotted")){%>selected<%}}%>> �㻮��</option>
                        <option value="solid" <%if(viewtable4!=null){if(viewtable4.equals("solid")){%>selected<%}}%>> ʵ��</option>
                        <option value="double" <%if(viewtable4!=null){if(viewtable4.equals("double")){%>selected<%}}%>> ˫��</option>
                    </select>
                </label>�߿���ɫ<div id="colorpanel" style="position:absolute;display:none;width:253px;height:177px;"></div><input type="text" size="8" alt="color2" name="biankuangcol" <%if(viewtable5!=null){ if(!viewtable5.equals("null")){%>value="<%=viewtable5%>"<%}}%>  onclick="OnDocumentClick();"><script language="javascript">
                intocolor();
            </script> </td>
        </tr>
        <tr height=24>
            <td>����&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="text" size="8" name="ziti" <%if(viewtd3!=null){%>value=<%=viewtd3%><%}%>>
                px              &nbsp;&nbsp;�����Сpx&nbsp;&nbsp;
                <input type="text" size="8" name="zitidaxiao" <%if(viewtd1!=null){%>value=<%=viewtd1%><%}%>>
                px
                ������ɫ&nbsp;
                <div id="colorpanel" style="position:absolute;display:none;width:253px;height:177px;"></div><input type="text" size="8" alt="color1" name="ziticol" <%if(viewtd2!=null){%>value="<%=viewtd2%>"<%}%>  onclick="OnDocumentClick();"><script language="javascript">
                intocolor();
            </script></td>
        </tr>
        <tr><td>�ı����С&nbsp;&nbsp;
            <input type="text" size="8" name="inputsize" <%if(viewput2!=null){%>value=<%=viewput2%><%}%>>
            px �ı������ִ�С
            <input type="text" size="8" name="inputzisize" <%if(viewput1!=null){%>value=<%=viewput1%><%}%>>
            px </td>
        </tr>
        <tr><td>ͼƬ�߿�&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="8" name="imgbiankuang" <%if(viewimg1!=null){%>value=<%=viewimg1%><%}%>></td></tr>
        <tr height=24>
            <td>����������ƣ�<input name=chineseName size=20 value="<%=cname%>" class=tine></td>
        </tr>
        <tr height=80>
            <td>���������<br><textarea rows="3" id="notes" cols="38" class=tine><%=notes%>
            </textarea>&nbsp;&nbsp;<a href="javascript:openlogin()">�߼�ѡ��</a></td>
        </tr>
        <tr height="50">
            <td align=center>
                <input type="button" value=" ȷ�� " onClick = "doit();" class=tine>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value=" ȡ�� " onClick = "javascript:cal();" class=tine>
            </td>
        </tr>
    </form>
</table>

</body>
</html>