package com.bizwink.net.http;

import com.bizwink.cms.server.MyConstants;
import com.bizwink.util.FileUtil;
import com.bizwink.util.Md5;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created with IntelliJ IDEA.
 * User: perter.song
 * Date: 16-5-20
 * Time: 下午3:47
 * To change this template use File | Settings | File Templates.
 */
public class Post {

    /**
     * POST---有参测试(普通参数)
     *
     * @date 2018年7月13日 下午4:18:50
     */
    public static String PostByHttpClient(String url, String params) {
        String retval = null;
        // 获得Http客户端(可以理解为:你得先有一个浏览器;注意:实际上HttpClient与浏览器是不一样的)
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();

        // 创建Post请求
        HttpPost httpPost = new HttpPost(url + "?" + params);

        // 设置ContentType(注:如果只是传普通参数的话,ContentType不一定非要用application/json)
        httpPost.setHeader("Content-Type", "application/json;charset=utf8");

        // 响应模型
        CloseableHttpResponse response = null;
        try {
            // 由客户端执行(发送)Post请求
            response = httpClient.execute(httpPost);
            // 从响应模型中获取响应实体
            HttpEntity responseEntity = response.getEntity();

            System.out.println("响应状态为:" + response.getStatusLine());
            if (responseEntity != null) {
                System.out.println("响应内容长度为:" + responseEntity.getContentLength());
                System.out.println("响应内容为:" + EntityUtils.toString(responseEntity));
                retval = EntityUtils.toString(responseEntity);
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                // 释放资源
                if (httpClient != null) {
                    httpClient.close();
                }
                if (response != null) {
                    response.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return retval;
    }

    /**
     * 向指定 URL 发送POST方法的请求
     *
     * @param url
     *            发送请求的 URL
     * @param param
     *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return 所代表远程资源的响应结果
     */
    public static String sendPost(String url, String param) {
        PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("Accept-Charset", "UTF-8");
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            out = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
            out.print(param);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送 POST 请求出现异常！"+e);
            e.printStackTrace();
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                ex.printStackTrace();
            }
        }
        return result;
    }

    public static String ArapXML(String url, String strxml) {
        OutputStreamWriter wr = null;
        BufferedReader rd = null;
        String msg = "";
        try {
            URLConnection conn = getUrlConnection(url, "v6");
            wr = new OutputStreamWriter(conn.getOutputStream(),"UTF-8");
            wr.write(strxml);
            wr.flush();

            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line;
            StringBuffer response = new StringBuffer("");
            while ((line = rd.readLine()) != null) {
                response.append(line);
                response.append(System.getProperty("line.separator"));
            }
            if (response.length() == 0) {
                throw new Exception("未接收到返回数据!");
            }
            msg = response.toString();


        } catch (Exception e) {

            e.printStackTrace();
        }
        return msg;

    }

    //北京城建集团党校系统信息传送HTTP接口调用程序，获取HTTP连接
    private static URLConnection getUrlConnection(String oppurl, String ncVersion) throws Exception {
        if (ncVersion.startsWith("v6")) {
            return getConnection4v5(oppurl);
        }
        throw new Exception("链接失败!");
    }

    private static HttpURLConnection getConnection4v5(String url) throws Exception {
        try {
            URL realURL = new URL(url);
            HttpURLConnection connection = (HttpURLConnection) realURL.openConnection();
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-type", "text/xml");
            connection.setRequestMethod("POST");
            return connection;
        } catch (IOException ex) {
            ex.printStackTrace();
            throw new Exception("错误:" + ex.getMessage());
        }
    }

    public static String createSign(String secretKey, Map<String, String> params) {
        Map<String, String> signMap = new TreeMap<String, String>();
        signMap.putAll(params);
        StringBuffer buffer = new StringBuffer();

        for (Object name : signMap.keySet().toArray()) {
            if (buffer.length() != 0) {
                buffer.append("&");
            }
            buffer.append(name.toString()).append("=").append(StringUtils.trimToEmpty(signMap.get(name)));
        }
        buffer.append("&").append(secretKey);
        String sign = Md5.md5(buffer.toString());
        System.out.println("sign=" + sign);
        try {
            FileUtil.writeTxtFile(buffer.toString(), new File("c:\\jrbh.txt"));
        } catch (Exception exp) {

        }
        return sign;
    }

    private static Map<String, String> setBaseMap(Map<String, String> params) {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
        String time = format.format(new Date(System.currentTimeMillis()));
        params.put("created", time);
        params.put("access_key",MyConstants.getAccess_key());
        return params;
    }

    public static String httpRequest(Map<String, String> params) throws Exception {
        String responseBody = null;
        HttpClient httpclient = new DefaultHttpClient();
        httpclient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT,180000);
        httpclient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,300000);
        //setBaseMap(params);
        List<NameValuePair> formparams = new ArrayList<NameValuePair>();

        StringBuffer tbuf = new StringBuffer();
        for (Object name : params.keySet().toArray()) {
            formparams.add(new BasicNameValuePair((String) name, (String) params.get(name)));
        }
        formparams.add(new BasicNameValuePair("sign", createSign(MyConstants.getSecret_key(), params).toLowerCase()));

        System.out.println("传送的报文参数");
        for (int ii=0;ii<formparams.size();ii++) {
            NameValuePair nameValuePair = formparams.get(ii);
            System.out.println(nameValuePair.getName() +"="+nameValuePair.getValue());
        }
        System.out.println("报文参数结束");

        UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formparams, "UTF-8");
        HttpPost httppost = new HttpPost(MyConstants.getServiceUrl());
        httppost.setEntity(entity);
        HttpResponse response = httpclient.execute(httppost);
        HttpEntity entityResponse = response.getEntity();
        responseBody = EntityUtils.toString(entityResponse , "UTF-8");

        return responseBody;
    }

    public static void main(String[] args) {
        //发送 POST 请求
        String sr=Post.sendPost("http://localhost:6144/Home/RequestPostString", "key=123&v=456");
        System.out.println(sr);
    }
}
