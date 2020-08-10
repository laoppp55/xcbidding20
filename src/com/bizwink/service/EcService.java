package com.bizwink.service;

import com.bizwink.persistence.*;
import com.bizwink.po.*;
import com.bizwink.vo.InvoiceAndContents;
import com.bizwink.vo.OrderAndOrderdetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 18-8-30.
 */
@Service
public class EcService {
    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private OrderDetailMapper orderDetailMapper;

    @Autowired
    private InvoiceinfofororderMapper invoiceinfoMapper;

    @Autowired
    private InvoicecontentfororderMapper invoicecontentMapper;

    @Autowired
    private AddressinfofororderMapper addressinfoMapper;

    @Autowired
    private TrainingClassDictMapper trainingClassDictMapper;

    @Autowired
    private TrainingMajorDictMapper trainingMajorDictMapper;

    //订单明细项只有一行数据
    @Transactional
    public int saveOrder(Orders orders, OrderDetail orderDetail, Invoiceinfofororder invoiceinfo, Invoicecontentfororder invoicecontent, Addressinfofororder addressinfo) {
        //保存订单信息
        int id =ordersMapper.insert(orders);
        int orderDetailID = orderDetailMapper.insert(orderDetail);

        //保存发票信息
        if (orders.getNeed_invoice() != 0) {
            int invoiceid = invoiceinfoMapper.insert(invoiceinfo);
            invoicecontent.setInvoiceid(invoiceinfo.getId());
            int invoiceContentId = invoicecontentMapper.insert(invoicecontent);
        }

        //保存送货地址信息
        int addressid = addressinfoMapper.insert(addressinfo);

        return 0;
    }

    //订单明细项只有一行数据
    @Transactional
    public int updateOrder(Orders orders,OrderDetail orderDetail,Invoiceinfofororder invoiceinfo,Invoicecontentfororder invoicecontent,Addressinfofororder addressinfo) {
        //保存订单信息
        int id =ordersMapper.updateByPrimaryKeySelective(orders);
        int orderDetailID = orderDetailMapper.updateByOrderidSelective(orderDetail);

        //保存发票信息
        if (orders.getNeed_invoice() != 0) {
            int invoiceid = invoiceinfoMapper.updateByOrderidSelective(invoiceinfo);
            int invoiceContentId = invoicecontentMapper.updateByOrderidSelective(invoicecontent);
        }

        //保存送货地址信息
        if (addressinfo!=null) addressinfoMapper.updateByOrderidSelective(addressinfo);

        return orderDetailID;
    }

    //订单明细项有多行数据
    @Transactional
    public int saveOrder(Orders orders, List<OrderDetail> orderDetails, Invoiceinfofororder invoiceinfo, Invoicecontentfororder invoicecontent, Addressinfofororder addressinfo) {
        int retcode = 0;
        //保存订单信息
        retcode =ordersMapper.insert(orders);
        for(int ii=0;ii<orderDetails.size();ii++){
            OrderDetail orderDetail = orderDetails.get(ii);
            int orderDetailID = orderDetailMapper.insert(orderDetail);
            retcode = retcode + orderDetailID;
        }

        //保存发票信息
        if (orders.getNeed_invoice() != 0) {
            int invoiceid = invoiceinfoMapper.insert(invoiceinfo);
            invoicecontent.setInvoiceid(invoiceinfo.getId());
            int invoiceContentId = invoicecontentMapper.insert(invoicecontent);
        }

        //保存送货地址信息
        if (addressinfo!=null) addressinfoMapper.insert(addressinfo);

        return retcode;
    }

    //订单明细项有多行数据
    @Transactional
    public int updateOrder(Orders orders,List<OrderDetail> orderDetails,Invoiceinfofororder invoiceinfo,Invoicecontentfororder invoicecontent,Addressinfofororder addressinfo) {
        //保存订单信息
        int id =ordersMapper.updateByPrimaryKeySelective(orders);
        List<OrderDetail> s_orderDetailList = orderDetailMapper.selectByOrderid(orders.getORDERID());

        //原来的订单明细记录在新的订单明细记录中是否存在，不存在就从数据库中删除该明细记录，存在就用新的订单明细数据修改老数据
        for(int ii=0;ii<s_orderDetailList.size();ii++) {
            OrderDetail s_orderDetail = s_orderDetailList.get(ii);
            boolean exist_flag = false;
            OrderDetail orderDetail = null;
            for(int jj=0;jj<orderDetails.size();jj++) {
                orderDetail = orderDetails.get(jj);
                if (orderDetail.getProductcode().equals(s_orderDetail.getProductcode())) {
                    s_orderDetail.setProductname(orderDetail.getProductname());
                    s_orderDetail.setPRODUCTID(orderDetail.getPRODUCTID());
                    s_orderDetail.setSALEPRICE(orderDetail.getSALEPRICE());
                    exist_flag = true;
                    break;
                }
            }
            if (!exist_flag)
                orderDetailMapper.deleteByPrimaryKey(s_orderDetail.getID());
            else {
                orderDetailMapper.updateByPrimaryKeySelective(s_orderDetail);
            }
        }

        //新的订单明细记录在老订单明细记录中不存在，增加该订单明细记录
        for(int ii=0;ii<orderDetails.size();ii++) {
            OrderDetail orderDetail = orderDetails.get(ii);
            boolean exist_flag = false;
            for(int jj=0;jj<s_orderDetailList.size();jj++) {
                OrderDetail s_orderDetail = s_orderDetailList.get(jj);
                if (orderDetail.getProductcode().equals(s_orderDetail.getProductcode())) {
                    exist_flag = true;
                    break;
                }
            }
            if (!exist_flag) orderDetailMapper.insert(orderDetail);
        }

        //保存发票信息
        if (orders.getNeed_invoice() != 0) {
            int invoiceid = invoiceinfoMapper.updateByOrderidSelective(invoiceinfo);
            int invoiceContentId = invoicecontentMapper.updateByOrderidSelective(invoicecontent);
        }

        //保存送货地址信息
        if (addressinfo!=null) addressinfoMapper.updateByOrderidSelective(addressinfo);

        return id;
    }

