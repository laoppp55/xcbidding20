<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.orderArticleListManager.*,
                 com.bizwink.cms.security.*,
                 com.bizwink.cms.util.*,
                 com.bizwink.cms.server.CmsServer" contentType="text/html;charset=GBK" %>
<%@ page import="com.bizwink.cms.util.Map" %>
<%@ page import="com.bizwink.cms.refers.IRefersManager" %>
<%@ page import="com.bizwink.cms.refers.RefersPeer" %>
<%@ page import="com.bizwink.wenba.IWenbaManager" %>
<%@ page import="com.bizwink.wenba.wenbaManagerImpl" %>
<%@ page import="com.bizwink.wenba.wenbaImpl" %>
<%@ page import="com.bizwink.wenba.Wenti" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String username = authToken.getUserID();
    int siteid = authToken.getSiteID();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
   
     IWenbaManager columnMgr = wenbaManagerImpl.getInstance();
     wenbaImpl column=null;

    int count = 0;
    int zongpage = 0;
    int recordcount = 10;
    int ipage=0;

    count =columnMgr.count(columnID);
   
   String dpage=request.getParameter("dpage");
       zongpage = (count + recordcount - 1) / recordcount;

       try{
	     	ipage=Integer.parseInt(dpage);
	   }catch(Exception e){
			ipage=1;
       }

       if (ipage <= 0) ipage = 1;
       if (ipage >= zongpage) ipage = zongpage;
     List  list1=columnMgr.getWenttiList(ipage,columnID);
      // list = iarticle.listPage(ipage,id);
      // Iterator iterator = list.iterator();
       if(list1.isEmpty()) {
         //  System.out.println("is empty*********"+count);
       }
          
%>

<html>
<head>
<title>��������</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel=stylesheet type=text/css href="../../style/global.css">
<script language="javascript" src="../js/setday.js"></script>

</head>

<BODY BGCOLOR=#ffffff LINK=#000099 ALINK=#cc0000 VLINK=#000099 TOMARGIN=8>

<table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width='100%'>
<form action="doArticleRSS.jsp" method=Post name=form1>

<tr class=itm bgcolor="#dddddd" height=20>
    
    <td align=center width="4%">IP</td>
    <td align=center width="33%">����</td>
    <td align=center width="2%">�Ƿ���ͶƱ����</td>
    <td align=center width="6%">������ֵ</td>
    
    <td align=center width="10%">��½������</td>
    <td align=center width="5%">����������ʡ��</td>
    <td align=center width="4%">���������ڳ���</td>
    <td align=center width="4%">���������ڵ���</td>
    <td align=center width="4%">���ⴴ������</td>
    <td align=center width="4%">������</td>
    <td align=center width="6%">�޸�</td>
    <td align=center width="6%">ɾ��</td>
     <td align=center width="6%">��ֹ������ʾ</td>
</tr>
       <%
       for(int j=0;j<list1.size();j++)
          {

                   Wenti w=(Wenti)list1.get(j);
                   String istoupiao="";
                   if(w.getVoteflag()==1)
                   {
                          istoupiao="��";
                   }
                   else{
                        istoupiao="��";
                    }
                    String name=null;
                    name=w.getUsername();
                    if(name==null)
                    {
                       name="&nbsp;";
                     }
                     String ip=null;
                     ip=w.getIpaddress();
                     if(ip==null)
                     {
                     ip=" &nbsp;";
                      }
                      String  pro=null;
                      pro=w.getProvince();
                      if(pro==null)
                      {
                        pro=" &nbsp;";
                      }
                      String city=w.getCity();
                      if(city==null)
                      {
                           city="&nbsp;";
                       }
                       String area=w.getArea();
                       if(area==null)
                       {
                       area="&nbsp;";
                        }
       %>
       <tr class=itm bgcolor="#dddddd" height=20>
           <td align=center width="4%"><%=ip%></td>
    <td align=center width="36%"><%=w.getQuestion()%></td>
    <td align=center width="2%"><%=istoupiao%></td>
    <td align=center width="6%"><%=w.getXuanshang()%></td>

    <td align=center width="10%"><%=name%></td>
    <td align=center width="5%"><%=pro%></td>
    <td align=center width="4%"><%=city%></td>
    <td align=center width="4%"><%=area%></td>
    <td align=center width="4%"><%=w.getCreatedate()%></td>
   <td align=center width="6%"><%=w.getAnswernum()%></td>
    <td align=center width="6%"><a href="answer.jsp?id=<%=w.getId()%>" target="_blank">�鿴��</a></td>
      <td align=center width="6%"><%if(w.getIstop()==0){%><a href="istop.jsp?id=<%=w.getId()%>&column=<%=columnID%>&istop=1&dpage=<%=dpage%>" >�ö�</a><%}else{%>&nbsp;<a href="istop.jsp?id=<%=w.getId()%>&column=<%=columnID%>&istop=0&dpage=<%=dpage%>" >ȡ���ö�</a><%}%></td>
    <td align=center width="6%"><a href="delete.jsp?id=<%=w.getId()%>&dpage=<%=dpage%>&column=<%=columnID%>">ɾ��</a></td>
    <td align=center width="6%"><%if(w.getStatus()==2){%><a href="status.jsp?id=<%=w.getId()%>&dpage=<%=dpage%>&status=1&column=<%=columnID%>">�ѽ�ֹ��ʾ</a><%}else{%><a href="status.jsp?id=<%=w.getId()%>&dpage=<%=dpage%>&status=2&column=<%=columnID%>">��ʾ</a><%}%></td>
       </tr>
    <%}%>
</table>

    <% if(zongpage>1)
  {

%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="20" align="center" valign="bottom" class="blues"><a href="?dpage=1&column=<%=columnID%>" class="lian1">��һҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="?dpage=<%=ipage-1%>&column=<%=columnID%>" class="lian1" >��һҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="?dpage=<%=ipage+1%>&column=<%=columnID%>" class="lian1"  >��һҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="?dpage=<%=zongpage%>&column=<%=columnID%>" class="lian1"  > ���һҳ</a></td>
  </tr>
</table>
     <%}%>


</BODY>
</html>
