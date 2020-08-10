package com.bizwink.mysql.po;

import java.io.Serializable;

public class City implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_city.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_city.orderid
     *
     * @mbggenerated
     */
    private Integer orderid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_city.provid
     *
     * @mbggenerated
     */
    private Integer provid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_city.cityname
     *
     * @mbggenerated
     */
    private String cityname;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_city.valid
     *
     * @mbggenerated
     */
    private Integer valid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column en_city.code
     *
     * @mbggenerated
     */
    private String code;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_city.id
     *
     * @return the value of en_city.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_city.id
     *
     * @param id the value for en_city.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_city.orderid
     *
     * @return the value of en_city.orderid
     *
     * @mbggenerated
     */
    public Integer getOrderid() {
        return orderid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_city.orderid
     *
     * @param orderid the value for en_city.orderid
     *
     * @mbggenerated
     */
    public void setOrderid(Integer orderid) {
        this.orderid = orderid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_city.provid
     *
     * @return the value of en_city.provid
     *
     * @mbggenerated
     */
    public Integer getProvid() {
        return provid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_city.provid
     *
     * @param provid the value for en_city.provid
     *
     * @mbggenerated
     */
    public void setProvid(Integer provid) {
        this.provid = provid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_city.cityname
     *
     * @return the value of en_city.cityname
     *
     * @mbggenerated
     */
    public String getCityname() {
        return cityname;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_city.cityname
     *
     * @param cityname the value for en_city.cityname
     *
     * @mbggenerated
     */
    public void setCityname(String cityname) {
        this.cityname = cityname == null ? null : cityname.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_city.valid
     *
     * @return the value of en_city.valid
     *
     * @mbggenerated
     */
    public Integer getValid() {
        return valid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_city.valid
     *
     * @param valid the value for en_city.valid
     *
     * @mbggenerated
     */
    public void setValid(Integer valid) {
        this.valid = valid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column en_city.code
     *
     * @return the value of en_city.code
     *
     * @mbggenerated
     */
    public String getCode() {
        return code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column en_city.code
     *
     * @param code the value for en_city.code
     *
     * @mbggenerated
     */
    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }
}