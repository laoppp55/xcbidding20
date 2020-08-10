package com.bizwink.cms.entity;

import java.sql.Timestamp;

public class UserCaInfo {
    private String userid;
    private String username;
    private String subjectCompanyCode;
    private String source;
    private String keyType;
    private String snKey;
    private String certNum;
    private String dataStatus;
    private String extendParam;
    private Timestamp updateTime;
    private String platformCode;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSubjectCompanyCode() {
        return subjectCompanyCode;
    }

    public void setSubjectCompanyCode(String subjectCompanyCode) {
        this.subjectCompanyCode = subjectCompanyCode;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getKeyType() {
        return keyType;
    }

    public void setKeyType(String keyType) {
        this.keyType = keyType;
    }

    public String getSnKey() {
        return snKey;
    }

    public void setSnKey(String snKey) {
        this.snKey = snKey;
    }

    public String getCertNum() {
        return certNum;
    }

    public void setCertNum(String certNum) {
        this.certNum = certNum;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

    public String getExtendParam() {
        return extendParam;
    }

    public void setExtendParam(String extendParam) {
        this.extendParam = extendParam;
    }

    public Timestamp getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public String getPlatformCode() {
        return platformCode;
    }

    public void setPlatformCode(String platformCode) {
        this.platformCode = platformCode;
    }
}
