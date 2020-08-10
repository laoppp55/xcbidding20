package com.bizwink.util;

import com.bizwink.po.Article;
import com.jolbox.bonecp.BoneCPDataSource;
import org.springframework.context.ApplicationContext;

import java.io.BufferedReader;
import java.io.StringReader;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by petersong on 16-6-19.
 */
public class DBUtil {
    public static Connection getConn() {
        ApplicationContext appContext = SpringInit.getApplicationContext();
        BoneCPDataSource dataSource = (BoneCPDataSource)appContext.getBean("myDataSource");
        Connection conn= null;
        try {
            conn= dataSource.getConnection();
        }catch(SQLException exp) {
            exp.printStackTrace();
        }

        return conn;
    }

    public static List<Article> getNeedIndex(int siteid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs=null;
        Article article = null;
        List<Article> list = new ArrayList();
        try {
            conn= getConn();
            pstmt = conn.prepareStatement("select t.id,t.siteid,t.sortid,t.brand,t.pic,t.bigpic,t.columnid,t.articlepic,t.createdate,t.publishtime," +
                    "tc.dirname,t.filename,t.maintitle,t.summary,t.keyword ,t.content from tbl_article t  ,tbl_column tc where t.columnid=tc.id  " +
                    "and  (t.status =1 or t.status=2 or t.status =5)  and t.pubflag =0 and  t.siteid = ? and t.indexflag=0  and rownum < 200");
            pstmt.setInt(1,siteid);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                article = new Article();
                article.setID(BigDecimal.valueOf(rs.getInt("id")));
                article.setSITEID(BigDecimal.valueOf(rs.getInt("siteid")));
                article.setSORTID(BigDecimal.valueOf(rs.getInt("sortid")));
                article.setBRAND(rs.getString("brand"));
                article.setBIGPIC(rs.getString("bigpic"));
                article.setPIC(rs.getString("pic"));
                article.setCOLUMNID(BigDecimal.valueOf(rs.getInt("columnid")));
                article.setARTICLEPIC(rs.getString("articlepic"));
                article.setCREATEDATE(rs.getTimestamp("createdate"));
                article.setPUBLISHTIME(rs.getTimestamp("publishtime"));
                article.setDIRNAME(rs.getString("dirname"));
                article.setFILENAME(rs.getString("filename"));
                article.setMAINTITLE(rs.getString("maintitle"));
                article.setSUMMARY(rs.getString("summary"));
                article.setKEYWORD(rs.getString("keyword"));
                article.setCONTENT(DBUtil.getBigString("oracle",rs,"content"));
                list.add(article);
            }
            rs.close();
            pstmt.close();
        } catch (Exception exp) {
            exp.printStackTrace();
        } finally {
            if (conn!=null){
                try {
                    conn.close();
                } catch (SQLException exp){

                }
            }
        }

        return list;
    }

    public static void setBigString(String type, PreparedStatement pstmt, int index, String content) throws SQLException {
        if (content == null || content.length() == 0) {
            pstmt.setNull(index, java.sql.Types.VARCHAR);
            return;
        }

        if (type.equalsIgnoreCase("oracle"))
            setOracleBigString(pstmt, index, content);
        else if (type.equalsIgnoreCase("mssql") || type.equalsIgnoreCase("sybase"))
            setSQLServerBigString(pstmt, index, content);
        else                                            //defalut, change if have new database
            setOracleBigString(pstmt, index, content);
    }

    private static void setOracleBigString(PreparedStatement pstmt, int index, String content) throws SQLException {
        String strText = StringUtil.iso2gb(content);
        pstmt.setCharacterStream(index, new StringReader(strText), strText.length());
    }

    private static void setSQLServerBigString(PreparedStatement pstmt, int index, String content) throws SQLException {
        pstmt.setString(index, StringUtil.iso2gb(content));
    }

    public static String getBigString(String type, ResultSet rs, String fieldName) throws Exception {
        String content = null;
        if (type.equalsIgnoreCase("oracle"))
            content = getOracleBigString(rs, fieldName);
        else if (type.equalsIgnoreCase("mssql") || type.equalsIgnoreCase("sybase"))
            content = getSQLServerBigString(rs, fieldName);
        else
            content = getOracleBigString(rs, fieldName);

        return content;
    }

    private static String getSQLServerBigString(ResultSet rs, String fieldName) throws Exception {
        return rs.getString(fieldName);
    }

    private static String getOracleBigString(ResultSet rs, String fieldName) throws Exception {
        String content = "";
        if (rs.getCharacterStream(fieldName) != null) {
            BufferedReader is = new BufferedReader(rs.getCharacterStream(fieldName));
            char[] buffer = new char[1000];
            int length = 0;
            while ((length = is.read(buffer)) != -1) {
                String str = new String(buffer, 0, length);
                content = content + str;
            }
            is.close();
        }
        return content;
    }


    private static final String SEQ_NEXT_ARTICLE_ID = "select tbl_article_id.NEXTVAL from dual";
    private static final String SEQ_NEXT_TEMPLATE_ID = "select tbl_template_id.NEXTVAL from dual";
    private static final String SEQ_NEXT_PUBLISH_QUEUE_ID = "select tbl_new_publish_queue_id.NEXTVAL from dual";

    public long getMainKeyID(String keyflag) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs=null;
        long nextID = 0l;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConn();
            if (keyflag.equalsIgnoreCase("article"))
                pstmt = conn.prepareStatement(SEQ_NEXT_ARTICLE_ID);
            else if (keyflag.equalsIgnoreCase("template"))
                pstmt = conn.prepareStatement(SEQ_NEXT_TEMPLATE_ID);
            else if (keyflag.equalsIgnoreCase("PublishQueue"))
                pstmt = conn.prepareStatement(SEQ_NEXT_PUBLISH_QUEUE_ID);
            rs = pstmt.executeQuery();
            if (rs.next()) nextID = rs.getInt(1);
            rs.close();
            pstmt.close();
        } catch(SQLException exp) {
            exp.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException sexp) {
                sexp.printStackTrace();
            }
        }

        return nextID;
    }
}
