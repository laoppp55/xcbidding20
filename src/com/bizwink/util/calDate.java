package com.bizwink.util;

import java.util.Calendar;

/**
 * Created by Administrator on 18-9-19.
 * subscribetype:1整订，2破头订，3破尾订，4破头破尾订
 * subscribe:订阅类型，1年订，2半年订 3季度定 4月订
 * across_year_flag:年订是否允许跨年年订
 * across_half_year_flag:半年订是否允许跨自然半年
 * across_q_flag:季度订是否允许跨自然季度
 * tqdays:提前预定天数
 * dyqnum:按季度订阅，用户输入订阅的季度数
 * dymnum:按月度订阅，用户输入的订阅月度数
 * b_calender:用户输入的开始订阅日期
 * e_calender:用户输入的结束订阅日期
 */
public class calDate {

    public String aa(int subscribetype,int subscribe,int across_year_flag,int across_half_year_flag,int across_q_flag,int tqdays,int dyqnum,
                     int dymnum,Calendar b_calender,Calendar e_calender) {
        if (subscribetype == 1) {                                                           //整订
            if (subscribe==1)  {                                                            //年订
                if (across_year_flag==1) {                                                  //年度订阅，用户可以跨年订阅
                    b_calender.add(Calendar.DATE, e_calender.get(Calendar.DATE)+tqdays);   //用户设置的订阅日期加提前订阅天数
                    if (b_calender.get(Calendar.DAY_OF_MONTH) == 1) {                     //如果用户输入订阅日期加上提前订阅天数等于某月1号，设置订阅结束日期
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.YEAR ,1);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else {                                                               //如果用户输入订阅日期加上提前订阅天数不等于某月1号，开始订阅时间设置为下个月1号
                        b_calender.add(Calendar.MONTH,1);
                        b_calender.set(Calendar.DAY_OF_MONTH, 1);
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.YEAR ,1);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    }
                } else {                                                                  //订阅设置不允许跨年
                    b_calender.add(Calendar.DATE, e_calender.get(Calendar.DATE)+tqdays);
                    if (b_calender.get(Calendar.MONTH)==0 && b_calender.get(Calendar.DAY_OF_MONTH)==1) {   //用户输入订阅起始日期加提前起订日为下一年的一月1号
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.YEAR ,1);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else {      //用户输入订阅起始日期加提前起订日不是下一年的一月1号，
                        Calendar now = Calendar.getInstance();
                        b_calender.add(Calendar.YEAR,1);
                        b_calender.set(Calendar.MONTH,0);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.YEAR, 1);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    }
                }
                System.out.println(b_calender.get(Calendar.YEAR) + "===" + (b_calender.get(Calendar.MONTH) + 1) + "==" + b_calender.get(Calendar.DAY_OF_MONTH));
                System.out.println(e_calender.get(Calendar.YEAR) + "===" + (e_calender.get(Calendar.MONTH) + 1) + "==" + e_calender.get(Calendar.DAY_OF_MONTH));
            } else if (subscribe==2) {              //半年订阅
                if(across_half_year_flag == 1) {                    //自然半年预定
                    b_calender.add(Calendar.DATE, e_calender.get(Calendar.DATE)+tqdays);
                    if(((b_calender.get(Calendar.MONTH)==0) || (b_calender.get(Calendar.MONTH)==6)) && b_calender.get(Calendar.DAY_OF_MONTH)==1) {
                        e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH, 6);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else {
                        if ((b_calender.get(Calendar.MONTH)==0 && b_calender.get(Calendar.DAY_OF_MONTH)>1)||((b_calender.get(Calendar.MONTH)>0) && (b_calender.get(Calendar.MONTH)<6))) {
                            b_calender.set(Calendar.MONTH,6);
                            b_calender.set(Calendar.DAY_OF_MONTH,1);
                            e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                            e_calender.add(Calendar.MONTH, 6);
                            e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                        } else {
                            b_calender.add(Calendar.YEAR,1);
                            b_calender.set(Calendar.MONTH,0);
                            b_calender.set(Calendar.DAY_OF_MONTH,1);
                            e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                            e_calender.add(Calendar.MONTH, 6);
                            e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                        }
                    }
                } else {
                    b_calender.add(Calendar.DATE, e_calender.get(Calendar.DATE)+tqdays);
                    if (b_calender.get(Calendar.DAY_OF_MONTH)==1) {             //用户输入日期加提前预定日期刚好是某月1号，这天既为实际预定日期
                        e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH, 6);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else {                                                     //用户输入日期加提前预定日期不是某月1号，从下月1号起为实际预定日期
                        b_calender.add(Calendar.MONTH,1);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR), b_calender.get(Calendar.MONTH), b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH, 6);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    }
                }
                System.out.println(b_calender.get(Calendar.YEAR) + "===" + (b_calender.get(Calendar.MONTH) + 1) + "==" + b_calender.get(Calendar.DAY_OF_MONTH));
                System.out.println(e_calender.get(Calendar.YEAR) + "===" + (e_calender.get(Calendar.MONTH) + 1) + "==" + e_calender.get(Calendar.DAY_OF_MONTH));
            } else if (subscribe==3) {              //季度订阅
                b_calender.add(Calendar.DATE, e_calender.get(Calendar.DATE)+tqdays);
                if(across_q_flag == 1) {                                 //按照自然季度预定
                    if ((b_calender.get(Calendar.MONTH)==0 && b_calender.get(Calendar.DAY_OF_MONTH)==1)||
                            ((b_calender.get(Calendar.MONTH)==3) && (b_calender.get(Calendar.DAY_OF_MONTH)==1)) ||
                            ((b_calender.get(Calendar.MONTH)==6) && (b_calender.get(Calendar.DAY_OF_MONTH)==1)) ||
                            ((b_calender.get(Calendar.MONTH)==9) && (b_calender.get(Calendar.DAY_OF_MONTH)==1))) {
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else if ((b_calender.get(Calendar.MONTH)==0 && b_calender.get(Calendar.DAY_OF_MONTH)>1)||((b_calender.get(Calendar.MONTH)>0) && (b_calender.get(Calendar.MONTH)<3))) {
                        b_calender.set(Calendar.MONTH,3);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else if ((b_calender.get(Calendar.MONTH)==3 && b_calender.get(Calendar.DAY_OF_MONTH)>1)||((b_calender.get(Calendar.MONTH)>3) && (b_calender.get(Calendar.MONTH)<6))) {
                        b_calender.set(Calendar.MONTH,6);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else if ((b_calender.get(Calendar.MONTH)==6 && b_calender.get(Calendar.DAY_OF_MONTH)>1)||((b_calender.get(Calendar.MONTH)>6) && (b_calender.get(Calendar.MONTH)<9))) {
                        b_calender.set(Calendar.MONTH,9);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else {
                        b_calender.add(Calendar.YEAR,1);
                        b_calender.set(Calendar.MONTH,0);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    }
                } else {                             //按照非自然季度订阅
                    if (b_calender.get(Calendar.DAY_OF_MONTH)==1) {
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    } else {
                        b_calender.add(Calendar.MONTH,1);
                        b_calender.set(Calendar.DAY_OF_MONTH,1);
                        e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                        e_calender.add(Calendar.MONTH ,3*dyqnum);
                        e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                    }
                }
                System.out.println(b_calender.get(Calendar.YEAR) + "===" + (b_calender.get(Calendar.MONTH) + 1) + "==" + b_calender.get(Calendar.DAY_OF_MONTH));
                System.out.println(e_calender.get(Calendar.YEAR) + "===" + (e_calender.get(Calendar.MONTH) + 1) + "==" + e_calender.get(Calendar.DAY_OF_MONTH));
            } else if (subscribe==4) {              //按月订阅
                b_calender.add(Calendar.DATE, e_calender.get(Calendar.DATE)+tqdays);
                b_calender.add(Calendar.MONTH,1);
                b_calender.set(Calendar.DAY_OF_MONTH, 1);
                if (b_calender.get(Calendar.DAY_OF_MONTH)==1) {
                    e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                    e_calender.add(Calendar.MONTH ,1*dymnum);
                    e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                } else if (b_calender.get(Calendar.MONTH)==11 && b_calender.get(Calendar.DAY_OF_MONTH)>1){
                    b_calender.add(Calendar.YEAR,1);
                    b_calender.set(Calendar.MONTH,0);
                    b_calender.set(Calendar.DAY_OF_MONTH,1);
                    e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                    e_calender.add(Calendar.MONTH ,1*dymnum);
                    e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                } else {
                    b_calender.add(Calendar.MONTH,1);
                    b_calender.set(Calendar.DAY_OF_MONTH,1);
                    e_calender.set(b_calender.get(Calendar.YEAR),b_calender.get(Calendar.MONTH),b_calender.get(Calendar.DAY_OF_MONTH));
                    e_calender.add(Calendar.MONTH ,1*dymnum);
                    e_calender.set(Calendar.DATE, e_calender.get(Calendar.DATE) - 1);
                }
                System.out.println(b_calender.get(Calendar.YEAR) + "===" + (b_calender.get(Calendar.MONTH) + 1) + "==" + b_calender.get(Calendar.DAY_OF_MONTH));
                System.out.println(e_calender.get(Calendar.YEAR) + "===" + (e_calender.get(Calendar.MONTH) + 1) + "==" + e_calender.get(Calendar.DAY_OF_MONTH));
            }
        } else if(subscribetype == 2) {                                     //破订，破头订阅
        } else if (subscribetype == 3) {                                    //破订，破尾订阅
        } else if (subscribetype == 4) {                                   //破订，破头破尾订阅
        }

        return null;
    }
}
