package com.bizwink.webservice.show;

import java.io.Serializable;
import java.util.List;

public  class FirstLevelData implements Serializable {
        private static final long serialVersionUID = 4973784296461198585L;

        private String srcsystem;

        private String busidate;

        private List<DataObject> data;

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

        public List<DataObject> getData() {
            return data;
        }

        public void setData(List<DataObject> data) {
            this.data = data;
        }

    }