package com.bizwink.util;


import java.util.*;
import java.util.regex.Pattern;

public class StringUtil {
    public static String iso2gb(String str) {
        return str;
    }

    public static boolean isNullOrEmpty(Object obj) {
        return obj == null || "".equals(obj.toString());
    }
    public static String toString(Object obj){
        if(obj == null) return "null";
        return obj.toString();
    }
    public static String join(Collection s, String delimiter) {
        StringBuffer buffer = new StringBuffer();
        Iterator iter = s.iterator();
        while (iter.hasNext()) {
            buffer.append(iter.next());
            if (iter.hasNext()) {
                buffer.append(delimiter);
            }
        }
        return buffer.toString();
    }

    public static String gb2iso4View(String str) {
        try {
            return new String(str.getBytes("iso-8859-1"), "GBK");
        }
        catch (Exception e) {
            return str;
        }
    }

    //获取标记之间的内容
    public static final String getContentFromHTML(String content, String startTag, String endTag) {
        List list = new ArrayList();
        String tempBuf = content.toLowerCase();
        tempBuf = StringUtil.replace(tempBuf,"&lt;","<");
        tempBuf = StringUtil.replace(tempBuf,"&gt;",">");
        String lowcaseStartTag = startTag.toLowerCase();
        String lowcaseEndTag = endTag.toLowerCase();
        String field = "";
        int startTagPosi = 0;
        int endTagPosi = 0;
        int endTagLength = endTag.length();
        startTagPosi = tempBuf.indexOf(lowcaseStartTag);

        while (startTagPosi != -1) {
            endTagPosi = tempBuf.indexOf(lowcaseEndTag);
            if (endTagPosi != -1) {
                field = content.substring(startTagPosi + startTag.length(), endTagPosi);
                list.add(field);
                tempBuf = tempBuf.substring(endTagPosi + endTagLength);
                content = content.substring(endTagPosi + endTagLength);
            }
            startTagPosi = tempBuf.indexOf(lowcaseStartTag);
        }

        tempBuf = "";
        for (int i=0; i<list.size(); i++) {
            tempBuf = tempBuf + (String)list.get(i);
        }

        return tempBuf;
    }

    //获取HTML文件的文本内容
    public static final String getContentFromHTML(String content) {
        String tempBuf = "";
        Pattern p = Pattern.compile("<[^<>]*>", Pattern.CASE_INSENSITIVE);
        if (content != null) {
            String buf[] = p.split(content);

            for(int i=0; i<buf.length; i++) {
                tempBuf = tempBuf + buf[i];
            }
        }

        return tempBuf;
    }

    public static final String replace(String line, String oldString, String newString) {
        int i = 0;
        if (line != null) {
            if ((i = line.indexOf(oldString, i)) >= 0) {
                char[] line2 = line.toCharArray();
                char[] newString2 = newString.toCharArray();
                int oLength = oldString.length();
                StringBuffer buf = new StringBuffer(line2.length);
                buf.append(line2, 0, i).append(newString2);
                i += oLength;
                int j = i;
                while ((i = line.indexOf(oldString, i)) > 0) {
                    buf.append(line2, j, i - j).append(newString2);
                    i += oLength;
                    j = i;
                }
                buf.append(line2, j, line2.length - j);
                return buf.toString();
            }
        }
        return line;
    }

    public static final String replace(String line, String oldString, String newString, int[] count) {
        if (line == null) {
            return null;
        }

        int i = 0;
        if ((i = line.indexOf(oldString, i)) >= 0) {
            int counter = 0;
            counter++;
            char[] line2 = line.toCharArray();
            char[] newString2 = newString.toCharArray();
            int oLength = oldString.length();
            StringBuffer buf = new StringBuffer(line2.length);
            buf.append(line2, 0, i).append(newString2);
            i += oLength;
            int j = i;
            while ((i = line.indexOf(oldString, i)) > 0) {
                counter++;
                buf.append(line2, j, i - j).append(newString2);
                i += oLength;
                j = i;
            }
            buf.append(line2, j, line2.length - j);
            count[0] = counter;
            return buf.toString();
        }
        return line;
    }

    public static boolean isNumeric(String str){
        for (int i = str.length();--i>=0;){
            if (!Character.isDigit(str.charAt(i))){
                return false;
            }
        }
        return true;
    }

    public static String getUUID() {
        String id =null;
        UUID uuid = UUID.randomUUID();
        id = uuid.toString();

        //去掉随机ID的短横线
        id = id.replace("-", "");

        //将随机ID换成数字
        int num = id.hashCode();
        //去绝对值
        num = num < 0 ? -num : num;

        id = String.valueOf(num);

        return id;
    }
}
