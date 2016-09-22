<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String id = (String)request.getParameter("id");
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
				sql = "Delete from NoActKey where DeviceID = '" + id + "'";
				pstmt.executeUpdate(sql);
				sql = "Delete from ManageMode where DeviceID = '" + id + "'";
				pstmt.executeUpdate(sql);
				sql = "Delete from AlarmTime where DeviceID = '" + id + "'";
				pstmt.executeUpdate(sql);
				sql = "Delete from AccessDevice where device= '" + id + "'";
				pstmt.executeUpdate(sql);
					
				sql = "select * from MainChart";
				ResultSet rs = pstmt.executeQuery(sql);
				String DeAc = "";
				String DeStatus = "";
				if(rs.next()){
					DeAc = rs.getString(1);
					DeStatus = rs.getString(2);
				}
				
				DeAc = DeAc.replace(","+ id + ",",",");
				DeStatus = DeStatus.replace(","+ id + ",",",");
				
				sql = "update MainChart set DeAC = '"+DeAc+"', DeStatus ='"+DeStatus+"' where idx ='1'";
				pstmt.executeUpdate(sql);
				
				rs.close();
				conn.close();
				
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}	

		
%>