<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	if(request.getParameter("num") == "" || request.getParameter("dep") == ""){
	
	}else{
		int Num = Integer.parseInt(request.getParameter("num"));
		int Dep = Integer.parseInt(request.getParameter("dep"));
	
		
		Connection conn = null;
		String sql = "insert into DeviceGroup(GroupName, UpNumber, Depth)"; 
		sql += " values('new group', "+ Num +","+ Dep +")";
		
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
		
		sql = "select Top 1 idx from DeviceGroup order by idx desc";
		int idx = 0;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			
			ResultSet rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				idx = rs.getInt(1);
			}
			
			rs.close();
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
		
		
		
		
		sql = "update SetupTcpip set groupIdx = " + idx + "where groupIdx = " + Num;
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
	}
%>