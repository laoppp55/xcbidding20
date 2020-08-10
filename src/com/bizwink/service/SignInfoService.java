package com.bizwink.service;

import com.bizwink.net.http.Post;
import com.bizwink.persistence.*;
import com.bizwink.po.SignInfo;
import com.bizwink.po.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class SignInfoService {
    @Autowired
    private SignInfoMapper signInfoMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ArticleClassMapper articleClassMapper;

    @Autowired
    private ArticleExtendattrMapper articleExtendattrMapper;

    public int SaveSigninfo(SignInfo signInfo) {
        return signInfoMapper.insert(signInfo);
    }

    //uid：签到用户的ID
    //projcode：培训项目编码
    //signdate：签到日期
    //timeFlag：签到时间段，0表示上午签到，1表示下午签到
    //该方法用于判断用户是否已经完成过签到，true表示已经签过到，false表示未签到
    public boolean CheckSigninfo(BigDecimal uid, String projcode, String startSignTime, String endSignTime, String noonTime, String signtime, int timeFlag) {
        Map params = new HashMap<String,Object>();
        params.put("uid",uid);
        params.put("projcode",projcode);
        params.put("signtime",signtime);
        params.put("timeFlag",timeFlag);
        params.put("startsigntime",startSignTime);
        params.put("endsigntime",endSignTime);
        params.put("noontime",noonTime);
        BigDecimal existSigninfoFlag = signInfoMapper.checkSigninfo(params);
        if (existSigninfoFlag.intValue() > 0)
            return true;
        else
            return false;
    }

    public void sendSignInfo() {
        // TODO 自动生成的方法存根
        String url = "http://i.bucg.com:80/service/XChangeServlet?account=0001&groupcode=0001";
        Calendar today_cal = Calendar.getInstance();
        today_cal.setTimeInMillis(System.currentTimeMillis());
        List<SignInfo> signInfos = signInfoMapper.getSignInfosForCurrentDay(today_cal.get(Calendar.YEAR) + "-" + (today_cal.get(Calendar.MONTH)+1) + "-" + today_cal.get(Calendar.DAY_OF_MONTH));
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        for(int ii=0;ii<signInfos.size();ii++) {
            SignInfo signInfo = signInfos.get(ii);
            Users user = usersMapper.selectByUid(signInfo.getUSERID());
            //设置签到的时间
            Calendar sign_cal = Calendar.getInstance();
            sign_cal.setTimeInMillis(signInfo.getSIGNTIME().getTime());
            //设置中午的时间
            Calendar noon_cal = Calendar.getInstance();
            noon_cal.setTimeInMillis(System.currentTimeMillis());
            noon_cal.set(Calendar.HOUR,12);
            noon_cal.set(Calendar.MINUTE,0);
            noon_cal.set(Calendar.SECOND,0);

            String AMFlag = "N";
            String PMFlag = "N";
            if (sign_cal.before(noon_cal))
                AMFlag = "Y";
            else
                PMFlag = "Y";

            String strxml = "<?xml version=\"1.0\" encoding='UTF-8'?>" +
                    "<ufinterface account=\"0001\" billtype=\"HM26\" filename=\"\" groupcode=\"0001\" isexchange=\"Y\" replace=\"Y\" roottag=\"\" sender=\"cjpxmng\">" +
                    "    <bill id=\"\">" +
                    "        <billhead>" +
                    "            <pk_group>0001</pk_group>" +
                    "            <dbilldate>" + simpleDateFormat.format(signInfo.getSIGNTIME()) + "</dbilldate>" +
                    "            <vbillstatus>0</vbillstatus>" +
                    "            <pk_billtype>HM26</pk_billtype>" +
                    "            <creator>zhanghao</creator>" +
                    "            <creationtime>" + simpleDateFormat.format(signInfo.getCREATEDATE()) + "</creationtime>" +
                    "            <pk_tranpro>HM132019121100000001</pk_tranpro>" +
                    "            <pk_classset_b>1001</pk_classset_b>" +
                    "            <pk_workunit>" + user.getCOMPANY() + "</pk_workunit>" +
                    "            <pk_tranpsn>" + user.getNICKNAME() + "</pk_tranpsn>" +
                    "            <cardid>" + user.getIDCARD() + "</cardid>" +
                    "            <dcheckindate>" + simpleDateFormat.format(signInfo.getSIGNTIME()) + "</dcheckindate>" +
                    "            <checkinam>" + AMFlag + "</checkinam>" +
                    "            <checkinpm>" + PMFlag + "</checkinpm>" +
                    "            <memo>备注</memo>" +
                    "            <def1>add</def1>" +
                    "            <def2>MH20191030</def2>" +
                    "        </billhead>" +
                    "    </bill>" +
                    "</ufinterface>";


            System.out.println(strxml);
            String returnxml = Post.ArapXML(url, strxml);
            System.out.println(returnxml);
        }
    }

    public void sendEnrollInfo() {
        String url = "http://i.bucg.com:80/service/XChangeServlet?account=0001&groupcode=0001";
        String strxml = "<?xml version=\"1.0\" encoding='UTF-8'?>" +
                "<ufinterface account=\"0001\" billtype=\"HM24\" filename=\"\" groupcode=\"0001\" isexchange=\"Y\" replace=\"Y\" roottag=\"\" sender=\"cjpxmng\">" +
                "    <bill id=\"MH20191030\">" +
                "        <billhead>" +
                "            <pk_group>0001</pk_group>" +
                "            <pk_billtype>HM24</pk_billtype>" +
                "            <dbilldate>2019-10-28 09:00:26</dbilldate>" +
                "            <vbillstatus>-1</vbillstatus>" +
                "            <creator>zhanghao</creator>" +
                "            <creationtime>2019-10-30 09:31:28</creationtime>" +
                "            <pk_tranpro>HM132019121100000001</pk_tranpro>" +
                "            <pk_sepecial>1001</pk_sepecial>" +
                "            <sigtype>1</sigtype>" +
                "            <stuname>张三</stuname>" +
                "            <stucardid>110105196609308153</stucardid>" +
                "            <stusex>1</stusex>" +
                "            <stunation>汉族</stunation>" +
                "            <dstubirthday>2019-10-28 09:00:26</dstubirthday>" +
                "            <polstatus>a</polstatus>" +
                "            <stuedu>a</stuedu>" +
                "            <jobtitle>a</jobtitle>" +
                "            <curpost>a</curpost>" +
                "            <telphone>a</telphone>" +
                "            <wbunit>城建勘测院</wbunit>" +
                "            <ntotalfee>1000</ntotalfee>" +
                "            <def1>del</def1>" +
                "            <def2>MH20191030</def2>" +
                "            <bodymx>" +
                "                <item>" +
                "                    <pk_classs>1001</pk_classs>" +
                "                    <classname>测试课程</classname>" +
                "                    <dclasshour>1</dclasshour>" +
                "                    <dclassfee>1000</dclassfee>" +
                "                </item>" +
                "            </bodymx>" +
                "        </billhead>" +
                "    </bill>" +
                "</ufinterface>";

        String returnxml = Post.ArapXML(url, strxml);
        System.out.println(returnxml);
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
        ApplicationContext ctx=null;
        ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
        SignInfoService signInfoService = (SignInfoService)ctx.getBean("signInfoService");
        signInfoService.sendSignInfo();

        //SignInfoService signInfoService = new SignInfoService();
        //signInfoService.sendSignInfo();
        //signInfoService.sendEnrollInfo();
    }

}
