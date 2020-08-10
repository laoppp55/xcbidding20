package com.transferBjrabData;

import com.bizwink.util.MD5Util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class transgerDzll {
    public transgerDzll() {

    }

    private static Connection createConnection(String ip, String username, String password, String server,int port,int flag) {
        Connection conn = null;
        String dbip = "";
        String dbusername = "";
        String dbpassword = "";

        try {
            dbip = ip;
            dbusername = username;
            dbpassword = password;

            System.out.println("dbip=" + dbip);
            System.out.println("server=" + server);
            System.out.println("dbusername=" + dbusername);
            System.out.println("dbpassword=" + dbpassword);

            if (flag == 0) {
                Class.forName("weblogic.jdbc.mssqlserver4.Driver");
                conn = DriverManager.getConnection("jdbc:weblogic:mssqlserver4:" + dbip + ":" + port, dbusername, dbpassword);
            } else if (flag == 1) {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@" + dbip + ":" + port + ":"+server, dbusername, dbpassword);
            } else {
                Class.forName("org.gjt.mm.mysql.Driver").newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://" + dbip + ":" + port + "/" + server + "?characterEncoding=utf-8", dbusername, dbpassword);
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args)
    {
        Connection conn = null;
        PreparedStatement pstmt=null,pstmt1=null;
        ResultSet rs = null;
        List<Integer> artids = new ArrayList();
        try
        {
            //获取CMS的栏目目录、栏目ID等信息
            String t_dbip = "localhost";
            String t_username = "edarongdbadmin";
            String t_password = "qazwsxokm";
            String t_server = "oracle11g";

            conn = createConnection(t_dbip, t_username, t_password,t_server,1521,1);
            conn.setAutoCommit(false);
            pstmt = conn.prepareStatement("select id from tbl_article where columnid=51598");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                artids.add(rs.getInt("id"));
                //String tt = MD5Util.MD5Encode(rs.getInt("id") + "==" + rs.getString("maintitle"),"utf-8");
                //pstmt1 = conn.prepareStatement("update tbl_article set sign = ? where id=?");
                //pstmt1.setString(1,tt);
                //pstmt1.setInt(2,rs.getInt("id"));
                //pstmt1.executeUpdate();
                //pstmt1.close();
            }
            rs.close();
            pstmt.close();

            for(int ii=0; ii<artids.size();ii++) {
                int articleid= artids.get(ii);
                pstmt = conn.prepareStatement("delete from tbl_article where id=?");
                pstmt.setInt(1,articleid);
                pstmt.executeUpdate();
                pstmt.close();
                System.out.println(articleid);
                conn.commit();
            }
            conn.close();
        } catch (SQLException exp1) {
            exp1.printStackTrace();
        }
    }
}

