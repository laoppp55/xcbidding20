package com.bizwink.log;

import java.util.*;
import java.sql.*;
import java.sql.Date;

import com.bizwink.cms.server.*;
import com.bizwink.cms.security.User;

public class LogPeer implements ILogManager {
    PoolServer cpool;

    public LogPeer(PoolServer cpool) {
        this.cpool = cpool;
    }

    public static ILogManager getInstance() {
        return CmsServer.getInstance().getFactory().getLogManager();
    }

    private static final String SQL_GET_EDITOR_INFO =
            "SELECT DISTINCT a.Editor,b.NickName FROM TBL_Log a,TBL_Members b WHERE a.SiteID = ? AND a.Editor = b.UserID";

    private static final String SQL_GET_EDITOR_ACTINFO = "select createarticles,editarticles,deletearticles from tbl_members" +
            " where userid = ?";

    public List getEditorLogInfo(int siteID, String where) throws LogException {
        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        List editList = new ArrayList();
        List tempList = new ArrayList();

        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_EDITOR_INFO);
            pstmt.setInt(1, siteID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                tempList.add(rs.getString(1) + ":" + rs.getString(2));
            }
            rs.close();
            pstmt.close();

            for (int i = 0; i < tempList.size(); i++) {
                int createCount = 0;
                int updateCount = 0;
                int deleteCount = 0;
                String editor = (String) tempList.get(i);
                String nickname = editor.substring(editor.indexOf(":") + 1);
                editor = editor.substring(0, editor.indexOf(":"));

                /*if (where.equals(" and 1=1")) {
                    pstmt = conn.prepareStatement(SQL_GET_EDITOR_ACTINFO);
                    pstmt.setString(1, editor);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        createCount = rs.getInt(1);
                        updateCount = rs.getInt(2);
                        deleteCount = rs.getInt(3);
                    }
                    rs.close();
                    pstmt.close();

                    editList.add(editor + ":" + nickname + ":" + createCount + ":" + updateCount + ":" + deleteCount);
                } else */
                {
                    String SQL_SEARCH_USERS_LOG_INFO = "select count(id),max(acttype) as acttype from tbl_log " +
                            "where editor = ?" + where + " group by editor,acttype order by acttype";

                    pstmt = conn.prepareStatement(SQL_SEARCH_USERS_LOG_INFO);
                    pstmt.setString(1, editor);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int acttype = rs.getInt("acttype");
                        if (acttype == 1)
                            createCount = rs.getInt(1);
                        else if (acttype == 2)
                            updateCount = rs.getInt(1);
                        else if (acttype == 3)
                            deleteCount = rs.getInt(1);
                    }
                    rs.close();
                    pstmt.close();

                    editList.add(editor + ":" + nickname + ":" + createCount + ":" + updateCount + ":" + deleteCount);
                }
            }
        } catch (Throwable t) {
            t.printStackTrace();
        } finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return editList;
    }

    private static String SQL_GET_USERS_LOG_INFO_OF_GROUP = "select userid,nickname,createarticles,editarticles," +
            "deletearticles from tbl_members where userid in (select userid from tbl_group_members where groupid=?)";


    /**
     * 获得某个用户组下所有用户的Log信息
     * Add by EricDu 2007-9-23
     *
     * @param groupId 用户组的id
     * @return 用户Log信息的List
     * @throws LogException 异常
     */
    public List getGroupsEditorLogInfo(int groupId) throws LogException {
        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        List logList = new ArrayList();
        List tempList = new ArrayList();
        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_USERS_LOG_INFO_OF_GROUP);
            pstmt.setInt(1, groupId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                /*User user = new User();
                user.setID(rs.getString("userid"));
                user.setNickName(rs.getString("nickname"));
                user.setCreatearticles(rs.getInt("createarticles"));
                user.setEditarticles(rs.getInt("editarticles"));
                user.setDeletearticles(rs.getInt("deletearticles"));

                logList.add(user);*/
                tempList.add(rs.getString(1) + ":" + rs.getString(2));
            }
            rs.close();
            pstmt.close();
            for (int i = 0; i < tempList.size(); i++) {
                int createCount = 0;
                int updateCount = 0;
                int deleteCount = 0;
                String editor = (String) tempList.get(i);
                String nickname = editor.substring(editor.indexOf(":") + 1);
                editor = editor.substring(0, editor.indexOf(":"));


                {
                    String SQL_SEARCH_USERS_LOG_INFO = "select count(id),max(acttype) as acttype from tbl_log " +
                            "where editor = ? group by editor,acttype order by acttype";

                    pstmt = conn.prepareStatement(SQL_SEARCH_USERS_LOG_INFO);
                    pstmt.setString(1, editor);
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        int acttype = rs.getInt("acttype");
                        if (acttype == 1)
                            createCount = rs.getInt(1);
                        else if (acttype == 2)
                            updateCount = rs.getInt(1);
                        else if (acttype == 3)
                            deleteCount = rs.getInt(1);


                    }
                    rs.close();
                    pstmt.close();
                    User user = new User();
                    user.setID(editor);
                    user.setNickName(nickname);
                    user.setCreatearticles(createCount);
                    user.setEditarticles(updateCount);
                    user.setDeletearticles(deleteCount);

                    logList.add(user);
                    /*editList.add(editor + ":" + nickname + ":" + createCount + ":" + updateCount + ":" + deleteCount);*/
                }
            }
        } catch (Throwable t) {
            t.printStackTrace();
        } finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return logList;
    }

    /**
     * 查询某个用户组下某段时间内所有用户的Log信息
     * Add by EricDu 2007-9-23
     *
     * @param groupId 用户组的id
     * @param where   条件
     * @return 用户Log信息的List
     * @throws LogException 异常
     */
    public List getGroupsEditorLogInfo(int groupId, String where) throws LogException {

        String SQL_SEARCH_USERS_LOG_INFO_OF_GROUP = "select count(id),max(acttype) as acttype from tbl_log where editor" +
                " = ?" + where + " group by editor,acttype order by acttype";

        String SQL_GET_ALL_USERS_OF_GROUP = "select g.userid,m.nickname from tbl_group_members g,tbl_members m where groupid=? and g.userid=m.userid";

        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        List logList = new ArrayList();
        List userList = new ArrayList();

        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_ALL_USERS_OF_GROUP);
            pstmt.setInt(1, groupId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setID(rs.getString("userid"));
                user.setNickName(rs.getString("nickname"));
                userList.add(user);
            }
            rs.close();
            pstmt.close();

            for (int i = 0; i < userList.size(); i++) {
                User user = (User) userList.get(i);
                pstmt = conn.prepareStatement(SQL_SEARCH_USERS_LOG_INFO_OF_GROUP);
                pstmt.setString(1, user.getID());

                rs = pstmt.executeQuery();
                while (rs.next()) {
                    int acttype = rs.getInt("acttype");
                    if (acttype == 1)
                        user.setCreatearticles(rs.getInt(1));
                    else if (acttype == 2)
                        user.setEditarticles(rs.getInt(1));
                    else if (acttype == 3)
                        user.setDeletearticles(rs.getInt(1));
                }
                logList.add(user);

                rs.close();
                pstmt.close();
            }
        } catch (Throwable t) {
            t.printStackTrace();
        } finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return logList;
    }

    public List getEditorLogInfoGroupbyActTime(int siteID, String editor, int flag, int startrow, int range, String where)
            throws LogException {

        String SQL_GET_LOGINFO_GROUPBY_CREATEDATE = "SELECT count(id),createdate FROM TBL_Log WHERE SiteID = ? AND " +
                "ActType = ? AND Editor = ?" + where + " group by createdate order by createdate desc";

        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        List editList = new ArrayList();

        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_LOGINFO_GROUPBY_CREATEDATE);
            pstmt.setInt(1, siteID);
            pstmt.setInt(2, flag);
            pstmt.setString(3, editor);
            rs = pstmt.executeQuery();

            for (int i = 0; i < startrow; i++) {
                rs.next();
            }
            for (int i = 0; i < range && rs.next(); i++) {
                editList.add(rs.getDate(2) + ":" + rs.getInt(1));
            }
            rs.close();
            pstmt.close();
        }
        catch (Throwable t) {
            t.printStackTrace();
        }
        finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return editList;
    }

    public int getEditorLogInfoNumGroupbyActTime(int siteID, String editor, int flag, String where) throws LogException {

        String SQL_GET_LOGINFONUM_GROUPBY_CREATEDATE =
                "SELECT count(distinct createdate) FROM TBL_Log WHERE SiteID = ? AND ActType = ? AND Editor = ?" + where;

        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        int rowsnum = 0;

        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_LOGINFONUM_GROUPBY_CREATEDATE);
            pstmt.setInt(1, siteID);
            pstmt.setInt(2, flag);
            pstmt.setString(3, editor);
            rs = pstmt.executeQuery();
            if (rs.next())
                rowsnum = rs.getInt(1);

            rs.close();
            pstmt.close();
        }
        catch (Throwable t) {
            t.printStackTrace();
        }
        finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return rowsnum;
    }

    private static final String SQL_GET_DETAIL_LOGINFONUM_GROUPBY_CREATEDATE =
            "SELECT count(id) FROM TBL_Log WHERE SiteID = ? AND ActType = ? AND Editor = ? and createdate = ?";

    public int getEditorDetailLogInfoNumGroupbyActTime(int siteID, String editor, int flag, String date) throws LogException {
        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        int rowsnum = 0;

        int year = Integer.parseInt(date.substring(0, 4)) - 1900;
        int month = Integer.parseInt(date.substring(date.indexOf("-") + 1, date.lastIndexOf("-"))) - 1;
        int d = Integer.parseInt(date.substring(date.lastIndexOf("-") + 1));
        Date actDate = new Date(year, month, d);

        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_DETAIL_LOGINFONUM_GROUPBY_CREATEDATE);
            pstmt.setInt(1, siteID);
            pstmt.setInt(2, flag);
            pstmt.setString(3, editor);
            pstmt.setDate(4, actDate);
            rs = pstmt.executeQuery();
            if (rs.next())
                rowsnum = rs.getInt(1);

            rs.close();
            pstmt.close();
        } catch (Throwable t) {
            t.printStackTrace();
        } finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return rowsnum;
    }

    private static final String SQL_CREATE_KEYWORD_LOG = "INSERT INTO tbl_searchword (siteid,ip,keyword,createdate) VALUES (?, ?, ?, ?)";

    public int LogSearchKeyword(int siteID, String userip, String keyword) throws LogException {
        int retcode = 0;
        Connection conn = null;
        PreparedStatement pstmt=null;

        try {
            conn = cpool.getConnection();
            conn.setAutoCommit(false);
            pstmt = conn.prepareStatement(SQL_CREATE_KEYWORD_LOG);
            pstmt.setInt(1, siteID);
            pstmt.setString(2, userip);
            pstmt.setString(3, keyword);
            pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            pstmt.executeUpdate();
            pstmt.close();
            conn.commit();
        } catch (Throwable t) {
            retcode = -10;
            t.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }

        return  retcode;
    }

    private static final String SQL_GET_DETAIL_LOGINFO_GROUPBY_CREATEDATE = "SELECT articleid,editor,maintitle,acttime" +
            " FROM TBL_Log WHERE SiteID = ? AND ActType = ? AND Editor = ? and createdate = ? order by id desc";

    public List getEditorDetailLogInfoGroupbyActTime(int siteID, String editor, int flag, int startrow, int range, String date)
            throws LogException {
        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        List editList = new ArrayList();

        int year = Integer.parseInt(date.substring(0, 4)) - 1900;
        int month = Integer.parseInt(date.substring(date.indexOf("-") + 1, date.lastIndexOf("-"))) - 1;
        int d = Integer.parseInt(date.substring(date.lastIndexOf("-") + 1));
        Date actDate = new Date(year, month, d);

        try {
            conn = cpool.getConnection();
            pstmt = conn.prepareStatement(SQL_GET_DETAIL_LOGINFO_GROUPBY_CREATEDATE);
            pstmt.setInt(1, siteID);
            pstmt.setInt(2, flag);
            pstmt.setString(3, editor);
            pstmt.setDate(4, actDate);
            rs = pstmt.executeQuery();

            for (int i = 0; i < startrow; i++) {
                rs.next();
            }
            for (int i = 0; i < range && rs.next(); i++) {
                Log log = new Log();
                log.setArticleID(rs.getInt("articleid"));
                log.setMaintitle(rs.getString("maintitle"));
                log.setActTime(rs.getTimestamp("acttime"));
                log.setEditor(rs.getString("editor"));
                editList.add(log);
            }
            rs.close();
            pstmt.close();
        } catch (Throwable t) {
            t.printStackTrace();
        } finally {
            if (conn != null) {
                try {

                    cpool.freeConnection(conn);
                }
                catch (Exception e) {
                    System.out.println("Error in closing the pooled connection " + e.toString());
                }
            }
        }
        return editList;
    }
}