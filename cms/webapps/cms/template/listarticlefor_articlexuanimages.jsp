<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*"
         contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.markManager.mark" %>
<%@ page import="com.bizwink.cms.markManager.IMarkManager" %>
<%@ page import="com.bizwink.cms.markManager.markPeer" %>
<%@ page import="com.bizwink.cms.publish.IPublishManager" %>
<%@ page import="com.bizwink.cms.publish.PublishPeer" %>
<%@ page import="com.bizwink.cms.xml.XMLProperties" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="com.bizwink.cms.sitesetting.*" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int siteID = authToken.getSiteID();
    ISiteInfoManager siteInfoMgr = SiteInfoPeer.getInstance();
    SiteInfo siteinfo = siteInfoMgr.getSiteInfo(siteID);

    String sitename = authToken.getSitename();
    String username = authToken.getUserID();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    int markID = ParamUtil.getIntParameter(request, "mark", 0);
    int modeltype = ParamUtil.getIntParameter(request, "modeltype", 0);
    int start = ParamUtil.getIntParameter(request, "start", 0);
    int range = ParamUtil.getIntParameter(request, "range", 20);
    int h = ParamUtil.getIntParameter(request, "height", 0);
    int w = ParamUtil.getIntParameter(request, "width", 0);
    int ph = ParamUtil.getIntParameter(request, "picheight", 0);
    int pw = ParamUtil.getIntParameter(request, "picwidth", 0);
    int px = ParamUtil.getIntParameter(request,"px",0);
    String msg = ParamUtil.getParameter(request, "msg");
    String pictype = ParamUtil.getParameter(request, "picturetype");
    String disp_pictype = ParamUtil.getParameter(request, "disp_picturetype");
    String keyword = ParamUtil.getParameter(request, "keyword");
    int pic_texiao_type = ParamUtil.getIntParameter(request,"pictxtype",12);
    int scrolltitle = ParamUtil.getIntParameter(request,"scrolltitle",0);
    String doaction = ParamUtil.getParameter(request, "doaction");
    int total = 0;
    int articleCount = 0;
    String CName = null;
    Column column = null;
    String dirname = null;
    String content = null;
    int innerFlag = 0;

    String notes = "";
    String cname = "����ͼƬ�б�";
    String extname = "";
    StringBuffer sb = new StringBuffer();
    IMarkManager markMgr = markPeer.getInstance();

    if (doaction.equals("ȷ��")){
        markID = ParamUtil.getIntParameter(request, "mark", 0);
        boolean saveas = ParamUtil.getBooleanParameter(request, "saveas");
        pic_texiao_type = ParamUtil.getIntParameter(request,"pictxtype",2);

        cname = ParamUtil.getParameter(request, "chineseName");
        notes = ParamUtil.getParameter(request, "notes");
        innerFlag = ParamUtil.getIntParameter(request, "innerFlag", 0);
        int listType = ParamUtil.getIntParameter(request, "listType", 0);
        int orgmarkID = markID;

        String viewer = request.getHeader("user-agent");
        String markname = "";
        markname = "ͼƬ��Ч";

        if ( pic_texiao_type >=0 && pic_texiao_type<=25) {
            markname = "ͼƬ��Ч";

            content = "[TAG][TURN_PIC][MARKTYPE]10[/MARKTYPE][TEXIAOTYPE]"+pic_texiao_type +"[/TEXIAOTYPE][PICTYPE]" + pictype + "[/PICTYPE][DISPPICTYPE]" + disp_pictype + "[/DISPPICTYPE][PH]" + ph + "[/PH][PW]" + pw + "[/PW][H]" + h +"[/H][W]" + w + "[/W][PX]" + px + "[/PX][STYLES][/STYLES][CONTENT][/CONTENT][/TURN_PIC][/TAG]";
            mark mark = new mark();
            mark.setID(markID);
            mark.setColumnID(columnID);
            mark.setSiteID(siteID);
            mark.setContent(content);
            mark.setChinesename(cname);
            mark.setNotes(notes);
            mark.setInnerHTMLFlag(innerFlag);
            mark.setFormatFileNum(listType);
            mark.setMarkType(10);
            if (orgmarkID > 0 && !saveas)
                markMgr.Update(mark);
            else
                markID = markMgr.Create(mark);
        }

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

    IColumnManager columnManager = ColumnPeer.getInstance();
    if (columnID > 0) {
        column = columnManager.getColumn(columnID);
        if (column != null) {
            dirname = column.getDirName();
            extname = column.getExtname();
        }
    } else {
        dirname = "/_prog/";
    }

    if (columnID > 0) {
        column = columnManager.getColumn(columnID);
        if (column != null)
            CName = column.getCName();
        else
            CName = "��ҳ";
    } else {
        CName = "����ģ��";
    }
%>

<html>
<head>
    <title>���¸���ͼƬ�б�</title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <link rel=stylesheet type=text/css href="../style/global.css">
</head>
<script language="JavaScript">
    function onclickthehref(form,start)
    {
        var obj;
        obj=document.getElementsByName("pictxtype");
        if(obj!=null){
            var i,ptxvalue;
            for(i=0;i<obj.length;i++){
                if(obj[i].checked){
                    ptxvalue = obj[i].value;
                    break;
                }
            }
        }

        var imgW = document.selarticleform.picwidth.value;
        var W = document.selarticleform.width.value;
        if(ptxvalue<=1){
            if(W>imgW*2){
                alert('��������Ȳ��ܴ���ͼƬ��ȵ�2��');
                return false;
            }
        }
        form.method="post";
        form.action="listarticlefor_articlexuanimages.jsp?start=" + start + "&pictxtype=" + ptxvalue;
        form.submit();
        //return true;
    }

    function closewin() {
        //top.opener.document.createForm.MarkName.value = "";
        top.window.close();
    }
</script>

<body>
<table cellpadding="1" cellspacing="1" border="0">
    <form name="selarticleform" onSubmit="javascript:return onclickthehref(selarticleform,<%=start%>)">
        <input type=hidden name=doSearch value=true>
        <input type=hidden name=saveas value=false>
        <input type=hidden name=mark value="<%=markID%>">
        <input type=hidden name=column value=<%=columnID%>>
        <input type=hidden name=start value=<%=start%>>
        <input type=hidden name=range value=<%=range%>>
        <input type=hidden name=modeltype value=<%=modeltype%>>
        <tr>
            <td>��Ч��ʾ���ͣ�</td>
            <td>
                <select name="pictxtype">
                    <option value="1">Flash�õ�Ч��</option>
                    <option value="2">������С</option>
                    <option value="3">��������</option>
                    <option value="4">԰����С</option>
                    <option value="5">Բ������</option>
                    <option value="6">�����Ϲ���</option>
                    <option value="7">�����¹���</option>
                    <option value="8">���������</option>
                    <option value="9">�����ҹ���</option>
                    <option value="10">��Ҷ���ҹ���</option>
                    <option value="11">��Ҷ���¹���</option>
                    <option value="12">դ���ҹ���</option>
                    <option value="13">դ���¹���</option>
                    <option value="14">����ɢ����Ч��</option>
                    <option value="15">���ҹ���Ч��</option>
                    <option value="16">���ҿ���Ч��</option>
                    <option value="17">���¿���Ч��</option>
                    <option value="18">���¹���Ч��</option>
                    <option value="19">�����������л�</option>
                    <option value="20">�����������л�</option>
                    <option value="21">�����������л�</option>
                    <option value="22">�����������л�</option>
                    <option value="23">��������</option>
                    <option value="24">��������</option>
                    <option value="25">����任Ч��</option>
                    <option value="26">ͼƬ�õƽ���</option>
                </select>
            </td>
        </tr>
        <tr >
            <td>�Ƿ���ʾͼƬ˵����</td>
            <td valign="top">
                <input type=checkbox name="scrolltitle" value="1" <%=(scrolltitle==0)?"":"checked"%>>�Ƿ���ʾͼƬ˵��
            </td>
        </tr>
        <tr>
            <td>ͼƬ�˵�����</td>
            <td>
                �˵����߶ȣ�<input type=text name="height" <%=(h!=0)?"value="+h:"value=\"400\""%> size="5">px
                �˵�����ȣ�<input type=text name="width"  <%=(w!=0)?"value="+w:"value=\"500\""%> size="5">px&nbsp;&nbsp;&nbsp;
                ͼƬ�߶ȣ� <input type=text name="picheight"  <%=(ph!=0)?"value="+ph:"value=\"\""%> size="5">px
                ͼƬ��ȣ� <input type=text name="picwidth"  <%=(pw!=0)?"value="+pw:"value=\"\""%> size="5">px&nbsp;
            </td>
        </tr>
        <tr>
            <td>�˵�ͼƬ˵����</td>
            <td>
                �˵�ͼƬ��С��<select name="picturetype" style="width: 150px">
                <option value="ts" selected><%=siteinfo.getTs_pic()%></option>
                <option value="s"><%=siteinfo.getS_pic()%></option>
                <option value="ms"><%=siteinfo.getMs_pic()%></option>
                <option value="m"><%=siteinfo.getM_pic()%></option>
                <option value="ml"><%=siteinfo.getMl_pic()%></option>
                <option value="l"><%=siteinfo.getL_pic()%></option>
                <option value="tl"><%=siteinfo.getTl_pic()%></option>
            </select>&nbsp;
                �˵�ͼƬ��ࣺ<input type=test name="px"  <%=(px!=0)?"value="+px:"value=\"10\""%> size="10">px&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td>����ͼƬ˵����</td>
            <td>
                ����ͼƬ��С��<select name="disp_picturetype" style="width: 150px">
                <option value="tl" selected><%=siteinfo.getTl_pic()%></option>
                <option value="l"><%=siteinfo.getL_pic()%></option>
                <option value="ml"><%=siteinfo.getMl_pic()%></option>
                <option value="m"><%=siteinfo.getM_pic()%></option>
                <option value="ms"><%=siteinfo.getMs_pic()%></option>
                <option value="s"><%=siteinfo.getS_pic()%></option>
                <option value="ts"><%=siteinfo.getTs_pic()%></option>
            </select>
            </td>
        </tr>
        <tr>
            <td>����Ƿ�Ҫ���ɰ����ļ���</td>
            <td>

                <input type=radio name=innerFlag value=0 <%if(innerFlag==0){%>checked<%}%>>��
                <input type=radio name=innerFlag value=1 <%if(innerFlag==1){%>checked<%}%>>��
            </td>
        </tr>
        <tr>
            <td>����������ƣ�</td>
            <td><input name=chineseName size=20 value="<%=cname%>" class=tine></td>
        </tr>
        <tr>
            <td>���������</td>
            <td><br><textarea rows="3" name="notes" id="notesid" cols="38" class=tine><%=notes%>
            </textarea></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
            <input type="submit"  name="doaction" value="ȷ��">&nbsp;&nbsp;
            <input type="button"  value="ȡ��" onClick="javascript:closewin();">
        </td></tr>
    </form>
</table>
</body>
</html>