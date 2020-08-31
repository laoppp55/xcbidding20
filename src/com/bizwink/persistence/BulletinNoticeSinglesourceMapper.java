package com.bizwink.persistence;

import com.bizwink.po.BulletinNoticeSinglesource;
import com.bizwink.po.BulletinNoticeSinglesourceExample;
import com.bizwink.po.BulletinNoticeSinglesourceWithBLOBs;

import java.util.List;

public interface BulletinNoticeSinglesourceMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int countByExample(BulletinNoticeSinglesourceExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int insert(BulletinNoticeSinglesourceWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int insertSelective(BulletinNoticeSinglesourceWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    BulletinNoticeSinglesourceWithBLOBs selectByPrimaryKey(String uuid);

    List<BulletinNoticeSinglesourceWithBLOBs> getSinglesourceNoticesByProjectCode(String projectCode);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(BulletinNoticeSinglesourceWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(BulletinNoticeSinglesourceWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table bulletin_notice_singlesource
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(BulletinNoticeSinglesource record);
}