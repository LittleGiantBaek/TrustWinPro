<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String queryString = (String)request.getParameter("queryString");
	String DevAccountStatus = (String)request.getParameter("DevAccount");
	String UserAccountStatus = (String)request.getParameter("UserAccount");
	String ACAccountStatus = (String)request.getParameter("ACAccount");
	String MonitoringAccountStatus = (String)request.getParameter("MonitoringAccount");
	
	System.out.println(DevAccountStatus);
	System.out.println(UserAccountStatus);
	System.out.println(ACAccountStatus);
	System.out.println(MonitoringAccountStatus);

/* Connection conn = null;
String sql = "UPDATE AccountMode SET";

sql = sql + ";";
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
	} */	
%>