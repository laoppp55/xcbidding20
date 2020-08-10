package com.bizwink.service.impl;

import com.bizwink.persistence.NameValueCodeMapper;
import com.bizwink.po.NameValueCode;
import com.bizwink.service.ICodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class CodeService implements ICodeService{
    @Autowired
    private NameValueCodeMapper nameValueCodeMapper;

    public List<NameValueCode> getNameValueCodeByClassCode(BigDecimal classcode) {
        return nameValueCodeMapper.getNameValueCodeByClassCode(classcode);
    }
}
