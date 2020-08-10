package com.bizwink.cms.business.Order;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;


public class Training implements Serializable {

    private BigDecimal ID;
    private String projname;  //项目名称
    private String projcode;  //项目编码
    private String brief;     //项目简介
    private Timestamp createdate;
    private String major;     //专业名称
    private String majorcode;  //专业编码
    private String classname;   //课程名称
    private String classcode;   //课程编码
    private int teacherid;      //教师
    private int price;          //价格
    private String traintime;   //
    private String address;   //培训地点
    private int siteid;
    private int nouse;

    public BigDecimal getID() {
        return ID;
    }

    public void setID(BigDecimal ID) {
        this.ID = ID;
    }

    public String getProjname() {
        return projname;
    }

    public void setProjname(String projname) {
        this.projname = projname;
    }

    public String getProjcode() {
        return projcode;
    }

    public void setProjcode(String projcode) {
        this.projcode = projcode;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getMajorcode() {
        return majorcode;
    }

    public void setMajorcode(String majorcode) {
        this.majorcode = majorcode;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public String getClasscode() {
        return classcode;
    }

    public void setClasscode(String classcode) {
        this.classcode = classcode;
    }

    public int getTeacherid() {
        return teacherid;
    }

    public void setTeacherid(int teacherid) {
        this.teacherid = teacherid;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getTraintime() {
        return traintime;
    }

    public void setTraintime(String traintime) {
        this.traintime = traintime;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getSiteid() {
        return siteid;
    }

    public void setSiteid(int siteid) {
        this.siteid = siteid;
    }

    public int getNouse() {
        return nouse;
    }

    public void setNouse(int nouse) {
        this.nouse = nouse;
    }
}
