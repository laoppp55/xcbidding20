package com.bizwink.cms.refers;

import java.sql.Timestamp;

/**
 * Created by IntelliJ IDEA.
 * User: Du Zhenqiang
 * Date: 2008-2-18
 * Time: 17:37:23
 */
public class Refers {

    private int id;
    private int articleid;
    private int siteid;
    private int ssiteid;
    private int columnid;
    private int scolumnid;
    private String columnname;
    private String title;
    private int status;
    private int pubflag;
    private int auditflag;
    private Timestamp createdate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getArticleid() {
        return articleid;
    }

    public void setArticleid(int articleid) {
        this.articleid = articleid;
    }

    public int getSiteid() {
        return siteid;
    }

    public void setSiteid(int siteid) {
        this.siteid = siteid;
    }

    public int getSsiteid() {
        return ssiteid;
    }

    public void setSsiteid(int ssiteid) {
        this.ssiteid = ssiteid;
    }

    public int getColumnid() {
        return columnid;
    }

    public void setColumnid(int columnid) {
        this.columnid = columnid;
    }

    public int getScolumnid() {
        return scolumnid;
    }

    public void setScolumnid(int scolumnid) {
        this.scolumnid = scolumnid;
    }

    public String getColumnname() {
        return columnname;
    }

    public void setColumnname(String columnname) {
        this.columnname = columnname;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPubflag() {
        return pubflag;
    }

    public void setPubflag(int pubflag) {
        this.pubflag = pubflag;
    }

    public int getAuditflag() {
        return auditflag;
    }

    public void setAuditflag(int auditflag) {
        this.auditflag = auditflag;
    }

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }
}
