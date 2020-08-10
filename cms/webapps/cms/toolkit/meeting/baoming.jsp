<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.Meetting_sign" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.Meetting_sign_part" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.ICompanyinfoManager" %>
<%@ page import="com.bizwink.cms.toolkit.companyinfo.CompanyinfoPeer" %>
<%@ page contentType="text/html;charset=GBK" %>
<%
    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);

    if (startflag == 1) {
        long oredertime = System.currentTimeMillis();
        String str = String.valueOf(oredertime);
        str = str.substring(6, 13);
        if (str.length() < 7) {
            for (int i = 0; i < (7 - str.length()); i++) {
                str = "1" + str;
            }
        }
        String random = String.valueOf(Math.random());
        random = random.substring(random.indexOf(".") + 1, random.indexOf(".") + 4);
        str = str + random;
        if (str != null) {
            if (str.length() < 10) {
                for (int i = 0; i < (10 - str.length()); i++) {
                    str = "1" + str;
                }
            }
        }
        long orderid = Long.parseLong(str);
        str = String.valueOf(orderid);
        if (str.length() < 10) {
            for (int i = 0; i < (10 - str.length()); i++) {
                str = "1" + str;
            }
        }
        orderid = Long.parseLong(str);

        //��˾��Ϣ
        String comapnyname = ParamUtil.getParameter(request,"comapnyname");//��˾����
        String invoicetitle = ParamUtil.getParameter(request,"invoicetitle");//��Ʊ̧ͷ
        String address = ParamUtil.getParameter(request,"address");//��Ʊ�ʼĵ�ַ
        String postcode = ParamUtil.getParameter(request,"postcode");//��������
        float fees = ParamUtil.getFloatParameter(request, "fees", 0);//����
        System.out.println("fee="+fees);
        int payway = ParamUtil.getIntParameter(request,"payway",1);
        String paytime = ParamUtil.getParameter(request,"paytime");
        Meetting_sign meetting_sign = new Meetting_sign();
        meetting_sign.setOrderid(orderid);
        meetting_sign.setMeetingid(0);
        meetting_sign.setComapnyname(comapnyname);
        meetting_sign.setInvoicetitle(invoicetitle);
        meetting_sign.setAddress(address);
        meetting_sign.setPostcode(postcode);
        meetting_sign.setFee(fees);
        meetting_sign.setPayway(payway);
        meetting_sign.setPaytime(Timestamp.valueOf(paytime + " 00:00:00"));

        int curNum = ParamUtil.getIntParameter(request,"curNum",0);
        List list = new ArrayList();
        Meetting_sign_part meetting_sign_part;
        for(int i =1; i <=curNum; i++){
            String name = ParamUtil.getParameter(request,"name"+i);
            String dept = ParamUtil.getParameter(request,"dept"+i);
            String phone = ParamUtil.getParameter(request,"phone"+i);
            String fax = ParamUtil.getParameter(request,"fax"+i);
            String mail = ParamUtil.getParameter(request,"mail"+i);
            int select = ParamUtil.getIntParameter(request,"select"+i,0);
            meetting_sign_part = new Meetting_sign_part();
            meetting_sign_part.setOrderid(orderid);
            meetting_sign_part.setSignid(select);//��ѵ��id
            meetting_sign_part.setName(name);
            meetting_sign_part.setDepttitle(dept);
            meetting_sign_part.setMobilephone(phone);
            meetting_sign_part.setFax(fax);
            meetting_sign_part.setEmail(mail);
            list.add(meetting_sign_part);
        }

        ICompanyinfoManager CompanyinfoMgr = CompanyinfoPeer.getInstance();
        int code = CompanyinfoMgr.sub_baoming(meetting_sign,list);



    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>��ѵר��</title>
    <link href="css/20151013.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.js"></script>
    <script type="text/javascript" src="js/WdatePicker.js" ></script>
</head>

<body>
<div class="main">
    <div class="top_box"><img src="images/baoming.jpg" width="107" height="31" /><img src="images/weibo.jpg" width="107" height="31" /></div>
    <div class="menu">
        <ul>
            <li class="home"><a href="#">��ҳ</a></li>
            <li><a href="#">���鰲��</a></li>
            <li><a href="#">����ع�</a></li>
            <li><a href="#">��Ҫ����</a></li>
        </ul>
    </div>

    <div class="box4">
        <form id="form1" name="form1" method="post" action="baoming.jsp">
            <input type="hidden" name="startflag" value="1">
            <input type="hidden" name="curNum" id="curNum" value="1">
            <div class="txt">��˾���ƣ�
                <label>
                    <input name="comapnyname" type="text" id="comapnyname" value="����д" onclick="if(this.value=='����д')this.value=''" onblur="if (value ==''){value='����д'}" />
                </label>
            </div>
            <div class="txt">
                <table id="table" width="950" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                        <td width="84">����</td>
                        <td width="153">���ż�ְ��</td>
                        <td width="119">�ֻ�</td>
                        <td width="139">����</td>
                        <td width="164">�����ʼ�</td>
                        <td width="153">��ѵʱ��</td>
                        <td width="80">�ص�</td>
                        <td width="60">ɾ��</td>
                    </tr>
                    <tr>
                        <td><input type="text" class="name" name="name1"/></td>
                        <td><input type="text" class="dept" name="dept1" /></td>
                        <td><input type="text" class="phone" name="phone1" /></td>
                        <td><input type="text" class="fax" name="fax1" /></td>
                        <td><input type="text" class="mail" name="mail1" /></td>
                        <td><label>
                            <select name="select1" id="select1" onchange="getaddress(1)">
                            </select>
                        </label></td>
                        <td><span id="address1"></span></td>
                        <td onClick="getDel(this)"><a href="javascript:void(0);">ɾ��</a></td>
                    </tr>

                </table>
            </div>
            <div class="txt" id="btn">��������ѵ��Ա</div>
            <div class="txt" style="margin-top:20px;">��˾���ƣ���Ʊ̧ͷ��<label>
                <input name="invoicetitle" type="text" id="invoicetitle" value="����д" onclick="if(this.value=='����д')this.value=''" onblur="if (value ==''){value='����д'}" />
            </label></div>
            <div class="txt">��˾��ַ����Ʊ���ͣ�<label>
                <input name="address" type="text" id="address" value="����д" onclick="if(this.value=='����д')this.value=''" onblur="if (value ==''){value='����д'}" />
            </label></div>
            <div class="txt">��������<label>
                <input name="postcode" type="text" id="postcode" value="����д" onclick="if(this.value=='����д')this.value=''" onblur="if (value ==''){value='����д'}"/>
            </label></div>
            <div class="txt">�λ���ã�1000RMB/��</div>
            <div class="txt">���ð��������������úͻ������ϡ������ò͵ȣ�������ס�޷��ã���</div>
            <div class="txt">
                <table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                        <td width="350">��ѵ���ã���<span id="fee">1000</span>Ԫ����д��<span id="dfee">ҼǪ</span>Ԫ��</td>
                        <input type="hidden" name="fees" id="fees" value="1000">
                        <td>֧����ʽ��
                            <input class="bnt" type="radio" name="payway"  value="1" checked="checked"/>
                            ����
                            <input class="bnt" type="radio" name="payway"  value="2" />
                            ����</td>
                    </tr>
                    <tr>
                        <td>���ʱ�䣺</td>
                        <td><input  type="text" value="" name="paytime" id="beginTime"  onfocus="WdatePicker({el:'beginTime',dateFmt:'yyyy-MM-dd'});" class="Wdate" /></td>
                    </tr>
                </table>
            </div>
            <div class="txt" style="margin-top:20px;">������Ϣ</div>
            <div class="txt">�������������ǵ����������޹�˾</div>
            <div class="txt">�˺ţ�3350 6196 6103</div>
            <div class="txt">�����У��й����б�����չ����֧��</div>
            <div class="txt">�кţ�104100004290</div>
            <div class="txt" style="margin-top:20px;">ע������</div>
            <div class="txt">1�������ڸ����ѻ��׵����浽010-64661119-9900����Ʊ������ѵ������������ͨ����ݼ��͵�����˾��</div>
            <div class="txt">2����ʲ��ܲμ���ѵ����Ҫ�˿�ģ����ڵ�����ѵ��ʼǰ5������������룬�������˿ֻ�����ڲμӺ�������ѵ��</div>
            <div class="txt">�������׼ȷ������д�ϱ������Ϣ���Ա�����������ѵ����׼��������Ϊ���ṩ���õķ���</div>
            <div class="submit">
                <input name="button" type="submit" class="submit_bnt" id="button" value="�ύ" />
            </div>
        </form>
    </div>

    <div class="footer"><a target="_blank" href="http://egreatwall.com/">���ǵ���</a>|<a target="_blank" href="http://egreatwall.com/case/sinopec/?i=0&amp;k=3&amp;key=webmenu">���䰸��</a>|<a target="_blank" href="http://egreatwall.com/product/ecai/index.shtml">��Ʒ����</a>|<a target="_blank" href="http://egreatwall.com/about/law/">��������</a>|<a target="_blank" href="http://egreatwall.com/about/introduction/">��������</a><br>
        @ 2011-2015 �������ǵ����������޹�˾ ��ICP��13024604��<script type="text/javascript">
            var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
            document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Ff7e90d63d47624debcca739841d621bf' type='text/javascript'%3E%3C/script%3E"));
        </script><script src=" http://hm.baidu.com/h.js?f7e90d63d47624debcca739841d621bf" type="text/javascript"></script><a href="http://tongji.baidu.com/hm-web/welcome/ico?s=f7e90d63d47624debcca739841d621bf" target="_blank"><img border="0" src="http://eiv.baidu.com/hmt/icon/21.gif" width="20" height="20"></a></div>
</div>
</body>
<script src="js/ccbm.js"></script>
<script>getTime(1);</script>
</html>
