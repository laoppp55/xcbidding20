package com.bizwink.mysql.service;

import com.bizwink.mysql.persistence.*;
import com.bizwink.mysql.po.*;
import com.bizwink.mysql.vo.InvoiceAndContents;
import com.bizwink.mysql.vo.OrderAndOrderdetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 18-8-30.
 */
@Service
public class MEcService {
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

    @Transactional
    public int saveOrder(Orders orders,OrderDetail orderDetail,Invoiceinfofororder invoiceinfo,Invoicecontentfororder invoicecontent,Addressinfofororder addressinfo) {
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
        int addressid = addressinfoMapper.updateByOrderidSelective(addressinfo);

        return 0;
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
}
