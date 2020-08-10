package com.bizwink.cms.entity;

public class ApplyCreditResult {
    private String result;               //成功状态success
    private String status;               //-1：未授信，0：审核中，1：审核通过，2：审核不通过
    private String expiry_date;         //授信截止时间，审核通过时必填
    private String annual_rate;         //费率描述
    private String credit_limit;        //授信额度，单位元，审核通过时必填
    private String credit_usable;       //可用额度，单位元，审核通过时必填
    private String error;                //审核不通过原因

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getExpiry_date() {
        return expiry_date;
    }

    public void setExpiry_date(String expiry_date) {
        this.expiry_date = expiry_date;
    }

    public String getAnnual_rate() {
        return annual_rate;
    }

    public void setAnnual_rate(String annual_rate) {
        this.annual_rate = annual_rate;
    }

    public String getCredit_limit() {
        return credit_limit;
    }

    public void setCredit_limit(String credit_limit) {
        this.credit_limit = credit_limit;
    }

    public String getCredit_usable() {
        return credit_usable;
    }

    public void setCredit_usable(String credit_usable) {
        this.credit_usable = credit_usable;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
