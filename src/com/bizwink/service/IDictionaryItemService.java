package com.bizwink.service;

import com.bizwink.po.BaseDictionaryItem;
import com.bizwink.po.DictGetfilesModel;

public interface IDictionaryItemService {
    BaseDictionaryItem getBaseDictionaryItemByUUID(String uuid);

    DictGetfilesModel getDictGetfilesModel(String uuid);
}
