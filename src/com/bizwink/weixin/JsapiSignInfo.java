package com.bizwink.weixin;

public class JsapiSignInfo {
    private String jsapiticket;
    private String noncestr;
    private String timestamp;
    private String url;
    private String signature;

    public String getJsapiticket() {
        return jsapiticket;
    }

    public void setJsapiticket(String jsapiticket) {
        this.jsapiticket = jsapiticket;
    }

    public String getNoncestr() {
        return noncestr;
    }

    public void setNoncestr(String noncestr) {
        this.noncestr = noncestr;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }
}
