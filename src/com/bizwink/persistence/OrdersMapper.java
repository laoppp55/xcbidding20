package com.bizwink.persistence;

import com.bizwink.po.Orders;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface OrdersMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_orders
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long ORDERID);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_orders
     *
     * @mbggenerated
     */
    int insert(Orders record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_orders
     *
     * @mbggenerated
     */
    int insertSelective(Orders record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_orders
     *
     * @mbggenerated
     */
    Orders selectByPrimaryKey(Long ORDERID);

    Orders getOrderByUIDAndTraningProjcode(Map params);

    int selectOrderCountByUid(Integer Uid);

    List<Orders> selectByUid(Integer Uid);

    List<Orders> selectByUidInPage(Map params);

    List<Orders> getOrdersGreatTheOrderid(Long ORDERID);

    List<Orders> getAllOrders();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_orders
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Orders record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_orders
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Orders record);

    int updatePayflag(Orders record);

    int updateStatus(Orders record);
}