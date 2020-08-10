<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.bizwink.util.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bizwink.weixin.*" %>
<%
    //发送 POST 请求
    //appSecret:168d9e4a2989c9f30ba38e48559060d4
    //appid: wx4ed8404ab6e53a0d
    //dx.coosite.com
    String accessTikenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx4ed8404ab6e53a0d&secret=168d9e4a2989c9f30ba38e48559060d4";

    //appSecret:5296fdc65726198a5a8a5dcab08bf2d0
    //appid: wx9ec0c0c2b1427624
    //www.pxzx-bucg.cn
    //String accessTikenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx9ec0c0c2b1427624&secret=5296fdc65726198a5a8a5dcab08bf2d0";
    String result = HttpUtility.urlSendPost(accessTikenUrl,"");
    JSONObject jsonObject=JSONObject.fromObject(result);
    AccessTokenResult accessTokenResult=(AccessTokenResult) JSONObject.toBean(jsonObject, AccessTokenResult.class);
    String jsapi_url="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + accessTokenResult.getAccess_token() + "&type=jsapi";
    result = HttpUtility.urlSendPost(jsapi_url,"");
    jsonObject=JSONObject.fromObject(result);
    JsapiTicket jsapiTicket = (JsapiTicket)JSONObject.toBean(jsonObject,JsapiTicket.class);
    System.out.println(jsapiTicket.getErrcode() + "=" + jsapiTicket.getErrmsg() + "=" + jsapiTicket.getExpires_in() + jsapiTicket.getTicket());

    String noncestr = WXUtil.create_nonce_str();
    String timestamp = WXUtil.create_timestamp();

    String sign_str="jsapi_ticket=" + jsapiTicket.getTicket() + "&noncestr=" + noncestr + "&timestamp=" + timestamp + "&url=http://www.pxzx-bucg.cn/users/smqiandao.jsp";
    System.out.println(sign_str);
    String signature = WXUtil.getSha1(sign_str);
    System.out.println(signature);
    JsapiSignInfo jsapiSignInfo = new JsapiSignInfo();
    jsapiSignInfo.setJsapiticket(jsapiTicket.getTicket());
    jsapiSignInfo.setNoncestr(noncestr);
    jsapiSignInfo.setTimestamp(timestamp);
    jsapiSignInfo.setSignature(signature);
    jsapiSignInfo.setUrl("http://www.pxzx-bucg.cn/users/smqiandao.jsp");

    Gson gson = new Gson();
    String jsonData = null;
    if (result != null) {
        jsonData = gson.toJson(jsapiSignInfo);
        System.out.println(jsonData);
    }else
        jsonData = "{\"result\":\"false\"}";

    JSON.setPrintWriter(response, jsonData,"utf-8");
%>