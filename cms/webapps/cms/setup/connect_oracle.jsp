<%@ page contentType="text/html;charset=gbk"%>
<!-- ------------ JSP DECLARATIONS ----------------- -->
<% /* Initialize the Bean */ %>
<jsp:useBean id="Bean" class="com.bizwink.boot.CmsSetup" scope="session" />
<%	/* true if properties are initialized */
	boolean setupOk = (Bean.getProperties()!=null);
%>
<% /* Import packages */ %>
<%@ page import="java.util.*" %>
<% /* Set all given properties */ %>
<jsp:setProperty name="Bean" property="*" />
<%
	/* next page to be accessed */
	String nextPage ="create_database.jsp";
	boolean submited = false;
	if(setupOk)	{
		String conStr = request.getParameter("dbCreateConStr");
		String createDb = request.getParameter("createDb");

		if(createDb == null)	{
			createDb = "";
		}

		submited = ((request.getParameter("submit") != null) && (conStr != null));

		if(submited)	{

			Bean.setDbWorkConStr(conStr);

			/* Set user and passwords manually. This is necessary because
			   jsp:setProperty does not set empty strings ("") :( */

			String dbCreateUser = 	request.getParameter("dbCreateUser");
			String dbCreatePwd = 	request.getParameter("dbCreatePwd");

			String dbWorkUser =		request.getParameter("dbWorkUser");
			String dbWorkPwd =		request.getParameter("dbWorkPwd");

			Bean.setDbCreateUser(dbCreateUser);
			Bean.setDbCreatePwd(dbCreatePwd);

			Bean.setDbWorkUser(dbWorkUser);
			Bean.setDbWorkPwd(dbWorkPwd);

            Bean.SetDbMain(Bean.getResourceBroker(),Bean.getDbDriver(),conStr,dbWorkUser,dbWorkPwd);

			Hashtable replacer = new Hashtable();
			replacer.put("$$user$$",dbWorkUser);
			replacer.put("$$password$$",dbWorkPwd);

			Bean.setReplacer(replacer);

			session.setAttribute("createDb",createDb);

		}
	}
%>
<!-- ----------------------------------------- -->
<html>
<head>
	<title>WebBuilder Setup Wizard</title>
	<meta http-equiv=Content-Type content=text/html; charset=gb2312>
	<link rel=Stylesheet type=text/css href=style.css>
	<script language=Javascript>
	function checkSubmit()	{
		if(document.forms[0].dbCreateConStr.value == "")	{
			alert("���Ӵ�����Ϊ�գ������룡");
			document.forms[0].dbCreateConStr.focus();
			return false;
		}
		else if (document.forms[0].dbWorkUser.value == "")	{
			alert("�û�������Ϊ�գ������룡");
			document.forms[0].dbWorkUser.focus();
			return false;
		}
		else if (document.forms[0].dbWorkPwd.value == "")	{
			alert("���벻��Ϊ�գ������룡");
			document.forms[0].dbWorkPwd.focus();
			return false;
		}
		else	{
			return true;
		}
	}
	<%
		if(submited)	{
			out.println("location.href='"+nextPage+"';");
		}
	%>
	</script>
</head>

