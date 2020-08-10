package com.bizwink.service;

import com.bizwink.po.PurchaseProject;
import com.bizwink.po.PurchaseProjectWithBLOBs;
import com.bizwink.po.PurchasingAgency;
import com.bizwink.po.Section;
import com.bizwink.vo.PurchaseProjOfNeedMargin;

import java.util.List;

public interface IPurchaseProjectService {
    List<PurchaseProjOfNeedMargin> getProjectSectionsOfNeedMargin(String userid);

    Section getSectionBySecotionCode(String sectioncode);

    List<Section> getSectionsByProjcode(String projcode);

    PurchaseProject getProjectInfoByProjCode(String projcode);

    PurchaseProjectWithBLOBs getProjectInfoWithBLOBsByProjCode(String projcode);
}
