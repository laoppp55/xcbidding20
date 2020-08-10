package com.bizwink.service;

import com.bizwink.persistence.LeaveWordMapper;
import com.bizwink.po.LeaveWord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    @Autowired
    private LeaveWordMapper leaveWordMapper;

    public int saveMessage(LeaveWord leaveWord) {
        return leaveWordMapper.insert(leaveWord);
    }
}
