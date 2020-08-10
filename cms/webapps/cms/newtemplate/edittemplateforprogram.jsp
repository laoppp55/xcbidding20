<%@ page import="java.sql.*,
                 java.util.*,
                 java.io.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.modelManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.register.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.xml.TreatmentXML" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.bizwink.cms.server.CmsServer" %>

<%@ taglib uri="/FCKeditor" prefix="FCK" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    boolean errors        = false;
    boolean success       = false;
    String sitename       = authToken.getSitename();
    int samsiteid         = authToken.getSamSiteid();
    boolean doUpdate     = ParamUtil.getBooleanParameter(request, "doUpdate");
    int shareType         = ParamUtil.getIntParameter(request, "shareType", 1);
    int     ID            = ParamUtil.getIntParameter(request, "template", 0);
    int     rightid       = ParamUtil.getIntParameter(request, "rightid", 0);
    int     modelType     = ParamUtil.getIntParameter(request,"modelType",0);
    int     columnID      = ParamUtil.getIntParameter(request, "column", 0);
    String  content       = ParamUtil.getParameter(request, "content");
    String  cname         = ParamUtil.getParameter(request, "cname");
    String  modelname     = ParamUtil.getParameter(request, "modelname");
    String  modelnameBak  = ParamUtil.getParameter(request, "modelnameBak");
    String  username      = authToken.getUserID();
    int siteid            = authToken.getSiteID();
    String baseDir = application.getRealPath("/");
    int tempnum=ParamUtil.getIntParameter(request,"tempnum",0);
    IRegisterManager regMgr = RegisterPeer.getInstance();
    IModelManager modelManager = ModelPeer.getInstance();
    Model model = modelManager.getModel(ID, username);

    if (!doUpdate)
    {
        modelType = model.getIsArticle();
        content = model.getContent();
        int posi = -1;
        while ((posi=content.toLowerCase().indexOf("<textarea")) > -1)
            content = content.substring(0,posi) + "<cmstextarea" + content.substring(posi+9);
        while ((posi=content.toLowerCase().indexOf("</textarea>")) > -1)
            content = content.substring(0,posi) + "</cmstextarea>" + content.substring(posi+11);
        content = StringUtil.gb2iso4View(content);
        cname = model.getChineseName();
        cname = StringUtil.gb2iso4View(cname);
        modelname = model.getTemplateName();
    }

    String columnName = "����ģ�����";

    if (doUpdate)
    {
        try
        {
            if (modelname == null || modelname.length() < 1)
            {
                out.println("ģ���ļ�������Ϊ�գ���<a href=javascript:history.go(-1);>����</a>");
                return;
            } else {
                if (modelManager.hasSameModelNameForProgram(siteid,columnID,ID,modelname))
                {
                    out.println("ģ���ļ����Ʋ����ظ�����<a href=javascript:history.go(-1);>����</a>");
                    return;
                }
            }

            int posi = -1;
            while ((posi=content.toLowerCase().indexOf("<cmstextarea")) > -1)
                content = content.substring(0,posi) + "<textarea" + content.substring(posi+12);
            while ((posi=content.toLowerCase().indexOf("</cmstextarea>")) > -1)
                content = content.substring(0,posi) + "</textarea>" + content.substring(posi+14);

            model.setID(ID);
            model.setIsArticle(modelType);
            model.setContent(content);
            model.setEditor(username);
            model.setLastupdated(new Timestamp(System.currentTimeMillis()));
            model.setLockstatus(0);
            model.setChineseName(cname);
            model.setTemplateName(modelname);
            model.setTempnum(tempnum);
            modelManager.Update(model,siteid,samsiteid);
            //�б�����xml�ļ�
            if(content.indexOf("</form>")!=-1)
            {
                //����xml�ļ����
                List startformlist=new ArrayList();
                List endformlist =new ArrayList();
                Pattern p = Pattern.compile("<\\s*form[^<>]*>", Pattern.CASE_INSENSITIVE);
                Matcher m = p.matcher(content);
                String srcstr = "";
                String newstrsrc = "";
                while (m.find()) {
                    String s = m.group();
                    //  System.out.println("s="+s);
                    int start = m.start();
                    int end = m.end();
                    srcstr = content.substring(start, end);
                    // System.out.println("old="+srcstr+"   start="+start);
                    Integer startformtint=new Integer(start);
                    startformlist.add(startformtint);
                    /* Pattern p1=Pattern.compile("<\\s*input[^<>]*>");
              Matcher m1=p1.matcher(srcstr);
                  while(m1.find())
                  {
                      int start1 = m1.start();
                      int end1 = m1.end();
                      newstrsrc=srcstr.substring(start1,end1);
                      System.out.println("new strsrc="+newstrsrc);
                  }
                  System.out.println("old="+srcstr);

                  System.out.println("===========================");  */

                }
                p = Pattern.compile("</form>", Pattern.CASE_INSENSITIVE);
                m = p.matcher(content);

                while (m.find()) {


                    int start = m.start();
                    int end = m.end();
                    srcstr = content.substring(start, end);
                    //  System.out.println("old="+srcstr+"   end="+end);
                    Integer startformtint=new Integer(end);
                    endformlist.add(startformtint);
                    /* Pattern p1=Pattern.compile("<\\s*input[^<>]*>");
              Matcher m1=p1.matcher(srcstr);
                  while(m1.find())
                  {
                      int start1 = m1.start();
                      int end1 = m1.end();
                      newstrsrc=srcstr.substring(start1,end1);
                      System.out.println("new strsrc="+newstrsrc);
                  }
                  System.out.println("old="+srcstr);

                  System.out.println("===========================");  */

                }

                if(startformlist.size()==endformlist.size())
                {
                    String forms[]=new String[startformlist.size()];
                    for(int i=0;i<forms.length;i++)
                    {
                        if((Integer)startformlist.get(i)<(Integer)endformlist.get(i)){
                            forms[i]=content.substring((Integer)startformlist.get(i),(Integer)endformlist.get(i));
                            //System.out.println("forms[i]="+forms[i]);
                        }
                    }
                    TreatmentXML txml=new TreatmentXML();

                    //�Ȳ�����û��xml�ļ� �������xml�ļ����޸�xml�ļ�
                    //boolean flag=txml.readXMLFile(forms,authToken.getSiteID(),authToken.getSitename(),ID);
                    //if(flag){
                    txml.createXML(forms,authToken.getSiteID(),authToken.getSitename(),ID,baseDir);
                    // }
                }
                //System.out.println("listlength="+startformlist.size());


                //  txml.readXMLFile("E:\\works\\webbuilder5\\webapps\\cms\\sites\\test1_coosite_com\\_progInput.xml");
                //   txml.writeXMLFile("");
            }


            success = true;
        }
        catch (ModelException e)
        {
            e.printStackTrace();
            errors = true;
        }
    }

    if (success)
    {
        response.sendRedirect(response.encodeRedirectURL("closewin.jsp?id="+ID+"&column="+columnID+"&rightid="+rightid));
        return;
    }
