package com.bizwink.service;

import com.bizwink.po.PurchasingAgency;
import com.bizwink.po.Template;
import com.bizwink.po.Users;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface IUserService {
    int addUser(Users user);

    int createUserAndEnterpriseInfo(Users user,PurchasingAgency suppino);

    boolean checkName(BigDecimal siteid, String username);

    boolean checkEmail(BigDecimal siteid,String email);

    boolean checkCellphone(BigDecimal siteid,String cellphone);

    Users getUserinfoByUserid(String userid);

    Users getUserinfoByEmail(String email);

    Users getUserinfoByMphone(String mphone);

    boolean changePassword(String username,String email,String cellphone);

    List<Users> getUsersByCustomer(BigDecimal customer);

    int updateUserinfoByUseridSelective(Users user);

    int changePassword(String username,String pwd);

    int updatePwdByUseridAndMphone(String pwd,String userid,String mphone);

    Users getUserinfoByUseridAndMphone(String userid,String mphone);

    Map RegisterUserInfo(List user, List<Template> templates, int TemplateNum, String contactor, int samsiteid);

    Users getUserByCompcode(String compcode,int usertype);

    PurchasingAgency getEnterpriseInfo(String compname);

    PurchasingAgency getEnterpriseInfoByCompcode(String compcode);

    int updateEnterpriseInfo(PurchasingAgency purchasingAgency,String userid);
}
