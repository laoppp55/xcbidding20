package com.bizwink.mysql.po;

import java.io.Serializable;

public class Siteipinfo implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.siteid
     *
     * @mbggenerated
     */
    private Integer siteid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.siteip
     *
     * @mbggenerated
     */
    private String siteip;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.sitename
     *
     * @mbggenerated
     */
    private String sitename;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.docpath
     *
     * @mbggenerated
     */
    private String docpath;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.ftpuser
     *
     * @mbggenerated
     */
    private String ftpuser;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.ftppasswd
     *
     * @mbggenerated
     */
    private String ftppasswd;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.ftptype
     *
     * @mbggenerated
     */
    private Integer ftptype;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.publishway
     *
     * @mbggenerated
     */
    private Short publishway;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_siteipinfo.status
     *
     * @mbggenerated
     */
    private Short status;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.id
     *
     * @return the value of tbl_siteipinfo.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.id
     *
     * @param id the value for tbl_siteipinfo.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.siteid
     *
     * @return the value of tbl_siteipinfo.siteid
     *
     * @mbggenerated
     */
    public Integer getSiteid() {
        return siteid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.siteid
     *
     * @param siteid the value for tbl_siteipinfo.siteid
     *
     * @mbggenerated
     */
    public void setSiteid(Integer siteid) {
        this.siteid = siteid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.siteip
     *
     * @return the value of tbl_siteipinfo.siteip
     *
     * @mbggenerated
     */
    public String getSiteip() {
        return siteip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.siteip
     *
     * @param siteip the value for tbl_siteipinfo.siteip
     *
     * @mbggenerated
     */
    public void setSiteip(String siteip) {
        this.siteip = siteip == null ? null : siteip.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.sitename
     *
     * @return the value of tbl_siteipinfo.sitename
     *
     * @mbggenerated
     */
    public String getSitename() {
        return sitename;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.sitename
     *
     * @param sitename the value for tbl_siteipinfo.sitename
     *
     * @mbggenerated
     */
    public void setSitename(String sitename) {
        this.sitename = sitename == null ? null : sitename.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.docpath
     *
     * @return the value of tbl_siteipinfo.docpath
     *
     * @mbggenerated
     */
    public String getDocpath() {
        return docpath;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.docpath
     *
     * @param docpath the value for tbl_siteipinfo.docpath
     *
     * @mbggenerated
     */
    public void setDocpath(String docpath) {
        this.docpath = docpath == null ? null : docpath.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.ftpuser
     *
     * @return the value of tbl_siteipinfo.ftpuser
     *
     * @mbggenerated
     */
    public String getFtpuser() {
        return ftpuser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.ftpuser
     *
     * @param ftpuser the value for tbl_siteipinfo.ftpuser
     *
     * @mbggenerated
     */
    public void setFtpuser(String ftpuser) {
        this.ftpuser = ftpuser == null ? null : ftpuser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.ftppasswd
     *
     * @return the value of tbl_siteipinfo.ftppasswd
     *
     * @mbggenerated
     */
    public String getFtppasswd() {
        return ftppasswd;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.ftppasswd
     *
     * @param ftppasswd the value for tbl_siteipinfo.ftppasswd
     *
     * @mbggenerated
     */
    public void setFtppasswd(String ftppasswd) {
        this.ftppasswd = ftppasswd == null ? null : ftppasswd.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.ftptype
     *
     * @return the value of tbl_siteipinfo.ftptype
     *
     * @mbggenerated
     */
    public Integer getFtptype() {
        return ftptype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.ftptype
     *
     * @param ftptype the value for tbl_siteipinfo.ftptype
     *
     * @mbggenerated
     */
    public void setFtptype(Integer ftptype) {
        this.ftptype = ftptype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.publishway
     *
     * @return the value of tbl_siteipinfo.publishway
     *
     * @mbggenerated
     */
    public Short getPublishway() {
        return publishway;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.publishway
     *
     * @param publishway the value for tbl_siteipinfo.publishway
     *
     * @mbggenerated
     */
    public void setPublishway(Short publishway) {
        this.publishway = publishway;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_siteipinfo.status
     *
     * @return the value of tbl_siteipinfo.status
     *
     * @mbggenerated
     */
    public Short getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_siteipinfo.status
     *
     * @param status the value for tbl_siteipinfo.status
     *
     * @mbggenerated
     */
    public void setStatus(Short status) {
        this.status = status;
    }
}