    @Transactional
    public int deleteByOrderid(long orderid) {
        int retcode1 = ordersMapper.deleteByPrimaryKey(orderid);
        int retcode2 = addressinfoMapper.deleteByOrderid(orderid);
        int retcode3 = invoiceinfoMapper.deleteByOrderid(orderid);
        int retcode4 = invoicecontentMapper.deleteByOrderid(orderid);

        if (retcode1>0)
            return 0;
        else
            return -1;
    }

    public OrderAndOrderdetail getOrderinfos(long orderid) {
        OrderAndOrderdetail orderAndOrderdetail = new OrderAndOrderdetail();
        Orders order = ordersMapper.selectByPrimaryKey(orderid);
        List<OrderDetail> orderDetails = orderDetailMapper.selectByOrderid(orderid);

        orderAndOrderdetail.setID(order.getID());
        orderAndOrderdetail.setORDERID(order.getORDERID());
        orderAndOrderdetail.setUSERID(order.getUSERID());
        orderAndOrderdetail.setNAME(order.getNAME());
        orderAndOrderdetail.setNotes(order.getNotes());
        orderAndOrderdetail.setPHONE(order.getPHONE());
        orderAndOrderdetail.setADDRESS(order.getADDRESS());
        orderAndOrderdetail.setCREATEDATE(order.getCREATEDATE());
        orderAndOrderdetail.setPAYFEE(order.getPAYFEE());
        orderAndOrderdetail.setSTATUS(order.getSTATUS());
        orderAndOrderdetail.setNOUSE(order.getNOUSE());
        orderAndOrderdetail.setFlag(order.getFlag());
        orderAndOrderdetail.setPayflag(order.getPayflag());
        orderAndOrderdetail.setNeed_invoice(order.getNeed_invoice());
        orderAndOrderdetail.setVALID(order.getVALID());
        orderAndOrderdetail.setOrderDetails(orderDetails);

        return orderAndOrderdetail;
    }

    public int getOrdersNumByUID(int uid) {
        return ordersMapper.selectOrderCountByUid(uid);
    }

    public List<Orders> getOrdersByUID(int uid) {
        return ordersMapper.selectByUid(uid);
    }

    public List<Orders> getOrdersByUIDInPage(int siteid,int uid,int startPageNum,int endPageNum) {
        Map params = new HashMap();
        params.put("SITEID",siteid);
        params.put("UID",uid);
        params.put("BEGINROW",startPageNum);
        params.put("ENDROW",endPageNum);
        return ordersMapper.selectByUidInPage(params);
    }

    public List<OrderAndOrderdetail> getOrderinfoListByUid(int uid) {
        List<OrderAndOrderdetail> orderAndOrderdetails = new ArrayList();
        OrderAndOrderdetail orderAndOrderdetail = null;
        List<OrderDetail> orderDetails = null;

        List<Orders> orders = ordersMapper.selectByUid(uid);

        for(int ii=0; ii<orders.size(); ii++) {
            Orders order = orders.get(ii);
            orderDetails = orderDetailMapper.selectByOrderid(order.getORDERID());
            orderAndOrderdetail = new OrderAndOrderdetail();
            orderAndOrderdetail.setID(order.getID());
            orderAndOrderdetail.setORDERID(order.getORDERID());
            orderAndOrderdetail.setUSERID(order.getUSERID());
            orderAndOrderdetail.setNAME(order.getNAME());
            orderAndOrderdetail.setNotes(order.getNotes());
            orderAndOrderdetail.setPHONE(order.getPHONE());
            orderAndOrderdetail.setADDRESS(order.getADDRESS());
            orderAndOrderdetail.setCREATEDATE(order.getCREATEDATE());
            orderAndOrderdetail.setPAYFEE(order.getPAYFEE());
            orderAndOrderdetail.setSTATUS(order.getSTATUS());
            orderAndOrderdetail.setNOUSE(order.getNOUSE());
            orderAndOrderdetail.setFlag(order.getFlag());
            orderAndOrderdetail.setPayflag(order.getPayflag());
            orderAndOrderdetail.setNeed_invoice(order.getNeed_invoice());
            orderAndOrderdetail.setVALID(order.getVALID());
            orderAndOrderdetail.setOrderDetails(orderDetails);
            orderAndOrderdetails.add(orderAndOrderdetail);
        }

        return orderAndOrderdetails;
    }

