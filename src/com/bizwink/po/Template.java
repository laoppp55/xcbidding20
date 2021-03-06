package com.bizwink.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Template  implements Serializable {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.ID
     *
     * @mbggenerated
     */
    private BigDecimal ID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.SITEID
     *
     * @mbggenerated
     */
    private BigDecimal SITEID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.COLUMNID
     *
     * @mbggenerated
     */
    private BigDecimal COLUMNID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.ISARTICLE
     *
     * @mbggenerated
     */
    private Short ISARTICLE;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.CREATEDATE
     *
     * @mbggenerated
     */
    private Date CREATEDATE;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.LASTUPDATED
     *
     * @mbggenerated
     */
    private Date LASTUPDATED;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.EDITOR
     *
     * @mbggenerated
     */
    private String EDITOR;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.CREATOR
     *
     * @mbggenerated
     */
    private String CREATOR;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.STATUS
     *
     * @mbggenerated
     */
    private Short STATUS;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.RELATEDCOLUMNID
     *
     * @mbggenerated
     */
    private String RELATEDCOLUMNID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.MODELVERSION
     *
     * @mbggenerated
     */
    private BigDecimal MODELVERSION;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.LOCKSTATUS
     *
     * @mbggenerated
     */
    private Short LOCKSTATUS;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.LOCKEDITOR
     *
     * @mbggenerated
     */
    private String LOCKEDITOR;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.CHNAME
     *
     * @mbggenerated
     */
    private String CHNAME;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.DEFAULTTEMPLATE
     *
     * @mbggenerated
     */
    private Short DEFAULTTEMPLATE;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.TEMPLATENAME
     *
     * @mbggenerated
     */
    private String TEMPLATENAME;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.REFERMODELID
     *
     * @mbggenerated
     */
    private BigDecimal REFERMODELID;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.ISINCLUDED
     *
     * @mbggenerated
     */
    private Short ISINCLUDED;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.TEMPNUM
     *
     * @mbggenerated
     */
    private BigDecimal TEMPNUM;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column TBL_TEMPLATE.CONTENT
     *
     * @mbggenerated
     */
    private String CONTENT;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.ID
     *
     * @return the value of TBL_TEMPLATE.ID
     *
     * @mbggenerated
     */
    public BigDecimal getID() {
        return ID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.ID
     *
     * @param ID the value for TBL_TEMPLATE.ID
     *
     * @mbggenerated
     */
    public void setID(BigDecimal ID) {
        this.ID = ID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.SITEID
     *
     * @return the value of TBL_TEMPLATE.SITEID
     *
     * @mbggenerated
     */
    public BigDecimal getSITEID() {
        return SITEID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.SITEID
     *
     * @param SITEID the value for TBL_TEMPLATE.SITEID
     *
     * @mbggenerated
     */
    public void setSITEID(BigDecimal SITEID) {
        this.SITEID = SITEID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.COLUMNID
     *
     * @return the value of TBL_TEMPLATE.COLUMNID
     *
     * @mbggenerated
     */
    public BigDecimal getCOLUMNID() {
        return COLUMNID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.COLUMNID
     *
     * @param COLUMNID the value for TBL_TEMPLATE.COLUMNID
     *
     * @mbggenerated
     */
    public void setCOLUMNID(BigDecimal COLUMNID) {
        this.COLUMNID = COLUMNID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.ISARTICLE
     *
     * @return the value of TBL_TEMPLATE.ISARTICLE
     *
     * @mbggenerated
     */
    public Short getISARTICLE() {
        return ISARTICLE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.ISARTICLE
     *
     * @param ISARTICLE the value for TBL_TEMPLATE.ISARTICLE
     *
     * @mbggenerated
     */
    public void setISARTICLE(Short ISARTICLE) {
        this.ISARTICLE = ISARTICLE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.CREATEDATE
     *
     * @return the value of TBL_TEMPLATE.CREATEDATE
     *
     * @mbggenerated
     */
    public Date getCREATEDATE() {
        return CREATEDATE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.CREATEDATE
     *
     * @param CREATEDATE the value for TBL_TEMPLATE.CREATEDATE
     *
     * @mbggenerated
     */
    public void setCREATEDATE(Date CREATEDATE) {
        this.CREATEDATE = CREATEDATE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.LASTUPDATED
     *
     * @return the value of TBL_TEMPLATE.LASTUPDATED
     *
     * @mbggenerated
     */
    public Date getLASTUPDATED() {
        return LASTUPDATED;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.LASTUPDATED
     *
     * @param LASTUPDATED the value for TBL_TEMPLATE.LASTUPDATED
     *
     * @mbggenerated
     */
    public void setLASTUPDATED(Date LASTUPDATED) {
        this.LASTUPDATED = LASTUPDATED;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.EDITOR
     *
     * @return the value of TBL_TEMPLATE.EDITOR
     *
     * @mbggenerated
     */
    public String getEDITOR() {
        return EDITOR;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.EDITOR
     *
     * @param EDITOR the value for TBL_TEMPLATE.EDITOR
     *
     * @mbggenerated
     */
    public void setEDITOR(String EDITOR) {
        this.EDITOR = EDITOR == null ? null : EDITOR.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.CREATOR
     *
     * @return the value of TBL_TEMPLATE.CREATOR
     *
     * @mbggenerated
     */
    public String getCREATOR() {
        return CREATOR;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.CREATOR
     *
     * @param CREATOR the value for TBL_TEMPLATE.CREATOR
     *
     * @mbggenerated
     */
    public void setCREATOR(String CREATOR) {
        this.CREATOR = CREATOR == null ? null : CREATOR.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.STATUS
     *
     * @return the value of TBL_TEMPLATE.STATUS
     *
     * @mbggenerated
     */
    public Short getSTATUS() {
        return STATUS;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.STATUS
     *
     * @param STATUS the value for TBL_TEMPLATE.STATUS
     *
     * @mbggenerated
     */
    public void setSTATUS(Short STATUS) {
        this.STATUS = STATUS;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.RELATEDCOLUMNID
     *
     * @return the value of TBL_TEMPLATE.RELATEDCOLUMNID
     *
     * @mbggenerated
     */
    public String getRELATEDCOLUMNID() {
        return RELATEDCOLUMNID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.RELATEDCOLUMNID
     *
     * @param RELATEDCOLUMNID the value for TBL_TEMPLATE.RELATEDCOLUMNID
     *
     * @mbggenerated
     */
    public void setRELATEDCOLUMNID(String RELATEDCOLUMNID) {
        this.RELATEDCOLUMNID = RELATEDCOLUMNID == null ? null : RELATEDCOLUMNID.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.MODELVERSION
     *
     * @return the value of TBL_TEMPLATE.MODELVERSION
     *
     * @mbggenerated
     */
    public BigDecimal getMODELVERSION() {
        return MODELVERSION;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.MODELVERSION
     *
     * @param MODELVERSION the value for TBL_TEMPLATE.MODELVERSION
     *
     * @mbggenerated
     */
    public void setMODELVERSION(BigDecimal MODELVERSION) {
        this.MODELVERSION = MODELVERSION;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.LOCKSTATUS
     *
     * @return the value of TBL_TEMPLATE.LOCKSTATUS
     *
     * @mbggenerated
     */
    public Short getLOCKSTATUS() {
        return LOCKSTATUS;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.LOCKSTATUS
     *
     * @param LOCKSTATUS the value for TBL_TEMPLATE.LOCKSTATUS
     *
     * @mbggenerated
     */
    public void setLOCKSTATUS(Short LOCKSTATUS) {
        this.LOCKSTATUS = LOCKSTATUS;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.LOCKEDITOR
     *
     * @return the value of TBL_TEMPLATE.LOCKEDITOR
     *
     * @mbggenerated
     */
    public String getLOCKEDITOR() {
        return LOCKEDITOR;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.LOCKEDITOR
     *
     * @param LOCKEDITOR the value for TBL_TEMPLATE.LOCKEDITOR
     *
     * @mbggenerated
     */
    public void setLOCKEDITOR(String LOCKEDITOR) {
        this.LOCKEDITOR = LOCKEDITOR == null ? null : LOCKEDITOR.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.CHNAME
     *
     * @return the value of TBL_TEMPLATE.CHNAME
     *
     * @mbggenerated
     */
    public String getCHNAME() {
        return CHNAME;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.CHNAME
     *
     * @param CHNAME the value for TBL_TEMPLATE.CHNAME
     *
     * @mbggenerated
     */
    public void setCHNAME(String CHNAME) {
        this.CHNAME = CHNAME == null ? null : CHNAME.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.DEFAULTTEMPLATE
     *
     * @return the value of TBL_TEMPLATE.DEFAULTTEMPLATE
     *
     * @mbggenerated
     */
    public Short getDEFAULTTEMPLATE() {
        return DEFAULTTEMPLATE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.DEFAULTTEMPLATE
     *
     * @param DEFAULTTEMPLATE the value for TBL_TEMPLATE.DEFAULTTEMPLATE
     *
     * @mbggenerated
     */
    public void setDEFAULTTEMPLATE(Short DEFAULTTEMPLATE) {
        this.DEFAULTTEMPLATE = DEFAULTTEMPLATE;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.TEMPLATENAME
     *
     * @return the value of TBL_TEMPLATE.TEMPLATENAME
     *
     * @mbggenerated
     */
    public String getTEMPLATENAME() {
        return TEMPLATENAME;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.TEMPLATENAME
     *
     * @param TEMPLATENAME the value for TBL_TEMPLATE.TEMPLATENAME
     *
     * @mbggenerated
     */
    public void setTEMPLATENAME(String TEMPLATENAME) {
        this.TEMPLATENAME = TEMPLATENAME == null ? null : TEMPLATENAME.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.REFERMODELID
     *
     * @return the value of TBL_TEMPLATE.REFERMODELID
     *
     * @mbggenerated
     */
    public BigDecimal getREFERMODELID() {
        return REFERMODELID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.REFERMODELID
     *
     * @param REFERMODELID the value for TBL_TEMPLATE.REFERMODELID
     *
     * @mbggenerated
     */
    public void setREFERMODELID(BigDecimal REFERMODELID) {
        this.REFERMODELID = REFERMODELID;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.ISINCLUDED
     *
     * @return the value of TBL_TEMPLATE.ISINCLUDED
     *
     * @mbggenerated
     */
    public Short getISINCLUDED() {
        return ISINCLUDED;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.ISINCLUDED
     *
     * @param ISINCLUDED the value for TBL_TEMPLATE.ISINCLUDED
     *
     * @mbggenerated
     */
    public void setISINCLUDED(Short ISINCLUDED) {
        this.ISINCLUDED = ISINCLUDED;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.TEMPNUM
     *
     * @return the value of TBL_TEMPLATE.TEMPNUM
     *
     * @mbggenerated
     */
    public BigDecimal getTEMPNUM() {
        return TEMPNUM;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.TEMPNUM
     *
     * @param TEMPNUM the value for TBL_TEMPLATE.TEMPNUM
     *
     * @mbggenerated
     */
    public void setTEMPNUM(BigDecimal TEMPNUM) {
        this.TEMPNUM = TEMPNUM;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column TBL_TEMPLATE.CONTENT
     *
     * @return the value of TBL_TEMPLATE.CONTENT
     *
     * @mbggenerated
     */
    public String getCONTENT() {
        return CONTENT;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column TBL_TEMPLATE.CONTENT
     *
     * @param CONTENT the value for TBL_TEMPLATE.CONTENT
     *
     * @mbggenerated
     */
    public void setCONTENT(String CONTENT) {
        this.CONTENT = CONTENT == null ? null : CONTENT.trim();
    }
}