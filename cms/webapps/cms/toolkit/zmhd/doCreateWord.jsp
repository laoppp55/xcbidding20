<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.cms.util.CompressedFileUtil" %>
<%@ page import="com.bizwink.cms.util.HtmlToWord" %>
<%@ page import="com.heaton.bot.RandomStrg" %>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page import="java.io.File" %>
<%
    String[] checkids = request.getParameterValues("checkids");
    //String checkId = "";
    if ((checkids != null) && (checkids.length > 0)) {
        String path="/wordfile/";
        // ���Ŀ¼�Ƿ����
        File fileDir = new File(path);
        if (!fileDir.exists()  && !fileDir.isDirectory())
        {
            System.out.println("//������");
            fileDir.mkdir();
        }
        RandomStrg rstr = new RandomStrg();
        rstr.setCharset("a-z0-9");
        rstr.setLength(8);
        rstr.generateRandomObject();
        path = path+ "zmhd"+rstr.getRandom()+"/";
        for (int i = 0; i < checkids.length; i++) {
            //checkId = checkId + checkids[i] + ",";
            System.out.println(i+":"+checkids[i]);
            int id = Integer.valueOf(checkids[i]);
            HtmlToWord.writeWordFile(id,path);
        }
        CompressedFileUtil compressedFileUtil = new CompressedFileUtil();
        try {
            System.out.println(path);
            String downloadurl = compressedFileUtil.compressedFile(path, "/wordfile/");
            System.out.println(downloadurl);
            System.out.println("ѹ���ļ��Ѿ�����...");
            if (downloadurl != null) {
                //�½�һ��SmartUpload����
                SmartUpload su = new SmartUpload();
                //��ʼ��
                su.initialize(pageContext);
                // �趨contentDispositionΪnull�Խ�ֹ������Զ����ļ�
                su.setContentDisposition(null);
                su.downloadFile(downloadurl);
            }
        } catch (Exception e) {
            System.out.println("ѹ���ļ�����ʧ��...");
            e.printStackTrace();
        }

    }

    /*if(checkId.indexOf(",") != -1)
        checkId = checkId.substring(0, (checkId.length()-1));*/

    //System.out.println(checkId);
%>