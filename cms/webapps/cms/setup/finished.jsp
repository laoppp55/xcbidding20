<%@ page contentType="text/html;charset=gbk"%>
<!-- ----------- JSP DECLARATIONS ------------------- -->
<jsp:useBean id="Bean" class="com.bizwink.boot.CmsSetup" scope="session" />

<% /* Import packages */ %>
<%@ page import="com.bizwink.boot.*" %>

<%
	/* true if properties are initialized */
	boolean setupOk = (Bean.getProperties()!=null);

	/* get params */
	boolean understood = false;
	String temp = request.getParameter("understood");
	if(temp != null)	{
		understood = temp.equals("true");
	}
   //test
   understood =true;

	if(setupOk)	{

		if(understood)	{
			/* lock the wizard for further use */
			Bean.lockWizard();

			/* Save Properties to file "opencms.properties" */
			CmsSetupUtils Utils = new CmsSetupUtils(Bean.getBasePath());
			Utils.saveProperties(Bean.getProperties(),"cms.properties",false);

			/* invalidate the sessions */
			request.getSession().invalidate();
		}

	}

	/* next page to be accessed */
	String nextPage = "";

%>
<!-- ---------------------------- -->
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
	<td><form method=POST>
		<table class=background width=700 height=500 border=0 cellpadding=5 cellspacing=0>
			<tr>
				<td class=title height=25>WebBuilder Setup Wizard</td>
			</tr>

			<tr>
				<td height=50 align=right><img src=../images/opencms.gif alt=WebBuilder border=0></td>
			</tr>
			<% if(setupOk)	{ %>
			<tr>
				<td height=375 align=center valign=middle>
					<% if(understood)	{ %>
					<p><b>�ɹ���װWebBuilder.</b><br>
					��װ�򵼱���ס. ���������°�װWebBuilder�����޸�"cms.properties"�ļ�.</p>
					<p>����WebBuilder������ <a href="<%= request.getContextPath() %>">����</a>.</p>
					<% } else { %>
						<b>Please confirm ActiveX configuration</b>
					<% } %>
				</td>
			</tr>
			<tr>
				<td height=50 align=center>
					<table border=0>
						<tr>
							<td width=200 align=right>
							<% if (understood)	{ %>
								<input type=button disabled class=button style="width:150px;" width=150 value="&#060;&#060; ��һ��">
							<% } else { %>
								<input type=button class=button style="width:150px;" width=150 value="&#060;&#060; ��һ��" onclick="history.back();">
							<% } %>
							</td>
							<td width=200 align=left>
								<input type=button disabled class=button style="width:150px;" width=150 value="���">
							</td>
							<td width=200 align=center>
								<input type=button disabled class=button style="width:150px;" width=150 value="ȡ��" >
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
					����<a href=''>���</a> ����������
				</td>
			</tr>
			<% } %>
			</form>
			</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
</body>
</html>