    public Addressinfofororder getAddressByOrderid(long orderid) {
        return addressinfoMapper.selectByOrderid(orderid);
    }

    public InvoiceAndContents getInvoiceinfoByOrderid(long orderid) {
        InvoiceAndContents invoiceAndContents = new InvoiceAndContents();
        Invoiceinfofororder invoiceinfo = invoiceinfoMapper.selectByOrderid(orderid);
        List<Invoicecontentfororder> invoicecontentfororderList = invoicecontentMapper.selectByOrderid(orderid);

        if (invoiceinfo!=null) {
            invoiceAndContents.setUserid(invoiceinfo.getUserid());
            invoiceAndContents.setId(invoiceinfo.getId());
            invoiceAndContents.setPhone(invoiceinfo.getPhone());
            invoiceAndContents.setOrderid(invoiceinfo.getOrderid());
            invoiceAndContents.setCompanyname(invoiceinfo.getCompanyname());
            invoiceAndContents.setRegisteraddress(invoiceinfo.getRegisteraddress());
            invoiceAndContents.setIdentification(invoiceinfo.getIdentification());
            invoiceAndContents.setBankaccount(invoiceinfo.getBankaccount());
            invoiceAndContents.setBankname(invoiceinfo.getBankname());
            invoiceAndContents.setInvoicetype(invoiceinfo.getInvoicetype());
            invoiceAndContents.setTitle(invoiceinfo.getTitle());
            invoiceAndContents.setEmail(invoiceinfo.getEmail());
            invoiceAndContents.setCreatedate(invoiceinfo.getCreatedate());
            invoiceAndContents.setInvoicecontentfororders(invoicecontentfororderList);
            return invoiceAndContents;
        } else {
            return null;
        }
    }

    public int UpdatePayflag(long orderid,String jylsh,String zfmemberid,String r2type,String payresult,int payflag,int payway,Timestamp paydate) {
        Orders order = new Orders();
        order.setORDERID(orderid);
        order.setJylsh(jylsh);
        order.setZfmemberid(zfmemberid);
        order.setR2type(r2type);
        order.setPayresult(payresult);
        order.setPayflag((short)payflag);
        order.setPayway(payway);
        order.setSTATUS(8);
        order.setPaydate(paydate);
        return ordersMapper.updatePayflag(order);
    }

    //用户在订单回显页面点击了支付按钮，修改Payfalg=1，表示用户准备做支付
    //第一种情况是用户没有真正完成支付
    //第二种情况是用户真正完成了支付，但是第三方支付网关由于各种原因未能完成回调函数的调用，订单状态仍然是未完成状态
    public int UpdateUserClickPayflag(long orderid,int payflag,int payway) {
        Orders order = new Orders();
        order.setORDERID(orderid);
        order.setPayway(payway);
        order.setPayflag((short)payflag);
        order.setPaydate(new Timestamp(System.currentTimeMillis()));
        return ordersMapper.updateByPrimaryKeySelective(order);
    }

    public int UpdateOrderStatus(long orderid,int status) {
        Orders order = new Orders();
        order.setORDERID(orderid);
        order.setSTATUS(status);
        order.setLastupdate(new Timestamp(System.currentTimeMillis()));
        return ordersMapper.updateStatus(order);
    }

    public List<Orders> getAllOrders() {
        return ordersMapper.getAllOrders();
    }

    public List<Orders> getOrdersGreatTheOrderid(long orderid) {
        return ordersMapper.getOrdersGreatTheOrderid(orderid);
    }

    public Orders getOrder(long orderid) {
        return ordersMapper.selectByPrimaryKey(orderid);
    }

    public Orders getOrderByUIDAndTraningProjcode(BigDecimal uid,BigDecimal articleid) {
        Map params = new HashMap();
        params.put("USERID",uid);
        params.put("articleid",articleid);
        return ordersMapper.getOrderByUIDAndTraningProjcode(params);
    }

    public OrderDetail getOrderDetail(long orderid) {
        return orderDetailMapper.selectByPrimaryKey(orderid);
    }

    public List<OrderDetail> getOrderDetailList(long orderid) {
        return orderDetailMapper.selectByOrderid(orderid);
    }

    public TrainingClassDict getClassName(String classcode) {
        return trainingClassDictMapper.getClassNameByCode(classcode);
    }
}
