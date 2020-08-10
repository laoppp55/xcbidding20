package com.bizwink.persistence;

import com.bizwink.po.Users;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;


public interface UsersMapper {
    BigDecimal getMainKey();

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_MEMBERS
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String USERID);

    int stopByPrimaryKey(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_MEMBERS
     *
     * @mbggenerated
     */
    int insert(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_MEMBERS
     *
     * @mbggenerated
     */
    int insertSelective(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_MEMBERS
     *
     * @mbggenerated
     */
    Users selectByPrimaryKey(String USERID);

    Users selectByEmail(String email);

    Users selectByMphone(String mphone);

    int updateByUserid(Users user);

    List<Users> getUsersByArea(String areaid);

    List<Users> getUsersByCity(String cityid);

    List<Users> getUsersByParentOrgID(Map<String, Object> param);    //获取某个组织节点下的所有子组织的用户信息

    List<Users> getUsersByCustomer(Map<String, Object> param);       //分页获取用户信息

    List<Users> getUsersByCustomer(BigDecimal customer);             //获取某个客户的所有用户信息

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_MEMBERS
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Users record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table TBL_MEMBERS
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Users record);

    List<Users> getTheUsersByArea(Map<String, Object> param);

    Integer countUsers (Map<String, Object> param);

    Users getBySiteId(int siteId);

    Users CheckUsername(Map params);

    Users CheckEmail(Map params);

    Users CheckMphone(Map params);

    Users getPredepositAndScore(String USERID);
}