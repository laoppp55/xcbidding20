<%@ page import="java.util.*,
                 com.bizwink.cms.news.*,
                 com.bizwink.cms.extendAttr.*,
                 com.bizwink.cms.security.*,
                 org.jdom.*,
                 com.bizwink.cms.util.*,
                 org.jdom.input.*,
                 java.io.*"
         contentType="text/html;charset=gbk"
%>
<%@ page import="com.bizwink.util.JSON_Str_To_ObjArray" %>
<%@ page import="com.bizwink.util.zTreeNodeObj" %>
<%@ page import="com.bizwink.util.zTreeNodeObj" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="net.sf.json.JSONArray" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request,response,session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }

    String errormsg = "";
    String defaultval = "";
    boolean error = false;
    int siteid = authToken.getSiteID();
    int columnID = ParamUtil.getIntParameter(request, "ID", 0);
    int from = ParamUtil.getIntParameter(request, "from", 0);   //from=1������ҳ
    String act = ParamUtil.getParameter(request, "act");
    boolean extattrscope = ParamUtil.getCheckboxParameter(request, "attrscope");
    IColumnManager columnMgr = ColumnPeer.getInstance();
    if (from == 1) {
        Column rootColumn = columnMgr.getRootparentColumn(siteid);
        columnID = rootColumn.getID();
    }

    if (act == null){
        session.removeAttribute("ExtendAttr");
        if (columnID > 0){
            String xmlTemplate = columnMgr.getColumn(columnID).getXMLTemplate();
            if (xmlTemplate != null && xmlTemplate.trim().length() > 0){
                xmlTemplate = StringUtil.gb2iso4View(xmlTemplate);
                SAXBuilder builder = new SAXBuilder();
                Reader in = new StringReader(xmlTemplate);
                Document doc = builder.build(in);

                List attrList = new ArrayList();
                List nodeList = doc.getRootElement().getChildren();

                for (int i=0; i<nodeList.size(); i++){
                    Element e = (Element)nodeList.get(i);
                    ExtendAttr extend = new ExtendAttr();
                    extend.setCName(e.getText());
                    extend.setEName(e.getName());
                    defaultval = e.getAttributeValue("defaultval");
                    int type = Integer.parseInt(e.getAttributeValue("type"));
                    int datatype = Integer.parseInt(e.getAttributeValue("datatype"));
                    if (defaultval!=null && defaultval.indexOf("null")==-1) {
                        if (type == 5) {                   //�����б�����
                            extend.setDefaultValue(defaultval);
                        } else {                           //��������
                            defaultval = defaultval.replace(" ","\r\n");
                            extend.setDefaultValue(defaultval);
                        }
                    } else {
                        extend.setDefaultValue("");
                    }
                    extend.setControlType(type);
                    extend.setDataType(datatype);
                    attrList.add(extend);
                }
                session.setAttribute("ExtendAttr", attrList);
            }
        }
    }

    //����
    if (act != null && act.equals("doCreate")){
        int width = 0;
        int height = 0;
        List<String> typeOptions = null;             //�������ݰ��ղ�νṹ��֯�������б�ѡ���
        String typeinfos = null;                          //���ڱ���洢�������ֶ�droplist0�е�ֵ

        String cname = ParamUtil.getParameter(request, "cname");
        String ename = ParamUtil.getParameter(request, "ename");
        String defaultValue = ParamUtil.getParameter(request, "defaultval");
        int type = ParamUtil.getIntParameter(request, "type", 0);
        int datatype = ParamUtil.getIntParameter(request, "datatype", 0);
        if (type == 3){
            width = ParamUtil.getIntParameter(request, "width", 0);
            height = ParamUtil.getIntParameter(request, "height", 0);
        }
        if (type == 5) {
            defaultValue = ParamUtil.getParameter(request,"droplist");
        }

        if (cname == null || cname.trim().length() == 0 || ename == null || ename.trim().length() == 0 || type == 0 || datatype == 0){
            error = true;
            errormsg = "<p align=center><font color=red><b>������չ���Գ���</b></font></p>";
        }

        if (!error){
            ename = "_" + ename;
            List attrList = (List)session.getAttribute("ExtendAttr");
            if (attrList != null) {
                for (int i=0; i<attrList.size(); i++) {
                    ExtendAttr extend = (ExtendAttr)attrList.get(i);
                    if (ename.equalsIgnoreCase(extend.getEName())) {
                        error = true;
                        errormsg = "<p align=center><font color=red><b>��չ����Ӣ�������ظ���</b></font></p>";
                        break;
                    }
                }
            } else {
                attrList = new ArrayList();
            }

            if (!error) {
                ExtendAttr extend = new ExtendAttr();
                extend.setCName(cname);
                extend.setEName(ename);
                extend.setDefaultValue(defaultValue);
                extend.setDataType(datatype);
                extend.setControlType(type);
                extend.setPicWidth(width);
                extend.setPicHeight(height);
                attrList.add(extend);
                session.setAttribute("ExtendAttr", attrList);
            }
        }
        response.sendRedirect("editattr.jsp?act=doNothing&from="+from+"&ID="+columnID);
    }

    //ɾ��
    if (act != null && act.equals("doDelete")){
        String ename = ParamUtil.getParameter(request, "ename");
        List attrList = (List)session.getAttribute("ExtendAttr");
        if (attrList != null){
            for (int i=0; i<attrList.size(); i++){
                ExtendAttr extend = (ExtendAttr)attrList.get(i);
                if (ename.equalsIgnoreCase(extend.getEName())){
                    attrList.remove(i);
                    break;
                }
            }
            session.setAttribute("ExtendAttr", attrList);
        }
        response.sendRedirect("editattr.jsp?act=doNothing&from="+from+"&ID="+columnID);
    }

    //�޸�
    if (act != null && act.equals("doUpdate")){
        int width = 0;
        int height = 0;
        List<String> typeOptions = null;             //�������ݰ��ղ�νṹ��֯�������б�ѡ���
        String typeinfos = null;                          //���ڱ���洢�������ֶ�droplist0�е�ֵ
        String defaultValue = null;
        String ename = ParamUtil.getParameter(request, "ename");
        String cname = ParamUtil.getParameter(request, "cname");

        int type = ParamUtil.getIntParameter(request, "type", 0);
        int datatype = ParamUtil.getIntParameter(request, "datatype", 0);
        if (cname == null || cname.trim().length() == 0 || ename == null || ename.trim().length() == 0 || type == 0){
            error = true;
            errormsg = "<p align=center><font color=red><b>�޸���չ���Գ���</b></font></p>";
        }

        if (type == 3){
            width = ParamUtil.getIntParameter(request, "width", 0);
            height = ParamUtil.getIntParameter(request, "height", 0);
        }

        if (type == 5) {
            int rowno = ParamUtil.getIntParameter(request,"rowno",0);
            defaultValue = ParamUtil.getParameter(request,"droplist"+rowno);
        }

        if (!error){
            List attrList = (List)session.getAttribute("ExtendAttr");
            for (int i=0; i<attrList.size(); i++){
                ExtendAttr extend = (ExtendAttr)attrList.get(i);
                if (ename.equalsIgnoreCase(extend.getEName())){
                    extend.setCName(cname);
                    extend.setControlType(type);
                    if (type == 5) extend.setDefaultValue(defaultValue);
                    extend.setDataType(datatype);
                    attrList.set(i, extend);
                    break;
                }
            }
            session.setAttribute("ExtendAttr", attrList);
        }
        response.sendRedirect("editattr.jsp?act=doNothing&from="+from+"&ID="+columnID);
    }

    //���沢�رմ���
    if (act != null && act.equals("doSave")){
        List attrList = (List)session.getAttribute("ExtendAttr");
        String retstr = "";

        if (attrList != null){
            for (int i=0; i<attrList.size(); i++){
                ExtendAttr extend = (ExtendAttr)attrList.get(i);
                defaultval = (extend.getDefaultValue()==null?"":extend.getDefaultValue());
                if (extend.getControlType() == 3)
                    retstr = retstr + "<" + extend.getEName() + " datatype=\"" + extend.getDataType() + "\" type=\"" + extend.getControlType() + "\"" + " defaultval=\"" + defaultval + "\" width=\"" + extend.getPicWidth() + "\" height=\"" + extend.getPicHeight() + "\">" + extend.getCName() + "</" + extend.getEName() + ">";
                else if (extend.getControlType() == 5){
                    String options_val = ParamUtil.getParameter(request, "droplist" + i);
                    retstr = retstr + "<" + extend.getEName() + " datatype=\"" + extend.getDataType() + "\" type=\"" + extend.getControlType() + "\"" + " defaultval=\"" + options_val + "\">" + extend.getCName() + "</" + extend.getEName() + ">";
                }else
                    retstr = retstr + "<" + extend.getEName() + " datatype=\"" + extend.getDataType() + "\" type=\"" + extend.getControlType() + "\"" + " defaultval=\"" + defaultval + "\">" + extend.getCName() + "</" + extend.getEName() + ">";
            }
        }

        if (retstr.trim().length() > 0) retstr = "<?xml version=\"1.0\" encoding=\"GB2312\"?><Article_Properties>" + retstr + "</Article_Properties>";

        Column column = new Column();
        column.setDefineAttr(1);
        column.setSiteID(siteid);
        column.setXMLTemplate(retstr);
        column.setID(columnID);
        if (extattrscope)
            column.setExtattrscope(1);
        else
            column.setExtattrscope(0);
        columnMgr.updateColumnExtendAttr(column);

        retstr = retstr.replace("\r\n"," ");

        if (from == 1){
            out.println("<script language=javascript>window.close();</script>");
        } else {
            retstr = retstr.replaceAll("'","&apos;");
            out.println("<script language=javascript>opener.updateForm.xmlTemplate.value='"+retstr+"';opener.updateForm.extattrscope.value='" + extattrscope + "';window.close();</script>");
        }
        session.removeAttribute("ExtendAttr");
        return;
    }
