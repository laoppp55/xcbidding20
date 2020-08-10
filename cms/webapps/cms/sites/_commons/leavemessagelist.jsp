<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.webapps.leaveword.IWordManager" %>
<%@ page import="com.bizwink.webapps.leaveword.LeaveWordPeer" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.markManager.*" %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>
<%@ page import="com.bizwink.cms.xml.XMLProperties" %>
<%@ page import="com.bizwink.webapps.leaveword.Word" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.FileOutputStream" %>
<%@page contentType="text/html;charset=GBK" %>
<%
    int range = 0;
    int startrow = ParamUtil.getIntParameter(request,"startrow",0);
    int siteid = 1;
    int markid = ParamUtil.getIntParameter(request, "markid", 0);
    int audit_n = 0;
    int formid_n = 0;
    //��ñ����Ϣ
    IMarkManager markMgr = markPeer.getInstance();
    if (markid > 0) {
        String str = StringUtil.gb2iso4View(markMgr.getAMarkContent(markid));
        str = StringUtil.replace(str, "[", "<");
        str = StringUtil.replace(str, "]", ">");
        str = StringUtil.replace(str, "{^", "[");
        str = StringUtil.replace(str, "^}", "]");
        XMLProperties properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + str);
        range = Integer.parseInt(properties.getProperty(properties.getName().concat(".RANGE")));
        siteid = Integer.parseInt(properties.getProperty(properties.getName().concat(".SITEID")));
        String audit = properties.getProperty(properties.getName().concat(".AUDIT"));                          //�Ƿ�ֻ��ʾ��˺����Ϣ
        if (audit != null) audit_n = Integer.parseInt(audit);
        String formid = properties.getProperty(properties.getName().concat(".FORMID"));                        //�б���������Ա�
        if (formid != null) formid_n = Integer.parseInt(formid);
        String fenyestyle =properties.getProperty(properties.getName().concat(".PAGES"));               //��ҳ��ʽ
        int fenye_n = 0;
        if (fenyestyle != null) fenye_n = Integer.parseInt(fenyestyle);
        String listStyle = properties.getProperty(properties.getName().concat(".LISTSTYLE"));
        String head = "";
        String tail = "";
        if (listStyle != null) {
            listStyle = listStyle.substring(0,listStyle.length() -1);
            int posi = listStyle.indexOf("<"+"%%begin%%"+">");
            if (posi > -1) {
                head = listStyle.substring(0,posi);
                listStyle = listStyle.substring(posi + ("<"+"%%begin%%"+">").length());
            }
            posi = listStyle.indexOf("<"+"%%end%%"+">");
            if (posi > -1) {
                tail = listStyle.substring(posi + ("<"+"%%end%%"+">").length());
                listStyle = listStyle.substring(0,posi);
            }
        }

        if (formid != null) {
            mark mark=null;
            mark=markMgr.getAMark(Integer.parseInt(formid));
            String buf = StringUtil.gb2iso4View(mark.getContent());
            buf = StringUtil.replace(buf, "[", "<");
            buf = StringUtil.replace(buf, "]", ">");
            buf = StringUtil.replace(buf, "{^", "[");
            buf = StringUtil.replace(buf, "^}", "]");

            properties = new XMLProperties("<?xml version=\"1.0\" encoding=\"gb2312\"?>" + buf);
            String content = properties.getProperty(properties.getName().concat(".CONTENT"));
            XMLProperties contentProperties = null;
            contentProperties = new XMLProperties(content.substring(0,content.length() -1));
            String names[] = contentProperties.getChildrenProperties("fields");
            String outstr = head;
            IWordManager wMgr = LeaveWordPeer.getInstance();
            List list = new ArrayList();
            audit_n = 1;
            list = wMgr.getCurrentWord(siteid,formid_n, audit_n, startrow, range);
            int total_word = wMgr.getTotalWord(siteid,formid_n,audit_n);
            buf = "";
            String line = "";
            for(int i = 0; i < list.size(); i ++) {
                Word word = (Word)list.get(i);
                if(word != null){
                    line = listStyle;
                    line = StringUtil.replace(line,"<"+"%%id%%"+">",String.valueOf(word.getId()));
                    for(int j = 0; j < names.length; j ++){
                        String chinesename = contentProperties.getProperty("fields." + names[j] + ".chinesename");
                        if (chinesename != null) {
                            if(chinesename.equals("�ż�����")){
                                if (word.getTitle() != null)
                                    line = StringUtil.replace(line,"<"+"%%title%%"+">",StringUtil.gb2iso4View(word.getTitle()));
                                else
                                    line = StringUtil.replace(line,"<"+"%%title%%"+">","&nbsp");
                            }
                            else if(chinesename.equals("�ż�����"))
                            {
                                if (word.getContent() != null)
                                    line = StringUtil.replace(line,"<"+"%%content%%"+">",StringUtil.gb2iso4View(word.getContent()));
                                else
                                    line = StringUtil.replace(line,"<"+"%%content%%"+">","&nbsp;");
                            }
                            else if(chinesename.equals("���Ź�˾"))
                            {
                                if (word.getCompany() != null)
                                    line = StringUtil.replace(line,"<"+"%%company%%"+">",StringUtil.gb2iso4View(word.getCompany()));
                                else
                                    line = StringUtil.replace(line,"<"+"%%company%%"+">","&nbsp;");
                            }
                            else if(chinesename.equals("��    ��"))
                            {
                                if (word.getLinkman() != null)
                                    line = StringUtil.replace(line,"<"+"%%contactor%%"+">",StringUtil.gb2iso4View(word.getLinkman()));
                                else
                                    line = StringUtil.replace(line,"<"+"%%contactor%%"+">","&nbsp;");
                            }
                            else if(chinesename.equals("��ϵ��ַ"))
                            {
                                if (word.getLinks() != null)
                                    line = StringUtil.replace(line,"<"+"%%contactway%%"+">",StringUtil.gb2iso4View(word.getLinks()));
                                else
                                    line = StringUtil.replace(line,"<"+"%%contactway%%"+">","&nbsp;");
                            }
                            else if(chinesename.equals("��������"))
                            {
                                if (word.getZip() != null)
                                    line = StringUtil.replace(line,"<"+"%%postcode%%"+">",word.getZip());
                                else
                                    line = StringUtil.replace(line,"<"+"%%postcode%%"+">","&nbsp;");
                            }
                            else if(chinesename.equals("�����ʼ�"))
                            {
                                if (word.getEmail() != null)
                                    line = StringUtil.replace(line,"<"+"%%email%%"+">",word.getEmail());
                                else
                                    line = StringUtil.replace(line,"<"+"%%email%%"+">","&nbsp;");
                            } else if(chinesename.equals("��ϵ�绰"))
                            {
                                if (word.getPhone() != null)
                                    line = StringUtil.replace(line,"<"+"%%telephone%%"+">",word.getPhone());
                                else
                                    line = StringUtil.replace(line,"<"+"%%telephone%%"+">","&nbsp;");
                            }

                            if (word.getUserid() != null)
                                line = StringUtil.replace(line,"<"+"%%username%%"+">",word.getUserid());
                            else {
                                line = StringUtil.replace(line,"<"+"%%username%%"+">","&nbsp;");
                            }

                            //�ظ�����
                            if (word.getRetcontent() != null)
                                line = StringUtil.replace(line,"<"+"%%return%%"+">",word.getRetcontent());
                            else {
                                line = StringUtil.replace(line,"<"+"%%return%%"+">","&nbsp;");
                            }

                            //�ظ�ʱ��
                            if (word.getEndtouser() != null)
                                line = StringUtil.replace(line,"<"+"%%rettime%%"+">",word.getEndtouser().toString());
                            else {
                                line = StringUtil.replace(line,"<"+"%%rettime%%"+">","&nbsp;");
                            }

                            if (line.indexOf("writedate") > -1) {
                                if (word.getRetcontent() != null)
                                    line = StringUtil.replace(line,"<"+"%%writedate%%"+">",word.getWritedate().toString());
                                else {
                                    line = StringUtil.replace(line,"<"+"%%writedate%%"+">","&nbsp;");
                                }
                            }
                        }
                    }
                    buf = buf + line;
                }
            }
            outstr = outstr + buf;
            outstr = outstr + tail;

            //��ҳ
            if (fenye_n > 0) {
                int pages = total_word/range;
                int current_page = startrow/range;
                outstr = outstr +  StringUtil.generateNavBar(markid,fenye_n,pages,current_page,current_page,range,"javascript:getleavemessagelist");
            }

            PrintWriter pw = new PrintWriter(new FileOutputStream("c:\\tt.txt"));
            pw.write(outstr);
            pw.close();

            out.print(outstr);
        }
    } else {
        out.print("û��������Ϣ��");
    }

%>