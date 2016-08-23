<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String id = (String)request.getParameter("id");
	//SetupTcpip ID / Sunshine idx / AutoDoor idx / AutoKey idx / NoActKey idx / ManageMode idx
	//AlarmTime idx
	Connection conn = null;
	String sql = "Delete from SetupTcpip where UniqueID = '" + id + "'"; 
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement();
				pstmt.executeUpdate(sql);
				sql = "Delete from Sunshine where DeviceID = '" + id + "'";
				pstmt.executeUpdate(sql);
				sql = "Delete from AutoDoor where DeviceID = '" + id + "'";
				pstmt.executeUpdate(sql);
				sql = "Delete from AutoKey where DeviceID = '" + id + "'";
				pstmt.executeUpdate(sql);
				conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}

		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			sql = "Delete from NoActKey where DeviceID = '" + id + "'";
			pstmt.executeUpdate(sql);
			sql = "Delete from ManageMode where DeviceID = '" + id + "'";
			pstmt.executeUpdate(sql);
			sql = "Delete from AlarmTime where DeviceID = '" + id + "'";
			pstmt.executeUpdate(sql);
			sql = "Delete from AccessDevice where device= '" + id + "'";
			pstmt.executeUpdate(sql);
			conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}		
		
%>