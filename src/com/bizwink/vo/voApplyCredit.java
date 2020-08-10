package com.bizwink.vo;

import java.io.Serializable;

public class voApplyCredit implements Serializable {
    private String uuid;
    private String applyname;
    private String applyno;
    private String createtime;
    private String creator;
    private String uodatetime;
    private String modifier;
    private int status;
    private String acceptno;
    private String pageflow;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getApplyname() {
        return applyname;
    }

    public void setApplyname(String applyname) {
        this.applyname = applyname;
    }

    public String getApplyno() {
        return applyno;
    }

    public void setApplyno(String applyno) {
        this.applyno = applyno;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getUodatetime() {
        return uodatetime;
    }

    public void setUodatetime(String uodatetime) {
        this.uodatetime = uodatetime;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAcceptno() {
        return acceptno;
    }

    public void setAcceptno(String acceptno) {
        this.acceptno = acceptno;
    }

    public String getPageflow() {
        return pageflow;
    }

    public void setPageflow(String pageflow) {
        this.pageflow = pageflow;
    }
}
