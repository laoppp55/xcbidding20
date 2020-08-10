package com.bizwink.mysql.service;

import com.bizwink.error.ErrorMessage;
import com.bizwink.mysql.persistence.*;
import com.bizwink.mysql.po.*;
import com.bizwink.util.Encrypt;
import com.bizwink.util.SpringInit;
import com.jolbox.bonecp.BoneCPDataSource;
import com.sun.org.apache.regexp.internal.recompile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 17-12-30.
 */
@Service
public class MUsersService {
    @Autowired
    private UsersMapper usersMapper;
    @Autowired
    private ColumnMapper columnMapper;
    @Autowired
    private SiteinfoMapper siteinfoMapper;
    @Autowired
    private SiteipinfoMapper siteipinfoMapper;
    @Autowired
    private CompanyinfoMapper companyinfoMapper;
    @Autowired
    private OrganizationMapper organizationMapper;
    @Autowired
    private TemplateMapper templateMapper;
    @Autowired
    private SitesNumberMapper sitesNumberMapper;
    @Autowired
    private MembersRightsMapper membersRightsMapper;
    @Autowired
    private PublishQueueMapper publishQueueMapper;


    public int addUser(Users user) {
        int errcode = 0;
        Users t_user = usersMapper.selectByUserid(user.getUserid());
        if (t_user!=null) {
            errcode = -1;
        }

        List<Users> tt_user = usersMapper.selectByEmail(user.getEmail());
        if (tt_user != null) {
            if (tt_user.size()>0)
                errcode = -2;
        }

        tt_user = usersMapper.selectByMphone(user.getMphone());
        if (tt_user!=null) {
            if (tt_user.size()>0)
                errcode = -3;
        }

        if (errcode==0){
            errcode = usersMapper.insert(user);
        }

        return  errcode;
    }

    public boolean checkName(BigDecimal siteid,String username) {
        Users user = usersMapper.selectByUserid(username);
        if (user == null) {
            return false;
        } else {
            return true;
        }
    }

    public boolean checkEmail(BigDecimal siteid,String email) {
        List<Users> users = usersMapper.selectByEmail(email);
        if (users == null) {
            return false;
        } else {
            if (users.size()==0) {
                System.out.println("使用" + email + "手机号的用户有" + users.size());
                return false;
            } else
                return true;
        }
    }

    public boolean checkCellphone(BigDecimal siteid,String cellphone) {
        List<Users> users = usersMapper.selectByMphone(cellphone);
        if (users == null) {
            return false;
        } else {
            if (users.size() == 0) {
                System.out.println("使用" + cellphone + "手机号的用户有" + users.size());
                return false;
            } else
                return true;
        }
    }

    public Users getUserinfoByUserid(String userid) {
        return usersMapper.selectByUserid(userid);
    }

    public Users getUserinfoByUseridAndMphone(String userid,String mphone) {
        Map params = new HashMap();
        params.put("userid",userid);
        params.put("mphone",mphone);

        return usersMapper.selectByUseridAndMphone(params);
    }

    public int updatePwdByUseridAndMphone(String pwd,String userid,String mphone) {
        Map params = new HashMap();
        params.put("userid",userid);
        params.put("mphone",mphone);
        params.put("userpwd",pwd);

        return usersMapper.updatePwdByUserid(params);
    }

    public List<Users> getUserinfoByEmail(String email) {
        return usersMapper.selectByEmail(email);
    }

    public List<Users> getUserinfoByMphone(String mphone) {
        return usersMapper.selectByMphone(mphone);
    }

    public int updateUserinfoByUseridSelective(Users user) {
        int errcode = 0;
        List<Users> tt_user = usersMapper.selectByEmail(user.getEmail());
        if (tt_user != null) {
            if (tt_user.size()>0)
                errcode = -2;
        }

        tt_user = usersMapper.selectByMphone(user.getMphone());
        if (tt_user!=null) {
            if (tt_user.size()>0)
                errcode = -3;
        }

        if (errcode==0){
            errcode = usersMapper.updateByUseridSelective(user);
        }

        return errcode;
    }

    public int changePassword(String username,String pwd) {
        Map params = new HashMap();
        params.put("userid",username);
        params.put("userpwd",pwd);
        return usersMapper.updatePwdByUserid(params);
    }
}
