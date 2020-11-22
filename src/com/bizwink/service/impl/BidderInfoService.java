package com.bizwink.service.impl;

import com.bizwink.cms.server.InitServer;
import com.bizwink.cms.server.MyConstants;
import com.bizwink.persistence.BaseAttachmentMapper;
import com.bizwink.persistence.BidderInfoMapper;
import com.bizwink.persistence.CertInfoMapper;
import com.bizwink.persistence.DownBiddocLogMapper;
import com.bizwink.po.BaseAttachment;
import com.bizwink.po.BidderInfo;
import com.bizwink.po.CertInfo;
import com.bizwink.po.DownBiddocLog;
import com.bizwink.service.IBidderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class BidderInfoService implements IBidderInfoService{
    @Autowired
    private BidderInfoMapper bidderInfoMapper;

    @Autowired
    private BaseAttachmentMapper baseAttachmentMapper;

    @Autowired
    private DownBiddocLogMapper downBiddocLogMapper;

    @Autowired
    private CertInfoMapper certInfoMapper;

    //保存潜在投标人信息，如果注册用户下载了标书，他就成为这个项目的潜在投标人
    @Transactional
    public int saveBidderInfo(BidderInfo bidderInfo,String username,String compcode,String bidFile_uuid){
        int errcode = 0;
        //保存联系人身份证正面图片
        String filename = bidderInfo.getIdcard();
        if (filename!=null) {
            String uuid = UUID.randomUUID().toString();
            uuid = uuid.replace("-", "");
            int posi = filename.lastIndexOf(".");
            String extname = null;
            if (posi > -1) extname = filename.substring(posi + 1);
            BaseAttachment baseAttachment = new BaseAttachment();
            baseAttachment.setUuid(uuid);
            baseAttachment.setFilename(filename);
            baseAttachment.setCategory("bidder_info");
            baseAttachment.setSuffix(extname);
            baseAttachment.setCreationTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setLastUpdateTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setCreatorId(username);
            baseAttachment.setRootPath(MyConstants.getSftpRootpath());
            String filepath = MyConstants.getSftpRelatePath() + compcode + File.separator + filename;
            baseAttachment.setFilepath(filepath);
            File thefile = new File(filepath);
            baseAttachment.setFileSize((double) thefile.length()/(1024*1024));
            errcode = baseAttachmentMapper.insert(baseAttachment);
            bidderInfo.setIdcard(uuid);
        }

        //保存联系人身份证背面图片
        filename = bidderInfo.getIdcardback();
        if (filename!=null && filename!="") {
            String uuid = UUID.randomUUID().toString();
            uuid = uuid.replace("-", "");
            int posi = filename.lastIndexOf(".");
            String extname = null;
            if (posi > -1) extname = filename.substring(posi + 1);
            BaseAttachment baseAttachment = new BaseAttachment();
            baseAttachment.setUuid(uuid);
            baseAttachment.setFilename(filename);
            baseAttachment.setCategory("bidder_info");
            baseAttachment.setSuffix(extname);
            baseAttachment.setCreationTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setLastUpdateTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setCreatorId(username);
            baseAttachment.setRootPath(MyConstants.getSftpRootpath());
            String filepath = MyConstants.getSftpRelatePath() + compcode + File.separator + filename;
            baseAttachment.setFilepath(filepath);
            File thefile = new File(filepath);
            baseAttachment.setFileSize((double) thefile.length()/(1024*1024));
            errcode = baseAttachmentMapper.insert(baseAttachment);
            bidderInfo.setIdcardback(uuid);
        }

        //保存企业营业执照信息
        filename = bidderInfo.getBusinesslicense();
        if (filename!=null && filename!="") {
            String uuid = UUID.randomUUID().toString();
            uuid = uuid.replace("-", "");
            int posi = filename.lastIndexOf(".");
            String extname = null;
            if (posi > -1) extname = filename.substring(posi + 1);
            BaseAttachment baseAttachment = new BaseAttachment();
            baseAttachment.setUuid(uuid);
            baseAttachment.setFilename(filename);
            baseAttachment.setCategory("bidder_info");
            baseAttachment.setSuffix(extname);
            baseAttachment.setCreationTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setLastUpdateTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setCreatorId(username);
            baseAttachment.setRootPath(MyConstants.getSftpRootpath());
            String filepath = MyConstants.getSftpRelatePath() + compcode + File.separator + filename;
            baseAttachment.setFilepath(filepath);
            File thefile = new File(filepath);
            baseAttachment.setFileSize((double) thefile.length()/(1024*1024));
            errcode = baseAttachmentMapper.insert(baseAttachment);
            bidderInfo.setBusinesslicense(uuid);
        }

        //保存委托授权书附件
        filename = bidderInfo.getClientattorney();
        if (filename!=null && filename!="") {
            String uuid = UUID.randomUUID().toString();
            uuid = uuid.replace("-", "");
            int posi = filename.lastIndexOf(".");
            String extname = null;
            if (posi > -1) extname = filename.substring(posi + 1);
            BaseAttachment baseAttachment = new BaseAttachment();
            baseAttachment.setUuid(uuid);
            baseAttachment.setFilename(filename);
            baseAttachment.setCategory("bidder_info");
            baseAttachment.setSuffix(extname);
            baseAttachment.setCreationTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setLastUpdateTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setCreatorId(username);
            baseAttachment.setRootPath(MyConstants.getSftpRootpath());
            String filepath = MyConstants.getSftpRelatePath() + compcode + File.separator + filename;
            baseAttachment.setFilepath(filepath);
            File thefile = new File(filepath);
            baseAttachment.setFileSize((double) thefile.length()/(1024*1024));
            errcode = baseAttachmentMapper.insert(baseAttachment);
            bidderInfo.setClientattorney(uuid);
        }

        //保存其他上传附件
        filename = bidderInfo.getOtherpic();
        if (filename!=null && filename!="") {
            String uuid = UUID.randomUUID().toString();
            uuid = uuid.replace("-", "");
            int posi = filename.lastIndexOf(".");
            String extname = null;
            if (posi > -1) extname = filename.substring(posi + 1);
            BaseAttachment baseAttachment = new BaseAttachment();
            baseAttachment.setUuid(uuid);
            baseAttachment.setFilename(filename);
            baseAttachment.setCategory("bidder_info");
            baseAttachment.setSuffix(extname);
            baseAttachment.setCreationTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setLastUpdateTime(new Timestamp(System.currentTimeMillis()));
            baseAttachment.setCreatorId(username);
            //String filepath = InitServer.getProperties().getProperty("main.uploaddir");
            baseAttachment.setRootPath(MyConstants.getSftpRootpath());
            String filepath = MyConstants.getSftpRelatePath() + compcode + File.separator + filename;
            baseAttachment.setFilepath(filepath);
            File thefile = new File(filepath);
            baseAttachment.setFileSize((double) thefile.length()/(1024*1024));
            errcode = baseAttachmentMapper.insert(baseAttachment);
            bidderInfo.setOtherpic(uuid);
        }

        //保存用户下载公告文件的日志信息
        DownBiddocLog downBiddocLog = new DownBiddocLog();
        downBiddocLog.setBidderid(username);
        downBiddocLog.setNoticeid(bidFile_uuid);
        downBiddocLog.setSupplierCode(compcode);
        downBiddocLog.setOpname("提交报名信息，自动下载招标文件");
        downBiddocLog.setDowntime(new Timestamp(System.currentTimeMillis()));
        downBiddocLogMapper.insert(downBiddocLog);

        //保存投标人联系人信息
        return  bidderInfoMapper.insert(bidderInfo);
    }

    public BidderInfo getBidderInfoByProjcodeAndCompcode(String projcode,String Compcode){
        Map params = new HashMap();
        params.put("projcode",projcode);
        params.put("compcode",Compcode);
        return bidderInfoMapper.getBidderInfoByProjcodeAndCompcode(params);
    }

    public List<BidderInfo> getBidderInfosByUseridAndCompcode(String creator, String compcode, BigDecimal startrow, BigDecimal pagesize) {
        Map params = new HashMap();
        params.put("creator",creator);
        params.put("compcode",compcode);
        params.put("startrow",startrow);
        params.put("pagesize",pagesize);
        return bidderInfoMapper.getBidderInfosByUseridAndCompcode(params);
    }

    public int saveDownBidFileLog(String userid, String compcode, CertInfo certInfo,String bidFile_uuid, String op) {
       //判断用户CA信息是否为空，如果不为空查询数据库TBL_certinfo表是否有该用户的CA信息，如果存在不做任何操作，如果不存在，则插入用户CA信息
       if (certInfo!=null) {
           Map params = new HashMap();
           params.put("userid",userid);
           params.put("certnum",certInfo.getCertnum());
           CertInfo tt = certInfoMapper.getCertInfoByUserIDAndCertNum(params);
           if (tt==null) certInfoMapper.insert(certInfo);
       }

        //保存用户下载公告文件的日志信息
        DownBiddocLog downBiddocLog = new DownBiddocLog();
        downBiddocLog.setBidderid(userid);
        downBiddocLog.setNoticeid(bidFile_uuid);
        downBiddocLog.setSupplierCode(compcode);
        downBiddocLog.setOpname(op);
        if (certInfo!=null) {
            downBiddocLog.setSn(certInfo.getSn());
            downBiddocLog.setCertnum(certInfo.getCertnum());
        }
        downBiddocLog.setDowntime(new Timestamp(System.currentTimeMillis()));
        return downBiddocLogMapper.insert(downBiddocLog);
    }
}
