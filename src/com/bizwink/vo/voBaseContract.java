package com.bizwink.vo;

import java.io.Serializable;

public class voBaseContract implements Serializable {
    private String uuid;
    private String contarctName;
    private String createtime;
    private int readflag;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getContarctName() {
        return contarctName;
    }

    public void setContarctName(String contarctName) {
        this.contarctName = contarctName;
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
}
