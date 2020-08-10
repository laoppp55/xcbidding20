package com.bizwink.webservice.show1;

import java.io.Serializable;
import java.util.List;

public class DataObj implements Serializable {

    private static final long serialVersionUID = -2528670534592625424L;

    private String pk_tranpro; //项目库主键NC唯一标识

    private String pk_tranprotype;

    private  String pk_pnum;

    private String tranproinfo;  //培训内容

    private String billno;

    private String tranproname;

    private String dbegindate;

    private String denddate;

    private String ntrandays;

    private String tranposition;

    private String pk_cbf;

    private String pk_cbfpsn;

    private String cbflkman;

    private String cbflkmantel;

    private String hzcbf;

    private String hzcbfpsn;

    private String hzcbflkman;

    private String hzcbflkmantel;

    private String pk_zbf;

    private String zbfpsn;

    private String zbflkman;

    private String zbflkmantel;

    private String ntranpsnnum;

    private String nmngpsnnum;

    private List<PranprobodyvoData> pranprobodyvo;


    public String getTranproinfo() {
        return tranproinfo;
    }

    public void setTranproinfo(String tranproinfo) {
        this.tranproinfo = tranproinfo;
    }

    public String getPk_tranpro() {
        return pk_tranpro;
    }

    public void setPk_tranpro(String pk_tranpro) {
        this.pk_tranpro = pk_tranpro;
    }

    public String getPk_tranprotype() {
        return pk_tranprotype;
    }

    public void setPk_tranprotype(String pk_tranprotype) {
        this.pk_tranprotype = pk_tranprotype;
    }

    public String getPk_pnum() {
        return pk_pnum;
    }

    public void setPk_pnum(String pk_pnum) {
        this.pk_pnum = pk_pnum;
    }

    public String getBillno() {
        return billno;
    }

    public void setBillno(String billno) {
        this.billno = billno;
    }

    public String getTranproname() {
        return tranproname;
    }

    public void setTranproname(String tranproname) {
        this.tranproname = tranproname;
    }

    public String getDbegindate() {
        return dbegindate;
    }

    public void setDbegindate(String dbegindate) {
        this.dbegindate = dbegindate;
    }

    public String getDenddate() {
        return denddate;
    }

    public void setDenddate(String denddate) {
        this.denddate = denddate;
    }

    public String getNtrandays() {
        return ntrandays;
    }

    public void setNtrandays(String ntrandays) {
        this.ntrandays = ntrandays;
    }

    public String getTranposition() {
        return tranposition;
    }

    public void setTranposition(String tranposition) {
        this.tranposition = tranposition;
    }

    public String getPk_cbf() {
        return pk_cbf;
    }

    public void setPk_cbf(String pk_cbf) {
        this.pk_cbf = pk_cbf;
    }

    public String getPk_cbfpsn() {
        return pk_cbfpsn;
    }

    public void setPk_cbfpsn(String pk_cbfpsn) {
        this.pk_cbfpsn = pk_cbfpsn;
    }

    public String getCbflkman() {
        return cbflkman;
    }

    public void setCbflkman(String cbflkman) {
        this.cbflkman = cbflkman;
    }

    public String getCbflkmantel() {
        return cbflkmantel;
    }

    public void setCbflkmantel(String cbflkmantel) {
        this.cbflkmantel = cbflkmantel;
    }

    public String getHzcbf() {
        return hzcbf;
    }

    public void setHzcbf(String hzcbf) {
        this.hzcbf = hzcbf;
    }

    public String getHzcbfpsn() {
        return hzcbfpsn;
    }

    public void setHzcbfpsn(String hzcbfpsn) {
        this.hzcbfpsn = hzcbfpsn;
    }

    public String getHzcbflkman() {
        return hzcbflkman;
    }

    public void setHzcbflkman(String hzcbflkman) {
        this.hzcbflkman = hzcbflkman;
    }

    public String getHzcbflkmantel() {
        return hzcbflkmantel;
    }

    public void setHzcbflkmantel(String hzcbflkmantel) {
        this.hzcbflkmantel = hzcbflkmantel;
    }

    public String getPk_zbf() {
        return pk_zbf;
    }

    public void setPk_zbf(String pk_zbf) {
        this.pk_zbf = pk_zbf;
    }

    public String getZbfpsn() {
        return zbfpsn;
    }

    public void setZbfpsn(String zbfpsn) {
        this.zbfpsn = zbfpsn;
    }

    public String getZbflkman() {
        return zbflkman;
    }

    public void setZbflkman(String zbflkman) {
        this.zbflkman = zbflkman;
    }

    public String getZbflkmantel() {
        return zbflkmantel;
    }

    public void setZbflkmantel(String zbflkmantel) {
        this.zbflkmantel = zbflkmantel;
    }

    public String getNtranpsnnum() {
        return ntranpsnnum;
    }

    public void setNtranpsnnum(String ntranpsnnum) {
        this.ntranpsnnum = ntranpsnnum;
    }

    public String getNmngpsnnum() {
        return nmngpsnnum;
    }

    public void setNmngpsnnum(String nmngpsnnum) {
        this.nmngpsnnum = nmngpsnnum;
    }

    public List<PranprobodyvoData> getPranprobodyvo() {
        return pranprobodyvo;
    }

    public void setPranprobodyvo(List<PranprobodyvoData> pranprobodyvo) {
        this.pranprobodyvo = pranprobodyvo;
    }
}
