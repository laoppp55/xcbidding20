package com.bizwink.webservice;

import com.bizwink.webservice.show1.DataMain;
import com.bizwink.webservice.show2.DataMain2;
import com.google.gson.Gson;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;


public class ICjPxmhService {

    //报名课程设置
    public String AddClasssetDate(String addjson,String method){
        Map<String, Object> map = new HashMap<String, Object>();
        String resultstr="success";

        map.put("status",resultstr);
        Gson gson = new Gson();
        String resultJson = gson.toJson(map,LinkedHashMap.class);
        return resultJson;
    }

    //培训项目库
    public String AddTranproDate(String addjson,String method){
        System.out.printf("AddTranproDate");
        DataMain dataMain = new   DataMain();
        return dataMain.AddTranproDate(addjson);
    }

    //学员统一报名
    public String  AddSigupDate(String addjson,String method){
        System.out.printf("AddSigupDate");
        //解密

      //  Map<String, Object> map = new HashMap<String, Object>();
      //  String resultstr="success";
        DataMain2 dataMain2 = new   DataMain2();
        return dataMain2.insertOrders(addjson);
     //   map.put("status",resultstr);
     //   Gson gson = new Gson();
     //   String resultJson = gson.toJson(map,LinkedHashMap.class);
     //   return resultJson;
    }

}
