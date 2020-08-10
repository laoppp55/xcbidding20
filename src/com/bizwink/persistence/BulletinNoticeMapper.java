package com.bizwink.persistence;

import com.bizwink.po.BulletinNotice;
import com.bizwink.po.BulletinNoticeExample;
import com.bizwink.po.BulletinNoticeWithBLOBs;
import com.bizwink.vo.voBulletinNotice;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public interface BulletinNoticeMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int countByExample(BulletinNoticeExample example);

    BigDecimal getBulletinNoticeCount(Timestamp now);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int insert(BulletinNoticeWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int insertSelective(BulletinNoticeWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    BulletinNoticeWithBLOBs selectByPrimaryKey(String uuid);

    BulletinNoticeWithBLOBs getBulletinNoticeBySectionCode(String sectionCode);

    List<BulletinNoticeWithBLOBs> getBulletinNoticeByProjectCode(String projectCode);

    List<voBulletinNotice> getBulletinNoticeList(Map params);

    List<voBulletinNotice> getTopBulletinNotice(Map params);

    List<voBulletinNotice> SearchBulletinNotice(Map params);

    BigDecimal SearchBulletinNoticeCount(Map params);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(BulletinNoticeWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(BulletinNoticeWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(BulletinNotice record);
}