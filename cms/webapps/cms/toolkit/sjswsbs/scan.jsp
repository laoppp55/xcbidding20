<%@page import="com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.sjswsbs.*" %>
<%@ page import="java.util.*" %>
<%
    int id = ParamUtil.getIntParameter(request, "id", 0);
    WsbsEntity wsbs = new WsbsEntity();
    List list = new ArrayList();
    IWsbsManager wsbsMgr = WsbsPeer.getInstance();
    wsbs = wsbsMgr.getByIdwsbs(id);
    list = wsbsMgr.getByIdGist(id);  list.size();
%>
<HTML>
<HEAD><TITLE>���ϰ���</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=gb2312">
    <LINK href="images/common.css" type=text/css rel=stylesheet>
    <LINK href="images/forum.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<CENTER>
    <TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0 width="98%"
           borderColorLight=#008000 border=1>
        <TBODY>
        <TR>
            <TD width=493 bgColor=#33ccff colSpan=2 height=32>
                <P align=center>���ϰ���</P></TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�������ƣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getName() == null ? "--" : wsbs.getName()%>
            </TD>
        </TR>         
        <TR>
            <TD align=right width="20%" height=32>�������ࣺ</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbsMgr.getByIdcatg(wsbs.getCatgid()).getName() == null ? "--" : wsbsMgr.getByIdcatg(wsbs.getCatgid()).getName()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����ί��֣�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbsMgr.getByIdcatg(wsbs.getDepid()).getName() == null ? "--" : wsbsMgr.getByIdcatg(wsbs.getDepid()).getName()%>
            </TD>
        </TR>        
        <TR>
            <TD align=right width="20%" height=32>�������Ķ���</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getServiceobject() == null ? "--" : wsbs.getServiceobject()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�������ݣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getBasis() == null ? "--" : wsbs.getBasis()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�շ����ݺͱ�׼��</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getChargestandard() == null ? "--" : wsbs.getChargestandard()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�������ޣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getTimelimited() == null ? "--" : wsbs.getTimelimited()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>��ŵ���ޣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getTimelimit() == null ? "--" : wsbs.getTimelimit()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�����ţ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getOrgnization() == null ? "--" : wsbs.getOrgnization()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����ص㣺</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getWorkaddress() == null ? "--" : wsbs.getWorkaddress()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�˳�·�ߣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getRidingroute() == null ? "--" : wsbs.getRidingroute()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>��ϵ�绰��</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getRelatephone() == null ? "--" : wsbs.getRelatephone()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>��ע��</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getMemo() == null ? "--" : wsbs.getMemo()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�������</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getWorkprocedure() == null ? "--" : wsbs.getWorkprocedure()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>���߰������ӣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getLink_zxbl() == null ? "--" : wsbs.getLink_zxbl()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����������ӣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getLink_jgfk() == null ? "--" : wsbs.getLink_jgfk()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>������ѯ���ӣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getLink_zxzx() == null ? "--" : wsbs.getLink_zxzx()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>¼�����ڣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getStandby() == null ? "--" : wsbs.getStandby()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>��������</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getCoun() == null ? "--" : wsbs.getCoun()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>������ϣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getStuff() == null ? "--" : wsbs.getStuff()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����������</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getItem_condition() == null ? "--" : wsbs.getItem_condition()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����ʱ�䣺</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getItem_times() == null ? "--" : wsbs.getItem_times()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>������룺</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getCode() == null ? "--" : wsbs.getCode()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>������ࣺ</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getClassified() == null ? "--" : wsbs.getClassified()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�������壺</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getMain() == null ? "--" : wsbs.getMain()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����Ȩ�ޣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getJurisdiction() == null ? "--" : wsbs.getJurisdiction()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>����������</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getAnswer() == null ? "--" : wsbs.getAnswer()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>�ල�绰��</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getSupervision_telephone() == null ? "--" : wsbs.getSupervision_telephone()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>��λ˵����</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=wsbs.getJob_description() == null ? "--" : wsbs.getJob_description()%>
            </TD>
        </TR>
        <TR>
            <TD colSpan=2><FONT
                    color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������˵����</FONT></TD>
        </TR>
        <%
            if(list != null){
                for(int i = 0; i < list.size(); i++){
                BasisEntity basis = (BasisEntity)list.get(i);                    
        %>
        <TR>
            <TD align=right width="20%" height=32>˵�����ƣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=basis.getName() == null ? "--" : basis.getName()%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>ѡ��</TD>
            <TD align=left width="80%" height=32>&nbsp;<%if(basis.getCategory()==0){%>��������<%}else{%>��ظ���<%}%>
            </TD>
        </TR>
        <TR>
            <TD align=right width="20%" height=32>˵�����ݣ�</TD>
            <TD align=left width="80%" height=32>&nbsp;<%=basis.getContent() == null ? "--" : basis.getContent()%>
            </TD>
        </TR>         
        <%}}%>
        </TBODY>
    </TABLE>
</CENTER>
<BR><BR>
<CENTER><INPUT onclick=javascript:history.go(-1); type=button value=" �� �� ">
</CENTER>
</BODY>
</HTML>
