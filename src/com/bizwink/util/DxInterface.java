package com.bizwink.util;

import com.bizwink.net.http.Post;
import com.bizwink.po.OrderDetail;
import com.bizwink.po.Orders;
import com.bizwink.po.Users;

import java.text.SimpleDateFormat;
import java.util.List;

public class DxInterface {
    public void sendEnrollInfo(String ywprojcode,Users user, Orders order, List<OrderDetail> orderDetails) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String url = "http://i.bucg.com:80/service/XChangeServlet?account=0001&groupcode=0001";
        String strxml = "<?xml version=\"1.0\" encoding='UTF-8'?>" +
                "<ufinterface account=\"0001\" billtype=\"HM24\" filename=\"\" groupcode=\"0001\" isexchange=\"Y\" replace=\"Y\" roottag=\"\" sender=\"cjpxmng\">" +
                "    <bill id=\"MH20191030\">" +
                "        <billhead>" +
                "            <pk_group>0001</pk_group>" +
                "            <pk_billtype>HM24</pk_billtype>" +
                "            <dbilldate>" + simpleDateFormat.format(order.getCREATEDATE()) + "</dbilldate>" +                 //提交报名时间
                "            <vbillstatus>-1</vbillstatus>" +
                "            <creator>zhanghao</creator>" +
                "            <creationtime>" + simpleDateFormat.format(order.getCREATEDATE()) + "</creationtime>" +          //报名信息创建时间
                "            <pk_tranpro>" + ywprojcode + "</pk_tranpro>" +                  //学校业务系统定义的报名培训项目编号
                "            <pk_sepecial>" + order.getMajorcode() + "</pk_sepecial>" +                             //报名专业编号
                "            <sigtype>1</sigtype>" +
                "            <stuname>" + user.getNICKNAME() + "</stuname>" +                                      //报名人员姓名
                "            <stucardid>" + user.getIDCARD() + "</stucardid>" +                  //报名人员身份证号
                "            <stusex>" + user.getSEX() + "</stusex>" +                           //报名人员性别
                "            <stunation></stunation>" +                                          //报名人员民族
                "            <dstubirthday></dstubirthday>" +                                   //报名人员生日
                "            <polstatus>a</polstatus>" +
                "            <stuedu>a</stuedu>" +
                "            <jobtitle>" + user.getDUTY() + "</jobtitle>" +
                "            <curpost></curpost>" +
                "            <telphone>" + user.getMPHONE() + "</telphone>" +
                "            <wbunit>" + user.getCOMPANY() + "</wbunit>" +                                  //报名人员单位
                "            <ntotalfee>" + order.getTOTALFEE() + "</ntotalfee>" +                                 //总费用
                "            <def1>add</def1>" +                                             //操作
                "            <def2>MH20191030</def2>" +
                "            <bodymx>";

        String courseXml = "";
        for(int ii=0;ii<orderDetails.size();ii++) {
            OrderDetail orderDetail = orderDetails.get(ii);
            courseXml = courseXml + "                <item>";
            courseXml = courseXml + "                    <pk_classs>" + orderDetail.getProductcode() +"</pk_classs>";                        //课程编码
            courseXml = courseXml + "                    <classname>" + orderDetail.getProductname() + "</classname>";                    //课程名称
            courseXml = courseXml + "                    <dclassfee>" + orderDetail.getSALEPRICE() + "</dclassfee>";                        //课程价格
            courseXml = courseXml + "                    <dclasshour>" + orderDetail.getSubscribenum() + "</dclasshour>";                         //培训学时数
            courseXml = courseXml + "                </item>";
        }

        strxml = strxml + courseXml +
                "            </bodymx>" +
                "        </billhead>" +
                "    </bill>" +
                "</ufinterface>";

        String returnxml = Post.ArapXML(url, strxml);
        System.out.println(returnxml);
    }

}
