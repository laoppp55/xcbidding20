package com.bizwink.cms.entity;

public class ApplyCreditRetval {
    private String result;     //返回结果信息
    private String accept_no;   //受理编号
    private String page_flow;   //打开页面地址

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getAccept_no() {
        return accept_no;
    }

    public void setAccept_no(String accept_no) {
        this.accept_no = accept_no;
    }

    public String getPage_flow() {
        return page_flow;
    }

    public void setPage_flow(String page_flow) {
        this.page_flow = page_flow;
    }
}
