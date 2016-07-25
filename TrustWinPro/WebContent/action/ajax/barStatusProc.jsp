<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String vals = request.getParameter("val");
	
	Connection conn = null;
	String sql = "";
	sql = "update MainChart set DeAC = '" + vals + "';"; 

	out.println("AAAAAAAAAAAAAAAA");
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		out.println("QQQQQQQQQQQQQQQQQ");
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>