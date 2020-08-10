package com.bizwink.vo;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

/**
 * Created by Administrator on 17-11-16.
 */
public class VoUser {
    private BigDecimal ID;
    private String USERID;
    private BigDecimal SITEID;
    private String NICKNAME;
    private String EMAIL;
    private String MPHONE;
    private BigDecimal USERTYPE;
    private String CREATEDATE;                   //用户被创建的时间
    private String COMPANY;                      //用户所属的公司名称
    private String ADDRESS;
    private String DEPARTMENT;                      //用户所属的部门名称
    private BigDecimal ORGID;                   //用户所属的组织架构ID
    private BigDecimal COMPANYID;               //用户所属的公司ID
    private BigDecimal DEPTID;                   //用户所属的部门
    private BigDecimal CREATERID;                //用户创建者ID，如果是注册用户为0

    public BigDecimal getID() {
        return ID;
    }

    public void setID(BigDecimal ID) {
        this.ID = ID;
    }

    public String getUSERID() {
        return USERID;
    }

    public void setUSERID(String USERID) {
        this.USERID = USERID;
    }

    public BigDecimal getSITEID() {
        return SITEID;
    }

    public void setSITEID(BigDecimal SITEID) {
        this.SITEID = SITEID;
    }

    public String getNICKNAME() {
        return NICKNAME;
    }

    public void setNICKNAME(String NICKNAME) {
        this.NICKNAME = NICKNAME;
    }

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String EMAIL) {
        this.EMAIL = EMAIL;
    }

    public String getMPHONE() {
        return MPHONE;
    }

    public void setMPHONE(String MPHONE) {
        this.MPHONE = MPHONE;
    }

    public BigDecimal getUSERTYPE() {
        return USERTYPE;
    }

    public void setUSERTYPE(BigDecimal USERTYPE) {
        this.USERTYPE = USERTYPE;
    }

    public String getCREATEDATE() {
        return CREATEDATE;
    }

    public void setCREATEDATE(String CREATEDATE) {
        this.CREATEDATE = CREATEDATE;
    }

    public String getCOMPANY() {
        return COMPANY;
    }

    public void setCOMPANY(String COMPANY) {
        this.COMPANY = COMPANY;
    }

    public String getADDRESS() {
        return ADDRESS;
    }

    public void setADDRESS(String ADDRESS) {
        this.ADDRESS = ADDRESS;
    }

    public String getDEPARTMENT() {
        return DEPARTMENT;
    }

    public void setDEPARTMENT(String DEPARTMENT) {
        this.DEPARTMENT = DEPARTMENT;
    }

    public BigDecimal getORGID() {
        return ORGID;
    }

    public void setORGID(BigDecimal ORGID) {
        this.ORGID = ORGID;
    }

    public BigDecimal getCOMPANYID() {
        return COMPANYID;
    }

    public void setCOMPANYID(BigDecimal COMPANYID) {
        this.COMPANYID = COMPANYID;
    }

    public BigDecimal getDEPTID() {
        return DEPTID;
    }

    public void setDEPTID(BigDecimal DEPTID) {
        this.DEPTID = DEPTID;
    }

    public BigDecimal getCREATERID() {
        return CREATERID;
    }

    public void setCREATERID(BigDecimal CREATERID) {
        this.CREATERID = CREATERID;
    }
}
