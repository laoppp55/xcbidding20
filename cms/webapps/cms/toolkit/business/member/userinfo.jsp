<script language="javascript">
    function show(name){
        if(document.all('layer'+name).style.visibility=='hidden'){
            document.all('layer'+name).style.visibility='visible'
        }else{
            document.all('layer'+name).style.visibility='hidden'
        }
    }
    function editpass(userid){
        window.open("editpass.jsp?userid="+userid,"�޸�����","width=500,height=400,toolbar=no,top=200,left=200,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no");
    }
</script>
<table width="100%" border="0" cellpadding="2" cellspacing="1" height="571">
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="left">

    </td>
    <td class="txt" >
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--font color="red">˫�������޸�&nbsp;</font-->
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
    <td >
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt" align="center">�û���ʵ������</td>
    <td class="txt" >
        <!--a href="###"  onDblClick="show('username')"-->
            <%=username==null?"":StringUtil.gb2iso4View(username)%>
        <!--/a-->

    <td >
        <div id="layerusername" style="visibility:hidden;">
            <input type="text" name="username" size="14" value="<%=username==null?"":StringUtil.gb2iso4View(username)%>">
            <font color="#FF0000"> * </font>
        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt" align="center">�û����룺</td>
    <td class="txt" >
        <a href="###"  onDblClick="editpass('<%=userid%>')">
            ˫���޸�
            <!--/a-->
            <td >
            </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="center">�û�ע��ʱ�䣺</td>
    <td >
        <%=showdate%>
    </td>
    <td  class="txt">
        <font color="#FF0000"> �����޷��޸� </font>
    </td>

</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt" align="center">email��</td>
    <td class="txt" >
        <!--a href="###"  onDblClick="show('email')"-->
            <%=email==null?"":StringUtil.gb2iso4View(email)%>
        <!--/a-->
    <td >
        <div id="layeremail" style="visibility:hidden;">
            <input type="text" name="email" size="20" value="<%=email==null?"":StringUtil.gb2iso4View(email)%>">

        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt" align="center">�Ա�</td>
    <td >
        <!--a href="###"  onDblClick="show('sex')"-->
        <%if(sex==0){%>
        ��
        <%}else{%>
        Ů
        <%}%>
        <!--/a-->
    </td>
    <td class="txt" >
        <div id="layersex" style="visibility:hidden;">
            <%if(sex==0){%>
            <select name="sex">
                <option value="-1">��ѡ��</option>
                <option value="0" selected>��</option>
                <option value="1">Ů</option>
            </select>
            <%}else{%>
            <select name="sex">
                <option value="-1">��ѡ��</option>
                <option value="0">��</option>
                <option value="1" selected>Ů</option>
            </select>
            <%}%>

        </div>
    </td>
</tr>

