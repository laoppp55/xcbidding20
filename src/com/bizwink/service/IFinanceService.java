package com.bizwink.service;

import com.bizwink.po.bhApplyCredit;
import com.bizwink.po.bhApplyGuarantee;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

public interface IFinanceService {
    int saveApplyCreditInfo(bhApplyCredit applyCredit);

    List<bhApplyCredit> getApplyCredits(String companycode, BigDecimal startrow, BigDecimal resultrows);

    bhApplyCredit getApplyCreditByuuid(String uuid);

    int updateApplytimeAndApplicant(String uuid,String applicant,Date applytime);

    int updateApplyCreditResult(String uuid,int status,String accept_no,String page_flow,String pageflowurl);

    int deleteApplyCredit(String uuid);

    int updateApplyCredit(bhApplyCredit applyCredit);

    //保存保函申请信息
    int saveGL(bhApplyGuarantee bhGL);

    int updateApplyGuaranteeResult(String uuid,int status,String accept_no,String page_flow,String pageflowurl);

    int updateGuaranteeLetterQueryResult(bhApplyGuarantee bhGL);

    bhApplyGuarantee queryGuaranteeLetter(String sectioncode);
}
