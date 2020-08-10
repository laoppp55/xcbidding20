package com.bizwink.service;

import com.bizwink.po.BaseAttachment;

public interface IAttechemntsService {
    BaseAttachment getAttechmentFilenameByUUID(String uuid);
}
