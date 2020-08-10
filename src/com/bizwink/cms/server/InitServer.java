package com.bizwink.cms.server;

public class InitServer {
    // singleton instance
    private static InitServer singleton = new InitServer();

    // server status
    boolean isInitialized = false;
    public static Process process = null;
    public static String indexpath;

    // server properties
    public static FileProps properties;

    public static synchronized InitServer getInstance() {
        singleton.init();
        return singleton;
    }

    public synchronized void init() {
        System.out.println("isInitialized:" + isInitialized);
        if (!isInitialized) {
            initEnv();                      //初始化环境变量
            isInitialized = true;
        }
    }

    void initEnv() {
        System.out.println("获取环境设置参数" + System.currentTimeMillis());
        properties = new FileProps("com/bizwink/cms/server/config.properties");
        System.out.println("获取环境设置参数结束" + System.currentTimeMillis());
    }

    public static FileProps getProperties() {
        return properties;
    }

    public static void setProperties(FileProps properties) {
        InitServer.properties = properties;
    }
}
