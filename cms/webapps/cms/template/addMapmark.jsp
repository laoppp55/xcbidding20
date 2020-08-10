<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.util.*,
                com.bizwink.cms.xml.*,
                com.bizwink.cms.markManager.*,
                com.bizwink.cms.viewFileManager.*"
        contentType="text/html;charset=gbk"
        %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    //     �޸ı༭����ȡֵ
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    IMarkManager markMgr = markPeer.getInstance();
    int siteID = authToken.getSiteID();
    String sitename = authToken.getSitename();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    mark vmark = null;

    int width = 1200;
    int height = 800;
    double lat = 39.999373437683296d;
    double lng = 116.40782803259279d;
    int scale = 12;
    if (markID > 0) {
        vmark = markMgr.getAMark(markID);
        String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(markID));
        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        str = StringUtil.replace(str, "{^", "[");
        str = StringUtil.replace(str, "^}", "]");

        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
        String width_s = properties.getProperty(properties.getName().concat(".WIDTH"));
        String height_s = properties.getProperty(properties.getName().concat(".HEIGHT"));
        String lat_s = properties.getProperty(properties.getName().concat(".CLAT"));
        String lng_s = properties.getProperty(properties.getName().concat(".CLNG"));
        String scale_s = properties.getProperty(properties.getName().concat(".SCALE"));

        if (width_s != null && width_s != "" && !width_s.equals("null")) width = Integer.parseInt(width_s);
        if (height_s != null && height_s != "" && !height_s.equals("null")) height = Integer.parseInt(height_s);
        if (lat_s!=null && lat_s!="" && !lat_s.equals("null")) lat = Double.parseDouble(lat_s);
        if (lng_s!=null && lng_s!="" && !lng_s.equals("null")) lng = Double.parseDouble(lng_s);
        if (scale_s!=null && scale_s!="" && !scale_s.equals("null")) scale = Integer.parseInt(scale_s);
    }

    int listType = 0;
    int innerFlag = 0;
    String notes = "";
    String cname = "��ͼ��ע";

    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");
    if (doCreate) {
        int type = ParamUtil.getIntParameter(request, "type", 0);
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        listType = ParamUtil.getIntParameter(request, "listType", 0);

        String mapwidth=ParamUtil.getParameter(request,"mapwidth");
        String mapheight=ParamUtil.getParameter(request,"mapheight");
        String maplat=ParamUtil.getParameter(request,"maplat");
        String maplng =ParamUtil.getParameter(request,"maplng");
        String mapscale =ParamUtil.getParameter(request,"mapscale");

        String content ="[TAG][HTMLCODE][MARKTYPE]" + type +"[/MARKTYPE][SITEID]"+siteID+"[/SITEID][SITENAME]" + sitename + "[/SITENAME]"+
                "[CHINESENAME]"+cname+"[/CHINESENAME][NOTES]"+notes+"[/NOTES]" +
                "[INNERFLAG]" + innerFlag + "[/INNERFLAG]"+
                "[WIDTH]" + mapwidth + "[/WIDTH]"+
                "[HEIGHT]" + mapheight + "[/HEIGHT]"+
                "[CLAT]" + maplat + "[/CLAT]"+
                "[CLNG]" + maplng + "[/CLNG]"+
                "[SCALE]" + mapscale + "[/SCALE]"+
                "[/HTMLCODE]"+ "[/TAG]";

        boolean saveas = ParamUtil.getBooleanParameter(request, "saveas");
        String relatedCID = "(0)";
        mark mark = new mark();
        mark.setID(markID);
        mark.setColumnID(columnID);
        mark.setSiteID(siteID);
        mark.setContent(content.toString());
        mark.setChinesename(cname);
        mark.setNotes(notes);
        mark.setInnerHTMLFlag(innerFlag);
        mark.setFormatFileNum(listType);
        mark.setRelatedColumnID(relatedCID);
        mark.setMarkType(24);   //24Ϊ��ͼ��עtype
        int orgmarkID = markID;
        if (orgmarkID > 0 )
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        String markname = "��ͼ��ע";

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
%>

<html>
<head>
    <base target="_self" >
    <title>�����ͼ��ע��</title>
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
                markform.action = "addMapmark.jsp";
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


        function doclose(){
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

        function openmap() {
            //alert("hello word!!!");
            latval = document.markform.maplat.value;
            lngval = document.markform.maplng.value;
            window.open("selectpoint.jsp?lat=" + latval + "&lng=" + lngval, "", "width=820,height=680,left=100,top=50,status,scrollbars");
        }
    </script>
</head>

<body bgcolor="#CCCCCC">
<table width="100%" border="0" align="center">
    <form name="markform">
        <input type=hidden name=doCreate value=true>
        <input type=hidden name=saveas value=false>
        <input type=hidden name=column value="<%=columnID%>">
        <input type="hidden" name="mark" value="<%=markID%>">
        <input type=hidden name=type value=24>
        <tr>
            <td height="30">�༭��ͼ��ע����</td>
        </tr>
        <tr>
            <td>���&nbsp;&nbsp;<input type="text" name="mapwidth" class="tine" size="8" value="<%=(width==0)?"":width%>">&nbsp;&nbsp;px
                &nbsp;&nbsp;&nbsp;
                �߶�&nbsp;&nbsp;<input type="text" name="mapheight" class="tine" size="8"  value="<%=(height==0)?"":height%>">&nbsp;&nbsp;px</td>
        </tr>
        <tr>
            <td height="30">��ͼ���ľ�γ��</td>
        </tr>
        <tr>
            <td>γ��&nbsp;&nbsp;<input type="text" name="maplat" class="tine" size="30" value="<%=(lat==0d)?"":lat%>">�磺39.91700
                &nbsp;&nbsp;&nbsp;
                ����&nbsp;&nbsp;<input type="text" name="maplng" class="tine" size="30" value="<%=(lng==0d)?"":lng%>">�磺116.39700
               &nbsp;&nbsp;<input type="button" name="point" value="ѡ�����ľ�γ��" onclick="javascript:openmap();">
            </td>
        </tr>
        <tr>
            <td height="30">��ͼ���ű���</td>
        </tr>
        <tr>
            <td>γ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="mapscale" class="tine" size="8" value="<%=(scale==0)?"":scale%>">
            </td>
        </tr>
        <tr>
            <td height="30">����������ƣ�<input name=chineseName size=20 value="<%=cname%>" class=tine></td>
        </tr>
        <tr>
            <td height="80">���������<br><textarea rows="3" id="notes" cols="38" class=tine name="notes" ><%=notes%>
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