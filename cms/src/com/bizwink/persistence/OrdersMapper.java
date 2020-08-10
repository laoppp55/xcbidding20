package com.bizwink.persistence;

import com.bizwink.po.Orders;
import java.math.BigDecimal;

public interface OrdersMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_ORDERS
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(BigDecimal ORDERID);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_ORDERS
     *
     * @mbggenerated
     */
    int insert(Orders record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_ORDERS
     *
     * @mbggenerated
     */
    int insertSelective(Orders record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_ORDERS
     *
     * @mbggenerated
     */
    Orders selectByPrimaryKey(BigDecimal ORDERID);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_ORDERS
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Orders record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_ORDERS
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Orders record);
}