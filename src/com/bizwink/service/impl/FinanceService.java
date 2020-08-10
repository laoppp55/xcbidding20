package com.bizwink.service.impl;


import com.bizwink.persistence.bhApplyGuaranteeMapper;
import com.bizwink.po.bhApplyCredit;
import com.bizwink.persistence.bhApplyCreditMapper;
import com.bizwink.po.bhApplyGuarantee;
import com.bizwink.service.IFinanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FinanceService implements IFinanceService{
    @Autowired
    private bhApplyCreditMapper bhApplyCreditMapper;

    @Autowired
    private bhApplyGuaranteeMapper bhApplyGuaranteeMapper;

    public int saveApplyCreditInfo(bhApplyCredit applyCredit) {
        return bhApplyCreditMapper.insert(applyCredit);
    }

    public List<bhApplyCredit> getApplyCredits(String companycode,BigDecimal startrow,BigDecimal resultrows) {
        Map params = new HashMap();
        params.put("compcode",companycode);
        params.put("startrow",startrow);
        params.put("rows",resultrows);
        return bhApplyCreditMapper.getApplyCredits(params);
    }

    public bhApplyCredit getApplyCreditByuuid(String uuid) {
        return bhApplyCreditMapper.selectByPrimaryKey(uuid);
    }

    //修改授信申请的提交人和提交时间信息
    public int updateApplytimeAndApplicant(String uuid,String applicant, Date applytime) {
        bhApplyCredit applyCredit =new bhApplyCredit();
        applyCredit.setUuid(uuid);
        applyCredit.setApplicant(applicant);
        applyCredit.setApplytime(applytime);
        return bhApplyCreditMapper.updateByPrimaryKeySelective(applyCredit);
    }

    //修改授信申请的返回结果信息
    public int updateApplyCreditResult(String uuid,int status,String accept_no,String page_flow,String pageflowurl) {
        bhApplyCredit applyCredit =new bhApplyCredit();
        applyCredit.setUuid(uuid);
        applyCredit.setStatus(status);
        applyCredit.setAcceptno(accept_no);
        applyCredit.setPageflow(page_flow);
        applyCredit.setPageflowurl(pageflowurl);
        return bhApplyCreditMapper.updateByPrimaryKeySelective(applyCredit);
    }

    public int deleteApplyCredit(String uuid) {
        return bhApplyCreditMapper.deleteByPrimaryKey(uuid);
    }

    public int updateApplyCredit(bhApplyCredit applyCredit) {
        return bhApplyCreditMapper.updateByPrimaryKeySelective(applyCredit);
    }

    public int saveGL(bhApplyGuarantee bhGL) {
        return bhApplyGuaranteeMapper.insert(bhGL);
    }

    //传输申请保函的结果数据
    //status:申请状态
    //accept_no：申请保函接收编号
    //page_flow:申请返回的确认URL地址，BASE64格式提供
    //pageflowurl：BASE64格式的URL地址转化为HTTP格式URL地址
    public int updateApplyGuaranteeResult(String uuid,int status,String accept_no,String page_flow,String pageflowurl) {
        bhApplyGuarantee bhApplyGuarantee = new bhApplyGuarantee();
        bhApplyGuarantee.setUuid(uuid);
        bhApplyGuarantee.setStatus(status);
        bhApplyGuarantee.setAccept_no(accept_no);
        bhApplyGuarantee.setPage_flow(page_flow);
        bhApplyGuarantee.setPageflowurl(pageflowurl);
        return bhApplyGuaranteeMapper.updateByPrimaryKeySelective(bhApplyGuarantee);
    }

    //传输申请保函对象，修改对象中不为空的数据
    public int updateGuaranteeLetterQueryResult(bhApplyGuarantee bhGL) {
        return bhApplyGuaranteeMapper.updateByPrimaryKeySelective(bhGL);
    }

    public bhApplyGuarantee queryGuaranteeLetter(String sectioncode) {
        return bhApplyGuaranteeMapper.queryGuaranteeLetter(sectioncode);
    }
}
