package com.bizwink.vo;

import java.io.Serializable;

public class voBulletinNotice implements Serializable{
    private String uuid;
    private String purchaseprojcode;
    private String purchaseprojname;
    private String bulletintitle;
    private String xcprojectcode;
    private int type;
    private int status;
    private String agentname;
    private String publishtime;
    private String createtime;
    private int readflag;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getPurchaseprojcode() {
        return purchaseprojcode;
    }

    public void setPurchaseprojcode(String purchaseprojcode) {
        this.purchaseprojcode = purchaseprojcode;
    }

    public String getPurchaseprojname() {
        return purchaseprojname;
    }

    public void setPurchaseprojname(String purchaseprojname) {
        this.purchaseprojname = purchaseprojname;
    }

    public String getBulletintitle() {
        return bulletintitle;
    }

    public void setBulletintitle(String bulletintitle) {
        this.bulletintitle = bulletintitle;
    }

    public String getXcprojectcode() {
        return xcprojectcode;
    }

    public void setXcprojectcode(String xcprojectcode) {
        this.xcprojectcode = xcprojectcode;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public int getReadflag() {
        return readflag;
    }

    public void setReadflag(int readflag) {
        this.readflag = readflag;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAgentname() {
        return agentname;
    }

    public void setAgentname(String agentname) {
        this.agentname = agentname;
    }

    public String getPublishtime() {
        return publishtime;
    }

    public void setPublishtime(String publishtime) {
        this.publishtime = publishtime;
    }
}
