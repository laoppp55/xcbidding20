<%@ page import="com.jspsmart.upload.SmartUploadException" %>
<%@ page import="java.io.File" %>
<%@ page import="com.bizwink.cms.util.*" %>
<%@ page import="com.bizwink.cms.security.*," %>
<%@page contentType="text/html;charset=GBK" %>
<%
    /*Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    } */

    int type = ParamUtil.getIntParameter(request, "type", 0);
    int startflag = ParamUtil.getIntParameter(request, "startflag", 0);
    if (startflag ==1) {
        //�ϴ�ͼƬ
        com.jspsmart.upload.SmartUpload mySmartUpload = new com.jspsmart.upload.SmartUpload();
        mySmartUpload.initialize(pageContext);
        mySmartUpload.setMaxFileSize(5 * 1024 * 1024);

        try {
            //�����ļ�
            mySmartUpload.upload();
        } catch (Exception e) {
            e.printStackTrace();
        }

        String myFileName = "";

        //ȡ���������ص��ļ�
        if (mySmartUpload.getFiles().getCount() > 0) {
            //ȡ�����ص��ļ�
            com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
            if (!myFile.isMissing()) {
                long createtime = System.currentTimeMillis();
                //ȡ�ú�׺��
                String ext = myFile.getFileExt();
                myFileName = String.valueOf(createtime) + "." + ext;

                if ((ext.equalsIgnoreCase("gif")) || (ext.equalsIgnoreCase("jpg")) || (ext.equalsIgnoreCase("jpeg")) || (ext.equalsIgnoreCase("bmp"))) {
                    //����·��
                    String path = application.getRealPath("/");
                    String trace = path + File.separator + "sites/images/buttons/" + myFileName;

                    //���ļ������ڷ�������
                    try {
                        myFile.saveAs(trace);
                    } catch (SmartUploadException e) {
                        e.printStackTrace();
                    }
                }
                mySmartUpload.stop();
                mySmartUpload = null;
                /*if (type==0) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"okimage\").value='" + myFileName + "';window.close();</script>");
                } else if(type ==1 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"cancelimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==2 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"addressimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==3 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"sendwayimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==4 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"paywayimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==5 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"orderimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==6 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"submitsimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==7 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"editsendwayimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==8 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"editpaywayimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==9 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"invoiceimage\").value='" + myFileName + "';window.close();</script>");
                }
                else if(type ==10 ) {
                    out.print("<script language=javascript>window.opener.document.getElementById(\"editinvoiceimage\").value='" + myFileName + "';window.close();</script>");
                }*/
                out.print("<script language=javascript>window.returnValue='" + myFileName + "';top.close();</script>");
            }
        }
    }


%>
<html>
<head>
    <title></title>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <meta http-equiv="Pragma" content="no-cache">
    <style type="text/css">
        TABLE {
            FONT-SIZE: 12px;
            word-break: break-all
        }

        BODY {
            FONT-SIZE: 12px;
            margin-top: 0px;
            margin-bottom: 0px;
            line-height: 20px;
        }

        .TITLE {
            FONT-SIZE: 16px;
            text-align: center;
            color: #FF0000;
            font-weight: bold;
            line-height: 30px;
        }

        .FONT01 {
            FONT-SIZE: 12px;
            color: #FFFFFF;
            line-height: 20px;
        }

        .FONT02 {
            FONT-SIZE: 12px;
            color: #D04407;
            font-weight: bold;
            line-height: 20px;
        }

        .FONT03 {
            FONT-SIZE: 14px;
            color: #000000;
            line-height: 25px;
        }

        A:link {
            text-decoration: none;
            line-height: 20px;
        }

        A:visited {
            text-decoration: none;
            line-height: 20px;
        }

        A:active {
            text-decoration: none;
            line-height: 20px;
            font-weight: bold;
        }

        A:hover {
            text-decoration: none;
            line-height: 20px;
        }

        .pad {
            padding-left: 4px;
            padding-right: 4px;
            padding-top: 2px;
            padding-bottom: 2px;
            line-height: 20px;
        }

        .form {
            border-bottom: #000000 1px solid;
            background-color: #FFFFFF;
            border-left: #000000 1px solid;
            border-right: #000000 1px solid;
            border-top: #000000 1px solid;
            font-size: 9pt;
            font-family: "����";
        }

        .botton {
            border-bottom: #000000 1px solid;
            background-color: #F1F1F1;
            border-left: #FFFFFF 1px solid;
            border-right: #333333 1px solid;
            border-top: #FFFFFF 1px solid;
            font-size: 9pt;
            font-family: "����";
            height: 20px;
            color: #000000;
            padding-bottom: 1px;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
            border-style: ridge
        }
    </style>
    <script language="javascript">
        function checkSelect() {
            if ((uploadform.pic.value == null) || (uploadform.pic.value == "")) {
                alert("��ѡ��Ҫ�ϴ���ͼƬ");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<center>
    <table width="80%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class="css_002">
        <tr>
            <td>
                <table width="100%" border="0" cellpadding="0">
                    <tr bgcolor="#F4F4F4" align="center">
                        <td height="30" valign="middle" bgcolor="#F4F4F4" class="css_003">��ťСͼƬ</td>
                    </tr>
                    <tr bgcolor="#d4d4d4" align="right">
                        <td>
                            <table width="100%" border="0" cellpadding="3" cellspacing="1" class="css_002">
                                <form name=uploadform enctype="multipart/form-data" method="post" action="uploadsubmitpic.jsp?type=<%=type%>&startflag=1"
                                      onsubmit="javascript:return checkSelect();">

                                    <tr bgcolor="#FFFFFF" class="css_001">
                                        <td>��ѡ��ͼƬ��<input type="file" name="pic"></td>
                                    </tr>
                                    <tr bgcolor="#FFFFFF" class="css_001">
                                        <td><input type="submit" name="sub" value="�ϴ�"></td>
                                    </tr>
                                </form>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</center>
</body>
</html>