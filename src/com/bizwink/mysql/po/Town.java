package com.bizwink.mysql.po;

import java.io.Serializable;

public class Town implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_town.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_town.orderid
     *
     * @mbggenerated
     */
    private Integer orderid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_town.zoneid
     *
     * @mbggenerated
     */
    private Integer zoneid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_town.townname
     *
     * @mbggenerated
     */
    private String townname;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_town.valid
     *
     * @mbggenerated
     */
    private Integer valid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_town.code
     *
     * @mbggenerated
     */
    private String code;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_town.id
     *
     * @return the value of en_town.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_town.id
     *
     * @param id the value for en_town.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_town.orderid
     *
     * @return the value of en_town.orderid
     *
     * @mbggenerated
     */
    public Integer getOrderid() {
        return orderid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_town.orderid
     *
     * @param orderid the value for en_town.orderid
     *
     * @mbggenerated
     */
    public void setOrderid(Integer orderid) {
        this.orderid = orderid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_town.zoneid
     *
     * @return the value of en_town.zoneid
     *
     * @mbggenerated
     */
    public Integer getZoneid() {
        return zoneid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_town.zoneid
     *
     * @param zoneid the value for en_town.zoneid
     *
     * @mbggenerated
     */
    public void setZoneid(Integer zoneid) {
        this.zoneid = zoneid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_town.townname
     *
     * @return the value of en_town.townname
     *
     * @mbggenerated
     */
    public String getTownname() {
        return townname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_town.townname
     *
     * @param townname the value for en_town.townname
     *
     * @mbggenerated
     */
    public void setTownname(String townname) {
        this.townname = townname == null ? null : townname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_town.valid
     *
     * @return the value of en_town.valid
     *
     * @mbggenerated
     */
    public Integer getValid() {
        return valid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_town.valid
     *
     * @param valid the value for en_town.valid
     *
     * @mbggenerated
     */
    public void setValid(Integer valid) {
        this.valid = valid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_town.code
     *
     * @return the value of en_town.code
     *
     * @mbggenerated
     */
    public String getCode() {
        return code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_town.code
     *
     * @param code the value for en_town.code
     *
     * @mbggenerated
     */
    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }
}