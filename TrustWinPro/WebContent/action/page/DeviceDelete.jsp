<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	String id = (String)request.getParameter("id");
	Connection conn = null;
	String sql = "Delete from SetupTcpip where id = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "Delete from AlarmTime where DeviceID = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "Delete from AutoDoor where DeviceID = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "Delete from AutoKey where DeviceID = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "Delete from ManageMode where DeviceID = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "Delete from NoActKey where DeviceID = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	
	sql = "Delete from Sunshine where DeviceID = '" + id + "'"; 
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);
			
			
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
			function replace(){
				document.getElementById("Device").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="Device" id="Device" method="post">
			<input type="hidden" value="Device" name="left" />
			<input type="hidden" value="DeviceInfo" name="content" />
		</form>
	</body>
</html>