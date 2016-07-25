<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String name = (String)request.getParameter("name");
	String date = (String)request.getParameter("date");
	String used = (String)request.getParameter("used");
	
	Connection conn = null;
	String sql = "";

	sql = "insert into HoliDays(HolidayName, HolidayDate, Used)"; 
	sql += " values('"+name+"','"+date+"','"+used+"')";
	
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