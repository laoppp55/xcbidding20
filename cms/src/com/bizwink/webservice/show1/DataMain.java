package com.bizwink.webservice.show1;

import com.alibaba.fastjson.JSON;
import com.bizwink.cms.server.FileProps;
import com.google.gson.Gson;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class DataMain {

   public static String AddTranproDate(String jsonStr){
       Map<String, Object> map = new HashMap<String, Object>();
       String resultstr="success";
       Connection conn = null;
       PreparedStatement pstmt=null;
       PreparedStatement pstmt1=null;
       ResultSet rs1=null;
       ResultSet rs=null;
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
           String url = props.getProperty("main.db.url");
           String UserName = props.getProperty("main.db.username");
           String Password = props.getProperty("main.db.password");
          /* String url = "jdbc:oracle:thin:@localhost:1522:orcl11g";
           String UserName="bucgdxdbadmin";
           String Password="qazwsxokm";*/
           conn = DriverManager.getConnection(url, UserName, Password);

           System.out.println("Connection Successful!");
           conn.setAutoCommit(false);

           JsonData jsonData = JSON.parseObject(jsonStr, JsonData.class);
           List<DataObj> data = jsonData.getData();
           int columnID=0;
           int t1=0;
           int nextID=0;
           for(int i = 0;i < data.size();i++){
               String majorcode ="";
               List<PranprobodyvoData> tranprobodysData = data.get(i).getPranprobodyvo();
               for(PranprobodyvoData curData : tranprobodysData){ //获取本库majorcode
                   majorcode = curData.getPk_special();  //专业编码
                   pstmt1 = conn.prepareStatement("select t.majorcode from TBL_TRAININGMAJOR t where t.nc_majorcode=?");
                   pstmt1.setString(1, curData.getPk_special());
                   rs1 = pstmt1.executeQuery();
                   if (rs1.next()) majorcode = rs1.getString("majorcode");
                   rs1.close();
               }


               String projcode = ""; //获取本库项目编码
               pstmt1 = conn.prepareStatement("select t.projcode from TBL_TRAININGPROJECT t where t.nc_code=?");
               pstmt1.setString(1,data.get(i).getPk_tranprotype());
               rs1 = pstmt1.executeQuery();
               if (rs1.next()) projcode = rs1.getString("projcode");
               rs1.close();
               pstmt1.close();

               //System.out.println("projcode="+projcode);
             //  String pk_tranprotype = projcode;
               String pk_tranprotype=data.get(i).getPk_tranprotype();
               if(pk_tranprotype.equals("01")) //党校教育
                   columnID = 47;
               if(pk_tranprotype.equals("0101")) //企业领导干部培训
                   columnID=48;
               if(pk_tranprotype.equals("0102")) //党员发展对象培训
                   columnID=49;
               if(pk_tranprotype.equals("0103")) //入党积极分子培训
                   columnID=50;
               if(pk_tranprotype.equals("02")) //商学院
                   columnID=51;
               if(pk_tranprotype.equals("03")) //新技术推广
                   columnID=52;
               if(pk_tranprotype.equals("04")) //成人学历教育
                   columnID=53;
               if(pk_tranprotype.equals("05")) //行业培训
                   columnID=54;
               //if(pk_tranprotype.equals("0201")) //企业紧缺人才培训
               //    columnID=54;
              // if(pk_tranprotype.equals("0202"))  //继续教育培训
               if(pk_tranprotype.equals("0301")) //四新技术推广
                  columnID = 69;
               if(pk_tranprotype.equals("0302")) //BIM培训
                  columnID= 70;
               if(pk_tranprotype.equals("0401")) //中央党校研究生班
                  columnID =71;
               if(pk_tranprotype.equals("0402")) //奥鹏学历教育
                   columnID =72;
               if(pk_tranprotype.equals("0403")) //其他学历教育
                   columnID=73;
               if(pk_tranprotype.equals("050101")) //一级注册建造师
                   columnID=78;
               if(pk_tranprotype.equals("050102")) //二级注册建造师
                   columnID=79;
               if(pk_tranprotype.equals("050103")) //一级注册造价师
                   columnID=80;
               if(pk_tranprotype.equals("050104")) //二级注册造价师
                   columnID=81;
               if(pk_tranprotype.equals("0503")) //现场管理人员
                   columnID=76;
               if(pk_tranprotype.equals("050402")) //操作人员
                   columnID=77;
               if(pk_tranprotype.equals("0502")) //安全三类
                   columnID=75;
               if(pk_tranprotype.equals("050105")) //其他
                   columnID=82;

               pstmt1 = conn.prepareStatement("select id from tbl_article where pk_tranpro=? and columnid=?");//判断是否重复
               pstmt1.setString(1, data.get(i).getPk_tranpro());
               pstmt1.setInt(2, columnID);
               rs1 = pstmt1.executeQuery();
               while (rs1.next()) {
                   t1 = rs1.getInt(1);
               }
               rs1.close();
               pstmt1.close();

               pstmt1 = conn.prepareStatement("select dirname from tbl_column where id= ?");
               pstmt1.setInt(1, columnID);
               rs1 = pstmt1.executeQuery();
               while (rs1.next()) {
                   dirname = rs1.getString("dirname");
               }
               rs1.close();
               pstmt1.close();

               if(t1 > 0 ){
                   System.out.println("数据已存在t1="+t1+"更新该条数据");
                   pstmt = conn.prepareStatement("update tbl_article set maintitle=?,content=?," +
                           "publishtime=?,createdate=?,lastupdated=?,editor=?," +
                           "pubflag=?,BILLNO=?,pk_tranprotype=?,pk_tranpro=? where id=?");
                   pstmt.setString(1,data.get(i).getTranproname());
                   // pstmt.setString(7,CommUtil.html2Text(article_masterkong.getContent()));
                   pstmt.setString(2,data.get(i).getTranproinfo());
                   // DBUtil.setBigString("oracle", pstmt, 7, article_masterkong.getContent());
                   Timestamp create_date = new Timestamp(System.currentTimeMillis());
                   pstmt.setTimestamp(3,create_date);
                   pstmt.setTimestamp(4,create_date);
                   pstmt.setTimestamp(5,create_date);
                   pstmt.setString(6,jsonData.getSrcsystem());
                   pstmt.setInt(7,1);
                   pstmt.setString(8,data.get(i).getBillno());
                   pstmt.setString(9,projcode);
                   pstmt.setString(10,data.get(i).getPk_tranpro());
                   pstmt.setInt(11,t1);
                   pstmt.executeUpdate();
                   pstmt.close();

                   //修改扩展属性
                   //培训开始时间
                   String Dbegindate = data.get(i).getDbegindate();
                   int ExtID=0;
                   if(Dbegindate!=null) {
                       pstmt = conn.prepareStatement("update TBL_Article_ExtendAttr set " +
                               "StringValue=? where articleid=? and Ename='_pxbt'");
                       pstmt.setString(1,Dbegindate);
                       pstmt.setInt(2, t1);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }
                   //培训结束时间
                   String Denddate = data.get(i).getDenddate();
                   if(Denddate!=null) {
                       pstmt = conn.prepareStatement("update TBL_Article_ExtendAttr set " +
                               "StringValue=? where articleid=? and Ename='_pxet'");
                       pstmt.setString(1,Denddate);
                       pstmt.setInt(2, t1);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

                   //专业编码
                   if(majorcode!=null) {
                       pstmt = conn.prepareStatement("update TBL_Article_ExtendAttr set " +
                               "StringValue=? where articleid=? and Ename='_major'");
                       pstmt.setString(1,majorcode);
                       pstmt.setInt(2, t1);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

                   //培训地点
                   String pxdd = data.get(i).getTranposition();
                   if(pxdd!=null) {
                       pstmt = conn.prepareStatement("update TBL_Article_ExtendAttr set " +
                               "StringValue=? where articleid=? and Ename='_pxdd'");
                       pstmt.setString(1,pxdd);
                       pstmt.setInt(2, t1);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }
                   //修改课程
                   //Connection conn1 = null;
                   try{
                       pstmt = conn.prepareStatement("delete from TBL_ARTICLE_CLASS where ARTICLEID=?");
                       pstmt.setInt(1,t1);
                       pstmt.executeUpdate();
                       pstmt.close();
                       conn.commit();
                   }catch (Exception e){
                       try{
                           conn.rollback();
                       }catch (SQLException e1) {
                           e1.printStackTrace();
                       }
                   }/*finally {
                       if(conn!=null){
                           try {
                               conn1.close();
                           } catch (SQLException e) {
                               e.printStackTrace();
                           }
                       }
                   }*/
                   List<PranprobodyvoData> tranprobodysDatas = data.get(i).getPranprobodyvo();
                   for(PranprobodyvoData curData : tranprobodysDatas){
                       int TRAININGID=0;
                       pstmt1 = conn.prepareStatement("select TRAINING_ID.NEXTVAL from dual");
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) TRAININGID = rs1.getInt(1);
                       rs1.close();
                       pstmt1.close();

                       pstmt = conn.prepareStatement("INSERT INTO TBL_ARTICLE_CLASS(ID,ARTICLEID,projcode,ncprojcode,majorcode,classcode,classname,price,classhour,createdate)" +
                               "values(?,?,?,?,?,?,?,?,?,?) ");
                       pstmt.setInt(1,TRAININGID);
                       pstmt.setInt(2,t1);
                       pstmt.setString(3,projcode);                           //保存本地的projcode
                       pstmt.setString(4,data.get(i).getBillno());            //保存传过来的projcode
                       pstmt.setString(5,curData.getPk_special());            //保存传过来的majorcode
                       pstmt.setString(6,curData.getPk_class());
                       String classname="";
                       pstmt1 = conn.prepareStatement("select t.classname from TBL_TRAININGCLASS t where t.classcode=?");
                       pstmt1.setString(1, curData.getPk_class());
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) classname = rs1.getString("classname");
                       rs1.close();
                       pstmt1.close();
                       pstmt.setString(7,classname);
                       pstmt.setString(8,curData.getDclassfee());
                       pstmt.setString(9,curData.getDclasshour());
                       pstmt.setTimestamp(10,new Timestamp(System.currentTimeMillis()));
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

                    resultstr = "success";
                    map.put("Message", "数据已存在，更新成功！");
               }else {
                   pstmt1 = conn.prepareStatement("select tbl_article_id.NEXTVAL from dual");//Oracle 获取自增序列
                   rs1 = pstmt1.executeQuery();
                   if (rs1.next()) nextID = rs1.getInt(1);
                   rs1.close();
                   pstmt1.close();

                   System.out.println("插入一条记录");
                   pstmt = conn.prepareStatement("insert into TBL_ARTICLE(columnid,maintitle,vicetitle,summary,keyword,source,content,author,publishtime,defineurl,t1,siteid,emptycontentflag,createdate,lastupdated,dirname,editor,status,doclevel,pubflag,auditflag,subscriber,lockstatus,ispublished,indexflag,isjoinrss,clicknum,referID,modelID,bigpic,mediafile,articlepic,urltype,id,CREATOR,BILLNO,pk_tranprotype,pk_tranpro)" +
                           " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                   pstmt.setInt(1,columnID);
                   pstmt.setString(2,data.get(i).getTranproname());
                   pstmt.setString(3,"");
                   pstmt.setString(4,"");
                   pstmt.setString(5,"");
                   pstmt.setString(6,"");
                   // pstmt.setString(7,CommUtil.html2Text(article_masterkong.getContent()));
                   pstmt.setString(7,data.get(i).getTranproinfo());
                   // DBUtil.setBigString("oracle", pstmt, 7, article_masterkong.getContent());
                   pstmt.setString(8,"");
                   Timestamp create_date = new Timestamp(System.currentTimeMillis());
                   pstmt.setTimestamp(9,create_date);
                   pstmt.setString(10,"");
                   pstmt.setInt(11,0);
                   pstmt.setInt(12,59);
                   pstmt.setInt(13,0);
                   pstmt.setTimestamp(14,create_date);
                   pstmt.setTimestamp(15,create_date);
                   pstmt.setString(16,dirname);
                   //pstmt.setString(17,article.getAuthor());
                   pstmt.setString(17,jsonData.getSrcsystem());
                   pstmt.setInt(18,1);
                   pstmt.setInt(19,0);
                   pstmt.setInt(20,1);
                   pstmt.setInt(21,0);
                   pstmt.setInt(22,1);
                   pstmt.setInt(23,0);
                   pstmt.setInt(24,0);
                   pstmt.setInt(25,0);
                   pstmt.setInt(26,0);
                   pstmt.setInt(27,0);
                   pstmt.setInt(28,0);
                   pstmt.setInt(29,0);
                   pstmt.setString(30,null);
                   // pstmt.setInt(31,nextID);
                   pstmt.setString(31,null);
                   pstmt.setString(32,null);
                   pstmt.setInt(33, 0);
                   pstmt.setInt(34,nextID);
                   pstmt.setString(35, "bucgdxadmin_NC");
                   pstmt.setString(36,data.get(i).getBillno());
                   pstmt.setString(37,projcode);
                   pstmt.setString(38,data.get(i).getPk_tranpro());
                   pstmt.executeUpdate();
                   pstmt.close();

                   //增加扩展属性
                   //培训开始时间
                   String Dbegindate = data.get(i).getDbegindate();
                   int ExtID=0;
                   if(Dbegindate!=null) {
                       pstmt1 = conn.prepareStatement("select tbl_article_extendattr_id.NEXTVAL from dual");
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) ExtID = rs1.getInt(1);
                       rs1.close();
                       pstmt1.close();
                       pstmt = conn.prepareStatement("INSERT INTO TBL_Article_ExtendAttr(ArticleID,Ename,Type," +
                               "StringValue,NumericValue,FloatValue,ID,TextValue) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                       pstmt.setInt(1, nextID);
                       pstmt.setString(2,"_pxbt");
                       pstmt.setInt(3, 1);
                       pstmt.setString(4,Dbegindate);
                       pstmt.setInt(5, 0);
                       pstmt.setFloat(6,(float)0.00);
                       pstmt.setInt(7,ExtID);
                       pstmt.setNull(8, java.sql.Types.LONGVARCHAR);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }
                   //培训结束时间
                   String Denddate = data.get(i).getDenddate();
                   if(Denddate!=null) {
                       pstmt1 = conn.prepareStatement("select tbl_article_extendattr_id.NEXTVAL from dual");
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) ExtID = rs1.getInt(1);
                       rs1.close();
                       pstmt1.close();
                       pstmt = conn.prepareStatement("INSERT INTO TBL_Article_ExtendAttr(ArticleID,Ename,Type," +
                               "StringValue,NumericValue,FloatValue,ID,TextValue) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                       pstmt.setInt(1,nextID);
                       pstmt.setString(2,"_pxet");
                       pstmt.setInt(3,1);
                       pstmt.setString(4,Denddate);
                       pstmt.setInt(5,0);
                       pstmt.setFloat(6,(float)0.00);
                       pstmt.setInt(7,ExtID);
                       pstmt.setNull(8, java.sql.Types.LONGVARCHAR);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

                   //专业编码
                   if(majorcode!=null) {
                       pstmt1 = conn.prepareStatement("select tbl_article_extendattr_id.NEXTVAL from dual");
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) ExtID = rs1.getInt(1);
                       rs1.close();
                       pstmt1.close();
                       pstmt = conn.prepareStatement("INSERT INTO TBL_Article_ExtendAttr(ArticleID,Ename,Type," +
                               "StringValue,NumericValue,FloatValue,ID,TextValue) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                       pstmt.setInt(1,nextID);
                       pstmt.setString(2,"_major");
                       pstmt.setInt(3,1);
                       pstmt.setString(4,majorcode);
                       pstmt.setInt(5,0);
                       pstmt.setFloat(6,(float)0.00);
                       pstmt.setInt(7,ExtID);
                       pstmt.setNull(8, java.sql.Types.LONGVARCHAR);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

                   //培训地点
                   String pxdd = data.get(i).getTranposition();
                   if(pxdd!=null) {
                       pstmt1 = conn.prepareStatement("select tbl_article_extendattr_id.NEXTVAL from dual");
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) ExtID = rs1.getInt(1);
                       rs1.close();
                       pstmt1.close();
                       pstmt = conn.prepareStatement("INSERT INTO TBL_Article_ExtendAttr(ArticleID,Ename,Type," +
                               "StringValue,NumericValue,FloatValue,ID,TextValue) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                       pstmt.setInt(1,nextID);
                       pstmt.setString(2,"_pxdd");
                       pstmt.setInt(3,1);
                       pstmt.setString(4,pxdd);
                       pstmt.setInt(5,0);
                       pstmt.setFloat(6,(float)0.00);
                       pstmt.setInt(7,ExtID);
                       pstmt.setNull(8, java.sql.Types.LONGVARCHAR);
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

                   //添加课程
                   List<PranprobodyvoData> tranprobodysDatas = data.get(i).getPranprobodyvo();
                   for(PranprobodyvoData curData : tranprobodysDatas){
                       int TRAININGID=0;
                       pstmt1 = conn.prepareStatement("select TRAINING_ID.NEXTVAL from dual");
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) TRAININGID = rs1.getInt(1);
                       rs1.close();
                       pstmt1.close();

                       pstmt = conn.prepareStatement("INSERT INTO TBL_ARTICLE_CLASS(ID,ARTICLEID,projcode,ncprojcode,majorcode,classcode,classname,price,classhour,createdate)" +
                               "values(?,?,?,?,?,?,?,?,?,?) ");
                       pstmt.setInt(1,TRAININGID);
                       pstmt.setInt(2,nextID);
                       pstmt.setString(3,projcode);                            //保存本系统projcode
                       pstmt.setString(4,data.get(i).getBillno());             //保存传过来的projcode
                       pstmt.setString(5,curData.getPk_special());             //保存传过来的majorcode
                       pstmt.setString(6,curData.getPk_class());
                       String classname="";
                       pstmt1 = conn.prepareStatement("select t.classname from TBL_TRAININGCLASS t where t.classcode=?");
                       pstmt1.setString(1, curData.getPk_class());
                       rs1 = pstmt1.executeQuery();
                       if (rs1.next()) classname = rs1.getString("classname");
                       rs1.close();
                       pstmt1.close();
                       pstmt.setString(7,classname);
                       pstmt.setString(8,curData.getDclassfee());
                       pstmt.setString(9,curData.getDclasshour());
                       pstmt.setTimestamp(10,new Timestamp(System.currentTimeMillis()));
                       pstmt.executeUpdate();
                       pstmt.close();
                   }

               }


               /*System.out.println("项目类别编码:"+data.get(i).getPk_tranprotype()); //编码 对应项目编码
               System.out.println("期数：" + data.get(i).getPk_pnum());
               System.out.println("培训项目编码："+ data.get(i).getBillno()); // 该数据唯一标识
               System.out.println("项目名称:"+data.get(i).getTranproname()); //标题
               System.out.println("开始时间:"+data.get(i).getDbegindate());
               System.out.println("结束时间:"+data.get(i).getDenddate());
               System.out.println("培训天数："+data.get(i).getNtrandays());
               System.out.println("培训地点："+ data.get(i).getTranposition());
               System.out.println("承办方:"+data.get(i).getPk_cbf());
               System.out.println("承办方负责人："+data.get(i).getPk_cbfpsn());
               System.out.println("承办方联系人："+data.get(i).getCbflkman());
               System.out.println("承办联系人手机号:"+data.get(i).getCbflkmantel());
               System.out.println("合作承办方:"+data.get(i).getHzcbf());
               System.out.println("合作承办负责人:"+data.get(i).getHzcbfpsn());
               System.out.println("合作承办方联系人："+data.get(i).getHzcbflkman());
               System.out.println("合作承办方联系人手机号："+data.get(i).getHzcbflkmantel());
               System.out.println("主办方："+data.get(i).getPk_zbf());
               System.out.println("主办方负责人："+data.get(i).getZbfpsn());
               System.out.println("主办方联系人："+data.get(i).getZbflkman());
               System.out.println("主办方联系人电话："+data.get(i).getZbflkmantel());
               System.out.println("培训人数：" + data.get(i).getNtranpsnnum());
               System.out.println("项目管理人数:"+data.get(i).getNmngpsnnum());
               List<TranprobodysData> tranprobodysData = data.get(i).getTranprobodys();
               for(TranprobodysData curData : tranprobodysData){
                   System.out.println("专业编码："+curData.getPk_special());  //专业编码
                   System.out.println("课程编码："+curData.getPk_classs());
                   System.out.println("课时："+curData.getDclasshour());
                   System.out.println("学费："+ curData.getDclassfee());
               }*/
           }

           conn.commit();
       }catch (SQLException e){
           System.out.println("i = 异常" + e);
            resultstr = "error";
            map.put("errMessage", "入库失败,请联系管理员");
            e.printStackTrace();
       }finally{
           if(conn!=null){
               try {
                   conn.close();
               } catch (SQLException e) {
                   e.printStackTrace();
               }
           }
       }
       map.put("status",resultstr);
       Gson gson = new Gson();
       String resultJson = gson.toJson(map,LinkedHashMap.class);
       return resultJson;
   }

   public static void main(String[] args){
   /*String jsonStr="{\n" +
           "\"srcsystem\": \"NC\",\n" +
           "\"busidate\": \"2019-08-26 13:57:33\",\n" +
           "\"data\": [{\n" +
           "\"pk_tranprotype\": \"050101\",\n" +
           "\"pk_pnum\": \"一期\",\n" +
           "\"billno\": \"PXXM20190829001\",\n" +
           "\"tranproname\": \"2019-08-26一级建造师一期培训\",\n" +
           "\"dbegindate\": \"2019-08-26 09:00:00\"," +
           "\"denddate\": \"2019-08-26 17:00:00\",\n" +
           "\"ntrandays\": 1.00," +
           "\"tranposition\": \"北苑大酒店12层1212教师\"," +
           "\"pk_cbf\": \"城建培训中心\",\n" +
           "\"pk_cbfpsn\": \"张三\",\n" +
           "\"cbflkman\": \"张三\",\n" +
           "\"cbflkmantel\": \"18911788987\",\n" +
           "\"hzcbf\": \"城建集团\",\n" +
           "\"hzcbfpsn\": \"李四\",\n" +
           "\"hzcbflkman\": \"李四\",\n" +
           "\"hzcbflkmantel\": \"18977866567\",\n" +
           "\"pk_zbf\": \"城建置业\",\n" +
           "\"zbfpsn\": \"王五\"," +
           "\"zbflkman\": \"王五\"," +
           "\"zbflkmantel\": \"17878787879\"," +
           "\"ntranpsnnum\": 100,\n" +
           " \"nmngpsnnum\": 5," +
           " \"tranprobodys\": [{\n" +
           "\"pk_special\": \"1001\",\n" +
           "\"pk_classs\": \n" +
           "\"1001\",\n" +
           "\"dclasshour\": 2.0,\n" +
           "\"dclassfee\": 1000.0}, {\n" +
           "\"pk_special\": \"1001\",\"pk_classs\": \"1001\", \"dclasshour\": 2.0,\n" +
           " \"dclassfee\": 2000.0\n" +
           " }] }]\n" +
           "}";
*/
       String json1="{\n" +
               "\"srcsystem\": \"NC\",\n" +
               "\"busidate\": \"2020-03-23 15:00:01\",\n" +
               "\"data\": [{\n" +
               "\"pk_tranpro\": \"1002ZZ1000000004IQT9\",\n" +
               "\"pk_tranprotype\": \"050101\",\n" +
               "\"pk_pnum\": \"一期\",\n" +
               "\"billno\": \"HM133020031500000039\",\n" +
               "\"tranproname\": \"2020-05-09一级注册建造师培训一期\",\n" +
               "\"dbegindate\": \"2020-05-5 09:00:00\",\n" +
               "\"denddate\": \"2020-05-7 16:00:00\",\n" +
               "\"ntrandays\": 1.0,\n" +
               "\"tranposition\": \"北苑大酒店\",\n" +
               "\"pk_cbf\": \"城建培训中心        \",\n" +
               "\"pk_cbfpsn\": \"张三\",\n" +
               "\"cbflkman\": \"张三\",\n" +
               "\"cbflkmantel\": \"18911788987\",\n" +
               "\"hzcbf\": \"城建集团\",\n" +
               "\"hzcbfpsn\": \"李四\",\n" +
               "\"hzcbflkman\": \"李四\",\n" +
               "\"hzcbflkmantel\": \"18977866567\",\n" +
               "\"pk_zbf\": \"城建置业\",\n" +
               "\"zbfpsn\": \"王五\"," +
               "\"zbflkman\": \"王五\"," +
               "\"zbflkmantel\": \"17878787879\"," +
               "\"ntranpsnnum\": 100,\n" +
               " \"nmngpsnnum\": 5," +
               "\"tranproinfo\": \"各相关单位：\\n根据北京市住建委《关于开展2019年度\\u003c安全生产考核合格证书\\u003e延续工作的通知》文件精神，现将集团2019年度安全管理三类人员证书延续工作的安排通知如下：\\n一、证书延续人员范围\",\n" +
               "\"pranprobodyvo\": [" +
               "{\"pk_special\": \"1001\",\"pk_class\": \"1001\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1001\",\"pk_class\": \"1002\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1001\",\"pk_class\": \"1003\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1001\",\"pk_class\": \"1004\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1002\",\"pk_class\": \"1001\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1002\",\"pk_class\": \"1002\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1002\",\"pk_class\": \"1003\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1002\",\"pk_class\": \"1005\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1003\",\"pk_class\": \"1001\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1003\",\"pk_class\": \"1002\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1003\",\"pk_class\": \"1003\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1003\",\"pk_class\": \"1006\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1004\",\"pk_class\": \"1001\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1004\",\"pk_class\": \"1002\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1004\",\"pk_class\": \"1003\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1004\",\"pk_class\": \"1007\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1005\",\"pk_class\": \"1001\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1005\",\"pk_class\": \"1002\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1005\",\"pk_class\": \"1003\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0},\n" +
               "{\"pk_special\": \"1005\",\"pk_class\": \"1008\",\"dclasshour\": 1.0,\"dclassfee\": 1000.0}\n" +
               "]}]" +
               "}";

         String strcode = AddTranproDate(json1);
    }
}
