package com.bizwink.po;

import java.io.Serializable;
import java.math.BigDecimal;

public class ColumnIDS implements Serializable {
    private BigDecimal ID;
    private BigDecimal SITEID;
    private BigDecimal PARENTID;

    public BigDecimal getID() {
        return ID;
    }

    public void setID(BigDecimal ID) {
        this.ID = ID;
    }

    public BigDecimal getSITEID() {
        return SITEID;
    }

    public void setSITEID(BigDecimal SITEID) {
        this.SITEID = SITEID;
    }

    public BigDecimal getPARENTID() {
        return PARENTID;
    }

    public void setPARENTID(BigDecimal PARENTID) {
        this.PARENTID = PARENTID;
    }
}
