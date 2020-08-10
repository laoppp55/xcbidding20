package com.bizwink.webservice;

import com.bizwink.cms.entity.UserCaInfo;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

public class CALogin {
    public String addUserInformation(UserCaInfo userCaInfo) {
        String ws_address = "http://106.38.57.117:18080/user-ca-info-service?wsdl";
        try {
            // 直接引用远程的wsdl文件
            // 以下都是套路
            Service service = new Service();
            Call call = (Call) service.createCall();
            call.setTargetEndpointAddress(ws_address);
            call.setOperationName("addUser");// WSDL里面描述的接口名称
            call.addParameter("userName", org.apache.axis.encoding.XMLType.XSD_DATE, javax.xml.rpc.ParameterMode.IN);// 接口的参数
            call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);// 设置返回类型
            String temp = "测试人员";
            String result = (String) call.invoke(new Object[] { temp });
            // 给方法传递参数，并且调用方法
            System.out.println("result is " + result);
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return null;
    }

    public String checkCert(String platformCode, String certSN, String source, String certInfo) {
        String ws_address = "http://106.38.57.117:18080/check-cert-valid-service?wsdl";
        try {
            // 直接引用远程的wsdl文件
            // 以下都是套路
            Service service = new Service();
            Call call = (Call) service.createCall();
            call.setTargetEndpointAddress(ws_address);
            call.setOperationName("addUser");// WSDL里面描述的接口名称
            call.addParameter("userName", org.apache.axis.encoding.XMLType.XSD_DATE, javax.xml.rpc.ParameterMode.IN);// 接口的参数
            call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);// 设置返回类型
            String temp = "测试人员";
            String result = (String) call.invoke(new Object[] { temp });
            // 给方法传递参数，并且调用方法
            System.out.println("result is " + result);
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return null;
    }

    public String shareUserCaInfo(String certNum,String snKey,String platformCode) {
        String ws_address = "http://106.38.57.117:18080/user-ca-info-service?wsdl";
        try {
            // 直接引用远程的wsdl文件
            // 以下都是套路
            Service service = new Service();
            Call call = (Call) service.createCall();
            call.setTargetEndpointAddress(ws_address);
            call.setOperationName("addUser");// WSDL里面描述的接口名称
            call.addParameter("userName", org.apache.axis.encoding.XMLType.XSD_DATE, javax.xml.rpc.ParameterMode.IN);// 接口的参数
            call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);// 设置返回类型
            String temp = "测试人员";
            String result = (String) call.invoke(new Object[] { temp });
            // 给方法传递参数，并且调用方法
            System.out.println("result is " + result);
        } catch (Exception e) {
            System.err.println(e.toString());
        }
        return null;
    }
}
