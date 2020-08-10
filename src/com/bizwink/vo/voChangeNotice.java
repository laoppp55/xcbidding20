package com.bizwink.vo;

import java.io.Serializable;

public class voChangeNotice implements Serializable {
    private String uuid;
    private String Bulletintitle;
    private String Createtime;
    private int readflag;


    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getBulletintitle() {
        return Bulletintitle;
    }

    public void setBulletintitle(String bulletintitle) {
        Bulletintitle = bulletintitle;
    }

    public String getCreatetime() {
        return Createtime;
    }

    public void setCreatetime(String createtime) {
        Createtime = createtime;
    }

    public int getReadflag() {
        return readflag;
    }

    public void setReadflag(int readflag) {
        this.readflag = readflag;
    }
}
