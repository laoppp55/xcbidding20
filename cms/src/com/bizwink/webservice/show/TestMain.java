package com.bizwink.webservice.show;

import com.alibaba.fastjson.JSON;

import java.util.List;

public class TestMain {

    public static void main(String[] args){
        String jsonStr ="{\n" +
                " \"srcsystem\": \"MH\",\n" +
                " \"busidate\": \"2019-09-17 09:00:52\",\n" +
              " \"data\": [{\n" +
                "  \"pk_tranprotype\": \"0102\",\n" +
                "  \"classsetbodys\": [{\n" +
                "   \"pk_special\": \"1002\",\n" +
                "   \"pk_class\": \"1003\",\n" +
                "   \"dclasshour\": 1.0,\n" +
                "   \"dclassfee\": 2.0\n" +
                "  }, {\n" +
                "   \"pk_special\": \"1001\",\n" +
                "   \"pk_class\": \"1004\",\n" +
                "   \"dclasshour\": 1.0,\n" +
                "   \"dclassfee\": 2.0\n" +
                "  }],\n" +
                "  \"specialbodys\": [{\n" +
                "   \"pk_special\": \"1001\"\n" +
                "  }, {\n" +
                "   \"pk_special\": \"1002\"\n" +
                "  }]\n" +
                " }]\n" +
                "}";

        FirstLevelData td =  JSON.parseObject(jsonStr, FirstLevelData.class);
        List<DataObject> data = td.getData();
        for(DataObject curData : data){
            System.out.println("培训项目分类编码:"+curData.getPk_tranprotype());
            List<ClasssetbodysData> classsetbodysDataList = curData.getClasssetbodys();
            for(ClasssetbodysData classsetbodysData : classsetbodysDataList){
                System.out.println("专业编码："+ classsetbodysData.getPk_special());
                System.out.println("课程编码："+ classsetbodysData.getPk_class());
                System.out.println("课时："+classsetbodysData.getDclasshour());
                System.out.println("学费："+classsetbodysData.getDclassfee());
            }
            List<SpecialbodysData> specialbodysDataList=curData.getSpecialbodys();
            for(SpecialbodysData specialbodysData:specialbodysDataList){
                System.out.println("专业编码："+specialbodysData.getPk_special());
            }
        }


    }
}
