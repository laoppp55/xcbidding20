<%@ page contentType="text/html;charset=gbk"%>
<!-- ----- JSP DECLARATIONS --------- -->
<% /* Initialize the Bean */ %>
<jsp:useBean id="Bean" class="com.bizwink.boot.CmsSetup" scope="session" />
<% /* Set the base path to the opencms home folder */ %>
<jsp:setProperty name="Bean" property="basePath" value='<%= config.getServletContext().getRealPath("/") %>' />
<%
	/* Initialize the properties */
	Bean.initProperties("config.properties");
	/* check wizards accessability */
	boolean wizardEnabled = Bean.getWizardEnabled();
    //boolean wizardEnabled =true;
	if(!wizardEnabled)	{
		request.getSession().invalidate();
	}
	/* next page to be accessed */
	String nextPage = "database_connection.jsp";
%>
<!-- -------- -->
<html>
<head>
	<title>WebBuilder Setup Wizard</title>
	<meta http-equiv=Content-Type content=text/html; charset=gb2312>
	<link rel=Stylesheet type=text/css href=style.css>
</head>
<body>
<table width=100% height=100% border=0 cellpadding=0 cellspacing=0>
<tr>
<td align=center valign=middle>
<table border=1 cellpadding=0 cellspacing=0>
<tr>
	<td><form action="<%= nextPage %>" method=POST>
		<table class=background width=700 height=500 border=0 cellpadding=5 cellspacing=0>
			<tr>
				<td class=title height=25>WebBuilder Setup Wizard</td>
			</tr>

			<tr>
				<td height=50 align=right><img src=../images/opencms.gif alt=OpenCms border=0></td>
			</tr>
			<% if(wizardEnabled)	{ %>
			<tr>
				<td align=center valign=top height=375>
					<table border=0 width=600 cellpadding=5>
						<tr>
							<td align=center valign=top height=125 class=bold>��ӭʹ��WebBuilder��װ����</td>
						</tr>
                        <tr>
                            <td align=center valign=top class=bold>�����һ����ʼ��װ</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td height=50 align=center>
					<table border=0>
						<tr>
							<td width=200 align=right>
								<input type=button class=button style=width:150px; width=150 disabled value="&#060;&#060; ��һ��">
							</td>
							<td width=200 align=left>
								<input type=submit name=submit class=button style=width:150px; width=150 value="��һ�� &#062;&#062;">
							</td>
							<td width=200 align=center>
								<input type=button class=button style=width:150px; width=150 value=ȡ�� onclick="location.href='cancel.jsp'">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<% } else	{ %>
			<tr>
				<td align=center valign=top>
					<p><b>�Բ���, ��װ��������ʹ��.</b></p>
					WebBuilder��װ�����Ѿ�����ס!<br>
					Ϊ������ʹ��, ����"config.properties"��.
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