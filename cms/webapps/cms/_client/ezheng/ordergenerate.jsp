<%@page import="java.util.*,
                com.bizwink.cms.util.*" 
%>
<%
         String sitename = request.getServerName();
         sitename = StringUtil.replace(sitename,".","_");
         String login_to_url = ParamUtil.getParameter(request,"loginurl");
%>
<html>
    <head>
        <title></title>
    <style type="text/css">
<!--.biz_table{ border:0 dashed null;
 } 
.biz_table td{ font-size:8px; color:#000000; font-family:���� ; text-align:left;
}
.biz_table input{ font-size:18px;  size:10px;

}
biz_table img{ border:0;
}
-->
</style></head>
    <body leftmargin="0" topmargin="0">
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
        <meta content="bzwink" name="author" />
        <meta content="��Ʒ����" name="description" />
        <meta content="��ױƷ��ʮ���塢���Ρ�����Ʒ" name="keywords" />
        <link href="/css/link.css" rel="stylesheet" /><%@include file="/www_chinabuy360_cn/include/top.shtml" %>
        <table cellspacing="0" cellpadding="0" width="1006" border="0">
            <tbody>
                <tr>
                    <td width="6" bgcolor="#ececec">&nbsp;</td>
                    <td width="32"><img alt="" src="/images/logo_leftgap02.gif" /></td>
                    <td align="center" width="220"><img height="23" alt="" width="210" border="0" src="/images/category_view.gif" /></td>
                    <td width="740" bgcolor="#ececec">
                    <table cellspacing="0" cellpadding="0" width="730" bgcolor="#ececec" border="0">
                        <tbody>
                            <tr>
                                <td width="10"><img height="30" alt="" width="10" border="0" src="/images/keyword_leftgap.gif" /></td>
                                <td width="730"><img height="10" alt="" width="2" align="absMiddle" border="0" src="/images/notice_bullet.gif" />&nbsp;<font style="FONT-SIZE: 12px">��������</font></td>
                            </tr>
                        </tbody>
                    </table>
                    </td>
                    <td width="8" bgcolor="#ececec"></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
                <tr height="10">
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table height="150" cellspacing="0" cellpadding="0" width="960" align="center" background="/images/shop_bucket_bg.gif" border="0">
            <tbody>
                <tr height="70">
                    <td valign="top" align="right" width="168" height="70" rowspan="2"><br />
                    <img height="131" alt="" width="141" border="0" src="/images/shop_bucket_img.gif" /></td>
                    <td valign="top" width="414" height="70"><br />
                    <br />
                    <br />
                    <br />
                    <img height="55" alt="" width="324" vspace="3" src="/images/shop_bucket_txt.gif" /></td>
                    <td valign="top" align="left" width="90" height="70" rowspan="2"><a href="#"><img height="141" alt="" width="87" border="0" src="/images/shop_bucket_ico01.gif" /></a></td>
                    <td valign="top" align="left" width="90" height="70" rowspan="2"><a href="#"><img height="141" alt="" width="90" border="0" src="/images/shop_bucket_ico02.gif" /></a></td>
                    <td valign="top" align="left" width="90" height="70" rowspan="2"><a href="#"><img height="141" alt="" width="90" border="0" src="/images/shop_bucket_ico03.gif" /></a></td>
                    <td valign="top" align="left" width="108" rowspan="2"><a href="#"><img height="141" alt="" width="88" border="0" src="/images/shop_bucket_ico04.gif" /></a></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
                <tr height="10">
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" width="960" align="center" border="0">
            <tbody>
                <tr height="22">
                    <td width="3"></td>
                    <td valign="top" width="15"><img height="15" alt="" width="10" border="0" src="/images/shop_bucket_tit_bullet.gif" /></td>
                    <td valign="top" width="942"><strong>���ﳵ</strong></td>
                </tr>
                <tr>
                    <td valign="top" colspan="3"><script type="text/javascript" src="/_sys_js/shoppingcart.js"></script>
<form name="confirmform">
<div id="alladdress"></div>
<div id="connaddr"></div>
<div id="sendway"></div>
<div id="payway"></div>
<div id="productinfo"></div>
<script type="text/javascript">checkAddress('www_chinabuy360_cn','<%=login_to_url%>');</script>
</form>
</td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" width="960" align="center" border="0">
            <tbody>
                <tr height="27">
                    <td valign="top" align="center" width="17"><img height="15" alt="" width="10" border="0" src="/images/shop_bucket_tit_bullet.gif" /></td>
                    <td valign="top" width="795"><strong>���ﳵ��Ϣ</strong></td>
                    <td width="148" rowspan="7"><img alt="" border="0" src="/images/use_guide_img.gif" /></td>
                </tr>
                <tr height="21">
                    <td valign="top" align="right"><img height="13" alt="" width="2" border="0" src="/images/use_guide_bullet.gif" /></td>
                    <td valign="top"><font style="FONT-FAMILY: ����" color="#46a8b4"><strong>&nbsp;�仯��</strong></font> <font style="FONT-FAMILY: Gulim">: ����ͷ��ť���������롣</font></td>
                </tr>
                <tr height="21">
                    <td valign="top" align="right"><img height="13" alt="" width="2" border="0" src="/images/use_guide_bullet.gif" /></td>
                    <td valign="top"><font style="FONT-FAMILY: ����" color="#46a8b4"><strong>&nbsp;����</strong></font> <font style="FONT-FAMILY: Gulim">: ������붩���Ĺ��ﳵ���ﳵ�������嵥ÿ��[Ϊ��]��ť���밴.</font></td>
                </tr>
                <tr height="21">
                    <td valign="top" align="right"><img height="13" alt="" width="2" border="0" src="/images/use_guide_bullet.gif" /></td>
                    <td valign="top"><font style="FONT-FAMILY: ����" color="#46a8b4"><strong>&nbsp;���ж���</strong></font> <font style="FONT-FAMILY: Gulim">: һ�Σ�ÿ���������Եײ���[���ж���]��ť���밴</font></td>
                </tr>
                <tr height="21">
                    <td valign="top" align="right"><img height="13" alt="" width="2" border="0" src="/images/use_guide_bullet.gif" /></td>
                    <td valign="top"><font style="FONT-FAMILY: ����" color="#46a8b4"><strong>&nbsp;���ʽ</strong></font> <font style="FONT-FAMILY: Gulim">: �޴��۴�׼�����Ż�ȯ���֣����㣬����������ʱ����.</font></td>
                </tr>
                <tr height="21">
                    <td valign="top" align="right"><img height="13" alt="" width="2" border="0" src="/images/use_guide_bullet.gif" /></td>
                    <td valign="top"><font style="FONT-FAMILY: ����" color="#46a8b4"><strong>&nbsp;��������</strong></font> <font style="FONT-FAMILY: Gulim">: �������]��ť�����Ƿ���ڹ�ȥ��Ŀǰ�Ĳ�Ʒ��ѡ�����Ŀ���Ѿ�����ҳ�档.</font></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
                <tr height="30">
                    <td></td>
                </tr>
            </tbody>
        </table>
        <table cellspacing="0" cellpadding="0" border="0">
            <tbody>
                <tr height="30">
                    <td></td>
                </tr>
            </tbody>
        </table>
        <%@include file="/www_chinabuy360_cn/include/low.shtml" %>
    </body>
</html>