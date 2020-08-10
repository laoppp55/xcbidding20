package com.bizwink.service;

import com.bizwink.po.ChangeNoticeWithBLOBs;
import com.bizwink.po.ReadNoticeLog;

import java.util.List;

public interface IChangeNoticeService {
    ChangeNoticeWithBLOBs getChangeNoticeByUUID(String uuid);

    int saveReadNoticeFlag(String noticeTitle,String noticeid,String userid);

    List<ReadNoticeLog> getReadNotiesLog(String userid, List<String> notice_ids);
}
