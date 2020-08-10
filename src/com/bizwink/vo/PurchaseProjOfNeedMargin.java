package com.bizwink.vo;

import java.io.Serializable;

public class PurchaseProjOfNeedMargin implements Serializable {
    private String projectName;                   //采购项目名称
    private String projectCode;                   //采购项目编码
    private String projectSectionName;           //采购项目标包名称
    private String projectSectionCode;           //采购项目标包编码
    private String buyer;                         //采购人
    private String buyWay;                        //采购方式
    private double margin;                       //保证金数额，保留两位小数
    private String apply_no;                     //保函申请编号
    private int status;                          //保函申请状态，-1-保存未提交，0-提交，审核中，1-审核通过，2-审核不通过
    private String gl_name;                       //保函申请的名称
    private String accept_no;                     //保函申请受理编号
    private String result;                        //保函申请提交结果
    private String page_flow;                     //加密的保函查看地址
    private String pageflowurl;                   //解密后的保函查看地址
    private String guarantee_url;                //审核通过时，返回电子保函下载（查看）地址
    private String error;                         //审核不通过的原因
    private String createdate;                   //采购项目创建日期

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getProjectSectionName() {
        return projectSectionName;
    }

    public void setProjectSectionName(String projectSectionName) {
        this.projectSectionName = projectSectionName;
    }

    public String getProjectSectionCode() {
        return projectSectionCode;
    }

    public void setProjectSectionCode(String projectSectionCode) {
        this.projectSectionCode = projectSectionCode;
    }

    public String getBuyer() {
        return buyer;
    }

    public void setBuyer(String buyer) {
        this.buyer = buyer;
    }

    public String getBuyWay() {
        return buyWay;
    }

    public void setBuyWay(String buyWay) {
        this.buyWay = buyWay;
    }

    public double getMargin() {
        return margin;
    }

    public void setMargin(double margin) {
        this.margin = margin;
    }

    public String getCreatedate() {
        return createdate;
    }

    public void setCreatedate(String createdate) {
        this.createdate = createdate;
    }

    public String getGl_name() {
        return gl_name;
    }

    public void setGl_name(String gl_name) {
        this.gl_name = gl_name;
    }

    public String getApply_no() {
        return apply_no;
    }

    public void setApply_no(String apply_no) {
        this.apply_no = apply_no;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAccept_no() {
        return accept_no;
    }

    public void setAccept_no(String accept_no) {
        this.accept_no = accept_no;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getPage_flow() {
        return page_flow;
    }

    public void setPage_flow(String page_flow) {
        this.page_flow = page_flow;
    }

    public String getPageflowurl() {
        return pageflowurl;
    }

    public void setPageflowurl(String pageflowurl) {
        this.pageflowurl = pageflowurl;
    }

    public String getGuarantee_url() {
        return guarantee_url;
    }

    public void setGuarantee_url(String guarantee_url) {
        this.guarantee_url = guarantee_url;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