<body>
<table width=100% height=100% border=0 cellpadding=0 cellspacing=0>
<tr>
<td align=center valign=middle>
<table border=1 cellpadding=0 cellspacing=0>
<tr>
	<td><form method=POST onSubmit="return checkSubmit()">
		<table class=background width=700 height=500 border=0 cellpadding=5 cellspacing=0>
			<tr>
				<td class=title height=25>WebBuilder Setup Wizard</td>
			</tr>

			<tr>
				<td height=50 align=right><img src=../images/opencms.gif alt=WebBuilder border=0></td>
			</tr>

			<% if(setupOk)	{ %>

			<tr>
				<td height=375 align=center valign=top>
					<table border=0>
						<tr>
							<td align=center>
								<table border=0 cellpadding=2>
									<tr>
										<td width=150 class=bold>
											��ѡ�����ݿ����ͣ�
										</td>
										<td width=250>
											<select name=resourceBroker style='width:250px;' size=1 width=250 onchange="location.href='database_connection.jsp?resourceBroker='+this.options[this.selectedIndex].value;">
											<!-- --------------------- JSP CODE --------------------------- -->
											<%
												/* get all available resource brokers */
												Vector resourceBrokers = Bean.getResourceBrokers();
												Vector resourceBrokerNames = Bean.getResourceBrokerNames();
                                                /* 	List all resource broker found in the dbsetup.properties */
												if (resourceBrokers !=null && resourceBrokers.size() > 0)	{
													for(int i=0;i<resourceBrokers.size();i++)	{
														String rb = resourceBrokers.elementAt(i).toString();
														String rn = resourceBrokerNames.elementAt(i).toString();
                                                        String selected = "";
														if(Bean.getResourceBroker().equals(rb))	{
															selected = "selected";
														}
														out.println("<option value='"+rb+"' "+selected+">"+rn);
													}
												}
												else	{
													out.println("<option value='null'>no resource broker found");
												}
											%>
											<!-- --------------------------------------------------------- -->
											</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>

						<tr><td>&nbsp;</td></tr>

						<tr>
							<td>
								<table border=0 cellpadding=5 cellspacing=0 class=header>
									<tr><td>&nbsp;</td><td>�û�</td><td>����</td></tr>
									<tr>
										<td>�������ݿⳬ���û���</td><td><input type=text name=dbCreateUser size=8 style="width:120px;" value='<%= Bean.getDbCreateUser() %>'></td>
										<td><input type=text name=dbCreatePwd size=8 style="width:120px;" value='<%= Bean.getDbCreatePwd() %>'></td>
									</tr>
									<%
									String user = Bean.getDbWorkUser();
									if(user.equals(""))	{
										user = request.getContextPath();
									}
									if(user.startsWith("/"))	{
										user = user.substring(1,user.length());
									}
									%>
									<tr>
										<td>WebBuilder�������ݿ��û���</td><td><input type=text name=dbWorkUser size=8 style="width:120px;" value='<%= user %>'></td><td><input type=text name=dbWorkPwd size=8 style="width:120px;" value='<%= Bean.getDbWorkPwd() %>'></td>
									</tr>
									<tr><td colspan=3><hr></td></tr>
									<tr>
										<td>���ӵ��ַ�����</td><td colspan=2><input type=text name=dbCreateConStr size=22 style="width:250px;" value='<%= Bean.getDbCreateConStr() %>'></td>
									</tr>
									<tr><td colspan=3><hr></td></tr>
									<tr><td colspan=3 align=center><input type=checkbox name=createDb value="true" checked> ͬʱ�������ݿ�����ݱ�<br>
									<b><font color=FF0000>����:</font></b> �Ѵ��ڵ����ݿ�ᱻɾ����<br></td></tr>

								</table>
							</td>
						</tr>
						<tr><td align=center><b>ע��:</b> �����������/oclib �� /libĿ¼�д���oracle��������!</td></tr>

					</table>
				</td>
			</tr>
			<tr>
				<td height=50 align=center>
					<table border=0>
						<tr>
							<td width=200 align=right>
								<input type=button class=button style="width:150px;" width=150 value="&#060;&#060; ��һ��" onclick="history.go(-2);">
							</td>
							<td width=200 align=left>
								<input type=submit name=submit class=button style="width:150px;" width=150 value="��һ�� &#062;&#062;">
							</td>
							<td width=200 align=center>
								<input type=button class=button style="width:150px;" width=150 value="ȡ��" onclick="location.href='cancel.jsp'">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<% } else	{ %>
			<tr>
				<td align=center valign=top>
                    <p><b>����</b></p>
                    û����ȷ������װ����!<br>
					����<a href="">���</a> ����������
				</td>
			</tr>
			<% } %>
			</form>
			</table>
		</td>
	</tr>
</table>
</td></tr>
</table>
</body>
</html>