package com.bizwink.persistence;

import com.bizwink.po.DownBiddocLog;
import com.bizwink.po.DownBiddocLogExample;

public interface DownBiddocLogMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    int countByExample(DownBiddocLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    int insert(DownBiddocLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    int insertSelective(DownBiddocLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    DownBiddocLog selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(DownBiddocLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_downbiddoc_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(DownBiddocLog record);
}