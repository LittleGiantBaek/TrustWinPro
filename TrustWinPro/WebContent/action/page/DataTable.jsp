<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	LanguageFunc Lanfunc = new LanguageFunc();
	String lan = (String)session.getAttribute("nation");
	Connection conn = null;
	String sql = "select * from dbo.History; ";
	
		try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		
		ResultSet rs = pstmt.executeQuery(sql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=Lanfunc.language(lan, 112) %></title>
</head>
<body>
	<h3><%=Lanfunc.language(lan, 104) %>!</h3>
	<div class="datatable">
		<table width="550" border="1" align="center">
			<tr>
				<td><%=Lanfunc.language(lan, 105) %></td>
				<td><%=Lanfunc.language(lan, 71) %></td>
				<td><%=Lanfunc.language(lan, 106) %></td>
			</tr>
<%			
					while(rs.next()){
%>
			<tr>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getDate(2) %></td>
				<td><%=rs.getTime(3) %></td>
			</tr>		
<%
					}
					rs.close();
%>
		</table>
	</div>
</body>
</html>
<%
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%>