%>

<html>
<head>
<title>�޸�ģ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel=stylesheet type="text/css" href="../style/editor.css">
<script type="text/javascript" src="../toolbars/btnclick<%=CmsServer.lang%>.js"></script>
<script type="text/javascript" src="../toolbars/dhtmled.js"></script>
<script type="text/javascript" src="../fckeditor/fckeditor.js"></script>

<script language="javascript">
    function checkoption(para,para1)
    {
        var selectlens = new Array;
        selectlens[0] = 25;
        var optionsname = new Array();
        var optionsvalue = new Array();

        optionsname[0] = new Array();
        optionsname[0][0] ="ѡ����";
        optionsname[0][1] ="�����б�";
        optionsname[0][2] ="��Ŀ�б�";
        optionsname[0][3] ="����·��";
        optionsname[0][4] ="Ӣ��·��";
        optionsname[0][5] ="�ȵ�����";
        optionsname[0][6] ="�������б�";
        optionsname[0][7] ="��������";
        optionsname[0][8] ="����������";
        optionsname[0][9] ="������";
        optionsname[0][10] ="��¼��";
        optionsname[0][11] ="�������ҳ";
        optionsname[0][12] ="���ﳵ";
        optionsname[0][13] ="��������";
        optionsname[0][14] ="��������";
        optionsname[0][15] ="������ѯ";
        optionsname[0][16] ="��Ϣ����";
        optionsname[0][17] ="��������";
        optionsname[0][18] ="�û�ע��";
        optionsname[0][19] ="��¼��ʾҳ";
        optionsname[0][20] ="������ϸ��ѯҳ";
        optionsname[0][21] ="�û�����";
        optionsname[0][22] ="�޸�ע��";
        optionsname[0][23] = "ͼƬ��Ч";
        optionsname[0][24] = "�Զ����";
        optionsname[0][25] ="ѡ�����б��";

        optionsvalue[0] = new Array();
        optionsvalue[0][0] ="NO_SELECT";
        optionsvalue[0][1] ="ARTICLE_LIST";
        optionsvalue[0][2] ="COLUMN_LIST";
        optionsvalue[0][3] ="CHINESE_PATH";
        optionsvalue[0][4] ="ENGLISH_PATH";
        optionsvalue[0][5] ="TOP_STORIES";
        optionsvalue[0][6] ="SUBARTICLE_LIST";
        optionsvalue[0][7] ="ARTICLE_COUNT";
        optionsvalue[0][8] ="SUBARTICLE_COUNT";
        optionsvalue[0][9] ="SEARCH_FORM";
        optionsvalue[0][10] ="LOGIN_FORM";
        optionsvalue[0][11] ="SEARCH_RESULT-11";
        optionsvalue[0][12] ="SHOPPINGCAR_RESULT-12";
        optionsvalue[0][13] ="ORDER_RESULT-13";
        optionsvalue[0][14] ="ORDER_REDISPLAY-14";
        optionsvalue[0][15] ="ORDERSEARCH_RESULT-15";
        optionsvalue[0][16] ="FEEDBACK-16";
        optionsvalue[0][17] ="ARTICLE_COMMENT-17";
        optionsvalue[0][18] ="REGISTER_RESULT-18";
        optionsvalue[0][19] ="USER_LOGIN_DISPLAY-19";
        optionsvalue[0][20] ="ORDERSEARCH_DETAIL-20";
        optionsvalue[0][21] ="LEAVE_MESSAGE-21";
        optionsvalue[0][22] ="UPDATEREG-22";
        optionsvalue[0][23] ="XUAN_IMAGES";
        optionsvalue[0][24] ="SELF_DEFINE_FORM";
        optionsvalue[0][25] ="USED_MARK";

        MarkName = document.getElementById("MarkName");
        MarkName.length = 0;
        param = 0;
        for (x=0; x<=selectlens[param]; x++)
        {
            oOption = document.createElement("OPTION");
            oOption.text = optionsname[param][x];
            oOption.value = optionsvalue[param][x];
            MarkName.add(oOption);
        }
    }

    function Form_Check(form)
    {
        var modeltype = form.modelType.value;

        if (modeltype < 10) {
            var ret = confirm("��ѡ�����ҳ��");
            return false;
        }

        if (form.cname.value == "")
        {
            alert("������ģ���������ƣ�");
            return false;
        }

        if (form.modelname.value == "")
        {
            alert("������ģ���ļ�����");
            return false;
        }

        return true;
    }
