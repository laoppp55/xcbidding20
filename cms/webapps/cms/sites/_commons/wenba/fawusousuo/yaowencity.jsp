<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.util.ParamUtil" %>
<%@ page import="com.po.IArticleManager" %>
<%@ page import="com.po.ArticlePeer" %>
<%@ page import="java.util.List" %>
<%@ page import="com.po.Article" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>

<%
    int flag = ParamUtil.getIntParameter(request, "flag", -1);
    String city=ParamUtil.getParameter(request,"city");
    int ci=ParamUtil.getIntParameter(request,"ci",-1);
    Timestamp createdate = null;
    Timestamp cdate=null;
    IArticleManager apeer = ArticlePeer.getInstance();
    int count = 0;
    int zongpage = 0;
    int recordcount = 20;
    int ipage = 0;
     List list=null;
     List listisempty=null;
    //��ѯ�Ͷ���ͬ��ߵķ���
    if (flag == 7) {
        //��ʾ�Ͷ���ͬ
        if(ci==1){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=513  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=513   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where   columnid=513  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "  ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where   columnid=513   order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
        //��ʾ���� ��
        if(ci==2){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=514  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=514   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=514  and area='"+city+"'  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
           //out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=514 order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "     ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
        //�Ͷ����� ��
        if(ci==3){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=515  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=515  ");
       // out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=515  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=515  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "     ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
        //��Ƹ���ҵ ��
        if(ci==4){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=516  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=516   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=516  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=516  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
                //�ٲ����� ��
        if(ci==5){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=517  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=517   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=517  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=517  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
                //���ϱ��� ��
        if(ci==6){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=518  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=518   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=518  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=518  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
                //ҽ�Ʊ��� ��
        if(ci==7){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=519  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=519   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=519  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=519  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
                //���˱���  ��
        if(ci==8){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=520  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=520   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=520  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=520  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
                //ʧҵ���ա�
        if(ci==9){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=521  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=521   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=521  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=521  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
                //�������ա�
        if(ci==10){
        count = apeer.getGediCount("select count(*) as zong from tbl_article where columnid=522  and area='"+city+"' ");
        count =count+ apeer.getGediCount("select count(*) as zong from tbl_article where columnid=522   ");
        //out.write(""+count);
        String dpage = request.getParameter("dpage");
        zongpage = (count + recordcount - 1) / recordcount;
        try {
            ipage = Integer.parseInt(dpage);
        } catch (Exception e) {
            ipage = 1;
        }
        if (ipage <= 0) ipage = 1;
        if (ipage >= zongpage) ipage = zongpage;
        int num = 20 * (ipage - 1);
        String sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where  columnid=522  and area='"+city+"' order by id desc)  A  WHERE  ROWNUM  <=   " + (num + 20) + "   ) WHERE  RN  >   " + num + " ";
        list = apeer.getGeCity(sql);
        if (list.isEmpty()) {
          // out.write("isempty");
        }
          int i=0;
		  i=list.size();
		  int j=20-i;
           num=j*(ipage-1);
          sql="SELECT   *   FROM  (SELECT  A. * , ROWNUM RN FROM   (select b.* from tbl_article  b where columnid=522  order by id desc)  A  WHERE  ROWNUM  <=   " + (num + j) + "    ) WHERE  RN  >   " + num + " ";
		  listisempty=apeer.getGeCity(sql);
        }
    }
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <title>�ޱ����ĵ�</title>
    <link href="images/css.css" rel="stylesheet" type="text/css">
	<link href="/images/hr-low.css" rel="stylesheet" type="text/css">
	<style type="text/css">
<!--
.red {
	font-size: 16px;
	color: #FF3300;
	text-align: right;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<%@ include file="/include/laodongtop.shtml"%>
<table width="982" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="225"><img src="images/yaowen_r2_c2.jpg" width="225" height="28" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg">&nbsp;<a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=1" class="hei">�Ͷ���ͬ</a></td>
    <td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=3" class="hei">����</a></td>
    <td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=3" class="hei">�Ͷ�����</a></td>
    <td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=4" class="hei">��Ƹ���ҵ</a></td>
    <td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=5" class="hei">�ٲ�����</a></td>
	<td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=6" class="hei">���ϱ���</a></td>
	<td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=7" class="hei">ҽ�Ʊ���</a></td>
	<td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=8" class="hei">���˱���</a></td>
	<td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=9" class="hei">ʧҵ����</a></td>
	<td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg"><a href="/yaowencity.jsp?flag=7&city=<%=city%>&ci=10" class="hei">��������</a></td>
	<td width="1" align="center" background="images/yaowen_r2_c3.jpg"><img src="images/yaowen_r2_c233.jpg" width="1" height="12" align="absmiddle" /></td>
    <td align="center" background="images/yaowen_r2_c3.jpg" class="red"><%=city%>վ</td>
    <td width="15"><img src="images/yaowen_r2_c5.jpg" width="15" height="28" /></td>
  </tr>
</table>
<%
    String lanmu="";
if(ci==1)
{
   lanmu="�Ͷ���ͬ";
}
    if(ci==2)
{
    lanmu="����";
}
    if(ci==3)
{
      lanmu="�Ͷ�����";
}
    if(ci==4)
{
        lanmu="��Ƹ���ҵ";
}
    if(ci==5)
{
      lanmu="�ٲ�����";
}
    if(ci==6)
{
      lanmu="���ϱ���";
}
    if(ci==7)
{
      lanmu="ҽ�Ʊ���";
}
    if(ci==8)
{
      lanmu="���˱���";
}
    if(ci==9)
{
     lanmu="ʧҵ����";
}
    if(ci==10)
{
      lanmu="��������";
}
%>
<table width="982" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="10"><img src="images/3_laodonghetong_r2_c2.jpg" width="10" height="30"/></td>
        <td bgcolor="#F0F0F0"><span class="black12a">��Ŀǰ��λ�ã�</span><a href="/">�й��Ͷ�������</a>��<a href="/yaowen.jsp?flag=7&city=<%=city%>">Ҫ��</a>��<%=lanmu%></td>
        <td width="10"><img src="images/3_laodonghetong_r4_c5.jpg" width="10" height="30"/></td>
    </tr>
</table>
<table width="1" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td><img src="images/bai.gif" width="1" height="8"/></td>
    </tr>
</table>
<table width="982" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td valign="top">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="33" background="images/3_faluchaxun_r3_c4.jpg" class="black12b">&nbsp;&nbsp;<img
                                src="images/3_faluchaxun_r4_c6.jpg" width="7" height="11" align="absmiddle"/>&nbsp;<%=lanmu%>����
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
							<%
							   for(int i=0;i<list.size();i++)
                               {

                                     Article article=(Article)list.get(i);
                                   createdate = article.getCreateDate();
                                   cdate=article.getCreateDate();
                                   SimpleDateFormat cd=new SimpleDateFormat("MM-dd-yyyy");
                                   String date=cd.format(cdate);
                   SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
                   String dateString = formatter.format(createdate);
                   String driname=apeer.getDriName(article.getColumnID());
                               if(i%2!=0)
                               {
                            %>
                                <tr>
                                    <td bgcolor="#F3F1F2">
                                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="15" height="25"><img src="images/3_faluchaxun_r9_c6.jpg"
                                                                                width="3" height="3" align="absmiddle"/>
                                                </td>
                                                <td><a href="<%=driname+dateString+"/"+article.getArticleid()+".shtml"%>"><%=article.getMainTitle()%></a></td>
                                                <td width="80" align="center"><%=date%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%}else{%>
                                <tr>
                                    <td>
                                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="15" height="25"><img src="images/3_faluchaxun_r9_c6.jpg"
                                                                                width="3" height="3" align="absmiddle"/>
                                                </td>
                                                <td><a href="<%=driname+dateString+"/"+article.getArticleid()+".shtml"%>"><%=article.getMainTitle()%></a></td>
                                                <td width="80" align="center"><%=date%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%}
                                }%>
                                <%
							   for(int i=0;i<listisempty.size();i++)
                               {

                                     Article article=(Article)listisempty.get(i);
                                     createdate = article.getCreateDate();
                                      cdate=article.getCreateDate();
                                   SimpleDateFormat cd=new SimpleDateFormat("MM-dd-yyyy");
                                   String date=cd.format(cdate);
                   SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
                   String dateString = formatter.format(createdate);
                   String driname=apeer.getDriName(article.getColumnID());
                   
                               if(i%2!=0)
                               {
                            %>
                                <tr>
                                    <td bgcolor="#F3F1F2">
                                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="15" height="25"><img src="images/3_faluchaxun_r9_c6.jpg"
                                                                                width="3" height="3" align="absmiddle"/>
                                                </td>
                                                <td><a href="<%=driname+dateString+"/"+article.getArticleid()+".shtml"%>"><%=article.getMainTitle()%></a></td>
                                                <td width="80" align="center"><%=date%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%}else{%>
                                <tr>
                                    <td>
                                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="15" height="25"><img src="images/3_faluchaxun_r9_c6.jpg"
                                                                                width="3" height="3" align="absmiddle"/>
                                                </td>
                                                <td><a href="<%=driname+dateString+"/"+article.getArticleid()+".shtml"%>"><%=article.getMainTitle()%></a></td>
                                                <td width="80" align="center"><%=date%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%}
                                }%>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td height="25" bgcolor="#F3F1F2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="35" align="right"><%
    if (zongpage > 1) {
%>
��ҳ��:<%=zongpage%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��ǰҳ��<%=ipage + "/" + zongpage%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="?dpage=1&flag=<%=flag%>&city=<%=city%>&ci=<%=ci%>" class="lian1">��ҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
        href="?dpage=<%=ipage-1%>&flag=<%=flag%>&city=<%=city%>&ci=<%=ci%>" class="lian1">��һҳ </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
        href="?dpage=<%=ipage+1%>&flag=<%=flag%>&city=<%=city%>&ci=<%=ci%>" class="lian1">��һҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="?dpage=<%=zongpage%>&flag=<%=flag%>&city=<%=city%>&ci=<%=ci%>" class="lian1">βҳ </a>
<%}%>  
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</td>
<td width="10" valign="top"><img src="images/bai.gif" width="10" height="1"/></td>
<td width="210" valign="top">
<%@ include file="/include/wzright.shtml"%>
</td>
</tr>
</table>
<%@ include file="/include/low.shtml"%>
</body>
</html>
