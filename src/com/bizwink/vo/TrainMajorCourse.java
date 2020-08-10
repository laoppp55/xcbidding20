package com.bizwink.vo;

import java.io.Serializable;

public class TrainMajorCourse  implements Serializable {
    private String classcode;
    private String classname;
    private float price;
    private String classhour;

    public String getClasscode() {
        return classcode;
    }

    public void setClasscode(String classcode) {
        this.classcode = classcode;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getClasshour() {
        return classhour;
    }

    public void setClasshour(String classhour) {
        this.classhour = classhour;
    }
}
