package com.bizwink.service.impl;

import com.bizwink.persistence.BudgetProjectMapper;
import com.bizwink.po.BudgetProject;
import com.bizwink.service.IBudgetProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BudgetProjectService implements IBudgetProjectService{
    @Autowired
    private BudgetProjectMapper budgetProjectMapper;

   public BudgetProject getBudgetProjByPrjcode(String projectcode) {
       return budgetProjectMapper.getBudgetProjByProjectCode(projectcode);
   }

}
