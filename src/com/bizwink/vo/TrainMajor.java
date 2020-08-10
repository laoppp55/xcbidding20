package com.bizwink.vo;

import java.io.Serializable;

public class TrainMajor  implements Serializable {
     private String majorcode;
     private String major;

    public String getMajorcode() {
        return majorcode;
    }

    public void setMajorcode(String majorcode) {
        this.majorcode = majorcode;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }
}
