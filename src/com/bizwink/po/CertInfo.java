package com.bizwink.po;

import java.util.Date;

public class CertInfo {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.userid
     *
     * @mbggenerated
     */
    private String userid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.sn
     *
     * @mbggenerated
     */
    private String sn;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.certnum
     *
     * @mbggenerated
     */
    private String certnum;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.certpublisher
     *
     * @mbggenerated
     */
    private String certpublisher;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.certpublishercode
     *
     * @mbggenerated
     */
    private String certpublishercode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_certinfo.createdate
     *
     * @mbggenerated
     */
    private Date createdate;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.id
     *
     * @return the value of tbl_certinfo.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.id
     *
     * @param id the value for tbl_certinfo.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.userid
     *
     * @return the value of tbl_certinfo.userid
     *
     * @mbggenerated
     */
    public String getUserid() {
        return userid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.userid
     *
     * @param userid the value for tbl_certinfo.userid
     *
     * @mbggenerated
     */
    public void setUserid(String userid) {
        this.userid = userid == null ? null : userid.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.sn
     *
     * @return the value of tbl_certinfo.sn
     *
     * @mbggenerated
     */
    public String getSn() {
        return sn;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.sn
     *
     * @param sn the value for tbl_certinfo.sn
     *
     * @mbggenerated
     */
    public void setSn(String sn) {
        this.sn = sn == null ? null : sn.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.certnum
     *
     * @return the value of tbl_certinfo.certnum
     *
     * @mbggenerated
     */
    public String getCertnum() {
        return certnum;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.certnum
     *
     * @param certnum the value for tbl_certinfo.certnum
     *
     * @mbggenerated
     */
    public void setCertnum(String certnum) {
        this.certnum = certnum == null ? null : certnum.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.certpublisher
     *
     * @return the value of tbl_certinfo.certpublisher
     *
     * @mbggenerated
     */
    public String getCertpublisher() {
        return certpublisher;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.certpublisher
     *
     * @param certpublisher the value for tbl_certinfo.certpublisher
     *
     * @mbggenerated
     */
    public void setCertpublisher(String certpublisher) {
        this.certpublisher = certpublisher == null ? null : certpublisher.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.certpublishercode
     *
     * @return the value of tbl_certinfo.certpublishercode
     *
     * @mbggenerated
     */
    public String getCertpublishercode() {
        return certpublishercode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.certpublishercode
     *
     * @param certpublishercode the value for tbl_certinfo.certpublishercode
     *
     * @mbggenerated
     */
    public void setCertpublishercode(String certpublishercode) {
        this.certpublishercode = certpublishercode == null ? null : certpublishercode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_certinfo.createdate
     *
     * @return the value of tbl_certinfo.createdate
     *
     * @mbggenerated
     */
    public Date getCreatedate() {
        return createdate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_certinfo.createdate
     *
     * @param createdate the value for tbl_certinfo.createdate
     *
     * @mbggenerated
     */
    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }
}