%>

<html>
<head>
    <title>��չ����</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link rel="stylesheet" type="text/css" href="../style/global.css">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
    <script language=javascript>
        function check(frm) {
            var src=document.activeElement;
            var val = src.value;
            if (val=="  �ύ  " && frm.cname.value == "") {
                alert("��չ�����������Ʋ���Ϊ�գ�");
                return false;
                cname.focus();
            }
            if (val=="  �ύ  " && frm.ename.value == "") {
                alert("��չ����Ӣ�����Ʋ���Ϊ�գ�");
                return false;
                ename.focus();
            }
            if (val=="  �ύ  " && !checkEname(frm.ename.value)) {
                alert("��������ȷ��Ӣ�����ƣ�");
                return false;
                ename.focus();
            }

            if (val=="   ����   "){
                frm.act.value = "doSave";
            }

            return true;
        }

        function checkEname(ename) {
            var retstr = false;
            var regstr = /[^a-zA-Z0-9_]/gi;
            if (regstr.exec(ename) == null) {
                retstr = true;
            }
            return retstr;
        }

        function Update(i,ename) {
            var cname = document.all("cname"+i).value;
            if (cname == "") return;
            var type = document.all("type"+i).value;
            var datatype = document.all("datatype"+i).value;
            if (type != 5)
                window.location = "editattr.jsp?ename="+ename+"&cname="+cname+"&type="+type+"&datatype="+datatype+"&act=doUpdate&from=<%=from%>&ID=<%=columnID%>";
            else {
                attr.cname.value = cname;
                attr.ename.value = ename;
                attr.act.value = "update";
                attr.rowno.value = i;
                window.open("editattrfordroplist.jsp?ename=" + ename + "&cname="+cname+"&type="+type+"&datatype="+datatype+"&from=<%=from%>&column=<%=columnID%>&act=update&rowno=" + i, "", 'width=800,height=650,left=200,top=50,scrollbars=yes');
            }
        }

        function control() {
            if (document.all("type").value == "3")
                picattr.style.display = "";
            else
                picattr.style.display = "none";
            if (document.all("type").value == "5") {
                window.open("editattrfordroplist.jsp?column=<%=columnID%>&act=add&rowno=0", "", 'width=800,height=650,left=200,top=50,scrollbars=yes');
            }
        }

        function setSelectOptions(rowno) {
            var content = eval("document.attr.droplist" + rowno).value;
            var opts = new Array();
            opts = content.split("\r\n");
            var mysel = document.getElementById("selid" + rowno);
            mysel.options.length=0;
            for(i=0;i<opts.length;i++){
                posi = opts[i].indexOf("|");
                key = opts[i].substring(0,posi);
                value = opts[i].substring(posi+1);
                var varItem = new Option(key,value);
                mysel.options.add(varItem);
            }
        }
    </script>
