package com.bizwink.webservice.show2;

import com.alibaba.fastjson.JSON;
import com.bizwink.cms.server.FileProps;
import com.bizwink.util.Encrypt;
import com.google.gson.Gson;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DataMain2 {

    public  static  String insertOrders(String jsonStr){
        Map<String, Object> map = new HashMap<String, Object>();
        String resultstr="success";
        Connection conn = null;
        PreparedStatement pstmt;
        PreparedStatement pstmt1;
        ResultSet rs1;
        ResultSet rs;
        String dirname = "";
        try{
                try {
                    //Class.forName("weblogic.jdbc.mssqlserver4.Driver");
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                } catch (ClassNotFoundException e) {
                    System.out.println("数据库连接异常");
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                }

            FileProps props = new FileProps("com/bizwink/cms/server/config.properties");
          //  FileProps props = new FileProps("/data/bucgdx/cms/WEB-INF/classes/com/bizwink/cms/server/config.properties");
            String url = props.getProperty("main.db.url");
            String UserName = props.getProperty("main.db.username");
            String Password = props.getProperty("main.db.password");
            conn = DriverManager.getConnection(url, UserName, Password);

            System.out.println("Connection Successful!");
            conn.setAutoCommit(false);

            JsonData2 jsonData = JSON.parseObject(jsonStr, JsonData2.class);
            String busidate = jsonData.getBusidate();
            List<DataObj2> data = jsonData.getData();
            for(DataObj2 curData: data) {

                //判断用户是否存在
                //int idcard = 0;
                int userid = 0;
                pstmt1 = conn.prepareStatement("select id from TBL_MEMBERS t where t.idcard=?");
                pstmt1.setString(1, curData.getStucardid());
                rs1 = pstmt1.executeQuery();
                if (rs1.next()) userid = rs1.getInt("id");
                rs1.close();
                pstmt1.close();


                if (userid > 0) { //用户存在
                    System.out.println("用户存在");
                } else {          //用户不存在，注册该用户
                    System.out.println("注册用户");
                    pstmt1 = conn.prepareStatement("select TBL_USERINFOS_ID.NEXTVAL from dual");//Oracle 获取自增序列
                    rs1 = pstmt1.executeQuery();
                    if (rs1.next()) userid = rs1.getInt(1);
                    rs1.close();
                    pstmt1.close();


                    pstmt = conn.prepareStatement("insert into TBL_MEMBERS (USERID,ID, SITEID, USERPWD,NICKNAME, EMAIL, MPHONE,PHONE, SEX, USERTYPE,\n" +
                            "        CREATEDATE, COMPANY, DEPARTMENT,\n" +
                            "        CREATERID,DUTY,IDCARD,STUEDU,POLSTATUS,TEXTPWD)\n" +
                            "        values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

                    System.out.println(userid);
                    pstmt.setString(1, curData.getStucardid()); //将身份证号存入userid
                    pstmt.setInt(2, userid);  //注册用户表中的唯一标识
                    pstmt.setInt(3, 59);
                    pstmt.setString(4, Encrypt.md5("123456".getBytes()));
                    pstmt.setString(5, curData.getStuname());
                    pstmt.setString(6, "");
                    pstmt.setString(7, curData.getTelphone());
                    pstmt.setString(8, curData.getTelphone());
                    pstmt.setInt(9, curData.getStusex());
                    pstmt.setInt(10, 5);
                    pstmt.setTimestamp(11, new Timestamp(System.currentTimeMillis()));
                    pstmt.setString(12, curData.getWbunit());
                    pstmt.setString(13, "");
                    pstmt.setInt(14, 0);
                    pstmt.setString(15, curData.getCurpost());
                    pstmt.setString(16, curData.getStucardid());
                    pstmt.setString(17, curData.getStuedu());
                    pstmt.setString(18, curData.getPolstatus());
                    pstmt.setString(19, "123456");

                    pstmt.executeUpdate();
                    pstmt.close();
                }

                //入订单表
                int ArticleId = 0; //文章ID
                String projcode = ""; //获取本库项目编码
                int columnID = 0;
                //  pstmt1 = conn.prepareStatement("select * from TBL_ARTICLE t where t.billno = 'PXXM20190829001'");
                pstmt1 = conn.prepareStatement("select  t.id,t.columnid,t.maintitle,t.pk_tranprotype projcode from TBL_ARTICLE t where t.billno = ?");
                pstmt1.setString(1, curData.getPk_tranpro());
                rs1 = pstmt1.executeQuery();
                while (rs1.next()) {
                    projcode = rs1.getString("projcode");
                    ArticleId = rs1.getInt("id");
                    columnID = rs1.getInt("columnid");
                }
                rs1.close();
                pstmt1.close();
                //System.out.println("projcode="+projcode);
               /* String pk_tranprotype = projcode;
                int columnID = 0;
                if(pk_tranprotype.equals("101")) //一级注册建造师
                    columnID=78;
                if(pk_tranprotype.equals("102")) //二级注册建造师
                    columnID=79;
                if(pk_tranprotype.equals("103")) //一级注册造价师
                    columnID=80;
                if(pk_tranprotype.equals("104")) //二级注册造价师
                    columnID=81;
                if(pk_tranprotype.equals("105")) //现场管理人员
                    columnID=76;
                if(pk_tranprotype.equals("106")) //操作人员
                    columnID=77;
                if(pk_tranprotype.equals("107")) //安全三类
                    columnID=75;
                if(pk_tranprotype.equals("108")) //其他
                    columnID=82;*/
                int INITORDERID = 0;

                //String PKSIGUP="";
                int orderid = 0;
                pstmt1 = conn.prepareStatement("select id from TBL_ORDERS t where t.PKSIGUP=?");
                pstmt1.setString(1, curData.getPksigup());
                rs1 = pstmt1.executeQuery();
                if (rs1.next()) orderid = rs1.getInt("id");
                rs1.close();
                pstmt1.close();
                if (orderid > 0) {
                    System.out.println("订单已存在");
                    resultstr = "error";
                    map.put("errMessage", "数据已存在，请勿重复提交");

                } else {


                    pstmt = conn.prepareStatement("insert into TBL_ORDERS (ORDERID, USERID, NAME, \n" +
                            "      SEX,  \n" +
                            "      PHONE, TOTALFEE, \n" +
                            "      PAYFEE, CREATEDATE, \n" +
                            "      SITEID, STATUS, \n" +
                            "      INITORDERID，PROJCLASSID,PROJCODE,PROJNAME,TRAINUNIT,PROJARTID,MAJORCODE,ID，PKSIGUP)\n" +
                            "    values (?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?)");


                    pstmt1 = conn.prepareStatement("select TBL_ORDERS_DETAIL_ID.NEXTVAL from dual");//Oracle 获取自增序列
                    rs1 = pstmt1.executeQuery();
                    if (rs1.next()) orderid = rs1.getInt(1);
                    rs1.close();
                    pstmt1.close();

                    pstmt.setInt(1, orderid);
                    pstmt.setInt(2, userid);
                    pstmt.setString(3, curData.getStuname());
                    pstmt.setInt(4, curData.getStusex());
                    pstmt.setString(5, curData.getTelphone());
                    pstmt.setFloat(6, Float.valueOf(curData.getNtotalfee()));
                    pstmt.setFloat(7, Float.valueOf(curData.getNtotalfee()));
                    pstmt.setTimestamp(8, Timestamp.valueOf(busidate));
                    pstmt.setInt(9, 59);
                    pstmt.setInt(10, 1);
                    pstmt.setInt(11, INITORDERID); //原始订单ID
                    pstmt.setInt(12, columnID); //栏目ID
                    pstmt.setString(13, projcode); //项目编码
                    String maintitle = "";
                    pstmt1 = conn.prepareStatement("select t.maintitle from tbl_article t where t.id=?");
                    pstmt1.setInt(1, ArticleId);
                    rs1 = pstmt1.executeQuery();
                    if (rs1.next()) maintitle = rs1.getString("maintitle");
                    rs1.close();
                    pstmt1.close();

                    pstmt.setString(14, maintitle); //项目名称
                    pstmt.setString(15, ""); //培训单位
                    pstmt.setInt(16, ArticleId);
                    pstmt.setString(17, curData.getPk_sepecial());//专业编码
                    pstmt.setInt(18, orderid);
                    pstmt.setString(19,curData.getPksigup());
                    pstmt.executeUpdate();
                    pstmt.close();


                    System.out.println("培训项目编码：" + curData.getPk_tranpro());
                    System.out.println("培训专业编码：" + curData.getPk_sepecial());
                    System.out.println("姓名：" + curData.getStuname());
                    System.out.println("身份证号：" + curData.getStucardid());
                    System.out.println("政治面貌：" + curData.getPolstatus());
                    System.out.println("学历：" + curData.getStuedu());
                    System.out.println("职称：" + curData.getJobtitle());
                    System.out.println("手机号：" + curData.getTelphone());
                    System.out.println("单位：" + curData.getWbunit());
                    System.out.println("费用：" + curData.getNtotalfee());

                    List<SignupbodysData> signupbodysDataList = curData.getSignupbodys();
                    for (SignupbodysData signupbodysData : signupbodysDataList) {
                        pstmt = conn.prepareStatement("insert into TBL_ORDERS_DETAIL (ID, ORDERID, PRODUCTID, PRODUCTNAME, PRODUCTCODE, SALEPRICE, CREATEDATE,CLASSHOUR)\n" +
                                "    values (?,?, ?, ?,?, ?, ?,?)");
                        int id = 0;
                        pstmt1 = conn.prepareStatement("select TBL_ORDERS_DETAIL_ID.NEXTVAL from dual");//Oracle 获取自增序列
                        rs1 = pstmt1.executeQuery();
                        if (rs1.next()) id = rs1.getInt(1);
                        rs1.close();
                        pstmt1.close();

                        pstmt.setInt(1, id);
                        pstmt.setInt(2, orderid);

                   /* int PRODUCTID=0;
                    pstmt1 = conn.prepareStatement("select TBL_ORDERS_DETAIL_ID.NEXTVAL from dual");//Oracle 获取自增序列
                    rs1 = pstmt1.executeQuery();
                    if (rs1.next())  id= rs1.getInt(1);
                    rs1.close();
                    pstmt1.close();*/

                        pstmt.setInt(3, 0);
                        String classname = "";
                        pstmt1 = conn.prepareStatement("select t.classname from TBL_TRAININGCLASS t where t.classcode=?");
                        pstmt1.setString(1, signupbodysData.getPk_classs());
                        rs1 = pstmt1.executeQuery();
                        if (rs1.next()) classname = rs1.getString("classname");
                        rs1.close();
                        pstmt1.close();
                        pstmt.setString(4, classname);
                        pstmt.setString(5, signupbodysData.getPk_classs());
                        pstmt.setFloat(6, Float.valueOf(signupbodysData.getDclassfee()));
                        pstmt.setTimestamp(7, Timestamp.valueOf(busidate));
                        pstmt.setString(8, signupbodysData.getDclasshour());
                        pstmt.executeUpdate();
                        pstmt.close();


                      //  System.out.println("课程编码：" + signupbodysData.getPk_classs());
                      //  System.out.println("课时：" + signupbodysData.getDclasshour());
                      //  System.out.println("学费：" + signupbodysData.getDclassfee());
                    }
                }
            }
            conn.commit();
        }catch (SQLException e){
            System.out.println("i = 异常" + e);
             resultstr = "error";
             map.put("errMessage", "入库失败,请联系管理员");
             e.printStackTrace();
            //resultstr = "error";
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            if(conn!=null){
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    resultstr = "error";
                }
            }
        }
        map.put("status",resultstr);
        Gson gson = new Gson();
        String resultJson = gson.toJson(map,LinkedHashMap.class);
        return resultJson;
    }



    public static void main(String[] args) {
        String jsonStr = "{\"srcsystem\": \"NC\",\n" +
                "\"busidate\": \"2019-08-26 13:57:33\",\n" +
                "\"data\": [{" +
                "\"pk_tranpro\": \"PXXM20190829001\"," +
                "\"pk_sepecial\": \"0101001\",\n" +
                "\"sigtype\": \"0\",\n" +
                "\"stuname\": \"李四\",\n" +
                "\"stucardid\":\"010089198702130321\",\n" +
                "\"polstatus\": \"团员\",\n" +
                "\"stuedu\": \"本科\",\n" +
                "\"jobtitle\": \"员工\"," +
                "\"telphone\": \"18911588967\"," +
                "\"wbunit\": \"城建集团\",\n" +
                "\"ntotalfee\": 3000.0,\n" +
                "\"signupbodys\": [{\n" +
                "\"pk_classs\": \"1001001\",\n" +
                "\"dclasshour\": 2.0,\n" +
                "\"dclassfee\": 1000.0\n" +
                "}, " +
                "{\n" +
                "\"pk_classs\": \"1001002\",\n" +
                "\"dclasshour\": 2.0,\n" +
                "\"dclassfee\": 2000.0 }]}, " +
                "{\n" +
                "\"pk_tranpro\": \"XM201908260001\",\n" +
                "\"pk_sepecial\": \n" +
                "\"0101002\",\n" +
                "\"sigtype\": \"0\"," +
                "\"stuname\": \"张三\",\n" +
                "\"stucardid\": \"010089198602130651\",\n" +
                "\"polstatus\": \"团员\",\n" +
                "\"stuedu\": \"本科\"," +
                "\"jobtitle\": \"员工\"," +
                "\"telphone\": \"18911588969\",\n" +
                "\"wbunit\": \"城建集团\", " +
                "\"ntotalfee\": 5000.0," +
                "\"signupbodys\":" +
                " [" +
                "{" +
                "\"pk_classs\": \"1001003\",\n" +
                " \"dclasshour\": 1.0," +
                "\"dclassfee\": 1000.0 " +
                "}, " +
                "{" +
                "\"pk_classs\": \"1001004\"," +
                "\"dclasshour\": 2.0, " +
                "\"dclassfee\": 2000.0}," +
                " {\n" +
                "\"pk_classs\": \"1001005\", " +
                "\"dclasshour\": 3.0," +
                "\"dclassfee\": 2000.0\n" +
                " }]}]\n" +
                "}";

       /* JsonData2 jsonData = JSON.parseObject(jsonStr, JsonData2.class);
        List<DataObj2> data = jsonData.getData();
        for(DataObj2 curData: data){
            System.out.println("培训项目编码："+ curData.getPk_tranpro());
            System.out.println("培训专业编码："+ curData.getPk_sepecial());
            System.out.println("姓名："+ curData.getStuname());
            System.out.println("身份证号：" + curData.getStucardid());
            System.out.println("政治面貌："+ curData.getPolstatus());
            System.out.println("学历："+ curData.getStuedu());
            System.out.println("职称：" + curData.getJobtitle());
            System.out.println("手机号：" + curData.getTelphone());
            System.out.println("单位："+ curData.getWbunit());
            System.out.println("费用："+ curData.getNtotalfee());

            List<SignupbodysData> signupbodysDataList = curData.getSignupbodys();
            for(SignupbodysData signupbodysData: signupbodysDataList){
                System.out.println("课程编码："+ signupbodysData.getPk_classs());
                System.out.println("课时：" + signupbodysData.getDclasshour());
                System.out.println("学费：" + signupbodysData.getDclassfee());
            }
        }
*/

        String str1="{\n" +
                "\t\"srcsystem\": \"NC\",\n" +
                "\t\"busidate\": \"2019-11-21 15:35:43\",\n" +
                "\t\"data\": [{\n" +
                "\t\t\"pksigup\": \"1001ZZ1000000004J8K0\",\n" +
                "\t\t\"pk_tranpro\": \"HM132019111800000041\",\n" +
                "\t\t\"pk_sepecial\": \"1012\",\n" +
                "\t\t\"stuname\": \"张三\",\n" +
                "\t\t\"stucardid\": \"379786198901120293\",\n" +
                "\t\t\"stusex\": \"1\",\n" +
                "\t\t\"stunation\": null,\n" +
                "\t\t\"dstubirthday\": \"1989-01-12 00:00:00\",\n" +
                "\t\t\"polstatus\": \"党员\",\n" +
                "\t\t\"stuedu\": \"本科\",\n" +
                "\t\t\"jobtitle\": \"主任\",\n" +
                "\t\t\"curpost\": \"主任\",\n" +
                "\t\t\"telphone\": \"18977656765\",\n" +
                "\t\t\"wbunit\": \"勘测院\",\n" +
                "\t\t\"ntotalfee\": 2000.0,\n" +
                "\t\t\"signupbodys\": [{\n" +
                "\t\t\t\"pk_classs\": \"1018\",\n" +
                "\t\t\t\"dclasshour\": 2.0,\n" +
                "\t\t\t\"dclassfee\": 1000.0\n" +
                "\t\t}]\n" +
                "\t}, {\n" +
                "\t\t\"pksigup\": \"1001ZZ1000000004J8K3\",\n" +
                "\t\t\"pk_tranpro\": \"HM132019110800000038\",\n" +
                "\t\t\"pk_sepecial\": null,\n" +
                "\t\t\"stuname\": \"张三\",\n" +
                "\t\t\"stucardid\": \"379898198901140281\",\n" +
                "\t\t\"stusex\": \"0\",\n" +
                "\t\t\"stunation\": null,\n" +
                "\t\t\"dstubirthday\": \"1989-01-14 00:00:00\",\n" +
                "\t\t\"polstatus\": \"党员\",\n" +
                "\t\t\"stuedu\": \"党员\",\n" +
                "\t\t\"jobtitle\": \"主任\",\n" +
                "\t\t\"curpost\": \"主任\",\n" +
                "\t\t\"telphone\": \"18911788768\",\n" +
                "\t\t\"wbunit\": \"勘测院\",\n" +
                "\t\t\"ntotalfee\": 1000.0,\n" +
                "\t\t\"signupbodys\": []\n" +
                "\t}, {\n" +
                "\t\t\"pksigup\": \"1001ZZ1000000004J8K4\",\n" +
                "\t\t\"pk_tranpro\": \"HM132019110800000038\",\n" +
                "\t\t\"pk_sepecial\": null,\n" +
                "\t\t\"stuname\": \"李四\",\n" +
                "\t\t\"stucardid\": \"379898198901140282\",\n" +
                "\t\t\"stusex\": \"0\",\n" +
                "\t\t\"stunation\": null,\n" +
                "\t\t\"dstubirthday\": \"1989-01-14 00:00:00\",\n" +
                "\t\t\"polstatus\": \"党员\",\n" +
                "\t\t\"stuedu\": \"党员\",\n" +
                "\t\t\"jobtitle\": \"主任\",\n" +
                "\t\t\"curpost\": \"主任\",\n" +
                "\t\t\"telphone\": \"18911788768\",\n" +
                "\t\t\"wbunit\": \"勘测院\",\n" +
                "\t\t\"ntotalfee\": 1000.0,\n" +
                "\t\t\"signupbodys\": []\n" +
                "\t}]\n" +
                "}";
        String strCode = insertOrders(str1);

    }
}
