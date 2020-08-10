package com.bizwink.service.impl;

import com.bizwink.persistence.*;
import com.bizwink.po.*;
import com.bizwink.service.IPurchaseProjectService;
import com.bizwink.vo.PurchaseProjOfNeedMargin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class PurchaseProjectService implements IPurchaseProjectService{
    @Autowired
    private SuppBiddingRecordMapper suppBiddingRecordMapper;
    @Autowired
    private PurchaseProjectMapper purchaseProjectMapper;
    @Autowired
    private SectionMapper sectionMapper;
    @Autowired
    private UsersMapper usersMapper;
    @Autowired
    private bhApplyGuaranteeMapper bhApplyGuaranteeMapper;

    public List<Section> getSectionsByProjcode(String projcode) {
        return sectionMapper.getSectionsByPurchaseProjCode(projcode);
    }

    //获取登录用户需要交纳保证金的项目和项目的标包
    //根据登录用户的用户名联合查询tbl_members表和supp_bidding_record表，获取用户已经报名但是处于已经发布公告阶段的项目
    //查看这些项目是否需要交纳保证金，根据标包表的保证金字段是否大于0确认是否需要交纳保证金
    public List<PurchaseProjOfNeedMargin> getProjectSectionsOfNeedMargin(String userid) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        PurchaseProjOfNeedMargin purchaseProjOfNeedMargin = null;
        bhApplyGuarantee bhApplyGuarantee = null;
        List<PurchaseProjOfNeedMargin> purchaseProjOfNeedMarginList = new ArrayList<>();
        Users user = usersMapper.selectByPrimaryKey(userid);
        System.out.println("companycode==" + user.getCOMPANYCODE());
        List<PurchaseProject> purchaseProjects = purchaseProjectMapper.getPurchaseProjectsByCompanyCode(user.getCOMPANYCODE());
        System.out.println("size==" + purchaseProjects.size());
        for(int ii=0;ii<purchaseProjects.size();ii++) {
            PurchaseProject purchaseProject = purchaseProjects.get(ii);
            List<Section> sections = sectionMapper.getSectionsByPurchaseProjCode(purchaseProject.getPurchaseprojcode());
            for(int jj=0;jj<sections.size();jj++) {
                Section section = sections.get(jj);
                if (section.getMargin().floatValue()>0f) {
                    bhApplyGuarantee = bhApplyGuaranteeMapper.queryGuaranteeLetter(section.getPurchasesectioncode());
                    purchaseProjOfNeedMargin = new PurchaseProjOfNeedMargin();
                    purchaseProjOfNeedMargin.setProjectName(purchaseProject.getPurchaseprojname());
                    purchaseProjOfNeedMargin.setProjectCode(purchaseProject.getPurchaseprojcode());
                    purchaseProjOfNeedMargin.setBuyer(purchaseProject.getPurchasername());
                    if (purchaseProject.getPurchasemode()=="1")
                        purchaseProjOfNeedMargin.setBuyWay("公开招标");
                    else if (purchaseProject.getPurchasemode()=="2")
                        purchaseProjOfNeedMargin.setBuyWay("邀请招标");
                    else if (purchaseProject.getPurchasemode()=="3")
                        purchaseProjOfNeedMargin.setBuyWay("竞争性谈判");
                    else if (purchaseProject.getPurchasemode()=="4")
                        purchaseProjOfNeedMargin.setBuyWay("单一来源采购");
                    else if (purchaseProject.getPurchasemode()=="5")
                        purchaseProjOfNeedMargin.setBuyWay("询价");
                    else if (purchaseProject.getPurchasemode()=="6")
                        purchaseProjOfNeedMargin.setBuyWay("竞争性磋商");
                    else
                        purchaseProjOfNeedMargin.setBuyWay("其他");
                    purchaseProjOfNeedMargin.setProjectSectionCode(section.getPurchasesectioncode());
                    purchaseProjOfNeedMargin.setProjectSectionName(section.getSectionname());
                    purchaseProjOfNeedMargin.setMargin(section.getMargin().doubleValue());
                    purchaseProjOfNeedMargin.setCreatedate(sdf.format(purchaseProject.getCreateTime()));
                    if (bhApplyGuarantee!=null) {
                        purchaseProjOfNeedMargin.setGl_name(bhApplyGuarantee.getGl_name());
                        purchaseProjOfNeedMargin.setApply_no(bhApplyGuarantee.getApply_no());
                        purchaseProjOfNeedMargin.setAccept_no(bhApplyGuarantee.getAccept_no());
                        purchaseProjOfNeedMargin.setPage_flow(bhApplyGuarantee.getPage_flow());
                        purchaseProjOfNeedMargin.setPageflowurl(bhApplyGuarantee.getPageflowurl());
                        purchaseProjOfNeedMargin.setStatus(bhApplyGuarantee.getStatus());
                        purchaseProjOfNeedMargin.setCreatedate(sdf.format(bhApplyGuarantee.getCreatetime()));
                    }
                    purchaseProjOfNeedMarginList.add(purchaseProjOfNeedMargin);
                }
            }
        }
        return purchaseProjOfNeedMarginList;
    }

    public Section getSectionBySecotionCode(String sectioncode) {
        return sectionMapper.getSectionBySecotionCode(sectioncode);
    }

    public PurchaseProject getProjectInfoByProjCode(String projcode) {
        return purchaseProjectMapper.getProjectInfoByProjCode(projcode);
    }

    public PurchaseProjectWithBLOBs getProjectInfoWithBLOBsByProjCode(String projcode) {
        return purchaseProjectMapper.getProjectInfoWithBLOBsByProjCode(projcode);
    }

}
