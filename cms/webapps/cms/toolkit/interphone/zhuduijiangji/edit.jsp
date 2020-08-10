<%@page import="com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil,
                com.bizwink.cms.util.SessionUtil,
                com.xml.Form,
                com.xml.FormPeer,
                com.xml.IFormManager" contentType="text/html;charset=GBK"
        %>
<script language="JavaScript" src="../images/setday.js"></script>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    int startflag = ParamUtil.getIntParameter(request, "startflag", -1);
    int id = ParamUtil.getIntParameter(request, "id", 0);
    String shetaidanwei = ParamUtil.getParameter(request, "shetaidanwei");
    String suoshuxitong = ParamUtil.getParameter(request, "suoshuxitong");
    String address = ParamUtil.getParameter(request, "address");
    String lianxiren = ParamUtil.getParameter(request, "lianxiren");
    String phone = ParamUtil.getParameter(request, "phone");
    String chuanzhen = ParamUtil.getParameter(request, "chuanzhen");
    String shiyongdiqu = ParamUtil.getParameter(request, "shiyongdiqu");
    String diantaishuliang = ParamUtil.getParameter(request, "diantaishuliang");
    String diantaileibie = ParamUtil.getParameter(request, "diantaileibie");
    String shetailiyou = ParamUtil.getParameter(request, "shetailiyou");
    String lingdaoyijian = ParamUtil.getParameter(request, "lingdaoyijian");
    String guanlijuyijian = ParamUtil.getParameter(request, "guanlijuyijian");
    String xitongbianhao = ParamUtil.getParameter(request, "xitongbianhao");
    String zhizhaobianhao = ParamUtil.getParameter(request, "zhizhaobianhao");
    Form form = new Form();
    IFormManager formMgr = FormPeer.getInstance();

    if (startflag == 1) {
        form.setShetaidanwei(shetaidanwei);
        form.setSuoshuxitong(suoshuxitong);
        form.setAddress(address);
        form.setLianxiren(lianxiren);
        form.setPhone(phone);
        form.setChuanzhen(chuanzhen);
        form.setShiyongdiqu(shiyongdiqu);
        form.setDiantaishuliang(diantaishuliang);
        form.setDiantaileibie(diantaileibie);
        form.setShetailiyou(shetailiyou);
        form.setLingdaoyijian(lingdaoyijian);
        form.setGuanlijuyijian(guanlijuyijian);
        form.setXitongbianhao(xitongbianhao);
        form.setZhizhaobianhao(zhizhaobianhao);
        formMgr.updateDuiJiangJi(form, id);
        response.sendRedirect("zhuduijiangji.jsp");
    }
    form = formMgr.getByIdduijiangji(id);
%>
<HTML>
<HEAD><TITLE>�޸����ߵ�̨�걨</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="../images/common.css" type=text/css rel=stylesheet>
    <LINK href="../images/forum.css" type=text/css rel=stylesheet>
    <SCRIPT language=javascript>
       function check()
        {
            if (form1.shetaidanwei.value == "")
            {
                alert("��������̨��λ��");
                return false;
            }
            if (form1.suoshuxitong.value == "")
            {
                alert("����������ϵͳ��");
                return false;
            }
            return true;
        }
        function goto()
        {
            form1.action = "zhuduijiangji.jsp";
            form1.submit();
        }
    </SCRIPT>

    <META content="MSHTML 6.00.2800.1479" name=GENERATOR>
</HEAD>
<BODY bgColor=#ffffff>
<FORM name=form1 action=edit.jsp method=post>
    <INPUT type=hidden value=1 name=startflag>
    <input type=hidden name="id" value="<%=id%>">

    <CENTER>
        <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width=80%
               borderColorLight=#008000 border=1>
            <TBODY>
            <TR>
                <TD bgColor=#33ccff colSpan=2 height=32>
                    <P align=center>�޸��걨</P></TD>
            </TR>
            <TR height=32>
                <TD align=right width=30% height=32>��̨��λ��</TD>
                <TD align=left width=70% height=32>&nbsp;<INPUT size=50 name=shetaidanwei value="<%=form.getShetaidanwei()==null?"":form.getShetaidanwei()%>"><FONT
                        color=red>*</FONT></TD>
            </TR>
            <TR height=32>
                <TD align=right>����ϵͳ��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=suoshuxitong value="<%=form.getSuoshuxitong()==null?"":form.getSuoshuxitong()%>"><FONT
                        color=red>*</FONT>
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>��ַ��</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=address value="<%=form.getAddress()==null?"":form.getAddress()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��ϵ�ˣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=lianxiren value="<%=form.getLianxiren()==null?"":form.getLianxiren()%>">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>�绰��</TD>
                <TD align=left>&nbsp;<INPUT name=phone value="<%=form.getPhone()==null?"":form.getPhone()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>���棺</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=chuanzhen value="<%=form.getChuanzhen()==null?"":form.getChuanzhen()%>">
                </TD>
            </TR>
            <TR height=32>
                <TD align=right>ʹ�õ�����</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=shiyongdiqu value="<%=form.getShiyongdiqu()==null?"":form.getShiyongdiqu()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��̨������</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=diantaishuliang value="<%=form.getDiantaishuliang()==null?"":form.getDiantaishuliang()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��̨���</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=diantaileibie value="<%=form.getDiantaileibie()==null?"":form.getDiantaileibie()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>��̨���ɣ�</TD>
                <TD align=left>&nbsp;<INPUT size=16 name=shetailiyou value="<%=form.getShetailiyou()==null?"":form.getShetailiyou()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>�ϼ����ܵ�λ�쵼�����</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=lingdaoyijian value="<%=form.getLingdaoyijian()==null?"":form.getLingdaoyijian()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>���������ߵ����������</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=guanlijuyijian value="<%=form.getGuanlijuyijian()==null?"":form.getGuanlijuyijian()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>ϵͳ��ţ�</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=xitongbianhao value="<%=form.getXitongbianhao()==null?"":form.getXitongbianhao()%>"></TD>
            </TR>
            <TR height=32>
                <TD align=right>ִ�ձ�ţ�</TD>
                <TD align=left>&nbsp;<INPUT size=50 name=zhizhaobianhao value="<%=form.getZhizhaobianhao()==null?"":form.getZhizhaobianhao()%>"></TD>
            </TR>
            <TR height=32>
                <TD colSpan=2><FONT
                        color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ע������*����Ϊ������</FONT></TD>
            </TR>
            </TBODY>
        </TABLE>
        <P align=center><INPUT onclick="javascript:return check();" type=submit value=" ȷ �� " name=Ok>&nbsp;&nbsp;
            <INPUT onclick=javascript:goto(); type=button value=�����б� name=golist>
        </P>
    </CENTER>
</FORM>
</BODY>
</HTML>
