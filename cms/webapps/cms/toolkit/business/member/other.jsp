<%@ page import="com.bizwink.cms.util.StringUtil" %>
<table width="100%" border="0" cellspacing="1" cellpadding="5">
<tr bgcolor="#FFFFFF">
<%
    forread = forread==null?"":new String(forread.getBytes("iso8859_1"),"GBK");
    String[] read = forread.split("&");
    boolean readflag = false;
    String other = "";
    if(StringUtil.iso2gb(read[read.length-1]).indexOf("[") != -1)
    {
        other = StringUtil.iso2gb(read[read.length-1]);
        other = other.substring(1, other.length()-1);
    }
    else
        other = "";
%>
<td bgcolor="#FFFFFF" width="80%" class="txt">�Ķ���Ȥ��<br>
<%
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("��ѧ"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="��ѧ" checked>
<%
} else {
%>
<input type="checkbox" name="read" value="��ѧ">
<%
    }
%>
��ѧ
<%
    readflag = false;
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("��ʷ"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="��ʷ" checked>
<%
} else { %>
<input type="checkbox" name="read" value="��ʷ">
<%
    }
%>
��ʷ
<%
    readflag = false;
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("��ѧ"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="��ѧ" checked>
<%
} else {
%>
<input type="checkbox" name="read" value="��ѧ">
<%
    }
%>

��ѧ
<%
    readflag = false;
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="����" checked>
<%
} else {
%>
<input type="checkbox" name="read" value="����">
<%
    }
%>
����
<%
    readflag = false;
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="����" checked>
<%  } else { %>
<input type="checkbox" name="read" value="����">
<%
    }
%>
����
<%
    readflag = false;
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("�Ļ�"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="�Ļ�" checked>
<%  } else { %>
<input type="checkbox" name="read" value="�Ļ�">
<%
    }
%>
<br>     �Ļ�
<%
    readflag = false;
    for(int i=0;i<read.length;i++)
    {
        if(StringUtil.iso2gb(read[i]).equals("������"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="read" value="������" checked>
<%  } else { %>
<input type="checkbox" name="read" value="������">
<%
    }
%>
������<br>
������<br>
<input type="text" name="readother" size="30" value="<%=other%>">
<br>
<br>
�ղ���Ȥ�� <br>
<%
    forsave= forsave==null?"":new String(forsave.getBytes("iso8859_1"),"GBK");

    String[] save = forsave.split("&");

    if(StringUtil.iso2gb(save[save.length-1]).indexOf("[") != -1)
    {
        other = StringUtil.iso2gb(save[save.length-1]);
        other = other.substring(1, other.length()-1);
    }
    else
        other = "";
%>
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("�ż�"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>
<input type="checkbox" name="save" value="�ż�" checked>
<%  } else { %>
<input type="checkbox" name="save" value="�ż�">
<%
    }
%>
�ż�
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("ǩ����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="ǩ����" checked>
<%  } else { %>
<input type="checkbox" name="save" value="ǩ����">
<%
    }
%>
ǩ����
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("����ѧ"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="����ѧ" checked>
<%  } else { %>
<input type="checkbox" name="save" value="����ѧ">
<%
    }
%>
����ѧ
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("��������"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="��������" checked>
<%  } else { %>
<input type="checkbox" name="save" value="��������">
<%
    }
%>
��������
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="����" checked>
<%  } else { %>
<input type="checkbox" name="save" value="����">
<%
    }
%>
����
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("�ָ廭��"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="�ָ廭��" checked>
<%  } else { %>
<input type="checkbox" name="save" value="�ָ廭��">
<%
    }
%>
<br>     �ָ廭��
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="����" checked>
<%  } else { %>
<input type="checkbox" name="save" value="����">
<%
    }
%>
����
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("������"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="������" checked>
<%  } else { %>
<input type="checkbox" name="save" value="������">
<%
    }
%>
������
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("������"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="������" checked>
<%  } else { %>
<input type="checkbox" name="save" value="������">
<%
    }
%>
������
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("��ͼ"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="��ͼ" checked>
<%  } else { %>
<input type="checkbox" name="save" value="��ͼ">
<%
    }
%>
<br>    ��ͼ
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("ӡ��"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="ӡ��" checked>
<%  } else { %>
<input type="checkbox" name="save" value="ӡ��">
<%
    }
%>
ӡ��
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="����" checked>
<%  } else { %>
<input type="checkbox" name="save" value="����">
<%
    }
%>
����
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("�����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="�����" checked>
<%  } else { %>
<input type="checkbox" name="save" value="�����">
<%
    }
%>
�����
<%
    readflag = false;
    for(int i=0;i<save.length;i++)
    {
        if(StringUtil.iso2gb(save[i]).equals("����"))
        {
            readflag = true;
            break;
        }
    }
    if(readflag){
%>

<input type="checkbox" name="save" value="����" checked>
<%  } else { %>
<input type="checkbox" name="save" value="����">
<%
    }
%>
���� <br>
������<br>
<input type="text" name="saveother" size="30" value="<%=other%>">
</td>
</tr>
</table>