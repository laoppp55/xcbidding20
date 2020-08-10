package com.bizwink.service;

import com.bizwink.po.BidderInfo;

import java.math.BigDecimal;
import java.util.List;

public interface IBidderInfoService {
    int saveBidderInfo(BidderInfo bidderInfo,String userid,String compcode);

    BidderInfo getBidderInfoByProjcodeAndCompcode(String projcode,String Compcode);

    List<BidderInfo> getBidderInfosByUseridAndCompcode(String creator, String compcode, BigDecimal startrow, BigDecimal pagesize);
}
