package com.bizwink.BidInfo;

import com.bizwink.cms.entity.DayCompare;
import com.bizwink.cms.server.InitServer;
import com.bizwink.cms.server.MyConstants;
import com.bizwink.net.sftp.FtpFileToDest;
import com.bizwink.po.NameValueCode;
import com.bizwink.po.PurchasingAgency;
import com.bizwink.po.Users;
import com.bizwink.security.Auth;
import com.bizwink.service.IAttechemntsService;
import com.bizwink.service.ICodeService;
import com.bizwink.service.IUserService;
import com.bizwink.service.impl.CodeService;
import com.bizwink.service.impl.UsersService;
import com.bizwink.util.*;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

@Controller
public class BidInfoController {
    private static Logger logger = Logger.getLogger(BidInfoController.class);

    @RequestMapping(value="/hello.do")
    public String hello(Model model) throws Exception{
        System.out.println("HelloAction::hello()");
        model.addAttribute("message","你好");
        return "/_prog/search";
    }

    @RequestMapping(value="/init.do")
    public void initServer(HttpServletRequest request, HttpServletResponse response) throws Exception{
        InitServer initServer = InitServer.getInstance();
    }

    @RequestMapping(value="/getUserInfo.do")
    public @ResponseBody Users getUserInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        ApplicationContext appContext = SpringInit.getApplicationContext();
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        String userid = filter.excludeHTMLCode(URLDecoder.decode(ParamUtil.getParameter(request,"username"),"utf-8"));                          //用户名
        return  usersService.getUserinfoByUserid(userid);
    }

    @RequestMapping(value="/userreg.do")
    public String saveUserInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ApplicationContext appContext = SpringInit.getApplicationContext();
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        int errcode = 0;
        int siteid = MyConstants.getSiteid();
        String userid = filter.excludeHTMLCode(ParamUtil.getParameter(request,"username"));                          //用户名
        String pwd = filter.excludeHTMLCode(ParamUtil.getParameter(request, "pwdname"));                              //密码
        String suppliername = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppliername"));               //企业名称
        String supplierCode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "supplierCode"));               //企业统一社会信用代码
        String lawPersonName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "lawPersonName"));             //法人名称
        String lawPersonTel = filter.excludeHTMLCode(ParamUtil.getParameter(request, "lawPersonTel"));               //法人联系电话
        String lawPersonIdcard = filter.excludeHTMLCode(ParamUtil.getParameter(request, "Idcard"));                   //法人身份证号
        String supplierType = filter.excludeHTMLCode(ParamUtil.getParameter(request, "supplierType"));               //企业类别
        String suppOrgType = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppOrgType"));                 //企业组织类型
        String comprole = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppRole"));                       //企业角色，可以是供应商、代理机构、采购人、其他等
        String regDate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regDate"));                         //企业成立日期
        int longtimeflag = ParamUtil.getIntParameter(request, "longtimeflag",0);                        //企业经营期限是否为无限期
        String sdate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "sdate"));                              //企业经营开始时间
        String edate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "edate"));                              //企业经营结束时间
        String regaddress = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regaddress"));                   //注册地址
        String regCapital = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regCapital"));                   //注册资本
        String bankname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "bankname"));                       //基本户开户行
        String BaseAccountName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "BaseAccountName"));        //基本户名称
        String baseAccount = filter.excludeHTMLCode(ParamUtil.getParameter(request, "baseAccount"));                 //银行账号
        String weburl = filter.excludeHTMLCode(ParamUtil.getParameter(request, "weburl"));                            //企业网址
        String businessBrief = filter.excludeHTMLCode(ParamUtil.getParameter(request, "businessBrief"));             //经营范围
        String regAuthName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regAuthName"));                 //登记机关
        String checkInDate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "checkInDate"));                 //登记时间
        String provname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "provname"));                       //所在省份
        String cityname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "cityname"));                       //所在城市
        String areaname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "areaname"));                       //所在地区
        String zipcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "zipcode"));                         //邮政编码
        String operationAddress = filter.excludeHTMLCode(ParamUtil.getParameter(request, "operationAddress"));      //经营地址
        String contactorname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactorname"));            //联系人姓名
        String contactormphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactormphone"));        //联系人手机
        String contactorphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactorphone"));          //联系人电话
        String email = filter.excludeHTMLCode(ParamUtil.getParameter(request, "email"));                             //联系人电子邮件
        String faxnum = filter.excludeHTMLCode(ParamUtil.getParameter(request, "faxnum"));                           //联系人传真
        String licensepic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "licensepic"));                   //营业执照图片名称
        String promisepic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "promisepic"));                   //风险承诺书图片名称
        //boolean agreeflag = ParamUtil.getCheckboxParameter(request,"agreement");
        String yzcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "yzcode"));

        HttpSession session = request.getSession();
        String yzcodeForSession = (String)session.getAttribute("randnum");
        String checkcode = ParamUtil.getParameter(request, "checkval");
        String paramVals = MD5Util.MD5Encode("username=" + userid + "&pwdname=" + pwd + "&suppliername=" + suppliername  +
                "&supplierCode=" + supplierCode + "&lawPersonName=" + lawPersonName + "&lawPersonTel=" + ((lawPersonTel==null)?"":lawPersonTel) +
                "&supplierType=" + supplierType + "&suppOrgType=" + suppOrgType + "&comprole=" + comprole + "&regDate=" + regDate + "&longtimeflag=" + longtimeflag +
                "&sdate=" + sdate + "&edate=" + ((edate==null)?"":edate) + "&regaddress=" + ((regaddress==null)?"":regaddress) + "&regCapital=" + regCapital +
                "&bankname=" + ((bankname==null)?"":bankname) + "&BaseAccountName=" + ((BaseAccountName==null)?"":BaseAccountName) + "&baseAccount=" + ((baseAccount==null)?"":baseAccount) +
                "&weburl=" + ((weburl==null)?"":weburl) + "&businessBrief=" + ((businessBrief==null)?"":businessBrief) + "&regAuthName=" + regAuthName +
                "&checkInDate=" + checkInDate + "&provname=" + provname + "&cityname=" + cityname + "&areaname=" + areaname + "&zipcode=" + ((zipcode==null)?"":zipcode) +
                "&operationAddress=" + ((operationAddress==null)?"":operationAddress) + "&contactorname=" + ((contactorname==null)?"":contactorname) +
                "&contactormphone=" + ((contactormphone==null)?"":contactormphone) + "&contactorphone=" + ((contactorphone==null)?"":contactorphone) +
                "&email=" + ((email==null)?"":email) + "&faxnum=" + ((faxnum==null)?"":faxnum) + "&yzcode=" + yzcode + "&Idcard=" + ((lawPersonIdcard==null)?"":lawPersonIdcard) +
                "&bankname=" + bankname + "&BaseAccountName=" + BaseAccountName + "&baseAccount=" + baseAccount + "&businessBrief=" + businessBrief + "&operationAddress=" + operationAddress,"utf-8");

        checkcode = MD5Util.MD5Encode(checkcode,"utf-8");

        if (pwd!=null && yzcode!=null && yzcodeForSession!=null) {
            if (checkcode.equals(paramVals)) {
                if (yzcode.equals(yzcodeForSession)) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    PurchasingAgency suppinfo = new PurchasingAgency();
                    String uuid = UUID.randomUUID().toString();
                    uuid = uuid.replace("-", "");
                    suppinfo.setUuid(uuid);
                    suppinfo.setOrganName(suppliername);
                    suppinfo.setLegalCode(supplierCode);
                    suppinfo.setPersonName(lawPersonName);
                    suppinfo.setPersonTel(lawPersonTel);
                    suppinfo.setPersonType(supplierType);                                                       //企业法人类型
                    suppinfo.setPersonIdcard(lawPersonIdcard);
                    suppinfo.setPersonOorganType(suppOrgType);                                                  //企业组织机构类型
                    suppinfo.setPersonRole(comprole);                                                           //设置企业角色，可以使供应商、代理机构、采购人和其他
                    suppinfo.setCreateDate(sdf.parse(regDate));                                                 //公司成立日期
                    if (longtimeflag == 2)
                        suppinfo.setOperatingpeoid(String.valueOf(99));                                         //无限期营业
                    else {
                        DayCompare dayCompare = DateUtil.dayCompare(sdf.parse(sdate),sdf.parse(edate));
                        suppinfo.setOperatingpeoid(String.valueOf(dayCompare.getYear()));
                        System.out.println(String.valueOf(dayCompare.getYear()));
                    }
                    suppinfo.setRegistrationTime(sdf.parse(sdate));                                             //营业开始时间
                    if(edate!=null) suppinfo.setExpiryDate(sdf.parse(edate));                                  //营业结束时间
                    suppinfo.setAddress(regaddress);                                                            //注册地址
                    suppinfo.setRegisteredCapital(regCapital);                                                  //注册资本
                    suppinfo.setBank(bankname);                                                                 //开户银行
                    suppinfo.setBankAccount(baseAccount);                                                       //基本户账号
                    suppinfo.setBankAccountName(BaseAccountName);                                               //基本户名称
                    suppinfo.setWeburl(weburl);                                                                 //企业网址
                    suppinfo.setBusinesScope(businessBrief);                                                    //企业经营范围
                    suppinfo.setBusinessDirection("政府采购");
                    suppinfo.setRegistrationAuthority(regAuthName);                                             //企业登记机关
                    suppinfo.setRegistrationDate(sdf.parse(checkInDate));                                       //登记日期
                    suppinfo.setProvince(provname);                                                             //企业所在省份
                    suppinfo.setCity(cityname);                                                                 //企业所在城市
                    suppinfo.setRegionCode(areaname);                                                           //企业所在行政区域
                    suppinfo.setPostalCode(zipcode);                                                            //企业所在区域邮政编码
                    suppinfo.setBusinessAddress(operationAddress);                                              //企业经营地址
                    suppinfo.setContacts(contactorname);                                                        //企业联系人
                    suppinfo.setContactunitLandline(contactorphone);                                            //企业联系人座机
                    suppinfo.setContactNumber(contactormphone);                                                 //企业联系人手机号码
                    suppinfo.setLegalemail(email);                                                              //企业联系人电子邮件
                    suppinfo.setFax(faxnum);                                                                    //企业联系人传真
                    suppinfo.setBusinessAttachmentIds(licensepic);                                              //企业营业执照图片
                    suppinfo.setCertificateAttachmentIds(promisepic);                                           //企业风险承诺书图片
                    suppinfo.setAuditstatus("核验中");                                                          //修改信息后，供应商的状态变成审核中，审核中不能执行业务操作
                    suppinfo.setCreateTime(new Timestamp(System.currentTimeMillis()));                          //用户注册时间

                    Users user = new Users();
                    user.setTEXTPWD(pwd);
                    String password = Encrypt.md5(pwd.getBytes());
                    user.setUSERID(userid);                                                                      //用户ID
                    user.setNICKNAME(userid);
                    user.setUSERPWD(password);                                                                   //口令
                    user.setSITEID(BigDecimal.valueOf(siteid));                                                  //站点ID
                    user.setEMAIL(email);                                                                        //电子邮件
                    user.setPHONE(contactorphone);
                    user.setMPHONE(contactormphone);
                    user.setCOMPANY(suppliername);                                                                //工作单位名称
                    user.setCOMPANYCODE(supplierCode);                                                           //用户所在企业统一社会信用编码
                    user.setCREATEDATE(new Timestamp(System.currentTimeMillis()));                               //用户创建时间
                    user.setLASTUPDATE(new Timestamp(System.currentTimeMillis()));
                    user.setORGID(BigDecimal.valueOf(0));                                                        //用户所属企业组织架构ID
                    user.setCOMPANYID(BigDecimal.valueOf(0));                                                    //用户所属公司ID
                    user.setDEPTID(BigDecimal.valueOf(0));                                                       //用户所属部门ID
                    user.setDFLAG(BigDecimal.valueOf(0));
                    user.setDEPARTMENT("0");                                                                     //用户所属部门编码
                    user.setUSERTYPE(BigDecimal.valueOf(6));                                                     //注册用户类型，第一个注册的用户类型为6，表示是该公司的系统管理员，以后该公司的新账户由该管理员创建，用户类型为5
                    //boolean userExistFlag = usersService.checkName(BigDecimal.valueOf(siteid), userid);
                    boolean emailExistFlag = usersService.checkEmail(BigDecimal.valueOf(siteid), email);
                    boolean userExistFlag = usersService.checkName(BigDecimal.valueOf(siteid), userid);

                    if (!userExistFlag && !emailExistFlag && email != null && userid != null) {
                        FtpFileToDest ftpFileToDest = new FtpFileToDest();
                        InitServer initServer = InitServer.getInstance();
                        String localFileName = initServer.getProperties().getProperty("main.uploaddir");
                        if (localFileName.endsWith(File.separator))
                            localFileName = localFileName + licensepic;
                        else
                            localFileName = localFileName + File.separator + licensepic;
                        int retval_for_licensepic = ftpFileToDest.transfer(MyConstants.getSftpAddress(),MyConstants.getSftpUser(),MyConstants.getSftpPasswd(),localFileName,suppinfo.getLegalCode(),MyConstants.getSftpRootpath() + "/upload/30/supp",0);
                        localFileName = InitServer.getProperties().getProperty("main.uploaddir");
                        if (localFileName.endsWith(File.separator))
                            localFileName = localFileName + promisepic;
                        else
                            localFileName = localFileName + File.separator + promisepic;
                        int retval_for_promisepic = ftpFileToDest.transfer(MyConstants.getSftpAddress(),MyConstants.getSftpUser(),MyConstants.getSftpPasswd(),localFileName,suppinfo.getLegalCode(),MyConstants.getSftpRootpath() + "/upload/30/supp",0);


                        if (retval_for_licensepic==0 && retval_for_promisepic==0)                     //表示文件上传交易系统服务器成功
                            errcode = usersService.createUserAndEnterpriseInfo(user,suppinfo);
                        else                                                                          //表示文件上传交易系统服务器失败
                            errcode = -105;
                    } else {
                        errcode = -101;
                    }
                } else {
                    errcode = -102;
                }
            } else {
                errcode = -103;
            }
        } else {
            errcode = -104;
        }

        if (errcode >= 0)
            return "redirect:/users/login.jsp?errcode=" + errcode;
        else
            return "redirect:/users/error.jsp?errcode=" + errcode;
    }

    @RequestMapping(value="/updateCompanyinfo.do")
    public String updateCompanyinfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ApplicationContext appContext = SpringInit.getApplicationContext();
        IUserService usersService = (IUserService)appContext.getBean("usersService");
        IAttechemntsService attechemntsService = (IAttechemntsService)appContext.getBean("attechemntsService");

        String userid = ParamUtil.getParameter(request, "userid");               //企业名称
        String uuid = ParamUtil.getParameter(request, "uuid");               //企业名称
        String suppliername = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppliername"));               //企业名称
        String supplierCode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "supplierCode"));               //企业统一社会信用代码
        String lawPersonName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "lawPersonName"));             //法人名称
        String lawPersonTel = filter.excludeHTMLCode(ParamUtil.getParameter(request, "lawPersonTel"));               //法人联系电话
        String lawPersonIdcard = filter.excludeHTMLCode(ParamUtil.getParameter(request, "Idcard"));                   //法人身份证号
        String supplierType = filter.excludeHTMLCode(ParamUtil.getParameter(request, "supplierType"));               //企业类别
        String suppOrgType = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppOrgType"));                 //企业组织类型
        String comprole = filter.excludeHTMLCode(ParamUtil.getParameter(request, "suppRole"));                       //企业角色，可以是供应商、代理机构、采购人、其他等
        String regDate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regDate"));                         //企业成立日期
        int longtimeflag = ParamUtil.getIntParameter(request, "longtimeflag",0);                        //企业经营期限是否为无限期
        String sdate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "sdate"));                              //企业经营开始时间
        String edate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "edate"));                              //企业经营结束时间
        String regaddress = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regaddress"));                   //注册地址
        String regCapital = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regCapital"));                   //注册资本
        String bankname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "bankname"));                       //基本户开户行
        String BaseAccountName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "BaseAccountName"));        //基本户名称
        String baseAccount = filter.excludeHTMLCode(ParamUtil.getParameter(request, "baseAccount"));                 //银行账号
        String weburl = filter.excludeHTMLCode(ParamUtil.getParameter(request, "weburl"));                            //企业网址
        String businessBrief = filter.excludeHTMLCode(ParamUtil.getParameter(request, "businessBrief"));             //经营范围
        String regAuthName = filter.excludeHTMLCode(ParamUtil.getParameter(request, "regAuthName"));                 //登记机关
        String checkInDate = filter.excludeHTMLCode(ParamUtil.getParameter(request, "checkInDate"));                 //登记时间
        String provname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "provname"));                       //所在省份
        String cityname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "cityname"));                       //所在城市
        String areaname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "areaname"));                       //所在地区
        String zipcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "zipcode"));                         //邮政编码
        String operationAddress = filter.excludeHTMLCode(ParamUtil.getParameter(request, "operationAddress"));      //经营地址
        String contactorname = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactorname"));            //联系人姓名
        String contactormphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactormphone"));        //联系人手机
        String contactorphone = filter.excludeHTMLCode(ParamUtil.getParameter(request, "contactorphone"));          //联系人电话
        String email = filter.excludeHTMLCode(ParamUtil.getParameter(request, "email"));                             //联系人电子邮件
        String faxnum = filter.excludeHTMLCode(ParamUtil.getParameter(request, "faxnum"));                           //联系人传真
        String licensepic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "licensepic"));                   //营业执照图片名称
        String promisepic = filter.excludeHTMLCode(ParamUtil.getParameter(request, "promisefile"));                   //风险承诺书图片名称
        //boolean agreeflag = ParamUtil.getCheckboxParameter(request,"agreement");
        String yzcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "yzcode"));

        HttpSession session = request.getSession();
        String yzcodeForSession = (String)session.getAttribute("randnum");
        String checkcode = ParamUtil.getParameter(request, "checkval");
        String paramVals = MD5Util.MD5Encode("uuid=" + uuid + "&suppliername=" + suppliername  +
                "&supplierCode=" + supplierCode + "&lawPersonName=" + lawPersonName + "&lawPersonTel=" + ((lawPersonTel==null)?"":lawPersonTel) +
                "&supplierType=" + supplierType + "&suppOrgType=" + suppOrgType + "&comprole=" + comprole + "&regDate=" + regDate + "&longtimeflag=" + longtimeflag +
                "&sdate=" + sdate + "&edate=" + ((edate==null)?"":edate) + "&regaddress=" + ((regaddress==null)?"":regaddress) + "&regCapital=" + regCapital +
                "&bankname=" + ((bankname==null)?"":bankname) + "&BaseAccountName=" + ((BaseAccountName==null)?"":BaseAccountName) + "&baseAccount=" + ((baseAccount==null)?"":baseAccount) +
                "&weburl=" + ((weburl==null)?"":weburl) + "&businessBrief=" + ((businessBrief==null)?"":businessBrief) + "&regAuthName=" + regAuthName +
                "&checkInDate=" + checkInDate + "&provname=" + provname + "&cityname=" + cityname + "&areaname=" + areaname + "&zipcode=" + ((zipcode==null)?"":zipcode) +
                "&operationAddress=" + ((operationAddress==null)?"":operationAddress) + "&contactorname=" + ((contactorname==null)?"":contactorname) +
                "&contactormphone=" + ((contactormphone==null)?"":contactormphone) + "&contactorphone=" + ((contactorphone==null)?"":contactorphone) +
                "&email=" + ((email==null)?"":email) + "&faxnum=" + ((faxnum==null)?"":faxnum) + "&yzcode=" + yzcode + "&Idcard=" + ((lawPersonIdcard==null)?"":lawPersonIdcard) +
                "&bankname=" + bankname + "&BaseAccountName=" + BaseAccountName + "&baseAccount=" + baseAccount + "&businessBrief=" + businessBrief + "&operationAddress=" + operationAddress,"utf-8");

        //logger.info("update:" + checkcode + "=" + paramVals);
        //System.out.println(checkcode +"==" + paramVals);

        checkcode = MD5Util.MD5Encode(checkcode,"utf-8");

        int errcode = 0;
        if (yzcode!=null && yzcodeForSession!=null) {
            if (checkcode.equals(paramVals)) {
                if (yzcode.equals(yzcodeForSession)) {
                    //获取数据库中存储的附件名称，比较从前台页面传过来的附件文件名与数据库中的文件名是否相同
                    PurchasingAgency suppinfoInDB = usersService.getEnterpriseInfoByCompcode(supplierCode);
                    String licensepicIDInDB = suppinfoInDB.getBusinessAttachmentIds();
                    String promisepicIDInDB = suppinfoInDB.getCertificateAttachmentIds();
                    String licensepicFilenameInDB = attechemntsService.getAttechmentFilenameByUUID(licensepicIDInDB).getFilename();
                    String promisepicFilenameInDB = attechemntsService.getAttechmentFilenameByUUID(promisepicIDInDB).getFilename();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    PurchasingAgency suppinfo = new PurchasingAgency();
                    suppinfo.setUuid(uuid);
                    suppinfo.setOrganName(suppliername);
                    suppinfo.setLegalCode(supplierCode);
                    suppinfo.setPersonName(lawPersonName);
                    suppinfo.setPersonTel(lawPersonTel);
                    suppinfo.setPersonType(supplierType);                                                       //企业法人类型
                    suppinfo.setPersonIdcard(lawPersonIdcard);
                    suppinfo.setPersonOorganType(suppOrgType);                                                  //企业组织机构类型
                    suppinfo.setPersonRole(comprole);                                                           //设置企业角色，可以使供应商、代理机构、采购人和其他
                    suppinfo.setCreateDate(sdf.parse(regDate));                                                 //公司成立日期
                    if (longtimeflag == 2) suppinfo.setOperatingpeoid(String.valueOf(99));                      //无限期营业
                    suppinfo.setRegistrationTime(sdf.parse(sdate));                                             //营业开始时间
                    if (edate != null)
                        suppinfo.setExpiryDate(sdf.parse(edate));                                  //营业结束时间
                    suppinfo.setAddress(regaddress);                                                            //注册地址
                    suppinfo.setRegisteredCapital(regCapital);                                                  //注册资本
                    suppinfo.setBank(bankname);                                                                 //开户银行
                    suppinfo.setBankAccount(baseAccount);                                                       //基本户账号
                    suppinfo.setBankAccountName(BaseAccountName);                                               //基本户名称
                    suppinfo.setWeburl(weburl);                                                                 //企业网址
                    suppinfo.setBusinesScope(businessBrief);                                                    //企业经营范围
                    suppinfo.setBusinessDirection("政府采购");
                    suppinfo.setRegistrationAuthority(regAuthName);                                             //企业登记机关
                    suppinfo.setRegistrationDate(sdf.parse(checkInDate));                                       //登记日期
                    suppinfo.setProvince(provname);                                                             //企业所在省份
                    suppinfo.setCity(cityname);                                                                 //企业所在城市
                    suppinfo.setRegionCode(areaname);                                                           //企业所在行政区域
                    suppinfo.setPostalCode(zipcode);                                                            //企业所在区域邮政编码
                    suppinfo.setBusinessAddress(operationAddress);                                              //企业经营地址
                    suppinfo.setContacts(contactorname);                                                        //企业联系人
                    suppinfo.setContactNumber(contactormphone);                                                  //企业联系人手机号码
                    suppinfo.setContactunitLandline(contactorphone);                                            //企业联系人办公电话
                    suppinfo.setLegalemail(email);                                                              //企业联系人电子邮件
                    suppinfo.setFax(faxnum);                                                                    //企业联系人传真
                    suppinfo.setBusinessAttachmentIds(licensepic);                                              //企业营业执照图片
                    suppinfo.setCertificateAttachmentIds(promisepic);                                           //企业风险承诺书图片
                    suppinfo.setAuditstatus("核验中");                                                          //修改信息后，供应商的状态变成审核中，审核中不能执行业务操作

                    //修改公司基本信息
                    FtpFileToDest ftpFileToDest = new FtpFileToDest();
                    int retval_for_licensepic = -2;
                    if (!licensepicFilenameInDB.equals(licensepic)) {
                        String localFileName = InitServer.getProperties().getProperty("main.uploaddir");
                        if (localFileName.endsWith(File.separator))
                            localFileName = localFileName + licensepic;
                        else
                            localFileName = localFileName + File.separator + licensepic;
                        retval_for_licensepic = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, suppinfo.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);
                    }

                    int retval_for_promisepic = -2;
                    if (!promisepicFilenameInDB.equals(promisepic)) {
                        String localFileName = InitServer.getProperties().getProperty("main.uploaddir");
                        if (localFileName.endsWith(File.separator))
                            localFileName = localFileName + promisepic;
                        else
                            localFileName = localFileName + File.separator + promisepic;
                        retval_for_promisepic = ftpFileToDest.transfer(MyConstants.getSftpAddress(), MyConstants.getSftpUser(), MyConstants.getSftpPasswd(), localFileName, suppinfo.getLegalCode(), MyConstants.getSftpRootpath() + "/upload/30/supp", 0);
                    }

                    if ((retval_for_licensepic==0 && retval_for_promisepic==0) || (retval_for_licensepic==0 && retval_for_promisepic==-2)
                            || (retval_for_licensepic==-2 && retval_for_promisepic==0) || (retval_for_licensepic==-2 && retval_for_promisepic==-2))                     //表示文件上传交易系统服务器成功
                        errcode = usersService.updateEnterpriseInfo(suppinfo,userid);
                    else                                                                          //表示文件上传交易系统服务器失败
                        errcode = -105;
                } else {
                    errcode = -102;     //输入验证码错误
                }
            } else {
                errcode = -103;          //检验后台获取的数据和前台传入的数据不一致
            }
        } else {
            errcode = -104;              //口令、验证码或者前后台数据校验值为空
        }

        return "redirect:/users/companyinfo.jsp?errcode=" + errcode;
    }

    @RequestMapping(value = "/login.do")
    public String login(HttpServletRequest request, HttpServletResponse response) {
        boolean doLogin = ParamUtil.getBooleanParameter(request,"doLogin");
        String refer_url = ParamUtil.getParameter(request,"refer");
        String userid = filter.excludeHTMLCode(ParamUtil.getParameter(request,"username"));
        String passwd = filter.excludeHTMLCode(ParamUtil.getParameter(request,"pwd"));
        String yzcode = filter.excludeHTMLCode(ParamUtil.getParameter(request, "yzcode"));
        HttpSession session = request.getSession();
        String yzcodeForSession = (String)session.getAttribute("randnum");
        String password = null;

        if (refer_url == null) refer_url = "/ggzyjy/index.shtml";

        if (yzcode.equals(yzcodeForSession) && doLogin) {
            ApplicationContext appContext = SpringInit.getApplicationContext();
            IUserService usersService = (IUserService)appContext.getBean("usersService");

            Users us= usersService.getUserinfoByUserid(userid);
            if (us==null) {
                us= usersService.getUserinfoByEmail(userid);                   //用户输入邮件地址进行登录
                if (us == null) {
                    us= usersService.getUserinfoByMphone(userid);             //用户输入手机地址进行登录
                }
            }

            if (us == null) {
                return "redirect:/users/login.jsp?errcode=-101";
            } else {
                if (us.getDFLAG().intValue()==0) {
                    try {
                        password = Encrypt.md5(passwd.getBytes());
                    } catch (Exception e) {
                        return "redirect:/users/login.jsp?errcode=-102";
                    }
                    if (password!=null) {
                        //用户口令错
                        if (!password.equalsIgnoreCase(us.getUSERPWD())) {
                            return "redirect:/users/login.jsp?errcode=-103";
                        } else {
                            Auth auth = new Auth();
                            auth.setUid(us.getID().intValue());
                            auth.setSiteid(us.getSITEID().intValue());
                            auth.setUserid(us.getUSERID());
                            auth.setUsername(us.getNICKNAME());
                            auth.setUsertype(us.getUSERTYPE().intValue());
                            session.setMaxInactiveInterval(60*60*1000);
                            session.setAttribute("AuthInfo", auth);
                            //return "redirect:" +  refer_url;
                            return "redirect:ggzyjy/index.shtml";
                        }
                    } else {
                        return "redirect:/users/login.jsp?errcode=-106";
                    }
                } else {
                    return "redirect:/users/login.jsp?errcode=-104";
                }
            }
        } else {
            return "redirect:/users/login.jsp?errcode=-105";
        }
    }

    @RequestMapping(value="/updatePersonReg.do")
    public String updatePersonReg(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String idcard = ParamUtil.getParameter(request,"idcard");                                          //身份证号
        String mphone = ParamUtil.getParameter(request, "mphone");                                         //手机号
        String phone = ParamUtil.getParameter(request, "phone");                                           //联系手机电话
        String email = ParamUtil.getParameter(request, "email");                                           //联系座机电话
        String unit = ParamUtil.getParameter(request, "unit");                                             //单位名称
        String title = ParamUtil.getParameter(request, "title");                                           //职务
        String sex = ParamUtil.getParameter(request, "sex");                                               //性别
        String idcardpic_frontfile = ParamUtil.getParameter(request, "idcardpic_frontfile");             //身份证正面文件
        String idcardpic_backfile = ParamUtil.getParameter(request, "idcardpic_backfile");               //身份证背面文件
        String nation = ParamUtil.getParameter(request, "native");                                        //籍贯
        String yzcode = ParamUtil.getParameter(request, "yzcode");                                        //企业组织类型
        boolean doupdate = ParamUtil.getBooleanParameter(request,"doUpdate");

        BigDecimal sex_val = BigDecimal.valueOf(-1);
        if (idcard!=null)
            idcard = filter.excludeHTMLCode(idcard);
        else
            idcard = "";
        if (mphone!=null)
            mphone = filter.excludeHTMLCode(mphone);
        else
            mphone = "";
        if (phone!=null)
            phone = filter.excludeHTMLCode(phone);
        else
            phone = "";
        if (email!=null)
            email = filter.excludeHTMLCode(email);
        else
            email = "";
        if (unit!=null)
            unit = filter.excludeHTMLCode(unit);
        else
            unit = "";
        if (title!=null)
            title = filter.excludeHTMLCode(title);
        else
            title = "";
        if (sex!=null) {
            sex = filter.excludeHTMLCode(sex);
            sex_val = BigDecimal.valueOf(Integer.parseInt(sex));
        }else
            sex = "";
        if (idcardpic_frontfile!=null)
            idcardpic_frontfile = filter.excludeHTMLCode(idcardpic_frontfile);
        else
            idcardpic_frontfile = "";
        if (idcardpic_backfile!=null)
            idcardpic_backfile = filter.excludeHTMLCode(idcardpic_backfile);
        else
            idcardpic_backfile = "";
        if (nation!=null)
            nation = filter.excludeHTMLCode(nation);
        else
            nation = "";
        if (yzcode!=null)
            yzcode = filter.excludeHTMLCode(yzcode);
        else
            yzcode = "";

        String checkcode = ParamUtil.getParameter(request, "checkval");

        String messages = "idcard=" + idcard + "&mphone=" + mphone + "&phone=" + phone  + "&email=" + email + "&unit=" + unit + "&title=" + title +
                "&sex=" + sex + "&idcardpic_frontfile=" + idcardpic_frontfile + "&idcardpic_backfile=" + idcardpic_backfile + "&nation=" + nation +
                "&yzcode=" + yzcode;

        String paramVals = MD5Util.MD5Encode(messages,"utf-8");

        HttpSession session = request.getSession();
        String yzcodeForSession = (String)session.getAttribute("randnum");
        Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
        String userid = authToken.getUserid();

        if (yzcode.equals(yzcodeForSession) && doupdate) {
            if (checkcode.equals(paramVals)) {
                ApplicationContext appContext = SpringInit.getApplicationContext();
                IUserService usersService = (IUserService) appContext.getBean("usersService");

                Users user = new Users();
                user.setUSERID(userid);
                user.setIDCARD(idcard);
                user.setMPHONE(mphone);
                user.setPHONE(phone);
                user.setEMAIL(email);
                user.setCOMPANY(unit);
                user.setDUTY(title);
                user.setSEX(sex_val);
                user.setNATION(nation);
                user.setIDCARD_FRONT_PIC(idcardpic_frontfile);
                user.setIDCARD_BACK_PIC(idcardpic_backfile);
                usersService.updateUserinfoByUseridSelective(user);
            }
        }

        return "redirect:/users/updatereg.jsp";
    }

    @RequestMapping(value = "/getNameValeCode.do")
    public @ResponseBody List<NameValueCode> getNameValueCode(HttpServletRequest request, HttpServletResponse response) {
        int classcode = ParamUtil.getIntParameter(request,"classcode",0);
        ApplicationContext appContext = SpringInit.getApplicationContext();
        ICodeService codeService = (ICodeService)appContext.getBean("codeService");
        List<NameValueCode> nameValueCodes = codeService.getNameValueCodeByClassCode(BigDecimal.valueOf(classcode));
        return nameValueCodes;
    }
}
