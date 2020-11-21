package com.bizwink.po;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CertInfoExample {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    protected String orderByClause;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    protected boolean distinct;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    protected List<Criteria> oredCriteria;

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public CertInfoExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public String getOrderByClause() {
        return orderByClause;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public boolean isDistinct() {
        return distinct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Integer value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Integer value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Integer value1, Integer value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Integer value1, Integer value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andUseridIsNull() {
            addCriterion("userid is null");
            return (Criteria) this;
        }

        public Criteria andUseridIsNotNull() {
            addCriterion("userid is not null");
            return (Criteria) this;
        }

        public Criteria andUseridEqualTo(String value) {
            addCriterion("userid =", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridNotEqualTo(String value) {
            addCriterion("userid <>", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridGreaterThan(String value) {
            addCriterion("userid >", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridGreaterThanOrEqualTo(String value) {
            addCriterion("userid >=", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridLessThan(String value) {
            addCriterion("userid <", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridLessThanOrEqualTo(String value) {
            addCriterion("userid <=", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridLike(String value) {
            addCriterion("userid like", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridNotLike(String value) {
            addCriterion("userid not like", value, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridIn(List<String> values) {
            addCriterion("userid in", values, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridNotIn(List<String> values) {
            addCriterion("userid not in", values, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridBetween(String value1, String value2) {
            addCriterion("userid between", value1, value2, "userid");
            return (Criteria) this;
        }

        public Criteria andUseridNotBetween(String value1, String value2) {
            addCriterion("userid not between", value1, value2, "userid");
            return (Criteria) this;
        }

        public Criteria andSnIsNull() {
            addCriterion("sn is null");
            return (Criteria) this;
        }

        public Criteria andSnIsNotNull() {
            addCriterion("sn is not null");
            return (Criteria) this;
        }

        public Criteria andSnEqualTo(String value) {
            addCriterion("sn =", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnNotEqualTo(String value) {
            addCriterion("sn <>", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnGreaterThan(String value) {
            addCriterion("sn >", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnGreaterThanOrEqualTo(String value) {
            addCriterion("sn >=", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnLessThan(String value) {
            addCriterion("sn <", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnLessThanOrEqualTo(String value) {
            addCriterion("sn <=", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnLike(String value) {
            addCriterion("sn like", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnNotLike(String value) {
            addCriterion("sn not like", value, "sn");
            return (Criteria) this;
        }

        public Criteria andSnIn(List<String> values) {
            addCriterion("sn in", values, "sn");
            return (Criteria) this;
        }

        public Criteria andSnNotIn(List<String> values) {
            addCriterion("sn not in", values, "sn");
            return (Criteria) this;
        }

        public Criteria andSnBetween(String value1, String value2) {
            addCriterion("sn between", value1, value2, "sn");
            return (Criteria) this;
        }

        public Criteria andSnNotBetween(String value1, String value2) {
            addCriterion("sn not between", value1, value2, "sn");
            return (Criteria) this;
        }

        public Criteria andCertnumIsNull() {
            addCriterion("certnum is null");
            return (Criteria) this;
        }

        public Criteria andCertnumIsNotNull() {
            addCriterion("certnum is not null");
            return (Criteria) this;
        }

        public Criteria andCertnumEqualTo(String value) {
            addCriterion("certnum =", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumNotEqualTo(String value) {
            addCriterion("certnum <>", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumGreaterThan(String value) {
            addCriterion("certnum >", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumGreaterThanOrEqualTo(String value) {
            addCriterion("certnum >=", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumLessThan(String value) {
            addCriterion("certnum <", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumLessThanOrEqualTo(String value) {
            addCriterion("certnum <=", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumLike(String value) {
            addCriterion("certnum like", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumNotLike(String value) {
            addCriterion("certnum not like", value, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumIn(List<String> values) {
            addCriterion("certnum in", values, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumNotIn(List<String> values) {
            addCriterion("certnum not in", values, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumBetween(String value1, String value2) {
            addCriterion("certnum between", value1, value2, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertnumNotBetween(String value1, String value2) {
            addCriterion("certnum not between", value1, value2, "certnum");
            return (Criteria) this;
        }

        public Criteria andCertpublisherIsNull() {
            addCriterion("certpublisher is null");
            return (Criteria) this;
        }

        public Criteria andCertpublisherIsNotNull() {
            addCriterion("certpublisher is not null");
            return (Criteria) this;
        }

        public Criteria andCertpublisherEqualTo(String value) {
            addCriterion("certpublisher =", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherNotEqualTo(String value) {
            addCriterion("certpublisher <>", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherGreaterThan(String value) {
            addCriterion("certpublisher >", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherGreaterThanOrEqualTo(String value) {
            addCriterion("certpublisher >=", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherLessThan(String value) {
            addCriterion("certpublisher <", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherLessThanOrEqualTo(String value) {
            addCriterion("certpublisher <=", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherLike(String value) {
            addCriterion("certpublisher like", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherNotLike(String value) {
            addCriterion("certpublisher not like", value, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherIn(List<String> values) {
            addCriterion("certpublisher in", values, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherNotIn(List<String> values) {
            addCriterion("certpublisher not in", values, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherBetween(String value1, String value2) {
            addCriterion("certpublisher between", value1, value2, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublisherNotBetween(String value1, String value2) {
            addCriterion("certpublisher not between", value1, value2, "certpublisher");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeIsNull() {
            addCriterion("certpublishercode is null");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeIsNotNull() {
            addCriterion("certpublishercode is not null");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeEqualTo(String value) {
            addCriterion("certpublishercode =", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeNotEqualTo(String value) {
            addCriterion("certpublishercode <>", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeGreaterThan(String value) {
            addCriterion("certpublishercode >", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeGreaterThanOrEqualTo(String value) {
            addCriterion("certpublishercode >=", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeLessThan(String value) {
            addCriterion("certpublishercode <", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeLessThanOrEqualTo(String value) {
            addCriterion("certpublishercode <=", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeLike(String value) {
            addCriterion("certpublishercode like", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeNotLike(String value) {
            addCriterion("certpublishercode not like", value, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeIn(List<String> values) {
            addCriterion("certpublishercode in", values, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeNotIn(List<String> values) {
            addCriterion("certpublishercode not in", values, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeBetween(String value1, String value2) {
            addCriterion("certpublishercode between", value1, value2, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCertpublishercodeNotBetween(String value1, String value2) {
            addCriterion("certpublishercode not between", value1, value2, "certpublishercode");
            return (Criteria) this;
        }

        public Criteria andCreatedateIsNull() {
            addCriterion("createdate is null");
            return (Criteria) this;
        }

        public Criteria andCreatedateIsNotNull() {
            addCriterion("createdate is not null");
            return (Criteria) this;
        }

        public Criteria andCreatedateEqualTo(Date value) {
            addCriterion("createdate =", value, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateNotEqualTo(Date value) {
            addCriterion("createdate <>", value, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateGreaterThan(Date value) {
            addCriterion("createdate >", value, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateGreaterThanOrEqualTo(Date value) {
            addCriterion("createdate >=", value, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateLessThan(Date value) {
            addCriterion("createdate <", value, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateLessThanOrEqualTo(Date value) {
            addCriterion("createdate <=", value, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateIn(List<Date> values) {
            addCriterion("createdate in", values, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateNotIn(List<Date> values) {
            addCriterion("createdate not in", values, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateBetween(Date value1, Date value2) {
            addCriterion("createdate between", value1, value2, "createdate");
            return (Criteria) this;
        }

        public Criteria andCreatedateNotBetween(Date value1, Date value2) {
            addCriterion("createdate not between", value1, value2, "createdate");
            return (Criteria) this;
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table tbl_certinfo
     *
     * @mbggenerated do_not_delete_during_merge
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    /**
     * This class was generated by MyBatis Generator.
     * This class corresponds to the database table tbl_certinfo
     *
     * @mbggenerated
     */
    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}