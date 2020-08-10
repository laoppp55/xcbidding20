package com.bizwink.service;

import com.bizwink.cms.security.AuthPeer;
import com.bizwink.cms.security.IAuthManager;
import com.bizwink.cms.security.UnauthedException;
import com.bizwink.cms.sjswsbs.IWsbsManager;
import com.bizwink.cms.sjswsbs.WsbsPeer;
import org.quartz.*;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Map;

/**
 * Created by Administrator on 15-5-25.
 */

@Service
public class updateLoginUserStatus extends QuartzJobBean {
    public void work(String dtime){
        //实现你的业务逻辑
        System.out.println("每" + dtime + "分钟修改用户登录状态!,并修改2019年8月1号后indexflag=2的文章的indexflag=0" + new Timestamp(System.currentTimeMillis()));

        IAuthManager authMgr = AuthPeer.getInstance();
        IWsbsManager wsbsManager = WsbsPeer.getInstance();
        int i_dtime = Integer.parseInt(dtime);
        try {
            authMgr.removeAllNoActionUsers(i_dtime);
            wsbsManager.updateIndexflag();
        } catch (UnauthedException exp) {
            exp.printStackTrace();
        }
    }

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        Map properties = context.getJobDetail().getJobDataMap();
        String message = (String)properties.get("message");
        this.work(message);
    }
}
