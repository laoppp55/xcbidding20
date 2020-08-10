<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.toolkit.csinfo.CsInfo" %>
<%@ page import="com.bizwink.cms.toolkit.csinfo.ICsInfoManager" %>
<%@ page import="com.bizwink.cms.toolkit.csinfo.CsInfoPeer" %>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.bizwink.cms.sitesetting.IFtpSetManager" %>
<%@ page import="com.bizwink.cms.sitesetting.FtpInfo" %>
<%@ page import="com.bizwink.cms.sitesetting.FtpSetting" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    String sitename = authToken.getSitename();
    String baseDir = application.getRealPath("/");
    int siteID = authToken.getSiteID();
    String userID = authToken.getUserID();
    IFtpSetManager ftpsetMgr = FtpSetting.getInstance();

    List piclist = (List) session.getAttribute("upload_pic");
    if (piclist == null) piclist = new ArrayList();

   // System.out.println(userID);
   // System.out.println(siteID);
    SmartUpload upload = new SmartUpload();
    upload.initialize(this.getServletConfig(), request, response);
    upload.upload();

    String startflag =  upload.getRequest().getParameter("startflag");
    String ROOM_NAME = upload.getRequest().getParameter("ROOM_NAME");
    String CATLOG_CODE = upload.getRequest().getParameter("CATLOG_CODE");
    String ROOM_TYPE = upload.getRequest().getParameter("ROOM_TYPE");
    String ROOM_NUM = upload.getRequest().getParameter("ROOM_NUM");
    String ROOM_WAY = upload.getRequest().getParameter("ROOM_WAY");
    String ROOM_SIZE = upload.getRequest().getParameter("ROOM_SIZE");
    String INIT_PRICE = upload.getRequest().getParameter("INIT_PRICE");
    String BED_NUM = upload.getRequest().getParameter("BED_NUM");
    String BED_TYPE = upload.getRequest().getParameter("BED_TYPE");
    String FLOOR = upload.getRequest().getParameter("FLOOR");
    String TOILET = upload.getRequest().getParameter("TOILET");
    String TV = upload.getRequest().getParameter("TV");
    String AIRCONDITIONER = upload.getRequest().getParameter("AIRCONDITIONER");
    String BATHROOM = upload.getRequest().getParameter("BATHROOM");
    String BEDCLOTHES = upload.getRequest().getParameter("BEDCLOTHES");
    String AMENITIES = upload.getRequest().getParameter("AMENITIES");
    String SPECIALSERVICE = upload.getRequest().getParameter("SPECIALSERVICE");

    System.out.println("startflag="+startflag);




    if(startflag!=null&&startflag.equals("1")){
        //��ȡ�ϴ����ļ��������ϴ��ļ�
        com.jspsmart.upload.Files uploadfiles = upload.getFiles();
        String[] upfiles = new String[uploadfiles.getCount()];
        if(uploadfiles.getCount()>0){
            for(int ii=0; ii<uploadfiles.getCount(); ii++) {
                com.jspsmart.upload.File tempfile = uploadfiles.getFile(ii);
                if(!tempfile.isMissing()){
                    //java.io.File tfile = new java.io.File(baseDir + "images/");
                    //if(!tfile.exists()) tfile.mkdirs();
                    String filename = URLDecoder.decode(tempfile.getFileName(), "utf-8");
                    filename = filename.substring(filename.lastIndexOf(File.separator)+1);
                    int posi = filename.lastIndexOf(".");
                    String ext_name = "";
                    if (posi>-1) ext_name = filename.substring(posi);
                    String uuid = UUID.randomUUID().toString();
                    uuid = uuid.replaceAll("-", "");
                    String myfilename = uuid + ext_name;
                    upfiles[ii] = myfilename;
                    //tempfile.saveAs(saveit);
                    //upload.save(baseDir + column.getDIRNAME().replace("/", File.separator) +"images/");

                    String saveUrl = baseDir + "sites/" + sitename  + "/images/";//�ļ�����·��
                    java.io.File tfile = new java.io.File(saveUrl);
                    if(!tfile.exists()) tfile.mkdirs();
                    tempfile.saveAs(saveUrl+java.io.File.separator + myfilename,upload.SAVE_PHYSICAL);

                    String saveit = tfile.getPath()+java.io.File.separator + myfilename;
                    System.out.println("original name=" + tempfile.getFileName());
                    System.out.println("full file name=" + saveit);

                   /* List siteList = ftpsetMgr.getFtpInfoList(siteID);
                    for(int j=0; j < siteList.size();j++){
                        FtpInfo ftpInfo = (FtpInfo)siteList.get(j);
                        String docPath = ftpInfo.getDocpath();
                        String dirUrl = docPath+"/images/"; //�ļ�����·��
                        System.out.println("docPath="+docPath);
                        tempfile.saveAs(dirUrl+java.io.File.separator + myfilename,upload.SAVE_PHYSICAL);
                    }*/
                    CsInfo csInfo = new CsInfo();
                    csInfo.setRoom_pic_url(myfilename);
                    piclist.add(csInfo);
                    session.setAttribute("upload_pic", piclist);

                }
            }
        }

        //���
        CsInfo csinfo= new CsInfo();
        ICsInfoManager csInfoMgr = CsInfoPeer.getInstance();
        //long nowtime = System.currentTimeMillis();
        csinfo.setSiteid(siteID);
        csinfo.setROOM_NAME(ROOM_NAME);
        csinfo.setCATLOG_CODE(CATLOG_CODE);
        csinfo.setROOM_TYPE(Integer.valueOf(ROOM_TYPE));
        csinfo.setBED_NUM(Integer.valueOf(ROOM_NUM));
        csinfo.setROOM_WAY(ROOM_WAY);
        csinfo.setROOM_SIZE(Integer.valueOf(ROOM_SIZE));
        csinfo.setINIT_PRICE(Integer.valueOf(INIT_PRICE));
        csinfo.setBED_NUM(Integer.valueOf(BED_NUM));
        csinfo.setBED_TYPE(BED_TYPE);
        csinfo.setFLOOR(Integer.valueOf(FLOOR));
        csinfo.setTOILET(Integer.valueOf(TOILET));
        csinfo.setTV(Integer.valueOf(TV));
        csinfo.setAIRCONDITIONER(Integer.valueOf(AIRCONDITIONER));
        csinfo.setBATHROOM(Integer.valueOf(BATHROOM));
        csinfo.setBEDCLOTHES(Integer.valueOf(BEDCLOTHES));
        csinfo.setAMENITIES(Integer.valueOf(AMENITIES));
        csinfo.setSPECIALSERVICE(Integer.valueOf(SPECIALSERVICE));

        csInfoMgr.insertCsinfo(csinfo,piclist);
        session.removeAttribute("upload_pic");
        response.sendRedirect("index.jsp");
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>��ӷ�����Ϣ</title>
    <META http-equiv=Content-Type content="text/html; charset=UTF-8">
    <SCRIPT language=javascript>
        function check()
        {
            return true;
        }

        //�������ڶ�ͼƬ�ϴ�Ԥ������
        function setImagePreviews() {
            var docObj = document.getElementById("doc");
            var dd = document.getElementById("dd");
            dd.innerHTML = "";
            var fileList = docObj.files;
            for (var i = 0; i < fileList.length; i++) {
                dd.innerHTML += "<div style=\'float:left\'><img id='img" + i + "'  /> </div>";
                var imgObjPreview = document.getElementById("img"+i);
                if (docObj.files &&docObj.files[i]) {

                    //����£�ֱ����img����
                    imgObjPreview.style.display = 'block';
                    imgObjPreview.style.width = '150px';
                    imgObjPreview.style.height = '180px';
                    //imgObjPreview.src = docObj.files[0].getAsDataURL();
                    //���7���ϰ汾�����������getAsDataURL()��ʽ��ȡ����Ҫһ�·�ʽ
                    imgObjPreview.src = window.URL.createObjectURL(docObj.files[i]);
                }
                else {
                    //IE�£�ʹ���˾�
                    docObj.select();
                    var imgSrc = document.selection.createRange().text;
                    alert(imgSrc);
                    var localImagId = document.getElementById("img" + i);
                    //�������ó�ʼ��С
                    localImagId.style.width = "150px";
                    localImagId.style.height = "180px";
                    //ͼƬ�쳣�Ĳ�׽����ֹ�û��޸ĺ�׺��α��ͼƬ
                    try {
                        localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                        localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
                    }
                    catch (e) {
                        alert("���ϴ���ͼƬ��ʽ����ȷ��������ѡ��!");
                        return false;
                    }
                    imgObjPreview.style.display = 'none';
                    document.selection.empty();
                }
            }
            return true;
        }
        function goto()
        {
            form1.action="index.jsp";
            form1.submit();
        }

</script>
        </head>
<BODY bgColor=#ffffff>
<CENTER>
<FORM name=form1 action=addcsinfo.jsp method=post enctype="multipart/form-data"  onsubmit="check()">
    <INPUT type="hidden" name="startflag" value=1 >

        <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80%
               borderColorLight=#008000 border=1>
            <TBODY>
            <TR>
                <TD bgColor=#33ccff colSpan=2 height=32>
                    <P align=center>��ӷ�����Ϣ</P></TD></TR>
            <TR height=32>
                <TD align=right width=30% height=32>�������ƣ�</TD>
                <TD align=left width=70% height=32>&nbsp;<INPUT name=ROOM_NAME> <FONT
                        color=red>*</FONT> </TD></TR>
            <TR height=32>
                <TD align=right>�����ţ�</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=CATLOG_CODE>
                </TD></TR>
            <TR height=32>
                <TD align=right>�������ͣ�</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=ROOM_TYPE> </TD></TR>
            <TR height=32>
                <TD align=right>���仧�ͣ�</TD>
                <TD align=left>&nbsp;<INPUT size=13 name=ROOM_NUM>
                </TD></TR>
            <TR height=32>
                <TD align=right>���䳯��</TD>
                <TD align=left>&nbsp;<INPUT name=ROOM_WAY> </TD></TR>
            <TR height=32>
                <TD align=right>���������</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=ROOM_SIZE>
                </TD></TR>
            <TR height=32>
                <TD align=right>����۸�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=INIT_PRICE> </TD></TR>
            <TR height=32>
                <TD align=right>��λ����</TD>
                <TD align=left>&nbsp;<INPUT size=30 name=BED_NUM> </TD></TR>
            <TR height=32>
                <TD align=right>��λ���ͣ�</TD>
                <TD align=left>&nbsp;<INPUT size=30 name=BED_TYPE> </TD></TR>
            <TR height=32>
                <TD align=right>���ڲ�����</TD>
                <TD align=left>&nbsp;<INPUT size=30 name=FLOOR> </TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ��������䣺</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=TOILET value="1" checked>��<INPUT type="radio" size=30 name=TOILET value="0">û�� </TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ��е��ӣ�</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=TV value="1" checked>��<INPUT type="radio" size=30 name=TV value="0">û�� </TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ��пյ���</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=AIRCONDITIONER value="1" checked>��<INPUT type="radio" size=30 name=AIRCONDITIONER value="0">û��</TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ���ϴ��䣺</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=BATHROOM value="1" checked>��<INPUT type="radio" size=30 name=BATHROOM value="0">û��</TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ��б��죺</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=BEDCLOTHES value="1" checked>��<INPUT type="radio" size=30 name=BEDCLOTHES value="0">û��</TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ������ֳ�����</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=AMENITIES value="1" checked>��<INPUT type="radio" size=30 name=AMENITIES value="0">û��</TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ����ر�ҵ��</TD>
                <TD align=left>&nbsp;<INPUT type="radio" size=30 name=SPECIALSERVICE value="1" checked>��<INPUT type="radio" size=30 name=SPECIALSERVICE value="0">û�� </TD></TR>
            <TR height=32>
                <TD align=right>�Ƿ�</TD>
                <TD align=left>&nbsp;<INPUT size=30 name=DELFLAG> </TD></TR>
            <TR height=32>
                <TD align=right>��ӷ���ͼƬ:</TD>
                <TD align=left><input type="file"  name="img" id="doc" style="width:150px;" multiple="multiple"  onchange="javascript:setImagePreviews();" accept="image/*" /></TD>
            </TR>
            <TR height=32>
                <TD colspan="2"><div id="dd" style=" width:990px;"></div></TD>
            </TR>
            <TR>
                <TD colSpan=2><FONT
                        color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע������*����Ϊ������</FONT></TD>
            </TR></TBODY></TABLE>
        <P align=center><INPUT type=submit value=" ȷ �� " name=Ok>&nbsp;&nbsp;
            <INPUT onclick=javascript:goto(); type=button value=�����б� name=golist>
        </P>
</FORM>
</CENTER>
</BODY>
</html>
