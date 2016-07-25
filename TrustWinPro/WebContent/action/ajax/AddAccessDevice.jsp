<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	UserFunc Userfunc = new UserFunc();
	CategoryFunc catefunc = new CategoryFunc();

	String access = request.getParameter("access");
	String device_id = request.getParameter("id");
	
	Connection conn = null;
	String sql = "Delete from AccessDevice where access = '" + access + "' and device='"+ device_id+ "'"; 
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
	
	
	sql = "insert into AccessDevice(device, timezone, access)"; 
	sql += " values('"+device_id+"','"+0+"','"+access+"')";
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