package com.bizwink.persistence;

import com.bizwink.po.PlaceReserveInformationforSections;
import com.bizwink.po.PlaceReserveInformationforSectionsExample;

public interface PlaceReserveInformationforSectionsMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    int countByExample(PlaceReserveInformationforSectionsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    int insert(PlaceReserveInformationforSections record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    int insertSelective(PlaceReserveInformationforSections record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    PlaceReserveInformationforSections selectByPrimaryKey(String uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(PlaceReserveInformationforSections record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table place_reserve_information_for_sections
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(PlaceReserveInformationforSections record);
}