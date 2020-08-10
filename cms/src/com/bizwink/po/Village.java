package com.bizwink.po;

import java.io.Serializable;
import java.math.BigDecimal;

public class Village implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column EN_VILLAGE.ID
     *
     * @mbggenerated
     */
    private BigDecimal ID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column EN_VILLAGE.PID
     *
     * @mbggenerated
     */
    private BigDecimal ORDERID;
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column EN_VILLAGE.PID
     *
     * @mbggenerated
     */
    private BigDecimal TOWNID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column EN_VILLAGE.NAME
     *
     * @mbggenerated
     */
    private String VILLAGENAME;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column EN_VILLAGE.VILLAGECODE
     *
     * @mbggenerated
     */
    private String CODE;


    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column EN_VILLAGE.VALID
     *
     * @mbggenerated
     */
    private BigDecimal VALID;

    private String SELFCODE;

    private String PSELFCODE;


    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column EN_VILLAGE.ID
     *
     * @return the value of EN_VILLAGE.ID
     *
     * @mbggenerated
     */
    public BigDecimal getID() {
        return ID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column EN_VILLAGE.ID
     *
     * @param ID the value for EN_VILLAGE.ID
     *
     * @mbggenerated
     */
    public void setID(BigDecimal ID) {
        this.ID = ID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column EN_VILLAGE.CODE
     *
     * @return the value of EN_VILLAGE.CODE
     *
     * @mbggenerated
     */
    public String getCODE() {
        return CODE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column EN_VILLAGE.CODE
     *
     * @param CODE the value for EN_VILLAGE.CODE
     *
     * @mbggenerated
     */
    public void setCODE(String CODE) {
        this.CODE = CODE == null ? null : CODE.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column EN_VILLAGE.NAME
     *
     * @return the value of EN_VILLAGE.NAME
     *
     * @mbggenerated
     */
    public String getVILLAGENAME() {
        return VILLAGENAME;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column EN_VILLAGE.NAME
     *
     * @param NAME the value for EN_VILLAGE.NAME
     *
     * @mbggenerated
     */
    public void setVILLAGENAME(String NAME) {
        this.VILLAGENAME = NAME == null ? null : NAME.trim();
    }

    public BigDecimal getTOWNID() {
        return TOWNID;
    }

    public void setTOWNID(BigDecimal TOWNID) {
        this.TOWNID = TOWNID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column EN_VILLAGE.PID
     *
     * @return the value of EN_VILLAGE.PID
     *
     * @mbggenerated
     */
    public BigDecimal getORDERID() {
        return ORDERID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column EN_VILLAGE.PID
     *
     * @param ORDERID the value for EN_VILLAGE.PID
     *
     * @mbggenerated
     */
    public void setORDERID(BigDecimal ORDERID) {
        this.ORDERID = ORDERID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column EN_VILLAGE.VALID
     *
     * @return the value of EN_VILLAGE.VALID
     *
     * @mbggenerated
     */
    public BigDecimal getVALID() {
        return VALID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column EN_VILLAGE.VALID
     *
     * @param VALID the value for EN_VILLAGE.VALID
     *
     * @mbggenerated
     */
    public void setVALID(BigDecimal VALID) {
        this.VALID = VALID;
    }

    public String getSELFCODE() {
        return SELFCODE;
    }

    public void setSELFCODE(String SELFCODE) {
        this.SELFCODE = SELFCODE;
    }

    public String getPSELFCODE() {
        return PSELFCODE;
    }

    public void setPSELFCODE(String PSELFCODE) {
        this.PSELFCODE = PSELFCODE;
    }
}