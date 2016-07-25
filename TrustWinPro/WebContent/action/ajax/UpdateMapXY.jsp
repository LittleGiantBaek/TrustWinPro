<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	Connection conn = null;
	int idx = Integer.parseInt(request.getParameter("idx"));
	String X = request.getParameter("X");
	String Y = request.getParameter("Y");
	if(Integer.parseInt(X) < 0){
		X = "0";
	}
	if(Integer.parseInt(Y) < 0){
		Y = "0";
	}
	
	String sql = "update MapDevice set X = "+X+", Y = "+Y;
	sql = sql +" where idx = '"+idx+"';";	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>