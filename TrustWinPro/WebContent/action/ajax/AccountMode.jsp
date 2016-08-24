<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
	String queryString = (String) request.getParameter("queryString");
	String DevAccountStatus = (String) request.getParameter("DevAccount");
	String UserAccountStatus = (String) request.getParameter("UserAccount");
	String ACAccountStatus = (String) request.getParameter("ACAccount");
	String MonitoringAccountStatus = (String) request.getParameter("MonitoringAccount");
/* 	System.out.println(DevAccountStatus);
	System.out.println(UserAccountStatus);
	System.out.println(ACAccountStatus);
	System.out.println(MonitoringAccountStatus); */

	Connection conn = null;
	String sql = "UPDATE AccountMode SET ";
	if(DevAccountStatus.equals("see")){
		sql = sql + "Device='1' ,";
	}
	else if(DevAccountStatus.equals("edit")){
		sql = sql + "Device='2' ,";
	}
	else if(DevAccountStatus.equals("hide")){
		sql = sql + "Device='3' ,";
	}
 	
	if(UserAccountStatus.equals("see")){
		sql = sql + "[User]='1' ,";
	}
	else if(UserAccountStatus.equals("edit")){
		sql = sql + "[User]='2' ,";
	}
	else if(UserAccountStatus.equals("hide")){
		sql = sql + "[User]='3' ,";
	} 
	if(ACAccountStatus.equals("see")){
		sql = sql + "AccessControl='1' ,";
	}
	else if(ACAccountStatus.equals("edit")){
		sql = sql + "AccessControl='2' ,";
	}
	else if(ACAccountStatus.equals("hide")){
		sql = sql + "AccessControl='3' ,";
	}
	if(MonitoringAccountStatus.equals("see")){
		sql = sql + "Monitoring='1' ";
	}
	else if(MonitoringAccountStatus.equals("edit")){
		sql = sql + "Monitoring='2' ";
	}
	else if(MonitoringAccountStatus.equals("hide")){
		sql = sql + "Monitoring='3' ";
	}
	sql = sql + "Where UserClass = '1';";
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();

		pstmt.executeUpdate(sql);

		conn.close();
	} catch (Exception e) {
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>