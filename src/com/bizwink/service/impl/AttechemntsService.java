package com.bizwink.service.impl;

import com.bizwink.persistence.BaseAttachmentMapper;
import com.bizwink.po.BaseAttachment;
import com.bizwink.service.IAttechemntsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttechemntsService implements IAttechemntsService{
    @Autowired
    private BaseAttachmentMapper baseAttachmentMapper;

    public BaseAttachment getAttechmentFilenameByUUID(String uuid) {
        return baseAttachmentMapper.selectByPrimaryKey(uuid);
    }
}
