package com.bizwink.service.impl;

import com.bizwink.persistence.ChangeNoticeMapper;
import com.bizwink.persistence.ReadNoticeLogMapper;
import com.bizwink.po.ChangeNotice;
import com.bizwink.po.ChangeNoticeWithBLOBs;
import com.bizwink.po.ReadNoticeLog;
import com.bizwink.service.IChangeNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class ChangeNoticeService implements IChangeNoticeService {
    @Autowired
    private ChangeNoticeMapper changeNoticeMapper;

    @Autowired
    private ReadNoticeLogMapper readNoticeLogMapper;

    public ChangeNoticeWithBLOBs getChangeNoticeByUUID(String uuid) {
        return changeNoticeMapper.selectByPrimaryKey(uuid);
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
