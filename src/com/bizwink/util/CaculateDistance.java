package com.bizwink.util;

import com.alibaba.fastjson.JSONObject;
import org.gavaghan.geodesy.Ellipsoid;
import org.gavaghan.geodesy.GeodeticCalculator;
import org.gavaghan.geodesy.GeodeticCurve;
import org.gavaghan.geodesy.GlobalCoordinates;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class CaculateDistance {
    public static void main(String[] args)
    {
        String jw[] = getCoordinate("北苑大酒店");
        System.out.println(jw[0] + "==" + jw[1]);
        GlobalCoordinates source = new GlobalCoordinates(29.615295, 106.581654);
        GlobalCoordinates target = new GlobalCoordinates(Double.parseDouble(jw[0]), Double.parseDouble(jw[1]));

        double meter1 = getDistanceMeter(source, target, Ellipsoid.Sphere);
        double meter2 = getDistanceMeter(source, target, Ellipsoid.WGS84);

        System.out.println("Sphere坐标系计算结果："+meter1 + "米");
        System.out.println("WGS84坐标系计算结果："+meter2 + "米");
    }

    public static double getDistanceMeter(GlobalCoordinates gpsFrom, GlobalCoordinates gpsTo, Ellipsoid ellipsoid)
    {
        //创建GeodeticCalculator，调用计算方法，传入坐标系、经纬度用于计算距离
        GeodeticCurve geoCurve = new GeodeticCalculator().calculateGeodeticCurve(ellipsoid, gpsFrom, gpsTo);

        return geoCurve.getEllipsoidalDistance();
    }

    /**
     * @param addr
     * 查询的地址
     * @return
     * @throws IOException
     */
    public static String[] getCoordinate(String addr) {
        String lng = null;//经度
        String lat = null;//纬度
        String address = null;
        try {
            address = java.net.URLEncoder.encode(addr, "UTF-8");
        }catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        System.out.println(address);
        String url = "http://api.map.baidu.com/geocoder/v2/?output=json&ak=DKcHydRZwnyBvf6PGdkra2xrWE6o4lPU&address="+address;
        URL myURL = null;

        URLConnection httpsConn = null;
        try {
            myURL = new URL(url);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        InputStreamReader insr = null;
        BufferedReader br = null;
        try {
            httpsConn = (URLConnection) myURL.openConnection();
            if (httpsConn != null) {
                insr = new InputStreamReader( httpsConn.getInputStream(), "UTF-8");
                br = new BufferedReader(insr);
                String data = null;
                while((data= br.readLine())!=null){
                    System.out.println("baidu return:"+data);
                    JSONObject json = JSONObject.parseObject(data);
                    if (json.getJSONObject("result")!=null) {
                        lng = json.getJSONObject("result").getJSONObject("location").getString("lng");
                        lat = json.getJSONObject("result").getJSONObject("location").getString("lat");
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (insr != null) {
                    insr.close();
                }
                if (br != null) {
                    br.close();
                }
            } catch (IOException exp) {

            }
        }
        return new String[]{lng,lat};
    }

    public static String[] getAddr(String lng,String lat) throws IOException {
        System.out.println("lng==" + lng);
        System.out.println("lat==" + lat);

        String url = "http://api.map.baidu.com/geocoder/v2/?output=json&ak=lA1OUxeHEBISZVGtj2k0hP16&location="+lat+","+lng;
        URL myURL = null;
        String city = "";
        String qx = "";
        URLConnection httpsConn = null;
        try {
            myURL = new URL(url);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        InputStreamReader insr = null;
        BufferedReader br = null;
        try {
            httpsConn = (URLConnection) myURL.openConnection();// 不使用代理
            if (httpsConn != null) {
                insr = new InputStreamReader( httpsConn.getInputStream(), "UTF-8");
                br = new BufferedReader(insr);
                String data = null;
                while((data= br.readLine())!=null){
                    System.out.println("data=="+data);
                    if (data!=null) {
                        JSONObject json = JSONObject.parseObject(data);
                        city = json.getJSONObject("result").getJSONObject("addressComponent").getString("city");
                        qx = json.getJSONObject("result").getJSONObject("addressComponent").getString("district");
                        System.out.println("city==" + city);
                        System.out.println("qx==" + qx);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if(insr!=null){
                insr.close();
            }
            if(br!=null){
                br.close();
            }
        }
        return new String[]{city,qx};
    }

}
