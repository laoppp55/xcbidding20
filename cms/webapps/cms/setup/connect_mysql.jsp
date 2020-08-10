<%@ page contentType="text/html;charset=gbk"%>
<!-- ------------------------------------------------- JSP DECLARATIONS ------------------------------------------------ -->
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
		String database = request.getParameter("db");
		String createDb = request.getParameter("createDb");
		if(createDb == null)	{
			createDb = "";
		}

		submited = ((request.getParameter("submit") != null) && (conStr != null) && (database != null));

		if(submited)	{

			if(!conStr.endsWith("/"))conStr += "/";

			/* Set user and passwords manually. This is necessary because
			   jsp:setProperty does not set empty strings ("") :( */
			String dbCreateUser = 	request.getParameter("dbCreateUser");
			String dbWorkUser =		request.getParameter("dbWorkUser");

			String dbCreatePwd = 	request.getParameter("dbCreatePwd");
			String dbWorkPwd =		request.getParameter("dbWorkPwd");


			Bean.setDbWorkConStr(conStr + database);

			Bean.setDbCreateUser(dbCreateUser);
			Bean.setDbWorkUser(dbWorkUser);

			Bean.setDbCreatePwd(dbCreatePwd);
			Bean.setDbWorkPwd(dbWorkPwd);

			Hashtable replacer = new Hashtable();
			replacer.put("$$database$$",database);

			Bean.setReplacer(replacer);

			session.setAttribute("createDb",createDb);

		}


	}
%>
<!-- ------------------------------------------------------------------------------------------------------------------- -->
<html>
<head>
	<title>OpenCms Setup Wizard</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="Stylesheet" type="text/css" href="style.css">
	<script language="Javascript">
	function checkSubmit()	{
		if(document.forms[0].dbCreateConStr.value == "")	{
			alert("Please insert connection string");
			document.forms[0].dbCreateConStr.focus();
			return false;
		}
		else if (document.forms[0].db.value == "")	{
			alert("Please insert database name");
			document.forms[0].db.focus();
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
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td align="center" valign="middle">
<table border="1" cellpadding="0" cellspacing="0">
<tr>
	<td><form method="POST" onSubmit="return checkSubmit()">
		<table class="background" width="700" height="500" border="0" cellpadding="5" cellspacing="0">
			<tr>
				<td class="title" height="25">OpenCms Setup Wizard</td>
			</tr>

			<tr>
				<td height="50" align="right"><img src="../images/opencms.gif" alt="OpenCms" border="0"></td>
			</tr>

			<% if(setupOk)	{ %>

			<tr>
				<td height="375" align="center" valign="top">
					<table border="0">
						<tr>
							<td align="center">
								<table border="0" cellpadding="2">
									<tr>
										<td width="150" class="bold">
											Resource Broker
										</td>
										<td width="250">
											<select name="resourceBroker" style="width:250px;" size="1" width="250" onchange="location.href='database_connection.jsp?resourceBroker='+this.options[this.selectedIndex].value;">
											<!-- --------------------- JSP CODE --------------------------- -->
											<%
												/* get all available resource brokers */
												Vector resourceBrokers = Bean.getResourceBrokers();
												/* 	List all resource broker found in the dbsetup.properties */
												if (resourceBrokers !=null && resourceBrokers.size() > 0)	{
													for(int i=0;i<resourceBrokers.size();i++)	{
														String rb = resourceBrokers.elementAt(i).toString();
														String selected = "";
														if(Bean.getResourceBroker().equals(rb))	{
															selected = "selected";
														}
														out.println("<option value='"+rb+"' "+selected+">"+rb);
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
								<table border="0" cellpadding="5"  cellspacing="0" class="header">
									<tr><td>&nbsp;</td><td>User</td><td>Password</td></tr>
									<tr>
										<td>Database Server Connection</td><td><input type="text" name="dbCreateUser" size="8" style="width:120px;" value='<%= Bean.getDbCreateUser() %>'></td><td><input type="text" name="dbCreatePwd" size="8" style="width:120px;" value='<%= Bean.getDbCreatePwd() %>'></td>
									</tr>
									<tr>
										<td>OpenCms Connection</td><td><input type="text" name="dbWorkUser" size="8" style="width:120px;" value='<%= Bean.getDbWorkUser() %>'></td><td><input type="text" name="dbWorkPwd" size="8" style="width:120px;" value='<%= Bean.getDbWorkPwd() %>'></td>
									</tr>
									<tr><td colspan="3"><hr></td></tr>
									<tr>
										<td>Connection String</td><td colspan="2"><input type="text" name="dbCreateConStr" size="22" style="width:250px;" value='<%= Bean.getDbCreateConStr() %>'></td>
									</tr>
									<%

									/* Get database name.if name is not set, take the context path as default */

									String database = "";
									if(Bean.getDb() != null)	{
										database = Bean.getDb();
									}
									else	{
										database = request.getContextPath();
									}
									/* cut off leading slash ('/') */
									if(database.startsWith("/"))	{
										database = database.substring(1,database.length());
									}
									%>
									<tr>
										<td>Database</td><td colspan="2"><input type="text" name="db" size="22" style="width:250px;" value='<%= database %>'></td>
									</tr>
									<tr><td colspan="3"><hr></td></tr>
									<tr><td colspan="3" align="center"><input type="checkbox" name="createDb" value="true" checked> Create database and tables<br>
									<b><font color="FF0000">Warning:</font></b> Existing database will be dropped !
									</td></tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="50" align="center">
					<table border="0">
						<tr>
							<td width="200" align="right">
								<input type="button" class="button" style="width:150px;" width="150" value="&#060;&#060; Back" onclick="history.go(-2);">
							</td>
							<td width="200" align="left">
								<input type="submit" name="submit" class="button" style="width:150px;" width="150" value="Continue &#062;&#062;">
							</td>
							<td width="200" align="center">
								<input type="button" class="button" style="width:150px;" width="150" value="Cancel" onclick="location.href='cancel.jsp'">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<% } else	{ %>
			<tr>
				<td align="center" valign="top">
					<p><b>ERROR</b></p>
					The setup wizard has not been started correctly!<br>
					Please click <a href="">here</a> to restart the Wizard
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