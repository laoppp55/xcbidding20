package com.bizwink.util;


import com.bizwink.cms.news.Article;
import com.bizwink.service.LuceneSearchService;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: jackzhang
 * Date: 13-10-15
 * Time: 下午4:40
 * To change this template use File | Settings | File Templates.
 */
public class TestUnit {
    private static Connection createConnection(String ip, String username, String password, String server,int port,int flag) {
        Connection conn = null;
        String dbip = "";
        String dbusername = "";
        String dbpassword = "";

        try {
            dbip = ip;
            dbusername = username;
            dbpassword = password;

            if (flag == 0) {
                String connectionUrl = "jdbc:sqlserver://" + dbip + ":" + port + ";databaseName=" + server + ";integratedSecurity=true;";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(connectionUrl);
                //Class.forName("weblogic.jdbc.mssqlserver4.Driver");
                //conn = DriverManager.getConnection("jdbc:weblogic:mssqlserver4:" + dbip + ":" + port, dbusername, dbpassword);
            } else if (flag == 1) {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@" + dbip + ":" + port + ":"+server, dbusername, dbpassword);
            } else {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://" + dbip + ":" + port + "/" + server + "?useSSL=false&characterEncoding=utf8", dbusername, dbpassword);
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        return conn;
    }


    public static void main(String[] argv) {

        Connection conn = null;
        PreparedStatement pstmt=null;
        ResultSet rs = null;

        conn = createConnection("192.168.194.166", "cwzdbadmin", "1qaz2wsx","cwzdb",3306,2);

    }
}
