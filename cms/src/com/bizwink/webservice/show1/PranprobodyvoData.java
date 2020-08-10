package com.bizwink.webservice.show1;

import java.io.Serializable;

public class PranprobodyvoData implements Serializable {
    private static final long serialVersionUID = 8841511182055901148L;
    private String pk_special;

    private String pk_class;

    private String dclasshour;

    private String dclassfee;

    public String getPk_special() {
        return pk_special;
    }

    public void setPk_special(String pk_special) {
        this.pk_special = pk_special;
    }

    public String getPk_class() {
        return pk_class;
    }

    public void setPk_class(String pk_class) {
        this.pk_class = pk_class;
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
