package com.bizwink.mysql.po;

import java.io.Serializable;

public class SitesNumber implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_sites_number.ipaddress
     *
     * @mbggenerated
     */
    private String ipaddress;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_sites_number.sitesnum
     *
     * @mbggenerated
     */
    private Integer sitesnum;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_sites_number.hashcode
     *
     * @mbggenerated
     */
    private Integer hashcode;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_sites_number.ipaddress
     *
     * @return the value of tbl_sites_number.ipaddress
     *
     * @mbggenerated
     */
    public String getIpaddress() {
        return ipaddress;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_sites_number.ipaddress
     *
     * @param ipaddress the value for tbl_sites_number.ipaddress
     *
     * @mbggenerated
     */
    public void setIpaddress(String ipaddress) {
        this.ipaddress = ipaddress == null ? null : ipaddress.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_sites_number.sitesnum
     *
     * @return the value of tbl_sites_number.sitesnum
     *
     * @mbggenerated
     */
    public Integer getSitesnum() {
        return sitesnum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_sites_number.sitesnum
     *
     * @param sitesnum the value for tbl_sites_number.sitesnum
     *
     * @mbggenerated
     */
    public void setSitesnum(Integer sitesnum) {
        this.sitesnum = sitesnum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_sites_number.hashcode
     *
     * @return the value of tbl_sites_number.hashcode
     *
     * @mbggenerated
     */
    public Integer getHashcode() {
        return hashcode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_sites_number.hashcode
     *
     * @param hashcode the value for tbl_sites_number.hashcode
     *
     * @mbggenerated
     */
    public void setHashcode(Integer hashcode) {
        this.hashcode = hashcode;
    }
}