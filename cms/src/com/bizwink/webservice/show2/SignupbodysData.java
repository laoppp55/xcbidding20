package com.bizwink.webservice.show2;

import java.io.Serializable;

public class SignupbodysData implements Serializable {
    private static final long serialVersionUID = 8841511182055901148L;

    private String pk_classs;

    private String dclasshour;

    private String dclassfee;


    public String getPk_classs() {
        return pk_classs;
    }

    public void setPk_classs(String pk_classs) {
        this.pk_classs = pk_classs;
    }

    public String getDclasshour() {
        return dclasshour;
    }

    public void setDclasshour(String dclasshour) {
        this.dclasshour = dclasshour;
    }

    public String getDclassfee() {
        return dclassfee;
    }

    public void setDclassfee(String dclassfee) {
        this.dclassfee = dclassfee;
    }
}
