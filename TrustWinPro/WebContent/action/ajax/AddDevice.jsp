<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String group = (String)request.getParameter("group");
	int value = 0;
	if(!group.equals("")){
		Connection conn = null;
		String sql = "select ID from SetupTcpip";
		int maxID = 0;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			ResultSet rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				if(maxID < Integer.parseInt(rs.getString(1))){
					maxID = Integer.parseInt(rs.getString(1));
				}
			}
				
			rs.close();
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
		
		maxID++;
		
		String SMaxId = Integer.toString(maxID);
		
	
		sql = "select * from DeviceGroup where UpNumber = " + group;
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
					
			ResultSet rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				value++;
			}
				
			rs.close();
			
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
		
		
		if(value == 0){
			sql = "insert into SetupTcpip(ID, ControllerName, Address, Port, Password, UniqueID, ServerPort, groupIdx,InOut)"; 
			sql += " values('"+SMaxId+"','new device',' ','1000','1111','"+SMaxId+"','0',"+group+",'IN')";
			
			try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement();
				pstmt.executeUpdate(sql);
				
				conn.close();
			}catch(Exception e){
				out.println("DB error!!1.");
				e.printStackTrace();
			}
			
			sql = "insert into AlarmTime(DeviceID)"; 
			sql += " values("+SMaxId+")";
			
			try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement();
				pstmt.executeUpdate(sql);
				
				conn.close();
			}catch(Exception e){
				out.println("DB error!!1.");
				e.printStackTrace();
			}
			
			sql = "insert into AutoDoor(DeviceID)"; 
			sql += " values("+SMaxId+")";
			
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
			
			sql = "insert into AutoKey(DeviceID)"; 
			sql += " values("+SMaxId+")";
			
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
			
			sql = "insert into ManageMode(DeviceID)"; 
			sql += " values("+SMaxId+")";
			
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
			
			sql = "insert into NoActKey(DeviceID)"; 
			sql += " values("+SMaxId+")";
			
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
			
			sql = "insert into Sunshine(DeviceID)"; 
			sql += " values("+SMaxId+")";
			
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
		}else{
			out.println("해당 그룹에 추가 할 수 없습니다.");
		}
	}
%>