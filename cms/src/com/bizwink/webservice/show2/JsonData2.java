package com.bizwink.webservice.show2;

import java.io.Serializable;
import java.util.List;

public class JsonData2 implements Serializable {

    private static final long serialVersionUID = 5583219926137112302L;

    private String srcsystem;

    private String busidate;

    private List<DataObj2> data;

    public String getSrcsystem() {
        return srcsystem;
    }

    public void setSrcsystem(String srcsystem) {
        this.srcsystem = srcsystem;
    }

    public String getBusidate() {
        return busidate;
    }

    public void setBusidate(String busidate) {
        this.busidate = busidate;
    }

    public List<DataObj2> getData() {
        return data;
    }

    public void setData(List<DataObj2> data) {
        this.data = data;
    }
}
