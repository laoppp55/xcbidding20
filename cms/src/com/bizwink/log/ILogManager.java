package com.bizwink.log;

import java.util.*;

public interface ILogManager {
    List getEditorLogInfo(int siteID, String where) throws LogException;

    List getEditorLogInfoGroupbyActTime(int siteID, String editor, int flag, int startrow, int range, String where) throws LogException;

    int getEditorLogInfoNumGroupbyActTime(int siteID, String editor, int flag, String where) throws LogException;

    int getEditorDetailLogInfoNumGroupbyActTime(int siteID, String editor, int flag, String date) throws LogException;

    List getEditorDetailLogInfoGroupbyActTime(int siteID, String editor, int flag, int startrow, int range, String date)
            throws LogException;

    List getGroupsEditorLogInfo(int groupId) throws LogException;

    List getGroupsEditorLogInfo(int groupId, String where) throws LogException;

    int LogSearchKeyword(int siteID, String userip, String keyword) throws LogException;
}