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
    int yangshi =0;
    int gaoji=-1;
    System.out.println("markID="+markID+"  yangshi="+yangshi);
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

    String viewimg1="";
    String s_loginimg = "";
    String s_regimg = "";
    String s_mimaimg = "";
    String loginimg = "/images/login_go.gif";
    String regimg = "ע�����û�";
    String mimaimg = "��������";
    String gjform="";
    if(markID>0)
    {

        vmark=markMgr.getAMark(markID);
        String stylecontent=vmark.getContent();
        String ysstr="";
        String gjstr="";
         String content = vmark.getContent();
        if(stylecontent.indexOf("[YANGSHI]")!=-1)
        {
            ysstr=stylecontent.substring(stylecontent.indexOf("[YANGSHI]")+"[YANGSHI]".length(),stylecontent.indexOf("[/YANGSHI]"));
           try{
            yangshi=Integer.parseInt(ysstr);
           }catch(Exception e){
               yangshi=0;
           }
           
        }
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
               gjform=gjform.substring(gjform.indexOf("<div id=\"biz_user_login_form\">")+"<div id=\"biz_user_login_form\">".length(),gjform.indexOf("<script language=javascript>checklogin();</script>"));

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
                        
                if(viewput1.lastIndexOf(" size:")!=-1)
                {
                    viewput2=viewput1.substring(viewput1.lastIndexOf("size:")+"size:".length(),viewput1.lastIndexOf("px;"));
                    if(viewput1.indexOf("font-size:")!=-1)
                    {
                        viewput1=viewput1.substring(viewput1.indexOf("font-size:")+10,viewput1.lastIndexOf("px;  size:"));

                    }
                }else{
                    if(viewput1.lastIndexOf("size:")!=-1)
                    {
                        viewput2=viewput1.substring(viewput1.lastIndexOf("size:")+"size:".length(),viewput1.lastIndexOf("px;"));

                    }
                    if(viewput1.indexOf("font-size:")!=-1)
                    {
                        viewput1=viewput1.substring(viewput1.indexOf("font-size:")+10,viewput1.lastIndexOf("px;  width:"));
                                
                    }
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
        int sposi = -1;
        int eposi = -1;
        //��ȡloginͼ��
        sposi = content.indexOf("[LOGINIMG]");
        eposi = content.indexOf("[/LOGINIMG]");
        if (sposi != -1 && eposi != -1) {
            s_loginimg = content.substring(sposi + "[LOGINIMG]".length(),eposi);
            loginimg = s_loginimg;
        }
        //��ȡ�û�ע��ͼ��
        sposi = content.indexOf("[REGIMG]");
        eposi = content.indexOf("[/REGIMG]");
        if (sposi != -1 && eposi != -1) {
            s_regimg = content.substring(sposi + "[REGIMG]".length(),eposi);
            regimg = s_regimg;
        }
        //��ȡ��������ͼ��
        sposi = content.indexOf("[MIMAIMG]");
        eposi = content.indexOf("[/MIMAIMG]");
        if (sposi != -1 && eposi != -1) {
            s_mimaimg = content.substring(sposi + "[MIMAIMG]".length(),eposi);
            mimaimg = s_mimaimg;
        }
    }

    int siteID = authToken.getSiteID();
    String sitename = authToken.getSitename();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    String gjcontent=ParamUtil.getParameter(request,"gjcontent");
    int listType = 0;
    int innerFlag = 0;
    String notes = "";
    String cname = "�û���¼��";
    int type = ParamUtil.getIntParameter(request, "type", 0);
    boolean doCreate = ParamUtil.getBooleanParameter(request, "doCreate");


    if (doCreate) {
        yangshi=ParamUtil.getIntParameter(request,"yangshi",0);
        gaoji=ParamUtil.getIntParameter(request,"gaoji",-1);
        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        listType = ParamUtil.getIntParameter(request, "listType", 0);

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
         s_loginimg = ParamUtil.getParameter(request,"login_img");
        s_regimg = ParamUtil.getParameter(request,"reg_img");
        s_mimaimg = ParamUtil.getParameter(request,"mima_img");
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
         if (loginimg == null || loginimg == "")
            loginimg="/images/login_go.gif";
        else
            loginimg="/_sys_images/" + s_loginimg;
        if (regimg == null || regimg == "")
            regimg="ע�����û�";
        else
            regimg="<img src=\"/_sys_images/" + s_regimg + "\" border=\"0\" />";
        if (mimaimg == null || mimaimg == "")
            mimaimg="��������";
        else
            mimaimg="<img src=\"/_sys_images/" + s_mimaimg + "\" border=\"0\" />";

        String head="<style type=\"text/css\">\n" +
                "<!--";
        head=head+".biz_table{ border:"+biankuang+" "+biankuangstyle+" "+biankuangcol +";\n" +
                " } \n" +
                "";
        head=head+".biz_table td{ font-size:"+zitidaxiao+"px; color:"+ziticol+"; font-family:"+ziti+" ; text-align:left;\n" +
                "}\n";
        head=head+".biz_table input{ font-size:"+inputsize+"px;  width:"+inputzisize+"px;\n" +
                "\n" +
                "}\n";
        head=head+"biz_table img{ border:"+imgbiankuang+";\n" +
                "}\n";
        head=head+"-->\n" +
                "</style>";

        String content = "[TAG][HTMLCODE][MARKTYPE]" + type +"[/MARKTYPE][LOGINIMG]" + s_loginimg + "[/LOGINIMG][REGIMG]" + s_regimg + "[/REGIMG][MIMAIMG]" + s_mimaimg + "[/MIMAIMG][YANGSHI]"+yangshi+"[/YANGSHI][STYLES]"+head+"[/STYLES][GAOJI]"+gaoji+"[/GAOJI][CONTENT]" +head+
                "<script type=\"text/javascript\" src=\"/_sys_js/check.js\"></script>\r\n" +
                "<div id=\"biz_user_login\" style=\"display:none\"></div>\r\n" +
                "<div id=\"biz_user_login_form\">\r\n" +
                "<table  "+style+"   class=\"biz_table\" border='0'>\r\n" +
                "<form name=\"loginForm\" method=\"post\" action=\"/" + sitename +"/_prog/login.jsp\" onsubmit=\"return check();\">\r\n" +
                "<input type=\"hidden\" name=\"doLogin\" value=\"true\">\r\n" +
                "<TR><TD>�û�����</TD>\r\n" +
                "<TD><INPUT name=username> </TD></TR>\r\n" +
                "<TR><TD>��&nbsp;&nbsp;�룺</TD>\r\n" +
                "<TD><INPUT type=\"password\" name=\"password\"></TD></TR>\r\n"+
                "<TR><TD>&nbsp;</TD><TD align=\"right\">\r\n" +
                "<DIV align=\"center\" class=\"biz_table\"><input  style=\"width:auto\"  type=\"image\" src=\"" + loginimg +"\" value=\"�ύ\" /></DIV></TD></TR></form></TABLE>\r\n"+
                "<script language=javascript>checklogin();</script>\r\n" +
                "<TABLE cellSpacing=\"0\" cellPadding=\"5\" width=\"80%\"  border=\"0\" class=\"biz_table\">\r\n"+
                "<TR><TD><A href=\"/" + sitename + "/_prog/register.jsp\" target=\"_blank\">\r\n" +
                ""+ regimg +"</A></TD>\r\n" +
                "<TD><A href=#>"+ mimaimg +"</a></TD></TR></TBODY></TABLE></div>\r\n"+
                "[/CONTENT][/HTMLCODE][/TAG]";
        //-----������ʾ��ʽ
        if(yangshi==0){
             content= "[TAG][HTMLCODE][MARKTYPE]" + type +"[/MARKTYPE][LOGINIMG]" + s_loginimg + "[/LOGINIMG][REGIMG]" + s_regimg + "[/REGIMG][MIMAIMG]" + s_mimaimg + "[/MIMAIMG][YANGSHI]"+yangshi+"[/YANGSHI][STYLES]"+head+"[/STYLES][GAOJI]"+gaoji+"[/GAOJI][CONTENT]" + head+
                "<script type=\"text/javascript\" src=\"/_sys_js/check.js\"></script>\r\n" +
                "<div id=\"biz_user_login\" style=\"display:none\"></div>\r\n" +
                "<div id=\"biz_user_login_form\">\r\n" +
                "<table  "+style+"   class=\"biz_table\" border='0'>\r\n" +
                "<form name=\"loginForm\" method=\"post\" action=\"/" + sitename +"/_prog/login.jsp\" onsubmit=\"return check();\">\r\n" +
                "<input type=\"hidden\" name=\"doLogin\" value=\"true\">\r\n" +
                "<TR><TD>�û�����</TD>\r\n" +
                "<TD><INPUT name=username> </TD>\r\n" +
                "<TD>��&nbsp;&nbsp;�룺</TD>\r\n" +
                "<TD><INPUT type=\"password\" name=\"password\"></TD>\r\n"+
                "<TD>&nbsp;</TD><TD align=\"right\">\r\n" +
                "<DIV align=\"center\" class=\"biz_table\"><input  style=\"width:auto\" type=\"image\" src=\"" + loginimg +"\" value=\"�ύ\" /></DIV></TD></TR></form></TABLE>\r\n"+
                "<script language=javascript>checklogin();</script>\r\n" +

                "</div>\r\n"+
                "[/CONTENT][/HTMLCODE][/TAG]";

        }
        //�Զ����

        System.out.println("gjcontent="+gjcontent);
        if(gjcontent!=null&&gaoji!=-1)
        {
            content="[TAG][HTMLCODE][MARKTYPE]" + type +"[/MARKTYPE][LOGINIMG]" + s_loginimg + "[/LOGINIMG][REGIMG]" + s_regimg + "[/REGIMG][MIMAIMG]" + s_mimaimg + "[/MIMAIMG][YANGSHI]"+yangshi+"[/YANGSHI][STYLES]"+head+"[/STYLES][GAOJI]"+gaoji+"[/GAOJI][CONTENT]" + head+
                "<script type=\"text/javascript\" src=\"/_sys_js/check.js\"></script>\r\n" +
                "<div id=\"biz_user_login\" style=\"display:none\"></div>\r\n" +
                "<div id=\"biz_user_login_form\">\r\n" +gjcontent+
                "<script language=javascript>checklogin();</script>\r\n" +

                "</div>\r\n"+
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
        mark.setMarkType(19);
        int orgmarkID = markID;
        if (orgmarkID > 0 && !saveas)
            markMgr.Update(mark);
        else
            markID = markMgr.Create(mark);

        String viewer = request.getHeader("user-agent");
        String markname = "�û���¼��";

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
    <script language="javascript" src="../js/color.js"></script>
    <meta http-equiv="Pragma" content="no-cache">
    <script type="text/javascript">
        function cal() {
           // alert(document.getElementById("gjcontent").value);
           // return;
          
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                window.returnValue = "";
                top.close();
            } else {
                top.close();
            }
        }
        function selpic(type)
        {
            winStr = "selectIcon.jsp";
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:70em; dialogHeight:40em; status:no");

            var loginimg = document.getElementById("loginimg");
            var regimg = document.getElementById("regimg");
            var mimaimg = document.getElementById("mimaimg");
            if (type == 1) {
                markform.login_img.value=returnvalue;
                if (returnvalue != null && returnvalue != "") {
                    loginimg.style.display = "";
                    document.getElementById("loginsrc_img").src="/_sys_images/" + returnvalue;
                }
            }
            else if (type == 2) {
                markform.reg_img.value = returnvalue;
                if (returnvalue != null && returnvalue != "") {
                    regimg.style.display = "";
                    document.getElementById("regsrc_img").src="/_sys_images/" + returnvalue;
                }
            }
            else {
                markform.mima_img.value = returnvalue;
                if (returnvalue != null && returnvalue != "") {
                    mimaimg.style.display = "";
                    document.getElementById("mimasrc_img").src="http://www.coosite.com/webbuilder/sites/images/" + returnvalue;
                }
            }
        }
        function doit()
        {
            var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
            if (isMSIE) {
                markform.action = "addUserLoginForm.jsp";
                markform.method = "post";
                markform.target = "_self"
                markform.submit();
            }
        }
        function openlogin()
        {
            <%if(markID==-1){%>
            showModalDialog("gaojilogin.jsp?id=0",window,"font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
            <%}else{%>
        showModalDialog("gaojilogin.jsp?id=0&markid=<%=markID%>",window,"font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
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
        <input type=hidden name=type value=23>
        <input type="hidden" name="mark" value="<%=markID%>">
        <input type="hidden" name="gaoji" value="<%=gaoji%>">
        <input type="hidden" name="gjcontent" id="gjcontent">
        <tr height="30">
            <td>��ѡ���񱳾�ɫ��</td>
        </tr>
        <tr height=24>
            <td>������ֵ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="text" size="8" name="tianchong" <%if(viewtable1!=null){%>value=<%=viewtable1%><%}%>>
                px
                &nbsp;&nbsp;�����ֵ&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                <input type="text" size="8" name="jianju" <%if(viewtable2!=null){%>value=<%=viewtable2%><%}%>>
                px
                &nbsp; ���߿�ֵ&nbsp;
                <input type="text" size="8" name="biankuang" <%if(viewtable3!=null){%>value=<%=viewtable3%><%}%>>
                px
                &nbsp;&nbsp;���߿���ʽ
                <label>
                    <select name="biankuangstyle">
                        <option value="dashed" <%if(viewtable4!=null){ if(viewtable4.equals("dashed")){%>selected<%}}%> >����</option>
                        <option value="dotted" <%if(viewtable4!=null){if(viewtable4.equals("dotted")){%>selected<%}}%>> �㻮��</option>
                        <option value="solid" <%if(viewtable4!=null){if(viewtable4.equals("solid")){%>selected<%}}%>> ʵ��</option>
                        <option value="double" <%if(viewtable4!=null){if(viewtable4.equals("double")){%>selected<%}}%>> ˫��</option>
                    </select>
                </label>���߿���ɫ<div id="colorpanel" style="position:absolute;display:none;width:253px;height:177px;"></div><input type="text" size="8" alt="color2" name="biankuangcol" <%if(viewtable5!=null){ if(!viewtable5.equals("null")){%>value="<%=viewtable5%>"<%}}%>  onclick="OnDocumentClick();"><script language="javascript">
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
        <tr><td>�ı������ִ�С&nbsp;&nbsp;
            <input type="text" size="8" name="inputsize" <%if(viewput1!=null){%>value=<%=viewput1%><%}%>>
            px �ı��򳤶�
            <input type="text" size="8" name="inputzisize" <%if(viewput2!=null){%>value=<%=viewput2%><%}%>>
            px </td>
        </tr>
        <tr><td >ͼƬ�߿�&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="8" name="imgbiankuang" <%if(viewimg1!=null){%>value=<%=viewimg1%><%}%>></td></tr>
       <tr>
            <td align="left">��¼ͼƬ(<a href="javascript:selpic(1)">ѡ��</a>)
            <input type="text" size="8" name="login_img" value="<%=(loginimg.equals("/images/login_go.gif")?"":s_loginimg)%>" readonly><div id="loginimg" style="position:absolute;display:<%=(loginimg.equals("/images/login_go.gif")?"none":"")%>"><img id="loginsrc_img" src="<%=(loginimg.equals("/images/login_go.gif")?"":"/_sys_images/" + s_loginimg)%>" /></div>
            ע��ͼƬ(<a href="javascript:selpic(2)">ѡ��</a>)
            <input type="text" size="8" name="reg_img" value="<%=(regimg.equals("ע�����û�")?"":s_regimg)%>" readonly><div id="regimg" style="position:absolute;display:<%=(regimg.equals("ע�����û�")?"none":"\"\"")%>"><img id="regsrc_img" src="<%=(regimg.equals("ע�����û�")?"":"/_sys_images/" + s_regimg)%>" /></div>
            ��������ͼƬ(<a href="javascript:selpic(3)">ѡ��</a>)
            <input type="text" size="8" name="mima_img" value="<%=(mimaimg.equals("��������")?"":s_mimaimg)%>" readonly><div id="mimaimg" style="position:absolute;display:<%=(mimaimg.equals("��������")?"none":"\"\"")%>"><img id="mimasrc_img" src="<%=(mimaimg.equals("��������")?"":"/_sys_images/" + s_mimaimg)%>" /></div></td>
        </tr>
        <tr height=24>
            <td>����������ƣ�<input name=chineseName size=20 value="<%=cname%>" class=tine></td>
        </tr>
        <tr><td ><input type="radio" <%if(yangshi==0){%> checked="checked" <%}%> value="0" name="yangshi">��½������ʾ&nbsp;&nbsp;<input type="radio" <%if(yangshi==1){%> checked="checked" <%}%> name="yangshi" value="1">��½������ʾ </td><td></td></tr>
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