</head>

<body>
<form name="attr" method="POST" action="editattr.jsp?from=<%=from%>&ID=<%=columnID%>" onsubmit="javascript:return check(this);">
    <table border="0" width="100%" align="center">
        <tr><td><%=errormsg%></td></tr>
        <tr height=80>
            <td width="100%">
                <input type="hidden" name="act" value="doCreate">
                <input type="hidden" name="defaultval" value="">
                <input type="hidden" name="rowno" value="">
                <input type="hidden" name="droplist" value="">
                <table border=0 cellspacing=2 cellpadding=2 width="100%">
                    <tr>
                        <td width="60%">
                            �������ƣ�<input name="cname" size="15" class=tine>
                            Ӣ�����ƣ�<input name="ename" size="15" class=tine></td>
                        <td width="40%"><div style="display:none" id=picattr>
                            <b>��</b>��<input name="width" size="4" class=tine>
                            <b>��</b>��<input name="height" size="4" class=tine></div></td></tr>
                    <tr>
                        <td>
                            �ؼ����ͣ�<select size="1" name="type" id="typeid" class=tine style="width:102px" onchange="control();">
                            <option value="0">��ѡ��</option>
                            <option value="1">�����ı���</option>
                            <option value="2">�����ı���</option>
                            <option value="3">�ļ��ϴ�</option>
                            <option value="4">HTML�༭��</option>
                            <option value="5">�����б�</option>
                            <option value="6">������ʱ��</option>
                        </select>
                            �������ͣ�<select size="1" name="datatype" class=tine style="width:102px">
                            <option value="1">�ַ���</option>
                            <option value="2">������</option>
                            <option value="3">�ı���</option>
                            <option value="4">С����</option>
                        </select></td>
                        <td><input type="submit" value="  �ύ  " name="submit" class=tine></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <table border=1 borderColorDark=#ffffec borderColorLight=#5e5e00 cellPadding=0 cellSpacing=0 width="100%">
                    <tr>
                        <td width="20%" align="center"><B>��������</B></td>
                        <td width="15%" align="center"><B>Ӣ������</B></td>
                        <td width="10%" align="center"><B>�ؼ�����</B></td>
                        <td width="10%" align="center"><B>��������</B></td>
                        <td width="15%" align="center"><B>Ĭ��ֵ</B></td>
                        <td width="10%" align="center"><B>��λ</B></td>
                        <td width="10%" align="center"><B>�ɷ�Ϊ��</B></td>
                        <td width="10%" align="center"><B>����</B></td>
                    </tr>
                    <%
                        List attrList = (List)session.getAttribute("ExtendAttr");
                        if (attrList != null){
                            for (int i=0; i<attrList.size(); i++){
                                ExtendAttr extend = (ExtendAttr)attrList.get(i);
                                int controlType = extend.getControlType();
                                int dataType = extend.getDataType();
                    %>
                    <tr height=26>
                        <td align="center"><input name=cname<%=i%> value="<%=extend.getCName()%>" class=tine></td>
                        <td align="center"><%=extend.getEName()%></td>
                        <td align="center"><select size="1" name="type<%=i%>" class=tine style="width:90px">
                            <option value="0" <%if(controlType==0){%>selected<%}%>>��ѡ��</option>
                            <option value="1" <%if(controlType==1){%>selected<%}%>>�����ı���</option>
                            <option value="2" <%if(controlType==2){%>selected<%}%>>�����ı���</option>
                            <option value="3" <%if(controlType==3){%>selected<%}%>>�ļ��ϴ�</option>
                            <option value="4" <%if(controlType==4){%>selected<%}%>>HTML�༭��</option>
                            <option value="5" <%if(controlType==5){%>selected<%}%>>�����б�</option>
                            <option value="6" <%if(controlType==6){%>selected<%}%>>������ʱ��</option>
                        </select></td>
                        <td align="center"><select size="1" name="datatype<%=i%>" class=tine style="width:75px">
                            <option value="1" <%if(dataType==1){%>selected<%}%>>�ַ���</option>
                            <option value="2" <%if(dataType==2){%>selected<%}%>>������</option>
                            <option value="3" <%if(dataType==3){%>selected<%}%>>�ı���</option>
                            <option value="4" <%if(dataType==4){%>selected<%}%>>С����</option>
                        </select></td>
                        <!--��������Ĭ��ֵ-->
                        <%if (controlType==5) {%>
                        <td>
                            <input type="hidden" name="droplist<%=i%>" value="<%=(extend.getDefaultValue()==null)?"":extend.getDefaultValue()%>">
                            <div id="dl<%=i%>" style="display: block">
                                <select size="1" id="selid<%=i%>" name="selname<%=i%>"  class="tine" style="width:75px">
                                    <%
                                        String tempbuf = extend.getDefaultValue();
                                        if (tempbuf!=null && tempbuf!="") {
                                            tempbuf = tempbuf.replaceAll("'","\"");
                                            JSONObject jsStr = JSONObject.fromObject(tempbuf);
                                            JSONArray jsonArray = jsStr.getJSONArray("data");
                                            List<zTreeNodeObj> zTreeNodeObjs = JSON_Str_To_ObjArray.Transfer_JsonStr_To_ObjArray(jsonArray);
                                            List typeOptions = JSON_Str_To_ObjArray.genOptionsStr(zTreeNodeObjs);
                                            tempbuf="";
                                            for (int ii=0;ii<typeOptions.size();ii++) {
                                                tempbuf = tempbuf + typeOptions.get(ii);
                                            }

                                            String[] ss = tempbuf.split("\r\n");
                                            for(int ii=0; ii<ss.length; ii++) {
                                                String tbuf = ss[ii];
                                                int posi = tbuf.indexOf("|");
                                                String text = tbuf.substring(0,posi);
                                                String value = tbuf.substring(posi+1);
                                                out.println("<option value=\"" + value + "\">" + text + "</option>");
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </td>
                        <%} else {%>
                        <td>&nbsp;</td>
                        <%}%>
                        <td align="center"><input type="text" name="unit" size="5"></td>
                        <td align="center"><input type="checkbox" name="allownull">��</td>
                        <td align="center">
                            <a href="editattr.jsp?ename=<%=extend.getEName()%>&act=doDelete&from=<%=from%>&ID=<%=columnID%>">ɾ��</a>&nbsp;
                            <a href="javascript:Update(<%=i%>,'<%=extend.getEName()%>');">�޸�</a>
                        </td>
                    </tr>
                    <%}}%>
                </table>
            </td>
        </tr>

        <tr height=40>
            <td align=left>
                <input type="checkbox" name="attrscope" id="attrscopeid" value="<%=(extattrscope==true)?1:0%>" <%=(extattrscope==true)?"checked":""%>>���ñ���Ŀ��������Ʒ��Ŀ
                <input type="submit" value="   ����   " name="save" class=tine>&nbsp;&nbsp;
                <input type="button" value="   �ر�   " name="close" class=tine onclick="window.close();">
            </td>
        </tr>
        <tr><td><font color="red"><b>ע�⣺���������桱��ť����Ҫֱ�ӹرգ�</b></font></td></tr>
    </table>
</form>
</body>
</html>