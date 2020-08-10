package com.bizwink.BidInfo;

import com.bizwink.cms.server.InitServer;
import com.bizwink.cms.server.MyConstants;
import com.bizwink.net.sftp.FtpFileToDest;
import com.bizwink.po.BidderInfo;
import com.bizwink.po.BulletinNoticeWithBLOBs;
import com.bizwink.po.PurchasingAgency;
import com.bizwink.po.Users;
import com.bizwink.security.Auth;
import com.bizwink.service.IBidderInfoService;
import com.bizwink.service.INoticeService;
import com.bizwink.service.IUserService;
import com.bizwink.util.*;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@Controller
public class BidApplication {
    @RequestMapping(value = "/createBidApplication.do")
    public String saveBidApplicationInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String bulletinNotice_uuid = filter.excludeHTMLCode(ParamUtil.getParameter(request, "uuid"));                                 //招标（资审）公告uuid
        String projName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "projName"));                         //潜在投标人拟投项目名称
        String projCode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "projCode"));                         //潜在投标人拟投项目编码
        String buyerName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "buyerName"));                       //购买人名称
        String buyerPhone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "buyerPhone"));                     //购买人联系电话
        String agentName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "agentName"));                       //招标代理机构名称
        String agentPhone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "projCode"));                       //招标代理机构联系电话
        String suppliername = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppliername"));                //潜在投标人名称
        String supplierCode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "supplierCode"));                //潜在投标人统一社会信用代码
        String lawPersonName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "lawPersonName"));              //潜在投标人法人代表名称
        String lawPersonTel = ParamUtil.getParameter(request, "lawPersonTel");                                        //潜在投标人法人代表联系电话
        String contactorname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactorname"));              //潜在投标人联系人姓名
        String contactormphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactormphone"));          //潜在投标人联系人手机
        String contactorphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactorphone"));            //潜在投标人联系人电话
        String email = filter.excludeHTMLCode(ParamUtil.getParameter(request, "email"));                               //潜在投标人联系人电子邮件
        String idcard = filter.excludeHTMLCode(ParamUtil.getParameter(request, "idcard"));                             //潜在投标人联系人身份证号
        String idcardpic_frontfile = ParamUtil.getParameter(request, "idcardpic_frontfile");                         //身份证正面文件
        String idcardpic_backfile = ParamUtil.getParameter(request, "idcardpic_backfile");                           //身份证背面文件
        String licensepic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "licensepic"));                    //潜在投标人营业执照图片
        String authletterpic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "authletterpic"));             //风险承诺书图片名称
        String otherpic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "otherpic"));                        //其它上传文件
        String yzcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "yzcode"));                            //图形验证码
        String checkcode = ParamUtil.getParameter(request, "checkval");

        if (lawPersonTel == null)
            lawPersonTel="";
        else
            lawPersonTel = filter.excludeHTMLCode(lawPersonTel);
        if (idcardpic_backfile == null)
            idcardpic_backfile = "";
        else
            idcardpic_backfile = filter.excludeHTMLCode(idcardpic_backfile);
        if (otherpic == null)
            otherpic = "";
        else
            otherpic = filter.excludeHTMLCode(otherpic);

        String messages = "uuid=" + bulletinNotice_uuid + "&suppliername=" + suppliername  + "&supplierCode=" + supplierCode + "&lawPersonName=" + lawPersonName + "&lawPersonTel=" + lawPersonTel +
                "&contactorname=" + contactorname + "&contactormphone=" + contactormphone + "&contactorphone=" + contactorphone + "&email=" + email + "&yzcode=" + yzcode +
                "&idcard=" + idcard + "&idcardpic_frontfile=" + idcardpic_frontfile + "&idcardpic_backfile=" + idcardpic_backfile + "&licensepic=" + licensepic +
                "&authletterpic=" + authletterpic + "&otherpic=" + otherpic;

        String paramVals = MD5Util.MD5Encode(messages,"utf-8");

        HttpSession session = request.getSession();
        String yzcodeForSession = (String)session.getAttribute("randnum");
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);

        if (yzcode.equals(yzcodeForSession)) {
            if (checkcode.equals(paramVals)) {
                ApplicationContext appContext = SpringInit.getApplicationContext();
                if (appContext!=null) {
                    BulletinNoticeWithBLOBs bulletinNotice = null;
                    Users user = null;
                    PurchasingAgency purchasingAgency = null;
                    BidderInfo bidderInfo = null;

                    //获取下载招标文件的公告信息，得到公告文件的文件名称
                    INoticeService noticeService = (INoticeService)appContext.getBean("noticeService");
                    bulletinNotice = noticeService.getBulletinNoticeByUUID(bulletinNotice_uuid);

                    //获取登录用户的信息
                    IUserService usersService = (IUserService)appContext.getBean("usersService");
                    user = usersService.getUserinfoByUserid(authToken.getUserid());

                    //获取用户所在单位的法人信息
                    purchasingAgency = usersService.getEnterpriseInfoByCompcode(user.getCOMPANYCODE());

                    //将下载招标文件的用户所在单位保存为潜在投标人
                    IBidderInfoService bidderInfoService = (IBidderInfoService)appContext.getBean("bidderInfoService");
                    bidderInfo = bidderInfoService.getBidderInfoByProjcodeAndCompcode(bulletinNotice.getPurchaseprojcode(),user.getCOMPANYCODE());
                    int retcode = 0;
                    //供应商已经注册并且对于该项目并非是潜在投标人，将该供应商的信息保存到潜在投标人信息表
                    if (purchasingAgency!=null) {
                        if (bidderInfo == null) {
                            String uuid = UUID.randomUUID().toString();
                            uuid = uuid.replace("-", "");
                            bidderInfo = new BidderInfo();
                            bidderInfo.setUuid(uuid);                                                        //潜在报名信息的uuid
                            bidderInfo.setPurchaseprojcode(bulletinNotice.getPurchaseprojcode());            //拟投项目编码
                            bidderInfo.setLegalname(lawPersonName);                                          //潜在投标人法人代表名称
                            bidderInfo.setBiddername(purchasingAgency.getOrganName());                       //潜在投标人名称
                            bidderInfo.setBiddercode(purchasingAgency.getLegalCode());                       //潜在投标人统一社会信用代码
                            bidderInfo.setBidderAddress(purchasingAgency.getAddress());                      //潜在投标人所在地址
                            bidderInfo.setContactor(contactorname);                                          //潜在投标人联系人
                            bidderInfo.setPhone(contactorphone);                                             //潜在投标人联系电话
                            bidderInfo.setMphone(contactormphone);                                           //潜在投标人联系手机
                            bidderInfo.setIdNo(idcard);                                                      //潜在投标人联系人身份证号码
                            bidderInfo.setIdcard(idcardpic_frontfile);                                       //潜在投标人联系人身份证正面图片
                            bidderInfo.setIdcardback(idcardpic_backfile);                                    //潜在投标人联系人身份证反面图片
                            bidderInfo.setBusinesslicense(licensepic);                                       //潜在投标人营业执照图片
                            bidderInfo.setClientattorney(authletterpic);                                     //授权委托书图片
                            bidderInfo.setOtherpic(otherpic);                                                //上传的其他文件
                            bidderInfo.setDateofapp(new Timestamp(System.currentTimeMillis()));              //潜在投标人报名时间
                            bidderInfo.setConfirmFlag("c4100c10ce7a44a14892684257a124ff");               //潜在投标人未投标
                            bidderInfo.setCreateTime(new Timestamp(System.currentTimeMillis()));             //下载招标文件时间
                            bidderInfo.setCreator(user.getUSERID());                                         //下载招标文件用户
                            bidderInfo.setUpdateTime(new Timestamp(System.currentTimeMillis()));             //潜在报名信息修改时间
                            bidderInfo.setModifier(user.getUSERID());

                            //FTP联系人身份证正面图片、背面图片、营业执照图片、委托人授权书文件、其他上传文件到交易系统服务器
                            FtpFileToDest ftpFileToDest = new FtpFileToDest();
                            InitServer initServer = InitServer.getInstance();
                            String localRootPath = initServer.getProperties().getProperty("main.uploaddir");
                            String localFileName = null;
                            if (localRootPath.endsWith(File.separator))
                                localFileName = localRootPath + licensepic;
                            else
                                localFileName = localRootPath + File.separator + licensepic;
                            int retval_for_licensepic = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, purchasingAgency.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);

                            if (localRootPath.endsWith(File.separator))
                                localFileName = localRootPath + authletterpic;
                            else
                                localFileName = localRootPath + File.separator + authletterpic;
                            int retval_for_authletterpic = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, purchasingAgency.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);

                            if (localRootPath.endsWith(File.separator))
                                localFileName = localRootPath + idcardpic_frontfile;
                            else
                                localFileName = localRootPath + File.separator + idcardpic_frontfile;
                            int retval_for_idcardpic_frontfile = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, purchasingAgency.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);

                            if (idcardpic_backfile!=null && idcardpic_backfile!="") {
                                if (localRootPath.endsWith(File.separator))
                                    localFileName = localRootPath + idcardpic_backfile;
                                else
                                    localFileName = localRootPath + File.separator + idcardpic_backfile;
                                int retval_for_idcardpic_backfile = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, purchasingAgency.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);
                            }

                            if (otherpic != null && otherpic!="") {
                                if (localRootPath.endsWith(File.separator))
                                    localFileName = localRootPath + otherpic;
                                else
                                    localFileName = localRootPath + File.separator + otherpic;
                                int retval_for_otherpic = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, purchasingAgency.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);
                            }

                            if (retval_for_licensepic == 0 && retval_for_authletterpic == 0 && retval_for_idcardpic_frontfile == 0)
                                //潜在报名信息修改人
                                retcode = bidderInfoService.saveBidderInfo(bidderInfo,authToken.getUserid(),supplierCode);

                        } else {
                            return "redirect:/users/error.jsp?errcode=-201";   //供应商已经报名，不需要再次报名
                        }
                    } else {
                        return "redirect:/users/error.jsp?errcode=-202";       //供应商必须登录系统后才能进行报名操作
                    }
                } else {
                    return "redirect:/users/error.jsp?errcode=-203";           //系统环境出现错误
                }
            } else {
                return "redirect:/users/error.jsp?errcode=-204";              //前后台数据收入不相符，未通过数据验证
            }
        } else {
            return "redirect:/users/error.jsp?errcode=-205";                 //验证码收入错误
        }

        //return "redirect:/ec/download.jsp?uuid=" + bulletinNotice_uuid;

        return "redirect:" + MyConstants.getDownloadAddress() + "/oa/common/attachment/publicDownloadFile?id="+bulletinNotice_uuid;
    }

    @RequestMapping(value = "/getMyBidInfos.do")
    public @ResponseBody List<BidderInfo> getBidderInfosByUseridAndCompcode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<BidderInfo> bidderInfos = null;
        HttpSession session = request.getSession();
        String yzcodeForSession = (String)session.getAttribute("randnum");
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        String username = authToken.getUsername();
        ApplicationContext appContext = SpringInit.getApplicationContext();
        if (appContext!=null) {
            String compcode = ParamUtil.getParameter(request, "compcode");
            int pageno = ParamUtil.getIntParameter(request, "pageno", 0);
            int pagesize = ParamUtil.getIntParameter(request, "pagesize", 20);

            IBidderInfoService bidderInfoService = (IBidderInfoService)appContext.getBean("bidderInfoService");
            bidderInfos = bidderInfoService.getBidderInfosByUseridAndCompcode(username,compcode,BigDecimal.valueOf(pageno),BigDecimal.valueOf(pagesize));
        }

        return bidderInfos;
    }
}
