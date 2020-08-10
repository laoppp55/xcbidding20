package com.bizwink.BidInfo;

import com.bizwink.cms.entity.ApplyCredit;
import com.bizwink.cms.entity.ApplyCreditResult;
import com.bizwink.cms.entity.ApplyCreditRetval;
import com.bizwink.cms.entity.ErrorInfo;
import com.bizwink.cms.server.MyConstants;
import com.bizwink.net.http.Post;
import com.bizwink.po.PurchasingAgency;
import com.bizwink.po.Users;
import com.bizwink.po.bhApplyCredit;
import com.bizwink.po.bhApplyGuarantee;
import com.bizwink.security.Auth;
import com.bizwink.service.IFinanceService;
import com.bizwink.service.IPurchaseProjectService;
import com.bizwink.service.IUserService;
import com.bizwink.util.*;
import com.bizwink.vo.PurchaseProjOfNeedMargin;
import com.bizwink.vo.voApplyCredit;
import net.sf.json.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InvalidObjectException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ManeyOfGureController {        //保证金
    //获取供应商或者投标人已经报名，并且需要交保证金的项目列表，按标包列出
    @RequestMapping(value="/ProjOfNeedMargin.do")
    public @ResponseBody List<PurchaseProjOfNeedMargin> getProjectSectionsOfNeedMargin(HttpServletRequest request, HttpServletResponse response) {
        PurchaseProjOfNeedMargin purchaseProjOfNeedMargin = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        IPurchaseProjectService purchaseProjectService = (IPurchaseProjectService)appContext.getBean("purchaseProjectService");
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        List<PurchaseProjOfNeedMargin> purchaseProjOfNeedMarginList = purchaseProjectService.getProjectSectionsOfNeedMargin(authToken.getUserid());
        return purchaseProjOfNeedMarginList;
    }

    @RequestMapping(value="/ApplyCreditList.do")
    public @ResponseBody List<voApplyCredit> getApplyCredits(HttpServletRequest request, HttpServletResponse response) throws Exception{
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
        }

        String username = authToken.getUsername();
        int startrow = ParamUtil.getIntParameter(request,"start",0);            //获取数据开始的行数
        int rows = ParamUtil.getIntParameter(request, "rows",20);               //获取数据行数

        ApplicationContext appContext = SpringInit.getApplicationContext();
        List<bhApplyCredit> applyCredits = null;
        List<voApplyCredit> voApplyCredits = new ArrayList<>();
        if (appContext!=null) {
            IUserService usersService = (IUserService)appContext.getBean("usersService");
            IFinanceService financeService = (IFinanceService)appContext.getBean("financeService");
            Users us= usersService.getUserinfoByUserid(username);
            applyCredits = financeService.getApplyCredits(us.getCOMPANYCODE(), BigDecimal.valueOf(startrow), BigDecimal.valueOf(rows));
        }

        if (applyCredits==null) {
            response.sendRedirect("/error.jsp");
        } else {
            voApplyCredit voApplyCredit = null;
            bhApplyCredit bhApplyCredit = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd hh:mm:ss");
            for(int ii=0;ii<applyCredits.size();ii++) {
                bhApplyCredit = applyCredits.get(ii);
                voApplyCredit = new voApplyCredit();
                voApplyCredit.setUuid(bhApplyCredit.getUuid());
                voApplyCredit.setApplyname(bhApplyCredit.getApplyname());
                voApplyCredit.setApplyno(bhApplyCredit.getApplyno());
                voApplyCredit.setCreatetime(sdf.format(bhApplyCredit.getCreatetime()));
                voApplyCredit.setAcceptno((bhApplyCredit.getAcceptno()==null)?"":bhApplyCredit.getAcceptno());
                voApplyCredit.setStatus(bhApplyCredit.getStatus());
                voApplyCredit.setCreator(username);
                voApplyCredits.add(voApplyCredit);
            }
        }

        return voApplyCredits;
    }

    @RequestMapping(value="/queryApplyCredit.do")
    public @ResponseBody ApplyCreditResult queryApplyCredit(HttpServletRequest request, HttpServletResponse response) {
        String uuid = ParamUtil.getParameter(request, "uuid");                        //申请授信唯一ID

        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken == null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        ApplicationContext appContext = SpringInit.getApplicationContext();
        bhApplyCredit applyCredit = null;
        ApplyCreditResult applyCreditResult=null;
        try {
            if (appContext != null) {
                IFinanceService financeService = (IFinanceService) appContext.getBean("financeService");
                //获取当前待提交的授信申请
                applyCredit = financeService.getApplyCreditByuuid(uuid);
                if (applyCredit!=null) {
                    if (applyCredit.getAcceptno()!=null && applyCredit.getAcceptno()!="" && !applyCredit.getAcceptno().isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
                        String created = sdf.format(new Date(System.currentTimeMillis()));
                        Map params = new HashMap();
                        params.put("version", "4.0.2");
                        params.put("method", "get_apply_credit_result");
                        params.put("access_key", MyConstants.getAccess_key().trim());
                        params.put("created", created.trim());
                        params.put("platform_id", MyConstants.getPlatform_id().trim());
                        params.put("merchant_id", MyConstants.getMerchant_id().trim());
                        params.put("accept_no", applyCredit.getAcceptno());

                        String result_str = Post.httpRequest(params);

                        System.out.println(result_str);

                        //将返回的字符串转化为申请结果对象
                        JSONObject jsonObject=JSONObject.fromObject(result_str);
                        applyCreditResult=(ApplyCreditResult) JSONObject.toBean(jsonObject, ApplyCreditResult.class);
                    } else{
                        response.sendRedirect("/error");
                        return null;
                    }
                } else {
                    response.sendRedirect("/error");
                    return null;
                }
            } else {
                response.sendRedirect("/error");
                return null;
            }
        } catch (Exception ioexp) {
            ioexp.printStackTrace();
        }

        return applyCreditResult;
    }

    @RequestMapping(value="/updateApplyCredit.do")
    public @ResponseBody ErrorInfo updateApplyCredit(HttpServletRequest request, HttpServletResponse response) {
        ErrorInfo errorInfo = new ErrorInfo();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        String uuid = ParamUtil.getParameter(request, "uuid");                        //申请授信唯一ID

        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken == null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }
        String username = authToken.getUsername();

        ApplicationContext appContext = SpringInit.getApplicationContext();
        bhApplyCredit applyCredit = null;
        if (appContext != null) {
            IFinanceService financeService = (IFinanceService) appContext.getBean("financeService");
            //获取当前待提交的授信申请
            applyCredit = financeService.getApplyCreditByuuid(uuid);
            //修改提交人和提交时间信息
            financeService.updateApplytimeAndApplicant(uuid,username,new Date(System.currentTimeMillis()));
        } else {
            try {
                response.sendRedirect("/error");
                return null;
            } catch (IOException ioexp) {

            }
        }

        return errorInfo;
    }

    @RequestMapping(value="/deleteApplyCredit.do")
    public @ResponseBody ErrorInfo deleteApplyCredit(HttpServletRequest request, HttpServletResponse response) {
        ErrorInfo errorInfo = new ErrorInfo();
        String uuid = ParamUtil.getParameter(request, "uuid");                        //申请授信唯一ID

        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken == null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        ApplicationContext appContext = SpringInit.getApplicationContext();
        bhApplyCredit applyCredit = null;
        if (appContext != null) {
            IFinanceService financeService = (IFinanceService) appContext.getBean("financeService");
            //获取当前待提交的授信申请
            applyCredit = financeService.getApplyCreditByuuid(uuid);
        } else {
            try {
                response.sendRedirect("/error");
                return null;
            } catch (IOException ioexp) {

            }
        }

        return errorInfo;
    }

    @RequestMapping(value="/submitApplyCredit.do")
    public @ResponseBody ErrorInfo submitApplyCredit(HttpServletRequest request, HttpServletResponse response) {
        ErrorInfo  errorInfo= new ErrorInfo();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        String uuid = ParamUtil.getParameter(request,"uuid");                        //申请授信唯一ID

        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }
        String username = authToken.getUsername();

        ApplicationContext appContext = SpringInit.getApplicationContext();
        bhApplyCredit applyCredit = null;
        IFinanceService financeService = null;
        if (appContext!=null) {
            financeService = (IFinanceService) appContext.getBean("financeService");
            //获取当前待提交的授信申请
            applyCredit = financeService.getApplyCreditByuuid(uuid);
            //修改提交人和提交时间信息
            financeService.updateApplytimeAndApplicant(uuid,username,new Date(System.currentTimeMillis()));
        } else {
            try {
                response.sendRedirect("/error");
                return null;
            }catch(IOException ioexp) {

            }
        }

        String applyname = applyCredit.getApplyname();                              //授信申请名称
        String apply_no = applyCredit.getApplyno();                                 //授信申请号，20位
        String enterprise_name = applyCredit.getCompanyName();                      //企业名称
        String enterprise_code = applyCredit.getCompanyCode();                      //企业统一社会信用代码
        String identity_symbol = applyCredit.getIdentitysymbol();                   //企业标识：“enterprise_id:enterprise_name:enterprise_code”其中enterprise_id为交易系统的主键
        String basic_account = applyCredit.getBaseAccount();                        //基本户账号
        String basic_bank_name = applyCredit.getBankOfBaseAccount();                //基本户开户行
        String enterprise_email = applyCredit.getEmail();                           //企业联系邮件
        String legal_name = applyCredit.getLawPersonName();                         //法人姓名
        String legal_id_no = applyCredit.getIdCard();                               //法人身份证号
        String business_license_url = applyCredit.getBusinessLicenseUrl();          //营业执照下载地址
        String enterprise_performances = applyCredit.getEnterprisePerformances();   //企业业绩
        String created = sdf.format(new Date(System.currentTimeMillis()));

        String result_str = null;
        try {
            Map params = new HashMap();
            params.put("version","4.0.2");
            params.put("method","apply_credit");
            params.put("access_key",MyConstants.getAccess_key().trim());
            params.put("created",created.trim());
            params.put("platform_id",MyConstants.getPlatform_id().trim());
            params.put("merchant_id",MyConstants.getMerchant_id().trim());
            params.put("identity_symbol",identity_symbol.trim());
            params.put("apply_no",apply_no.trim());
            params.put("enterprise_name",enterprise_name.trim());
            params.put("enterprise_code",enterprise_code.trim());
            //params.put("basic_account",(basic_account == null) ? "" : basic_account.trim());                //开发程序时基本户账户信息暂时不用
            //params.put("basic_bank_name",(basic_bank_name == null) ? "" : basic_bank_name.trim());          //开发程序时基本户开户行信息暂时不用
            params.put("enterprise_email",(enterprise_email == null) ? "" : enterprise_email.trim());
            params.put("legal_name",(legal_name == null) ? "" : legal_name.trim());
            params.put("legal_id_no",(legal_id_no == null) ? "" : legal_id_no.trim());
            params.put("business_license_url",(business_license_url == null) ? "" : business_license_url.trim());
            params.put("enterprise_performances",(enterprise_performances == null) ? "" : enterprise_performances.trim());

            result_str = Post.httpRequest(params);

            //将返回的字符串转化为申请结果对象
            JSONObject jsonObject=JSONObject.fromObject(result_str);
            ApplyCreditRetval applyCreditResult=(ApplyCreditRetval) JSONObject.toBean(jsonObject, ApplyCreditRetval.class);
            if (applyCreditResult.getResult().equals("success")) {
                String pageflowurl = Des.decrypt(applyCreditResult.getPage_flow(), MyConstants.getSecret_key());
                financeService.updateApplyCreditResult(uuid,1,applyCreditResult.getAccept_no(),applyCreditResult.getPage_flow(),pageflowurl);
                errorInfo.setErrcode(0);
                errorInfo.setErrmsg("成功提交授信申请到金融服务平台成功");
            }
        } catch (Exception exp) {
            errorInfo.setErrcode(-1);
            errorInfo.setErrmsg("提交授信申请到金融服务平台失败");
        }

        return errorInfo;
    }

    @RequestMapping(value="/ApplyCredit.do")
    public @ResponseBody ErrorInfo saveAndSubmitApplyCredit(HttpServletRequest request, HttpServletResponse response) {
        ErrorInfo  errorInfo= new ErrorInfo();
        String applyname = ParamUtil.getParameter(request,"creditName");                      //企业唯一ID
        String enterprise_id = ParamUtil.getParameter(request,"compuuid");                      //企业唯一ID
        String enterprise_name = ParamUtil.getParameter(request, "companyName");               //企业名称
        String enterprise_code = ParamUtil.getParameter(request, "companyCode");               //企业统一社会信用代码
        String basic_account = ParamUtil.getParameter(request, "baseAccount");                 //基本户账号
        String basic_bank_name = ParamUtil.getParameter(request, "bankOfBaseAccount");        //基本户开户行
        String enterprise_email = ParamUtil.getParameter(request, "email");                    //企业联系邮件
        String legal_name = ParamUtil.getParameter(request, "lawPersonName");                 //法人姓名
        String legal_id_no = ParamUtil.getParameter(request, "idCard");                        //法人身份证号
        String business_license_url = ParamUtil.getParameter(request, "businessLicenseUrl");  //营业执照下载地址
        String enterprise_performances = ParamUtil.getParameter(request, "enterprisePerformances");   //企业业绩
        String doaction = ParamUtil.getParameter(request, "action");                             //用户点击的操作按钮

        try {
            if (applyname != null) {
                applyname = URLDecoder.decode(applyname, "utf-8");
                applyname = filter.excludeHTMLCode(applyname);
            } else {
                applyname = "";
            }
            if (enterprise_id!=null) {
                enterprise_id = URLDecoder.decode(enterprise_id, "utf-8");
                enterprise_id = filter.excludeHTMLCode(enterprise_id);
            } else {
                enterprise_id = "";
            }
            if (enterprise_name!=null) {
                enterprise_name = URLDecoder.decode(enterprise_name, "utf-8");
                enterprise_name = filter.excludeHTMLCode(enterprise_name);
            } else {
                enterprise_name = "";
            }
            if (enterprise_code!=null) {
                enterprise_code = URLDecoder.decode(enterprise_code, "utf-8");
                enterprise_code = filter.excludeHTMLCode(enterprise_code);
            } else {
                enterprise_code = "";
            }
            if (basic_account!=null) {
                basic_account = URLDecoder.decode(basic_account, "utf-8");
                basic_account = filter.excludeHTMLCode(basic_account);
            } else {
                basic_account = "";
            }
            if (basic_bank_name!=null) {
                basic_bank_name = URLDecoder.decode(basic_bank_name, "utf-8");
                basic_bank_name = filter.excludeHTMLCode(basic_bank_name);
            } else {
                basic_bank_name = "";
            }
            if (enterprise_email!=null) {
                enterprise_email = URLDecoder.decode(enterprise_email, "utf-8");
                enterprise_email = filter.excludeHTMLCode(enterprise_email);
            } else{
                enterprise_email = "";
            }
            if (legal_name!=null) {
                legal_name = URLDecoder.decode(legal_name, "utf-8");
                legal_name = filter.excludeHTMLCode(legal_name);
            } else {
                legal_name = "";
            }
            if (legal_id_no!=null) {
                legal_id_no = URLDecoder.decode(legal_id_no, "utf-8");
                legal_id_no = filter.excludeHTMLCode(legal_id_no);
            } else {
                legal_id_no = "";
            }
            if (business_license_url!=null) {
                business_license_url = URLDecoder.decode(business_license_url, "utf-8");
                business_license_url = filter.excludeHTMLCode(business_license_url);
            } else{
                business_license_url = "";
            }
            if (enterprise_performances!=null) {
                enterprise_performances = URLDecoder.decode(enterprise_performances, "utf-8");
                enterprise_performances = filter.excludeHTMLCode(enterprise_performances);
            } else {
                enterprise_performances = "";
            }

        } catch(UnsupportedEncodingException exp) {

        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        String created = sdf.format(new Date(System.currentTimeMillis()));
        String apply_no = "xc" + GenerateUniqueIdUtil.getGuid();
        String identity_symbol = enterprise_id + ":" + enterprise_name + ":" + enterprise_code;

        String uuid = UUID.randomUUID().toString();
        uuid = uuid.replace("-", "");

        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        String username = authToken.getUsername();

        bhApplyCredit applyCredit = new bhApplyCredit();
        applyCredit.setUuid(uuid);
        applyCredit.setCompanyName(enterprise_name);
        applyCredit.setCompanyCode(enterprise_code);
        applyCredit.setApplyname(applyname);
        applyCredit.setApplyno(apply_no);
        applyCredit.setBankOfBaseAccount(basic_bank_name);
        applyCredit.setBaseAccount(basic_account);
        applyCredit.setEmail(enterprise_email);
        applyCredit.setLawPersonName(legal_name);
        applyCredit.setIdCard(legal_id_no);
        applyCredit.setBusinessLicenseUrl(business_license_url);
        if (doaction.equals("dosubmit"))
            applyCredit.setStatus(0);
        else
            applyCredit.setStatus(-1);
        applyCredit.setEnterprisePerformances(enterprise_performances);
        applyCredit.setIdentitysymbol(identity_symbol);
        applyCredit.setCreatetime(new Date(System.currentTimeMillis()));
        applyCredit.setUodatetime(new Date(System.currentTimeMillis()));
        applyCredit.setCreator(username);
        applyCredit.setModifier(username);
        if (doaction.equals("dosubmit")) {              //如果该申请信息同时被提交到金融服务平台，记录提交人和提交时间
            applyCredit.setApplicant(username);
            applyCredit.setApplytime(new Date(System.currentTimeMillis()));
        }

        ApplicationContext appContext = SpringInit.getApplicationContext();
        IFinanceService financeService = null;
        if (appContext!=null) {
            financeService = (IFinanceService) appContext.getBean("financeService");
            int retcode = financeService.saveApplyCreditInfo(applyCredit);
            errorInfo.setErrcode(0);
            errorInfo.setErrmsg("保存授信申请信息成功");
        } else {
            try {
                response.sendRedirect("/error");
                return null;
            }catch(IOException ioexp) {

            }
        }

        if (doaction.equals("dosubmit")) {              //信息提交到金融服务平台
            String result_str = null;
            try {
                Map params = new HashMap();
                params.put("version","4.0.2");
                params.put("method","apply_credit");
                params.put("access_key",MyConstants.getAccess_key().trim());
                params.put("created",created.trim());
                params.put("platform_id",MyConstants.getPlatform_id().trim());
                params.put("merchant_id",MyConstants.getMerchant_id().trim());
                params.put("identity_symbol",identity_symbol.trim());
                params.put("apply_no",apply_no.trim());
                params.put("enterprise_name",enterprise_name.trim());
                params.put("enterprise_code",enterprise_code.trim());
                //params.put("basic_account",(basic_account == null) ? "" : basic_account.trim());                //开发程序时基本户账户信息暂时不用
                //params.put("basic_bank_name",(basic_bank_name == null) ? "" : basic_bank_name.trim());          //开发程序时基本户开户行信息暂时不用
                params.put("enterprise_email",(enterprise_email == null) ? "" : enterprise_email.trim());
                params.put("legal_name",(legal_name == null) ? "" : legal_name.trim());
                params.put("legal_id_no",(legal_id_no == null) ? "" : legal_id_no.trim());
                params.put("business_license_url",(business_license_url == null) ? "" : business_license_url.trim());
                params.put("enterprise_performances",(enterprise_performances == null) ? "" : enterprise_performances.trim());

                result_str = Post.httpRequest(params);

                //将返回的字符串转化为申请结果对象
                JSONObject jsonObject=JSONObject.fromObject(result_str);
                ApplyCreditRetval applyCreditResult=(ApplyCreditRetval) JSONObject.toBean(jsonObject, ApplyCreditRetval.class);
                if (applyCreditResult.getResult().equals("success")) {
                    String pageflowurl = Des.decrypt(applyCreditResult.getPage_flow(), MyConstants.getSecret_key());
                    financeService.updateApplyCreditResult(uuid,1,applyCreditResult.getAccept_no(),applyCreditResult.getPage_flow(),pageflowurl);
                    errorInfo.setErrcode(0);
                    errorInfo.setErrmsg("成功提交授信申请到金融服务平台成功");
                }
            } catch (Exception exp) {
                errorInfo.setErrcode(-1);
                errorInfo.setErrmsg("提交授信申请到金融服务平台失败");
            }
        }
        return errorInfo;
    }

    //申请保函
    @RequestMapping(value="/ApplyGuaranteeLetter.do")
    public @ResponseBody ErrorInfo saveAndSubmitApplyGL(HttpServletRequest request, HttpServletResponse response) {
        ErrorInfo errorInfo = new ErrorInfo();

        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        String GLName = ParamUtil.getParameter(request, "GLName");                              //保函名称
        String compuuid = ParamUtil.getParameter(request, "compuuid");                              //申请保函的标包ID
        String enterprise_name = ParamUtil.getParameter(request, "enterprise_name");               //企业名称
        String enterprise_code = ParamUtil.getParameter(request, "enterprise_code");               //企业统一社会信用代码
        String project_name = ParamUtil.getParameter(request, "project_name");                     //项目名称
        String project_code = ParamUtil.getParameter(request, "project_code");                     //项目编码
        String project_area = ParamUtil.getParameter(request, "project_area");                     //项目所在区域
        String section_name = ParamUtil.getParameter(request, "section_name");                     //标包名称
        String section_code = ParamUtil.getParameter(request, "section_code");                     //标包编码
        String business_license_url = ParamUtil.getParameter(request, "business_license_url");    //营业执照下载地址
        String tenderer = ParamUtil.getParameter(request, "tenderer");                              //采购人名称
        String agency = ParamUtil.getParameter(request, "agency");                                  //采购代理名称
        String tenderer_address = ParamUtil.getParameter(request, "tenderer_address");             //采购人地址
        String tender_type = ParamUtil.getParameter(request, "tender_type");                        //采购类型
        String tender_bond = ParamUtil.getParameter(request, "tender_bond");                        //保证金数额
        String tender_start_time = ParamUtil.getParameter(request, "tender_start_time");            //投标开始时间
        String tender_expire = ParamUtil.getParameter(request, "tender_expire");                     //投标结束时间
        String agent_name = ParamUtil.getParameter(request, "agent_name");                            //经办人姓名
        String agent_id_no = ParamUtil.getParameter(request, "agent_id_no");                          //经办人身份证号
        String agent_phone = ParamUtil.getParameter(request, "agent_phone");                          //经办人手机
        String tender_file_urls = ParamUtil.getParameter(request, "tender_file_urls");                //招标文件下载地址
        String signinfo = ParamUtil.getParameter(request, "sign");                                     //MD5字符串
        String doaction = ParamUtil.getParameter(request, "action");                                   //用户点击的操作按钮

        try {
            if (GLName != null) {
                GLName = URLDecoder.decode(GLName, "utf-8");
                GLName = filter.excludeHTMLCode(GLName);
            } else {
                GLName = "";
            }
            if (enterprise_name != null) {
                enterprise_name = URLDecoder.decode(enterprise_name, "utf-8");
                enterprise_name = filter.excludeHTMLCode(enterprise_name);
            } else {
                enterprise_name = "";
            }
            if (project_name != null) {
                project_name = URLDecoder.decode(project_name, "utf-8");
                project_name = filter.excludeHTMLCode(project_name);
            } else {
                project_name = "";
            }
            if (section_name != null) {
                section_name = URLDecoder.decode(section_name, "utf-8");
                section_name = filter.excludeHTMLCode(section_name);
            } else {
                section_name = "";
            }
            if (tenderer != null) {
                tenderer = URLDecoder.decode(tenderer, "utf-8");
                tenderer = filter.excludeHTMLCode(tenderer);
            } else {
                tenderer = "";
            }
            if (agency != null) {
                agency = URLDecoder.decode(agency, "utf-8");
                agency = filter.excludeHTMLCode(agency);
            } else {
                agency = "";
            }
            if (tenderer_address != null) {
                tenderer_address = URLDecoder.decode(tenderer_address, "utf-8");
                tenderer_address = filter.excludeHTMLCode(tenderer_address);
            } else {
                tenderer_address = "";
            }
            if (tender_start_time != null) {
                tender_start_time = URLDecoder.decode(tender_start_time, "utf-8");
                tender_start_time = filter.excludeHTMLCode(tender_start_time);
            } else {
                tender_start_time = "";
            }
            if (tender_expire != null) {
                tender_expire = URLDecoder.decode(tender_expire, "utf-8");
                tender_expire = filter.excludeHTMLCode(tender_expire);
            } else {
                tender_expire = "";
            }
            if (agent_name != null) {
                agent_name = URLDecoder.decode(agent_name, "utf-8");
                agent_name = filter.excludeHTMLCode(agent_name);
            } else {
                agent_name = "";
            }
            if (agent_phone != null) {
                agent_phone = URLDecoder.decode(agent_phone, "utf-8");
                agent_phone = filter.excludeHTMLCode(agent_phone);
            } else {
                agent_phone = "";
            }
            if (agent_id_no != null) {
                agent_id_no = URLDecoder.decode(agent_id_no, "utf-8");
                agent_id_no = filter.excludeHTMLCode(agent_id_no);
            } else {
                agent_id_no = "";
            }
            if (tender_file_urls != null) {
                tender_file_urls = URLDecoder.decode(tender_file_urls, "utf-8");
                tender_file_urls = filter.excludeHTMLCode(tender_file_urls);
            } else {
                tender_file_urls = "";
            }
            if (business_license_url != null) {
                business_license_url = URLDecoder.decode(business_license_url, "utf-8");
                business_license_url = filter.excludeHTMLCode(business_license_url);
            } else {
                business_license_url = "";
            }
        } catch(UnsupportedEncodingException exp) { }
        String messages = "GLName=" + GLName + "&compuuid=" + compuuid + "&enterprise_name=" + enterprise_name  + "&enterprise_code=" + enterprise_code +
                "&project_name=" + project_name + "&project_code=" + project_code + "&project_area=" + project_area + "&section_name=" + section_name +
                "&section_code=" + section_code + "&tenderer=" + tenderer + "&agency=" + agency + "&tenderer_address=" + tenderer_address + "&tender_type=" + tender_type +
                "&tender_bond=" + tender_bond + "&tender_start_time=" + tender_start_time + "&tender_expire=" + tender_expire + "&agent_name=" + agent_name +
                "&agent_id_no=" + agent_id_no + "&agent_phone=" + agent_phone + "&business_license_url=" + business_license_url + "&tender_file_urls=" + tender_file_urls;

        String md5val = Md5.md5(messages);

        ApplicationContext appContext = SpringInit.getApplicationContext();
        if (appContext!=null) {
            if (md5val.equals(signinfo)) {
                IUserService usersService = (IUserService)appContext.getBean("usersService");
                IFinanceService financeService = (IFinanceService)appContext.getBean("financeService");
                Users us= usersService.getUserinfoByUserid(authToken.getUserid());
                PurchasingAgency purchasingAgency = usersService.getEnterpriseInfoByCompcode(us.getCOMPANYCODE());

                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
                Timestamp now = new Timestamp(System.currentTimeMillis());
                String created = sdf.format(new Date(now.getTime()));
                String apply_no = "xc" + GenerateUniqueIdUtil.getGuid();
                String identity_symbol = purchasingAgency.getUuid() + ":" + enterprise_name + ":" + enterprise_code;

                String uuid = UUID.randomUUID().toString();
                uuid = uuid.replace("-", "");

                try {
                    Timestamp db_tenderStartTime = new Timestamp(sdf.parse(tender_start_time).getTime());
                    Timestamp db_tenderEndTime = new Timestamp(sdf.parse(tender_expire).getTime());

                    bhApplyGuarantee bhApplyGuarantee = new bhApplyGuarantee();
                    bhApplyGuarantee.setUuid(uuid);
                    bhApplyGuarantee.setGl_name(GLName);
                    bhApplyGuarantee.setApply_no(apply_no);
                    bhApplyGuarantee.setEnterprise_name(enterprise_name);
                    bhApplyGuarantee.setEnterprise_code(enterprise_code);
                    bhApplyGuarantee.setProject_name(project_name);
                    bhApplyGuarantee.setProject_code(project_code);
                    bhApplyGuarantee.setProject_area(project_area);
                    bhApplyGuarantee.setSection_name(section_name);
                    bhApplyGuarantee.setSection_code(section_code);
                    bhApplyGuarantee.setTenderer(tenderer);
                    bhApplyGuarantee.setAgency(agency);
                    bhApplyGuarantee.setTenderer_address(tenderer_address);
                    bhApplyGuarantee.setTender_type(tender_type);
                    bhApplyGuarantee.setTender_bond(tender_bond);
                    bhApplyGuarantee.setTender_start_time(sdf.format(db_tenderStartTime));
                    bhApplyGuarantee.setTender_expire(sdf.format(db_tenderEndTime));
                    bhApplyGuarantee.setAgent_name(agent_name);
                    bhApplyGuarantee.setAgent_id_no(agent_id_no);
                    bhApplyGuarantee.setAgent_phone(agent_phone);
                    bhApplyGuarantee.setBusiness_license_url(business_license_url);
                    bhApplyGuarantee.setTender_file_urls(tender_file_urls);
                    if (doaction.equals("dosubmit"))
                        bhApplyGuarantee.setStatus(0);
                    else
                        bhApplyGuarantee.setStatus(-1);
                    bhApplyGuarantee.setCreatetime(now);
                    bhApplyGuarantee.setCreator(us.getUSERID());
                    bhApplyGuarantee.setUpdatetime(now);
                    bhApplyGuarantee.setModifier(us.getUSERID());

                    int retval = financeService.saveGL(bhApplyGuarantee);

                    //计算投标有效期的天数
                    SimpleDateFormat sdf_a = new SimpleDateFormat("yyyy-MM-dd");
                    //投标开始时间
                    Timestamp startdate = new Timestamp(sdf_a.parse(tender_start_time).getTime());
                    //投标结束时间
                    Timestamp enddate = new Timestamp(sdf_a.parse(tender_expire).getTime());
                    //计算两个时间之间的天数
                    int betweenDays = (int) (Math.abs(enddate.getTime() - startdate.getTime())/(24*3600*1000));

                    if (doaction.equals("dosubmit")) {              //信息提交到金融服务平台
                        String result_str = null;
                        Map params = new HashMap();
                        params.put("version","4.0.2");
                        params.put("method","apply_guarantee");
                        params.put("access_key",MyConstants.getAccess_key().trim());
                        params.put("created",created.trim());
                        params.put("platform_id",MyConstants.getPlatform_id().trim());
                        params.put("merchant_id",MyConstants.getMerchant_id().trim());
                        params.put("identity_symbol",identity_symbol.trim());
                        params.put("apply_no",apply_no.trim());
                        params.put("enterprise_name",enterprise_name);
                        params.put("enterprise_code",enterprise_code);
                        params.put("project_name",project_name);
                        params.put("project_code",project_code);
                        params.put("project_area",project_area);
                        params.put("section_name",section_name);
                        params.put("section_code",section_code);
                        params.put("tenderer",tenderer);
                        params.put("agency",agency);
                        params.put("tenderer_address",tenderer_address);
                        params.put("tender_type",tender_type);
                        params.put("tender_bond",tender_bond);
                        params.put("tender_start_time",sdf.format(db_tenderStartTime));
                        params.put("tender_expire",String.valueOf(betweenDays));
                        params.put("agent_name",agent_name);
                        params.put("agent_id_no",agent_id_no);
                        params.put("agent_phone",agent_phone);
                        params.put("business_license_url",business_license_url);
                        params.put("tender_file_urls",tender_file_urls);

                        result_str = Post.httpRequest(params);
                        System.out.println(result_str);

                        //将返回的字符串转化为申请结果对象
                        JSONObject jsonObject=JSONObject.fromObject(result_str);
                        ApplyCreditRetval applyCreditResult=(ApplyCreditRetval) JSONObject.toBean(jsonObject, ApplyCreditRetval.class);
                        if (applyCreditResult.getResult().equals("success")) {
                            String pageflowurl = Des.decrypt(applyCreditResult.getPage_flow(), MyConstants.getSecret_key());
                            financeService.updateApplyGuaranteeResult(uuid,1,applyCreditResult.getAccept_no(),applyCreditResult.getPage_flow(),pageflowurl);
                            errorInfo.setErrcode(0);
                            errorInfo.setErrmsg("成功提交保函申请到金融服务平台成功");
                        }

                    }

                } catch (Exception exp) {
                    exp.printStackTrace();
                }
            }
        }

        return errorInfo;
    }

    //根据标包的编码查询该标包是否申请过保函或者保证金子账号
    @RequestMapping(value="/queryGuaranteeLetter.do")
    public @ResponseBody bhApplyGuarantee queryApplyGL(HttpServletRequest request, HttpServletResponse response) {
        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        String section_code = ParamUtil.getParameter(request, "section_code");                     //标包编码
        bhApplyGuarantee bhApplyGuarantee = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        if (appContext!=null) {
            IFinanceService financeService = (IFinanceService)appContext.getBean("financeService");
            bhApplyGuarantee = financeService.queryGuaranteeLetter(section_code);
        }
        return bhApplyGuarantee;
    }

    //查询保函申请结果
    @RequestMapping(value="/queryGLApplyResult.do")
    public @ResponseBody bhApplyGuarantee queryGLApplyResult(HttpServletRequest request, HttpServletResponse response) {
        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        String section_code = ParamUtil.getParameter(request, "section_code");                     //标包编码

        bhApplyGuarantee bhApplyGuarantee = null;
        ApplicationContext appContext = SpringInit.getApplicationContext();
        if (appContext!=null) {
            IFinanceService financeService = (IFinanceService)appContext.getBean("financeService");
            bhApplyGuarantee = financeService.queryGuaranteeLetter(section_code);

            //如果保函申请数据不为空，特别是保函受理业务号不为空，查询保函的受理结果
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
                String created = sdf.format(new Timestamp(System.currentTimeMillis()));
                if (bhApplyGuarantee != null) {
                    if (bhApplyGuarantee.getAccept_no() != null) {
                        //if (bhApplyGuarantee.getGuarantee_no()==null && bhApplyGuarantee.getGuarantee_url()==null) {
                        String result_str = null;
                        Map params = new HashMap();
                        params.put("version", "4.0.2");
                        params.put("method", "get_apply_guarantee_result");
                        params.put("access_key", MyConstants.getAccess_key().trim());
                        params.put("created", created.trim());
                        params.put("platform_id", MyConstants.getPlatform_id().trim());
                        params.put("merchant_id", MyConstants.getMerchant_id().trim());
                        params.put("accept_no", bhApplyGuarantee.getAccept_no());
                        result_str = Post.httpRequest(params);
                        System.out.println(result_str);
                        //将返回值保存到查询结果对象
                        org.json.JSONObject jsonObj = new org.json.JSONObject(result_str);
                        bhApplyGuarantee bhApplyGuaranteeResult = new bhApplyGuarantee();
                        bhApplyGuaranteeResult.setUuid(bhApplyGuarantee.getUuid());
                        bhApplyGuaranteeResult.setEncrypt_status(jsonObj.getInt("encrypt_status"));
                        bhApplyGuaranteeResult.setStatus(jsonObj.getInt("status"));
                        bhApplyGuaranteeResult.setGuarantee_no(jsonObj.getString("guarantee_no"));
                        bhApplyGuaranteeResult.setGuarantee_url(jsonObj.getString("guarantee_url"));
                        bhApplyGuaranteeResult.setResult_page_flow(jsonObj.getString("page_flow"));
                        bhApplyGuaranteeResult.setResult(jsonObj.getString("result"));

                        //保存查询结果信息
                        financeService.updateGuaranteeLetterQueryResult(bhApplyGuaranteeResult);

                        //设置查询结果返回值
                        bhApplyGuarantee.setEncrypt_status(jsonObj.getInt("encrypt_status"));
                        bhApplyGuarantee.setStatus(jsonObj.getInt("status"));
                        bhApplyGuarantee.setGuarantee_no(jsonObj.getString("guarantee_no"));
                        bhApplyGuarantee.setGuarantee_url(jsonObj.getString("guarantee_url"));
                        bhApplyGuarantee.setResult_page_flow(jsonObj.getString("page_flow"));
                        //}
                    }
                }
            } catch (Exception exp) {
                exp.printStackTrace();
            }
        }
        return bhApplyGuarantee;
    }

    //查询保函申请结果
    @RequestMapping(value="/ApplyGuaranteeLetterDelay.do")
    public @ResponseBody bhApplyGuarantee ApplyGuaranteeLetterDelay(HttpServletRequest request, HttpServletResponse response) {
        //获取登录的用户名
        HttpSession session = request.getSession();
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        if (authToken==null) {
            try {
                response.sendRedirect("/users/login.jsp?errcode=-1");   //错误码为-1表示用户需要登录系统才能进行后续操作
                return null;
            } catch (IOException ioexp) {

            }
        }

        String hbuuid = ParamUtil.getParameter(request, "hbuuid");                     //保函申请的UUID
        String GLCode = ParamUtil.getParameter(request, "GLCode");                     //保函申请的UUID
        String delayDays = ParamUtil.getParameter(request, "delayDays");                     //保函申请的UUID
        String signinfo = ParamUtil.getParameter(request, "sign");                                     //MD5字符串

        try {
            if (GLCode != null) {
                GLCode = URLDecoder.decode(GLCode, "utf-8");
                GLCode = filter.excludeHTMLCode(GLCode);
            } else {
                GLCode = "";
            }

            if (hbuuid != null) {
                hbuuid = URLDecoder.decode(hbuuid, "utf-8");
                hbuuid = filter.excludeHTMLCode(hbuuid);
            } else {
                hbuuid = "";
            }

            if (delayDays != null) {
                delayDays = URLDecoder.decode(delayDays, "utf-8");
                delayDays = filter.excludeHTMLCode(delayDays);
            } else {
                delayDays = "";
            }

            String messages = "&hbuuid=" + hbuuid + "GLCode=" + GLCode + "&delayDays=" + delayDays;
            String md5val = Md5.md5(messages);
            System.out.println(signinfo + "==" + md5val);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
            Timestamp now = new Timestamp(System.currentTimeMillis());
            String created = sdf.format(new Date(now.getTime()));

            ApplicationContext appContext = SpringInit.getApplicationContext();
            if (appContext != null) {
                if (md5val.equals(signinfo)) {
                    IUserService usersService = (IUserService) appContext.getBean("usersService");
                    Users us = usersService.getUserinfoByUserid(authToken.getUserid());
                    PurchasingAgency purchasingAgency = usersService.getEnterpriseInfoByCompcode(us.getCOMPANYCODE());
                    String identity_symbol = purchasingAgency.getUuid() + ":" + purchasingAgency.getOrganName() + ":" + purchasingAgency.getLegalCode();
                    String apply_no = "xc" + GenerateUniqueIdUtil.getGuid();
                    String result_str = null;
                    Map params = new HashMap();
                    params.put("version", "4.0.2");
                    params.put("method","guarantee_delay");
                    params.put("access_key", MyConstants.getAccess_key().trim());
                    params.put("created", created.trim());
                    params.put("platform_id", MyConstants.getPlatform_id().trim());
                    params.put("merchant_id", MyConstants.getMerchant_id().trim());
                    params.put("identity_symbol", identity_symbol);
                    params.put("apply_no", apply_no);
                    params.put("guarantee_no", GLCode);
                    params.put("delay_days", delayDays);
                    result_str = Post.httpRequest(params);
                    System.out.println(result_str);
                }
            }
        } catch (Exception exp) {
            exp.printStackTrace();
        }
        return null;
    }
}
