package com.heaton.bot.test;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

import com.heaton.bot.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.regex.Pattern;

public class getHotelInfo {

    public getHotelInfo() {

    }

    /**
     * Program entry point, causes the main
     * window to be displayed.
     *
     * @param args Command line arguments are not used.
     */
    static public void main(String args[]) {
        StringBuffer temp = null;
        String domianname = "http://www.gubeikoucun.com";
        List<String> urls = new ArrayList();

        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6d4e\\u5357\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u9752\\u5c9b\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6dc4\\u535a\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u67a3\\u5e84\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u4e1c\\u8425\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u70df\\u53f0\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6f4d\\u574a\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6d4e\\u5b81\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6cf0\\u5b89\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u5a01\\u6d77\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u65e5\\u7167\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u83b1\\u829c\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u4e34\\u6c82\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u5fb7\\u5dde\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u804a\\u57ce\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6ee8\\u5dde\\u5e02");
        urls.add("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u83cf\\u6cfd\\u5e02");

        try {
            temp = new StringBuffer();
            URL url = new URL("http://www.sdta.cn/dtss/travelDaren/superiorSearchList.action?superiorProgramCondition.destId=\\u6d4e\\u5357\\u5e02");
            // 构造Image对象
            HttpURLConnection con = (HttpURLConnection)(url.openConnection());
            con.setConnectTimeout(10000);
            con.setReadTimeout(10000);
            System.out.println(con.getContentEncoding());
            System.out.println(con.getContentLength());
            System.out.println(con.getContentType());
            System.out.println(con.getHeaderField("Last-Modified"));
            System.out.println(con.getHeaderField("Server"));

            InputStream is = url.openStream();
            Reader rd = new InputStreamReader(is, "utf-8");
            int c = 0;
            while ((c = rd.read()) != -1) {
                temp.append((char) c);
            }

            String buf = temp.toString();
            boolean  existflag = true;
            String content = "";
            while (existflag) {
                int posi = buf.indexOf("<div class=\"wotoontraveler-16-col-3\">");
                if (posi > -1) {
                    buf = buf.substring(posi);
                    posi = buf .indexOf("<div class=\"gen-1\"></div>");
                    content = content + buf.substring(0,posi) + "\\r\\n";
                    buf = buf.substring(posi + "<div class=\"gen-1\"></div>".length());
                } else {
                    existflag = false;
                }
            }

            FileWriter fileWritter = new FileWriter("d:\\traveltips\\index"  + ".txt",false);
            BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
            bufferWritter.write(content);
            bufferWritter.close();
            is.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }


/*
        StringBuffer temp = null;
        String domianname = "http://www.gubeikoucun.com";
        try {
            for (int ii=1; ii<=4; ii++) {
                temp = new StringBuffer();
                URL url = new URL("http://www.gubeikoucun.com/kezhan/index/p/" + ii + ".html");
                // 构造Image对象
                HttpURLConnection con = (HttpURLConnection)(url.openConnection());
                con.setConnectTimeout(10000);
                con.setReadTimeout(10000);
                System.out.println(con.getContentEncoding());
                System.out.println(con.getContentLength());
                System.out.println(con.getContentType());
                System.out.println(con.getHeaderField("Last-Modified"));
                System.out.println(con.getHeaderField("Server"));

                InputStream is = url.openStream();
                Reader rd = new InputStreamReader(is, "utf-8");
                int c = 0;
                while ((c = rd.read()) != -1) {
                    temp.append((char) c);
                }

                String buf = temp.toString();
                Pattern p = Pattern.compile("/kezhan/show/id/[0-9]*.html",Pattern.CASE_INSENSITIVE);
                java.util.regex.Matcher matcher = p.matcher(buf);
                String matchStr = null;
                int jj = 0;
                while (matcher.find()) {
                    jj = jj + 1;
                    matchStr = buf.substring(matcher.start(), matcher.end());
                    url = new URL(domianname + matchStr);
                    is = url.openStream();
                    rd = new InputStreamReader(is, "utf-8");
                    c = 0;
                    while ((c = rd.read()) != -1) {
                        temp.append((char) c);
                    }
                    BufferedWriter Writter = new BufferedWriter(new FileWriter("d:\\" + ii +"-" + jj + ".txt",false));
                    Writter.write(temp.toString());
                    Writter.close();
                    System.out.println(matchStr);
                }

                FileWriter fileWritter = new FileWriter("d:\\" + ii + ".txt",false);
                BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
                bufferWritter.write(buf);
                bufferWritter.close();

                //InputStream is = null;
                //is = con.getInputStream();
                //OutputStream os = null;
                //os = new FileOutputStream("d:\\" + ii + ".txt");
                //int bytesRead = 0;
                //byte[] buffer = new byte[8192];
                //while((bytesRead = is.read(buffer,0,8192))!=-1){
                //    os.write(buffer,0,bytesRead);
                //}
                is.close();
                //os.close();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
*/
    }

}
