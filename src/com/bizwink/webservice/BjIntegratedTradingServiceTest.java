package com.bizwink.webservice;

import com.bizwink.util.SpringContextUtil;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import java.net.URL;

public class BjIntegratedTradingServiceTest {
    //调用北京市公共资源综合交易系统的接口，推送开评标视频信息
    public String pushVideoMediaData (VideoRequest res) {

        return "abc";
    }

    //调用北京市公共资源综合交易系统的接口，推送专家签到信息
    public String expertCheckInInformation(String IDCard,String checkInTime,String entryTime,String taskBookId, String sysCode) {

        return "abc";
    }

    //调用北京市公共资源综合交易系统的接口，推送变更信息
    public String modifyVenueBook(String oldTaskBookId,String taskBookId,String roomName,String bookStartTime,String bookEndTime, String sysCode) {

        return "abc";
    }

    public String testOtherService(String infoflag,String taskBookID) throws Exception{
        String retmsg = null;
        String sysCode = "110102";
        //http://localhost:81/services/BjIntegratedTradingService?wsdl
        //测试环境
        String url = "http://localhost:81/services/BjIntegratedTradingService";
        //生产环境
        //String url = "http://xicheng.tysoft.com/Service/ComprehensiveServiceImpl";
        Service serv = new Service();
        Call call = (Call) serv.createCall();
        call.setTargetEndpointAddress(new URL(url));

        if (infoflag.equalsIgnoreCase("project")) {
            String projectInfo="{\"projectCode\":\"XC-ZFCG-2020-001\"," +
                    "\"projectName\":\"北京市金水河整理工程一期项目\"," +
                    "\"electronFlag\":\"Y\"," +
                    "\"isSecret\":\"N\"," +
                    "\"industry\":\"ZFCG\"," +
                    "\"industryType\":\"SG\"," +
                    "\"agentContactName\":\"张一平\"," +
                    "\"agentContactPhone\":\"13901361786\"," +
                    "\"ownerUnitName\":\"西城区建委\"," +
                    "\"ownerContactName\":\"何大东\"," +
                    "\"ownerContactPhone\":\"01084978654\"" +
                    "}";
            String bidInfo = "[" +
                    "{\"bidSectionCode\":\"B12221\",\"bidSectionNo\":\"B1233320\", \"bidSectionName\":\"清除淤泥标段\" }," +
                    "{\"bidSectionCode\":\"B12222\",\"bidSectionNo\":\"B1233321\", \"bidSectionName\":\"沿岸绿化标段\" }," +
                    "{\"bidSectionCode\":\"B12224\",\"bidSectionNo\":\"B1233323\", \"bidSectionName\":\"桥梁建设标段\" }," +
                    "{\"bidSectionCode\":\"B12225\",\"bidSectionNo\":\"B1233324\", \"bidSectionName\":\"河水清理标段\" }," +
                    "{\"bidSectionCode\":\"B12226\",\"bidSectionNo\":\"B1233325\", \"bidSectionName\":\"二号桥梁建设标段\" }," +
                    "{\"bidSectionCode\":\"B12227\",\"bidSectionNo\":\"B1233326\", \"bidSectionName\":\"三号桥梁建设标段\" }," +
                    "{\"bidSectionCode\":\"B12228\",\"bidSectionNo\":\"B1233327\", \"bidSectionName\":\"四号桥梁建设标段\" }" +
                    "]";
            String syncType = "2";
            //本地测试环境
            call.setOperationName(new QName("BjIntegratedTradingService", "projectInfoSync"));
            //生产环境
            //call.setOperationName(new QName("ComprehensiveServiceImplService", "projectInfoSync"));
            call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_STRING);
            call.addParameter("projectInfo", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("bidInfo", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("syncType", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("sysCode", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            retmsg = (String) call.invoke(new Object[]{projectInfo, bidInfo, syncType, sysCode});
            System.out.println(retmsg);
        } else if (infoflag.equalsIgnoreCase("export")) {
            String exportInfos = "[{\"expertName\":\"张三\",\"passportNo\":\"110101201904234191\" , \"expertCode\":\"10000110\",\"telephone\":\"0371-8376464646\"}," +
                    "{\"expertName\":\"李四\",\"passportNo\":\"110101201904239814\" , \"expertCode\":\"10000101\",\"telephone\":\"0371-8376464646\"}" +
                    "]";
            //本地测试环境
            call.setOperationName(new QName("BjIntegratedTradingService", "receiveExpertList"));
            //生产环境
            //call.setOperationName(new QName("ComprehensiveServiceImplService", "projectInfoSync"));
            call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_STRING);
            call.addParameter("taskBookId", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("exportInfo", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("sysCode", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            retmsg = (String) call.invoke(new Object[]{taskBookID, exportInfos,sysCode});
            System.out.println(retmsg);
        } else if (infoflag.equalsIgnoreCase("bidder")) {
            String bidderInfos = "[{\"projectCode\":\"XC-ZFCG-2020-001\",bidInfo:[\n" +
                    "{\"bidSectionCode\":\"B12221\", bidderInfo: [{\"bidderName\":\"北京大中第一公司\",\"contackName\":\"张大中\" , \"bidderCode\":\"99901234567ZX\",\"contackMobile\":\"010-83762345\"},\n" +
                    "{\"bidderName\":\"北京大路集团公司\",\"contackName\":\"王大路\" , \"bidderCode\":\"9999999234XZ\",\"contackMobile\":\"010-64633712\"}\n" +
                    "]},\n" +
                    "\n" +
                    "{\"bidSectionCode\":\"B12222\", bidderInfo: [{\"bidderName\":\"北京东海科技有限公司\",\"contackName\":\"李海东\" , \"bidderCode\":\"9111022876352681XR\",\"contackMobile\":\"13901346789\"},\n" +
                    "{\"bidderName\":\"北京尚德利科技有限公司\",\"contackName\":\"王德利\" , \"bidderCode\":\"9222022876352681XR\",\"contackMobile\":\"010-67891234\"}\n" +
                    "]}]\n" +
                    "} ,{\"projectCode\":\"XC-ZFCG-2020-100\",\n" +
                    "\tbidderInfo: [\n" +
                    "{\"bidderName\":\"北京中环科技有限公司\",\"contackName\":\"李海\" , \"bidderCode\":\"9333022876352681XR\",\"contackMobile\":\"13802345432\"},\n" +
                    "{\"bidderName\":\"首都北海科技有限公司\",\"contackName\":\"王四海\" , \"bidderCode\":\"9444022876352681XR\",\"contackMobile\":\"13913801234\"}\n" +
                    "]\n" +
                    " }]";
            //本地测试环境
            call.setOperationName(new QName("BjIntegratedTradingService", "receiveBidderList"));
            //生产环境
            //call.setOperationName(new QName("ComprehensiveServiceImplService", "projectInfoSync"));
            call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_STRING);
            call.addParameter("taskBookId", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("bidderInfos", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("sysCode", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            retmsg = (String) call.invoke(new Object[]{taskBookID, bidderInfos,sysCode});
            System.out.println(retmsg);
        } else if (infoflag.equalsIgnoreCase("submitBook")) {
            String projectInfo = "[{\"projectCode\":\"XM-ZFCG-2020-200\",bidInfo:[\n" +
                    "{\"bidSectionCode\":\"B32221\",\"bidSectionNo\":\"B3222333\", \"bidSectionName\":\"清除淤泥标段\" },\n" +
                    "{\"bidSectionCode\":\"B32223\",\"bidSectionNo\":\"B3233335\", \"bidSectionName\":\"河岸公园建设标段\" },\n" +
                    "{\"bidSectionCode\":\"B32224\",\"bidSectionNo\":\"B3233336\", \"bidSectionName\":\"桥梁1建设标段\" },\n" +
                    "{\"bidSectionCode\":\"B32225\",\"bidSectionNo\":\"B3233337\", \"bidSectionName\":\"桥梁2建设标段\" },\n" +
                    "{\"bidSectionCode\":\"B32226\",\"bidSectionNo\":\"B3233338\", \"bidSectionName\":\"桥梁3建设标段\" },\n" +
                    "{\"bidSectionCode\":\"B32227\",\"bidSectionNo\":\"B3233339\", \"bidSectionName\":\"桥梁4建设标段\" }]}]\n";
            String roomType = "KB";
            String venueType = "KB_VT";
            String personNum = "10";
            String beginTime = "9:30";
            String endTime = "11:30";
            String bookDate = "20200225";
            String isForce = "N";
            //本地测试环境
            call.setOperationName(new QName("BjIntegratedTradingService", "submitBook"));
            //生产环境
            //call.setOperationName(new QName("ComprehensiveServiceImplService", "projectInfoSync"));
            call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_STRING);
            call.addParameter("projectInfo", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("roomType", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("venueType", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("personNum", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("beginTime", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("endTime", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("bookDate", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("isForce", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            call.addParameter("sysCode", XMLType.XSD_ANYTYPE, ParameterMode.IN);
            retmsg = (String) call.invoke(new Object[]{projectInfo, roomType,venueType,personNum,beginTime,endTime,bookDate,isForce,sysCode});
            System.out.println(retmsg);
        }

        return retmsg;
    }

    public static void main(String[] args) throws Exception {
        //初始化Spring上下文环境
        ApplicationContext appContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        SpringContextUtil.setValue(appContext);
        BjIntegratedTradingServiceTest bjIntegratedTradingServiceTest = new BjIntegratedTradingServiceTest();
        //bjIntegratedTradingServiceTest.testOtherService("project",null);
        //bjIntegratedTradingServiceTest.testOtherService("export","export1936218973");
        //bjIntegratedTradingServiceTest.testOtherService("bidder","export1936218973");
        bjIntegratedTradingServiceTest.testOtherService("submitBook",null);
    }
}
