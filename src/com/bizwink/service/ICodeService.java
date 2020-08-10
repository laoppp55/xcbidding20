package com.bizwink.service;

import com.bizwink.po.NameValueCode;
import sun.nio.cs.ext.Big5;

import java.math.BigDecimal;
import java.util.List;

public interface ICodeService {
    List<NameValueCode> getNameValueCodeByClassCode(BigDecimal classcode);
}
