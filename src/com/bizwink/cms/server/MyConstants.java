package com.bizwink.cms.server;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 17-4-4.
 */
public class MyConstants {
    private static List<String> columns = new ArrayList<String>();
    private static int totalNum;
    private static boolean initFlag;
    private static int siteid=1;
    private static String version="4.0.2";
    private static String access_key = "88085668";
    private static String secret_key = "70288874";
    private static String platform_id = "ZJXT_XCQ";
    private static String merchant_id = "iandc";
    private static String serviceUrl = "http://103.83.44.14/JFPT-test/api.do";

    //测试环境
    private static String SFTP_ADDRESS = "39.105.96.34";
    private static String SFTP_PORT ="22";
    private static String SFTP_USER = "suppinfo";
    private static String SFTP_PASSWD = "Zaq!2wsx";
    private static String SFTP_ROOTPATH = "/data/project/xicheng/upload";
    private static String SFTP_RELATE_PATH = "upload/30/supp/";
    private static String DOWNLOAD_ADDRESS = "http://39.105.96.34:8084/";

    //生产环境
    //private static String SFTP_ADDRESS = "39.97.119.172";
    //private static String SFTP_PORT ="22";
    //private static String SFTP_USER = "suppinfo";
    //private static String SFTP_PASSWD = "Zaq!2wsx";
    //private static String SFTP_ROOTPATH = "/home/xicheng/upload";
    //private static String SFTP_RELATE_PATH = "upload/30/supp/";
    //private static String DOWNLOAD_ADDRESS = "http://39.97.119.172:8084/";

    public static List<String> getColumns() {
        return columns;
    }

    public static void setColumns(List<String> columns) {
        MyConstants.columns = columns;
    }

    public static int getTotalNum() {
        return totalNum;
    }

    public static void setTotalNum(int totalNum) {
        MyConstants.totalNum = totalNum;
    }

    public static boolean isInitFlag() {
        return initFlag;
    }

    public static void setInitFlag(boolean initFlag) {
        MyConstants.initFlag = initFlag;
    }

    public static int getSiteid() {
        return siteid;
    }

    public static void setSiteid(int siteid) {
        MyConstants.siteid = siteid;
    }

    public static String getVersion() {
        return version;
    }

    public static void setVersion(String version) {
        MyConstants.version = version;
    }

    public static String getAccess_key() {
        return access_key;
    }

    public static void setAccess_key(String access_key) {
        MyConstants.access_key = access_key;
    }

    public static String getSecret_key() {
        return secret_key;
    }

    public static void setSecret_key(String secret_key) {
        MyConstants.secret_key = secret_key;
    }

    public static String getPlatform_id() {
        return platform_id;
    }

    public static void setPlatform_id(String platform_id) {
        MyConstants.platform_id = platform_id;
    }

    public static String getMerchant_id() {
        return merchant_id;
    }

    public static void setMerchant_id(String merchant_id) {
        MyConstants.merchant_id = merchant_id;
    }

    public static String getServiceUrl() {
        return serviceUrl;
    }

    public static void setServiceUrl(String serviceUrl) {
        MyConstants.serviceUrl = serviceUrl;
    }

    public static String getSftpAddress() {
        return SFTP_ADDRESS;
    }

    public static void setSftpAddress(String sftpAddress) {
        SFTP_ADDRESS = sftpAddress;
    }

    public static String getSftpUser() {
        return SFTP_USER;
    }

    public static void setSftpUser(String sftpUser) {
        SFTP_USER = sftpUser;
    }

    public static String getSftpPasswd() {
        return SFTP_PASSWD;
    }

    public static void setSftpPasswd(String sftpPasswd) {
        SFTP_PASSWD = sftpPasswd;
    }

    public static String getSftpRootpath() {
        return SFTP_ROOTPATH;
    }

    public static void setSftpRootpath(String sftpRootpath) {
        SFTP_ROOTPATH = sftpRootpath;
    }

    public static String getSftpPort() {
        return SFTP_PORT;
    }

    public static void setSftpPort(String sftpPort) {
        SFTP_PORT = sftpPort;
    }

    public static String getSftpRelatePath() {
        return SFTP_RELATE_PATH;
    }

    public static void setSftpRelatePath(String sftpRelatePath) {
        SFTP_RELATE_PATH = sftpRelatePath;
    }

    public static String getDownloadAddress() {
        return DOWNLOAD_ADDRESS;
    }

    public static void setDownloadAddress(String downloadAddress) {
        DOWNLOAD_ADDRESS = downloadAddress;
    }
}
