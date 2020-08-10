package com.bizwink.webservice.show2;

import java.io.Serializable;
import java.util.List;

public class DataObj2 implements Serializable {

    private static final long serialVersionUID = -2528670534592625424L;

    private String pksigup;

    private String pk_tranpro;

    private  String pk_sepecial;

    private String sigtype;

    private String stuname;

    private String stucardid;

    private String polstatus;

    private String stuedu;

    private int stusex; //男-1，女-0

    private String jobtitle; //职称

    private String curpost; //职务

    private String telphone;

    private String wbunit;

    private String ntotalfee;

    private List<SignupbodysData> signupbodys;

    public String getPksigup() {
        return pksigup;
    }

    public void setPksigup(String pksigup) {
        this.pksigup = pksigup;
    }

    public String getPk_tranpro() {
        return pk_tranpro;
    }

    public void setPk_tranpro(String pk_tranpro) {
        this.pk_tranpro = pk_tranpro;
    }

    public String getPk_sepecial() {
        return pk_sepecial;
    }

    public void setPk_sepecial(String pk_sepecial) {
        this.pk_sepecial = pk_sepecial;
    }

    public String getSigtype() {
        return sigtype;
    }

    public void setSigtype(String sigtype) {
        this.sigtype = sigtype;
    }

    public String getStuname() {
        return stuname;
    }

    public void setStuname(String stuname) {
        this.stuname = stuname;
    }

    public String getStucardid() {
        return stucardid;
    }

    public void setStucardid(String stucardid) {
        this.stucardid = stucardid;
    }

    public String getPolstatus() {
        return polstatus;
    }

    public void setPolstatus(String polstatus) {
        this.polstatus = polstatus;
    }

    public String getStuedu() {
        return stuedu;
    }

    public void setStuedu(String stuedu) {
        this.stuedu = stuedu;
    }

    public String getJobtitle() {
        return jobtitle;
    }

    public void setJobtitle(String jobtitle) {
        this.jobtitle = jobtitle;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getWbunit() {
        return wbunit;
    }

    public void setWbunit(String wbunit) {
        this.wbunit = wbunit;
    }

    public String getNtotalfee() {
        return ntotalfee;
    }

    public void setNtotalfee(String ntotalfee) {
        this.ntotalfee = ntotalfee;
    }

    public List<SignupbodysData> getSignupbodys() {
        return signupbodys;
    }

    public void setSignupbodys(List<SignupbodysData> signupbodys) {
        this.signupbodys = signupbodys;
    }

    public int getStusex() {
        return stusex;
    }

    public void setStusex(int stusex) {
        this.stusex = stusex;
    }

    public String getCurpost() {
        return curpost;
    }

    public void setCurpost(String curpost) {
        this.curpost = curpost;
    }
}
