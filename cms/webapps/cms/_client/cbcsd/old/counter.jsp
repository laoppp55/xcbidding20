<%@ page contentType="text/html;charset=GBK"%>
<jsp:useBean id="counter" scope="page" class="com.bizwink.cms.util.counter"/>
<%
    //����counter�����ReadFile��������ȡ�ļ�lyfcount.txt�еļ���
    String url=request.getRealPath("count.txt");
    String cont=counter.ReadFile(url);
    //����counter�����ReadFile����������������һ��д�뵽�ļ�lyfcount.txt��
    counter.WriteFile(url,cont);
    out.write("���ǵ�<font color=\"red\">" + cont + "</font>λ������");
%>
