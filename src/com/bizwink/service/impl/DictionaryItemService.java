package com.bizwink.service.impl;

import com.bizwink.persistence.BaseDictionaryItemMapper;
import com.bizwink.persistence.DictGetfilesModelMapper;
import com.bizwink.po.BaseDictionaryItem;
import com.bizwink.po.DictGetfilesModel;
import com.bizwink.service.IDictionaryItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DictionaryItemService implements IDictionaryItemService {
    @Autowired
    private BaseDictionaryItemMapper baseDictionaryItemMapper;

    @Autowired
    private DictGetfilesModelMapper dictGetfilesModelMapper;

    public BaseDictionaryItem getBaseDictionaryItemByUUID(String uuid) {
        return baseDictionaryItemMapper.selectByPrimaryKey(uuid);
    }

    public DictGetfilesModel getDictGetfilesModel(String uuid){
        return dictGetfilesModelMapper.selectByPrimaryKey(uuid);
    }
}
