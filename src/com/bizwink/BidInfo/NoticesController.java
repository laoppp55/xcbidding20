package com.bizwink.BidInfo;

import com.bizwink.po.*;
import com.bizwink.security.Auth;
import com.bizwink.service.INoticeService;
import com.bizwink.util.ParamUtil;
import com.bizwink.util.SessionUtil;
import com.bizwink.util.SpringInit;
import com.bizwink.util.filter;
import com.bizwink.vo.voBaseContract;
import com.bizwink.vo.voBulletinNotice;
import com.bizwink.vo.voChangeNotice;
import com.bizwink.vo.voWinResultsNotice;
import com.google.gson.Gson;
import org.apache.ibatis.annotations.Param;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Controller
public class NoticesController {
    @RequestMapping(value="/BulletinNoticeTop10.do")
    public @ResponseBody List<voBulletinNotice> getBulletinNoticeTop10(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voBulletinNotice> bulletinNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();

        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            bulletinNotices = noticeService.getTopBulletinNotice(now,10);
            //设置查到的每个招标公告是否被当前用户阅读过
            if (bulletinNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<bulletinNotices.size();ii++) {
                        notices_ids.add(bulletinNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<bulletinNotices.size();ii++) {
                        voBulletinNotice voBulletinNotice = bulletinNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voBulletinNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voBulletinNotice.setReadflag(1);
                                break;
                            }
                        }
                        bulletinNotices.set(ii,voBulletinNotice);
                    }
                }
            }
        }

        return  bulletinNotices;
    }

    @RequestMapping(value="/BulletinNoticeList.do")
    public @ResponseBody List<voBulletinNotice> getBulletinNoticeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voBulletinNotice> bulletinNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int startrow = ParamUtil.getIntParameter(request,"start",0);
        int rows = ParamUtil.getIntParameter(request,"rows",20);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            bulletinNotices = noticeService.getBulletinNoticeList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows));
            //设置查到的每个招标公告是否被当前用户阅读过
            if (bulletinNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<bulletinNotices.size();ii++) {
                        notices_ids.add(bulletinNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<bulletinNotices.size();ii++) {
                        voBulletinNotice voBulletinNotice = bulletinNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voBulletinNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voBulletinNotice.setReadflag(1);
                                break;
                            }
                        }
                        bulletinNotices.set(ii,voBulletinNotice);
                    }
                }
            }
        }

        return  bulletinNotices;
    }

    @RequestMapping(value="/BulletinNoticeCount.do")
    @ResponseBody
    public int getBulletinNoticeCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.getBulletinNoticeCount(now);
        }

        return count;
    }

    @RequestMapping(value="/SearchBulletinNotice.do")
    public @ResponseBody List<voBulletinNotice> SearchBulletinNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voBulletinNotice> bulletinNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int pageno = ParamUtil.getIntParameter(request,"page",0);
        int rows = ParamUtil.getIntParameter(request,"rows",10);
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);

        int startrow = 0;
        if (pageno <= 0) {
            startrow = 0;
        } else {
            startrow = pageno * rows;
        }

        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            bulletinNotices = noticeService.SearchBulletinNotice(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows),keyword);
            //设置查到的每个招标公告是否被当前用户阅读过
            if (bulletinNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<bulletinNotices.size();ii++) {
                        notices_ids.add(bulletinNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<bulletinNotices.size();ii++) {
                        voBulletinNotice voBulletinNotice = bulletinNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voBulletinNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voBulletinNotice.setReadflag(1);
                                break;
                            }
                        }
                        bulletinNotices.set(ii,voBulletinNotice);
                    }
                }
            }
        }

        Gson gson = new Gson();
        String jsondata = gson.toJson(bulletinNotices);
        System.out.println(jsondata);

        return  bulletinNotices;
    }

    @RequestMapping(value="/SearchBulletinNoticeCount.do")
    public @ResponseBody int SearchBulletinNoticeCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.SearchBulletinNoticeCount(now,keyword);
        }

        System.out.println("search result:" + count);

        return count;
    }

    @RequestMapping(value="/ChangeNoticeTop10.do")
    public @ResponseBody List<voChangeNotice> getChangeNoticeTop10(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voChangeNotice> changeNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();

        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            changeNotices = noticeService.getTopChangeNotice(now,10);
            //设置查到的每个变更公告是否被当前用户阅读过
            if (changeNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<changeNotices.size();ii++) {
                        notices_ids.add(changeNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<changeNotices.size();ii++) {
                        voChangeNotice voChangeNotice = changeNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voChangeNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voChangeNotice.setReadflag(1);
                                break;
                            }
                        }
                        changeNotices.set(ii,voChangeNotice);
                    }
                }
            }
        }

        return  changeNotices;
    }

    @RequestMapping(value="/ChangeNoticeList.do")
    public @ResponseBody List<voChangeNotice> getChangeNoticeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voChangeNotice> changeNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int startrow = ParamUtil.getIntParameter(request,"start",0);
        int rows = ParamUtil.getIntParameter(request,"rows",20);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            changeNotices = noticeService.getChangeNoticeList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows));
            //设置查到的每个变更公告是否被当前用户阅读过
            if (changeNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<changeNotices.size();ii++) {
                        notices_ids.add(changeNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<changeNotices.size();ii++) {
                        voChangeNotice voChangeNotice = changeNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voChangeNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voChangeNotice.setReadflag(1);
                                break;
                            }
                        }
                        changeNotices.set(ii,voChangeNotice);
                    }
                }
            }
        }

        return  changeNotices;
    }

    @RequestMapping(value="/ChangeNoticeCount.do")
    @ResponseBody
    public int getChangeNoticeCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.getChangeNoticeCount(now);
        }

        return count;
    }

    @RequestMapping(value="/SearchChangeNoticeList.do")
    public @ResponseBody List<voChangeNotice> SearchChangeNoticeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voChangeNotice> changeNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int pageno = ParamUtil.getIntParameter(request,"page",0);
        int rows = ParamUtil.getIntParameter(request,"rows",10);
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);

        int startrow = 0;
        if (pageno <= 0) {
            startrow = 0;
        } else {
            startrow = pageno * rows;
        }

        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            changeNotices = noticeService.SearchChangeNoticeList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows),keyword);
            //设置查到的每个变更公告是否被当前用户阅读过
            if (changeNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<changeNotices.size();ii++) {
                        notices_ids.add(changeNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<changeNotices.size();ii++) {
                        voChangeNotice voChangeNotice = changeNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voChangeNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voChangeNotice.setReadflag(1);
                                break;
                            }
                        }
                        changeNotices.set(ii,voChangeNotice);
                    }
                }
            }
        }

        return  changeNotices;
    }

    @RequestMapping(value="/SearchChangeNoticeCount.do")
    @ResponseBody
    public int SearchChangeNoticeCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.SearchChangeNoticeCount(now,keyword);
        }

        return count;
    }

    @RequestMapping(value="/WinResultsNoticeTop10.do")
    public @ResponseBody List<voWinResultsNotice> getWinResultsNoticeTop10(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voWinResultsNotice> winResultsNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();

        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            winResultsNotices = noticeService.getTopWinResultsNotice(now,10);
            //设置查到的每个中标公告是否被当前用户阅读过
            if (winResultsNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<winResultsNotices.size();ii++) {
                        notices_ids.add(winResultsNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<winResultsNotices.size();ii++) {
                        voWinResultsNotice voWinResultsNotice = winResultsNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voWinResultsNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voWinResultsNotice.setReadflag(1);
                                break;
                            }
                        }
                        winResultsNotices.set(ii,voWinResultsNotice);
                    }
                }
            }
        }

        return  winResultsNotices;
    }

    @RequestMapping(value="/WinResultsNoticeList.do")
    public @ResponseBody List<voWinResultsNotice> getWinResultsNoticeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voWinResultsNotice> winResultsNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int startrow = ParamUtil.getIntParameter(request,"start",0);
        int rows = ParamUtil.getIntParameter(request,"rows",20);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            winResultsNotices = noticeService.getWinResultsNoticeList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows));
            //设置查到的每个中标公告是否被当前用户阅读过
            if (winResultsNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<winResultsNotices.size();ii++) {
                        notices_ids.add(winResultsNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<winResultsNotices.size();ii++) {
                        voWinResultsNotice voWinResultsNotice = winResultsNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voWinResultsNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voWinResultsNotice.setReadflag(1);
                                break;
                            }
                        }
                        winResultsNotices.set(ii,voWinResultsNotice);
                    }
                }
            }
        }

        return  winResultsNotices;
    }

    @RequestMapping(value="/WinResultsNoticeCount.do")
    @ResponseBody
    public int getWinResultsNoticeCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.getWinResultsNoticeCount(now);
        }

        return count;
    }

    @RequestMapping(value="/SearchWinResultsNoticeList.do")
    public @ResponseBody List<voWinResultsNotice> SearchWinResultsNoticeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voWinResultsNotice> winResultsNotices = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int pageno = ParamUtil.getIntParameter(request,"page",0);
        int rows = ParamUtil.getIntParameter(request,"rows",10);
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);

        int startrow = 0;
        if (pageno <= 0) {
            startrow = 0;
        } else {
            startrow = pageno * rows;
        }

        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            winResultsNotices = noticeService.SearchWinResultsNoticeList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows),keyword);
            //设置查到的每个中标公告是否被当前用户阅读过
            if (winResultsNotices!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<winResultsNotices.size();ii++) {
                        notices_ids.add(winResultsNotices.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<winResultsNotices.size();ii++) {
                        voWinResultsNotice voWinResultsNotice = winResultsNotices.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voWinResultsNotice.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voWinResultsNotice.setReadflag(1);
                                break;
                            }
                        }
                        winResultsNotices.set(ii,voWinResultsNotice);
                    }
                }
            }
        }

        return  winResultsNotices;
    }

    @RequestMapping(value="/SearchWinResultsNoticeCount.do")
    @ResponseBody
    public int SearchWinResultsNoticeCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.SearchWinResultsNoticeCount(now,keyword);
        }

        return count;
    }

    @RequestMapping(value="/BaseContractTop10.do")
    public @ResponseBody List<voBaseContract> getBaseContractTop10(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voBaseContract> baseContracts = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();

        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            baseContracts = noticeService.getTopBaseContract(now,10);
            //设置查到的每个合同公告是否被当前用户阅读过
            if (baseContracts!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<baseContracts.size();ii++) {
                        notices_ids.add(baseContracts.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<baseContracts.size();ii++) {
                        voBaseContract voBaseContract = baseContracts.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voBaseContract.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voBaseContract.setReadflag(1);
                                break;
                            }
                        }
                        baseContracts.set(ii,voBaseContract);
                    }
                }
            }
        }

        return  baseContracts;
    }

    @RequestMapping(value="/BaseContractList.do")
    public @ResponseBody List<voBaseContract> getBaseContractList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voBaseContract> baseContracts = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int startrow = ParamUtil.getIntParameter(request,"start",0);
        int rows = ParamUtil.getIntParameter(request,"rows",20);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            baseContracts = noticeService.getBaseContractList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows));
            //设置查到的每个合同公告是否被当前用户阅读过
            if (baseContracts!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<baseContracts.size();ii++) {
                        notices_ids.add(baseContracts.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<baseContracts.size();ii++) {
                        voBaseContract voBaseContract = baseContracts.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voBaseContract.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voBaseContract.setReadflag(1);
                                break;
                            }
                        }
                        baseContracts.set(ii,voBaseContract);
                    }
                }
            }
        }

        return  baseContracts;
    }

    @RequestMapping(value="/BaseContractCount.do")
    @ResponseBody
    public int getBaseContractCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.getBaseContractCount(now);
        }

        return count;
    }

    @RequestMapping(value="/SearchBaseContractList.do")
    public @ResponseBody List<voBaseContract> SearchBaseContractList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        List<voBaseContract> baseContracts = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int pageno = ParamUtil.getIntParameter(request,"page",0);
        int rows = ParamUtil.getIntParameter(request,"rows",10);
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);

        int startrow = 0;
        if (pageno <= 0) {
            startrow = 0;
        } else {
            startrow = pageno * rows;
        }
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            baseContracts = noticeService.SearchBaseContractList(now,BigDecimal.valueOf(startrow),BigDecimal.valueOf(rows),keyword);
            //设置查到的每个合同公告是否被当前用户阅读过
            if (baseContracts!=null) {
                HttpSession session = request.getSession();
                Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
                if (authToken!=null) {
                    List<String> notices_ids = new ArrayList<>();
                    List<ReadNoticeLog> readNoticeLogs = null;
                    for(int ii=0;ii<baseContracts.size();ii++) {
                        notices_ids.add(baseContracts.get(ii).getUuid());
                    }
                    //获取公告已经被该用户读取过的LOG信息
                    readNoticeLogs =noticeService.getReadNotiesLog(authToken.getUserid(),notices_ids);
                    //修改列表的公告是否已经被该用户读过的状态
                    for(int ii=0;ii<baseContracts.size();ii++) {
                        voBaseContract voBaseContract = baseContracts.get(ii);
                        for (int jj = 0; jj < readNoticeLogs.size(); jj++) {
                            if (voBaseContract.getUuid().equalsIgnoreCase(readNoticeLogs.get(jj).getNoticeid())){
                                voBaseContract.setReadflag(1);
                                break;
                            }
                        }
                        baseContracts.set(ii,voBaseContract);
                    }
                }
            }
        }

        return  baseContracts;
    }

    @RequestMapping(value="/SearchBaseContractCount.do")
    @ResponseBody
    public int SearchBaseContractCount(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ApplicationContext appContext = SpringInit.getApplicationContext();
        int count = 0;
        String keyword = ParamUtil.getParameter(request,"keyword");
        if (keyword!=null) keyword = filter.excludeHTMLCode(keyword);
        if (appContext!=null) {
            INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            count = noticeService.SearchBaseContractCount(now,keyword);
        }

        return count;
    }
}
