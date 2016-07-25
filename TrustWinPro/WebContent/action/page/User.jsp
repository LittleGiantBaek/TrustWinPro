<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<div id="userdata">
<%
	LanguageFunc Lanfunc = new LanguageFunc();
	
	String lan = (String)session.getAttribute("nation");
	Connection conn = null;
	String sql = "select UserID,FirstName,MiddleName,LastName,UserClass,ID,CompanyID,Department,Position from dbo.Member order by UserId; ";
	
		try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		
		ResultSet rs = pstmt.executeQuery(sql);
%>
	<table border=1 cellspacing="0" >
		<tr>
			<th><%=Lanfunc.language(lan, 29)%></th>
			<th><%=Lanfunc.language(lan, 26)%></th>
			<th><%=Lanfunc.language(lan, 27)%></th>
			<th><%=Lanfunc.language(lan, 28)%></th>
			<th><%=Lanfunc.language(lan, 125)%></th>
			<th><%=Lanfunc.language(lan, 2)%></th>
			<th><%=Lanfunc.language(lan, 136)%></th>
			<th><%=Lanfunc.language(lan, 39)%></th>
			<th><%=Lanfunc.language(lan, 40)%></th>
		</tr>
<%			
				for(int i=0;i<30;i++){
					rs.next();
%>
		<tr>
			<td><%=rs.getString(1) %></td>
			<td><%=rs.getString(2) %></td>
			<td><%=rs.getString(3) %></td>
			<td><%=rs.getString(4) %></td>
			<td><%=rs.getString(5) %></td>
			<td><%=rs.getString(6) %></td>
			<td><%=rs.getString(7) %></td>
			<td><%=rs.getString(8) %></td>
			<td><%=rs.getString(9) %></td>
		</tr>
<%
				}
				rs.close();
				conn.close();
%>	
	</table>
</div>
<%
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%>