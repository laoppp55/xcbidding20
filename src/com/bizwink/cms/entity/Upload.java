package com.bizwink.cms.entity;

public class Upload {
    private long totalSize;                                        //总大小
    private long startTime = System.currentTimeMillis();           //开始时间
    private long uploadSize;                                       //已上传的大小
    private String ret_filename;                                   //服务器生成的文件名

    public long getTotalSize() {
        return totalSize;
    }
    public void setTotalSize(long totalSize) {
        this.totalSize = totalSize;
    }
    public long getStartTime() {
        return startTime;
    }
    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }
    public long getUploadSize() {
        return uploadSize;
    }
    public void setUploadSize(long uploadSize) {
        this.uploadSize = uploadSize;
    }

    public String getRet_filename() {
        return ret_filename;
    }

    public void setRet_filename(String ret_filename) {
        this.ret_filename = ret_filename;
    }
}
