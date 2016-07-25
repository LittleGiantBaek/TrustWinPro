<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	Connection conn = null;
	String devID = request.getParameter("id");
	String sql = "insert into MapDevice(MapID, X, Y)"; 
	sql += " values("+devID+",0,0)";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		conn.close();
	}catch(Exception e){
		out.println("DB error!!");
		e.printStackTrace();
	}
%>