</script>
</head>

<body onload="return checkoption();">
<form action="edittemplateforprogram.jsp" method="post" name=createForm onsubmit="return Form_Check(createForm)">
    <input type="hidden" name=doUpdate value=true>
    <input type="hidden" name=modelnameBak value="<%=modelname%>">
    <input type="hidden" name=template value="<%=ID%>">
    <input type="hidden" name=columnCode value="<%=columnID%>">
    <input type="hidden" name=column value="<%=columnID%>">
    <input type="hidden" name=modelType value=<%=modelType%>>
    <input type="hidden" name=modelSourceCodeFlag value=0>
    <input type=hidden name=template_or_article_flag value="0">
    <input type="hidden" name=editor value="<%=username%>">
    <input type="hidden" name="username" value="<%=username%>">
    <input type="hidden" name="tempURL" value="<%=request.getRequestURL().toString()+"-"+siteid%>">

    <table width="100%" border=0 cellspacing=0 cellpadding=0>
        <tr bgcolor=#003366>
            <td colspan=3 height=2></td>
        </tr>
        <tr height=30>
            <td width="30%">��ǰ��Ŀ&nbsp;>&nbsp;<%=columnName%>
            </td>
            <td width="40%"><%
                if (!success && errors) {
                    out.println("<span class=cur>�޸�ģ��ʧ�ܣ����������ԡ�</span>");
                }
            %></td>
            <td width="30%" align=right>
                <input class=tine type=submit value="  ����  " name="savebutton">&nbsp;&nbsp;
                <input class=tine type=button value="  ȡ��  " onclick="window.location='closewin.jsp?id=<%=ID%>&column=<%=columnID%>&rightid=<%=rightid%>';">&nbsp;&nbsp;
            </td>
        </tr>
        <tr bgcolor=#003366>
            <td colspan=3 height=2></td>
        </tr>
        <tr>
            <td colspan=3 height=4></td>
        </tr>
    </table>
    <table width="100%" border=0 cellspacing=0 cellpadding=0>
        <tr>
            <td colspan=2>
                &nbsp;&nbsp;�������ƣ�<input type=text name="cname" size=20 value="<%=(cname==null)?"":cname%>" readonly>
                &nbsp;&nbsp;�ļ�����<input type=text name="modelname" size=20 value="<%=modelname%>" readonly>
                &nbsp;&nbsp;<select ID="MarkName" onchange="return MarkName_Add(<%=columnID%>,'<%=sitename%>')"></select>
                &nbsp;ģ���<input type=text name="tempnum" size="3" value="<%=model.getTempnum()%>"> </td>
        </tr>
    </table>

    <table border="0" width="100%">
        <tr>
            <td>
                <textarea id="content" name="content" style="WIDTH: 100%; HEIGHT: 530px"><%=content%></textarea>
                <script type="text/javascript">
                    var oFCKeditor = new FCKeditor('content') ;
                    oFCKeditor.BasePath = "../fckeditor/";
                    oFCKeditor.Height = 530;
                    oFCKeditor.ToolbarSet = "ProgramDefault";
                    oFCKeditor.ReplaceTextarea();
                </script>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
