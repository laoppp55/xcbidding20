package com.bizwink.service;

import com.bizwink.po.ReadNoticeLog;
import com.bizwink.po.WinResultsNotice;
import com.bizwink.po.WinResultsNoticeWithBLOBs;

import java.util.List;

public interface IWinResultsNoticeService {
    WinResultsNoticeWithBLOBs getWinResultsNoticeByUUID(String uuid);

    int saveReadNoticeFlag(String noticeTitle,String noticeid,String userid);

    List<ReadNoticeLog> getReadNotiesLog(String userid, List<String> notice_ids);
}
