package com.bizwink.service.impl;

import com.bizwink.persistence.ReadNoticeLogMapper;
import com.bizwink.persistence.WinResultsNoticeMapper;
import com.bizwink.po.ReadNoticeLog;
import com.bizwink.po.WinResultsNotice;
import com.bizwink.po.WinResultsNoticeWithBLOBs;
import com.bizwink.service.IWinResultsNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class WinResultsNoticeService implements IWinResultsNoticeService{
    @Autowired
    private WinResultsNoticeMapper winResultsNoticeMapper;

    @Autowired
    private ReadNoticeLogMapper readNoticeLogMapper;

    public WinResultsNoticeWithBLOBs getWinResultsNoticeByUUID(String uuid) {
        return winResultsNoticeMapper.selectByUUID(uuid);
    }

    public int saveReadNoticeFlag(String noticeTitle,String noticeid,String userid) {
        ReadNoticeLog readNoticeLog = new ReadNoticeLog();
        String uuid = UUID.randomUUID().toString();
        uuid = uuid.replace("-", "");

        readNoticeLog.setUuid(uuid);
        readNoticeLog.setNoticetitle(noticeTitle);
        readNoticeLog.setNoticeid(noticeid);
        readNoticeLog.setUserid(userid);
        readNoticeLog.setCreationdate(new Timestamp(System.currentTimeMillis()));

        return readNoticeLogMapper.insert(readNoticeLog);
    }

    public List<ReadNoticeLog> getReadNotiesLog(String userid, List<String> notice_ids) {
        Map params = new HashMap();
        params.put("userid",userid);
        params.put("noticeids",notice_ids);
        return readNoticeLogMapper.getReadNoticesLogs(params);
    }

}
