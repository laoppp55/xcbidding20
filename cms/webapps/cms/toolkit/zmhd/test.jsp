<%@page import="com.bizwink.cms.security.Auth,
                com.bizwink.cms.util.ParamUtil" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bizwink.cms.sjswsbs.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>�ޱ����ĵ�</title>
    <style type="text/css">
        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            font-size:14px;
        }
        a{ text-decoration:none; color:#000;}
        a:hover{ color:#03F;}

        .txtsel{ height:25px;}
        .txtinp{ height:21px;}
        .button_cx{ width:65px; height:25px; color:#FFF; cursor:pointer; background-color:#db4b03; border:0px;}
        .button_blue{ width:65px; height:25px; color:#FFF; cursor:pointer; background-color:#619cd9; border:0px;}
        .button_grey{ width:65px; height:25px; color:#FFF; cursor:pointer; background-color:#666666; border:0px;}
    </style>

</head>

<body>
<table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="130"  height="60">������<select name="" class="txtsel">
                    <option>����</option>
                    <option>��ѯ��</option>
                    <option>�ż�����</option>
                </select></td>
                <td width="253">
                    <input name="textfield" type="text" id="textfield" size="30"   class="txtinp"/></td>
                <td width="549" ><input type="submit" name="button" id="button" value="��ѯ"  class="button_cx"/></td>

                <td width="68"><input type="submit" name="button" id="button" value="����"  class="button_grey"/></td>
            </tr>
        </table>
            <table width="100%"  align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                <tr>
                    <td width="81" height="50" align="center" bgcolor="#e0f0fe"><input type="submit" name="button2" id="button2" value="��������" class="button_blue" /></td>
                    <td colspan="6" align="right" bgcolor="#e0f0fe"><input type="submit" name="button3" id="button3" value="������" class="button_blue" />&nbsp;&nbsp;<input type="submit" name="button3" id="button3" value="�Ѿ�����" class="button_blue"  />&nbsp;&nbsp;<input type="submit" name="button3" id="button3" value="������" class="button_blue" />&nbsp;&nbsp; </td>
                </tr>
                <tr>
                    <td width="81" align="center" bgcolor="#cae4ff"><input type="checkbox" name="checkbox2" id="checkbox2" />ȫѡ</td>
                    <td width="80" height="30" align="center" bgcolor="#cae4ff"><strong>�ż�����</strong></td>
                    <td width="461" align="center" bgcolor="#cae4ff"><strong>����</strong></td>
                    <td width="146" align="center" bgcolor="#cae4ff"><strong>�ύʱ��</strong></td>
                    <td width="79" align="center" bgcolor="#cae4ff"><strong>����״̬</strong></td>
                    <td width="79" align="center" bgcolor="#cae4ff"><strong>�������</strong></td>
                    <td width="64" align="center" bgcolor="#cae4ff"><strong>ɾ��</strong></td>

                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="images/gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="images/gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>        <tr>
                <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                <td align="center" bgcolor="#e0f0fe">δ����</td>
                <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
            </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#e0f0fe"><input type="checkbox" name="checkbox" id="checkbox" /></td>
                    <td height="30" align="center" bgcolor="#e0f0fe">zm821</td>
                    <td align="center" bgcolor="#e0f0fe">����ʯ��ɽ��³��·���˼�԰�������ڳ��벻������</td>
                    <td align="center" bgcolor="#e0f0fe">2019-01-15 16:32.43</td>
                    <td align="center" bgcolor="#e0f0fe">δ����</td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_039.gif" width="25" height="25" /></a></td>
                    <td align="center" bgcolor="#e0f0fe"><a href="#"><img src="gif_45_037.gif" width="25" height="25" /></a></td>
                </tr>

                <tr>
                    <td height="50" colspan="7" align="center" bgcolor="#e0f0fe"><a href="#">��ҳ</a> &nbsp;&nbsp;| &nbsp;&nbsp; <a href="#">��һҳ</a> &nbsp;&nbsp;| &nbsp;&nbsp;<a href="#">��һҳ</a> &nbsp;&nbsp;| &nbsp;&nbsp;<a href="#">βҳ</a>  &nbsp;&nbsp; &nbsp;&nbsp;��ǰΪ��2ҳ &nbsp;&nbsp;��10ҳ &nbsp;&nbsp;��200��</td>
                </tr>
            </table></td>
    </tr>
</table>
</body>
</html>