<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="center">ְҵ��</td>
    <td >
        <!--a href="###"  onDblClick="show('occupation')"-->
        <%=occupation==null?"������":StringUtil.gb2iso4View(occupation)%>
        <!--/a-->
    </td>
    <td class="txt" >
        <div id="layeroccupation" style="visibility:hidden;">
            <select name="occupation">
                <%occupation = occupation==null?"":StringUtil.gb2iso4View(occupation);%>
                <option value="">��ѡ��</option>
                <option value="ѧ��" <%if((occupation != null)&&(occupation.equals("ѧ��"))){%>selected<%}%>>ѧ��</option>
                <option value="ִ�й�/����" <%if((occupation != null)&&(occupation.equals("ִ�й�/����"))){%>selected<%}%>>ִ�й�/����</option>
                <option value="ר��" <%if((occupation != null)&&(occupation.equals("ר��"))){%>selected<%}%>>ר��</option>
                <option value="����/��ʦ" <%if((occupation != null)&&(occupation.equals("����/��ʦ"))){%>selected<%}%>>����/��ʦ</option>
                <option value="������Ա/����ʦ" <%if((occupation != null)&&(occupation.equals("������Ա/����ʦ"))){%>selected<%}%>>������Ա/����ʦ</option>
                <option value="������Ա" <%if((occupation != null)&&(occupation.equals("������Ա"))){%>selected<%}%>>������Ա</option>
                <option value="�����ɲ�" <%if((occupation != null)&&(occupation.equals("�����ɲ�"))){%>selected<%}%>>�����ɲ�</option>
                <option value="����/�г�" <%if((occupation != null)&&(occupation.equals("����/�г�"))){%>selected<%}%>>����/�г�</option>
                <option value="������" <%if((occupation != null)&&(occupation.equals("������"))){%>selected<%}%>>������</option>
                <option value="����ְҵ��" <%if((occupation != null)&&(occupation.equals("����ְҵ��"))){%>selected<%}%>>����ְҵ��</option>
                <option value="��Ա/����" <%if((occupation != null)&&(occupation.equals("��Ա/����"))){%>selected<%}%>>��Ա/����</option>
                <option value="ʧҵ" <%if((occupation != null)&&(occupation.equals("ʧҵ"))){%>selected<%}%>>ʧҵ</option>
                <option value="��/����" <%if((occupation != null)&&(occupation.equals("��/����"))){%>selected<%}%>>��/����</option>
                <option value="����" <%if((occupation != null)&&(occupation.equals("����"))){%>checked<%}%>>����</option>
                <option value="��ְͨԱ" <%if((occupation != null)&&(occupation.equals("��ְͨԱ"))){%>selected<%}%>>��ְͨԱ</option>
                <option value="����" <%if((occupation != null)&&(occupation.equals("����"))){%>selected<%}%>>����</option>
            </select>
        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt" height="34" align="center">��ϵ�绰��</td>
    <td >
        <!--a href="###"  onDblClick="show('phone')"-->
        <%=(phone==null)?"������":phone%>
        <!--/a-->
    </td>
    <td class="txt" height="34">
        <div id="layerphone" style="visibility:hidden;">
            <input type="text" name="phone" size="20" value="<%=phone==null?"":StringUtil.gb2iso4View(phone)%>">
        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="center">�ֻ���</td>
    <td >
        <!--a href="###"  onDblClick="show('mobilephone')"-->
        <%=(mobilephone==null)?"������":mobilephone%>
        <!--/a-->
    </td>
    <td class="txt" >
        <div id="layermobilephone" style="visibility:hidden;">
            <input type="text" name="mobilephone" size="18" value="<%=mobilephone==null?"":mobilephone%>">
        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt" height="34" align="center">�ʼĵ�ַ��</td>
    <td >
        <!--a href="###"  onDblClick="show('address')"-->
        <%=address==null?"":StringUtil.gb2iso4View(address)%>
        <!--/a-->
    </td>
    <td class="txt" height="34">
        <div id="layeraddress" style="visibility:hidden;">
            <input type="text" name="address" size="20" value="<%=address==null?"":StringUtil.gb2iso4View(address)%>">

        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="center">�������룺</td>
    <td >
        <!--a href="###"  onDblClick="show('postcode')"-->
        <%=postcode==null?"":postcode%>
        <!--/a-->
    </td>
    <td  class="txt">
        <div id="layerpostcode" style="visibility:hidden;">
            <input type="text" name="postcode" size="13" value="<%=postcode==null?"":postcode%>">
        </div>
    </td>
</tr>
<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="center">�������ڣ�</td>
    <td >
        <!--a href="###"  onDblClick="show('birthday')"-->
        <%=birthday_year%>��<%=birthday_month%>��<%=birthday_day%>��
        <!--/a-->
    </td>
    <td class="txt" >
        <div id="layerbirthday" style="visibility:hidden;">
            <input type="text" name="birthday_year" maxlength="4" size="4" value=<%=birthday_year%>>
            ��
            <input name="birthday_month" type="text" maxlength="2" size="3" value=<%=birthday_month%>>
            ��
            <input type="text" name="birthday_day" maxlength="2" size="3" value=<%=birthday_day%>>
            ��
        </div>
    </td>
</tr>

<tr bgcolor="#FFFFFF" align="left">
    <td class="txt"  align="center">�û�״̬��</td>
    <td >
        <!--a href="###"  onDblClick="show('lockflag')"-->
        <%if(lockflag == 0){%>����<%}%>
        <%if(lockflag == 1){%>��ͣ����<%}%>
        <%if(lockflag == 2){%>��ͣ��½<%}%>
        <!--/a-->
    </td>
    <td>
        <div id="layerlockflag" style="visibility:hidden;">
            <select name="lockflag">
                <option value="0" <%if(lockflag == 0){%>selected<%}%>>����</option>
                <option value="1" <%if(lockflag == 1){%>selected<%}%>>��ͣ����</option>
                <option value="2" <%if(lockflag == 2){%>selected<%}%>>��ͣ��½</option>
            </select>
        </div>
    </td>
</tr>
</table>

