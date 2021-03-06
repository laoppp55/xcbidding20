package com.bizwink.persistence;

import com.bizwink.po.SuppBiddingRecord;
import com.bizwink.po.SuppBiddingRecordExample;

public interface SuppBiddingRecordMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    int countByExample(SuppBiddingRecordExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    int insert(SuppBiddingRecord record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    int insertSelective(SuppBiddingRecord record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    SuppBiddingRecord selectByPrimaryKey(String uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(SuppBiddingRecord record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table supp_bidding_record
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(SuppBiddingRecord record);
}