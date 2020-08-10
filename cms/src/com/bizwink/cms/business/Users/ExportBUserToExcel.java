package com.bizwink.cms.business.Users;

import com.bizwink.cms.util.StringUtil;
import jxl.CellView;
import jxl.Workbook;
import jxl.write.*;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
public class ExportBUserToExcel{

    public ExportBUserToExcel(){

    }

    public static String ExportUsers(List<BUser> list,String path) throws IOException, WriteException {
        //创建excel文件
        //String path = request.getRealPath("");
        IBUserManager buserMgr = buserPeer.getInstance();
        Date date = new Date();
        SimpleDateFormat dateFm = new SimpleDateFormat("yyyyMMddHHmmss");
        String time = dateFm.format(date);
        String xlsname = "Users"+time+".xls";
        String filepath = path+"xls" + File.separator + "Users";
        File dir = new File(filepath);
        if(!dir.exists()){
            dir.mkdirs();
        }
        File f = new File(filepath,xlsname);
        //在当前目录下建立文件
        if (f.exists()) {
            f.delete();
        } else {
            f.createNewFile();
        }
        String absolutePath = f.getAbsolutePath();
        System.out.println(absolutePath);
        //创建一个可写入的excel文件对象
        WritableWorkbook workbook = Workbook.createWorkbook(f);
        //使用第一张工作表，将其命名为“member”
        // WritableSheet sheet = workbook.createSheet("dd", 0);
        int totle = list.size();//获取List集合的size
        int mus = 60000;//每个工作表格最多存储2条数据（注：excel表格一个工作表可以存储65536条）
        int avg = totle / mus;
        DecimalFormat df = new DecimalFormat();
        df.applyPattern("0.00");
        DecimalFormat df2 = new DecimalFormat();
        df2.applyPattern("0");
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatDateAndTime=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        try {
            for (int i = 0; i < avg + 1; i++) {
                WritableSheet sheet = workbook.createSheet("列表"+(i + 1), i); //创建一个可写入的工作表
                WritableCellFormat wcfF = new WritableCellFormat(NumberFormats.INTEGER);
                CellView cv0 = new CellView();
                cv0.setFormat(wcfF);
                cv0.setSize(20);
                sheet.setColumnView(0,cv0);
                cv0.setSize(40);
                sheet.setColumnView(1,cv0);

                WritableCellFormat wcfF1 = new WritableCellFormat(NumberFormats.TEXT);
                CellView cv1 = new CellView();
                cv1.setFormat(wcfF1);
                cv1.setSize(20);
                sheet.setColumnView(2,cv1);
                sheet.setColumnView(3,cv1);
                cv1.setSize(60);
                sheet.setColumnView(4,cv1);

                //表头
                Label label0 = new Label(0, 0, "用户名");
                sheet.addCell(label0);
                Label label1 = new Label(1, 0, "用户昵称");
                sheet.addCell(label1);
                Label label2 = new Label(2, 0, "电子邮箱");
                sheet.addCell(label2);
                Label label3 = new Label(3, 0, "手机号");
                sheet.addCell(label3);
                Label label4 = new Label(4, 0, "性别");
                sheet.addCell(label4);
                Label label5 = new Label(5, 0, "地区");
                sheet.addCell(label5);
                Label label6 = new Label(6, 0, "注册日期");
                sheet.addCell(label6);
                Label label7 = new Label(7, 0, "单位");
                sheet.addCell(label7);
                Label label8 = new Label(8, 0, "职位");
                sheet.addCell(label8);
                Label label9 = new Label(9, 0, "IDCARD");
                sheet.addCell(label9);



                int num = i * mus;
                int index = 0;
                for (int m = num; m < list.size(); m++) {
                    if (index == mus) {//判断index == mus的时候跳出当前for循环
                        break;
                    }
                    BUser bUser=(BUser)list.get(m);
                    String sex="男";
                    if(bUser.getSex() == 1){
                        sex="女";
                    }

                    Label userID = new Label(0, index+1, StringUtil.gb2iso4View(bUser.getUserID()));
                    sheet.addCell(userID);
                    Label Nickname = new Label(1, index+1, bUser.getNickname() == null ? "" : StringUtil.gb2iso4View(bUser.getNickname()));
                    sheet.addCell(Nickname);
                    Label email = new Label(2, index+1, bUser.getEmail() == null ? "" : bUser.getEmail());
                    sheet.addCell(email);
                    Label mphone = new Label(3, index+1, bUser.getMphone() == null ? "" : bUser.getMphone());
                    sheet.addCell(mphone);
                    Label sexs = new Label(4, index+1, sex);
                    sheet.addCell(sexs);
                    Label area = new Label(5, index+1, bUser.getArea() == null ? "" : StringUtil.gb2iso4View(bUser.getArea()));
                    sheet.addCell(area);
                    Label createdate = new Label(6, index+1, formatDateAndTime.format(bUser.getCreateDate()));
                    sheet.addCell(createdate);
                    Label company = new Label(7, index+1, bUser.getCompany()==null?"":StringUtil.gb2iso4View(bUser.getCompany()));
                    sheet.addCell(company);
                    Label duty = new Label(8, index+1, bUser.getDuty()==null?"":StringUtil.gb2iso4View(bUser.getDuty()));
                    sheet.addCell(duty);
                    Label idcard = new Label(9, index+1, bUser.getIdcard());
                    sheet.addCell(idcard);
                    index++;
                }
            }

            //关闭对象，释放资源
            workbook.write();
            workbook.close();
        }catch (Exception e) {
            workbook.close();
            e.printStackTrace();
        }
        return "/xls/Users/"+xlsname;
    }

}
