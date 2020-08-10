<%@page import="com.bizwink.cms.security.Auth" contentType="text/html;charset=GBK"
        %>
<%@ page import="com.bizwink.cms.sjswsbs.IWsbsManager" %>
<%@ page import="com.bizwink.cms.sjswsbs.Letter" %>
<%@ page import="com.bizwink.cms.sjswsbs.WsbsPeer" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="java.math.BigDecimal" %>

<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null) {
        response.sendRedirect(response.encodeRedirectURL("../../login.jsp?msg=ϵͳ��ʱ�������µ�½!"));
        return;
    }
    int id = ParamUtil.getIntParameter(request, "id", 0);
    Letter letter = new Letter();
    IWsbsManager wsbsMgr = WsbsPeer.getInstance();
    letter = wsbsMgr.getLetterById(id);
    //String department = wsbsMgr.getDepartment(letter.getDeptid().intValue());
    String department=letter.getDepartment();
    String category = wsbsMgr.getCategory(letter.getCategorycode().intValue());
    int statusFlag = letter.getStatusflag().intValue();
    String status="δ����";
    if(statusFlag == -1){
        status = "�����ʼ�";
    }
    if(statusFlag == 1){
        status = "���";
    }
    int publishflag = letter.getPublishflag().intValue();
    int selectflag = letter.getSelectedflag().intValue();
    int newflag = letter.getNewflag().intValue();

    int startflag = ParamUtil.getIntParameter(request,"startflag",0);
    if(startflag ==1){
        String replycontent = ParamUtil.getParameter(request,"replycontent");
        statusFlag = ParamUtil.getIntParameter(request,"statusFlag",0);
        selectflag =ParamUtil.getIntParameter(request,"selectflag",0);
        newflag =ParamUtil.getIntParameter(request,"newflag",0);
        department=ParamUtil.getParameter(request,"department");

        letter = new Letter();
        letter.setReplycontent(replycontent);
        letter.setStatusflag(BigDecimal.valueOf(statusFlag));
        letter.setSelectedflag(BigDecimal.valueOf(selectflag));
        letter.setNewflag(BigDecimal.valueOf(newflag));
        letter.setDepartment(department);
        wsbsMgr.updateLetter(id,letter);
        response.sendRedirect("index.jsp");
    }


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>�ż����ݹ���</title>
    <link rel="stylesheet" type="text/css" href="css/xinjianneirong.css">
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <script type="text/javascript">
        function createWord(id){
            window.open("createWord.jsp?id="+id);
        }
    </script>
</head>

<body style="text-align: center;">


<div class="about">
    <div class="abouTop">
        <p></p>
        <img src="images/xinjian.png" alt="">
    </div>
    <div class="box">
        <ul>
            <li class="li-1">
                <p>��</p>
                <input type="button" value="����" onclick="history.go(-1)">

            </li>
            <li class="li-2">

                <!-- ѡ���ż��������� -->
                <p><%=letter.getTitle()%></p>
                <table>
                    <tr>
                        <td align="left">�ύʱ�䣺<%=letter.getCreatedate()==null?"--":letter.getCreatedate().toString().substring(0,10)%></td>
                        <td align="left">��ӳ���ͣ�<%=category%></td>
                        <td align="left">����ʱ�䣺<%=letter.getReplytime()==null?"--":letter.getReplytime().toString().substring(0,10)%></td>
                    </tr>
                    <tr>
                        <%--<td>�����ţ�<%=department%></td>--%>
                        <td align="left">����״̬��<%=status%></td>
                        <td align="left">д���ˣ�<%=letter.getLinkman()%>&nbsp;�绰��<%=letter.getPhone()%></td>
                        <td align="left">��ѯ�룺<%=letter.getSearchmsg()%></td>
                    </tr>

                </table>
            </li>
            <li class="li-3" style="min-height:236px;">
                <p class="p1"><span>�ż�����</span></p>
                <!-- ѡ���ż��������� -->
                <p class="p2"><%=letter.getContent()%></p>
            </li>

            <li class="li-4">
                <p>�ظ�����</p>
            </li>
            <form method="post" action="view.jsp" name="form1">
                <input type="hidden" name="startflag" value="1"/>
                <input type="hidden" name="id" value="<%=id%>"/>

            <li class="li-5">
                <p>
                <textarea name="replycontent" rows="8" cols="120"><%=letter.getReplycontent()==null?"":letter.getReplycontent()%></textarea>
                </p>
            </li>
             <li class="li-4">
                 <p>�ż�״̬</p>
             </li>
             <li class="li-2">
                 <table>
                     <tr>
                         <td align="left">����״̬��
                           <select name="statusFlag">
                               <option value="-1" <%=statusFlag==-1?"selected":""%>>�����ʼ�</option>
                               <option value="0" <%=statusFlag==0?"selected":""%>>δ����</option>
                               <option value="1" <%=statusFlag==1?"selected":""%>>���</option>
                               <option value="2" <%=statusFlag==2?"selected":""%>>��ʷ�ż�</option>
                           </select>
                        </td>
                        <td align="left">����ѡ�ǣ�
                            <select name="selectflag">
                                <option value="0" <%=selectflag==0?"selected":""%>>˽�Żظ�</option>
                                <option value="1" <%=selectflag==1?"selected":""%>>�����ظ�</option>
                            </select></td>
                         <td align="left">�ظ����ţ�</td>
                         <td align="left"><input type="text" name="department" id="department" value="<%=department==null?"":department%>"></td>
                     </tr>
                <%-- <%
                     if(publishflag == 0){
                 %>
                    <tr>
                        <td>������</td>
                    </tr>
                 <%
                     }else {
                 %>

                     <tr>
                         <td>����ѡ�ǣ�
                             <select name="selectflag">
                                  <option value="0" <%=selectflag==0?"selected":""%>>����ʾ</option>
                                  <option value="1" <%=selectflag==1?"selected":""%>>��ʾ</option>
                             </select>
                         </td>
                         <td>�������ţ�
                             <select name="newflag">
                                 <option value="0" <%=newflag==0?"selected":""%>>����ʾ</option>
                                 <option value="1" <%=newflag==1?"selected":""%>>��ʾ</option>
                             </select>
                         </td>
                     </tr>
                 <%
                     }
                 %>
                    <%if(statusFlag == 1){%>
                     <tr>
                         <td align="left">����ѡ�ǣ�
                             <select name="selectflag">
                                 <option value="0" <%=selectflag==0?"selected":""%>>˽�Żظ�</option>
                                 <option value="1" <%=selectflag==1?"selected":""%>>�����ظ�</option>
                             </select>
                         </td>
                     <%}
                      if(statusFlag != -1){%>
                         <td align="left">�������ţ�
                             <select name="newflag">
                                 <option value="0" <%=newflag==0?"selected":""%>>����ʾ</option>
                                 <option value="1" <%=newflag==1?"selected":""%>>��ʾ</option>
                             </select>
                         </td>
                     </tr>
                     <%}%>--%>
                 </table>
             </li>
               <li class="li-3">
                <table align="center">
                    <tr align="center">
                        <td></td>
                        <td style="text-align:center;padding:5px;">
                            <!--button value="�ύ" class="DL" onClick="javascript:submit2();">�ύ</button-->
                            <input type="submit" name="sub" id="sub" value="�ύ" class="DL"/>
                        </td>
                        <td style="text-align:center;padding:5px;" colspan="2">
                            <a href="createWord.jsp?id=<%=id%>">��������ĵ�</a>
                            <%--<button type="button" value="ȡ��" class="ZC" onclick="history.go(-1)">ȡ��</button>--%>
                            <%--<button type="button" value="�����ĵ�" class="ZC" onclick="createWord(<%=id%>)">�����ĵ�</button>--%>
                        </td>
                        <td></td>
                </table>
               </li>
            </form>

        </ul>
    </div>
</div>

</body>
</html>